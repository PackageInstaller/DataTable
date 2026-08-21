_class("UIN33MainEnter", UICustomWidget)
UIN33MainEnter = UIN33MainEnter

function UIN33MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._new:SetActive(false)
  self._red:SetActive(false)
  self._tips1 = self:GetGameObject("tipspanel1")
  self._tips2 = self:GetGameObject("tipspanel2")
  self._tips3 = self:GetGameObject("tipspanel3")
  self._tips1:SetActive(false)
  self._tips2:SetActive(false)
  self._tips3:SetActive(false)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self:RequestCampaign()
end

function UIN33MainEnter:OnHide()
end

function UIN33MainEnter:GetEntryNewIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_POWER2ITEM
  return componentIds
end

function UIN33MainEnter:GetEntryRedIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_POWER2ITEM
  return componentIds
end

function UIN33MainEnter:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N33
end

function UIN33MainEnter:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION
  return componentIds
end

function UIN33MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN33MainEnter:RequestCampaign()
  self:StartTask(function(TT)
    local lockName = "UIN33MainEnterRequestCampaign"
    self:Lock(lockName)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._activityConst:LoadData(TT, res)
    self:Flush()
    self:UnLock(lockName)
  end, self)
end

function UIN33MainEnter:Flush()
  self:FlushNewRed()
  self:FlushTips()
end

function UIN33MainEnter:FlushTips()
  self._tips1:SetActive(false)
  self._tips2:SetActive(false)
  self._tips3:SetActive(false)
  local status = self._activityConst:GetComponentStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
  if status == ActivityComponentStatus.Open then
    self._tips3:SetActive(true)
    return
  end
  status = self._activityConst:GetComponentStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  if status == ActivityComponentStatus.Open then
    self._tips2:SetActive(true)
    return
  end
  status = self._activityConst:GetComponentStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
  if status == ActivityComponentStatus.Open then
    self._tips1:SetActive(true)
    return
  end
end

function UIN33MainEnter:FlushNewRed()
  self._new:SetActive(false)
  self._red:SetActive(false)
  if self._activityConst:IsShowEntryNew(self:GetEntryNewIgnore()) then
    self._new:SetActive(true)
    return
  end
  if self._activityConst:IsShowEntryRed(self:GetEntryRedIgnore()) then
    self._red:SetActive(true)
    return
  end
  local campaign = self._activityConst:GetCampaign()
  local isNew, canReceive, storyNum = UIActivityN33DateHelper.GetDateStatus(campaign)
  if canReceive or 0 < storyNum then
    self._red:SetActive(true)
  end
end

function UIN33MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN33MainEnter:Enter(TT)
  self:Lock("UIN33MainEnter_Enter")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
    self:UnLock("UIN33MainEnter_Enter")
    return
  end
  self:SwitchState(UIStateType.UIActivityN33MainController)
  self:UnLock("UIN33MainEnter_Enter")
end
