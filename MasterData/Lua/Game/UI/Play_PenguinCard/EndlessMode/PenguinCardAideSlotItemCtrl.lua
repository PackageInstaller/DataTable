local PenguinCardAideSlotItemCtrl = class("PenguinCardAideSlotItemCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local _, NotMaxLevel = ColorUtility.TryParseHtmlString("#FFF7EA")
local _, MaxLevel = ColorUtility.TryParseHtmlString("#ffe075")
PenguinCardAideSlotItemCtrl._mapNodeConfig = {
  AnimRoot = {sComponentName = "Animator"},
  aniOn = {sNodeName = "goOn", sComponentName = "Animator"},
  goOff = {},
  imgReady = {},
  imgSlotLock = {},
  goOn = {},
  imgIcon = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  btnOpenInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenInfo"
  }
}
PenguinCardAideSlotItemCtrl._mapEventConfig = {
  PenguinCardAideTriggered = "OnEvent_Triggered",
  PenguinCardWaitPlay = "OnEvent_WaitPlay",
  PenguinCardAideGrowth = "OnEvent_Growth",
  PenguinCard_AuraTriggered = "OnEvent_AuraTriggered"
}

function PenguinCardAideSlotItemCtrl:Refresh(nSlot)
  self.nSlot = nSlot
  local mapAide = self._panel.mapLevel.tbAide[nSlot]
  self.bWaitPlay = false
  self._mapNode.goOn:SetActive(mapAide ~= 0)
  self._mapNode.goOff:SetActive(mapAide == 0)
  NovaAPI.SetButtonInteractable(self._mapNode.btnOpenInfo, mapAide ~= 0)
  if mapAide == 0 then
    self:RefreshSlot(nSlot)
  else
    self:RefreshAide(mapAide)
  end
end

function PenguinCardAideSlotItemCtrl:RefreshAide(mapAide)
  self:SetPngSprite(self._mapNode.imgIcon, mapAide.sIcon .. AllEnum.CharHeadIconSurfix.Q)
  if mapAide.nLevel == mapAide.nMaxLevel then
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, MaxLevel)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_AideLevel"), mapAide.nLevel))
  else
    NovaAPI.SetTMPColor(self._mapNode.txtLevel, NotMaxLevel)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("PenguinCard_AideLevel"), mapAide.nLevel))
  end
end

function PenguinCardAideSlotItemCtrl:RefreshSlot(nSlot)
  self._mapNode.imgSlotLock:SetActive(nSlot > self._panel.mapLevel.nAideLimit)
  self._mapNode.imgReady:SetActive(nSlot <= self._panel.mapLevel.nAideLimit)
end

function PenguinCardAideSlotItemCtrl:PlaySelectAni()
  self._mapNode.aniOn:Play("PenguinCardAideSlot_goOn_in", 0, 0)
  WwiseManger:PostEvent("Mode_Card_appear")
end

function PenguinCardAideSlotItemCtrl:PlayUpgradeAni(callback)
  self._mapNode.aniOn:Play("PenguinCardAideSlot_goOn_UP", 0, 0)
  WwiseManger:PostEvent("Mode_Card_levelup")
  self:AddTimer(1, 0.2, function()
    if callback then
      callback()
    end
  end, true, true, true)
end

function PenguinCardAideSlotItemCtrl:PlayGiftAni()
  self._mapNode.aniOn:Play("PenguinCardAideSlot_goOn_show", 0, 0)
  WwiseManger:PostEvent("Mode_Card_love")
end

function PenguinCardAideSlotItemCtrl:PlaySaleAni(callback)
  self._mapNode.AnimRoot:Play("PenguinCardAideSlot_out", 0, 0)
  WwiseManger:PostEvent("Mode_Card_giveup")
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
    "PenguinCardAideSlot_out"
  })
  self:AddTimer(1, nAnimTime, function()
    if callback then
      callback()
    end
    self._mapNode.AnimRoot:Play("PenguinCardAideSlot_in", 0, 0)
  end, true, true, true)
end

function PenguinCardAideSlotItemCtrl:PlaySlotHideAni()
  self._mapNode.AnimRoot:Play("PenguinCardAideSlot_out", 0, 0)
end

function PenguinCardAideSlotItemCtrl:PlayUnlockAni()
  WwiseManger:PostEvent("Mode_Card_unlock")
  self._mapNode.imgSlotLock:SetActive(false)
  self._mapNode.imgReady:SetActive(true)
end

function PenguinCardAideSlotItemCtrl:PlayTriggerAni()
  if self.bTriggerCd then
    self:PlayEffectAni()
    return
  end
  self.bTriggerCd = true
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.AnimRoot, {
    "PenguinCardAideSlot_trigger"
  })
  self:AddTimer(1, nAnimTime, function()
    self.bTriggerCd = false
  end, true, true, true)
  self._mapNode.AnimRoot:Play("PenguinCardAideSlot_trigger", 0, 0)
  WwiseManger:PostEvent("Mode_Card_cast")
  self:PlayEffectAni()
end

function PenguinCardAideSlotItemCtrl:PlayEffectAni()
end

function PenguinCardAideSlotItemCtrl:Awake()
end

function PenguinCardAideSlotItemCtrl:OnEnable()
end

function PenguinCardAideSlotItemCtrl:OnDisable()
end

function PenguinCardAideSlotItemCtrl:OnBtnClick_OpenInfo()
  if not self.nSlot then
    return
  end
  local mapAide = self._panel.mapLevel.tbAide[self.nSlot]
  if mapAide == 0 then
    return
  end
  EventManager.Hit("PenguinCard_OpenAideInfo", mapAide)
end

function PenguinCardAideSlotItemCtrl:OnEvent_Triggered(nSlotIndex)
  if not self.nSlot then
    return
  end
  local mapAide = self._panel.mapLevel.tbAide[self.nSlot]
  if mapAide == 0 or nSlotIndex ~= mapAide.nSlotIndex then
    return
  end
  if mapAide.mapPenguinCard.nTriggerPhase == GameEnum.PenguinCardTriggerPhase.Aura then
    return
  end
  if mapAide.mapPenguinCard.nTriggerPhase == GameEnum.PenguinCardTriggerPhase.Settlement then
    self.bWaitPlay = true
    return
  end
  self:PlayTriggerAni()
end

function PenguinCardAideSlotItemCtrl:OnEvent_AuraTriggered()
  if not self.nSlot then
    return
  end
  local mapAide = self._panel.mapLevel.tbAide[self.nSlot]
  if mapAide == 0 then
    return
  end
  if mapAide.mapPenguinCard.nTriggerPhase ~= GameEnum.PenguinCardTriggerPhase.Aura then
    return
  end
  self:PlayTriggerAni()
end

function PenguinCardAideSlotItemCtrl:OnEvent_Growth(nSlotIndex)
end

function PenguinCardAideSlotItemCtrl:OnEvent_WaitPlay()
  if self.bWaitPlay == true then
    self.bWaitPlay = false
    self:PlayTriggerAni()
  end
end

return PenguinCardAideSlotItemCtrl
