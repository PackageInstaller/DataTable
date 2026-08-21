_class("UISeasonMazeRoomStage", UIController)
UISeasonMazeRoomStage = UISeasonMazeRoomStage

function UISeasonMazeRoomStage:LoadDataOnEnter(TT, res, uiParams)
end

function UISeasonMazeRoomStage:_GetComponents()
  self.enemy_activity_tree = self:GetUIComponent("UISelectObjectPath", "enemy_activity_tree")
  local tipsPool = self:GetUIComponent("UISelectObjectPath", "tips")
  self._tips = tipsPool:SpawnObject("UISelectInfo")
  self.rewardPool = self:GetUIComponent("UISelectObjectPath", "Content")
  self.sr = self:GetUIComponent("ScrollRect", "ScrollView")
  self.autoMS = self:GetUIComponent("UILocalizationText", "autoMS")
  self.normalRoot = self:GetGameObject("normalRoot")
  self.bossRoot = self:GetGameObject("bossRoot")
  self.autoFightBtn = self:GetGameObject("autoFightBtn")
  self._fightAgainText = self:GetUIComponent("UILocalizationText", "FighltAgainText")
  self._fightAgainCost = self:GetGameObject("FightAgainCost")
  self._normalTitle = self:GetUIComponent("UILocalizationText", "normalTitle")
  self._bossTilte = self:GetUIComponent("UILocalizationText", "bossTilte")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._specialDesc = self:GetUIComponent("UILocalizationText", "specialDesc")
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowTips)
end

function UISeasonMazeRoomStage:OnShow(uiParams)
  self:_GetComponents()
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.seasonMazeObj = self.seasonMazeModule:CurSeasonObj()
  self.component = self.seasonMazeObj:GetMazeComponent()
  self.cmptInfo = self.seasonMazeObj:GetComponentInfo(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self.cmptId = self.seasonMazeObj:GetMazeComponent():GetComponentCfgId()
  self.nodeID = 0
  if uiParams then
    self.nodeID = uiParams[1]
    self.roomInfo = self.cmptInfo.rooms[self.nodeID]
  end
  self.isBoss = self.cmptInfo.cur_state == SeasonMazeActionState.SMAS_BossBattle
  self.normalRoot:SetActive(not self.isBoss)
  self.bossRoot:SetActive(self.isBoss)
  self.autoFightBtn:SetActive(not self.isBoss)
  local hardLevel = self.cmptInfo.hard
  local bossInfos = self.cmptInfo.boss_info
  local bossIndex = 1
  for i = 0, table.count(bossInfos) - 1 do
    local info = bossInfos[i]
    if info.do_cnt ~= -1 then
      break
    end
    bossIndex = bossIndex + 1
  end
  self.seasonMazeCfg = self:GetSeasonMazeCfg(hardLevel)
  self.curBoosInfo = bossInfos[bossIndex - 1]
  self._bossFailed = 0 < self.curBoosInfo.do_cnt
  if self.isBoss and self._bossFailed then
    self._fightAgainCost:SetActive(true)
    local need = Cfg.cfg_component_season_maze_global[self.cmptId].BossMS
    local have = self.component:GetAttrValue(SeasonMazeAttrType.SMAT_Ms)
    local text
    if need >= have then
      text = "<color=#ff0000>" .. need .. "</color>/" .. have
      self._msEnough = false
    else
      text = need .. "/" .. have
      self._msEnough = true
    end
    self._fightAgainText:SetText(text)
  else
    self._fightAgainCost:SetActive(false)
  end
  local titleStr = "str_season_maze_room_name_battle"
  local descStr = "str_season_maze_room_name_battle_desc"
  if self.isBoss then
    if bossIndex == table.count(bossInfos) then
      titleStr = "str_season_maze_room_name_ultboss"
      descStr = "str_season_maze_room_name_ultboss_desc"
    else
      titleStr = "str_season_maze_room_name_boss"
      descStr = "str_season_maze_room_name_boss_desc"
    end
    self._bossTilte:SetText(StringTable.Get(titleStr))
  else
    self._normalTitle:SetText(StringTable.Get(titleStr))
  end
  self._desc:SetText(StringTable.Get(descStr))
  self:InitRewards(bossIndex)
  self:InitMissionInfo()
  self:ShowLeaveBtn()
  if self.isBoss then
    self:Lock("UISeasonMazeRoomStage_EnterAni")
    self:StartTask(function(TT)
      YIELD(TT, 500)
      self:UnLock("UISeasonMazeRoomStage_EnterAni")
      self:_CheckGuide()
    end)
  end
end

function UISeasonMazeRoomStage:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUIShare.UISeasonMazeRoomStage)
end

function UISeasonMazeRoomStage:ShowLeaveBtn()
  local leave = self:GetUIComponent("UISelectObjectPath", "UISMazeRoomLeaveBtn")
  local btn = leave:SpawnObject("UISMazeRoomLeaveBtn")
  btn:SetData(function()
    self:OnlyHideUI()
  end)
end

function UISeasonMazeRoomStage:OnlyHideUI()
  self.seasonMazeModule:UIModule():SetTempRoom(self:GetName())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTempCloseRoom, true)
  self:CloseDialog()
end

function UISeasonMazeRoomStage:GetSeasonMazeCfg(hardLevel)
  local cfgs = Cfg.cfg_component_season_maze({
    ComponentID = self.cmptId
  })
  if cfgs and table.count(cfgs) > 0 then
    for _, v in pairs(cfgs) do
      if v.Hard == hardLevel then
        return v
      end
    end
  end
  return nil
end

function UISeasonMazeRoomStage:InitMsShow()
  local fightSweep = self.component:GetAttrValue(SeasonMazeAttrType.SMAT_Fight_Sweep)
  if fightSweep ~= 1 then
    self.autoFightBtn:SetActive(false)
    return
  end
  self.curMs = self.component:GetAttrValue(SeasonMazeAttrType.SMAT_Ms)
  self.autoMS:SetText(self.curMs .. "/" .. self.missionCfg.AutoMS)
end

function UISeasonMazeRoomStage:InitRewards(bossIndex)
  local rewardID
  if self.isBoss then
    if self.seasonMazeCfg.BossReward then
      rewardID = self.seasonMazeCfg.BossReward[bossIndex]
    end
  elseif self.seasonMazeCfg.CommonReward then
    rewardID = self.seasonMazeCfg.CommonReward[bossIndex]
  end
  if not rewardID or rewardID == 0 then
    return
  end
  local rewardCfg = Cfg.cfg_component_season_maze_mission_reward[rewardID]
  local rewardList = {}
  for _, id in ipairs(rewardCfg.EffectIDs) do
    SeasonMazeTool:GetInstance():GetEffectObject(id, rewardList)
  end
  self.rewardPool:SpawnObjects("UISeasonMazeItem", #rewardList)
  local spwanList = self.rewardPool:GetAllSpawnList()
  for i = 1, #rewardList do
    local effect = rewardList[i]
    spwanList[i]:SetData(effect, self._tips, 0.8)
  end
end

function UISeasonMazeRoomStage:InitMissionInfo()
  local enemyMsg = self.enemy_activity_tree:SpawnObject("UIEnemyMsg")
  self.missionId = nil
  self.wordIdList = nil
  local waveRandoms
  if self.isBoss then
    self.missionId = self.curBoosInfo.cfg_id
    self.wordIdList = self.curBoosInfo.word_ids
    waveRandoms = table.cloneconf(self.curBoosInfo.wave_randoms)
  else
    self.missionId = self.roomInfo.cfg_id
    self.wordIdList = self.roomInfo.word_ids
    waveRandoms = table.cloneconf(self.roomInfo.wave_randoms)
  end
  local cfgs = Cfg.cfg_season_maze_mission({
    SeasonMazeMissionId = self.missionId
  })
  if cfgs and 0 < #cfgs then
    self.missionCfg = cfgs[1]
    local level = self.missionCfg.FightLevel
    if self.isBoss then
      enemyMsg:SetData(level)
    else
      local enemyIds = GameGlobal.GetModule(SeasonMazeModule):GetLevelMonsterList(level, waveRandoms)
      if next(enemyIds) then
        enemyMsg:SetData(nil, enemyIds)
      end
    end
    self:InitMsShow()
  else
    Log.exception("Cfg.cfg_season_maze_mission got a nil id -->", self.missionId)
  end
  local str = ""
  for i = 1, #self.wordIdList do
    local v = self.wordIdList[i]
    local cfg_word = Cfg.cfg_word_buff[v]
    if cfg_word and not cfg_word.HideUIType then
      local name = StringTable.Get(cfg_word.Word[1])
      local desc = StringTable.Get(cfg_word.Desc)
      str = str .. "【" .. name .. "】" .. "\n" .. desc
      if i ~= #self.wordIdList then
        str = str .. "\n"
      end
    end
  end
  self._specialDesc:SetText(str)
end

function UISeasonMazeRoomStage:AutoFightBtnOnClick()
  if self.curMs < self.missionCfg.AutoMS then
    ToastManager.ShowToast(StringTable.Get("str_season_maze_ms_insufficient"))
    return
  end
  GameGlobal.TaskManager():StartTask(self.OnReqAutoFight, self)
end

function UISeasonMazeRoomStage:OnReqAutoFight(TT)
  local res = AsyncRequestRes:New()
  self:Lock("UISeasonMazeRoomStage:OnReqAutoFight")
  self._response = self.component:HandleSeasonMazeBattle(TT, res)
  self:UnLock("UISeasonMazeRoomStage:OnReqAutoFight")
  if res and res:GetSucc() then
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, SeasonMazeAttrType.SMAT_Ms)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonMazeRoomOperationFinish, self._response.reward)
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeRoomStage] HandleSeasonMazeBattle fail ! result : ", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeRoomStage:BtnFightOnClick()
  self:_DoFight()
end

function UISeasonMazeRoomStage:_DoFight()
  if self.isBoss and self._bossFailed and not self._msEnough then
    local title = StringTable.Get("str_season_maze_boss_attack_tip_1")
    UISeasonMazeModule.PopMsgBox("", title, SeasonMazeMsgBoxType.Ok, function()
      self:ShowDialog("UISeasonMazeCompleteResult")
    end, nil, function()
    end, nil)
    return
  else
    self:_Fight()
  end
end

function UISeasonMazeRoomStage:_Fight()
  GameGlobal.UAReportForceGuideEvent("UIStageClick", {
    "btnFightOnClick"
  }, true)
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  ctx:InitSeasonMazeTeam(self.cmptInfo.m_formation_list)
  local cpt = GameGlobal.GetModule(SeasonMazeModule):CurSeasonObj():GetMazeComponent()
  local params = cpt:GetCampaignMissionParamKeyMap()
  ctx:Init(TeamOpenerType.SeasonMaze, {
    self.nodeID,
    self.missionId,
    ECampaignMissionComponentId.ECampaignMissionComponentId_SeasonMaze,
    params,
    false
  })
  ctx:ShowDialogUITeams()
end
