_class("UIN30MainEnter", UICustomWidget)
UIN30MainEnter = UIN30MainEnter

function UIN30MainEnter:OnShow(uiParams)
  EntrustComponent:HookClientData(109301805, UIN30Entrust.RefreshClientData)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._new:SetActive(false)
  self._red:SetActive(false)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self:RequestCampaign()
end

function UIN30MainEnter:OnHide()
end

function UIN30MainEnter:GetEntryNewIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET
  return componentIds
end

function UIN30MainEnter:GetEntryRedIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET
  return componentIds
end

function UIN30MainEnter:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N30
end

function UIN30MainEnter:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_LOTTERY
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST
  return componentIds
end

function UIN30MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN30MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN29MainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:FlushNewRed()
    self:UnLock(lockName)
  end, self)
end

function UIN30MainEnter:Flush()
end

function UIN30MainEnter:FlushNewRed()
  self._new:SetActive(false)
  self._red:SetActive(false)
  local new = self._activityConst:IsShowComponentRed(ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST)
  if self._activityConst:IsShowEntryNew(self:GetEntryNewIgnore()) or new then
    self._new:SetActive(true)
    return
  end
  if self._activityConst:IsShowEntryRed(self:GetEntryRedIgnore()) then
    self._red:SetActive(true)
  end
end

function UIN30MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN30MainEnter:Enter(TT)
  self:Lock("UIN29MainEnter_Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UIN29MainEnter_Enter")
    return
  end
  CutsceneManager.ExcuteCutsceneIn("CommonBlack", function()
    self:SwitchState(UIStateType.UIActivityN30MainController)
  end)
  self:UnLock("UIN29MainEnter_Enter")
end
