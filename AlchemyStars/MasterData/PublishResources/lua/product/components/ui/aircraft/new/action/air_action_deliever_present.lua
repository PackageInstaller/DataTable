local DelieverStatus = {
  None = 0,
  Starting = 1,
  Talking = 2,
  Bursting = 3,
  ShowAsset = 4,
  End = 5
}
_enum("DelieverStatus", DelieverStatus)
_class("AirActionDelieverPresent", AirActionBase)
AirActionDelieverPresent = AirActionDelieverPresent

function AirActionDelieverPresent:Constructor(pet, assetList, main)
  self._pet = pet
  self.delieverStatus_ = DelieverStatus.None
  self.assetList_ = assetList
  self.main_ = main
end

function AirActionDelieverPresent:Start()
  self.delieverStatus_ = DelieverStatus.Starting
  self._running = true
  self._pet:SetState(AirPetState.SendingGift)
  self._timer = 0
  self._waitTime = 2000
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AircraftSendGift")
end

function AirActionDelieverPresent:IsOver()
  return not self._running
end

function AirActionDelieverPresent:Update(deltaTimeMS)
  if self.delieverStatus_ == DelieverStatus.Starting then
    local pet_cfg = Cfg.cfg_aircraft_pet[self._pet:TemplateID()]
    local group = pet_cfg.ClickActionLib
    local giftTag
    if self._pet:IsGiftPet() then
      giftTag = AircraftPetGiftTag.Gift
    elseif self._pet:IsVisitPet() then
      giftTag = AircraftPetGiftTag.Visit
    else
      Log.exception("送礼星灵状态错误:", self._pet:TemplateID())
    end
    local cfgs = Cfg.cfg_aircraft_click_action_lib({Group = group, GiftTag = giftTag})
    if cfgs == nil or #cfgs == 0 then
      Log.exception("找不到送礼文本气泡，group:", group, "，Tag:", giftTag)
    end
    local sentence = cfgs[1].Sentence
    if not sentence then
      Log.exception("送礼文本气泡配置错误，group:", group, "，Tag:", giftTag)
    end
    local skinList = cfgs[1].SkinID
    local currSkinID = self._pet:ClothSkinID()
    local _playIdx = 0
    if skinList then
      for i = 1, #skinList do
        local skinid = skinList[i]
        if skinid == currSkinID then
          _playIdx = i
          break
        end
      end
    end
    local playIdx = _playIdx + 1
    local sentenceTex = sentence[playIdx]
    local DelieverPresentSentenceAction = AirActionSentence:New(self._pet, sentenceTex, self.main_, nil)
    self._pet:StartSentenceAction(DelieverPresentSentenceAction)
    self.delieverStatus_ = DelieverStatus.Talking
    return
  end
  if self.delieverStatus_ == DelieverStatus.Talking then
    self._timer = self._timer + deltaTimeMS
    if self._timer > self._waitTime then
      self.delieverStatus_ = DelieverStatus.Bursting
      self:DoBurstAnimation()
      return
    end
  end
  if self.delieverStatus_ == DelieverStatus.Bursting and not self:DoingBurstAnimation() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AircraftSendGift")
    self.delieverStatus_ = DelieverStatus.ShowAsset
    if self.assetList_ and 0 < table.count(self.assetList_) then
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", self.assetList_, function()
        self.delieverStatus_ = DelieverStatus.End
        self:Stop()
      end)
    end
  end
end

function AirActionDelieverPresent:Stop()
  self._running = false
  self._pet:StopSpecialAction(AircraftSpecialActionType.PresentBag)
  if self._pet:IsGiftPet() then
    self._pet:SetGiftFlag(nil)
  elseif self._pet:HasVisitGift() then
    self._pet:SetVisitGift(nil)
  end
  if self._pet:IsWorkingPet() then
    AirLog("送礼星灵走回工作房间：", self._pet:TemplateID(), "，空间id：", self._pet:GetSpace())
    local action = AirActionMoveToWork:New(self.main_, self._pet)
    self._pet:StartMainAction(action)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshNavMenuData)
end

function AirActionDelieverPresent:Dispose()
  self._pet = nil
  self.delieverStatus_ = DelieverStatus.End
  self.assetList_ = nil
end

function AirActionDelieverPresent:DoBurstAnimation()
  local obj = self._pet:GetPresentObject()
  local lizi = obj.transform:Find("lizi").gameObject
  lizi:SetActive(true)
  self.animation_ = obj:GetComponent("Animation")
  self.animation_:Play("eff_meme_baokai")
end

function AirActionDelieverPresent:DoingBurstAnimation()
  return self.animation_:IsPlaying("eff_meme_baokai")
end
