_class("UISeasonOnceMissionStageEnemy", UICustomWidget)
UISeasonOnceMissionStageEnemy = UISeasonOnceMissionStageEnemy

function UISeasonOnceMissionStageEnemy:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonOnceMissionStageEnemy:InitWidget()
  self._enemy_normal_Pool = self:GetUIComponent("UISelectObjectPath", "enemy_normal")
  self._enemy_black_Pool = self:GetUIComponent("UISelectObjectPath", "enemy_blackfist")
  self._normalGo = self:GetGameObject("normal")
  self._blackGo = self:GetGameObject("blackfist")
end

function UISeasonOnceMissionStageEnemy:SetData(missionID, onceMissionData, cmpt)
  self._missionID = missionID
  self._onceMissionData = onceMissionData
  self._cmpt = cmpt
  local subCfg = cmpt:GetLineSubCfg()
  self._campaignSubMatchTyhpe = subCfg.SubType
  local cmpInfo = self._cmpt:GetComponentInfo()
  self._missionFinishInfo = cmpInfo.m_pass_mission_info[missionID]
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  self._normalGo:SetActive(self._campaignSubMatchTyhpe ~= CampaignSubMatchType.CSMT_BLACKFIST)
  self._blackGo:SetActive(self._campaignSubMatchTyhpe == CampaignSubMatchType.CSMT_BLACKFIST)
  if self._campaignSubMatchTyhpe == CampaignSubMatchType.CSMT_BLACKFIST then
    self:FlushBalckFist()
  else
    self:FlushNormal(missionCfg)
  end
end

function UISeasonOnceMissionStageEnemy:FlushNormal(missionCfg)
  local color = Color(1, 1, 1, 1)
  local enemyTitleBgSprite, enemyTitleBg2Sprite
  if missionCfg.Type == ActivityMissionType.FightBoss then
    color = Color(0.21176470588235294, 0.21176470588235294, 0.21176470588235294, 1)
  else
    color = Color(0.21176470588235294, 0.21176470588235294, 0.21176470588235294, 1)
  end
  self._enemyObj = self._enemy_normal_Pool:SpawnObject("UIStageEnemy")
  local recommendAwaken = missionCfg.RecommendAwaken and missionCfg.RecommendAwaken or 0
  local recommendLV = missionCfg.RecommendLV and missionCfg.RecommendLV or 0
  self._enemyObj:Flush(recommendAwaken, recommendLV, missionCfg.FightLevel or missionCfg.LevelID, color, enemyTitleBgSprite, enemyTitleBg2Sprite, true, true)
  self._enemyObj._enemyTitleBg2go:SetActive(false)
end

function UISeasonOnceMissionStageEnemy:FlushBalckFist()
  local enemyObj = self._enemy_black_Pool:SpawnObject("UISeasonStageEnemyBalckfist")
  enemyObj:SetData(self._missionID)
end

function UISeasonOnceMissionStageEnemy:RelBtnOnClick()
  self:ShowDialog("UIStageElemTips")
end
