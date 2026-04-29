require("ui_side_enter_item_campaign")
_class("UICommonLineMissionEnter", UISideEnterItem_Campaign)
UICommonLineMissionEnter = UICommonLineMissionEnter

function UICommonLineMissionEnter:DoShow()
  UISideEnterItem_Campaign.DoShow(self)
  if not IsInland then
    self:GetGameObject("reuse"):SetActive(true)
  end
end

function UICommonLineMissionEnter:_CalcRed()
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY, ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK)
  local sample = campaign:GetSample()
  if not sample then
    Log.fatal("can not load campaign sample data, type: ECampaignType.CAMPAIGN_TYPE_STORY_ACTIVITY")
    return 0
  end
  local component = campaign:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK)
  if component then
    local missionRed = not UIActivityHelper.HasCmptRedViewed(UICommonLineMissionConst.LineMissionDBID()) and sample:IsCompRed(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION)
    local taskRed = component:HaveRedPoint()
    return (missionRed or taskRed) and 1 or 0
  elseif UIActivityHelper.HasCmptRedViewed(UICommonLineMissionConst.LineMissionDBID()) then
    return sample:IsCompRed(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK) and 1 or 0
  else
    return sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD) and 1 or 0
  end
end
