_class("CCampaignSeasonMaze", ICampaignComponentLocalProcessBase)
CCampaignSeasonMaze = CCampaignSeasonMaze

function CCampaignSeasonMaze:Constructor()
  self._seasonMazeComponet = nil
  self._seasonMazeCompInfo = nil
  self._totalProgressComponent = nil
  self._totalProgressComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignSeasonMaze:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SEASON_MAZE
end

function CCampaignSeasonMaze:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSeasonMaze:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetSeasonMazeComponent()
  self:_GetTotalProgressComponent()
end

function CCampaignSeasonMaze:_GetSeasonMazeComponent()
  self._seasonMazeComponet = self._campaignObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  if not self._seasonMazeComponet then
    return
  end
  self._seasonMazeCompInfo = self._seasonMazeComponet:ComponentInfo()
end

function CCampaignSeasonMaze:_GetTotalProgressComponent()
  self._totalProgressComponent = self._campaignObj:GetComponent(ECCampaignSeasonMazeComponentID.TOTAL_PROCESS)
  if not self._totalProgressComponent then
    return
  end
  self._totalProgressComponentInfo = self._totalProgressComponent:ComponentInfo()
end

function CCampaignSeasonMaze:GetComponent(componentID)
  if ECCampaignSeasonMazeComponentID.SEASON_MAZE == componentID then
    return self._seasonMazeComponet
  end
  if ECCampaignSeasonMazeComponentID.TOTAL_PROCESS == componentID then
    return self._totalProgressComponent
  end
  return nil
end

function CCampaignSeasonMaze:GetComponentInfo(componentID)
  if ECCampaignSeasonMazeComponentID.SEASON_MAZE == componentID then
    return self._seasonMazeCompInfo
  end
  if ECCampaignSeasonMazeComponentID.TOTAL_PROCESS == componentID then
    return self._totalProgressComponentInfo
  end
  return nil
end
