_class("UIN28MainEnter", UIMainLobbyMainCampaignBase)
UIN28MainEnter = UIN28MainEnter

function UIN28MainEnter:GetComponent()
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._new:SetActive(false)
  self._red:SetActive(false)
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tipspanel2 = self:GetGameObject("tipspanel2")
  self._tipspanel3 = self:GetGameObject("tipspanel3")
  self._tipspanel4 = self:GetGameObject("tipspanel4")
end

function UIN28MainEnter:RefreshView()
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

function UIN28MainEnter:OnShow(uiParams)
  self:GetComponent()
  self._activityConst = UIActivityN28Const:New()
  self:RequestCampaign()
end

function UIN28MainEnter:OnHide()
end

function UIN28MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN28MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN28MainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN28MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._tipspanel3:SetActive(false)
  self._tipspanel4:SetActive(false)
  local status, time = self._activityConst:GetTryPetComponentStatus()
  if status == ActivityN28ComponentStatus.Open then
    self._tipspanel4:SetActive(true)
    return
  end
  local status, time = self._activityConst:EnterGetHardLineMissionComponentStatus()
  if status == ActivityN28ComponentStatus.Open then
    self._tipspanel2:SetActive(true)
    return
  end
  local status, time = self._activityConst:GetAVGGameComponentStatus()
  if status == ActivityN28ComponentStatus.Open then
    self._tipspanel1:SetActive(true)
    return
  end
  local status, time = self._activityConst:GetShopComponentStatus()
  if status == ActivityN28ComponentStatus.Open then
    self._tipspanel3:SetActive(true)
    return
  end
end

function UIN28MainEnter:FlushNewRed()
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

function UIN28MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN28MainEnter:Enter(TT)
  self:Lock("UIN28MainEnter_Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UIN28MainEnter_Enter")
    return
  end
  CutsceneManager.ExcuteCutsceneIn_Shot()
  self:SwitchState(UIStateType.UIActivityN28MainController)
  self:UnLock("UIN28MainEnter_Enter")
end
