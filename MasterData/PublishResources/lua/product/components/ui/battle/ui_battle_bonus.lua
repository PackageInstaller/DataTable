_class("UIBattleBonus", UIController)
UIBattleBonus = UIBattleBonus

function UIBattleBonus:OnShow(uiParams)
  local match = self:GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  if not enterData then
    Log.fatal("enterData为空，可能是进局内时断线重登，matchmodule reset了，导致enterdata丢失，此时应该处于force switch login ui状态，直接返回即可")
    return
  end
  if MatchType.MT_Mission == enterData._match_type then
    local mission = self:GetModule(MissionModule)
    local missionID = enterData:GetMissionCreateInfo().mission_id
    local infos = {}
    if mission:Has3StarCondition(missionID) then
      local allStarConditions = ConfigServiceHelper.GetMission3StarCondition(missionID)
      if allStarConditions and 0 < #allStarConditions then
        infos = self:_ShowMission3StarConditionBonusUI(allStarConditions, missionID)
      else
        self:_ShowMissionNo3StarBonusUI(missionID)
      end
    end
  elseif MatchType.MT_ExtMission == enterData._match_type then
    local extMission = self:GetModule(ExtMissionModule)
    local matchCreateData = enterData:GetMissionCreateInfo()
    local detailExtTask = extMission:UI_GetExtTaskDetail(matchCreateData.m_nExtMissionID, matchCreateData.m_nExtTaskID)
    local infos = {}
    for i = 1, #detailExtTask.m_vecCondition do
      local finish = detailExtTask.m_vecCondition[i].m_bPass
      local text
      local conditionId = detailExtTask.m_vecCondition[i].m_nID
      local showProgress = Cfg.cfg_threestarcondition[conditionId].ShowProgress
      local progress
      if showProgress then
        progress = BattleStatHelper.Get3StarProgress(conditionId)
      end
      local checkComplete = detailExtTask.m_vecCondition[i].m_bPass
      if progress then
        text = i .. ".  " .. detailExtTask.m_vecCondition[i].m_stDest .. "  " .. progress
      else
        text = i .. ".  " .. detailExtTask.m_vecCondition[i].m_stDest
      end
      infos[i] = {text = text, finish = checkComplete}
    end
    self:GetGameObject("TaskInfo"):SetActive(true)
    self:GetUIComponent("UILocalizationText", "win_cond"):SetText(StringTable.Get("str_battle_info_victory_condition") .. "      " .. ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
    local condText = {
      self:GetUIComponent("UILocalizationText", "star1_cond"),
      self:GetUIComponent("UILocalizationText", "star2_cond"),
      self:GetUIComponent("UILocalizationText", "star3_cond")
    }
    local yellowStars = {
      self:GetGameObject("star_yellow1"),
      self:GetGameObject("star_yellow2"),
      self:GetGameObject("star_yellow3")
    }
    local whiteStars = {
      self:GetGameObject("star_white1"),
      self:GetGameObject("star_white2"),
      self:GetGameObject("star_white3")
    }
    for i, info in ipairs(infos) do
      condText[i]:SetText(info.text)
      if info.finish then
        yellowStars[i]:SetActive(true)
        whiteStars[i]:SetActive(false)
      else
        yellowStars[i]:SetActive(false)
        whiteStars[i]:SetActive(true)
      end
    end
  elseif MatchType.MT_ResDungeon == enterData._match_type then
    self:GetGameObject("TaskInfo_res"):SetActive(true)
    self:GetUIComponent("UILocalizationText", "win_cond_res"):SetText(StringTable.Get("str_battle_info_victory_condition") .. "      " .. ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
  elseif MatchType.MT_Maze == enterData._match_type then
    self:GetGameObject("TaskInfo_maze"):SetActive(true)
    local mazeMD = self:GetModule(MazeModule)
    local mazeRoom = mazeMD:GetCurrentRoom()
    local cfgName = StringTable.Get(Cfg.cfg_maze_room[mazeRoom.room_id].Title[1])
    self:GetUIComponent("UILocalizationText", "maze_name"):SetText(cfgName)
    self:GetUIComponent("UILocalizationText", "win_cond_maze"):SetText(StringTable.Get("str_battle_info_victory_condition") .. "      " .. ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
  elseif MatchType.MT_SeasonMaze == enterData._match_type then
    self:GetGameObject("TaskInfo_res"):SetActive(true)
    self:GetUIComponent("UILocalizationText", "win_cond_res"):SetText(StringTable.Get("str_battle_info_victory_condition") .. "      " .. ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
  elseif MatchType.MT_Tower == enterData._match_type then
    self:GetGameObject("TaskInfo_tower"):SetActive(true)
    local tModule = self:GetModule(TowerModule)
    local matchInfo = tModule:GetMatchInfo()
    local tCfg = Cfg.cfg_tower_detail[matchInfo.nId]
    local name = tModule:GetTowerName(tCfg.Type)
    local cfgName = StringTable.Get("str_tower_tower_layer", name, tCfg.stage)
    self:GetUIComponent("UILocalizationText", "tower_name"):SetText(cfgName)
    self:GetUIComponent("UILocalizationText", "win_cond_tower"):SetText(StringTable.Get("str_battle_info_victory_condition") .. "      " .. ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
  elseif MatchType.MT_Chess == enterData._match_type then
    local mission = self:GetModule(MissionModule)
    local campaign = self:GetModule(CampaignModule)
    local missionID = enterData:GetChessInfo().mission_id
    local infos = {}
    if campaign:Has3StarCondition(missionID) then
      infos = self:_GetChessMission3StarInfo(missionID)
    end
    self:GetGameObject("TaskInfo"):SetActive(true)
    self:GetUIComponent("UILocalizationText", "win_cond"):SetText(ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
    local condText, yellowStars, whiteStars = self:GetMission3StarUIComponents()
    for i, info in ipairs(infos) do
      condText[i]:SetText(info.text)
      if info.finish then
        yellowStars[i]:SetActive(true)
        whiteStars[i]:SetActive(false)
      else
        yellowStars[i]:SetActive(false)
        whiteStars[i]:SetActive(true)
      end
    end
  elseif MatchType.MT_MiniMaze == enterData._match_type then
    self:GetGameObject("TaskInfo_tower"):SetActive(true)
    local matchInfo = enterData:GetMissionCreateInfo()
    local cfg = Cfg.cfg_component_bloodsucker({
      CampaignMissionID = matchInfo.mission_id
    })
    local cfgName = StringTable.Get(cfg[1].MissionName)
    self:GetUIComponent("UILocalizationText", "tower_name"):SetText(cfgName)
    self:GetUIComponent("UILocalizationText", "win_cond_tower"):SetText(StringTable.Get("str_battle_info_victory_condition") .. "      " .. ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
  elseif MatchType.MT_PopStar == enterData._match_type then
    local createInfo = enterData:GetMissionCreateInfo()
    if not createInfo.is_challenge then
      do
        local allStarConditions = ConfigServiceHelper.GetPopStar3StarCondition(createInfo.mission_id)
        if allStarConditions and 0 < #allStarConditions then
          self:_ShowMission3StarConditionBonusUI(allStarConditions, createInfo.mission_id)
        else
        end
      end
    end
  elseif MatchType.MT_PopStarPro == enterData:GetMatchType() then
    local createInfo = enterData:GetMissionCreateInfo()
    local cfgName = StringTable.Get(Cfg.cfg_anipop_mission[createInfo.mission_id].Name)
    self:GetUIComponent("UILocalizationText", "maze_name"):SetText(cfgName)
    self:GetUIComponent("UILocalizationText", "win_cond_maze"):SetText(StringTable.Get("str_battle_info_victory_condition") .. "      " .. ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
  end
  local anim = self:GetUIComponent("Animation", "UIBattleStart")
  self._player = EZTL_Player:New()
  local tl = EZTL_Sequence:New({
    EZTL_PlayAnimation:New(anim, anim.clip.name),
    EZTL_Callback:New(function()
      self.timeEvent = nil
      self:CloseDialog()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnClickUIBonusInfo)
    end)
  }, "战斗开始ui动效")
  self._player:Play(tl)
end

function UIBattleBonus:_GetChessMission3StarInfo(missionID)
  local infos = {}
  local mission = GameGlobal.GetModule(MissionModule)
  local allStarConditions = ConfigServiceHelper.GetChessMission3StarCondition(missionID)
  for i = 1, #allStarConditions do
    local text
    local showProgress = Cfg.cfg_threestarcondition[allStarConditions[i]].ShowProgress
    local cur3StarProgress = BattleStatHelper.Get3StarProgress(allStarConditions[i])
    local cur3StarMatchResult = BattleStatHelper.GetBonusMatchResult()
    local missionDesc = mission:Get3StarConditionDesc(allStarConditions[i], "5BA8F6")
    if missionDesc ~= nil then
      if showProgress then
        text = i .. ".  " .. missionDesc .. "  " .. cur3StarProgress
      else
        text = i .. ".  " .. missionDesc
      end
    else
      Log.fatal("mission desc is nil ", missionID)
    end
    local checkComplete = false
    for _, conditionId in ipairs(cur3StarMatchResult) do
      if conditionId == allStarConditions[i] then
        checkComplete = true
      end
    end
    infos[i] = {text = text, finish = checkComplete}
  end
  return infos
end

function UIBattleBonus:GetMission3StarUIComponents()
  local condText = {
    self:GetUIComponent("UILocalizationText", "star1_cond"),
    self:GetUIComponent("UILocalizationText", "star2_cond"),
    self:GetUIComponent("UILocalizationText", "star3_cond")
  }
  local yellowStars = {
    self:GetGameObject("star_yellow1"),
    self:GetGameObject("star_yellow2"),
    self:GetGameObject("star_yellow3")
  }
  local whiteStars = {
    self:GetGameObject("star_white1"),
    self:GetGameObject("star_white2"),
    self:GetGameObject("star_white3")
  }
  return condText, yellowStars, whiteStars
end

function UIBattleBonus:_OnTweenShow()
  local transWork = self._animRoot.transform
  self._closeBtn:SetActive(false)
  transWork.localPosition = Vector3(-2300, 0, 0)
  self._tweenQueue = DG.Tweening.DOTween.Sequence()
  self._tweenQueue:Append(transWork:DOLocalMoveX(0, 0.4))
  self._tweenQueue:AppendInterval(1):AppendCallback(function()
    self._closeBtn:SetActive(true)
  end)
  local stayTime = BattleConst.BonusShowDuration / 1000 - 1
  self._tweenQueue:AppendInterval(stayTime):OnComplete(function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnClickUIBattleBonus)
  end)
end

function UIBattleBonus:CloseBtnOnClick(go)
  if self._tweenQueue then
    self._tweenQueue:Kill(false)
  end
  if self._player:IsPlaying() then
    self._player:Stop()
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnClickUIBattleBonus)
end

function UIBattleBonus:_ShowMission3StarConditionBonusUI(allStarConditions, missionID)
  local mission = self:GetModule(MissionModule)
  local infos = {}
  for i = 1, #allStarConditions do
    local text
    local showProgress = Cfg.cfg_threestarcondition[allStarConditions[i]].ShowProgress
    local cur3StarProgress = BattleStatHelper.Get3StarProgress(allStarConditions[i])
    local cur3StarMatchResult = BattleStatHelper.GetBonusMatchResult()
    local missionDesc = mission:Get3StarConditionDesc(allStarConditions[i], "5BA8F6")
    if missionDesc ~= nil then
      if showProgress then
        text = i .. ".  " .. missionDesc .. "  " .. cur3StarProgress
      else
        text = i .. ".  " .. missionDesc
      end
    else
      Log.fatal("mission desc is nil ", missionID)
    end
    local checkComplete = false
    for _, conditionId in ipairs(cur3StarMatchResult) do
      if conditionId == allStarConditions[i] then
        checkComplete = true
      end
    end
    infos[i] = {text = text, finish = checkComplete}
  end
  self:GetGameObject("TaskInfo"):SetActive(true)
  self:GetUIComponent("UILocalizationText", "win_cond"):SetText(ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
  local condText = {
    self:GetUIComponent("UILocalizationText", "star1_cond"),
    self:GetUIComponent("UILocalizationText", "star2_cond"),
    self:GetUIComponent("UILocalizationText", "star3_cond")
  }
  local yellowStars = {
    self:GetGameObject("star_yellow1"),
    self:GetGameObject("star_yellow2"),
    self:GetGameObject("star_yellow3")
  }
  local whiteStars = {
    self:GetGameObject("star_white1"),
    self:GetGameObject("star_white2"),
    self:GetGameObject("star_white3")
  }
  for i, info in ipairs(infos) do
    condText[i]:SetText(info.text)
    if info.finish then
      yellowStars[i]:SetActive(true)
      whiteStars[i]:SetActive(false)
    else
      yellowStars[i]:SetActive(false)
      whiteStars[i]:SetActive(true)
    end
  end
  return infos
end

function UIBattleBonus:_ShowMissionNo3StarBonusUI(missionID)
  local stageInfo = ""
  local missionModule = self:GetModule(MissionModule)
  local data = missionModule:GetDiscoveryData()
  if data then
    local node = data:GetNodeDataByStageId(missionID)
    if node then
      local stage = node:GetStageById(missionID)
      if stage then
        stageInfo = stage.stageIdx .. " " .. stage.name
      end
    end
  end
  self:GetGameObject("TaskInfo_tower"):SetActive(true)
  self:GetUIComponent("UILocalizationText", "tower_name"):SetText(stageInfo)
  self:GetUIComponent("UILocalizationText", "win_cond_tower"):SetText(StringTable.Get("str_battle_info_victory_condition") .. "      " .. ConfigServiceHelper.GetLevelConfigData():GetLevelCompleteConditionStr())
end
