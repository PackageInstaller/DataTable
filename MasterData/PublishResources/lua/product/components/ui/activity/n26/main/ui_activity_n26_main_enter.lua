_class("UIN26MainEnter", UICustomWidget)
UIN26MainEnter = UIN26MainEnter

function UIN26MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._new:SetActive(false)
  self._red:SetActive(false)
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tipspanel2 = self:GetGameObject("tipspanel2")
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._activityConst = UIActivityN26Const:New()
  self:RequestCampaign()
end

function UIN26MainEnter:OnHide()
end

function UIN26MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN26MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN20MainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN26MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  local status, time = self._activityConst:GetShopComponentStatus()
  if status == ActivityComponentStatus.Open then
    self._tipspanel1:SetActive(true)
  end
  status, time = self._activityConst:GetHardLineMissionComponentStatus()
  if status == ActivityComponentStatus.Open then
    self._tipspanel2:SetActive(true)
  end
end

function UIN26MainEnter:FlushNewRed()
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

function UIN26MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN26MainEnter:Enter(TT)
  self:Lock("UIN20MainEnter_Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UIN20MainEnter_Enter")
    return
  end
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIActivityN26MainController, function()
    self:SwitchState(UIStateType.UIActivityN26MainController)
  end)
  self:UnLock("UIN20MainEnter_Enter")
end
