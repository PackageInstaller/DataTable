_class("UICommonLineMissionConst", Object)
UICommonLineMissionConst = UICommonLineMissionConst
UICommonLineMissionConst.CampaignID = 0

function UICommonLineMissionConst.InitCampaignID(id)
  UICommonLineMissionConst.CampaignID = id
end

function UICommonLineMissionConst.LineMissionDBID()
  return UICommonLineMissionConst.CampaignID * 100 + ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION
end

function UICommonLineMissionConst.TaskDBID()
  return UICommonLineMissionConst.CampaignID * 100 + ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK
end
