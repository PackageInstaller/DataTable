_class("UIN25IdolApController", UIController)
UIN25IdolApController = UIN25IdolApController

function UIN25IdolApController:Constructor()
end

function UIN25IdolApController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, function()
    end, function()
      self:SwitchState(UIStateType.UIMain)
    end)
  end
  self.component = self._campaign:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
end

function UIN25IdolApController:OnShow(uiParams)
  self.apID = uiParams[1]
  self:GetStoryID()
  self:OpenAp()
  self:AttachEvent(GameEventType.OnN25IdolCheckState, self.OnN25IdolCheckState)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN25IdolCheckState, self:GetName())
end

function UIN25IdolApController:GetStoryID()
  local cfg = Cfg.cfg_component_idol_event({
    EventId = self.apID
  })[1]
  self.storyID = cfg.StoryId
  if not self.storyID then
    Log.fatal("###[UIN25IdolApController] storyID is nil ! apid:", self.apID)
  end
end

function UIN25IdolApController:CheckOptionCantClick(condition)
  local conditionTab = condition
  for key, value in pairs(condition) do
    if not self.component:UI_IsFinishAgreedEvent(value) then
      return true
    end
  end
  return false
end

function UIN25IdolApController:AddThreeD(idx, callback)
  self.eventType = IdolEventType.IdolEventType_Agree
  self.chooseIdx = idx
  self.callback = callback or nil
  GameGlobal.TaskManager():StartTask(self.FinishAp, self)
end

function UIN25IdolApController:FinishAp(TT)
  self:Lock("UIN25IdolApController:FinishAp")
  local res = AsyncRequestRes:New()
  local optionType = IdolOptionType.IdolOptionType_None
  if self.chooseIdx == 1 then
    optionType = IdolOptionType.IdolOptionType_First
  elseif self.chooseIdx == 2 then
    optionType = IdolOptionType.IdolOptionType_Second
  elseif self.chooseIdx == 3 then
    optionType = IdolOptionType.IdolOptionType_Third
  end
  self.component:HandleIdolCompleteEvent(TT, res, self.eventType, optionType, self.apID)
  self:UnLock("UIN25IdolApController:FinishAp")
  if res:GetSucc() then
    local cfg = Cfg.cfg_component_idol_event({
      EventId = self.apID
    })[1]
    if not cfg then
      Log.error("###[UIN25IdolApController] not cfg ! ap id :", self.apID)
    end
    local limit = cfg.AddValue
    if limit and table.count(limit) > 0 then
      self.threeType = limit[self.chooseIdx][1]
      self.threeValue = limit[self.chooseIdx][2]
    else
      Log.error("###[UIN25IdolApController] cfg.AddValue is nil ! id :", self.apID)
    end
    if self.callback then
      self.callback(true, self.threeType, self.threeValue, res)
    end
  else
    local result = res:GetResult()
    Log.fatal("###[UIN25IdolApController] HandleIdolCompleteEvent fail ! result:", result)
    if self.callback then
      self.callback(false, nil, nil, res)
    end
  end
end

function UIN25IdolApController:CheckAp(currentTurn)
end

function UIN25IdolApController:OpenAp()
  self:ShowDialog("UIN25IdolStoryController", self.storyID, function()
    CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N25IdolGameNextDay)
      CutsceneManager.ExcuteCutsceneOut()
    end)
  end)
end

function UIN25IdolApController:OnN25IdolCheckState(openDialog)
  local diaName = self:GetName()
  if diaName ~= openDialog then
    self:CloseDialog()
  end
end
