_class("AnipopModule", GameModule)
AnipopModule = AnipopModule

function AnipopModule:Constructor()
  self._anipopInfo = nil
  self.end_time = 0
end

function AnipopModule:GetAniPopInfo()
  return self._anipopInfo
end

function AnipopModule:SetAnipopInfo(_info)
  self._anipopInfo = _info
end

function AnipopModule:SetAnipopRoundInfo(_info)
  self._anipopInfo.round_info = _info
end

function AnipopModule:Init()
  self.caller:RegisterPushHandler(CEventNotifyAnipopInfo, self.HandleAnipopInfoChange, self)
  self.caller:RegisterPushHandler(CEventNotifyAnipopRoundInfo, self.HandleAnipopRoundInfoChange, self)
end

function AnipopModule:HandleAnipopInfoChange(msg)
  self:SetAnipopInfo(msg.data)
  self.end_time = msg.end_time
end

function AnipopModule:HandleAnipopRoundInfoChange(msg)
  self._anipopInfo.relic_info = msg.relic_info
  self:SetAnipopRoundInfo(msg.data)
end

function AnipopModule:RequestAnipopInfo(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestAnipopInfo)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_ret)
  return res, replyEvent
end

function AnipopModule:SelectHard(TT, hard_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(AnipopSelectHardReq)
  request.hard_id = hard_id
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == 0 then
    self._anipopInfo.round_info = replyEvent.round_info
  end
  return res
end

function AnipopModule:UpdateAnipopFormationInfo(TT, formation_id, formation_name, pet_list)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyChangeAnipopFormationReq)
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

function AnipopModule:Balance(TT, hard_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestAnipopBalance)
  request.hard_id = hard_id
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent.round_info
end

function AnipopModule:GetReward(TT, req_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(AnipopRewardReq)
  request.req_id = req_id
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == 0 then
    self._anipopInfo.week_info = replyEvent.week_info
  end
  return res, replyEvent.rewards
end

function AnipopModule:_SetFormationInfos(formation_info)
  self._anipopInfo.formation_info = formation_info
end

function AnipopModule:GetFormationInfo()
  return self._anipopInfo.formation_info
end

function AnipopModule:RequestSelectRelic(TT, relicid)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestAnipopSelectRelic)
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
  if replyEvent.m_ret == 0 then
    self._anipopInfo.relic_info = replyEvent.relic_info
  end
  return res, replyEvent.relics
end

function AnipopModule:AnipopConvertRelic(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(AnipopConvertRelicReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == 0 then
    self._anipopInfo.relic_info = replyEvent.relic_info
  end
  return res, replyEvent.relics
end

function AnipopModule:AnipopUseRelic(TT, relic_id)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(AnipopUseRelicReq)
  request.relic_id = relic_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == 0 then
    self._anipopInfo.relic_info = replyEvent.relic_info
  end
  return res, replyEvent.relics
end

function AnipopModule:AnipopChangeSkill(TT, skill_relic_id)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(AnipopChangeSkillReq)
  request.skill_relic_id = skill_relic_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-3)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == 0 then
    self._anipopInfo.relic_info = replyEvent.relic_info
  end
  return res
end

function AnipopModule:SingleMatch(mission_index, teamid)
  local game = GameGlobal.GetModule(GameMatchModule)
  local info = AnipopMissionCreateInfo:New()
  info.mission_index = mission_index
  game:StartMatch(MatchType.MT_PopStarPro, teamid, info)
end

function AnipopModule:GetLevelMonsterList(missionIndex)
  local curRoundInfo = self._anipopInfo.round_info
  local levelInfo = curRoundInfo.level_list[missionIndex]
  local levelID = 0
  local missionCfg = Cfg.cfg_anipop_fight_level[levelInfo.level_id]
  if missionCfg then
    levelID = missionCfg.LevelID
  end
  local waveRandoms = levelInfo.wave_randoms
  local cfg = Cfg.cfg_level[levelID]
  if cfg == nil then
    Log.exception("找不到关卡：", levelID)
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
    local ww = waveRandoms[2 * i - 1] * totalw
    for j, w in ipairs(monsterWeight) do
      ww = ww - w
      if ww <= 0 then
        monsterRefreshId = monsterRIds[j]
        break
      end
    end
    local monsters
    local refreshMonsterCfg = Cfg.cfg_refresh_monster[monsterRefreshId]
    if refreshMonsterCfg.RandomMonsterIDList then
      local monsterList = table.cloneconf(refreshMonsterCfg.RandomMonsterIDList)
      local weightList = table.cloneconf(refreshMonsterCfg.RandomWeightList)
      weightList = weightList or self:_MakeDefaultRandomWeightList(monsterList)
      monsters = self:_ParseRandomMonsterID(monsterList, weightList, waveRandoms)
    else
      monsters = table.cloneconf(refreshMonsterCfg.MonsterIDList)
    end
    table.appendArray(ret, monsters)
  end
  ret = table.unique(ret)
  return ret
end

function AnipopModule:_MakeDefaultRandomWeightList(monsterList)
  local weightList = {}
  for index, value in ipairs(monsterList) do
    local monsterGroup = value
    local weightGroup = {}
    for groupIndex, monsterID in ipairs(monsterGroup) do
      table.insert(weightGroup, 1)
    end
    table.insert(weightList, weightGroup)
  end
  return weightList
end

function AnipopModule:_ParseRandomMonsterID(monsterList, weightList, waveRandoms)
  local monsterIDList = {}
  if #monsterList ~= #weightList then
    return monsterIDList
  end
  for i = 1, #monsterList do
    local monsterGroup = monsterList[i]
    local weightGroup = weightList[i]
    local totalWeight = 0
    for _, w in ipairs(weightGroup) do
      totalWeight = totalWeight + w
    end
    local index = math.fmod(i - 1, #waveRandoms) + 1
    local rand = waveRandoms[index]
    local curWeight = rand * totalWeight
    for i, w in ipairs(weightGroup) do
      curWeight = curWeight - w
      if curWeight <= 0 then
        table.insert(monsterIDList, monsterGroup[i])
        break
      end
    end
  end
  return monsterIDList
end

function AnipopModule:GetPetPower(pet_pstid)
  local max = self:_GetPetPowerLimit(pet_pstid)
  local roundInfo = self._anipopInfo.round_info
  local l_pet_info = roundInfo.pet_info[pet_pstid]
  if l_pet_info then
    return l_pet_info.power, max
  end
  return -1, max
end

function AnipopModule:_GetPetPowerLimit(pet_pstid)
  local petMd = GameGlobal:GetInstance().GetModule(PetModule)
  local pet = petMd:GetPet(pet_pstid)
  if not pet then
    return 0
  end
  local activeSkillID = pet:GetPetActiveSkill()
  local cfg = BattleSkillCfg(activeSkillID)
  return cfg.TriggerParam
end

function AnipopModule:GetCalPetADH(pet_pst_id)
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
  local ak1 = self._anipopInfo.relic_info.relic_attrs.attack_mul[0] or 0
  local ak2 = self._anipopInfo.relic_info.relic_attrs.attack_mul[l_elem] or 0
  local ak3 = self._anipopInfo.relic_info.relic_attrs.attack_mul[l_job] or 0
  local attack_mul = ak1 + ak2 + ak3
  local defense_base = l_cfg_maze_pet_info.Defence
  local df1 = self._anipopInfo.relic_info.relic_attrs.defense_mul[0] or 0
  local df2 = self._anipopInfo.relic_info.relic_attrs.defense_mul[l_elem] or 0
  local df3 = self._anipopInfo.relic_info.relic_attrs.defense_mul[l_job] or 0
  local defense_mul = df1 + df2 + df3
  local max_hp_base = l_cfg_maze_pet_info.Health
  local hp1 = self._anipopInfo.relic_info.relic_attrs.maxhp_mul[0] or 0
  local hp2 = self._anipopInfo.relic_info.relic_attrs.maxhp_mul[l_elem] or 0
  local hp3 = self._anipopInfo.relic_info.relic_attrs.maxhp_mul[l_job] or 0
  local max_hp_mul = hp1 + hp2 + hp3
  local attack = math.floor(attack_base * (1 + attack_mul))
  local defense = math.floor(defense_base * (1 + defense_mul))
  local max_hp = math.floor(max_hp_base * (1 + max_hp_mul))
  return attack, defense, max_hp
end
