_class("UIN11MainEnter", UICustomWidget)
UIN11MainEnter = UIN11MainEnter

function UIN11MainEnter:OnShow(uiParams)
  self.new = self:GetGameObject("new")
  self.red = self:GetGameObject("red")
  self.second = self:GetGameObject("second")
  self.rlt2nd = self:GetUIComponent("RollingText", "txt2nd")
  self:_AttachEvents()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN11Data()
  self:RequestCampaign()
end

function UIN11MainEnter:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:_DetachEvents()
end

function UIN11MainEnter:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN11MainEnter:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN11MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN11MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN11MainEnterRequestCampaign"
    self:Lock(lockName)
    self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N11)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN11MainEnter:btnOnClick(go)
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIN11Main, cache_rt, true)
    end)
  else
    self:SwitchState(UIStateType.UIN11Main, nil, true)
  end
end

function UIN11MainEnter:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:FlushNewRed()
  end
end

function UIN11MainEnter:_OnQuestUpdate()
  self:FlushNewRed()
end

function UIN11MainEnter:Flush()
  local state = self.data:GetStateHard()
  if state == UISummerOneEnterBtnState.Locked or state == UISummerOneEnterBtnState.Normal then
    self.second:SetActive(true)
    self.rlt2nd:RefreshText(StringTable.Get("str_n11_2nd_stage_open"))
  else
    self.second:SetActive(false)
  end
end

function UIN11MainEnter:FlushNewRed()
  local notEnterMain = not N11Data.HasPrefsMain()
  local notEnterHard = not N11Data.HasPrefsHard()
  local hasHardOpen = self.data:GetStateHard() == UISummerOneEnterBtnState.Normal
  local new = notEnterMain or hasHardOpen and notEnterHard
  local red = false
  if not new then
    red = self.data:CheckRedAward() or self.data:CheckRedNormal()
  end
  UIActivityHelper.SetWidgetNewAndRed(self.new, new, self.red, red)
end
