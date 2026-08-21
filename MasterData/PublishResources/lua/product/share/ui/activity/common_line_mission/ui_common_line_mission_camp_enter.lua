require("main_lobby_center_camp_data")
_class("UICommonLineMissionCampEnter", MainLobbyCenterCampData)
UICommonLineMissionCampEnter = UICommonLineMissionCampEnter

function UICommonLineMissionCampEnter:Constructor(cfg)
  local sample = GameGlobal.GetModule(CampaignModule):GetSampleByType(ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY)
  if sample then
    UICommonLineMissionConst.InitCampaignID(sample.id)
  end
end

function UICommonLineMissionCampEnter:CheckRed()
  local sample = GameGlobal.GetModule(CampaignModule):GetSampleByType(ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY)
  if sample then
    if UIActivityHelper.HasCmptRedViewed(UICommonLineMissionConst.LineMissionDBID()) then
      return sample:IsCompRed(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK) and 1 or 0
    else
      return sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD) and 1 or 0
    end
  end
end
