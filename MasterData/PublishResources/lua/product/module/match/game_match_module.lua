_class("UI_MatchResult", Object)
UI_MatchResult = UI_MatchResult

function UI_MatchResult:Constructor()
  self.m_nMatchType = 0
  self.m_nSubMatchType = nil
  self.m_nID = 0
  self.m_bVictory = true
  self.m_stShowName = ""
  self.m_stShowDesc = ""
  self.m_vecCondition = {}
  self.m_vecAwardNormal = {}
  self.m_vecAwardPerfect = {}
  self.m_vecFirstPassAward = {}
  self.m_vecExtAward = {}
  self.m_vecDoubleExtAward = {}
  self.m_matchResRolInfo = nil
  self.m_firstFail = false
  self.m_back_rewards = {}
  self.m_recommend_pet_rewards = {}
  self.m_damage = 0
  self.m_enties = {}
  self.m_parent_mission_id = 0
  self.layer_mission_num = 0
  self.cur_max_layer = 0
  self.history_exploration_progress = 0
  self.wave = 0
  self.m_coin_ext_rewards = {}
  self.m_ext_star_rewards = {}
  self.m_ext_first_rewards = {}
  self.m_ext_skill_rewards = {}
end

_class("GameMatchModule", GameModule)
GameMatchModule = GameMatchModule

function GameMatchModule:Constructor()
  self.match_token = GroupToken:New()
  self.vkey = 0
  self.ip = ""
  self.port = 0
end

function GameMatchModule:Init()
  self.caller:RegisterPushHandler(CEventPushMatchEnd, self.HandleCEventPushMatchEnd, self)
  self.caller:RegisterPushHandler(CEventPushJoinMatch, self.HandleCEventPushJoinMatch, self)
end

function GameMatchModule:StartMatch(match_type, teamid, createInfo)
  GameGlobal.TaskManager():StartTask(self.StartMatchTask, self, match_type, teamid, createInfo)
end

function GameMatchModule:GetMatchCreateInfo(match_type, param)
  local serialAutoFightModule = GameGlobal.GetModule(SerialAutoFightModule)
  local createInfo = {}
  if MatchType.MT_Mission == match_type then
    createInfo = MissionCreateInfo:New()
    createInfo.mission_id = param
    createInfo.asset_double_item_count = serialAutoFightModule:GetTicketCount()
  elseif MatchType.MT_Campaign == match_type then
    createInfo = CampaignMissionCreateInfo:New()
    createInfo.nCampaignMissionId = param[1]
    createInfo.nMissionComId = param[2]
    createInfo.CampaignMissionParams = param[3]
  elseif MatchType.MT_ExtMission == match_type then
    createInfo = ExtMissionCreateInfo:New()
    createInfo.m_nExtMissionID = param[1]
    createInfo.m_nExtTaskID = param[2]
  elseif MatchType.MT_Maze == match_type then
    createInfo = MazeCreateInfo:New()
    createInfo.maze_room_index = param
  elseif MatchType.MT_ResDungeon == match_type then
    createInfo = ResDungeonCreateInfo:New()
    createInfo.res_dungeon_id = param
    createInfo.asset_double_item_count = serialAutoFightModule:GetTicketCount()
  elseif MatchType.MT_Tower == match_type then
    createInfo = TowerCreateInfo:New()
    createInfo.nId = param
  elseif MatchType.MT_TalePet == match_type then
    createInfo = TalePetCreateInfo:New()
    createInfo.nId = param
  elseif MatchType.MT_LostArea == match_type then
    createInfo = LostAreaCreateInfo:New()
    createInfo.mission_id = param
  elseif MatchType.MT_Conquest == match_type then
    createInfo = ConquestMissionCreateInfo:New()
    createInfo.mission_id = param[1]
    createInfo.component_type = param[2]
    createInfo.component_cfg_id = param[3]
    createInfo.random_index = param[4]
  elseif MatchType.MT_WorldBoss == match_type then
    createInfo = WorldBossCreateInfo:New()
    createInfo.mission_id = param[1]
    createInfo.select_index = param[2]
  elseif MatchType.MT_BlackFist == match_type then
    createInfo = BlackFistCreateInfo:New()
    createInfo.mission_id = param[1]
    createInfo.component_id = param[2]
    createInfo.CampaignMissionParams = param[3]
  elseif MatchType.MT_Chess == match_type then
    createInfo = ChessMissionCreateInfo:New()
    createInfo.mission_id = param[1]
    createInfo.component_id = param[2]
    createInfo.CampaignMissionParams = param[3]
  elseif MatchType.MT_DifficultyMission == match_type then
    createInfo = DifficultyMissionCreateInfo:New()
    createInfo.parent_mission_id = param[1]
    createInfo.sub_mission_id = param[2]
    createInfo.mission_component_id = param[3]
    createInfo.campaign_component_cfg_id = param[4]
  elseif MatchType.MT_SailingMission == match_type then
    createInfo = SailingMissionCreateInfo:New()
    createInfo.layer_id = param[1]
    createInfo.mission_id = param[2]
  elseif MatchType.MT_MiniMaze == match_type then
    createInfo = BloodsuckerMissionCreateInfo:New()
    createInfo.mission_id = param[1]
    createInfo.component_type = param[2]
    createInfo.component_cfg_id = param[3]
  elseif MatchType.MT_Season == match_type then
    createInfo = SeasonMissionCreateInfo:New()
    createInfo.mission_id = param[1]
    createInfo.component_id = param[2]
    createInfo.CampaignMissionParams = param[3]
  elseif MatchType.MT_PopStar == match_type then
    createInfo = PopStarMissionCreateInfo:New()
    createInfo.mission_id = param[1]
    createInfo.component_id = param[2]
    createInfo.CampaignMissionParams = param[3]
    createInfo.is_challenge = param[4]
  elseif MatchType.MT_EightPets == match_type then
    createInfo = EightPetsMissionCreateInfo:New()
    createInfo.mission_id = param[1]
    createInfo.component_id = param[2]
    createInfo.CampaignMissionParams = param[3]
  elseif MatchType.MT_PopStarPro == match_type then
    createInfo = AnipopMissionCreateInfo:New()
    createInfo.mission_index = param[3]
  elseif MatchType.MT_SeasonMaze == match_type then
    createInfo = SeasonMazeMissionCreateInfo:New()
    createInfo.room_id = param[1]
    createInfo.mission_id = param[2]
    createInfo.component_id = param[3]
    createInfo.CampaignMissionParams = param[4]
  end
  return createInfo
end

function GameMatchModule:QuickReStartMatchTT(TT)
  if GameSingle then
    local md = GameGlobal.GetModule(SkillPerfModule)
    md:EnterCoreGameSingleReStart()
    return
  end
  if not self._quickReStartCreateInfo then
    return
  end
  self:StartMatchTask(TT, self._quickReStartMatchType, self._quickReStartTeamId, self._quickReStartCreateInfo, nil, true)
end

function GameMatchModule:QuickReStartMatch()
  if GameSingle then
    local md = GameGlobal.GetModule(SkillPerfModule)
    md:EnterCoreGameSingleReStart()
    return
  end
  if not self._quickReStartCreateInfo then
    return
  end
  GameGlobal.TaskManager():StartTask(self.StartMatchTask, self, self._quickReStartMatchType, self._quickReStartTeamId, self._quickReStartCreateInfo, nil, true)
end

function GameMatchModule:StartMatchTask(TT, match_type, teamid, createInfo, bblackloading, isQuickReStart)
  Log.prof("[loading] StartMatchTask match_type=" .. match_type)
  if not isQuickReStart then
    self._quickReStartCreateInfo = createInfo
    self._quickReStartTeamId = teamid
    self._quickReStartMatchType = match_type
  end
  GameGlobal:GetInstance():StartChangeCacheLevelTask(CacheResLevel.Maximum)
  local collector = GameGlobal:GetInstance():GetCollector("CoreGameLoading")
  local login = self:GetModule(LoginModule)
  local game = self:GetModule(GameMatchModule)
  local match = self:GetModule(MatchModule)
  local res = self:CreateMatch(TT, match_type, teamid, createInfo)
  if not res:GetSucc() then
    if res:GetResult() == MatchOpResCode.MATCH_ALREADY_IN_MATCH then
      self:LeaveMatch(TT)
    end
    res = self:CreateMatch(TT, match_type, teamid, createInfo)
    if not res:GetSucc() then
      Log.fatal("创建对局失败")
      return res
    end
  end
  Log.prof("[loading] CreateMatch success match_type=" .. match_type)
  collector:Sample("CreateMatch(TT)")
  res = self:JoinMatch(TT)
  if not res:GetSucc() then
    Log.fatal("加入对局失败")
    return res
  end
  Log.prof("[loading] JoinMatch success match_type=" .. match_type)
  collector:Sample("JoinMatch(TT)")
  match.auth.player_id = login.PstID
  match.auth.token = self.match_token
  match.auth.vkey = self.vkey
  match:StartEnterMatch()
  res = match:Login(TT, self.match_token.server_id, false)
  if not res:GetSucc() then
    Log.fatal("登录match失败")
    return res
  end
  Log.prof("[loading] Login Match success match_type=" .. match_type)
  collector:Sample("match:Login(TT)")
  res = match:EnterMatch(TT, login.PstID, self.match_token)
  if not res:GetSucc() then
    Log.fatal("进入match失败")
    return res
  end
  Log.prof("[loading] Enter Match success match_type=" .. match_type)
  collector:Sample("matdch:EnterMatch(TT)")
  local enterData = match:GetMatchEnterData()
  self:GetModule(PetModule):GetAllPetsSnapshoot()
  GameGlobal.GetModule(ItemModule):CommonAutoConversionEventOpen(true)
  if not isQuickReStart then
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Battle_Loading)
  end
  return res
end

function GameMatchModule:CreateMatch(TT, match_type, teamid, create_info)
  Log.debug("sending CEventRequestCreateMatch")
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local role = self:GetModule(RoleModule)
  if role == nil then
    Log.fatal("GameMatchModule:CreateMatch failed RoleModule = nil")
    res:SetResult(-1)
    return res
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestCreateMatch)
  request.m_match_type = match_type
  request.m_formation_id = teamid
  local helpPetModule = self:GetModule(HelpPetModule)
  request.m_nHelpPetKey = helpPetModule:UI_GetHelpPetKey()
  if match_type == MatchType.MT_Mission then
    request.m_client_create_info.mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] missinfo", create_info.mission_id)
  elseif match_type == MatchType.MT_ExtMission then
    request.m_client_create_info.m_extMissionInfo[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.m_nExtMissionID)
    Log.debug("[match] extMission", create_info.m_nExtMissionID, create_info.m_nExtTaskID)
  elseif match_type == MatchType.MT_Maze then
    request.m_client_create_info.maze_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.maze_room_index)
    Log.debug("[match] maze_info", create_info.maze_room_id)
  elseif match_type == MatchType.MT_ResDungeon then
    request.m_client_create_info.resdungeon_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.res_dungeon_id)
    Log.debug("[match] ResDungeon", create_info.res_dungeon_id)
  elseif match_type == MatchType.MT_Tower then
    request.m_client_create_info.tower_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.nId)
    Log.debug("[match] Tower", create_info.nId)
  elseif match_type == MatchType.MT_TalePet then
    request.m_client_create_info.tale_pet_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.nId)
    Log.debug("[match] tale_pet_stage", create_info.nId)
  elseif match_type == MatchType.MT_Campaign then
    request.m_client_create_info.campaign_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] campaign_missinfo", create_info.mission_id)
  elseif match_type == MatchType.MT_LostArea then
    request.m_client_create_info.lost_area_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] lost_area_mission", create_info.mission_id)
  elseif match_type == MatchType.MT_Conquest then
    request.m_client_create_info.conquest_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] conquest_mission", create_info.mission_id)
  elseif match_type == MatchType.MT_BlackFist then
    request.m_client_create_info.black_fist_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] black_fist_info", create_info.mission_id)
  elseif match_type == MatchType.MT_WorldBoss then
    request.m_client_create_info.world_boss_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] worldboss_mission", create_info.mission_id)
  elseif match_type == MatchType.MT_Chess then
    request.m_client_create_info.chess_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] chess_mission", create_info.mission_id)
  elseif match_type == MatchType.MT_DifficultyMission then
    request.m_client_create_info.difficulty_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.sub_mission_id)
    Log.debug("[match] difficulty_mission", create_info.parent_mission_id, create_info.sub_mission_id)
  elseif match_type == MatchType.MT_SailingMission then
    request.m_client_create_info.sailing_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] sailing_mission", create_info.layer_id, create_info.mission_id)
  elseif match_type == MatchType.MT_MiniMaze then
    request.m_client_create_info.bloodsucker_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] bloodsucker_mission", create_info.mission_id)
  elseif match_type == MatchType.MT_Season then
    request.m_client_create_info.season_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] season_mission", create_info.mission_id)
  elseif match_type == MatchType.MT_PopStar then
    request.m_client_create_info.popstar_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] popstar_mission", create_info.mission_id)
  elseif match_type == MatchType.MT_EightPets then
    request.m_client_create_info.eight_pets_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] eight_pets_mission_info", create_info.mission_id)
  elseif match_type == MatchType.MT_PopStarPro then
    request.m_client_create_info.anipop_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_index)
    Log.debug("[match] anipop_mission", create_info.mission_id)
  elseif match_type == MatchType.MT_SeasonMaze then
    request.m_client_create_info.season_maze_mission_info[1] = create_info
    role:UpdateMatchInfo(match_type, create_info.mission_id)
    Log.debug("[match] season_maze_mission_info", create_info.mission_id)
  end
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("GameMatchModule:CreateMatch failed with !reply:Succ()")
    res:SetResult(-1)
    return res
  end
  local replyEvent = CEventReplyCreateMatch(reply.msg)
  if replyEvent == nil then
    Log.fatal("GameMatchModule:CreateMatch failed with replyEvent == nil")
    res:SetResult(-1)
    return res
  end
  if replyEvent.m_ret ~= 0 then
    local stErrorMsg = self:GetErrorMsg(replyEvent.m_ret)
    Log.fatal("GameMatchModule:CreateMatch failed with ret=", replyEvent.m_ret, ", ErrorMsg=" .. stErrorMsg)
    res:SetResult(replyEvent.m_ret)
    return res
  end
  Log.debug("[match] createMatch() OK ----------", GetEnumKey("MatchType", match_type))
  Log.debug("[match]", echo(create_info))
  res:SetSucc(true)
  self.match_token = replyEvent.m_match_created
  self.vkey = replyEvent.m_vkey
  return res
end

function GameMatchModule:JoinMatch(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestJoinMatch)
  request.m_match_to_join = self.match_token
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("GameMatchModule:JoinMatch failed with !reply:Succ()")
    return res
  end
  local replyEvent = CEventReplyJoinMatch(reply.msg)
  if replyEvent == nil then
    Log.fatal("GameMatchModule:JoinMatch failed with replyEvent == nil")
    res:SetResult(-1)
    return res
  end
  if replyEvent.m_ret ~= 0 then
    Log.fatal("GameMatchModule:JoinMatch failed with ret=" .. replyEvent.m_ret)
    res:SetResult(replyEvent.m_ret)
    return res
  end
  res:SetSucc(true)
  self.vkey = replyEvent.m_vkey
  self.ip = replyEvent.m_server_ip
  self.port = replyEvent.m_server_port
  return res
end

function GameMatchModule:LeaveMatch(TT, isReStart)
  Log.debug("sending CEventRequestLeaveMatch")
  GameGlobal.GameRecorder():StopRecord()
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestLeaveMatch)
  request.m_away = true
  request.m_restart = isReStart
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventReplyLeaveMatch(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  return res
end

function GameMatchModule:HandleCEventPushMatchEnd(msg)
  Log.debug("CEventPushMatchEnd : ", msg, " type ", msg.match_type)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.MatchResult, {
    result = msg.m_result
  })
  GameGlobal.GameRecorder():StopRecord()
  local matchmodule = GameGlobal.GetModule(MatchModule)
  matchmodule:HandleMatchEndMsg(msg.m_result)
  local matchResult = msg.m_result
  if matchResult.exception then
    Log.notice("----------- battle match failed -----------")
    Log.error("exception code = ", matchResult.exception_code)
    Log.exception(matchResult.exception_msg)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DumpSyncLog)
    if EDITOR then
      UnityEngine.Time.timeScale = 0
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchClosed)
    end
    return
  end
  if not matchResult.sync_match then
    Log.exception("Sync battle result not match")
  end
  if GameGlobal:GetInstance():IsCoreGameRunning() == false then
    Log.debug("HandleCEventPushMatchEnd IsCoreGameRunning == false")
    return
  end
  if matchResult.victory then
    local matchModule = GameGlobal.GetModule(MatchModule)
    local enterData = matchModule:GetMatchEnterData()
    local levelId = enterData:GetLevelID()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideBattleComplete, levelId)
  end
  if msg.match_type == MatchType.MT_Mission then
    local workModule = GameGlobal.GetModule(MissionModule)
    self._match_result = workModule:Module_ConvertMatchResult(matchResult.mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MissionFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_ExtMission then
    local workModule = GameGlobal.GetModule(ExtMissionModule)
    self._match_result = workModule:Module_ConvertMatchResult(matchResult.ext_mission_result[1], matchResult.victory)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ExtMissionFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_Maze then
    self._match_result = matchResult.maze_result[1]
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MazeFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_ResDungeon then
    local resDungeonModule = GameGlobal.GetModule(ResDungeonModule)
    self._match_result = resDungeonModule:Module_ConvertMatchResult(matchResult.res_dungeon_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ResDungeonFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_Tower then
    local towerModule = GameGlobal.GetModule(TowerModule)
    self._match_result = towerModule:Module_ConvertMatchResult(matchResult.tower_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TowerFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_TalePet then
    local TalePetModule = GameGlobal.GetModule(TalePetModule)
    self._match_result = TalePetModule:Module_ConvertMatchResult(matchResult.tale_pet_reward[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TalePetFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_LostArea then
    local lostAreaModule = GameGlobal.GetModule(LostAreaModule)
    self._match_result = lostAreaModule:Module_ConvertMatchResult(matchResult.lost_area_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LostAreaFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_Campaign then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertMatchResult(matchResult.campaign_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_Conquest then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertConquestMatchResult(matchResult.conquest_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_BlackFist then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertBlackFistMatchResult(matchResult.black_fist_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BlackFistResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_WorldBoss then
    local worldBossModule = GameGlobal.GetModule(WorldBossModule)
    self._match_result = worldBossModule:Module_ConvertMatchResult(matchResult.world_boss_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_Chess then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertChessMatchResult(matchResult.chess_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_DifficultyMission then
    local workModule = GameGlobal.GetModule(DifficultyMissionModule)
    self._match_result = workModule:Module_ConvertDiffMatchResult(matchResult.difficulty_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_SailingMission then
    local workModule = GameGlobal.GetModule(SailingMissionModule)
    self._match_result = workModule:Module_ConvertSailingMatchResult(matchResult.sailing_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif MatchType.MT_MiniMaze == msg.match_type then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertBloodsuckerMatchResult(matchResult.bloodsucker_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_Season then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertSeasonMatchResult(matchResult.season_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_PopStar then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertPopStarMatchResult(matchResult.popstar_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MissionFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_EightPets then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertEightPetsMatchResult(matchResult.eight_pets_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MissionFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_PopStarPro then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertAniPopStarMatchResult(matchResult.anipop_mission_result[1], matchResult.battle_statistics)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AniPopFightResult, matchResult.victory)
  elseif msg.match_type == MatchType.MT_SeasonMaze then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._match_result = workModule:Module_ConvertSeasonMazeMatchResult(matchResult.season_maze_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MissionFightResult, matchResult.victory)
  else
    Log.error("HandleCEventPushMatchEnd error type ", msg.match_type)
  end
  if not self._match_result.m_nSubMatchType then
    self._match_result.m_nSubMatchType = self._match_result.m_nMatchType
  end
  self._match_result.m_bVictory = matchResult.victory
  self._match_result.m_firstFail = matchResult.first_fail
  self._match_result.m_activity_rewards = matchResult.campaign_reward
end

function GameMatchModule:GetMachResult()
  return self._match_result
end

function GameMatchModule:HandleCEventPushJoinMatch(msg)
  local push_msg = CEventPushJoinMatch(msg)
  local res = AsyncRequestRes:New()
  self:StartTask(self.JoinMatch, self, push_msg.m_match_to_join)
end

function GameMatchModule:GetErrorMsg(errCode)
  local vecErrorMsg = {}
  vecErrorMsg[MatchOpResCode.MATCH_NOT_ENOUGH_PHY_POWER] = StringTable.Get("str_match_error_not_enough_phy_power")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_TEAM] = StringTable.Get("str_match_error_invalid_team")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_MISSION_ID] = StringTable.Get("str_match_error_invalid_mission_id")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_ExtMissionID] = StringTable.Get("str_match_error_ext_mission_id")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_RoleLevel] = StringTable.Get("str_match_error_role_level")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_MissionLock] = StringTable.Get("str_match_error_mission_lock")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_ExtTaskLock] = StringTable.Get("str_match_error_ext_task_lock")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_ExtTaskID] = StringTable.Get("str_match_error_ext_task_id")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_LowPower] = StringTable.Get("str_match_error_low_power")
  vecErrorMsg[MatchOpResCode.MATCH_INVALID_MAZE_ROOM_ID] = StringTable.Get("str_match_error_maze_room")
  vecErrorMsg[MatchOpResCode.MATCH_NOT_ENOUGH_LIGHT] = StringTable.Get("str_maze_no_light")
  vecErrorMsg[MatchOpResCode.MATCH_NO_BLOOD] = StringTable.Get("str_match_error_no_blood")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_IS_LOCKED] = StringTable.Get("str_tower_match_tower_is_locked")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_CONFIG_INVALID] = StringTable.Get("str_tower_match_tower_config_invalid")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_ID_INVALID] = StringTable.Get("str_tower_match_tower_id_invalid")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_AFTER_LEVEL_NOT_PASS] = StringTable.Get("str_tower_match_tower_after_level_not_pass")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_TYPE_INVALID] = StringTable.Get("str_tower_match_tower_type_invalid")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_PET_NUM_ERR] = StringTable.Get("str_tower_match_tower_pet_num_err")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_PET_INVALID] = StringTable.Get("str_tower_match_tower_pet_invalid")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_PET_REPEAT] = StringTable.Get("str_tower_match_tower_pet_repeat")
  vecErrorMsg[MatchOpResCode.MATCH_ELEMENT_TYPE_ERR] = StringTable.Get("str_tower_match_element_type_err")
  vecErrorMsg[MatchOpResCode.MATCH_TOWER_DROPID_INVALIED] = StringTable.Get("str_tower_match_tower_dropid_invalied")
  vecErrorMsg[MatchOpResCode.MATCH_CAMPAIGN_CamNotOpen] = StringTable.Get("str_activity_error_109")
  vecErrorMsg[MatchOpResCode.MATCH_CAMPAIGN_ComNotOpen] = StringTable.Get("str_activity_error_109")
  vecErrorMsg[MatchOpResCode.MATCH_NOT_ENOUGH_ACTIONPOINT] = StringTable.Get("str_activity_point_not_enough")
  vecErrorMsg[MatchOpResCode.MATCH_CAMPAIGN_MISSIOHN_CROSS_DAY] = StringTable.Get("str_n5_battlefield_refreshed")
  vecErrorMsg[MatchOpResCode.MATCH_WORLD_BOSS_FORMATION_INVALID] = StringTable.Get("str_world_boss_team_invalid")
  vecErrorMsg[MatchOpResCode.MATCH_WORLD_BOSS_MISSION_INVALID] = StringTable.Get("str_world_boss_season_end")
  local stErrorMsg = vecErrorMsg[errCode]
  if nil == stErrorMsg then
    local errorCodeMsg = ""
    if errCode == nil then
      errorCodeMsg = "[nil]"
    else
      errorCodeMsg = "[" .. errCode .. "]"
    end
    local defaultMsg = StringTable.Get("str_match_error_server_error") .. errorCodeMsg
    return defaultMsg
  end
  return stErrorMsg
end

function GameMatchModule:HandleCEventPushMatchingSuccess(msg)
  Log:debug("CEventPushMatchingSuccess: ", msg)
  local push_msg = CEventPushMatchingSuccess(msg)
  local res = AsyncRequestRes:New()
  GameGlobal.TaskManager():StartTask(self.SuccessMatching, self, push_msg)
end

function GameMatchModule:StartMatching(TT)
  Log.debug("sending CEventRequestLeaveMatch")
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestQuickJoinMatch)
  request.m_level_id = 1
  request.m_match_type = MatchType.MT_LUA
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventReplyQuickJoinMatch(reply.msg)
  if replyEvent == nil then
    return res
  end
  if replyEvent.m_ret == GameMatchError.GME_Succ then
    res:SetSucc(true)
  end
  return res
end

function GameMatchModule:CancelMatching(TT)
  Log.debug("sending CEventRequestLeaveMatch")
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestCancelQuickJoinMatch)
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventReplyCancelQuickJoinMatch(reply.msg)
  if replyEvent == nil then
    return res
  end
  if replyEvent.m_ret == GameMatchError.GME_Succ then
    res:SetSucc(true)
  end
  return res
end

function GameMatchModule:SuccessMatching(TT, push_msg)
  Log.debug("Matching Succeed，try to enter match")
  GameGlobal.UIStateManager():CloseDialog("UIInMatchQueueController")
  self.match_token = push_msg.m_match_to_enter
  self.vkey = push_msg.m_vkey
  local login = self:GetModule(LoginModule)
  local match = self:GetModule(MatchModule)
  match.auth.player_id = login.PstID
  match.auth.token = push_msg.m_match_to_enter
  match.auth.vkey = push_msg.m_vkey
  match:StartEnterMatch()
  local res = match:Login(TT, push_msg.m_match_to_enter.server_id, false)
  if not res:GetSucc() then
    Log.fatal("GameMatchModule:Joining Match After Matching success failed due to match:Login failure", ", net: ", res:GetNetErr(), ", ret: ", res:GetResult())
    return
  end
  res = match:EnterMatch(TT, login.PstID, push_msg.m_match_to_enter)
  if not res:GetSucc() then
    Log.fatal("GameMatchModule:Joining Match After Matching success failed due to match:EnterMatch failure")
    return
  end
end

function GameMatchModule:ExtractResult(matchResult, match_type)
  if match_type == MatchType.MT_Mission then
    local workModule = GameGlobal.GetModule(MissionModule)
    self._sweep_result = workModule:Module_ConvertMatchResult(matchResult.mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MissionFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_ExtMission then
    local workModule = GameGlobal.GetModule(ExtMissionModule)
    self._sweep_result = workModule:Module_ConvertMatchResult(matchResult.ext_mission_result[1], matchResult.victory)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ExtMissionFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_Maze then
    self._sweep_result = matchResult.maze_result[1]
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MazeFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_ResDungeon then
    local resDungeonModule = GameGlobal.GetModule(ResDungeonModule)
    self._sweep_result = resDungeonModule:Module_SweepConvertMatchResult(matchResult.res_dungeon_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ResDungeonFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_Tower then
    local towerModule = GameGlobal.GetModule(TowerModule)
    self._sweep_result = towerModule:Module_ConvertMatchResult(matchResult.tower_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TowerFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_TalePet then
    local TalePetModule = GameGlobal.GetModule(TalePetModule)
    self._sweep_result = TalePetModule:Module_ConvertMatchResult(matchResult.tale_pet_reward[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TalePetFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_LostArea then
    local lostAreaModule = GameGlobal.GetModule(LostAreaModule)
    self._sweep_result = lostAreaModule:Module_ConvertMatchResult(matchResult.lost_area_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LostAreaFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_Campaign then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._sweep_result = workModule:Module_ConvertMatchResult(matchResult.campaign_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_Conquest then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._sweep_result = workModule:Module_ConvertConquestMatchResult(matchResult.conquest_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_BlackFist then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._sweep_result = workModule:Module_ConvertBlackFistMatchResult(matchResult.black_fist_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.BlackFistResult, matchResult.victory)
  elseif match_type == MatchType.MT_WorldBoss then
    local worldBossModule = GameGlobal.GetModule(WorldBossModule)
    self._sweep_result = worldBossModule:Module_ConvertMatchResult(matchResult.world_boss_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_Chess then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._sweep_result = workModule:Module_ConvertChessMatchResult(matchResult.chess_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_DifficultyMission then
    local workModule = GameGlobal.GetModule(DifficultyMissionModule)
    self._sweep_result = workModule:Module_ConvertDiffMatchResult(matchResult.difficulty_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_Season then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._sweep_result = workModule:Module_ConvertSeasonMatchResult(matchResult.season_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ConquestFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_EightPets then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._sweep_result = workModule:Module_ConvertEightPetsMatchResult(matchResult.eight_pets_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_PopStarPro then
    self._sweep_result = matchResult.anipop_mission_result[1]
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AniPopFightResult, matchResult.victory)
  elseif match_type == MatchType.MT_SeasonMaze then
    local workModule = GameGlobal.GetModule(CampaignModule)
    self._sweep_result = workModule:Module_ConvertSeasonMazeMatchResult(matchResult.season_mission_result[1])
    GameGlobal.EventDispatcher():Dispatch(GameEventType.CampaignFightResult, matchResult.victory)
  else
    Log.error("HandleCEventPushMatchEnd error type ", match_type)
  end
  self._sweep_result.m_activity_rewards = matchResult.campaign_reward
end

function GameMatchModule:MatchSweep(TT, match_type, mission_id, sweep_times, component_id, CampaignMissionParams)
  Log.debug("sending CEventRequestSweepMatch match_type : ", match_type, "mission_id : ", mission_id)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestSweepMatch)
  request.match_type = match_type
  request.mission_id = mission_id
  request.times = sweep_times
  request.component_id = component_id
  request.CampaignMissionParams = CampaignMissionParams
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("GameMatchModule:MatchSweep failed with !reply:Succ()")
    res:SetResult(-1)
    return res
  end
  local replyEvent = CEventReplySweepMatch(reply.msg)
  if replyEvent == nil then
    Log.fatal("GameMatchModule:MatchSweep failed with replyEvent == nil")
    res:SetResult(-1)
    return res
  end
  if replyEvent.m_ret ~= MatchOpResCode.MATCH_SUCCESS then
    local stErrorMsg = self:GetErrorMsg(replyEvent.m_ret)
    Log.fatal("GameMatchModule:MatchSweep failed with ret=", replyEvent.m_ret, ", ErrorMsg=" .. stErrorMsg)
    res:SetResult(replyEvent.m_ret)
    return res
  end
  Log.debug("[match] createMatch() OK ----------")
  self:ExtractResult(replyEvent.m_result, match_type)
  res:SetSucc(true)
  return res
end

function GameMatchModule:GetSweepResult()
  return self._sweep_result
end

function GameMatchModule:Start_MatchSweep(match_type, mission_id, sweep_times, component_id, campaignMissionParams, callback)
  local lockName = "Start_MatchSweep"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = self:MatchSweep(TT, match_type, mission_id, sweep_times, component_id, campaignMissionParams)
    local matchResult = self:GetSweepResult()
    GameGlobal.UIStateManager():UnLock(lockName)
    callback(res, matchResult)
  end)
end
