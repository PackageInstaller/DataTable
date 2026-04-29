_class("UIEliminateLevelController", UIController)
UIEliminateLevelController = UIEliminateLevelController

function UIEliminateLevelController:Constructor()
  self._levelIconTxt = "qdhl_stage_level"
  self._sweepTimeEnough = false
end

function UIEliminateLevelController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIEliminateLevelController:OnShow(uiParams)
  self:AttachEvent(GameEventType.AniPopRefreshRedPoint, self.AniPopRefreshRedPoint)
  self._anipopModule = GameGlobal.GetModule(AnipopModule)
  self._atlas = self:GetAsset("UIStage.spriteatlas", LoadType.SpriteAtlas)
  self._eliminateAtlas = self:GetAsset("UIEliminate.spriteatlas", LoadType.SpriteAtlas)
  self._bGObj = self:GetGameObject("BG")
  self:_GetComponents()
  self:_InitComponents()
  self:_ShowLevel3DEffect()
  self:_CheckGuide()
end

function UIEliminateLevelController:OnHide()
  self:_Dispose3DEffect()
  if self._countTimer then
    GameGlobal.Timer():CancelEvent(self._countTimer)
    self._countTimer = nil
  end
end

function UIEliminateLevelController:_GetComponents()
  local topBarPool = self:GetUIComponent("UISelectObjectPath", "CommonTopBar")
  local topBtns = topBarPool:SpawnObject("UINewCommonTopButton")
  topBtns:SetData(function()
    self:_Close()
  end)
  self._scoreValueTxt = self:GetUIComponent("UILocalizationText", "scoreValueTxt")
  self._exploreValueTxt = self:GetUIComponent("UILocalizationText", "exploreValueTxt")
  self._start = self:GetUIComponent("Image", "Start")
  self._enemyPool = self:GetUIComponent("UISelectObjectPath", "enemy_normal")
  self._roundTxt = self:GetUIComponent("UILocalizationText", "roundTxt")
  self._hpTxt = self:GetUIComponent("UILocalizationText", "HPTxt")
  self._levelModel = self:GetUIComponent("EmptyImage", "levelModel")
  self._content = self:GetUIComponent("UISelectObjectPath", "IntroContent")
  self._contentRect = self:GetUIComponent("RectTransform", "IntroContent")
  self._selectItemInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._selectItemInfo = self._selectItemInfoPool:SpawnObject("UISelectInfo")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._eff = self:GetUIComponent("RawImage", "eff")
  self._screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._noIntroTxtObj = self:GetGameObject("noIntroTxt")
  self._introScrollObj = self:GetGameObject("introScroll")
  self._redPointObj = self:GetGameObject("redPoint")
  self._sweepCost = self:GetUIComponent("UILocalizationText", "sweepCost")
  self._sweepObj = self:GetGameObject("Sweep")
  self._unLock = self:GetGameObject("Unclock")
  self._lock = self:GetGameObject("Lock")
end

function UIEliminateLevelController:_InitComponents()
  local aniPopInfo = self._anipopModule:GetAniPopInfo()
  self._curSeason = aniPopInfo.cur_season
  local roundInfo = aniPopInfo.round_info
  local levelInfo = roundInfo.level_list[roundInfo.mission_index]
  local missionCfg = Cfg.cfg_anipop_fight_level[levelInfo.level_id]
  if not missionCfg then
    Log.exception("cfg_anipop_fight_level 活动关卡未配置：", levelInfo.level_id)
    return
  end
  self._missionID = missionCfg.LevelID
  self._mission_index = roundInfo.mission_index
  local enemyIds = self._anipopModule:GetLevelMonsterList(roundInfo.mission_index)
  if next(enemyIds) then
    local enemyMsg = self._enemyPool:SpawnObject("UIEnemyMsg")
    enemyMsg:SetData(nil, enemyIds, true)
  end
  self._roundTxt:SetText(roundInfo.left_turn)
  self._hpTxt:SetText(math.floor(roundInfo.team_blood * 100) .. "%")
  local weekInfo = aniPopInfo.week_info
  self:InitSweep(missionCfg, roundInfo.left_turn, weekInfo)
  local wordIDs = levelInfo.word_ids
  local wordIDSpawns = {}
  for _, id in pairs(wordIDs) do
    local wordCfg = Cfg.cfg_word_buff[id]
    if wordCfg and not wordCfg.HideUIType then
      table.insert(wordIDSpawns, id)
    end
  end
  if 0 < #wordIDSpawns then
    self._noIntroTxtObj:SetActive(false)
    self._introScrollObj:SetActive(true)
    local wordItems = self._content:SpawnObjects("UIEliminateLevelIntroItem", #wordIDSpawns)
    for i, item in pairs(wordItems) do
      item:SetData(wordIDSpawns[i])
    end
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._contentRect)
  else
    self._noIntroTxtObj:SetActive(true)
    self._introScrollObj:SetActive(false)
  end
  local weekInfo = aniPopInfo.week_info
  if weekInfo then
    local curHardID = aniPopInfo.cur_hard_id
    local hardCfg = Cfg.cfg_anipop_hard[curHardID]
    local scoreHardID = aniPopInfo.week_info.hard_id
    local scoreHardCfg = Cfg.cfg_anipop_hard[scoreHardID]
    local showTotalScore = math.min(weekInfo.total_score, scoreHardCfg.MaxScore)
    self._scoreValueTxt:SetText("<color=#ffffff>" .. showTotalScore .. "</color>/" .. scoreHardCfg.MaxScore)
    local dropMax = hardCfg.DropMax
    if EliminateHelper.IsAniPopUseNewCfg() then
      dropMax = hardCfg.NewDropMax
    end
    self._exploreValueTxt:SetText(weekInfo.search_reward_num .. "/" .. dropMax)
  else
    Log.fatal("weekInfo错误，为空")
  end
  self:InitAllAwards(missionCfg)
  self:CheckAwardRed()
  self:CountDown()
  self._countTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:CountDown()
  end)
end

function UIEliminateLevelController:CountDown()
  local endTime = self._anipopModule.end_time
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if endTime - curTime <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_pet_config_pet_error_faild19"))
    self:SwitchState(UIStateType.UIEliminateController)
    return
  end
end

function UIEliminateLevelController:CheckAwardRed()
  self._redPointObj:SetActive(EliminateHelper.CheckAwardRed())
end

function UIEliminateLevelController:InitAllAwards(missionCfg)
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local awardCfgs = Cfg.cfg_anipop_mission({})
  local weekInfo = anipopInfo.week_info
  local curHardID = anipopInfo.cur_hard_id
  local hardCfg = Cfg.cfg_anipop_hard[curHardID]
  local dropMax = hardCfg.DropMax
  if EliminateHelper.IsAniPopUseNewCfg() then
    dropMax = hardCfg.NewDropMax
  end
  for _, awardCfg in pairs(awardCfgs) do
    if table.icontains(awardCfg.FightLevelArray, missionCfg.ID) then
      if awardCfg.ItemId then
        local sop = self:GetUIComponent("UISelectObjectPath", "Content")
        local item = sop:SpawnObject("UIPopStarRewardItem")
        local isDropMax = dropMax <= weekInfo.search_reward_num
        local itemTxt = isDropMax and "<color=#BB3030>" .. StringTable.Get("str_eliminate_reward_max") .. "</color>" or awardCfg.ItemCount
        local data = {
          awardCfg.ItemId,
          itemTxt
        }
        item:SetData(data, false, 1, function(id, pos)
          self._selectItemInfo:SetData(id, pos)
        end)
      end
      break
    end
  end
end

function UIEliminateLevelController:_ShowLevel3DEffect()
  local numTxt = "qdhl_stage_nub"
  self._ui3DModule = self:CreateUI3DModule()
  self._ui3DModuleID = self:InitUI3DModule(self._ui3DModule, "UIEliminateLevelModel.prefab")
  local ctrlCamera = GameGlobal.UIStateManager():GetControllerCamera("UIEliminateLevelController")
  ctrlCamera.clearFlags = UnityEngine.CameraClearFlags.Depth
  self:Show3DModule(self._ui3DModule, "UIEliminateLevelCamera.prefab", 45, self._levelModel, self:GetDepth(), false, false, false)
  local cubeUIViewObj = self._ui3DModule.gameObject.transform:Find("ModelShow/ShowPlayer/Model/UIEliminateLevelModel").gameObject
  local cubeUIView = cubeUIViewObj:GetComponent(typeof(UIView))
  local levelNum1Sprite = cubeUIView:GetUIComponent("Image", "LevelNum1")
  local levelNum2Sprite = cubeUIView:GetUIComponent("Image", "LevelNum2")
  local levelIconSprite = cubeUIView:GetUIComponent("Image", "LevelIcon")
  local cubeAnim = cubeUIView:GetUIComponent("Animation", "anim")
  local aniPopInfo = self._anipopModule:GetAniPopInfo()
  local roundInfo = aniPopInfo.round_info
  local num1 = math.floor(roundInfo.mission_index / 10)
  local num2 = roundInfo.mission_index % 10
  local levelID = roundInfo.level_list[roundInfo.mission_index].level_id
  local fightType = self:_LevelTypeCount(Cfg.cfg_anipop_fight_level[levelID].FightType)
  levelNum1Sprite.sprite = self._eliminateAtlas:GetSprite(numTxt .. num1)
  levelNum2Sprite.sprite = self._eliminateAtlas:GetSprite(numTxt .. num2)
  levelIconSprite.sprite = self._eliminateAtlas:GetSprite(self._levelIconTxt .. fightType)
  self:Lock("UIEliminateLevelController:_ShowLevel3DEffect")
  self:StartTask(function(TT)
    YIELD(TT, 2000)
    if not tolua.isnull(cubeAnim) then
      cubeAnim:Stop()
      cubeAnim:Play("uieff_EliminateLeve_mofang_idle")
      self:CheckUnselectRelics()
    end
    self:UnLock("UIEliminateLevelController:_ShowLevel3DEffect")
  end)
end

function UIEliminateLevelController:_Dispose3DEffect()
  local ctrlCamera = GameGlobal.UIStateManager():GetControllerCamera("UIEliminateLevelController")
  ctrlCamera.clearFlags = UnityEngine.CameraClearFlags.Nothing
  self:Hide3DModule(self._ui3DModule)
  self:Dispose3DModule(self._ui3DModule, self._ui3DModuleID)
end

function UIEliminateLevelController:FettersOnClick(go)
  local seasonCfg = Cfg.cfg_anipop_season[self._curSeason]
  self:ShowDialog("UIEliminateFettersController", seasonCfg.FettersId)
end

function UIEliminateLevelController:TotalScoreOnClick(go)
  self:ShowDialog("UIEliminateAwardController")
end

function UIEliminateLevelController:StartOnClick(go)
  local formationInfo = self._anipopModule:GetFormationInfo()
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  ctx:Init(TeamOpenerType.AniPopStar, {
    self._missionID,
    nil,
    self._mission_index,
    self._curSeason
  })
  ctx:InitAniPopStarTeam(formationInfo)
  ctx:ShowDialogUITeams(true)
end

function UIEliminateLevelController:BagOnClick(go)
  local aniPopInfo = self._anipopModule:GetAniPopInfo()
  if #aniPopInfo.relic_info.relics <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_eliminate_no_relic"))
    return
  end
  self:ShowDialog("UIRugueLikeBackpackController", false, TeamOpenerType.AniPopStar)
end

function UIEliminateLevelController:SupportCampOnClick(go)
  local seasonCfg = Cfg.cfg_anipop_season[self._curSeason]
  self:ShowDialog("UIEliminateSupportCampController", seasonCfg.FettersId)
end

function UIEliminateLevelController:_Close()
  self:StartTask(function(TT)
    self._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local rt = self._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    YIELD(TT)
    self._eff.texture = rt
    self:Lock("uieff_UIEliminateLevelController_out")
    self._anim:Play("uieff_UIEliminateLevelController_out")
    YIELD(TT, 500)
    self:UnLock("uieff_UIEliminateLevelController_out")
    self:SwitchState(UIStateType.UIEliminateController)
  end)
end

function UIEliminateLevelController:_LevelTypeCount(type)
  local typeNum = 1
  if type == 1 then
    typeNum = 1
  elseif type == 2 then
    typeNum = 3
  elseif type == 3 then
    typeNum = 2
  end
  return typeNum
end

function UIEliminateLevelController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIEliminateLevelController)
end

function UIEliminateLevelController:SweepOnClick(go)
  if self.SweepLock then
    ToastManager.ShowToast(StringTable.Get("str_eliminate_sweep_unlock"))
    return
  end
  if not self._sweepTimeEnough then
    ToastManager.ShowToast(StringTable.Get("str_eliminate_sweep_noturn_tip"))
  end
  self:_StartSweep()
end

function UIEliminateLevelController:_StartSweep()
  self:StartTask(function(TT)
    local duration = UISerialAutoFightConst.GetSweepDuration()
    YIELD(TT, duration)
    local matchType = MatchType.MT_PopStarPro
    local stageId = self._mission_index
    local sweepTimes = 1
    local gameMatchModule = GameGlobal.GetModule(GameMatchModule)
    gameMatchModule:Start_MatchSweep(matchType, stageId, sweepTimes, 0, {}, function(res, matchResult)
      if res:GetSucc() then
        local aniPopInfo = self._anipopModule:GetAniPopInfo()
        self._curSeason = aniPopInfo.cur_season
        local roundInfo = aniPopInfo.round_info
        if roundInfo.left_turn <= 0 then
          GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateController, true)
        else
          ToastManager.ShowToast(StringTable.Get("str_eliminate_sweep_end") .. self.score)
          self:CheckUnselectRelics()
        end
      end
    end)
  end)
end

function UIEliminateLevelController:InitSweep(missionCfg, leftTurn, weekInfo)
  local SweepCfg = self:GetSweepCfgData(missionCfg)
  local list = weekInfo.sweep_list
  local hard = SweepCfg.HardId
  self.score = SweepCfg.BaseScore
  self.SweepLock = true
  for _, v in ipairs(list) do
    if v == hard then
      self.SweepLock = false
      break
    end
  end
  if not self.SweepLock and SweepCfg.EnableSweep == 1 then
    self._unLock:SetActive(true)
    self._lock:SetActive(false)
    self.SweepLock = false
    local cost = SweepCfg.SweepCost
    self._sweepCost:SetText(cost)
    if leftTurn < cost then
      self._sweepCost.color = Color(1, 0, 0)
      self._sweepTimeEnough = false
    else
      self._sweepCost.color = Color(1, 1, 1)
      self._sweepTimeEnough = true
    end
  else
    if SweepCfg.EnableSweep == 0 then
      self._sweepObj:SetActive(false)
    end
    self._unLock:SetActive(false)
    self._lock:SetActive(true)
    self.SweepLock = true
  end
end

function UIEliminateLevelController:GetSweepCfgData(missionCfg)
  local aniPopInfo = self._anipopModule:GetAniPopInfo()
  local roundInfo = aniPopInfo.round_info
  local awardCfgs = Cfg.cfg_anipop_mission({
    HardId = roundInfo.select_hard_id
  })
  for _, awardCfg in pairs(awardCfgs) do
    if table.icontains(awardCfg.FightLevelArray, missionCfg.ID) then
      return awardCfg
    end
  end
end

function UIEliminateLevelController:RefrshData()
  self:_InitComponents()
  self:_ShowLevel3DEffect()
  self:_CheckGuide()
end

function UIEliminateLevelController:CheckUnselectRelics()
  local relicInfo = self._anipopModule._anipopInfo.relic_info
  local danglingRelics = relicInfo.dangling_relics
  local skillRelics = relicInfo.skill_dangling_relics
  if table.count(skillRelics) > 0 then
    self:ShowDialog("UIEliminateChooseSkillController", nil, skillRelics)
  elseif table.count(danglingRelics) > 0 then
    self:ShowDialog("UIEliminateChooseCardController", nil, danglingRelics)
  end
end

function UIEliminateLevelController:AniPopRefreshRedPoint()
  self:CheckAwardRed()
end
