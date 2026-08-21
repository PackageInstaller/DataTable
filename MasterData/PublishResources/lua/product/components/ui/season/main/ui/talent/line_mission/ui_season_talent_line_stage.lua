_class("UISeasonTalentLineStage", UIController)
UISeasonTalentLineStage = UISeasonTalentLineStage

function UISeasonTalentLineStage:_GetComponents()
  self._enemy_normal = self:GetUIComponent("UISelectObjectPath", "enemy_normal")
  self._sop = self:GetUIComponent("UISelectObjectPath", "conditions")
  self._conditionsGo = self:GetGameObject("conditions")
  self._conditionNo = self:GetGameObject("conditionNo")
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self.panelBattleInfoGo = self:GetGameObject("PanelBattleInfo")
  self.panelAwardsInfoGo = self:GetGameObject("PanelAwardsInfo")
  self.wordsContentNormal = self:GetUIComponent("UISelectObjectPath", "WordsNormalContent")
  self.wordsNormalGo = self:GetGameObject("WordsNormalScroll")
  self._chapterNormalNameText = self:GetUIComponent("UILocalizationText", "ChapterNameNormal")
  self._awardsPanelBtnText = self:GetUIComponent("UILocalizationText", "AwardsPanelBtnText")
  self._battleInfoPanelBtnText = self:GetUIComponent("UILocalizationText", "BattleInfoPanelBtnText")
  self._anim = self:GetUIComponent("Animation", "UICanvas")
  self._battleInfoBtn = self:GetGameObject("BattleInfoPanelBtn")
  self._panelAwardsTipGo = self:GetGameObject("AwardsPanelTip")
  self._panelBattleInfoTipGo = self:GetGameObject("BattleInfoPanelTip")
end

function UISeasonTalentLineStage:OnShow(uiParams)
  self._gradeAtlas = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._module = self:GetModule(MissionModule)
  self._missionID = uiParams[1]
  self._missionFinishInfo = uiParams[2]
  self._component = uiParams[3]
  self._curPanel = UISeasonLevelStagePanelMode.AwardsInfo
  self:_GetComponents()
  self:Init()
  self._anim:Play("uieff_UISeasonLevelStageS3_In")
end

function UISeasonTalentLineStage:HasPassThreeStar(missionCfg)
  local missionId = missionCfg.CampaignMissionId
  if not self._missionFinishInfo[missionId] then
    return false
  end
  local missionFinishInfo = self._missionFinishInfo[missionId]
  if missionCfg.ThreeStarCondition1 and missionFinishInfo.star & 1 == 0 then
    return false
  end
  if missionCfg.ThreeStarCondition2 and missionFinishInfo.star & 2 == 0 then
    return false
  end
  if missionCfg.ThreeStarCondition3 and missionFinishInfo.star & 4 == 0 then
    return false
  end
  return true
end

function UISeasonTalentLineStage:GetSortedArr(awardType, cfg, stageAwardType)
  local list = UICommonHelper:GetInstance():GetDropByAwardType(awardType, cfg)
  local vecSort = SortedArray:New(Algorithm.COMPARE_CUSTOM, DiscoveryStage._LessComparer)
  if list then
    for i, v in ipairs(list) do
      local award = Award:New()
      award:InitWithCount(v.ItemID, v.Count, v.Type)
      award:FlushType(stageAwardType)
      vecSort:Insert(award)
    end
  end
  return vecSort.elements
end

function UISeasonTalentLineStage:ProcessAward(missionCfg)
  local awards = {}
  if not self:HasPassThreeStar(missionCfg) then
    local awardsStar = self:GetSortedArr(AwardType.ThreeStar, missionCfg, StageAwardType.Star)
    if awardsStar then
      for i, v in ipairs(awardsStar) do
        awards[#awards + 1] = v
      end
    end
  end
  if not self._missionFinishInfo[self._missionID] then
    local awardsFirst = self:GetSortedArr(AwardType.First, missionCfg, StageAwardType.First)
    if awardsFirst then
      for i, v in ipairs(awardsFirst) do
        awards[#awards + 1] = v
      end
    end
  end
  local normalArr = self:GetSortedArr(AwardType.Pass, missionCfg, StageAwardType.Normal)
  if normalArr then
    for i, v in ipairs(normalArr) do
      awards[#awards + 1] = v
    end
  end
  return awards
end

function UISeasonTalentLineStage:RefreshWordsArea()
  self.wordsNormalGo:SetActive(true)
end

function UISeasonTalentLineStage:InitWords()
  self:_InitWords(self.wordsContentNormal, self._missionID)
  self:RefreshWordsArea()
end

function UISeasonTalentLineStage:_InitWords(sop, missionId)
  local missionCfg = Cfg.cfg_campaign_mission[missionId]
  local wordsTb = {}
  local usedWordIDList = {}
  local buff = missionCfg.BaseWordBuff
  if buff then
    local words = type(buff) == "table" and buff or {buff}
    for _, wordId in ipairs(buff) do
      if not table.icontains(usedWordIDList, wordId) then
        table.insert(wordsTb, self:_GetWordDesc(missionId, wordId))
        table.insert(usedWordIDList, wordId)
      end
    end
  end
  local data = wordsTb
  local count = #data
  sop:SpawnObjects("UIStageWordItem", count)
  local pools = sop:GetAllSpawnList()
  for i = 1, #pools do
    local item = pools[i]
    local tex = data[i]
    item:SetData(tex)
  end
end

function UISeasonTalentLineStage:_GetWordDesc(levelId, wordId)
  local word = Cfg.cfg_word_buff[wordId]
  if not word then
    Log.exception("cfg_word_buff 中找不到词缀:", wordId, "levelId:", levelId)
  end
  local name = StringTable.Get(word.Word[1])
  local desc = StringTable.Get(word.Desc)
  local tex = "【" .. name .. "】 " .. desc
  return tex
end

function UISeasonTalentLineStage:RefreshPanelShow()
  self.panelAwardsInfoGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.AwardsInfo)
  self.panelBattleInfoGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.BattleInfo)
  self._panelAwardsTipGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.AwardsInfo)
  self._panelBattleInfoTipGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.BattleInfo)
end

function UISeasonTalentLineStage:RefreshPanelText()
  if self._curPanel == UISeasonLevelStagePanelMode.AwardsInfo then
    self._awardsPanelBtnText.color = Color(0.404, 0.302, 0.259, 1)
    self._battleInfoPanelBtnText.color = Color(0.592, 0.51, 0.447, 1)
  else
    self._awardsPanelBtnText.color = Color(0.592, 0.51, 0.447, 1)
    self._battleInfoPanelBtnText.color = Color(0.404, 0.302, 0.259, 1)
  end
end

function UISeasonTalentLineStage:InitAllAwards()
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  local awards = self:ProcessAward(missionCfg)
  if not awards then
    return
  end
  local count = table.count(awards)
  local grid = self:GetUIComponent("GridLayoutGroup", "Content")
  local contentSizeFilter = self:GetUIComponent("ContentSizeFitter", "Content")
  local contentRect = self:GetUIComponent("RectTransform", "Content")
  if 4 < count then
    grid.childAlignment = UnityEngine.TextAnchor.MiddleLeft
    contentSizeFilter.enabled = true
  else
    grid.childAlignment = UnityEngine.TextAnchor.MiddleCenter
    contentSizeFilter.enabled = false
  end
  contentRect.localPosition = Vector3(0, 0, 0)
  local sop = self:GetUIComponent("UISelectObjectPath", "Content")
  sop:SpawnObjects("UISeasonStageAwardItemS4", count)
  local list = sop:GetAllSpawnList()
  for i, v in ipairs(list) do
    v:Flush(awards[i])
  end
end

function UISeasonTalentLineStage:Init()
  self:RefreshPanelShow()
  self:RefreshPanelText()
  self:InitChapterName()
  self:RefreshThreeStarArea(true, 0)
  self:InitAllAwards()
  self:InitEnemys()
  self:InitWords()
  self:RefreshRecommendLv()
  self:RefreshWordsArea()
end

function UISeasonTalentLineStage:UpdateCondition(three_star_condition, conditions)
  local l_cur_star_num = 0
  for index, value in ipairs(three_star_condition) do
    if value.satisfy == true then
      l_cur_star_num = l_cur_star_num + 1
    end
  end
  local l_finish_star_num = #conditions
  for index, value in ipairs(three_star_condition) do
    if l_finish_star_num == l_cur_star_num then
      value:FlushSatisfy(false)
    end
    for i, v in ipairs(conditions) do
      if v == index then
        value:FlushSatisfy(true)
      end
    end
  end
end

function UISeasonTalentLineStage:BtnFightOnClick(go)
  local ctx = self._module:TeamCtx()
  ctx:Init(TeamOpenerType.Campaign, {
    self._missionID,
    self._component:GetCampaignMissionComponentId(),
    self._component:GetCampaignMissionParamKeyMap()
  })
  ctx:ShowDialogUITeams()
end

function UISeasonTalentLineStage:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UISeasonTalentLineStage:BgOnClick()
  self:Close()
end

function UISeasonTalentLineStage:InitChapterName()
  self:_InitChapterName(self._chapterNormalNameText, self._missionID)
end

function UISeasonTalentLineStage:_InitChapterName(text, missionId)
  local missionCfg = Cfg.cfg_campaign_mission[missionId]
  if text and missionCfg then
    text:SetText(StringTable.Get(missionCfg.Name))
  end
end

function UISeasonTalentLineStage:RefreshThreeStarArea(playAnim, animDelay)
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  local threeStarConditions = {}
  if missionCfg.IgnoreThreeStar and missionCfg.IgnoreThreeStar == 0 then
    local ids = {
      missionCfg.ThreeStarCondition1,
      missionCfg.ThreeStarCondition2,
      missionCfg.ThreeStarCondition3
    }
    for i, v in ipairs(ids) do
      local cond = StageCondition:New()
      cond:Init(i, v)
      table.insert(threeStarConditions, cond)
    end
    if self._missionFinishInfo[self._missionID] then
      local starCount, completeStarList = self._module:ParseStarInfo(self._missionFinishInfo[self._missionID].star)
      self:UpdateCondition(threeStarConditions, completeStarList)
    end
  end
  if 0 < #threeStarConditions then
    self._conditionsGo:SetActive(true)
    self._conditionNo:SetActive(false)
    self._sop:SpawnObjects("UISeasonConditionItem", #threeStarConditions)
    self._conditions = self._sop:GetAllSpawnList()
    for i, v in ipairs(self._conditions) do
      if v:IsEnable() then
        v:Flush(threeStarConditions[i], i)
        if playAnim then
          v:SetWaitAnim()
        end
      end
    end
    if playAnim then
      self:PlayAnimThreeStarArea(animDelay)
    end
  else
    self._conditionsGo:SetActive(false)
    self._conditionNo:SetActive(true)
  end
end

function UISeasonTalentLineStage:PlayAnimThreeStarArea(totalAnimDelay)
  if self._conditions then
    local eachCellAnimDelay = 50
    local cellDelay = 50
    if totalAnimDelay then
      cellDelay = cellDelay + totalAnimDelay
    end
    for i, v in ipairs(self._conditions) do
      if v:IsEnable() then
        v:PlayAnim(cellDelay)
        cellDelay = cellDelay + eachCellAnimDelay
      end
    end
  end
end

function UISeasonTalentLineStage:InitEnemys()
  self:_InitEnemy(self._enemy_normal, self._missionID)
end

function UISeasonTalentLineStage:_InitEnemy(sop, missionId)
  local missionCfg = Cfg.cfg_campaign_mission[missionId]
  local enemyObj = sop:SpawnObject("UIStageEnemy")
  local recommendAwaken = missionCfg.RecommendAwaken and missionCfg.RecommendAwaken or 0
  local recommendLV = missionCfg.RecommendLV and missionCfg.RecommendLV or 0
  local color = Color(1, 1, 1, 1)
  local enemyTitleBgSprite, enemyTitleBg2Sprite
  enemyObj:Flush(recommendAwaken, recommendLV, missionCfg.FightLevel or missionCfg.LevelID, color, enemyTitleBgSprite, enemyTitleBg2Sprite, true, true, true)
end

function UISeasonTalentLineStage:RefreshRecommendLv()
  local imgGrade = self:GetUIComponent("Image", "imgGrade")
  local lvText = self:GetUIComponent("UILocalizationText", "RecommendLvText")
  local cfg = Cfg.cfg_campaign_mission[self._missionID]
  local recommendAwaken = cfg.RecommendAwaken and cfg.RecommendAwaken or 0
  local recommendLV = cfg.RecommendLV and cfg.RecommendLV or 0
  imgGrade.sprite = self._gradeAtlas:GetSprite(UIPetModule.GetAwakeSpriteNameByParam(3, recommendAwaken))
  local lvStr = tostring(recommendLV)
  lvText:SetText(lvStr)
end

function UISeasonTalentLineStage:Close()
  self:_CloseDialogWithAnim()
end

function UISeasonTalentLineStage:_CloseDialogWithAnim(callback)
  UIWidgetHelper.PlayAnimation(self, "UICanvas", "uieff_UISeasonLevelStageS3_out", 433, function()
    if callback then
      callback()
    end
    self:CloseDialog()
  end)
end

function UISeasonTalentLineStage:BattleInfoPanelBtnOnClick()
  self._curPanel = UISeasonLevelStagePanelMode.BattleInfo
  self:RefreshPanelShow()
  self:RefreshPanelText()
end

function UISeasonTalentLineStage:AwardsPanelBtnOnClick()
  self._curPanel = UISeasonLevelStagePanelMode.AwardsInfo
  self:RefreshPanelShow()
  self:RefreshPanelText()
end
