_class("CCampaignSeason", ICampaignComponentLocalProcessBase)
CCampaignSeason = CCampaignSeason

function CCampaignSeason:Constructor()
  self._seasonMisionComponet = nil
  self._seasonMisionCompInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._shopComponent = nil
  self._shopCompInfo = nil
  self._actionPointComponent = nil
  self._actionPointCompInfo = nil
  self._questComponent2 = nil
  self._questComponentInfo2 = nil
  self._storyComponent = nil
  self._storyComponentInfo = nil
  self._businessComponet = nil
  self._businessComponetInfo = nil
  self._totalProgressComponent = nil
  self._totalProgressComponentInfo = nil
  self._talentProgressComponent = nil
  self._talentProgressComponentInfo = nil
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._talentTreeComponet = nil
  self._talentTreeCompInfo = nil
  self._linepopstarMissionComponent = nil
  self._linepopstarMissionComponentInfo = nil
  self._lineblackfistComponet = nil
  self._lineblackfistComponetInfo = nil
  self._linetalentComponet = nil
  self._linetalentComponetInfo = nil
  self._campaignObj = nil
end

function CCampaignSeason:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON
end

function CCampaignSeason:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSeason:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetSeasonMissionComponent()
  self:_GetQuestComponent()
  self:_GetShopComponent()
  self:_GetActionPointComponent()
  self:_GetQuestComponent2()
  self:_GetStoryComponent()
  self:_GetBusinessCommonComponent()
  self:_GetTotalProgressComponent()
  self:_GetTalentProgressComponent()
  self:_GetLineMissionComponent()
  self:_GetTalentTreeComponent()
  self:_GetLinePopStarMissionComponent()
  self:_GetLineBlackfistComponent()
  self:_GetLineTalentTreeComponent()
end

function CCampaignSeason:_GetSeasonMissionComponent()
  self._seasonMisionComponet = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  if not self._seasonMisionComponet then
    return
  end
  self._seasonMisionCompInfo = self._seasonMisionComponet:ComponentInfo()
end

function CCampaignSeason:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignSeason:_GetShopComponent()
  self._shopComponent = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.EXCHANGE_SHOP)
  if not self._shopComponent then
    return
  end
  self._shopCompInfo = self._shopComponent:ComponentInfo()
end

function CCampaignSeason:_GetActionPointComponent()
  self._actionPointComponent = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.ACTION_POINT)
  if not self._actionPointComponent then
    return
  end
  self._actionPointCompInfo = self._actionPointComponent:ComponentInfo()
end

function CCampaignSeason:_GetQuestComponent2()
  self._questComponent2 = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.QUEST_STORY)
  if not self._questComponent2 then
    return
  end
  self._questComponentInfo2 = self._questComponent2:ComponentInfo()
end

function CCampaignSeason:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.STORY)
  if not self._storyComponent then
    return
  end
  self._storyComponentInfo = self._storyComponent:ComponentInfo()
end

function CCampaignSeason:_GetBusinessCommonComponent()
  self._businessComponet = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.BUSINESS)
  if not self._businessComponet then
    return
  end
  self._businessComponetInfo = self._businessComponet:ComponentInfo()
end

function CCampaignSeason:_GetTotalProgressComponent()
  self._totalProgressComponent = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.TOTAL_PROCESS)
  if not self._totalProgressComponent then
    return
  end
  self._totalProgressComponentInfo = self._totalProgressComponent:ComponentInfo()
end

function CCampaignSeason:_GetTalentProgressComponent()
  self._talentProgressComponent = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.REWARD_PROCESS)
  if not self._talentProgressComponent then
    return
  end
  self._talentProgressComponentInfo = self._talentProgressComponent:ComponentInfo()
end

function CCampaignSeason:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaignSeason:_GetTalentTreeComponent()
  self._talentTreeComponet = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.TALENT_TREE)
  if not self._talentTreeComponet then
    return
  end
  self._talentTreeCompInfo = self._talentTreeComponet:ComponentInfo()
end

function CCampaignSeason:_GetLinePopStarMissionComponent()
  self._linepopstarMissionComponent = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.LINE_MISSION_POPSTAR)
  if not self._linepopstarMissionComponent then
    return
  end
  self._linepopstarMissionComponentInfo = self._linepopstarMissionComponent:ComponentInfo()
end

function CCampaignSeason:_GetLineBlackfistComponent()
  self._lineblackfistComponet = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST)
  if not self._lineblackfistComponet then
    return
  end
  self._lineblackfistComponetInfo = self._lineblackfistComponet:ComponentInfo()
end

function CCampaignSeason:_GetLineTalentTreeComponent()
  self._linetalentComponet = self._campaignObj:GetComponent(ECCampaignSeasonComponentID.LINE_MISSION_TALEN)
  if not self._linetalentComponet then
    return
  end
  self._linetalentComponetInfo = self._linetalentComponet:ComponentInfo()
end

function CCampaignSeason:GetComponent(componentID)
  if ECCampaignSeasonComponentID.SEASON_MISSION == componentID then
    return self._seasonMisionComponet
  end
  if ECCampaignSeasonComponentID.QUEST == componentID then
    return self._questComponent
  end
  if ECCampaignSeasonComponentID.EXCHANGE_SHOP == componentID then
    return self._shopComponent
  end
  if ECCampaignSeasonComponentID.ACTION_POINT == componentID then
    return self._actionPointComponent
  end
  if ECCampaignSeasonComponentID.QUEST_STORY == componentID then
    return self._questComponent2
  end
  if ECCampaignSeasonComponentID.STORY == componentID then
    return self._storyComponent
  end
  if ECCampaignSeasonComponentID.BUSINESS == componentID then
    return self._businessComponet
  end
  if ECCampaignSeasonComponentID.TOTAL_PROCESS == componentID then
    return self._totalProgressComponent
  end
  if ECCampaignSeasonComponentID.REWARD_PROCESS == componentID then
    return self._talentProgressComponent
  end
  if ECCampaignSeasonComponentID.LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECCampaignSeasonComponentID.TALENT_TREE == componentID then
    return self._talentTreeComponet
  end
  if ECCampaignSeasonComponentID.LINE_MISSION_POPSTAR == componentID then
    return self._linepopstarMissionComponent
  end
  if ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST == componentID then
    return self._lineblackfistComponet
  end
  if ECCampaignSeasonComponentID.LINE_MISSION_TALEN == componentID then
    return self._linetalentComponet
  end
  return nil
end

function CCampaignSeason:GetComponentInfo(componentID)
  if ECCampaignSeasonComponentID.SEASON_MISSION == componentID then
    return self._seasonMisionCompInfo
  end
  if ECCampaignSeasonComponentID.QUEST == componentID then
    return self._questComponentInfo
  end
  if ECCampaignSeasonComponentID.EXCHANGE_SHOP == componentID then
    return self._shopCompInfo
  end
  if ECCampaignSeasonComponentID.ACTION_POINT == componentID then
    return self._actionPointCompInfo
  end
  if ECCampaignSeasonComponentID.QUEST_STORY == componentID then
    return self._questComponentInfo2
  end
  if ECCampaignSeasonComponentID.STORY == componentID then
    return self._storyComponentInfo
  end
  if ECCampaignSeasonComponentID.BUSINESS == componentID then
    return self._businessComponetInfo
  end
  if ECCampaignSeasonComponentID.TOTAL_PROCESS == componentID then
    return self._totalProgressComponentInfo
  end
  if ECCampaignSeasonComponentID.REWARD_PROCESS == componentID then
    return self._talentProgressComponentInfo
  end
  if ECCampaignSeasonComponentID.LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECCampaignSeasonComponentID.TALENT_TREE == componentID then
    return self._talentTreeCompInfo
  end
  if ECCampaignSeasonComponentID.LINE_MISSION_POPSTAR == componentID then
    return self._linepopstarMissionComponentInfo
  end
  if ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST == componentID then
    return self._lineblackfistComponetInfo
  end
  if ECCampaignSeasonComponentID.LINE_MISSION_TALEN == componentID then
    return self._linetalentComponetInfo
  end
  return nil
end
