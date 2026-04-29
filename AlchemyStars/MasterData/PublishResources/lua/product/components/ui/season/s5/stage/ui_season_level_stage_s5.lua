_class("UISeasonLevelStageS5", UIController)
UISeasonLevelStageS5 = UISeasonLevelStageS5

function UISeasonLevelStageS5:_GetComponents()
  self._chapter_normal = self:GetUIComponent("UISelectObjectPath", "chapter_normal")
  self._chapterPool = self._chapter_normal
  self._enemy_normal = self:GetUIComponent("UISelectObjectPath", "enemy_normal")
  self._enemy_hard = self:GetUIComponent("UISelectObjectPath", "enemy_hard")
  self._enemyPool = self._enemy_normal
  self._sop = self:GetUIComponent("UISelectObjectPath", "conditions")
  self._conditionsGo = self:GetGameObject("conditions")
  self._conditionNo = self:GetGameObject("conditionNo")
  self._sr = self:GetUIComponent("ScrollRect", "ScrollView")
  self._txtCost = self:GetUIComponent("UILocalizationText", "txtCost")
  self._bgImg = self:GetUIComponent("RawImageLoader", "bgImg")
  self._unKnowImg = self:GetUIComponent("Image", "btnUnknown")
  self:AttachEvent(GameEventType.DiscoveryInitUIStage, self.Init)
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._topTips = self:GetUIComponent("UISelectObjectPath", "TopTipInfo")
  self._topTipIcon = self:GetUIComponent("Image", "PowerTipsIcon")
  local aircraftModule = self:GetModule(AircraftModule)
  local room = aircraftModule:GetResRoom()
  local topIDList = {}
  if room then
    table.insert(topIDList, RoleAssetID.RoleAssetDoubleRes)
  end
  table.insert(topIDList, RoleAssetID.RoleAssetPhyPoint)
  if self._hideTopMenu then
    self:GetGameObject("stageTopPool"):SetActive(false)
  else
  end
  local itemCount = #topIDList
  local doubleDropTips = self:GetGameObject("DoubleDropTips")
  doubleDropTips:SetActive(false)
  self._conditionTitleBg2 = self:GetUIComponent("Image", "conditionTitleBg2")
  self._awardTitleBg2 = self:GetUIComponent("Image", "awardTitleBg2")
  self._awardTitleTex = self:GetUIComponent("UILocalizationText", "awardTitleTex")
  self._conditionTitleTex = self:GetUIComponent("UILocalizationText", "conditionTitleTex")
  local buffTips = self:GetUIComponent("UISelectObjectPath", "BuffTips")
  self._buffTips = buffTips:SpawnObject("UIResBuffDetail")
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self._uiSeasonModule = GameGlobal.GetUIModule(SeasonModule)
  self._backBtn = UIWidgetHelper.SpawnObject(self, "btns", "UISeasonTopBtn")
  self._backBtn:SetData(function()
    self:Close()
  end, nil, nil, nil)
  local isTeamRecord = false
  if isTeamRecord then
    local params = {
      {
        "TeamRecordBtn",
        function()
          self:ShowDialog("UIActivityLevelRecordController", self._campComp, self._missionID)
        end
      }
    }
    self._backBtn:SetData_Extra(params)
  end
  self.costGo = self:GetGameObject("cost")
  self.fightBtnTextTr = self:GetUIComponent("RectTransform", "fightBtnText")
  self._backgroundObj = self:GetGameObject("Background")
  self._noDiffAwardGo = self:GetGameObject("NoDiffAward")
  self._seasonAwardGo = self:GetGameObject("SeasonAward")
  self._seasonNormalAwardGo = self:GetGameObject("MultiAwardGroup1")
  self._seasonHardAwardGo = self:GetGameObject("MultiAwardGroup2")
  self._wordAndElem = self:GetUIComponent("UISelectObjectPath", "wordAndElem")
  self._btnIcon = self:GetUIComponent("Image", "powerIcon")
  self.buffLevelGen = self:GetUIComponent("UISelectObjectPath", "BuffLevelArea")
  self.btnWord = self:GetGameObject("btnUnknown")
  self.panelBattleInfoGo = self:GetGameObject("PanelBattleInfo")
  self.panelAwardsInfoGo = self:GetGameObject("PanelAwardsInfo")
  self.wordsContentNormal = self:GetUIComponent("UISelectObjectPath", "WordsNormalContent")
  self.wordsContentHard = self:GetUIComponent("UISelectObjectPath", "WordsHardContent")
  self.wordsNormalGo = self:GetGameObject("WordsNormalScroll")
  self.wordsHardGo = self:GetGameObject("WordsHardScroll")
  self._normalBtnText = self:GetUIComponent("UILocalizationText", "normal")
  self._hardBtnText = self:GetUIComponent("UILocalizationText", "hard")
  self._switchDiffSliderNormalGo = self:GetGameObject("SliderNormal")
  self._switchDiffSliderHardGo = self:GetGameObject("SliderHard")
  self._chapterNormalNameText = self:GetUIComponent("UILocalizationText", "ChapterNameNormal")
  self._chapterHardNameText = self:GetUIComponent("UILocalizationText", "ChapterNameHard")
  self._chapterNameNormalGo = self:GetGameObject("ChapterNameNormal")
  self._chapterNameHardGo = self:GetGameObject("ChapterNameHard")
  self._awardsPanelBtnText = self:GetUIComponent("UILocalizationText", "AwardsPanelBtnText")
  self._battleInfoPanelBtnText = self:GetUIComponent("UILocalizationText", "BattleInfoPanelBtnText")
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnAfterUILayerChanged)
  self._anim = self:GetUIComponent("Animation", "UICanvas")
  self._battleInfoBtn = self:GetGameObject("BattleInfoPanelBtn")
  self._recordGo = self:GetGameObject("Record")
  self._hardMask = self:GetGameObject("hardMask")
  self._normalMask = self:GetGameObject("normalMask")
  self._hardShadow = self:GetUIComponent("Shadow", "hard")
  self._normalShadow = self:GetUIComponent("Shadow", "normal")
  self._hardBtnTr = self:GetUIComponent("RectTransform", "SliderHard")
  self._normalBtnTr = self:GetUIComponent("RectTransform", "SliderNormal")
  self._hardEft = self:GetGameObject("effect")
  self._panelAwardsTipGo = self:GetGameObject("AwardsPanelTip")
  self._panelBattleInfoTipGo = self:GetGameObject("BattleInfoPanelTip")
end

function UISeasonLevelStageS5:OnShow(uiParams)
  GameGlobal.EngineInput().multiTouchEnabled = false
  self._atlas = self:GetAsset("UIStage.spriteatlas", LoadType.SpriteAtlas)
  self._gradeAtlas = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._module = self:GetModule(MissionModule)
  self._missionID = uiParams[1]
  self._rawMissionID = self._missionID
  local missionCfg = Cfg.cfg_season_mission[self._missionID]
  self._isDailyLevel = missionCfg.Type == SeasonEventPointType.DailyLevel
  self._seasonObj = uiParams[2]
  if not self._seasonObj then
    local seasonModule = self:GetModule(SeasonModule)
    if seasonModule then
      self._seasonObj = seasonModule:GetCurSeasonObj()
    end
  end
  self._component = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._componentInfo = self._seasonObj:GetComponentInfo(ECCampaignSeasonComponentID.SEASON_MISSION)
  self._allPassMissionInfo = self._componentInfo.m_pass_mission_info
  self._pointComp = self._seasonObj:GetComponent(ECCampaignSeasonComponentID.ACTION_POINT)
  self._curLevelProgress = 1
  if self._isDailyLevel then
    self._curLevelProgress = self._componentInfo.m_daily_info.m_progress
  end
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  ctx:InitSeasonTeam(self._componentInfo.m_formation_list)
  self._campType = ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON
  self._autoFightShow = true
  self._hideTopMenu = true
  self._hideCost = false
  self._curPanel = UISeasonLevelStagePanelMode.AwardsInfo
  self:_GetComponents()
  self:Init()
  self:_SetStoryBtn()
  self:InitAutoBtnState()
  if self._hideCost then
    self.costGo:SetActive(false)
  else
    self.costGo:SetActive(true)
  end
  self:InitBuffLevelArea()
  self:ShowMainUI(false)
  self._battleInfoBtn:SetActive(not self._isDailyLevel)
  if self._hasMultiDiff and self._missionDiff == UISeasonLevelDiff.Hard then
    self:DispatchEvent(GameEventType.OnSeasonMainBottomEftPlay, true)
    self._hardEft:SetActive(true)
  else
    self._hardEft:SetActive(false)
  end
  self._anim:Play("uieff_UISeasonLevelStageS3_In")
end

function UISeasonLevelStageS5:LoadDataOnEnter(TT, res)
end

function UISeasonLevelStageS5.GetAutoOpenState(matchType, stageId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local playerPrefsKey = pstId .. "AutoOpenState" .. matchType
  if stageId then
    playerPrefsKey = playerPrefsKey .. "_" .. stageId
  end
  return UnityEngine.PlayerPrefs.HasKey(playerPrefsKey)
end

function UISeasonLevelStageS5.SetAutoOpenState(matchType, stageId, isOpen)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local playerPrefsKey = pstId .. "AutoOpenState" .. matchType
  if stageId then
    playerPrefsKey = playerPrefsKey .. "_" .. stageId
  end
  if isOpen then
    UnityEngine.PlayerPrefs.SetInt(playerPrefsKey, 1)
  else
    UnityEngine.PlayerPrefs.DeleteKey(playerPrefsKey)
  end
end

function UISeasonLevelStageS5:_CanAutoFight()
  local tipsStr = ""
  local cfg = Cfg.cfg_global.auto_fight_need_3_star
  if cfg and cfg.StrValue then
    tipsStr = cfg.StrValue
  end
  local missionCfg = Cfg.cfg_season_mission[self._missionID]
  if not missionCfg then
    return false, tipsStr
  end
  local enableParam = missionCfg.EnableSerialAutoFight
  if not enableParam then
    return false
  end
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE then
    return false, tipsStr
  end
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE then
    return true
  end
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK then
    if self._allPassMissionInfo[self._missionID] then
      if self:HasPassThreeStar(missionCfg) then
        return true
      else
        return false, tipsStr
      end
    else
      return false, tipsStr
    end
  end
  return false
end

function UISeasonLevelStageS5:_CanShowAutoFight()
  local missionCfg = Cfg.cfg_season_mission[self._missionID]
  if not missionCfg then
    return false
  end
  local enableParam = missionCfg.EnableSerialAutoFight
  if not enableParam then
    return false
  end
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE then
    return false
  end
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE then
    return true
  end
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK then
    return true
  end
end

function UISeasonLevelStageS5:InitAutoBtnState()
  local enable, msg = self:_CanAutoFight()
  local canShow = self:_CanShowAutoFight()
  self._autoFightShow = canShow
  self._autoBtnEnable = enable
  self._autoBtnMsg = msg
  local autoFight_root = self:GetGameObject("autoFightRoot")
  local autoFight_lock = self:GetGameObject("lock")
  local autoFight_unlock = self:GetGameObject("unlock")
  autoFight_root:SetActive(self._autoFightShow and self._autoBtnEnable)
  local aircraftModule = self:GetModule(AircraftModule)
  local room = aircraftModule:GetResRoom()
  local textId = room and "str_season_mission_info_auto_sweep" or "str_season_mission_info_auto"
  UIWidgetHelper.SetLocalizationText(self, "AutoFightText", StringTable.Get(textId))
  autoFight_lock:SetActive(false)
end

function UISeasonLevelStageS5:_CheckShowWordBuff()
  local missionCfg = Cfg.cfg_season_mission[self._missionID]
  if not missionCfg then
    return false
  end
  if missionCfg.WordBuff and missionCfg.WordBuff > 0 then
  else
    return false
  end
  local checkMissionCfgs = {}
  local missionGroupId = missionCfg.GroupID
  local missionGroupCfgs = Cfg.cfg_season_mission({GroupID = missionGroupId})
  if 0 < #missionGroupCfgs then
    for index, value in ipairs(missionGroupCfgs) do
      if value.OrderID >= missionCfg.OrderID then
        table.insert(checkMissionCfgs, value)
      end
    end
  end
  for index, checkMissionCfgs in ipairs(checkMissionCfgs) do
    if self:HasPassThreeStar(checkMissionCfgs) then
      return true
    end
  end
  return false
end

function UISeasonLevelStageS5:OnHide()
  GameGlobal.EngineInput().multiTouchEnabled = true
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:DetachEvent(GameEventType.DiscoveryInitUIStage, self.Init)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryShowHideChapter, true)
  if self._refreshPowerTimer then
    GameGlobal.Timer():CancelEvent(self._refreshPowerTimer)
    self._refreshPowerTimer = nil
  end
  if self._refreshPowerTask then
    GameGlobal.TaskManager():KillTask(self._refreshPowerTask)
    self._refreshPowerTask = nil
  end
  if self._hasMultiDiff and self._missionDiff == UISeasonLevelDiff.Hard then
    self:DispatchEvent(GameEventType.OnSeasonMainBottomEftPlay, false)
  end
end

function UISeasonLevelStageS5:HasPassThreeStar(missionCfg)
  local missionId = missionCfg.ID
  if not self._allPassMissionInfo[missionId] then
    return false
  end
  local missionFinishInfo = self._allPassMissionInfo[missionId]
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

function UISeasonLevelStageS5:GetSortedArr(awardType, cfg, stageAwardType)
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

function UISeasonLevelStageS5:ProcessAward(missionCfg, noNormal)
  local missionId = missionCfg.ID
  local awards = {}
  local progress = self._curLevelProgress
  local awardCfg = {
    FirstDropId = missionCfg.FirstDropId and missionCfg.FirstDropId[progress],
    PassFixDropId = missionCfg.PassFixDropId and missionCfg.PassFixDropId[progress],
    CPassRandomAward = nil,
    ThreeStarDropId = missionCfg.ThreeStarDropId and missionCfg.ThreeStarDropId[progress]
  }
  if not self:HasPassThreeStar(missionCfg) then
    local awardsStar = self:GetSortedArr(AwardType.ThreeStar, awardCfg, StageAwardType.Star)
    if awardsStar then
      for i, v in ipairs(awardsStar) do
        awards[#awards + 1] = v
      end
    end
  end
  if not self._allPassMissionInfo[missionId] then
    local awardsFirst = self:GetSortedArr(AwardType.First, awardCfg, StageAwardType.First)
    if awardsFirst then
      for i, v in ipairs(awardsFirst) do
        awards[#awards + 1] = v
      end
    end
  end
  if not noNormal then
    local normalArr = self:GetSortedArr(AwardType.Pass, awardCfg, StageAwardType.Normal)
    if normalArr then
      for i, v in ipairs(normalArr) do
        awards[#awards + 1] = v
      end
    end
  end
  return awards
end

function UISeasonLevelStageS5:RefreshAwardsShowState()
  self._noDiffAwardGo = self:GetGameObject("NoDiffAward")
  self._seasonAwardGo = self:GetGameObject("SeasonAward")
  self._seasonNormalAwardGo = self:GetGameObject("MultiAwardGroup1")
  self._seasonHardAwardGo = self:GetGameObject("MultiAwardGroup2")
  self._noDiffAwardGo:SetActive(false)
  self._seasonAwardGo:SetActive(true)
  if self._hasMultiDiff then
    self._seasonNormalAwardGo:SetActive(self._missionDiff == UISeasonLevelDiff.Normal)
    self._seasonHardAwardGo:SetActive(self._missionDiff == UISeasonLevelDiff.Hard)
  else
    self._seasonNormalAwardGo:SetActive(self._missionDiff == UISeasonLevelDiff.Normal)
    self._seasonHardAwardGo:SetActive(self._missionDiff == UISeasonLevelDiff.Hard)
  end
  if self._sr then
    self._sr.horizontalNormalizedPosition = 0
  end
  if self._normalMultiAwardList then
    self._normalMultiAwardList:ResetScrollPos()
  end
  if self._hardMultiAwardList then
    self._hardMultiAwardList:ResetScrollPos()
  end
end

function UISeasonLevelStageS5:RefreshWordsArea()
  if self._hasMultiDiff then
    self.wordsNormalGo:SetActive(self._missionDiff == UISeasonLevelDiff.Normal)
    self.wordsHardGo:SetActive(self._missionDiff == UISeasonLevelDiff.Hard)
  else
    self.wordsNormalGo:SetActive(true)
    self.wordsHardGo:SetActive(false)
  end
end

function UISeasonLevelStageS5:InitWords()
  if self._hasMultiDiff then
    local normalMissionId = self._diffMissonIdMap[UISeasonLevelDiff.Normal]
    local hardMissionId = self._diffMissonIdMap[UISeasonLevelDiff.Hard]
    self:_InitWords(self.wordsContentNormal, normalMissionId)
    self:_InitWords(self.wordsContentHard, hardMissionId)
  else
    self:_InitWords(self.wordsContentNormal, self._missionID)
  end
  self:RefreshWordsArea()
end

function UISeasonLevelStageS5:_InitWords(sop, missionId)
  local missionCfg = Cfg.cfg_season_mission[missionId]
  local wordsTb = {}
  local usedWordIDList = {}
  local buff = missionCfg.BaseWordBuff
  if buff then
    local words = type(buff) == "table" and buff or {buff}
    for _, wordId in ipairs(buff) do
      if not table.icontains(usedWordIDList, wordId) then
        table.insert(wordsTb, self:_GetWordDesc(missionCfg.ID, wordId))
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

function UISeasonLevelStageS5:_GetWordDesc(levelId, wordId)
  local word = Cfg.cfg_word_buff[wordId]
  if not word then
    Log.exception("cfg_word_buff 中找不到词缀:", wordId, "levelId:", levelId)
  end
  local name = StringTable.Get(word.Word[1])
  local desc = StringTable.Get(word.Desc)
  local tex = "【" .. name .. "】 " .. desc
  return tex
end

function UISeasonLevelStageS5:RefreshBtnUnknown()
  local show = self:_CheckShowWordBuff()
  self.btnWord:SetActive(show)
end

function UISeasonLevelStageS5:InitForMultiDiff()
  local missionCfg = Cfg.cfg_season_mission[self._missionID]
  self._hasMultiDiff = false
  self._diffMissonIdMap = {}
  if self._isDailyLevel then
    self._missionDiff = UISeasonLevelDiff.Normal
    self._hasMultiDiff = false
    self._diffMissonIdMap[UISeasonLevelDiff.Normal] = self._missionID
  else
    self._missionDiff = missionCfg.OrderID
    local missionGroupId = missionCfg.GroupID
    self._missionGroupCfgs = Cfg.cfg_season_mission({GroupID = missionGroupId})
    if #self._missionGroupCfgs > 1 then
      self._hasMultiDiff = true
    end
  end
  if self._hasMultiDiff then
    for index, value in ipairs(self._missionGroupCfgs) do
      if value.OrderID == UISeasonLevelDiff.Normal then
        self._diffMissonIdMap[UISeasonLevelDiff.Normal] = value.ID
      elseif value.OrderID == UISeasonLevelDiff.Hard then
        self._diffMissonIdMap[UISeasonLevelDiff.Hard] = value.ID
      end
    end
  end
  self._switchDiffSliderNormalGo:SetActive(self._hasMultiDiff)
  self._switchDiffSliderHardGo:SetActive(self._hasMultiDiff)
  self:RefreshDiffArea()
end

function UISeasonLevelStageS5:RefreshPanelShow()
  self.panelAwardsInfoGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.AwardsInfo)
  self.panelBattleInfoGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.BattleInfo)
  self._panelAwardsTipGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.AwardsInfo)
  self._panelBattleInfoTipGo:SetActive(self._curPanel == UISeasonLevelStagePanelMode.BattleInfo)
end

function UISeasonLevelStageS5:RefreshPanelBg()
end

function UISeasonLevelStageS5:RefreshPanelText()
end

function UISeasonLevelStageS5:RefreshDiffArea()
end

function UISeasonLevelStageS5:InitAllAwards()
  if self._hasMultiDiff then
    local normalRewards = self:_ProcessLevelDiffAwards(self._diffMissonIdMap[UISeasonLevelDiff.Normal], UISeasonLevelDiff.Normal)
    local normalRewardsWithOutPass = self:_ProcessLevelDiffAwards(self._diffMissonIdMap[UISeasonLevelDiff.Normal], UISeasonLevelDiff.Normal, true)
    local hardRewards = self:_ProcessLevelDiffAwards(self._diffMissonIdMap[UISeasonLevelDiff.Hard], UISeasonLevelDiff.Hard)
    local normalMultiAwards = {normalRewards}
    local normalAwardGen = self:GetUIComponent("UISelectObjectPath", "MultiAwardGroup1")
    self._normalMultiAwardList = normalAwardGen:SpawnObject("UISeasonStageMultiAwardListS5")
    self._normalMultiAwardList:SetData(normalMultiAwards)
    local hardMultiAwards = {hardRewards}
    if normalRewardsWithOutPass and 0 < #normalRewardsWithOutPass then
      table.insert(hardMultiAwards, normalRewardsWithOutPass)
    end
    local hardAwardGen = self:GetUIComponent("UISelectObjectPath", "MultiAwardGroup2")
    self._hardMultiAwardList = hardAwardGen:SpawnObject("UISeasonStageMultiAwardListS5")
    self._hardMultiAwardList:SetData(hardMultiAwards)
  else
    local rewards = self:_ProcessLevelDiffAwards(self._missionID, self._missionDiff)
    local multiAwards = {rewards}
    if self._missionDiff == UISeasonLevelDiff.Normal then
      local normalAwardGen = self:GetUIComponent("UISelectObjectPath", "MultiAwardGroup1")
      self._normalMultiAwardList = normalAwardGen:SpawnObject("UISeasonStageMultiAwardListS5")
      self._normalMultiAwardList:SetData(multiAwards)
    elseif self._missionDiff == UISeasonLevelDiff.Hard then
      local hardAwardGen = self:GetUIComponent("UISelectObjectPath", "MultiAwardGroup2")
      self._hardMultiAwardList = hardAwardGen:SpawnObject("UISeasonStageMultiAwardListS5")
      self._hardMultiAwardList:SetData(multiAwards)
    else
      local normalAwardGen = self:GetUIComponent("UISelectObjectPath", "MultiAwardGroup1")
      self._normalMultiAwardList = normalAwardGen:SpawnObject("UISeasonStageMultiAwardListS5")
      self._normalMultiAwardList:SetData(multiAwards)
    end
  end
  self:RefreshAwardsShowState()
  local awardAnimDelay = 0
  self:PlayAnimAwardList(awardAnimDelay)
end

function UISeasonLevelStageS5:PlayAnimAwardList(totalAnimDelay)
  local multiAwardList
  if self._missionDiff == UISeasonLevelDiff.Normal then
    multiAwardList = self._normalMultiAwardList
  elseif self._missionDiff == UISeasonLevelDiff.Hard then
    multiAwardList = self._hardMultiAwardList
  else
    multiAwardList = self._normalMultiAwardList
  end
  if multiAwardList then
    multiAwardList:SetWaitAnim()
    multiAwardList:PlayAnim(totalAnimDelay)
  end
end

function UISeasonLevelStageS5:_ProcessLevelDiffAwards(missionId, levelDiff, noNormal)
  if missionId then
    local useMissionCfg = Cfg.cfg_season_mission[missionId]
    if useMissionCfg then
      local useAwards = self:ProcessAward(useMissionCfg, noNormal)
      if useAwards then
        useAwards.levelDiff = levelDiff
        return useAwards
      end
    end
  end
end

function UISeasonLevelStageS5:Init()
  local missionCfg = Cfg.cfg_season_mission[self._missionID]
  self:InitForMultiDiff()
  self._reach = true
  self._powerID = RoleAssetID.RoleAssetPhyPoint
  self._needPower = missionCfg.NeedPower
  if missionCfg.NeedAP then
    self._powerID = missionCfg.NeedAP[1]
    self._needPower = missionCfg.NeedAP[2]
  end
  local needPowerText = self._needPower
  if self._powerID == RoleAssetID.RoleAssetPhyPoint then
  else
    if not self._pointComp then
      Log.exception("关卡体力为行动点,但没有活动的行动点组件")
    end
    local cmpID = self._pointComp:GetComponentCfgId()
    local pointCfg = self._pointComp:GetActionPointConfig()
    local itemCfg = Cfg.cfg_top_tips[pointCfg.ItemID]
    self._btnIcon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(itemCfg.Icon)
    self._topTipIcon.sprite = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas):GetSprite(itemCfg.Icon)
    local cur, ceil = self._pointComp:GetItemCount()
    if cur < self._needPower then
      needPowerText = "<color=#FF0000>" .. self._needPower .. "</color>"
    end
  end
  self._txtCost:SetText(needPowerText)
  self:RefreshPanelShow()
  self:RefreshPanelText()
  self:InitChapterName()
  self:RefreshThreeStarArea(true, 0)
  self:InitAllAwards()
  self._reachGo = self:GetGameObject("reachGo")
  self._reachGo:SetActive(not self._reach)
  self:InitEnemys()
  self:InitWords()
  self:RefreshRecommendLv()
  self:RefreshAreasTitleStyle()
  self:RefreshWordsArea()
  self:RefreshBtnUnknown()
  self:RefreshPowerTips()
  self:InitAutoBtnState()
  self:_SetStoryBtn()
  self._refreshPowerTargetTime = self._pointComp:GetRegainEndTime()
  self._refreshPowerTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_Countdown()
  end)
  self:_Countdown()
  self._recordGo:SetActive(missionCfg.TeamRecord and missionCfg.TeamRecord == 1)
end

function UISeasonLevelStageS5:UpdateCondition(three_star_condition, conditions)
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

function UISeasonLevelStageS5:AutoFightBtnOnClick()
  if not self._seasonModule:CheckSeasonAndMissionCoseAndJump() then
    return
  end
  if self._autoBtnEnable then
    local id = self._missionID
    local power = self._needPower
    local unlock = true
    local campParams = UISerialAutoFightOptionCampParams:New(self._pointComp, self._campType, nil, 0, self._component:GetCampaignMissionComponentId(), self._component:GetCampaignMissionParamKeyMap())
    local matchType = MatchType.MT_Season
    local params = {
      matchType = matchType,
      stageId = id,
      needPower = power,
      uuid = nil,
      unlock = unlock,
      trackData = nil,
      campParams = campParams,
      toIndex = nil,
      checkFunction = function()
        return self._seasonModule:CheckSeasonAndMissionCoseAndJump()
      end,
      autoFightCallback = function(count)
        self:_DoFight(count)
      end
    }
    self:ShowDialog("UISerialAutoFightOptionNew", params)
  else
    ToastManager.ShowToast(StringTable.Get(self._autoBtnMsg))
  end
end

function UISeasonLevelStageS5:BtnFightOnClick(go)
  self:_DoFight()
end

function UISeasonLevelStageS5:_DoFight(autoFightCount)
  if not self._seasonModule:CheckSeasonAndMissionCoseAndJump() then
    return
  end
  if self._reach == false then
    return
  end
  local missionCfg = Cfg.cfg_season_mission[self._missionID]
  local enough = false
  local roleModule = self:GetModule(RoleModule)
  local cur, ceil = self._pointComp:GetItemCount()
  local leftPower = cur
  local enough = leftPower >= self._needPower
  if not enough then
    if self._powerID == RoleAssetID.RoleAssetPhyPoint then
      self:ShowDialog("UIGetPhyPointController")
    else
      local itemName = StringTable.Get(Cfg.cfg_item[self._powerID].Name)
      ToastManager.ShowToast(StringTable.Get("str_mission_error_power_not_enough", itemName))
    end
    return
  end
  local ctx = self._module:TeamCtx()
  ctx:Init(TeamOpenerType.Season, {
    self._missionID,
    self._component:GetCampaignMissionComponentId(),
    self._component:GetCampaignMissionParamKeyMap(),
    nil,
    self._curLevelProgress
  })
  ctx:ShowDialogUITeams(false, function()
    SerialAutoFightModule.QuickSetData_Campaign(autoFightCount ~= nil, self._campType, MatchType.MT_Season, autoFightCount)
  end)
end

function UISeasonLevelStageS5:IsPowerEnough()
  if self._curStage then
    local roleModule = self:GetModule(RoleModule)
    local leftPower = roleModule:GetAssetCount(RoleAssetID.RoleAssetPhyPoint)
    local enough = leftPower >= self._curStage.need_power
    if not enough and self._module:IsFirstPassMission(self._curStage.id) and self._module:IsMissionFirstPassCanIgnorPower(self._curStage.id) then
      enough = true
    end
    return enough
  end
end

function UISeasonLevelStageS5:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UISeasonLevelStageS5:BgOnClick()
  self:Close()
end

function UISeasonLevelStageS5:ThreeStarTipsBtnOnClick(go)
  self:ShowDialog("UIThreeStarTips")
end

function UISeasonLevelStageS5:BtnUnknownOnClick(go)
  local buffData = {}
  buffData.name = ""
  buffData.des = ""
  local word = Cfg.cfg_word_buff[BattleConst.WordBuffForMission]
  if word and word.BuffID and word.BuffID[1] then
    local buff = Cfg.cfg_buff[word.BuffID[1]]
    if buff then
      buffData.name = StringTable.Get(buff.Name)
      buffData.des = StringTable.Get(buff.Desc)
    end
  end
  local pos = go.transform.position
  self._buffTips:SetData(buffData, pos, Vector3(-250, 160, 0))
  local buffTips = self:GetUIComponent("UISelectObjectPath", "BuffTips")
  self._buffTips = buffTips:SpawnObject("UIResBuffDetail")
end

function UISeasonLevelStageS5:_SetStoryBtn()
  self._activityGroupObj = self:GetGameObject("ActivityGroup")
  self._imgBlack = self:GetGameObject("imgBlack")
  local checkPassMissionId = self._missionID
  local storyList = DiscoveryStoryList:New()
  if self._hasMultiDiff then
    checkPassMissionId = self._diffMissonIdMap[UISeasonLevelDiff.Normal]
  end
  storyList:Init(self._missionID)
  local flag = self._allPassMissionInfo[checkPassMissionId] and storyList:Count() ~= 0 and true or false
  self._activityGroupObj:SetActive(flag)
end

function UISeasonLevelStageS5:BtnPlotOnClick()
  local storyList = DiscoveryStoryList:New()
  storyList:Init(self._missionID)
  self:StartTask(self._TryFixStory, self)
  if storyList then
    if storyList:Count() == 1 then
      local story = storyList.list[1]
      UISeasonHelper.PlayStoryInSeasonScence(story.id)
    else
      local before = storyList:GetStoryByStoryType(StoryTriggerType.BeforeFight)
      local after = storyList:GetStoryByStoryType(StoryTriggerType.AfterFight)
      if not before and not after then
        Log.warn("### no story in curStage", storyList.stageId)
      end
      if before and after then
        self._imgBlack:SetActive(true)
        UISeasonHelper.PlayStoryInSeasonScence(before.id, function()
          self:StartTask(function(TT)
            YIELD(TT)
            UISeasonHelper.PlayStoryInSeasonScence(after.id, function()
              self._imgBlack:SetActive(false)
            end)
          end)
        end)
      else
        do
          local story = storyList.list[1]
          UISeasonHelper.PlayStoryInSeasonScence(story.id)
        end
      end
    end
  end
end

function UISeasonLevelStageS5:SliderHardOnClick()
  if self._hasMultiDiff then
    if self._missionDiff == UISeasonLevelDiff.Hard then
      return
    end
    self:_SwitchDiff()
  end
end

function UISeasonLevelStageS5:SliderNormalOnClick()
  if self._hasMultiDiff then
    if self._missionDiff == UISeasonLevelDiff.Normal then
      return
    end
    self:_SwitchDiff()
  end
end

function UISeasonLevelStageS5:_SwitchDiff()
  if self._hasMultiDiff then
    if self._missionDiff == UISeasonLevelDiff.Normal then
      self._missionDiff = UISeasonLevelDiff.Hard
      self._missionID = self._diffMissonIdMap[UISeasonLevelDiff.Hard]
    elseif self._missionDiff == UISeasonLevelDiff.Hard then
      self._missionDiff = UISeasonLevelDiff.Normal
      self._missionID = self._diffMissonIdMap[UISeasonLevelDiff.Normal]
    end
    self._uiSeasonModule:SetCurrentSeasonLevelDiff(self._missionDiff)
    if self._anim then
      local animName = "uieff_UISeasonLevelStageS3_switch_normal"
      if self._missionDiff == UISeasonLevelDiff.Normal then
        animName = "uieff_UISeasonLevelStageS3_switch_normal"
      elseif self._missionDiff == UISeasonLevelDiff.Hard then
        animName = "uieff_UISeasonLevelStageS3_switch_hard"
      end
      self._anim:Play(animName)
    end
    self:RefreshDiffArea()
    self:RefreshPanelShow()
    self:RefreshPanelText()
    self:RefreshAwardsShowState()
    local awardAnimDelay = 200
    self:PlayAnimAwardList(awardAnimDelay)
    self:RefreshWordsArea()
    self:RefreshBtnUnknown()
    self:RefreshChapter()
    local threeStarAnimTotalDelay = 200
    self:RefreshThreeStarArea(true, threeStarAnimTotalDelay)
    self:RefreshEnemyArea()
    self:RefreshRecommendLv()
    self:RefreshAreasTitleStyle()
    self:RefreshPowerTips()
    self:RefreshPowerCost()
    self:RefreshBuffArea()
    self:InitAutoBtnState()
    self:_SetStoryBtn()
  end
end

function UISeasonLevelStageS5:DiffInfoBtnOnClick(go)
  self:ShowDialog("UISeasonStageDiffTips")
end

function UISeasonLevelStageS5:RefreshPowerTips()
  local contentText = self:GetUIComponent("UILocalizationText", "PowerTipsText")
  local componentInfo = self._pointComp:ComponentInfo()
  local compID = self._pointComp:GetComponetCfgId(componentInfo.m_campaign_id, componentInfo.m_component_id)
  local cfg = self._pointComp:GetActionPointConfig()
  if cfg == nil then
    Log.exception("cfg_component_action_point中找不到组件ID:", compID)
  end
  local cur, ceil = self._pointComp:GetItemCount()
  contentText:SetText(string.format("<color=#ffffff>%s</color>/%s", cur, ceil))
end

function UISeasonLevelStageS5:RefreshPowerCost()
  local needPowerText = self._needPower
  if self._powerID == RoleAssetID.RoleAssetPhyPoint then
  else
    if not self._pointComp then
      Log.exception("关卡体力为行动点,但没有活动的行动点组件")
    end
    local cur, ceil = self._pointComp:GetItemCount()
    if cur < self._needPower then
      needPowerText = "<color=#FF0000>" .. self._needPower .. "</color>"
    end
  end
  self._txtCost:SetText(needPowerText)
end

function UISeasonLevelStageS5:InitChapterName()
  if self._hasMultiDiff then
    local normalMissionId = self._diffMissonIdMap[UISeasonLevelDiff.Normal]
    local hardMissionId = self._diffMissonIdMap[UISeasonLevelDiff.Hard]
    self:_InitChapterName(self._chapterNormalNameText, normalMissionId)
    self:_InitChapterName(self._chapterHardNameText, hardMissionId)
  else
    self:_InitChapterName(self._chapterNormalNameText, self._missionID)
  end
  self:RefreshChapter()
end

function UISeasonLevelStageS5:_InitChapterName(text, missionId)
  local missionCfg = Cfg.cfg_season_mission[missionId]
  if text and missionCfg then
    text:SetText(StringTable.Get(missionCfg.Name))
  end
end

function UISeasonLevelStageS5:RefreshChapter()
  if self._hasMultiDiff then
    self._chapterNameNormalGo:SetActive(self._missionDiff == UISeasonLevelDiff.Normal)
    self._chapterNameHardGo:SetActive(self._missionDiff == UISeasonLevelDiff.Hard)
  else
    self._chapterNameNormalGo:SetActive(true)
    self._chapterNameHardGo:SetActive(false)
  end
end

function UISeasonLevelStageS5:RefreshThreeStarArea(playAnim, animDelay)
  local missionCfg = Cfg.cfg_season_mission[self._missionID]
  local threeStarConditions = {}
  if missionCfg.ShowCondition and missionCfg.ShowCondition == 1 then
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
    if self._allPassMissionInfo[self._missionID] then
      local starCount, completeStarList = self._module:ParseStarInfo(self._allPassMissionInfo[self._missionID].star)
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

function UISeasonLevelStageS5:PlayAnimThreeStarArea(totalAnimDelay)
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

function UISeasonLevelStageS5:InitEnemys()
  if self._hasMultiDiff then
    local normalMissionId = self._diffMissonIdMap[UISeasonLevelDiff.Normal]
    local hardMissionId = self._diffMissonIdMap[UISeasonLevelDiff.Hard]
    self:_InitEnemy(self._enemy_normal, normalMissionId)
    self:_InitEnemy(self._enemy_hard, hardMissionId)
  else
    self:_InitEnemy(self._enemy_normal, self._missionID)
  end
  self:RefreshEnemyArea()
end

function UISeasonLevelStageS5:_InitEnemy(sop, missionId)
  local missionCfg = Cfg.cfg_season_mission[missionId]
  local progress = self._curLevelProgress
  local enemyObj = sop:SpawnObject("UIStageEnemy")
  local recommendAwaken = missionCfg.RecommendAwaken[progress] and missionCfg.RecommendAwaken[progress] or 0
  local recommendLV = missionCfg.RecommendLV[progress] and missionCfg.RecommendLV[progress] or 0
  local color = Color(1, 1, 1, 1)
  local enemyTitleBgSprite, enemyTitleBg2Sprite
  enemyObj:Flush(recommendAwaken, recommendLV, missionCfg.FightLevel[progress] or missionCfg.LevelID, color, enemyTitleBgSprite, enemyTitleBg2Sprite, true, true, true)
end

function UISeasonLevelStageS5:RefreshEnemyArea()
  self._enemyNormalGo = self:GetGameObject("enemy_normal")
  self._enemyHardGo = self:GetGameObject("enemy_hard")
  if self._hasMultiDiff then
    self._enemyNormalGo:SetActive(self._missionDiff == UISeasonLevelDiff.Normal)
    self._enemyHardGo:SetActive(self._missionDiff == UISeasonLevelDiff.Hard)
  else
    self._enemyNormalGo:SetActive(true)
    self._enemyHardGo:SetActive(false)
  end
end

function UISeasonLevelStageS5:RefreshRecommendLv()
  local imgGrade = self:GetUIComponent("Image", "imgGrade")
  local lvText = self:GetUIComponent("UILocalizationText", "RecommendLvText")
  local buffLvText = self:GetUIComponent("UILocalizationText", "RecommendBuffLvText")
  local cfg = Cfg.cfg_season_mission[self._missionID]
  local progress = self._curLevelProgress
  local recommendAwaken = cfg.RecommendAwaken[progress] and cfg.RecommendAwaken[progress] or 0
  local recommendLV = cfg.RecommendLV[progress] and cfg.RecommendLV[progress] or 0
  local recommendBuffLV = cfg.RecommendSeasonBuffLV[progress] and cfg.RecommendSeasonBuffLV[progress] or 0
  imgGrade.sprite = self._gradeAtlas:GetSprite(UIPetModule.GetAwakeSpriteNameByParam(3, recommendAwaken))
  local lvStr = tostring(recommendLV)
  lvText:SetText(lvStr)
  local buffLvStr = tostring(recommendBuffLV)
  buffLvText:SetText(buffLvStr)
end

function UISeasonLevelStageS5:RefreshAreasTitleStyle()
end

function UISeasonLevelStageS5:InitBuffLevelArea()
  self._buffLevelArea = self.buffLevelGen:SpawnObject("UISeasonBuffStageAreaS5")
  if self._buffLevelArea then
    self._buffLevelArea:SetData(self._seasonObj)
  end
end

function UISeasonLevelStageS5:RefreshBuffArea()
  if self._buffLevelArea then
    self._buffLevelArea:RefreshInfo()
  end
end

function UISeasonLevelStageS5:Close()
  self:_CloseDialogWithAnim()
end

function UISeasonLevelStageS5:_CloseDialogWithAnim(callback)
  UIWidgetHelper.PlayAnimation(self, "UICanvas", "uieff_UISeasonLevelStageS3_out", 433, function()
    if callback then
      callback()
    end
    self:_Resume()
    self:ShowMainUI(true)
    self:CloseDialog()
  end)
end

function UISeasonLevelStageS5:_Resume()
  local eventPoint = self._uiSeasonModule:SeasonManager():SeasonMapManager():GetEventPoint(self._rawMissionID)
  if eventPoint then
    eventPoint:InterruptExpress()
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

function UISeasonLevelStageS5:BattleInfoPanelBtnOnClick()
  self._curPanel = UISeasonLevelStagePanelMode.BattleInfo
  self:RefreshPanelShow()
  self:RefreshPanelText()
end

function UISeasonLevelStageS5:AwardsPanelBtnOnClick()
  self._curPanel = UISeasonLevelStagePanelMode.AwardsInfo
  self:RefreshPanelShow()
  self:RefreshPanelText()
end

function UISeasonLevelStageS5:PowerTopTipsOnClick(go)
  self:ShowDialog("UISeasonActionPointTipS5", self._pointComp, go.transform.anchoredPosition)
end

function UISeasonLevelStageS5:_Countdown()
  local now = GetSvrTimeNow()
  local time = self._refreshPowerTargetTime - now
  if time <= 0 then
    if self._refreshPowerTask then
      GameGlobal.TaskManager():KillTask(self._refreshPowerTask)
      self._refreshPowerTask = nil
    end
    self._refreshPowerTask = self:StartTask(self._ReqFlushPower, self)
  end
end

function UISeasonLevelStageS5:_ReqFlushPower(TT)
  local res = AsyncRequestRes:New()
  self._pointComp:HandleActionPointData(TT, res)
  if res:GetSucc() then
    self:RefreshPowerTips()
    self:RefreshPowerCost()
  else
    if self._refreshPowerTimer then
      GameGlobal.Timer():CancelEvent(self._refreshPowerTimer)
      self._refreshPowerTimer = nil
    end
    Log.error("请求刷新行动点失败:", res:GetResult())
  end
end

function UISeasonLevelStageS5:OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self:GetName())
  if topui then
    if self._refreshPowerTask then
      GameGlobal.TaskManager():KillTask(self._refreshPowerTask)
      self._refreshPowerTask = nil
    end
    self._refreshPowerTask = self:StartTask(self._ReqFlushPower, self)
  end
end

function UISeasonLevelStageS5:ShowMainUI(show)
  local controller = GameGlobal.UIStateManager():GetController(UISeasonHelper.CurSeasonSceneUI())
  if controller then
    controller:SetShow(show)
  end
end

function UISeasonLevelStageS5:RecordOnClick(go)
  self:ShowDialog("UIActivityLevelRecordController", self._component, self._missionID)
end

function UISeasonLevelStageS5:_TryFixStory(TT)
  local normalMissionID = self._diffMissonIdMap[UISeasonLevelDiff.Normal]
  if normalMissionID then
    local normalStoryList = DiscoveryStoryList:New()
    normalStoryList:Init(normalMissionID)
    local normalBefore = normalStoryList:GetStoryByStoryType(StoryTriggerType.BeforeFight)
    local normalAfter = normalStoryList:GetStoryByStoryType(StoryTriggerType.AfterFight)
    if normalBefore then
      local active = self._module:IsMissionStoryActive(normalMissionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
      if not active then
        Log.info("开始修正普通关战前剧情数据:", normalMissionID)
        self:_ReqFinishStory(TT, normalMissionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
      else
        Log.info("普通关战前剧情已经看过无需修正", normalMissionID)
      end
    end
    if normalAfter then
      local active = self._module:IsMissionStoryActive(normalMissionID, ActiveStoryType.ActiveStoryType_AfterBattle)
      if not active then
        Log.info("开始修正普通关战后剧情数据:", normalMissionID)
        self:_ReqFinishStory(TT, normalMissionID, ActiveStoryType.ActiveStoryType_AfterBattle)
      else
        Log.info("普通关战后剧情已经看过无需修正", normalMissionID)
      end
    end
  end
  local hardMissionID = self._diffMissonIdMap[UISeasonLevelDiff.Hard]
  if hardMissionID then
    local hardStoryList = DiscoveryStoryList:New()
    hardStoryList:Init(hardMissionID)
    local hardBefore = hardStoryList:GetStoryByStoryType(StoryTriggerType.BeforeFight)
    local hardAfter = hardStoryList:GetStoryByStoryType(StoryTriggerType.AfterFight)
    if hardBefore then
      local active = self._module:IsMissionStoryActive(hardMissionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
      if not active then
        Log.info("开始修正困难关战前剧情数据:", hardMissionID)
        self:_ReqFinishStory(TT, hardMissionID, ActiveStoryType.ActiveStoryType_BeforeBattle)
      else
        Log.info("困难关战前剧情已经看过无需修正", hardMissionID)
      end
    end
    if hardAfter then
      local active = self._module:IsMissionStoryActive(hardMissionID, ActiveStoryType.ActiveStoryType_AfterBattle)
      if not active then
        Log.info("开始修正困难关战后剧情数据:", hardMissionID)
        self:_ReqFinishStory(TT, hardMissionID, ActiveStoryType.ActiveStoryType_AfterBattle)
      else
        Log.info("困难关战后剧情已经看过无需修正", hardMissionID)
      end
    end
  end
end

function UISeasonLevelStageS5:_ReqFinishStory(TT, id, type)
  local res = self._module:SetMissionStoryActive(TT, id, type)
  if res:GetSucc() then
    Log.info("修正剧情数据成功:", id, type)
  else
    Log.info("修正剧情数据失败:", id, type, res:GetResult())
  end
end
