_class("UICommonLineMissionAwardsEntry", UICustomWidget)
UICommonLineMissionAwardsEntry = UICommonLineMissionAwardsEntry

function UICommonLineMissionAwardsEntry:OnShow(uiParams)
  self.awardProgressTxt = self:GetUIComponent("UILocalizationText", "AwardProgress")
  self.awardProgressShadowTxt = self:GetUIComponent("UILocalizationText", "AwardProgressShadow")
  self.awardRed = self:GetGameObject("AwardRed")
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.RefreshRed)
  self._gotStarCount = 0
end

function UICommonLineMissionAwardsEntry:SetData(campaign, checkCampaiginCloseFunc)
  self._campaign = campaign
  local lineCmpt = self._campaign:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_MISSION)
  local lineCmptInfo = lineCmpt:ComponentInfo()
  local passMissionMap = lineCmptInfo.m_pass_mission_info
  local missionCfgList = Cfg.cfg_component_line_mission({
    ComponentID = lineCmpt:GetComponentCfgId()
  })
  local totalStarCount = 0
  self._gotStarCount = 0
  for i = 1, #missionCfgList do
    local missionCfg = missionCfgList[i]
    local id = missionCfg.CampaignMissionId
    local missionInfoCfg = Cfg.cfg_campaign_mission[id]
    if missionInfoCfg.Type == MissionType.MissionType_Fight_Normal or missionInfoCfg.Type == MissionType.MissionType_Fight_Boss then
      totalStarCount = totalStarCount + 3
    end
    local passInfo = passMissionMap[id]
    if passInfo then
      local star = passInfo.star
      local starCount = (star & 1) + (star >> 1 & 1) + (star >> 2 & 1)
      self._gotStarCount = self._gotStarCount + starCount
    end
  end
  self.awardProgressTxt:SetText(self._gotStarCount .. "/" .. totalStarCount)
  if self.awardProgressShadowTxt then
    self.awardProgressShadowTxt:SetText(self._gotStarCount .. "/<color=#f2d385>" .. totalStarCount .. "</color>")
  end
  self:RefreshRed()
  self._checkCampaignCloseFunc = checkCampaiginCloseFunc
end

function UICommonLineMissionAwardsEntry:RefreshRed()
  local redAward = self._campaign:CheckComponentRed(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK)
  self.awardRed:SetActive(redAward)
end

function UICommonLineMissionAwardsEntry:AwardBtnOnClick()
  if not self._checkCampaignCloseFunc() then
    self:ShowDialog("UICommonLineMissionAwards", self._campaign:GetComponent(ECampaignStoryActivityComponentID.ECAMPAIGN_STORY_ACTIVITY_TASK), self._checkCampaignCloseFunc, self._gotStarCount)
  end
end
