_class("CCampaignHiiro", ICampaignComponentLocalProcessBase)
CCampaignHiiro = CCampaignHiiro

function CCampaignHiiro:Constructor()
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._personProgressComponent = nil
  self._personProgressCompInfo = nil
  self._camQuestComponet = nil
  self._camQuestComponetInfo = nil
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignHiiro:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_HIIRO
end

function CCampaignHiiro:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignHiiro:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLotteryComponent()
  self:_GetPersonProgressComponent()
  self:_GetCamQuestComponent()
  self:_GetStoryComponent()
  self:_GetCumulativeLoginComponent()
end

function CCampaignHiiro:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignHiiro:_GetPersonProgressComponent()
  self._personProgressComponent = self._campaignObj:GetComponent(ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_PERSON_PROGRESS)
  if not self._personProgressComponent then
    return
  end
  self._personProgressCompInfo = self._personProgressComponent:ComponentInfo()
end

function CCampaignHiiro:_GetCamQuestComponent()
  self._camQuestComponet = self._campaignObj:GetComponent(ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_QUEST)
  if not self._camQuestComponet then
    return
  end
  self._camQuestComponetInfo = self._camQuestComponet:ComponentInfo()
end

function CCampaignHiiro:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignHiiro:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignHiiro:GetComponent(componentID)
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_PERSON_PROGRESS == componentID then
    return self._personProgressComponent
  end
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_QUEST == componentID then
    return self._camQuestComponet
  end
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_STORY == componentID then
    return self._storyComponent
  end
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  return nil
end

function CCampaignHiiro:GetComponentInfo(componentID)
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_PERSON_PROGRESS == componentID then
    return self._personProgressCompInfo
  end
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_QUEST == componentID then
    return self._camQuestComponetInfo
  end
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_STORY == componentID then
    return self._storyComponentInfo
  end
  if ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  return nil
end
