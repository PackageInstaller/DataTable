require("base_service")
_class("Star3CalcService", BaseService)
Star3CalcService = Star3CalcService

function Star3CalcService:Constructor(world)
  self._3star_config = Cfg.cfg_threestarcondition
  self._trap_special_condition = {}
  self._trap_special_total_count_condition = {}
  for index, value in ipairs(self._3star_config) do
    if self:IsSpecialCondition(value.ConditionType) then
      self._trap_special_condition[index] = self:GetSpecialConditionData(value.ConditionNumber)
    elseif self:IsSpecialTotalCountCondition(value.ConditionType) then
      self._trap_special_total_count_condition[index] = self:GetSpecialConditionTotalData(value.ConditionNumber)
    end
  end
  self._3starProgressCalcFuncDic = {}
  self._3starProgressCalcFuncDic[BonusObjectiveType.NoAdditional] = self._CalcComplete
  self._3starProgressCalcFuncDic[BonusObjectiveType.Health] = self._CalcHealth
  self._3starProgressCalcFuncDic[BonusObjectiveType.LastWaveRoundNum] = self._CalcComplete
  self._3starProgressCalcFuncDic[BonusObjectiveType.SuperChainCount] = self._CalcSuperChainCount
  self._3starProgressCalcFuncDic[BonusObjectiveType.ActiveSkillCount] = self._CalcActiveSkillCount
  self._3starProgressCalcFuncDic[BonusObjectiveType.AllElementTeam] = self._CalcAllElementTeam
  self._3starProgressCalcFuncDic[BonusObjectiveType.SelectElement] = self._CalcSelectElement
  self._3starProgressCalcFuncDic[BonusObjectiveType.MatchNum] = self._CalcMatchNum
  self._3starProgressCalcFuncDic[BonusObjectiveType.TrapAttackTimes] = self._CalcTrapAttackTimes
  self._3starProgressCalcFuncDic[BonusObjectiveType.TrapAttackDammage] = self._CalcTrapAttackDamage
  self._3starProgressCalcFuncDic[BonusObjectiveType.TrapAttackTotalTimes] = self._CalcTrapAttackTotalTimes
  self._3starProgressCalcFuncDic[BonusObjectiveType.TrapAttackTotalDamage] = self._CalTrapAttackTotalDamage
  self._3starProgressCalcFuncDic[BonusObjectiveType.SmashTrapCount] = self._CalSmashTrapCount
  self._3starProgressCalcFuncDic[BonusObjectiveType.SmashTrapTotalCount] = self._CalSmashTrapTotalCount
  self._3starProgressCalcFuncDic[BonusObjectiveType.TotalMatchPropertyNum] = self._CalTotalMatchPropertyNum
  self._3starProgressCalcFuncDic[BonusObjectiveType.OnceMatchPropertyNum] = self._CalOnceMatchPropertyNum
  self._3starProgressCalcFuncDic[BonusObjectiveType.OnceMatchNorAttTimes] = self._CalOnceMatchNorAttTimes
  self._3starProgressCalcFuncDic[BonusObjectiveType.ColorSkillCount] = self._CalColorSkillCount
  self._3starProgressCalcFuncDic[BonusObjectiveType.AuroraTimeCount] = self._CalAuroraTimeCount
  self._3starProgressCalcFuncDic[BonusObjectiveType.PlayerBeHitCount] = self._CalPlayerBeHitCount
  self._3starProgressCalcFuncDic[BonusObjectiveType.CompelHelpPet] = self._CalCompelHelpPet
  self._3starProgressCalcFuncDic[BonusObjectiveType.ForbidHelpPet] = self._CalForbidHelpPet
  self._3starProgressCalcFuncDic[BonusObjectiveType.KillMonstersInLimitedRound] = self._CalKillMonstersInLimitedRound
  self._3starProgressCalcFuncDic[BonusObjectiveType.KillMonstersWithBuff] = self._CalKillMonstersWithBuff
  self._3starProgressCalcFuncDic[BonusObjectiveType.CollectItems] = self._CalCollectItems
  self._3starProgressCalcFuncDic[BonusObjectiveType.UIChangeTeamLeaderCount] = self._CalChangeTeamLeaderTimes
  self._3starProgressCalcFuncDic[BonusObjectiveType.MonsterEscapeLessThan] = self._CalMonsterEscapeLessThan
  self._3starProgressCalcFuncDic[BonusObjectiveType.PopStarNumber] = self._CalPopStarNumber
  self._3starProgressCalcFuncDic[BonusObjectiveType.BossHealth] = self._CalcBossHealth
end

function Star3CalcService:IsSpecialCondition(eConditionType)
  if eConditionType == BonusObjectiveType.TrapAttackTimes or eConditionType == BonusObjectiveType.TrapAttackDammage or eConditionType == BonusObjectiveType.SmashTrapCount then
    return true
  else
    return false
  end
end

function Star3CalcService:IsSpecialTotalCountCondition(eConditionType)
  if eConditionType == BonusObjectiveType.TrapAttackTotalTimes or eConditionType == BonusObjectiveType.TrapAttackTotalDamage or eConditionType == BonusObjectiveType.SmashTrapTotalCount then
    return true
  else
    return false
  end
end

function Star3CalcService:GetConditionNumber(conditionId)
  local value = self._3star_config[conditionId]
  if self:IsSpecialCondition(value.ConditionType) then
    return self._trap_special_condition[conditionId]
  end
  if self:IsSpecialTotalCountCondition(value.ConditionType) then
    return self._trap_special_total_count_condition[conditionId]
  end
  return value.ConditionNumber
end

function Star3CalcService:BeZeroProgress(conditionId)
  local conditionData = self._3star_config[conditionId]
  if conditionData == nil then
    Log.fatal("No config when BeZeroProgress id:", conditionId)
    return ""
  end
  local conditionType = conditionData.ConditionType
  if conditionType == BonusObjectiveType.Health then
    return "(0/1)"
  elseif conditionType == BonusObjectiveType.NoAdditional then
    return ""
  elseif self:IsSpecialCondition(conditionType) then
    return "(0/" .. tostring(#self._trap_special_condition[conditionId]) .. ")"
  elseif self:IsSpecialTotalCountCondition(conditionType) then
    return "(0/" .. tostring(self._trap_special_total_count_condition[conditionId].TotalCount) .. ")"
  elseif conditionType == BonusObjectiveType.SelectElement then
    return "(0/" .. conditionData.ConditionNumber[1] .. ")"
  elseif conditionType == BonusObjectiveType.KillMonstersInLimitedRound then
    return table.concat({
      "(0/",
      tostring(conditionData.ConditionNumber[1]),
      ")"
    })
  elseif conditionType == BonusObjectiveType.KillMonstersWithBuff then
    return table.concat({
      "(0/",
      tostring(conditionData.ConditionNumber[1]),
      ")"
    })
  elseif conditionType == BonusObjectiveType.HitBySkill then
    return table.concat({
      "(0/",
      tostring(conditionData.ConditionNumber[1]),
      ")"
    })
  elseif conditionType == BonusObjectiveType.BossHealth then
    return "(0/1)"
  end
  local conditionParam = conditionData.ConditionNumber[#conditionData.ConditionNumber]
  return "(0/" .. conditionParam .. ")"
end

function Star3CalcService:CalcProgress(conditionId)
  local conditionData = self._3star_config[conditionId]
  if conditionData == nil then
    Log.fatal("No config when CalcProgress id:", conditionId)
    return ""
  end
  local conditionType = conditionData.ConditionType
  local calcFunc = self._3starProgressCalcFuncDic[conditionType]
  if calcFunc ~= nil then
    local conditionParam = conditionData.ConditionNumber
    if self:IsSpecialCondition(conditionType) then
      conditionParam = self._trap_special_condition[conditionId]
    elseif self:IsSpecialTotalCountCondition(conditionType) then
      conditionParam = self._trap_special_total_count_condition[conditionId]
    end
    return calcFunc(self, conditionParam)
  else
    Log.fatal("No bonus calculator", conditionType)
  end
  return ""
end

function Star3CalcService:AutoTestCalcProgress(conditionType, conditionParam)
  local calcFunc = self._3starProgressCalcFuncDic[conditionType]
  return calcFunc(self, conditionParam)
end

function Star3CalcService:_CalcComplete(conditionParam)
  return ""
end

function Star3CalcService:_CalCompelHelpPet(conditionParam)
  return ""
end

function Star3CalcService:_CalForbidHelpPet(conditionParam)
  return ""
end

function Star3CalcService:_CalcHealth(conditionParam)
  local hpNumerator = tonumber(conditionParam[1])
  local targetPercent = hpNumerator / 100
  local playerEntity = self._world:Player():GetLocalTeamEntity()
  local attrCmpt = playerEntity:Attributes()
  local curHp = attrCmpt:GetCurrentHP()
  local maxHp = attrCmpt:CalcMaxHp()
  local curPercent = curHp / maxHp
  if targetPercent <= curPercent then
    return "(1/1)"
  else
    return "(0/1)"
  end
end

function Star3CalcService:_CalcSuperChainCount(conditionParam)
  local superChainCount = tonumber(conditionParam[1])
  local curSuperChainCount = self:_GetBattleStatComponent():GetSuperChainCount()
  if superChainCount >= curSuperChainCount then
    return "(" .. curSuperChainCount .. "/" .. superChainCount .. ")"
  else
    return "(" .. superChainCount .. "/" .. superChainCount .. ")"
  end
end

function Star3CalcService:_CalcActiveSkillCount(conditionParam)
  local activeSkillCount = tonumber(conditionParam[1])
  local curActiveSkillCount = self:_GetBattleStatComponent():GetActiveSkillCount()
  if activeSkillCount == 0 then
    if curActiveSkillCount == 0 then
      return "(1/1)"
    else
      return "(0/1)"
    end
  elseif activeSkillCount >= curActiveSkillCount then
    return "(" .. curActiveSkillCount .. "/" .. activeSkillCount .. ")"
  else
    return "(" .. activeSkillCount .. "/" .. activeSkillCount .. ")"
  end
end

function Star3CalcService:_CalcAllElementTeam(conditionParam)
  local teamElement = {}
  local joinedPlayerInfo = self._world:BattleWorldEnterData():GetLocalPlayerInfo()
  for petIndex, petinfo in ipairs(joinedPlayerInfo.pet_list) do
    local petPstID = petinfo.pet_pstid
    local petData = self._world:BattleWorldEnterData():GetPetData(petPstID)
    local elementType = petData:GetPetFirstElement()
    teamElement[#teamElement + 1] = elementType
  end
  local hasBlue = table.icontains(teamElement, ElementType.ElementType_Blue)
  if not hasBlue then
    return "(0/1)"
  end
  local hasRed = table.icontains(teamElement, ElementType.ElementType_Red)
  if not hasRed then
    return "(0/1)"
  end
  local hasGreen = table.icontains(teamElement, ElementType.ElementType_Green)
  if not hasGreen then
    return "(0/1)"
  end
  local hasYellow = table.icontains(teamElement, ElementType.ElementType_Yellow)
  if not hasYellow then
    return "(0/1)"
  end
  return "(1/1)"
end

function Star3CalcService:_CalcSelectElement(conditionParam)
  local memCount = tonumber(conditionParam[1])
  local memElement = tonumber(conditionParam[2])
  local curCount = 0
  local joinedPlayerInfo = self._world:BattleWorldEnterData():GetLocalPlayerInfo()
  for petIndex, petinfo in ipairs(joinedPlayerInfo.pet_list) do
    local petPstID = petinfo.pet_pstid
    local petData = self._world:BattleWorldEnterData():GetPetData(petPstID)
    local elementType = petData:GetPetFirstElement()
    if elementType == memElement then
      curCount = curCount + 1
    end
  end
  if memCount >= curCount then
    return "(" .. curCount .. "/" .. memCount .. ")"
  else
    return "(" .. memCount .. "/" .. memCount .. ")"
  end
end

function Star3CalcService:_CalcMatchNum(conditionParam)
  local matchType = tonumber(conditionParam[1])
  local matchParam = tonumber(conditionParam[2])
  local battleStateCmpt = self:_GetBattleStatComponent()
  if matchType == 1 then
    local oneMatchNum = battleStateCmpt:GetOneMatchMaxNum()
    if matchParam >= oneMatchNum then
      return "(" .. oneMatchNum .. "/" .. matchParam .. ")"
    else
      return "(" .. matchParam .. "/" .. matchParam .. ")"
    end
  elseif matchType == 2 then
    local totalMatchNum = battleStateCmpt:GetTotalMatchNum()
    if matchParam >= totalMatchNum then
      return "(" .. totalMatchNum .. "/" .. matchParam .. ")"
    else
      return "(" .. matchParam .. "/" .. matchParam .. ")"
    end
  elseif matchType == 3 then
    local elementMatchArray = battleStateCmpt:GetElementMatchNum()
    for index, value in ipairs(elementMatchArray) do
      if value ~= 0 then
        if matchParam >= value then
          return "(" .. value .. "/" .. matchParam .. ")"
        else
          return "(" .. matchParam .. "/" .. matchParam .. ")"
        end
      end
    end
  end
end

function Star3CalcService:_CalTotalMatchPropertyNum(conditionParam)
  local l_PieceType = tonumber(conditionParam[1])
  local l_MatchNum = tonumber(conditionParam[2])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local elementMatchArray = battleStateCmpt:GetElementMatchNum()
  local l_value = elementMatchArray[l_PieceType]
  if l_value ~= nil and 0 < l_value then
    if l_MatchNum < l_value then
      l_value = l_MatchNum
    end
    return "(" .. tostring(l_value) .. "/" .. tostring(l_MatchNum) .. ")"
  end
  return "(0/" .. tostring(l_MatchNum) .. ")"
end

function Star3CalcService:_CalOnceMatchPropertyNum(conditionParam)
  local l_PieceType = tonumber(conditionParam[1])
  local l_MatchNum = tonumber(conditionParam[2])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local battleState_type = battleStateCmpt:GetOneMatchMaxNumType()
  local battleState_MatChNum = battleStateCmpt:GetOneMatchMaxNum()
  if 0 < battleState_MatChNum and battleState_type == l_PieceType then
    if l_MatchNum < battleState_MatChNum then
      battleState_MatChNum = l_MatchNum
    end
    return "(" .. tostring(battleState_MatChNum) .. "/" .. tostring(l_MatchNum) .. ")"
  end
  return "(0/" .. tostring(l_MatchNum) .. ")"
end

function Star3CalcService:_CalcTrapAttackTimes(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local trap_attack_times = battleStateCmpt:GetTakeAttackTimesByTrap()
  local nCondCount = 0
  for key, value in pairs(conditionParam) do
    if trap_attack_times[key] ~= nil and value <= trap_attack_times[key] then
      nCondCount = nCondCount + 1
    end
  end
  return "(" .. tostring(nCondCount) .. "/" .. tostring(#conditionParam) .. ")"
end

function Star3CalcService:_CalcTrapAttackDamage(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local trap_attack_damage = battleStateCmpt:GetTakeAttackDamageByTrap()
  local nCondCount = 0
  for key, value in pairs(conditionParam) do
    if trap_attack_damage[key] ~= nil and value <= trap_attack_damage[key] then
      nCondCount = nCondCount + 1
    end
  end
  return "(" .. tostring(nCondCount) .. "/" .. tostring(#conditionParam) .. ")"
end

function Star3CalcService:_CalcTrapAttackTotalTimes(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local trap_attack_times = battleStateCmpt:GetTakeAttackTimesByTrap()
  local nCondCount = 0
  for key, value in pairs(conditionParam) do
    if key ~= "TotalCount" and trap_attack_times[key] ~= nil then
      nCondCount = nCondCount + trap_attack_times[key]
    end
  end
  return "(" .. tostring(nCondCount) .. "/" .. tostring(conditionParam.TotalCount) .. ")"
end

function Star3CalcService:_CalTrapAttackTotalDamage(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local trap_attack_damage = battleStateCmpt:GetTakeAttackDamageByTrap()
  local nTotalDamage = 0
  for key, value in pairs(conditionParam) do
    if key ~= "TotalCount" and trap_attack_damage[key] ~= nil then
      nTotalDamage = nTotalDamage + trap_attack_damage[key]
    end
  end
  return "(" .. tostring(nTotalDamage) .. "/" .. tostring(conditionParam.TotalCount) .. ")"
end

function Star3CalcService:_CalSmashTrapCount(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local smash_trap_count = battleStateCmpt:GetSmashTrapCount()
  local nCondCount = 0
  for key, value in pairs(conditionParam) do
    if smash_trap_count[key] ~= nil and value <= smash_trap_count[key] then
      nCondCount = nCondCount + 1
    end
  end
  return "(" .. tostring(nCondCount) .. "/" .. tostring(#conditionParam) .. ")"
end

function Star3CalcService:_CalSmashTrapTotalCount(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local smash_trap_count = battleStateCmpt:GetSmashTrapCount()
  local nTotalSmashCount = 0
  for key, value in pairs(conditionParam) do
    if key ~= "TotalCount" and smash_trap_count[key] ~= nil then
      nTotalSmashCount = nTotalSmashCount + smash_trap_count[key]
    end
  end
  return "(" .. tostring(nTotalSmashCount) .. "/" .. tostring(conditionParam.TotalCount) .. ")"
end

function Star3CalcService:_CalOnceMatchNorAttTimes(conditionParam)
  local nNorAttTimes = tonumber(conditionParam[1])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local nOneChainNormalAttackCount = battleStateCmpt:GetOneChainNormalAttackCount()
  if nNorAttTimes < nOneChainNormalAttackCount then
    nOneChainNormalAttackCount = nNorAttTimes
  end
  return "(" .. tostring(nOneChainNormalAttackCount) .. "/" .. tostring(nNorAttTimes) .. ")"
end

function Star3CalcService:_CalColorSkillCount(conditionParam)
  local nColorSkillCount = tonumber(conditionParam[1])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local nCmptColorSkillCount = battleStateCmpt:GetColorSkillCount()
  if nColorSkillCount < nCmptColorSkillCount then
    nCmptColorSkillCount = nColorSkillCount
  end
  return "(" .. tostring(nCmptColorSkillCount) .. "/" .. tostring(nColorSkillCount) .. ")"
end

function Star3CalcService:_CalAuroraTimeCount(conditionParam)
  local x = tonumber(conditionParam[1])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local cnt = battleStateCmpt:GetAuroraTimeCount()
  if x < cnt then
    cnt = x
  end
  return "(" .. tostring(cnt) .. "/" .. tostring(x) .. ")"
end

function Star3CalcService:_CalPlayerBeHitCount(conditionParam)
  local x = tonumber(conditionParam[1])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local cnt = battleStateCmpt:GetPlayerBeHitCount()
  if x < cnt then
    cnt = x
  end
  return "(" .. tostring(cnt) .. "/" .. tostring(x) .. ")"
end

function Star3CalcService:_CalKillMonstersInLimitedRound(conditionParam)
  local parser = ObjectiveConditionParamParser:New()
  local param = parser:ParseObjectiveConditionParam(BonusObjectiveType.KillMonstersInLimitedRound, conditionParam)
  local bonusCalcSvc = self._world:GetService("BonusCalc")
  local result = bonusCalcSvc:_CalKillMonstersInLimitedRound(param)
  return result and "(1/1)" or "(0/1)"
end

function Star3CalcService:_CalKillMonstersWithBuff(conditionParam)
  local parser = ObjectiveConditionParamParser:New()
  local param = parser:ParseObjectiveConditionParam(BonusObjectiveType.KillMonstersWithBuff, conditionParam)
  local bonusCalcSvc = self._world:GetService("BonusCalc")
  local _isPass, count, requireCount = bonusCalcSvc:_CalKillMonstersWithBuff(param)
  return table.concat({
    "(",
    count,
    "/",
    requireCount,
    ")"
  })
end

function Star3CalcService:_CalCollectItems(conditionParam)
  local parser = ObjectiveConditionParamParser:New()
  local param = parser:ParseObjectiveConditionParam(BonusObjectiveType.CollectItems, conditionParam)
  local bonusCalcSvc = self._world:GetService("BonusCalc")
  local _isPass, count, requireCount = bonusCalcSvc:_CalCollectItems(param)
  return table.concat({
    "(",
    count,
    "/",
    requireCount,
    ")"
  })
end

function Star3CalcService:_CalChangeTeamLeaderTimes(conditionParam)
  local parser = ObjectiveConditionParamParser:New()
  local param = parser:ParseObjectiveConditionParam(BonusObjectiveType.UIChangeTeamLeaderCount, conditionParam)
  local bonusCalcSvc = self._world:GetService("BonusCalc")
  local _isPass, count, requireCount = bonusCalcSvc:_CalChangeTeamLeaderTimes(param)
  return table.concat({
    "(",
    count,
    "/",
    requireCount,
    ")"
  })
end

function Star3CalcService:_CalMonsterEscapeLessThan(conditionParam)
  local parser = ObjectiveConditionParamParser:New()
  local param = parser:ParseObjectiveConditionParam(BonusObjectiveType.MonsterEscapeLessThan, conditionParam)
  local bonusCalcSvc = self._world:GetService("BonusCalc")
  local isPass, count, maxCount = bonusCalcSvc:_CalMonsterEscapeLessThan(param)
  if maxCount < count then
    count = maxCount
  end
  return table.concat({
    "(",
    count,
    "/",
    maxCount,
    ")"
  })
end

function Star3CalcService:_CalChessDeadPlayerPawnCount(conditionParam)
  local parser = ObjectiveConditionParamParser:New()
  local param = parser:ParseObjectiveConditionParam(BonusObjectiveType.ChessDeadPlayerPawnCount, conditionParam)
  local bonusCalcSvc = self._world:GetService("BonusCalc")
  local _isPass, count, requireCount = bonusCalcSvc:_CalChessDeadPlayerPawnCount(param)
  return table.concat({
    "(",
    count,
    "/",
    requireCount,
    ")"
  })
end

function Star3CalcService:_CalHitBySkill(conditionParam)
  local parser = ObjectiveConditionParamParser:New()
  local param = parser:ParseObjectiveConditionParam(BonusObjectiveType.HitBySkill, conditionParam)
  local bonusCalcSvc = self._world:GetService("BonusCalc")
  local _isPass, count, requireCount = bonusCalcSvc:_CalHitBySkill(param)
  return table.concat({
    "(",
    count,
    "/",
    requireCount,
    ")"
  })
end

function Star3CalcService:_CalPopStarNumber(conditionParam)
  local parser = ObjectiveConditionParamParser:New()
  local param = parser:ParseObjectiveConditionParam(BonusObjectiveType.PopStarNumber, conditionParam)
  local bonusCalcSvc = self._world:GetService("BonusCalc")
  local isPass, count, requireCount = bonusCalcSvc:CalPopStarNumber(param)
  return table.concat({
    "(",
    count,
    "/",
    requireCount,
    ")"
  })
end

function Star3CalcService:GetSpecialConditionData(conditionData)
  local arrTrapCond = {}
  for _, value in ipairs(conditionData) do
    local TrapCond = table.tonumber(string.split(value, ","))
    if table.count(TrapCond) == 2 then
      arrTrapCond[TrapCond[1]] = TrapCond[2]
    end
  end
  return arrTrapCond
end

function Star3CalcService:GetSpecialConditionTotalData(conditionData)
  local arrTrapCond = {}
  if table.count(conditionData) ~= 2 then
    return arrTrapCond
  end
  local TrapArray = table.tonumber(string.split(conditionData[1], ","))
  for _, value in ipairs(TrapArray) do
    arrTrapCond[value] = true
  end
  arrTrapCond.TotalCount = tonumber(conditionData[2])
  return arrTrapCond
end

function Star3CalcService:Calc3StarProgress()
  local battleStatCmpt = self._world:BattleStat()
  if self._world:MatchType() == MatchType.MT_Mission then
    local threeStarConditions = self._configService:GetMission3StarCondition(self._world.BW_WorldInfo.missionID)
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  elseif self._world:MatchType() == MatchType.MT_Campaign then
    local threeStarConditions = self._configService:GetCampaignMission3StarCondition(self._world.BW_WorldInfo.missionID)
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  elseif self._world:MatchType() == MatchType.MT_ExtMission then
    local threeStarConditions = self._configService:GetExtMission3StarCondition(self._world.BW_WorldInfo.ext_mission_task_id)
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  elseif self._world:MatchType() == MatchType.MT_Season then
    local threeStarConditions = self._configService:GetSeasonMission3StarCondition(self._world.BW_WorldInfo.missionID)
    local star3CalcService = self._world:GetService("Star3Calc")
    for _, conditionId in ipairs(threeStarConditions) do
      local ret = star3CalcService:CalcProgress(conditionId)
      battleStatCmpt:UpdateA3StarProgress(conditionId, ret)
    end
  end
end

function Star3CalcService:_CalcBossHealth(conditionParam)
  local hpNumerator = tonumber(conditionParam[1])
  local targetPercent = hpNumerator / 100
  local gBoss = self._world:GetGroup(self._world.BW_WEMatchers.Boss)
  local eBossList = gBoss:GetEntities()
  if eBossList and table.count(eBossList) > 0 then
    for i, e in ipairs(eBossList) do
      if not e:HasDeadMark() then
        local curHp = e:Attributes():GetCurrentHP()
        local maxHp = e:Attributes():CalcMaxHp()
        local curPercent = curHp / maxHp
        if targetPercent >= curPercent then
          return "(1/1)"
        else
          return "(0/1)"
        end
      else
        return "(1/1)"
      end
    end
  end
  return "(0/1)"
end
