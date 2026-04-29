_class("UISeasonMazeWorldBossDetailPopUp", UIController)
UISeasonMazeWorldBossDetailPopUp = UISeasonMazeWorldBossDetailPopUp

function UISeasonMazeWorldBossDetailPopUp:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeWorldBossDetailPopUp:OnShow(uiParams)
  self.ElementSpriteName = {
    [ElementType.ElementType_Blue] = "bing_color",
    [ElementType.ElementType_Red] = "huo_color",
    [ElementType.ElementType_Green] = "sen_color",
    [ElementType.ElementType_Yellow] = "lei_color"
  }
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.isPreview = uiParams[1]
  self:InitWidget()
  self:InitUI()
end

function UISeasonMazeWorldBossDetailPopUp:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self.atkBossScore = self:GetUIComponent("UILocalizationText", "AtkBossScore")
  self.bossName = self:GetUIComponent("UILocalizationText", "BossName")
  self.elemtIcon = self:GetUIComponent("Image", "ElemtIcon")
  self.boss_Icon = self:GetUIComponent("RawImageLoader", "Boss_Icon")
  self.lessUseCountText = self:GetUIComponent("UILocalizationText", "LessUseCountText")
  self.battleCountText = self:GetUIComponent("UILocalizationText", "BattleCountText")
  self.lock = self:GetGameObject("lock")
  self.tipsPool = self:GetUIComponent("UISelectObjectPath", "TipsPool")
  self.closeDetailPopBtn = self:GetGameObject("CloseDetailPopBtn")
  self.closeDetailPopBtn:SetActive(false)
  self.detailPop = self:GetGameObject("DetailPop")
  self.detailPop:SetActive(false)
  self.lessImg = self:GetGameObject("lessImg")
  self.unPassTextObj = self:GetGameObject("UnPassText")
end

function UISeasonMazeWorldBossDetailPopUp:InitUI()
  self._module = GameGlobal.GetModule(SeasonMazeModule)
  local seasonObj = self._module:CurSeasonObj()
  self.comInfo = seasonObj:GetMazeComponent():GetComponentInfo()
  self.worldBossInfo = self.comInfo.m_world_boss_info
  if self.worldBossInfo.total_damage == 0 then
    self.atkBossScore:SetText(StringTable.Get("str_season_maze_world_boss_no_score"))
  else
    local showNum = HelperProxy:GetInstance():SMazeDamageUnit(self.worldBossInfo.total_damage)
    self.atkBossScore:SetText(showNum)
  end
  if 0 < #self.worldBossInfo.word_ids then
    self.wordPools = self.tipsPool:SpawnObjects("UISeasonMazeWorldBossTipsItem", #self.worldBossInfo.word_ids)
    for i = 1, #self.wordPools do
      local item = self.wordPools[i]
      local word = self.worldBossInfo.word_ids[i]
      local wordCfg = Cfg.cfg_word_buff[word]
      local wordstr = wordCfg.Desc
      item:SetData(wordstr)
    end
  else
    local singleWord = self.tipsPool:SpawnObject("UISeasonMazeWorldBossTipsItem")
    singleWord:SetData("str_season_maze_world_boss_no_word")
  end
  local component = seasonObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  local ms = component:GetAttrValue(SeasonMazeAttrType.SMAT_Ms)
  self.lessUseCountText:SetText(StringTable.Get("str_season_maze_world_boss_less_use_count", ms))
  self._comCfgID = component:GetComponentCfgId()
  self._cfg_global = Cfg.cfg_component_season_maze_global[self._comCfgID]
  local rangeList = self._cfg_global.WorldBossMSRange
  local getIndex = 1
  for i = 1, #rangeList do
    local lessNum = rangeList[i][1]
    local topNum = rangeList[i][2]
    if ms >= lessNum and ms <= topNum then
      getIndex = i
    end
  end
  local topHighNum = rangeList[#rangeList][2]
  if ms > topHighNum then
    getIndex = #rangeList
  end
  local turnNum = self._cfg_global.WorldBossRound[getIndex]
  self.battleCountText:SetText(StringTable.Get("str_season_maze_world_boss_battle_count", turnNum))
  local missionCfg = Cfg.cfg_season_maze_mission[self.worldBossInfo.cfg_id]
  local monsterIDs = UICommonHelper:GetInstance():GetOptimalEnemys(missionCfg.FightLevel)
  local bossid = monsterIDs[1]
  self.curBossID = bossid
  local cfg_monster = Cfg.cfg_monster[bossid]
  if not cfg_monster then
    Log.error("###[UISeasonMazeSelectDifficultyPopup] cfg_monster is nil ! id :", showBoss)
  end
  local cfg_monster_class = Cfg.cfg_monster_class[cfg_monster.ClassID]
  if not cfg_monster_class then
    Log.error("###[UISeasonMazeSelectDifficultyPopup] cfg_monster_class is nil ! id:", cfg_monster.ClassID)
  end
  local head = cfg_monster_class.StaticBody
  self.boss_Icon:LoadImage(head)
  self.bossName:SetText(StringTable.Get(cfg_monster_class.Name))
  self.elemtIcon.sprite = self.atlasProperty:GetSprite(self.ElementSpriteName[cfg_monster.ElementType])
  if self.isPreview then
    self.lock:SetActive(true)
    self.lessImg:SetActive(false)
    self.unPassTextObj:SetActive(true)
    self.lessUseCountText.gameObject:SetActive(false)
    self.battleCountText.gameObject:SetActive(false)
  else
    self.lock:SetActive(false)
    self.lessImg:SetActive(true)
    self.unPassTextObj:SetActive(false)
    self.lessUseCountText.gameObject:SetActive(true)
    self.battleCountText.gameObject:SetActive(true)
  end
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._sample = self._seasonMazeModule:GetCurSample()
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._component = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._componentInfo = self._component:GetComponentInfo()
  self._progressComponent = self._seasonMazeObj:GetComponent(ECCampaignSeasonMazeComponentID.TOTAL_PROCESS)
  self._endTime = self._sample.end_time
end

function UISeasonMazeWorldBossDetailPopUp:CheckSeasonMazeClosed()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local endTime = self._endTime
  if curTime > endTime then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_state_over"))
    return true
  else
    return false
  end
end

function UISeasonMazeWorldBossDetailPopUp:BgOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self:CloseDialog()
end

function UISeasonMazeWorldBossDetailPopUp:CardBagBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UISeasonMazeBackPackController", 1)
end

function UISeasonMazeWorldBossDetailPopUp:AutoBagBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UISeasonMazeBead")
end

function UISeasonMazeWorldBossDetailPopUp:RankBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UISeasonMazeWorldBossRankingList")
end

function UISeasonMazeWorldBossDetailPopUp:BattleBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  if self.isPreview then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_world_boss_click_tips1"))
    return
  end
  local missionModule = self:GetModule(MissionModule)
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local ctx = missionModule:TeamCtx()
  local seasonMazeObj = seasonMazeModule:CurSeasonObj()
  local componentInfo = seasonMazeObj:GetComponentInfo(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  ctx:InitSeasonMazeTeam(componentInfo.m_formation_list)
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local params = cpt:GetCampaignMissionParamKeyMap()
  ctx:Init(TeamOpenerType.SeasonMaze, {
    0,
    componentInfo.m_world_boss_info.cfg_id,
    ECampaignMissionComponentId.ECampaignMissionComponentId_SeasonMaze,
    params,
    false
  })
  ctx:ShowDialogUITeams()
end

function UISeasonMazeWorldBossDetailPopUp:CloseBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self:CloseDialog()
end

function UISeasonMazeWorldBossDetailPopUp:LookBossBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  local ids = {}
  ids[1] = self.curBossID
  self:ShowDialog("UIEnemyTip", ids, 1)
end

function UISeasonMazeWorldBossDetailPopUp:LittlePopBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self.closeDetailPopBtn:SetActive(true)
  self.detailPop:SetActive(true)
end

function UISeasonMazeWorldBossDetailPopUp:DetailBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UISeasonMazeWorldBossTipsPopUp", "str_season_maze_world_boss_title_name", "str_season_maze_world_boss_help_detail")
end

function UISeasonMazeWorldBossDetailPopUp:CloseDetailPopBtnOnClick(go)
  if self:CheckSeasonMazeClosed() then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    seasonMazeModule:UIModule():ExitTo(UIStateType.UIMain)
    return
  end
  self.closeDetailPopBtn:SetActive(false)
  self.detailPop:SetActive(false)
end
