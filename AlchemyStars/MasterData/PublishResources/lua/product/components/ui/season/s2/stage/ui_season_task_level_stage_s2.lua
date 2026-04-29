_class("UISeasonTaskLevelStageS2", UIController)
UISeasonTaskLevelStageS2 = UISeasonTaskLevelStageS2

function UISeasonTaskLevelStageS2:LoadDataOnEnter(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SEASON_TASK_MISSION, ECampaignSeasonTaskMissionComponentID.ECAMPAIGN_SEASON_TASK_MISSION)
  self._component = self._campaign:GetComponent(ECampaignSeasonTaskMissionComponentID.ECAMPAIGN_SEASON_TASK_MISSION)
  self._componentInfo = self._campaign:GetComponentInfo(ECampaignSeasonTaskMissionComponentID.ECAMPAIGN_SEASON_TASK_MISSION)
end

function UISeasonTaskLevelStageS2:OnShow(uiParams)
  GameGlobal.EngineInput().multiTouchEnabled = false
  self._atlas = self:GetAsset("UIStage.spriteatlas", LoadType.SpriteAtlas)
  self._gradeAtlas = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._module = self:GetModule(MissionModule)
  self._missionID = uiParams[1]
  self._eventPoint = uiParams[2]
  self._missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  self._curPanel = UISeasonLevelStagePanelMode.BattleInfo
  self:_GetComponents()
  self:_OnValue()
  self:_ShowMainUI(false)
end

function UISeasonTaskLevelStageS2:_GetComponents()
  self._enemyPool = self:GetUIComponent("UISelectObjectPath", "enemy_normal")
  self._bgImg = self:GetUIComponent("RawImageLoader", "bgImg")
  self._tips = self:GetUIComponent("UISelectObjectPath", "itemTips"):SpawnObject("UISelectInfo")
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._backBtn = UIWidgetHelper.SpawnObject(self, "btns", "UISeasonTopBtn")
  self._backBtn:SetData(function()
    self:Close()
  end, nil, nil, nil)
  self._panelBattleInfoGo = self:GetGameObject("PanelBattleInfo")
  self._panelAwardsInfoGo = self:GetGameObject("PanelAwardsInfo")
  self._chapterNormalNameText = self:GetUIComponent("UILocalizedTMP", "ChapterNameNormal")
  self._wordsNormalContent = self:GetUIComponent("UILocalizationText", "WordsNormalContent")
  self._awardsPanelBtnText = self:GetUIComponent("UILocalizationText", "AwardsPanelBtnText")
  self._battleInfoPanelBtnText = self:GetUIComponent("UILocalizationText", "BattleInfoPanelBtnText")
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UISeasonTaskLevelStageS2:OnHide()
  GameGlobal.EngineInput().multiTouchEnabled = true
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UISeasonTaskLevelStageS2:RefreshPanelShow()
  self._panelAwardsInfoGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.AwardsInfo)
  self._panelBattleInfoGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.BattleInfo)
end

function UISeasonTaskLevelStageS2:RefreshPanelBg()
  local bgName = "exp_s2_map_di10"
  if self._curPanel == UISeasonLevelStagePanelMode.AwardsInfo then
    bgName = "exp_s2_map_di10"
  else
    bgName = "exp_s2_map_di11"
  end
  self._bgImg:LoadImage(bgName)
end

function UISeasonTaskLevelStageS2:RefreshPanelText()
  if self._curPanel == UISeasonLevelStagePanelMode.AwardsInfo then
    self._awardsPanelBtnText.color = Color(0.384, 0.333, 0.259, 1)
    self._battleInfoPanelBtnText = Color(0.522, 0.424, 0.263, 1)
  else
    self._awardsPanelBtnText.color = Color(0.522, 0.424, 0.263, 1)
    self._battleInfoPanelBtnText = Color(0.384, 0.333, 0.259, 1)
  end
end

function UISeasonTaskLevelStageS2:_OnValue()
  self:RefreshPanelShow()
  self:RefreshPanelBg()
  self:RefreshPanelText()
  self:InitChapterName()
  self:InitEnemys()
  self:RefreshRecommendLv()
end

function UISeasonTaskLevelStageS2:BtnFightOnClick(go)
  local ctx = self._module:TeamCtx()
  ctx:Init(TeamOpenerType.Campaign, {
    self._missionID,
    self._component:GetCampaignMissionComponentId(),
    self._component:GetCampaignMissionParamKeyMap(),
    nil
  })
  ctx:ShowDialogUITeams()
end

function UISeasonTaskLevelStageS2:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UISeasonTaskLevelStageS2:BgOnClick()
  self:Close()
end

function UISeasonTaskLevelStageS2:InitChapterName()
  self._chapterNormalNameText:SetText(StringTable.Get(self._missionCfg.Name))
  self._wordsNormalContent:SetText(StringTable.Get(self._missionCfg.Desc))
end

function UISeasonTaskLevelStageS2:InitEnemys()
  self:_InitEnemy()
  self:_RefreshEnemyArea()
end

function UISeasonTaskLevelStageS2:_InitEnemy()
  local enemyObj = self._enemyPool:SpawnObject("UIStageEnemy")
  local recommendAwaken = self._missionCfg.RecommendAwaken or 0
  local recommendLV = self._missionCfg.RecommendLV or 0
  local color = Color(1, 1, 1, 1)
  local enemyTitleBgSprite, enemyTitleBg2Sprite
  enemyObj:Flush(recommendAwaken, recommendLV, self._missionCfg.FightLevel, color, enemyTitleBgSprite, enemyTitleBg2Sprite, true, true, true)
end

function UISeasonTaskLevelStageS2:_RefreshEnemyArea()
  self._enemyNormalGo = self:GetGameObject("enemy_normal")
  self._enemyNormalGo:SetActive(true)
end

function UISeasonTaskLevelStageS2:RefreshRecommendLv()
  local imgGrade = self:GetUIComponent("Image", "imgGrade")
  local lvText = self:GetUIComponent("UILocalizationText", "RecommendLvText")
  local recommendAwaken = self._missionCfg.RecommendAwaken or 0
  local recommendLV = self._missionCfg.RecommendLV or 0
  imgGrade.sprite = self._gradeAtlas:GetSprite(UIPetModule.GetAwakeSpriteNameByParam(3, recommendAwaken))
  local lvStr = tostring(recommendLV)
  lvText:SetText(lvStr)
end

function UISeasonTaskLevelStageS2:Close()
  self:_CloseDialogWithAnim()
end

function UISeasonTaskLevelStageS2:_CloseDialogWithAnim(callback)
  UIWidgetHelper.PlayAnimation(self, "UICanvas", "uieff_Stage_out", 433, function()
    if callback then
      callback()
    end
    self:_Resume()
    self:_ShowMainUI(true)
    self:CloseDialog()
  end)
end

function UISeasonTaskLevelStageS2:_Resume()
  if self._eventPoint then
    self._eventPoint:InterruptExpress()
  end
  local seasonManager = self._uiSeasonModule:SeasonManager()
  local player = seasonManager:SeasonPlayerManager():GetPlayer()
  player:PlayAnimation(SeasonPlayerAnimation.Stand)
  local seasonAudio = seasonManager:SeasonAudioManager():GetSeasonAudio()
  if seasonAudio then
    seasonAudio:PlayVoice(false)
  end
  seasonManager:SeasonCameraManager():SeasonCamera():TryResumeSize()
  self:GetModule(SeasonModule):ClearLevelExpress()
end

function UISeasonTaskLevelStageS2:BattleInfoPanelBtnOnClick()
  self._curPanel = UISeasonLevelStagePanelMode.BattleInfo
  self:RefreshPanelShow()
  self:RefreshPanelBg()
  self:RefreshPanelText()
end

function UISeasonTaskLevelStageS2:AwardsPanelBtnOnClick()
  self._curPanel = UISeasonLevelStagePanelMode.AwardsInfo
  self:RefreshPanelShow()
  self:RefreshPanelBg()
  self:RefreshPanelText()
end

function UISeasonTaskLevelStageS2:_ShowMainUI(show)
  local controller = GameGlobal.UIStateManager():GetController(UISeasonHelper.CurSeasonSceneUI())
  if controller then
    controller:SetShow(show)
  end
end
