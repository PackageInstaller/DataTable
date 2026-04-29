_class("UIActivityLevelStageNew", UIController)
UIActivityLevelStageNew = UIActivityLevelStageNew

function UIActivityLevelStageNew:_GetComponents()
  local chapter_normal = self:GetUIComponent("UISelectObjectPath", "chapter_normal")
  local chapter_new = self:GetUIComponent("UISelectObjectPath", "chapter_new")
  if self._useNewTitle then
    self._chapterPool = chapter_new
  else
    self._chapterPool = chapter_normal
  end
  self._enemy_normal = self:GetUIComponent("UISelectObjectPath", "enemy_normal")
  self._enemy_activity_tree = self:GetUIComponent("UISelectObjectPath", "enemy_activity_tree")
  self._enemyPool = self._enemy_normal
  self._sop = self:GetUIComponent("UISelectObjectPath", "conditions")
  self._conditionsGo = self:GetGameObject("conditions")
  self._conditionNo = self:GetGameObject("conditionNo")
  self._sr = self:GetUIComponent("ScrollRect", "ScrollView")
  self._txtCost = self:GetUIComponent("UILocalizationText", "txtCost")
  self._bgImg = self:GetUIComponent("RawImageLoader", "bgImg")
  self._unKnowImg = self:GetUIComponent("Image", "btnUnknown")
  self._autoImg = self:GetUIComponent("Image", "autoImg")
  self:AttachEvent(GameEventType.DiscoveryInitUIStage, self.Init)
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
  self._toptips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._toptipsInfo = self._toptips:SpawnObject("UITopTipsContext")
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
    self:GetGameObject("stageTopPool"):SetActive(true)
    self.stageTopPool = self:GetUIComponent("UISelectObjectPath", "stageTopPool")
    self.stageTop = self.stageTopPool:SpawnObject("UIStageTop")
    self.stageTop:SetData(topIDList, function(id, go)
      self._toptipsInfo:SetData(id, go)
    end, self._isBetween)
  end
  local itemCount = #topIDList
  self._doublePos = self:GetUIComponent("RectTransform", "DoublePos")
  if itemCount <= 1 then
    self._doublePos.anchoredPosition = Vector2(513, 305)
  else
    self._doublePos.anchoredPosition = Vector2(157.5, 305)
  end
  local doubleDropTips = self:GetGameObject("DoubleDropTips")
  doubleDropTips:SetActive(false)
  self._conditionTitleBg2 = self:GetUIComponent("Image", "conditionTitleBg2")
  self._awardTitleBg2 = self:GetUIComponent("Image", "awardTitleBg2")
  self._awardTitleTex = self:GetUIComponent("UILocalizationText", "awardTitleTex")
  self._conditionTitleTex = self:GetUIComponent("UILocalizationText", "conditionTitleTex")
  local buffTips = self:GetUIComponent("UISelectObjectPath", "BuffTips")
  self._buffTips = buffTips:SpawnObject("UIResBuffDetail")
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end)
  self.costGo = self:GetGameObject("cost")
  self.fightBtnTextTr = self:GetUIComponent("RectTransform", "fightBtnText")
end

function UIActivityLevelStageNew:OnShow(uiParams)
  self._atlas = self:GetAsset("UIStage.spriteatlas", LoadType.SpriteAtlas)
  self._autoAltas = self:GetAsset("UIAutoFight.spriteatlas", LoadType.SpriteAtlas)
  self._module = self:GetModule(MissionModule)
  self._missionID = uiParams[1]
  self._missionFinishInfo = uiParams[2]
  self._campComp = uiParams[3]
  self._autoFightShow = uiParams[4]
  self._pointComp = uiParams[5]
  self._hideTopMenu = uiParams[6] or false
  self._hideCost = uiParams[7] or false
  self._useBgName = uiParams[8] or false
  self._useNewTitle = uiParams[9] or false
  self._isChess = uiParams[10] or false
  self._showAwakenTips = uiParams[11] or false
  self._checkCampaignClose = uiParams[12]
  if self._campComp then
    local cmpID = self._campComp:GetComponentCfgId()
    local camModule = self:GetModule(CampaignModule)
    local campID, _, _ = camModule:ParseCfgComponentID(cmpID)
    local campConfig = Cfg.cfg_campaign[campID]
    if campConfig then
      self._campType = campConfig.CampaignType
    end
  end
  self:_GetComponents()
  self:Init()
  self:_SetStoryBtn()
  self:InitAutoBtnState()
  if self._hideCost then
    self.costGo:SetActive(false)
    self.fightBtnTextTr.anchoredPosition = Vector2(0, 6)
  else
    self.costGo:SetActive(true)
    self.fightBtnTextTr.anchoredPosition = Vector2(-71, 6)
  end
end

function UIActivityLevelStageNew.GetAutoOpenState(matchType, stageId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local playerPrefsKey = pstId .. "AutoOpenState" .. matchType
  if stageId then
    playerPrefsKey = playerPrefsKey .. "_" .. stageId
  end
  return UnityEngine.PlayerPrefs.HasKey(playerPrefsKey)
end

function UIActivityLevelStageNew.SetAutoOpenState(matchType, stageId, isOpen)
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

function UIActivityLevelStageNew:_CanAutoFight()
  local tipsStr = ""
  local cfg = Cfg.cfg_global.auto_fight_need_pass
  if cfg and cfg.StrValue then
    tipsStr = cfg.StrValue
  end
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    return false, tipsStr
  end
  local enableParam = missionCfg.EnableSerialAutoFight
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE then
    return false, tipsStr
  end
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE then
    return true
  end
  if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK then
    if self._missionFinishInfo then
      return true
    else
      return false, tipsStr
    end
  end
  return false
end

function UIActivityLevelStageNew:InitAutoBtnState()
  local matchType = MatchType.MT_Campaign
  local param = {
    self._missionID
  }
  local enable, msg = self:_CanAutoFight()
  self._autoBtnEnable = enable
  self._autoBtnMsg = msg
  local autoFight_root = self:GetGameObject("autoFightRoot")
  local autoFight_lock = self:GetGameObject("lock")
  local autoFight_unlock = self:GetGameObject("unlock")
  autoFight_root:SetActive(self._autoFightShow)
  autoFight_lock:SetActive(not self._autoBtnEnable)
  self.btnWord = self:GetGameObject("btnUnknown")
  local show = self:_CheckShowWordBuff()
  self.btnWord:SetActive(show)
end

function UIActivityLevelStageNew:_CheckShowWordBuff()
  if self._isChess then
    return false
  end
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not missionCfg then
    return false
  end
  if missionCfg.WordBuff and missionCfg.WordBuff > 0 then
  else
    return false
  end
  if not self._missionFinishInfo then
    return false
  end
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if not self:HasPassThreeStar(missionCfg) then
    return false
  end
  return true
end

function UIActivityLevelStageNew:autoFightBtnOnClick()
  if self._autoBtnEnable then
    local id = self._missionID
    local power = self._needPower
    local unlock = true
    local campParams = UISerialAutoFightOptionCampParams:New(self._pointComp, self._campType, nil, 0, self._campComp:GetCampaignMissionComponentId(), self._campComp:GetCampaignMissionParamKeyMap())
    local matchType = MatchType.MT_Campaign
    local params = {
      matchType = matchType,
      stageId = id,
      needPower = power,
      uuid = nil,
      unlock = unlock,
      trackData = nil,
      campParams = campParams,
      toIndex = nil,
      checkFunction = nil,
      autoFightCallback = function(count)
        self:_DoFight(count)
      end
    }
    self:ShowDialog("UISerialAutoFightOption", params)
  else
    ToastManager.ShowToast(StringTable.Get(self._autoBtnMsg))
  end
end

function UIActivityLevelStageNew:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:DetachEvent(GameEventType.DiscoveryInitUIStage, self.Init)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryShowHideChapter, true)
end

function UIActivityLevelStageNew:HasPassThreeStar(missionCfg)
  if not self._missionFinishInfo then
    return false
  end
  if missionCfg.ThreeStarCondition1 and self._missionFinishInfo.star & 1 == 0 then
    return false
  end
  if missionCfg.ThreeStarCondition2 and self._missionFinishInfo.star & 2 == 0 then
    return false
  end
  if missionCfg.ThreeStarCondition3 and self._missionFinishInfo.star & 4 == 0 then
    return false
  end
  return true
end

function UIActivityLevelStageNew:GetSortedArr(awardType, cfg, stageAwardType)
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

function UIActivityLevelStageNew:ProcessAward(missionCfg)
  local awards = {}
  if not self:HasPassThreeStar(missionCfg) then
    local awardsStar = self:GetSortedArr(AwardType.ThreeStar, missionCfg, StageAwardType.Star)
    if awardsStar then
      for i, v in ipairs(awardsStar) do
        awards[#awards + 1] = v
      end
    end
  end
  if not self._missionFinishInfo then
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

function UIActivityLevelStageNew:InitAllAwards(missionCfg)
  local awards = self:ProcessAward(missionCfg)
  if not awards then
    return
  end
  local count = table.count(awards)
  local grid = self:GetUIComponent("GridLayoutGroup", "Content")
  local contentSizeFilter = self:GetUIComponent("ContentSizeFitter", "Content")
  local contentRect = self:GetUIComponent("RectTransform", "Content")
  if 6 < count then
    grid.childAlignment = UnityEngine.TextAnchor.MiddleLeft
    contentSizeFilter.enabled = true
  else
    grid.childAlignment = UnityEngine.TextAnchor.MiddleCenter
    contentSizeFilter.enabled = false
  end
  contentRect.localPosition = Vector3(0, 0, 0)
  local sop = self:GetUIComponent("UISelectObjectPath", "Content")
  sop:SpawnObjects("UIAwardItem", count)
  local list = sop:GetAllSpawnList()
  for i, v in ipairs(list) do
    v:Flush(awards[i])
  end
end

function UIActivityLevelStageNew:Init()
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if self._isChess then
    missionCfg = Cfg.cfg_chess_mission[self._missionID]
  end
  self._reach = true
  self._powerID = RoleAssetID.RoleAssetPhyPoint
  self._needPower = missionCfg.NeedPower
  local needPowerText = self._needPower
  self._txtCost.text = tostring(needPowerText)
  local unKnowImgBg, autoImgBg, bgName
  if self._useBgName then
    bgName = self._useBgName
  else
    bgName = "event_plot_di2"
  end
  unKnowImgBg = "map_guanqia_ludian26"
  autoImgBg = "map_guanqia_ludian27"
  self._bgImg:LoadImage(bgName)
  self._unKnowImg.sprite = self._autoAltas:GetSprite(unKnowImgBg)
  self._autoImg.sprite = self._autoAltas:GetSprite(autoImgBg)
  local color = Color(1, 1, 1, 1)
  local enemyTitleBgSprite, enemyTitleBg2Sprite
  if missionCfg.Type == ActivityMissionType.FightBoss then
    color = Color(0.21176470588235294, 0.21176470588235294, 0.21176470588235294, 1)
    self._awardTitleBg2.sprite = self._atlas:GetSprite("map_bantou15_frame")
    self._conditionTitleBg2.sprite = self._atlas:GetSprite("map_bantou15_frame")
    enemyTitleBgSprite = self._atlas:GetSprite("map_guanqia_tiao3")
    enemyTitleBg2Sprite = self._atlas:GetSprite("map_bantou15_frame")
  else
    color = Color(0.21176470588235294, 0.21176470588235294, 0.21176470588235294, 1)
    self._awardTitleBg2.sprite = self._atlas:GetSprite("map_bantou15_frame")
    self._conditionTitleBg2.sprite = self._atlas:GetSprite("map_bantou15_frame")
    enemyTitleBgSprite = self._atlas:GetSprite("map_bantou4_frame")
    enemyTitleBg2Sprite = self._atlas:GetSprite("map_bantou15_frame")
  end
  self._awardTitleTex.color = color
  self._conditionTitleTex.color = color
  self:Flush(missionCfg)
  self:InitAllAwards(missionCfg)
  self._reachGo = self:GetGameObject("reachGo")
  self._reachGo:SetActive(not self._reach)
  self._enemyObj = self._enemyPool:SpawnObject("UIStageEnemy")
  local recommendAwaken = missionCfg.RecommendAwaken and missionCfg.RecommendAwaken or 0
  local recommendLV = missionCfg.RecommendLV and missionCfg.RecommendLV or 0
  self._enemyObj:Flush(recommendAwaken, recommendLV, missionCfg.FightLevel or missionCfg.LevelID, color, enemyTitleBgSprite, enemyTitleBg2Sprite, self._isChess or self._showAwakenTips, true)
  self._reLv = self:GetUIComponent("UILocalizationText", "ReLv")
  local tex = StringTable.Get("str_discovery_node_recommend_lv")
  if recommendAwaken and 0 < recommendAwaken then
    tex = tex .. " " .. StringTable.Get("str_pet_config_common_advance") .. recommendAwaken
  end
  if recommendLV then
    tex = tex .. " LV." .. recommendLV
  end
  self._reLv:SetText(tex)
  self._wordAndElem = self:GetUIComponent("UISelectObjectPath", "wordAndElem")
  self._wordAndElemItem = self._wordAndElem:SpawnObject("UIWordAndElemItem")
  self._wordAndElemItem:SetData(missionCfg)
end

function UIActivityLevelStageNew:UpdateCondition(three_star_condition, conditions)
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

function UIActivityLevelStageNew:Flush(missionCfg)
  local chapterObj = self._chapterPool:SpawnObject("UIStageChapter")
  chapterObj:Flush(nil, StringTable.Get(missionCfg.Name), StringTable.Get(missionCfg.Desc), StringTable.Get(missionCfg.Title), false)
  local threeStarConditions = {}
  if missionCfg.IgnoreThreeStar == 0 then
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
    if self._missionFinishInfo then
      local starCount, completeStarList = self._module:ParseStarInfo(self._missionFinishInfo.star)
      self:UpdateCondition(threeStarConditions, completeStarList)
    end
  end
  if self._campComp:GetComponentType() == CampaignComType.E_CAMPAIGN_COM_TREE_MISSION then
    self._conditionsGo:SetActive(false)
    self._conditionNo:SetActive(false)
  elseif 0 < #threeStarConditions then
    self._conditionsGo:SetActive(true)
    self._conditionNo:SetActive(false)
    self._sop:SpawnObjects("UIConditionItem", #threeStarConditions)
    self._conditions = self._sop:GetAllSpawnList()
    for i, v in ipairs(self._conditions) do
      v:Flush(threeStarConditions[i], i)
    end
  else
    self._conditionsGo:SetActive(false)
    self._conditionNo:SetActive(true)
  end
  self._sr.horizontalNormalizedPosition = 0
end

function UIActivityLevelStageNew:btnFightOnClick(go)
  if self._checkCampaignClose and self._checkCampaignClose() then
    self:CloseDialog()
    return
  end
  self:_DoFight()
end

function UIActivityLevelStageNew:_DoFight(autoFightCount)
  if self._reach == false then
    return
  end
  if self._isChess then
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIBattleStart)
    self:Lock("DoEnterMatch")
    local game = GameGlobal.GetModule(GameMatchModule)
    local matchType = MatchType.MT_Chess
    local teamId = 1
    local parmas = {}
    table.insert(parmas, self._missionID)
    table.insert(parmas, ECampaignMissionComponentId.ECampaignMissionComponentId_ChessMission)
    table.insert(parmas, self._campComp:GetCampaignMissionParamKeyMap())
    local createInfo = game:GetMatchCreateInfo(matchType, parmas)
    self:StartTask(function(TT)
      local res = game:StartMatchTask(TT, matchType, teamId, createInfo)
      if not res:GetSucc() then
        ToastManager.ShowToast(game:GetErrorMsg(res:GetResult()))
        self:SwitchState(UIStateType.UIMain)
        self:UnLock("DoEnterMatch")
      else
        self:UnLock("DoEnterMatch")
      end
    end, self)
    return
  end
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  local enough = false
  local roleModule = self:GetModule(RoleModule)
  local leftPower = roleModule:GetAssetCount(self._powerID)
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
  ctx:Init(TeamOpenerType.Campaign, {
    self._missionID,
    self._campComp:GetCampaignMissionComponentId(),
    self._campComp:GetCampaignMissionParamKeyMap()
  })
  self:Lock("DoEnterTeam")
  ctx:ShowDialogUITeams(false, function()
    SerialAutoFightModule.QuickSetData_Campaign(autoFightCount ~= nil, self._campType, MatchType.MT_Campaign, autoFightCount)
  end)
end

function UIActivityLevelStageNew:IsPowerEnough()
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

function UIActivityLevelStageNew:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIActivityLevelStageNew:bgOnClick()
  self:CloseDialog()
end

function UIActivityLevelStageNew:threeStarTipsBtnOnClick(go)
  self:ShowDialog("UIThreeStarTips")
end

function UIActivityLevelStageNew:btnUnknownOnClick(go)
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

function UIActivityLevelStageNew:_SetStoryBtn()
  self._activityGroupObj = self:GetGameObject("ActivityGroup")
  self._imgBlack = self:GetGameObject("imgBlack")
  local storyList = DiscoveryStoryList:New()
  storyList:Init(self._missionID)
  local flag = self._missionFinishInfo and storyList:Count() ~= 0 and true or false
  self._activityGroupObj:SetActive(flag)
end

function UIActivityLevelStageNew:btnPlotOnClick()
  local storyList = DiscoveryStoryList:New()
  storyList:Init(self._missionID)
  if storyList then
    if storyList:Count() == 1 then
      local story = storyList.list[1]
      self:ShowDialog("UIStoryController", story.id)
    else
      local before = storyList:GetStoryByStoryType(StoryTriggerType.BeforeFight)
      local after = storyList:GetStoryByStoryType(StoryTriggerType.AfterFight)
      if not before and not after then
        Log.warn("### no story in curStage", storyList.stageId)
      end
      if before and after then
        self._imgBlack:SetActive(true)
        self:ShowDialog("UIStoryController", before.id, function()
          self:StartTask(function()
            YIELD(TT)
            self:ShowDialog("UIStoryController", after.id, function()
              self._imgBlack:SetActive(false)
            end)
          end)
        end)
      else
        do
          local story = storyList.list[1]
          self:ShowDialog("UIStoryController", story.id)
        end
      end
    end
  end
end
