_class("MazeModule", GameModule)
MazeModule = MazeModule

function MazeModule:Constructor()
  self._mazeInfo = nil
  self._mazeInitTime = nil
  self._max_layer = 0
end

function MazeModule:GetMazeInfo()
  return self._mazeInfo
end

function MazeModule:SetMazeInfo(maze_info)
  if self._mazeInfo and self._mazeInfo.maze_version ~= maze_info.maze_version and GameGlobal:GetInstance():IsCoreGameRunning() then
    local matchMd = self:GetModule(MatchModule)
    local matchEnterData = matchMd:GetMatchEnterData()
    if matchEnterData:GetMatchType() == MatchType.MT_Maze then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.MazeReset)
    end
  end
  self._mazeInfo = maze_info
  self:CalcResetTime()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MazeInfoUpdate)
end

function MazeModule:SetMazeInitTime(maze_init_time)
  self._mazeInitTime = maze_init_time
end

function MazeModule:IsMazeUseNewCfg()
  local loginModule = GameGlobal.GetModule(LoginModule)
  local timeTransform = 1
  local timeStr = "2024-06-13 05:00:00"
  local switchTime = 0
  if timeTransform == 0 then
    switchTime = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
  elseif timeTransform == 1 then
    switchTime = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if switchTime <= svrTime then
    return true
  else
    return false
  end
end

function MazeModule:CalcResetTime()
  local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  local h = Cfg.cfg_global.maze_reset_hour.IntValue
  if self:IsMazeUseNewCfg() then
    h = Cfg.cfg_global.maze_reset_hour_new.IntValue
  end
  self._mazeResetTime = now + h * 3600 - (now - self._mazeInitTime) % (h * 3600)
end

function MazeModule:GetSecToFinish()
  local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  local diff = self._mazeResetTime - now + 1
  if diff < 0 then
    diff = 0
  end
  return diff
end

function MazeModule:Init()
  self.caller:RegisterPushHandler(CEventNotifyMazeInfo, self.HandleMazeInfoChange, self)
end

function MazeModule:HandleMazeInfoChange(msg)
  self:SetMazeInfo(msg.data)
  self._max_layer = msg.max_layer
end

function MazeModule:UnlockSweep()
  local maxlayer = 0
  for k, v in pairs(Cfg.cfg_maze_layer()) do
    if maxlayer < v.Layer then
      maxlayer = v.Layer
    end
  end
  return self._max_layer == maxlayer
end

function MazeModule:RequestSweep(TT, roomIndex)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSweepMazeReq)
  request.maze_room_index = roomIndex
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  return res, replyEvent
end

function MazeModule:UpdateMazeFormationInfo(TT, formation_id, formation_name, pet_list)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyChangeMazeFormationReq)
  request.m_formation_id = formation_id
  request.m_formation_name = formation_name
  request.m_formation_pet_list = pet_list
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  if replyEvent.m_result == 0 then
    self:_SetFormationInfos(replyEvent.m_formation_info)
  end
  return res, replyEvent.m_formation_info
end

function MazeModule:RequestMazeVersion(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestMazeVersion)
  request.maze_version = self._mazeInfo.maze_version
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_ret)
  return res
end

function MazeModule:_SetFormationInfos(formation_info)
  self._mazeInfo.formation_info = formation_info
end

function MazeModule:GetFormationInfo()
  return self._mazeInfo.formation_info
end

function MazeModule:RequestSelectRelic(TT, relicid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestMazeSelectRelic)
  request.relic_id = relicid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_ret)
  return res
end

function MazeModule:RequestUseDice(TT, relicid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestMazeUseDice)
  request.relic_id = relicid
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_ret)
  return res, reply.msg
end

function MazeModule:RequestEnterRoom(TT, roomIndex, bIsReLife)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestMazeEnterRoom)
  request.room_index = roomIndex
  request.is_random_relife_pet = bIsReLife
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_ret)
  return res, replyEvent
end

function MazeModule:SingleMatch(room_index, teamid)
  local game = GameGlobal.GetModule(GameMatchModule)
  local info = MazeCreateInfo:New()
  info.maze_version = self._mazeInfo.maze_version
  info.maze_layer = self._mazeInfo.maze_layer
  info.maze_room_index = room_index
  game:StartMatch(MatchType.MT_Maze, teamid, info)
end

function MazeModule:GetRoomMonsterList(room_index)
  local room = self._mazeInfo.room_info[room_index + 1]
  if Cfg.cfg_maze_room[room.room_id].MazeRoomType == MazeRoomType.MazeRoomType_Battery then
    return {}
  end
  local levelid = room.level_info.level_id
  local waveInfo = room.level_info.wave_randoms
  local cfg = Cfg.cfg_level[levelid]
  if cfg == nil then
    Log.exception("找不到秘境关卡：", levelid)
  end
  local waveArr = cfg.MonsterWave
  local ret = {}
  for i, wave in ipairs(waveArr) do
    local wavecfg = Cfg.cfg_monster_wave[wave]
    local refreshcfg = Cfg.cfg_refresh[wavecfg.WaveBeginRefreshID]
    local monsterWeight = refreshcfg.MonsterWeight
    local monsterRIds = refreshcfg.MonsterRefreshIDList
    local totalw = 0
    for _, w in ipairs(monsterWeight) do
      totalw = totalw + w
    end
    local monsterRefreshId = 0
    local ww = waveInfo[2 * i - 1] * totalw
    for j, w in ipairs(monsterWeight) do
      ww = ww - w
      if ww <= 0 then
        monsterRefreshId = monsterRIds[j]
        break
      end
    end
    local monsters = Cfg.cfg_refresh_monster[monsterRefreshId].MonsterIDList
    table.appendArray(ret, monsters)
  end
  ret = table.unique(ret)
  return ret
end

function MazeModule:GetPetPower(pet_pstid)
  local max = self:_getPetPowerLimit(pet_pstid)
  local l_pet_info = self._mazeInfo.pet_info[pet_pstid]
  if l_pet_info then
    return l_pet_info.power, max
  end
  return -1, max
end

function MazeModule:_getPetPowerLimit(pet_pstid)
  local petMd = GameGlobal:GetInstance().GetModule(PetModule)
  local pet = petMd:GetPet(pet_pstid)
  if not pet then
    return 0
  end
  local activeSkillID = pet:GetPetActiveSkill()
  local cfg = BattleSkillCfg(activeSkillID)
  return cfg.TriggerParam
end

function MazeModule:IsPetActiveSkillUseLegendEnergy(pet_pstid, peiCls)
  local petMd = GameGlobal:GetInstance().GetModule(PetModule)
  local pet
  if pet_pstid then
    pet = petMd:GetPet(pet_pstid)
  else
    pet = peiCls
  end
  if not pet then
    return false
  end
  local activeSkillID = pet:GetPetActiveSkill()
  local cfg = BattleSkillCfg(activeSkillID)
  return cfg.TriggerType == SkillTriggerType.LegendEnergy or cfg.TriggerType == SkillTriggerType.AlchemyEnergy
end

function MazeModule:IsLastLayerRoom(version, layer, room_index)
  if version ~= self._mazeInfo.maze_version then
    return false
  end
  if layer ~= self._mazeInfo.layer then
    return false
  end
  if room_index + 1 ~= #self._mazeInfo.room_info then
    return false
  end
  return true
end

function MazeModule:GetLastTeamID()
  return self._mazeInfo.team_id
end

function MazeModule:GetCurrentRoom()
  local matchData = GameGlobal.GetModule(MatchModule):GetMatchEnterData():GetMazeCreateInfo()
  return self._mazeInfo.room_info[matchData.maze_room_index + 1]
end

function MazeModule:GetMazeRelicAddAttack(pet_pstid)
  local l_pet_info = self._mazeInfo.pet_info[pet_pstid]
  if l_pet_info then
    return l_pet_info.attack_mul
  end
  return 0
end

function MazeModule:GetMazeRelicAddDefence(pet_pstid)
  local l_pet_info = self._mazeInfo.pet_info[pet_pstid]
  if l_pet_info then
    return l_pet_info.defense_mul
  end
  return 0
end

function MazeModule:GetMazeRelicAddMaxHP(pet_pstid)
  local l_pet_info = self._mazeInfo.pet_info[pet_pstid]
  if l_pet_info then
    return l_pet_info.max_hp_mul
  end
  return 0
end

function MazeModule:CalcGameOverAddBlood()
  local addBlood = 0
  for i, relic in ipairs(self._mazeInfo.relics) do
    local cfg = Cfg.cfg_item.relic[relic]
    if cfg.OutGameTriggerType == MazeRelicOutGameTriggerType.MRTOGTT_GameOver and cfg.OutGameEffectType == MazeRelicOutGameEffectType.AddHP and self._mazeInfo.relic_counters[relic] - 1 < cfg.OutGameTriggerCount then
      addBlood = addBlood + cfg.OutGameEffectParam
    end
  end
  Log.error("CalcGameOverAddBlood() addBlood=", addBlood)
  return addBlood
end

function MazeModule:MazeIsPass()
  if self._mazeInfo == nil or self._mazeInfo.is_pass_all_maze == nil then
    return false
  end
  return self._mazeInfo.is_pass_all_maze
end

function MazeModule:GetMazePetInfoByPstId(pet_pst_id)
  local l_pet_info = self._mazeInfo.pet_info[pet_pst_id]
  if l_pet_info then
    return l_pet_info
  end
  local max_hp = self:GetCalPetMaxHp(pet_pst_id)
  if max_hp <= 0 then
    return nil
  end
  l_pet_info = {}
  l_pet_info.pet_pstid = pet_pst_id
  l_pet_info.power = -1
  l_pet_info.blood = 1
  l_pet_info.is_dead = false
  self._mazeInfo.pet_info[pet_pst_id] = l_pet_info
  return l_pet_info
end

function MazeModule:GetCalPetADH(pet_pst_id)
  local l_pet_module = GameGlobal.GameLogic():GetModule(PetModule)
  if l_pet_module == nil then
    return -1, -1, -1
  end
  local l_pet = l_pet_module:GetPet(pet_pst_id)
  if l_pet == nil then
    return -1, -1, -1
  end
  local l_pet_template_id = l_pet:GetTemplateID()
  if l_pet_template_id == nil or l_pet_template_id <= 0 then
    return -1, -1, -1
  end
  local l_cfg_maze_pet_info = Cfg.cfg_maze_pet_info[l_pet_template_id]
  if l_cfg_maze_pet_info == nil then
    return -1, -1, -1
  end
  local l_elem = l_pet:GetPetFirstElement()
  local l_job = l_pet:GetJob()
  if l_job == nil then
    return -1, -1, -1
  end
  local attack_base = l_cfg_maze_pet_info.Attack
  local ak1 = self._mazeInfo.relic_attrs.attack_mul[0] or 0
  local ak2 = self._mazeInfo.relic_attrs.attack_mul[l_elem] or 0
  local ak3 = self._mazeInfo.relic_attrs.attack_mul[l_job] or 0
  local attack_mul = ak1 + ak2 + ak3
  local defense_base = l_cfg_maze_pet_info.Defence
  local df1 = self._mazeInfo.relic_attrs.defense_mul[0] or 0
  local df2 = self._mazeInfo.relic_attrs.defense_mul[l_elem] or 0
  local df3 = self._mazeInfo.relic_attrs.defense_mul[l_job] or 0
  local defense_mul = df1 + df2 + df3
  local max_hp_base = l_cfg_maze_pet_info.Health
  local hp1 = self._mazeInfo.relic_attrs.maxhp_mul[0] or 0
  local hp2 = self._mazeInfo.relic_attrs.maxhp_mul[l_elem] or 0
  local hp3 = self._mazeInfo.relic_attrs.maxhp_mul[l_job] or 0
  local max_hp_mul = hp1 + hp2 + hp3
  local attack = math.floor(attack_base * (1 + attack_mul))
  local defense = math.floor(defense_base * (1 + defense_mul))
  local max_hp = math.floor(max_hp_base * (1 + max_hp_mul))
  return attack, defense, max_hp
end

function MazeModule:GetCalPetMaxHp(pet_pst_id)
  local l_pet_module = GameGlobal.GameLogic():GetModule(PetModule)
  if l_pet_module == nil then
    return -1
  end
  local l_pet = l_pet_module:GetPet(pet_pst_id)
  if l_pet == nil then
    return -1
  end
  local l_pet_template_id = l_pet:GetTemplateID()
  if l_pet_template_id == nil or l_pet_template_id <= 0 then
    return -1
  end
  local l_cfg_maze_pet_info = Cfg.cfg_maze_pet_info[l_pet_template_id]
  if l_cfg_maze_pet_info == nil then
    return -1
  end
  local l_elem = l_pet:GetPetFirstElement()
  local l_job = l_pet:GetJob()
  if l_job == nil then
    return -1
  end
  local max_hp_base = l_cfg_maze_pet_info.Health
  local hp1 = self._mazeInfo.relic_attrs.maxhp_mul[0] or 0
  local hp2 = self._mazeInfo.relic_attrs.maxhp_mul[l_elem] or 0
  local hp3 = self._mazeInfo.relic_attrs.maxhp_mul[l_job] or 0
  local max_hp_mul = hp1 + hp2 + hp3
  return math.floor(max_hp_base * (1 + max_hp_mul) + 0.5)
end

function MazeModule:GetErrorMsg(result)
  local vecErrorMsg = {}
  vecErrorMsg[FORMATION_RESUTL_CODE.FORMATION_DIRTY_NAME] = StringTable.Get("str_maze_FORMATION_DIRTY_NAME")
  vecErrorMsg[FORMATION_RESUTL_CODE.FORMATION_DATA_INVALID] = StringTable.Get("str_maze_FORMATION_DATA_INVALID")
  vecErrorMsg[FORMATION_RESUTL_CODE.MAZE_FORMATION_PET_DEADED] = StringTable.Get("str_maze_MAZE_FORMATION_PET_DEADED")
  vecErrorMsg[FORMATION_RESUTL_CODE.FORMATION_NAME_BAN] = StringTable.Get("str_maze_FORMATION_NAME_BAN")
  local stErrorMsg = vecErrorMsg[result]
  if nil == stErrorMsg then
    return StringTable.Get("str_match_error_server_error")
  end
  return stErrorMsg
end
