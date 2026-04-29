_class("UIN38MainEnter", UIMainLobbyMainCampaignBase)
UIN38MainEnter = UIN38MainEnter

function UIN38MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._new:SetActive(false)
  self._red:SetActive(false)
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tipspanel2 = self:GetGameObject("tipspanel2")
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._activityConst = UIN38Const:New()
  self:RequestCampaign()
end

function UIN38MainEnter:OnHide()
end

function UIN38MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN38MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN38MainEnter:RequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN38MainEnter:SetData(sampleInfo, controller)
end

function UIN38MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  local status, time = self._activityConst:GetBlackMissionComponentStatus()
  if status == ActivityComponentStatus.Open then
    self._tipspanel1:SetActive(true)
    return
  end
  status, time = self._activityConst:GetHardLineMissionComponentStatus()
  if status == ActivityComponentStatus.Open then
    self._tipspanel2:SetActive(true)
    return
  end
end

function UIN38MainEnter:FlushNewRed()
  self._new:SetActive(false)
  self._red:SetActive(false)
  if self._activityConst:IsShowEntryNew() then
    self._new:SetActive(true)
    return
  end
  if self._activityConst:IsShowEntryRed() then
    self._red:SetActive(true)
  end
end

function UIN38MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN38MainEnter:Enter(TT)
  self:Lock("UIN38MainEnter:Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UIN38MainEnter:Enter")
    return
  end
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIActivityN26MainController, function()
    self:SwitchState(UIStateType.UIN38MainController)
  end)
  self:UnLock("UIN38MainEnter:Enter")
end
