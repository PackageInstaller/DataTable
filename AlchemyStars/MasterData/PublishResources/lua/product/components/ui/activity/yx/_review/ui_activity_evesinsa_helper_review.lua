_class("UIActivityEveSinsaHelper_Review", Object)
UIActivityEveSinsaHelper_Review = UIActivityEveSinsaHelper_Review

function UIActivityEveSinsaHelper_Review:Constructor()
end

local EActivityEveSinsaTimePhase = {
  EPhase_Line = 1,
  EPhase_Tree = 2,
  EPhase_Shop = 3,
  EPhase_Over = 4
}
_enum("EActivityEveSinsaTimePhase", EActivityEveSinsaTimePhase)

function UIActivityEveSinsaHelper_Review.CheckTimePhase(campaign)
  return EActivityEveSinsaTimePhase.EPhase_Tree
end

function UIActivityEveSinsaHelper_Review.GetPhaseEndTime(campaign, phase)
  if phase == EActivityEveSinsaTimePhase.EPhase_Over then
    Log.error("UIActivityEveSinsaHelper_Review.GetPhaseEndTime phase = ", phase)
    return 0
  end
  local phase2id = {
    ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_LINE_MISSION,
    ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_TREE_MISSION
  }
  local id = phase2id[phase]
  local phase2name = {
    "m_close_time",
    "m_close_time",
    "m_close_time"
  }
  local name = phase2name[phase]
  local componentInfo = campaign:GetComponentInfo(id)
  return componentInfo and componentInfo[name] or 0
end

function UIActivityEveSinsaHelper_Review.GetPhaseBgUrl(campaign, phase)
  local cfg_campaign = Cfg.cfg_campaign({
    CampaignID = campaign._id
  })
  if cfg_campaign then
    local url = cfg_campaign[1].BGImage
    return url[phase]
  end
end

function UIActivityEveSinsaHelper_Review.CheckSpecialMissionShow(campaign)
  do return false end
  if UIActivityEveSinsaHelper_Review.CheckSpecialMissionCanPlay(campaign) then
    return false
  end
  local cmptId = ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_LINE_MISSION
  local component = campaign:GetComponent(cmptId)
  local missionId, needId = UIActivityEveSinsaHelper_Review.GetSpecialMission(campaign)
  local pre_mission_id = 9011013
  if component:IsPassCamMissionID(pre_mission_id) then
    return true, missionId
  end
  return false
end

function UIActivityEveSinsaHelper_Review.CheckSpecialMissionCanPlay(campaign)
  local cmptId = ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_TREE_MISSION
  local component = campaign:GetComponent(cmptId)
  local missionId, needId = UIActivityEveSinsaHelper_Review.GetSpecialMission(campaign)
  if missionId and component:IsPassCamMissionID(needId) then
    return true
  end
  return false
end

function UIActivityEveSinsaHelper_Review.GetSpecialMission(campaign)
  local cmptId = ECampaignReviewEvaRescuePlanComponentID.ECAMPAIGN_REVIEW_EVARESCUEPLAN_LINE_MISSION
  local component = campaign:GetComponent(cmptId)
  local componentCfgId = component:GetComponentCfgId()
  local lineCfg = UIActivityEveSinsaHelper_Review.MakeLineConfig(componentCfgId)
  for k, v in pairs(lineCfg) do
    local otherComponentId = v.NeedMissionComponentID
    if otherComponentId and otherComponentId ~= 0 and v.WayPointType == WayPointType.WayPointType_S then
      return k, v.NeedMissionId
    end
  end
end

function UIActivityEveSinsaHelper_Review.MakeLineConfig(componentId)
  local newConfig = {}
  local config = Cfg.cfg_component_line_mission({ComponentID = componentId})
  for _, v in ipairs(config) do
    newConfig[v.CampaignMissionId] = v
  end
  return newConfig
end
