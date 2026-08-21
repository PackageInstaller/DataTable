_class("UIShopSailingPlanHelper", Object)
UIShopSailingPlanHelper = UIShopSailingPlanHelper

function UIShopSailingPlanHelper:Constructor()
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_SAILING
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo_Local(self._campaignType)
end

function UIShopSailingPlanHelper:CheckActive()
  local mainSample = self._campaign:GetSample()
  local hide = false
  local pass = false
  if mainSample then
    hide = mainSample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_HIDE)
    local camid = mainSample.id
    local cfg_client = Cfg.cfg_shop_sailing_plan_client[camid]
    if not cfg_client then
      Log.error("###[UIShopSailingPlanHelper] cfg_client is nil ! id :", camid)
    end
    local missionid = cfg_client.MissionID
    if missionid then
      local missionModule = GameGlobal.GetModule(MissionModule)
      pass = missionModule:IsPassMissionID(missionid)
    end
  end
  Log.debug("###[UIShopSailingPlanHelper] hide:", hide, "|pass:", pass)
  return pass and not hide
end

function UIShopSailingPlanHelper:CheckNew()
  local active = self:CheckActive()
  if not active then
    return false
  end
  return self._campaign:CheckCampaignNew()
end

function UIShopSailingPlanHelper:CheckRed()
  local active = self:CheckActive()
  if not active then
    return false
  end
  return self._campaign:CheckCampaignRed()
end

function UIShopSailingPlanHelper:SetNew(new)
  GameGlobal.TaskManager():StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
end
