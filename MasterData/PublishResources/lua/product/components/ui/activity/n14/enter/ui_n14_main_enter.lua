_class("UIN14MainEnter", UICustomWidget)
UIN14MainEnter = UIN14MainEnter

function UIN14MainEnter:OnShow(uiParams)
  self.new = self:GetGameObject("new")
  self.red = self:GetGameObject("red")
  self.second = self:GetGameObject("second")
  self.rlt2nd = self:GetUIComponent("RollingText", "txt2nd")
  self:_AttachEvents()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = N14Data:New()
  self:RequestCampaign()
end

function UIN14MainEnter:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:_DetachEvents()
end

function UIN14MainEnter:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN14MainEnter:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN14MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN14MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN14MainEnterRequestCampaign"
    self:Lock(lockName)
    self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N14)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN14MainEnter:btnOnClick(go)
  self:SwitchState(UIStateType.UIN14Main)
end

function UIN14MainEnter:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:FlushNewRed()
  end
end

function UIN14MainEnter:_OnQuestUpdate()
  self:FlushNewRed()
end

function UIN14MainEnter:Flush()
  local state = self.data:GetStateHard()
  self.second:SetActive(false)
  if state == UISummerOneEnterBtnState.Locked or state == UISummerOneEnterBtnState.Normal then
    self.second:SetActive(true)
    self.rlt2nd:RefreshText(StringTable.Get("str_n14_2nd_stage_open"))
  end
  state = self.data:GetStateMiniGame()
  if state == UISummerOneEnterBtnState.Locked or state == UISummerOneEnterBtnState.Normal then
    self.second:SetActive(true)
    self.rlt2nd:RefreshText(StringTable.Get("str_n14_minigame_stage_open"))
  end
end

function UIN14MainEnter:FlushNewRed()
  local notEnterMain = not N14Data.HasPrefsMain()
  local notEnterHard = not N14Data.HasPrefsHard()
  local notEnterMinigame = not N14Data.HasPrefsMiniGame()
  local hasHardOpen = self.data:GetStateHard() == UISummerOneEnterBtnState.Normal
  local hasMinigameOpen = self.data:GetStateMiniGame() == UISummerOneEnterBtnState.Normal
  local new = notEnterMain or hasHardOpen and notEnterHard or hasMinigameOpen and notEnterMinigame
  local red = false
  if not new then
    red = self.data:CheckRedAward() or self.data:CheckRedNormal() or self.data:CheckNewMiniGame()
  end
  UIActivityHelper.SetWidgetNewAndRed(self.new, new, self.red, red)
end
