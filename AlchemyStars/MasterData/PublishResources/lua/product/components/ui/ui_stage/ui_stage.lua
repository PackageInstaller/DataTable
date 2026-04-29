_class("UIStage", UIController)
UIStage = UIStage

function UIStage:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._doubleDropValue = campaignModule:GetDoubleDropValue(TT)
  if not self._doubleDropValue then
    self._doubleDropValue = 0
  end
end

function UIStage:_GetComponents()
  self._chapter_normal = self:GetUIComponent("UISelectObjectPath", "chapter_normal")
  self._chapterPool = self._chapter_normal
  self._enemy_normal = self:GetUIComponent("UISelectObjectPath", "enemy_normal")
  self._enemy_activity_tree = self:GetUIComponent("UISelectObjectPath", "enemy_activity_tree")
  self._enemyPool = self._enemy_normal
  self._passRecordObj = self:GetGameObject("PassRecord")
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
  self._toptips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._toptipsInfo = self._toptips:SpawnObject("UITopTipsContext")
  local aircraftModule = self:GetModule(AircraftModule)
  local room = aircraftModule:GetResRoom()
  local cfg_node = Cfg.cfg_waypoint[self._nodeId]
  local topIDList = {}
  local missionCfg = Cfg.cfg_mission_guide[self._nodeId]
  local missionType = Cfg.cfg_mission_chapter({
    MissionID = self._nodeId
  })[1].Type
  if cfg_node then
    if not missionCfg and missionType == 1 then
      self._passRecordObj:SetActive(true)
    end
  else
    if room then
      table.insert(topIDList, RoleAssetID.RoleAssetDoubleRes)
    end
    self._passRecordObj:SetActive(false)
  end
  table.insert(topIDList, RoleAssetID.RoleAssetPhyPoint)
  self.stageTopPool = self:GetUIComponent("UISelectObjectPath", "stageTopPool")
  self.stageTop = self.stageTopPool:SpawnObject("UIStageTop")
  self.stageTop:SetData(topIDList, function(id, go)
    self._toptipsInfo:SetData(id, go)
  end, self._isBetween)
  local itemCount = #topIDList
  self._doublePos = self:GetUIComponent("RectTransform", "DoublePos")
  if itemCount <= 1 then
    self._doublePos.anchoredPosition = Vector2(513, 305)
  else
    self._doublePos.anchoredPosition = Vector2(157.5, 305)
  end
  self._conditionTitleBg2 = self:GetUIComponent("Image", "conditionTitleBg2")
  self._awardTitleBg2 = self:GetUIComponent("Image", "awardTitleBg2")
  self._awardTitleTex = self:GetUIComponent("UILocalizationText", "awardTitleTex")
  self._conditionTitleTex = self:GetUIComponent("UILocalizationText", "conditionTitleTex")
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end)
end

function UIStage:OnShow(uiParams)
  self._isActive = true
  local doubleDropTips = self:GetGameObject("DoubleDropTips")
  doubleDropTips:SetActive(self._doubleDropValue > 0)
  self._atlas = self:GetAsset("UIStage.spriteatlas", LoadType.SpriteAtlas)
  self._autoAltas = self:GetAsset("UIAutoFight.spriteatlas", LoadType.SpriteAtlas)
  self._module = self:GetModule(MissionModule)
  self._data = self._module:GetDiscoveryData()
  self._nodeInfo = nil
  self._curIdx = 0
  self._curStage = nil
  self._nodeId = uiParams[1]
  self._chapterID = uiParams[2]
  local chapter = self._data:GetChapterByChapterId(self._chapterID)
  self._chatperName = chapter.index_name .. StringTable.Get("str_common_colon") .. chapter.name
  local discoverySection = self._data:GetDiscoverySectionByChapterId(self._chapterID)
  self._isBetween = discoverySection.isBetween
  self:_GetComponents()
  self._showRTOffset = Vector2(0, 0)
  self:Init(self._nodeId, uiParams[3])
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryShowHideChapter, false)
  self:InitAutoBtnState()
  self._fightAgain = uiParams[4]
  if self._fightAgain then
    self:btnFightOnClick()
  end
  local jumpData = GameGlobal.GetModule(SerialAutoFightModule):GetJumpData()
  local trackData = jumpData:CreateTrackData_MainLine(self:GetNodeId(), self:GetChapterID(), self:GetReach(), self:GetFightAgain())
  jumpData:Track_Stage(trackData)
  self._trackData = trackData
end

function UIStage.GetAutoOpenState(matchType, stageId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local playerPrefsKey = pstId .. "AutoOpenState" .. matchType
  if stageId then
    playerPrefsKey = playerPrefsKey .. "_" .. stageId
  end
  return UnityEngine.PlayerPrefs.HasKey(playerPrefsKey)
end

function UIStage.SetAutoOpenState(matchType, stageId, isOpen)
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

function UIStage:InitAutoBtnState()
  local matchType = MatchType.MT_Mission
  local param = {
    self._curStage.id
  }
  local out = true
  local enable, msg = self:GetModule(RoleModule):GetAutoFightStatusUI(param, matchType, out)
  self._autoBtnEnable = enable
  self._autoBtnMsg = msg
  local autoFight_root = self:GetGameObject("autoFightRoot")
  local autoFight_lock = self:GetGameObject("lock")
  local autoFight_unlock = self:GetGameObject("unlock")
  autoFight_root:SetActive(true)
  if GameSingle then
    autoFight_root:SetActive(false)
  end
  autoFight_lock:SetActive(not self._autoBtnEnable)
  local aircraftModule = self:GetModule(AircraftModule)
  local room = aircraftModule:GetResRoom()
  local state = room and 2 or 1
  local textId = room and "str_battle_auto_fight_option_btn" or "str_common_auto_fight"
  UIWidgetHelper.SetLocalizationText(self, "_txtAutoFightBtn", StringTable.Get(textId))
  self.btnWord = self:GetGameObject("btnUnknown")
  local show = self:GetModule(RoleModule):CheckWordBuff(param, matchType)
  self.btnWord:SetActive(show)
end

function UIStage:autoFightBtnOnClick()
  if self._autoBtnEnable then
    local id = self._curStage.id
    local power = self._curStage.need_power
    local unlock = self._curStage:HasPassThreeStar()
    local params = {
      matchType = MatchType.MT_Mission,
      stageId = id,
      needPower = power,
      uuid = self.uiid,
      unlock = unlock,
      trackData = self._trackData,
      campParams = nil,
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

function UIStage:OnHide()
  self._isActive = false
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
  self:DetachEvent(GameEventType.DiscoveryInitUIStage, self.Init)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryShowHideChapter, true)
end

function UIStage:InitAwards()
  local awards = self._curStage.awards
  if not awards then
    return
  end
  awards = self:_InsertActivityReward(awards)
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
  sop:SpawnObjects("UIAwardItem", count)
  local list = sop:GetAllSpawnList()
  for i, v in ipairs(list) do
    v:Flush(awards[i])
  end
end

function UIStage:_InitAllAwards()
  self._activity_rewards = {}
  if self._curStage.need_power <= 0 then
    self:InitAwards()
    return
  end
  self:_GetActivityAwardsAndInit()
end

function UIStage:_GetActivityAwardsAndInit()
  self:StartTask(function(TT)
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    local res, rewards = campaignModule:HandleCampaignGetMatchMissionExReward(TT, MatchType.MT_Mission, self._curStage.id)
    if res:GetSucc() then
      local items = {}
      local itemconfig = Cfg.cfg_item
      for i = 1, table.count(rewards) do
        local _data = {}
        _data.id = rewards[i].assetid
        local config = itemconfig[_data.id]
        if config ~= nil then
          _data.icon = config.Icon
          _data.color = config.Color
        end
        _data.type = StageAwardType.Activity
        _data.count = rewards[i].count
        table.insert(items, _data)
      end
      self._activity_rewards = items
    end
    if self._isActive then
      self:InitAwards()
    end
  end, self)
end

function UIStage:_InsertActivityReward(rewards)
  local count = table.count(self._activity_rewards)
  if count <= 0 then
    return rewards
  end
  table.appendArray(self._activity_rewards, rewards)
  return self._activity_rewards
end

function UIStage:Init(nodeId, reach)
  if reach ~= nil then
    self._reach = reach
  end
  self._nodeInfo = self._module:GetNodeDataByNodeId(nodeId)
  self._canPlayStages = self._nodeInfo:GetCanPlayStages()
  local lenStages = table.count(self._canPlayStages)
  if self._canPlayStages and 0 < lenStages then
    self._curIdx = lenStages
    self._curStage = self._canPlayStages[self._curIdx]
    if GameSingle then
      self._curStage.need_power = 0
    end
  end
  local unKnowImgBg, autoImgBg, bgName
  if self._isBetween then
    bgName = "map_guanqia_ludian32"
    unKnowImgBg = "map_guanqia_ludian35"
    autoImgBg = "map_guanqia_ludian34"
  else
    bgName = "map_bantou18_frame"
    unKnowImgBg = "map_guanqia_ludian26"
    autoImgBg = "map_guanqia_ludian27"
  end
  self._bgImg:LoadImage(bgName)
  self._unKnowImg.sprite = self._autoAltas:GetSprite(unKnowImgBg)
  self._autoImg.sprite = self._autoAltas:GetSprite(autoImgBg)
  local stageType = self._nodeInfo:GetStageType()
  local color = Color(1, 1, 1, 1)
  local enemyTitleBgSprite, enemyTitleBg2Sprite
  if stageType == DiscoveryStageType.FightBoss then
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
  self:Flush(self._curIdx)
  self:_InitAllAwards()
  self._reachGo = self:GetGameObject("reachGo")
  self._reachGo:SetActive(not self._reach)
  self._enemyObj = self._enemyPool:SpawnObject("UIStageEnemy")
  self._reLv = self:GetUIComponent("UILocalizationText", "ReLv")
  local recommendAwaken = 0
  local recommendLV = 0
  local cfg_node = Cfg.cfg_waypoint[nodeId]
  if cfg_node then
    recommendAwaken = cfg_node.RecommendAwaken
    recommendLV = cfg_node.RecommendLV
  end
  self._enemyObj:Flush(recommendAwaken, recommendLV, Cfg.cfg_mission[self._curStage.id].FightLevel, color, enemyTitleBgSprite, enemyTitleBg2Sprite, true, true)
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
  self._wordAndElemItem:SetData(Cfg.cfg_mission[self._curStage.id])
end

function UIStage:Flush(idx)
  self._curIdx = idx
  self._curStage = self._canPlayStages[idx]
  local chapterObj = self._chapterPool:SpawnObject("UIStageChapter")
  chapterObj:Flush(self._curStage.stageIdx, self._curStage.name, self._curStage.desc, self._chatperName, self._isBetween)
  self._txtCost.text = tostring(self._curStage.need_power)
  if self._module:Has3StarCondition(self._curStage.id) then
    self._conditionsGo:SetActive(true)
    self._conditionNo:SetActive(false)
    self._sop:SpawnObjects("UIConditionItem", table.count(self._curStage.three_star_condition))
    self._conditions = self._sop:GetAllSpawnList()
    for i, v in ipairs(self._conditions) do
      v:Flush(self._curStage.three_star_condition[i], i)
    end
  else
    self._conditionsGo:SetActive(false)
    self._conditionNo:SetActive(true)
  end
  self._sr.horizontalNormalizedPosition = 0
end

function UIStage:btnFightOnClick(go)
  self:_DoFight()
end

function UIStage:_DoFight(autoFightCount)
  GameGlobal.UAReportForceGuideEvent("UIStageClick", {
    "btnFightOnClick"
  }, true)
  if self._reach == false then
    return
  end
  if not self:IsPowerEnough() then
    self:ShowDialog("UIGetPhyPointController")
    return
  end
  local ctx = self._module:TeamCtx()
  ctx:Init(TeamOpenerType.Stage, self._curStage.id)
  self:Lock("DoEnterTeam")
  ctx:ShowDialogUITeams(false, function()
    SerialAutoFightModule.QuickSetData(autoFightCount ~= nil, MatchType.MT_Mission, autoFightCount)
  end)
end

function UIStage:IsPowerEnough()
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

function UIStage:ShowTips(itemId, pos)
  if not self._tips then
    self._tips = self:GetUIComponent("UISelectObjectPath", "itemTips"):SpawnObject("UISelectInfo")
  end
  self._tips:SetData(itemId, pos)
end

function UIStage:bgOnClick()
  self:CloseDialog()
end

function UIStage:threeStarTipsBtnOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIStageClick", {
    "threeStarTipsBtnOnClick"
  }, true)
  self:ShowDialog("UIThreeStarTips")
end

function UIStage:btnUnknownOnClick(go)
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
  if not self._buffTips then
    local buffTips = self:GetUIComponent("UISelectObjectPath", "BuffTips")
    self._buffTips = buffTips:SpawnObject("UIResBuffDetail")
  end
  self._buffTips:SetData(buffData, pos, Vector3(-250, 160, 0))
end

function UIStage:GetNodeId()
  return self._nodeId
end

function UIStage:GetChapterID()
  return self._chapterID
end

function UIStage:GetReach()
  return self._reach
end

function UIStage:GetFightAgain()
  return self._fightAgain
end

function UIStage:PassRecordOnClick()
  self:Lock("UIStage_PassRecordOnClick")
  self:StartTask(function(TT)
    local missionModule = GameGlobal.GetModule(MissionModule)
    local res, info = missionModule:ReqMissionPassData(TT, self._nodeId)
    if res:GetSucc() then
      if table.count(info) > 0 then
        self:ShowDialog("UIStageRecordController", info)
      else
        ToastManager.ShowToast(StringTable.Get("str_tower_no_record_now"))
      end
      self:UnLock("UIStage_PassRecordOnClick")
    else
      Log.fatal("获取全服通关记录失败")
      self:UnLock("UIStage_PassRecordOnClick")
    end
  end, self)
end
