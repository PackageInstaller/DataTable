_class("CCampaignRandomDraw", ICampaignComponentLocalProcessBase)
CCampaignRandomDraw = CCampaignRandomDraw

function CCampaignRandomDraw:Constructor()
  self._randomLotteryComponent = nil
  self._randomLotteryCompInfo = nil
  self._actionPointComponent = nil
  self._actionPointScoreCompInfo = nil
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignRandomDraw:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_RANDOM_DRAW
end

function CCampaignRandomDraw:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignRandomDraw:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetRandomLotteryComponent()
  self:_GetActionPointComponent()
  self:_GetStoryComponent()
end

function CCampaignRandomDraw:_GetRandomLotteryComponent()
  self._randomLotteryComponent = self._campaignObj:GetComponent(ECampaignRandomDrawComponentID.RANDOMLOTTERY)
  if not self._randomLotteryComponent then
    return
  end
  self._randomLotteryCompInfo = self._randomLotteryComponent:ComponentInfo()
end

function CCampaignRandomDraw:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECampaignRandomDrawComponentID.ACTIONPOINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointScoreCompInfo = self._actionPointComponent:ComponentInfo()
end

function CCampaignRandomDraw:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignRandomDrawComponentID.STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignRandomDraw:GetComponent(componentID)
  if ECampaignRandomDrawComponentID.RANDOMLOTTERY == componentID then
    return self._randomLotteryComponent
  end
  if ECampaignRandomDrawComponentID.ACTIONPOINT == componentID then
    return self._actionPointComponent
  end
  if ECampaignRandomDrawComponentID.STORY == componentID then
    return self._storyComponent
  end
  return nil
end

function CCampaignRandomDraw:GetComponentInfo(componentID)
  if ECampaignRandomDrawComponentID.RANDOMLOTTERY == componentID then
    return self._randomLotteryCompInfo
  end
  if ECampaignRandomDrawComponentID.ACTIONPOINT == componentID then
    return self._actionPointScoreCompInfo
  end
  if ECampaignRandomDrawComponentID.STORY == componentID then
    return self._storyComponentInfo
  end
  return nil
end
