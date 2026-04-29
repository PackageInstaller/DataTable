_class("UIActivityHardStage", UIController)
UIActivityHardStage = UIActivityHardStage

function UIActivityHardStage:_GetComponents()
  self._txtTitleIdx = self:GetUIComponent("UILocalizationText", "txtTitleIdx")
  self._enemy_normal = self:GetUIComponent("UISelectObjectPath", "enemy_normal")
  self._enemyPool = self._enemy_normal
  self._sr = self:GetUIComponent("ScrollRect", "ScrollView")
  self._bgImg = self:GetUIComponent("RawImageLoader", "bgImg")
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end)
  self._awardTitleTex = self:GetUIComponent("UILocalizationText", "awardTitleTex")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._tips = s:SpawnObject("UISelectInfo")
end

function UIActivityHardStage:OnShow(uiParams)
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
  if self._campComp then
    local cmpID = self._campComp:GetComponentCfgId()
    local camModule = self:GetModule(CampaignModule)
    local campID, comp_id, com_type = camModule:ParseCfgComponentID(cmpID)
    local campConfig = Cfg.cfg_campaign[campID]
    if campConfig then
      self._campType = campConfig.CampaignType
    end
  end
  self:_GetComponents()
  self:Init()
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UIActivityHardStage:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UIActivityHardStage:Flush(missionCfg)
  self._txtTitleIdx.text = StringTable.Get(missionCfg.Name)
end

function UIActivityHardStage:Init()
  local missionCfg = Cfg.cfg_campaign_mission[self._missionID]
  if self._isChess then
    missionCfg = Cfg.cfg_chess_mission[self._missionID]
  end
  self._powerID = RoleAssetID.RoleAssetPhyPoint
  self._needPower = missionCfg.NeedPower
  local color = Color(1, 1, 1, 1)
  local enemyTitleBgSprite, enemyTitleBg2Sprite
  if missionCfg.Type == ActivityMissionType.FightBoss then
    color = Color(0.21176470588235294, 0.21176470588235294, 0.21176470588235294, 1)
    enemyTitleBgSprite = self._atlas:GetSprite("map_guanqia_tiao3")
    enemyTitleBg2Sprite = self._atlas:GetSprite("map_bantou15_frame")
  else
    color = Color(0.21176470588235294, 0.21176470588235294, 0.21176470588235294, 1)
    enemyTitleBgSprite = self._atlas:GetSprite("map_bantou4_frame")
    enemyTitleBg2Sprite = self._atlas:GetSprite("map_bantou15_frame")
  end
  self._bgImg:LoadImage("n11_gqxq_di12")
  self:Flush(missionCfg)
  self:InitAllAwards(missionCfg)
  self._enemyObj = self._enemyPool:SpawnObject("UIStageEnemyNew")
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
  self._hintContent = self:GetUIComponent("UISelectObjectPath", "hintContent")
  local word_tb = {}
  local buff = missionCfg.BaseWordBuff
  if buff then
    for _, wordId in ipairs(buff) do
      table.insert(word_tb, self:_GetWordDesc(missionCfg.ID, wordId))
    end
    self._hintContent:SpawnObjects("UIWordNew", #word_tb)
    local pools = self._hintContent:GetAllSpawnList()
    for i = 1, #pools do
      local item = pools[i]
      item:SetData(word_tb[i].tex, word_tb[i].desc)
    end
  end
end

function UIActivityHardStage:_GetWordDesc(levelId, wordId)
  local word = Cfg.cfg_word_buff[wordId]
  if not word then
    Log.exception("cfg_word_buff 中找不到词缀:", wordId, "levelId:", levelId)
  end
  local name = StringTable.Get(word.Word[1])
  local desc = StringTable.Get(word.Desc)
  local tex = "【" .. name .. "】"
  return {tex = tex, desc = desc}
end

function UIActivityHardStage:GetSortedArr(awardType, cfg, stageAwardType)
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

function UIActivityHardStage:ProcessAward(missionCfg)
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

function UIActivityHardStage:HasPassThreeStar(missionCfg)
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

function UIActivityHardStage:InitAllAwards(missionCfg)
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

function UIActivityHardStage:ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIActivityHardStage:BtnFightOnClick(go)
  self:_DoFight()
end

function UIActivityHardStage:_DoFight(autoFightCount)
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
  ctx:ShowDialogUITeams(false, function()
    SerialAutoFightModule.QuickSetData_Campaign(autoFightCount ~= nil, self._campType, MatchType.MT_Campaign, autoFightCount)
  end)
end

function UIActivityHardStage:BgOnClick()
  self:CloseDialog()
end
