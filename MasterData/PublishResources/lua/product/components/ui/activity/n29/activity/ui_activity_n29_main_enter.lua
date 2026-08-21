_class("UIN29MainEnter", UICustomWidget)
UIN29MainEnter = UIN29MainEnter

function UIN29MainEnter:OnShow(uiParams)
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._new:SetActive(false)
  self._red:SetActive(false)
  self._tipspanel1 = self:GetGameObject("tipspanel1")
  self._tipspanel2 = self:GetGameObject("tipspanel2")
  self._tipspanel3 = self:GetGameObject("tipspanel3")
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._tipspanel3:SetActive(false)
  self._activityConst = UIActivityCustomConst:New(self:GetCampaignType(), self:GetComponentIds())
  self:RequestCampaign()
end

function UIN29MainEnter:OnHide()
end

function UIN29MainEnter:GetEntryNewIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION
  return componentIds
end

function UIN29MainEnter:GetEntryRedIgnore()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_POWER2ITEM
  return componentIds
end

function UIN29MainEnter:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N29
end

function UIN29MainEnter:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE
  return componentIds
end

function UIN29MainEnter:SetData_uiMainLobbyController(controller)
  self._uiMainLobbyController = controller
end

function UIN29MainEnter:RequestCampaign()
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

function UIN29MainEnter:Flush()
  self._tipspanel1:SetActive(false)
  self._tipspanel2:SetActive(false)
  self._tipspanel3:SetActive(false)
  local status, time = self._activityConst:GetComponentStatus(ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS)
  if status == ActivityComponentStatus.Open then
    self._tipspanel3:SetActive(true)
    return
  end
  status, time = self._activityConst:GetComponentStatus(ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE)
  if status == ActivityComponentStatus.Open then
    self._tipspanel2:SetActive(true)
    return
  end
  status, time = self._activityConst:GetComponentStatus(ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY)
  if status == ActivityComponentStatus.Open then
    self._tipspanel1:SetActive(true)
    return
  end
end

function UIN29MainEnter:FlushNewRed()
  self._new:SetActive(false)
  self._red:SetActive(false)
  if self._activityConst:IsShowEntryNew(self:GetEntryNewIgnore()) then
    self._new:SetActive(true)
    return
  end
  if self._activityConst:IsShowEntryRed(self:GetEntryRedIgnore()) then
    self._red:SetActive(true)
  end
end

function UIN29MainEnter:BtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self.Enter, self)
end

function UIN29MainEnter:Enter(TT)
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
  self:SwitchState(UIStateType.UIActivityN29MainController)
  self:UnLock("UIN29MainEnter_Enter")
end
