_class("UIN22MainEnter", UICustomWidget)
UIN22MainEnter = UIN22MainEnter

function UIN22MainEnter:OnShow(uiParams)
  self.new = self:GetGameObject("new")
  self.red = self:GetGameObject("red")
  self.second = self:GetGameObject("second")
  self.rlt2nd = self:GetUIComponent("RollingText", "txt2nd")
  self:_AttachEvents()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN22Data()
  self:RequestCampaign()
end

function UIN22MainEnter:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:_DetachEvents()
end

function UIN22MainEnter:_AttachEvents()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:AttachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN22MainEnter:_DetachEvents()
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self._OnComponentStepChange)
  self:DetachEvent(GameEventType.QuestUpdate, self._OnQuestUpdate)
end

function UIN22MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN22MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN22MainEnterRequestCampaign"
    self:Lock(lockName)
    self.data:RequestCampaign(TT, ECampaignType.CAMPAIGN_TYPE_N22)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN22MainEnter:BtnOnClick(go)
  if self._uiMainLobbyController then
    self._uiMainLobbyController._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self._uiMainLobbyController:GetName())
    local rt = self._uiMainLobbyController._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIActivityN22MainController, cache_rt, true)
    end)
  else
    self:SwitchState(UIStateType.UIActivityN22MainController, nil, true)
  end
end

function UIN22MainEnter:_OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:FlushNewRed()
  end
end

function UIN22MainEnter:_OnQuestUpdate()
  self:FlushNewRed()
end

function UIN22MainEnter:Flush()
  local state = self.data:GetStateEntrust()
  if state == UISummerOneEnterBtnState.Locked or state == UISummerOneEnterBtnState.Normal then
    self.second:SetActive(true)
    self.rlt2nd:RefreshText(StringTable.Get("str_n22_trust_unlock"))
  else
    self.second:SetActive(false)
  end
end

function UIN22MainEnter:FlushNewRed()
  local notEnterMain = not N22Data.HasPrefsMain()
  local notEnterHard = not N22Data.HasPrefsHard()
  local notEnterMission = not N22Data.HasPrefsMission()
  local component = self.data:GetComponentEntrust()
  local notEnterEntrust = false
  if component ~= nil then
    notEnterEntrust = component:HasNew()
  end
  local hasHardOpen = self.data:GetStateHard() == UISummerOneEnterBtnState.Normal
  local hasEntrustOpen = self.data:GetStateEntrust() == UISummerOneEnterBtnState.Normal
  local new = notEnterMain or hasHardOpen and notEnterHard or notEnterMission or hasEntrustOpen and notEnterEntrust
  local red = false
  if not new then
    red = self.data:CheckRedAward() or self.data:CheckRedNormal()
  end
  UIActivityHelper.SetWidgetNewAndRed(self.new, new, self.red, red)
end
