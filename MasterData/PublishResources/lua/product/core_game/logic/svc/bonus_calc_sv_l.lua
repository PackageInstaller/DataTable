_class("BonusCalcService", BaseService)
BonusCalcService = BonusCalcService

function BonusCalcService:Constructor(world)
  self._bonusConditionFuncDic = {}
  self._bonusConditionFuncDic[BonusObjectiveType.NoAdditional] = self._NoAdditional
  self._bonusConditionFuncDic[BonusObjectiveType.Health] = self._CalcHealth
  self._bonusConditionFuncDic[BonusObjectiveType.LastWaveRoundNum] = self._CalcLastWaveRoundNum
  self._bonusConditionFuncDic[BonusObjectiveType.SuperChainCount] = self._CalcSuperChainCount
  self._bonusConditionFuncDic[BonusObjectiveType.ActiveSkillCount] = self._CalcActiveSkillCount
  self._bonusConditionFuncDic[BonusObjectiveType.AllElementTeam] = self._CalcAllElementTeam
  self._bonusConditionFuncDic[BonusObjectiveType.SelectElement] = self._CalcSelectElement
  self._bonusConditionFuncDic[BonusObjectiveType.MatchNum] = self._CalcMatchNum
  self._bonusConditionFuncDic[BonusObjectiveType.TrapAttackTimes] = self._CalcTrapAttackTimes
  self._bonusConditionFuncDic[BonusObjectiveType.TrapAttackDammage] = self._CalcTrapAttackDammage
  self._bonusConditionFuncDic[BonusObjectiveType.TrapAttackTotalTimes] = self._CalcTrapAttackTotalTimes
  self._bonusConditionFuncDic[BonusObjectiveType.TrapAttackTotalDamage] = self._CalTrapAttackTotalDamage
  self._bonusConditionFuncDic[BonusObjectiveType.SmashTrapCount] = self._CalSmashTrapCount
  self._bonusConditionFuncDic[BonusObjectiveType.SmashTrapTotalCount] = self._CalSmashTrapTotalCount
  self._bonusConditionFuncDic[BonusObjectiveType.TotalMatchPropertyNum] = self._CalTotalMatchPropertyNum
  self._bonusConditionFuncDic[BonusObjectiveType.OnceMatchPropertyNum] = self._CalOnceMatchPropertyNum
  self._bonusConditionFuncDic[BonusObjectiveType.OnceMatchNorAttTimes] = self._CalOnceMatchNorAttTimes
  self._bonusConditionFuncDic[BonusObjectiveType.ColorSkillCount] = self._CalColorSkillCount
  self._bonusConditionFuncDic[BonusObjectiveType.AuroraTimeCount] = self._CalAuroraTimeCount
  self._bonusConditionFuncDic[BonusObjectiveType.PlayerBeHitCount] = self._CalPlayerBeHitCount
  self._bonusConditionFuncDic[BonusObjectiveType.CompelHelpPet] = self._CalCompelHelpPet
  self._bonusConditionFuncDic[BonusObjectiveType.ForbidHelpPet] = self._CalForbidHelpPet
  self._bonusConditionFuncDic[BonusObjectiveType.KillMonstersInLimitedRound] = self._CalKillMonstersInLimitedRound
  self._bonusConditionFuncDic[BonusObjectiveType.KillMonstersWithBuff] = self._CalKillMonstersWithBuff
  self._bonusConditionFuncDic[BonusObjectiveType.CollectItems] = self._CalCollectItems
  self._bonusConditionFuncDic[BonusObjectiveType.UIChangeTeamLeaderCount] = self._CalChangeTeamLeaderTimes
  self._bonusConditionFuncDic[BonusObjectiveType.HitBySkill] = self._CalHitBySkill
  self._bonusConditionFuncDic[BonusObjectiveType.ChessDeadPlayerPawnCount] = self._CalChessDeadPlayerPawnCount
  self._bonusConditionFuncDic[BonusObjectiveType.MonsterEscapeLessThan] = self._CalMonsterEscapeLessThan
  self._bonusConditionFuncDic[BonusObjectiveType.PopStarNumber] = self.CalPopStarNumber
  self._bonusConditionFuncDic[BonusObjectiveType.BossHealth] = self._CalcBossHealth
end

function BonusCalcService:CalcCondition(conditionType, conditionParam)
  local calcFunc = self._bonusConditionFuncDic[conditionType]
  if calcFunc ~= nil then
    return calcFunc(self, conditionParam)
  else
    Log.fatal("No bonus calculator", conditionType)
  end
  return false
end

function BonusCalcService:_NoAdditional()
  return self:_GetBattleStatComponent():GetBattleLevelResult()
end

function BonusCalcService:_CalCompelHelpPet()
  local bComplete = self:_GetBattleStatComponent():GetBattleLevelResult()
  if bComplete then
    return self._world:IsHaveHelpPet()
  end
  return bComplete
end

function BonusCalcService:_CalForbidHelpPet()
  local bComplete = self:_GetBattleStatComponent():GetBattleLevelResult()
  if bComplete then
    return not self._world:IsHaveHelpPet()
  end
  return bComplete
end

function BonusCalcService:_CalcHealth(conditionParam)
  local calcDamageService = self._world:GetService("CalcDamage")
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  if teamEntity == nil then
    return false
  end
  local curHp, maxHp = calcDamageService:GetTeamLogicHP(teamEntity)
  local targetPercent = conditionParam / 100
  local curPercent = curHp / maxHp
  if targetPercent <= curPercent then
    return true
  end
  return false
end

function BonusCalcService:_CalcLastWaveRoundNum(conditionParam)
  local leftWaveCount = self:_GetBattleStatComponent()._curWaveLeftRoundCount
  local needCount = tonumber(conditionParam[1])
  if leftWaveCount >= needCount then
    return true
  else
    return false
  end
end

function BonusCalcService:_CalcSuperChainCount(conditionParam)
  local superChainCount = tonumber(conditionParam[1])
  local curSuperChainCount = self:_GetBattleStatComponent():GetSuperChainCount()
  if superChainCount <= curSuperChainCount then
    return true
  end
  return false
end

function BonusCalcService:_CalcActiveSkillCount(conditionParam)
  local activeSkillCount = tonumber(conditionParam[1])
  local curActiveSkillCount = self:_GetBattleStatComponent():GetActiveSkillCount()
  if activeSkillCount <= curActiveSkillCount then
    return true
  end
  return false
end

function BonusCalcService:_CalcAllElementTeam(conditionParam)
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
    return false
  end
  local hasRed = table.icontains(teamElement, ElementType.ElementType_Red)
  if not hasRed then
    return false
  end
  local hasGreen = table.icontains(teamElement, ElementType.ElementType_Green)
  if not hasGreen then
    return false
  end
  local hasYellow = table.icontains(teamElement, ElementType.ElementType_Yellow)
  if not hasYellow then
    return false
  end
  return true
end

function BonusCalcService:_CalcSelectElement(conditionParam)
  local memCount = tonumber(conditionParam[1])
  local memElement = tonumber(conditionParam[2])
  local curCount = 0
  local joinedPlayerInfo = self._world:BattleWorldEnterData():GetLocalPlayerInfo()
  for petIndex, petInfo in ipairs(joinedPlayerInfo.pet_list) do
    local petPstID = petInfo.pet_pstid
    local petData = self._world:BattleWorldEnterData():GetPetData(petPstID)
    local elementType = petData:GetPetFirstElement()
    if elementType == memElement then
      curCount = curCount + 1
    end
  end
  if memCount <= curCount then
    return true
  end
  return false
end

function BonusCalcService:_CalcMatchNum(conditionParam)
  local matchType = tonumber(conditionParam[1])
  local matchParam = tonumber(conditionParam[2])
  if matchType == 1 then
    local oneMatchNum = self:_GetBattleStatComponent():GetOneMatchMaxNum()
    if matchParam <= oneMatchNum then
      return true
    end
  elseif matchType == 2 then
    local totalMatchNum = self:_GetBattleStatComponent():GetTotalMatchNum()
    if matchParam <= totalMatchNum then
      return true
    end
  elseif matchType == 3 then
    local elementMatchArray = self:_GetBattleStatComponent():GetElementMatchNum()
    for k, v in pairs(elementMatchArray) do
      if v >= matchParam then
        return true
      end
    end
  end
  return false
end

function BonusCalcService:_CalTotalMatchPropertyNum(conditionParam)
  local l_PieceType = tonumber(conditionParam[1])
  local l_MatchNum = tonumber(conditionParam[2])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local elementMatchArray = battleStateCmpt:GetElementMatchNum()
  local l_value = elementMatchArray[l_PieceType]
  if l_value ~= nil and l_MatchNum <= l_value then
    return true
  end
  return false
end

function BonusCalcService:_CalOnceMatchPropertyNum(conditionParam)
  local l_PieceType = tonumber(conditionParam[1])
  local l_MatchNum = tonumber(conditionParam[2])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local battleState_type = battleStateCmpt:GetOneMatchMaxNumType()
  local battleState_MatChNum = battleStateCmpt:GetOneMatchMaxNum()
  if l_MatchNum <= battleState_MatChNum and battleState_type == l_PieceType then
    return true
  end
  return false
end

function BonusCalcService:_CalcTrapAttackTimes(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local trap_attack_times = battleStateCmpt:GetTakeAttackTimesByTrap()
  for key, value in pairs(conditionParam) do
    if trap_attack_times[key] ~= nil and value <= trap_attack_times[key] then
      return false
    end
  end
  return true
end

function BonusCalcService:_CalcTrapAttackDammage(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local trap_attack_damage = battleStateCmpt:GetTakeAttackDamageByTrap()
  for key, value in pairs(conditionParam) do
    if trap_attack_damage[key] ~= nil and value <= trap_attack_damage[key] then
      return false
    end
  end
  return true
end

function BonusCalcService:_CalcTrapAttackTotalTimes(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local trap_attack_times = battleStateCmpt:GetTakeAttackTimesByTrap()
  local nCondCount = 0
  for key, value in pairs(conditionParam) do
    if key ~= "TotalCount" and trap_attack_times[key] ~= nil then
      nCondCount = nCondCount + trap_attack_times[key]
    end
  end
  if nCondCount >= conditionParam.TotalCount then
    return false
  else
    return true
  end
end

function BonusCalcService:_CalTrapAttackTotalDamage(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local trap_attack_damage = battleStateCmpt:GetTakeAttackDamageByTrap()
  local nTotalDamage = 0
  for key, value in pairs(conditionParam) do
    if key ~= "TotalCount" and trap_attack_damage[key] ~= nil then
      nTotalDamage = nTotalDamage + trap_attack_damage[key]
    end
  end
  if nTotalDamage >= conditionParam.TotalCount then
    return false
  else
    return true
  end
end

function BonusCalcService:_CalSmashTrapCount(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local smash_trap_count = battleStateCmpt:GetSmashTrapCount()
  local bIsFinish = true
  for key, value in pairs(conditionParam) do
    if smash_trap_count[key] == nil or value > smash_trap_count[key] then
      bIsFinish = false
      break
    end
  end
  return bIsFinish
end

function BonusCalcService:_CalSmashTrapTotalCount(conditionParam)
  local battleStateCmpt = self:_GetBattleStatComponent()
  local smash_trap_count = battleStateCmpt:GetSmashTrapCount()
  local nTotalSmashCount = 0
  for key, value in pairs(conditionParam) do
    if key ~= "TotalCount" and smash_trap_count[key] ~= nil then
      nTotalSmashCount = nTotalSmashCount + smash_trap_count[key]
    end
  end
  if nTotalSmashCount >= conditionParam.TotalCount then
    return true
  else
    return false
  end
end

function BonusCalcService:_CalOnceMatchNorAttTimes(conditionParam)
  local nNorAttTimes = tonumber(conditionParam[1])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local nOneChainNormalAttackCount = battleStateCmpt:GetOneChainNormalAttackCount()
  if nNorAttTimes <= nOneChainNormalAttackCount then
    return true
  end
  return false
end

function BonusCalcService:_CalColorSkillCount(conditionParam)
  local nColorSkillCount = tonumber(conditionParam[1])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local nCmptColorSkillCount = battleStateCmpt:GetColorSkillCount()
  if nColorSkillCount <= nCmptColorSkillCount then
    return true
  end
  return false
end

function BonusCalcService:_CalAuroraTimeCount(conditionParam)
  local x = tonumber(conditionParam[1])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local cnt = battleStateCmpt:GetAuroraTimeCount()
  if x <= cnt then
    return true
  end
  return false
end

function BonusCalcService:_CalPlayerBeHitCount(conditionParam)
  local x = tonumber(conditionParam[1])
  local battleStateCmpt = self:_GetBattleStatComponent()
  local cnt = battleStateCmpt:GetPlayerBeHitCount()
  if x > cnt then
    return true
  end
  return false
end

function BonusCalcService:_CalKillMonstersInLimitedRound(conditionParam)
  local roundLimit = conditionParam.roundLimit
  local tBossID = conditionParam.tBossID
  local isAllMonsterKilled = true
  local globalMonsterGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(globalMonsterGroup) do
    if table.icontains(tBossID, e:MonsterID():GetMonsterID()) and isAllMonsterKilled then
      isAllMonsterKilled = e:HasDeadMark()
    end
  end
  local battleStatCmpt = self._world:BattleStat()
  local curWaveDeadMonsterParam = battleStatCmpt:GetCurWaveDeadMonsterParam()
  if isAllMonsterKilled then
    for _, param in ipairs(curWaveDeadMonsterParam) do
      if table.icontains(tBossID, param:GetMonsterID()) then
        isAllMonsterKilled = isAllMonsterKilled and roundLimit >= param:GetDeadWave()
      end
    end
  end
  return isAllMonsterKilled
end

function BonusCalcService:_CalKillMonstersWithBuff(param)
  local requireCount = param.requireCount
  local tBossID = param.tBossID
  local tBuffID = param.tBuffID
  local count = 0
  local battleStatCmpt = self._world:BattleStat()
  local totalDeadMonsterBuffInfo = battleStatCmpt:GetTotalDeadMonsterBuffInfo()
  for _, monsterID in ipairs(tBossID) do
    if totalDeadMonsterBuffInfo[monsterID] then
      local tBuffInfo = totalDeadMonsterBuffInfo[monsterID]
      if #tBuffInfo ~= 0 then
        for _, info in ipairs(tBuffInfo) do
          local union = table.union(tBuffID, info.buffIDs)
          if 0 < #union then
            count = count + 1
          end
        end
      end
    end
  end
  count = math.min(count, requireCount)
  return requireCount <= count, count, requireCount
end

function BonusCalcService:_CalCollectItems(param)
  local maxCollectCount = param.count
  local curCollectNum = self._world:BattleStat():GetDropCollectNumByItemID(param.id)
  return maxCollectCount <= curCollectNum, curCollectNum, maxCollectCount
end

function BonusCalcService:_CalChangeTeamLeaderTimes(param)
  local maxCount = param.count
  local count = self._world:BattleStat():GetTeamLeaderChangeNum()
  return maxCount >= count, count, maxCount
end

function BonusCalcService:_CalMonsterEscapeLessThan(param)
  local maxCount = param.count
  local count = self._world:BattleStat():GetMonsterEscapeNum()
  return maxCount > count, count, maxCount
end

function BonusCalcService:_CalHitBySkill(param)
  local skillID = param.skillID
  local requireCount = param.count
  local count = self._world:BattleStat():GetPlayerSkillHitCount(skillID)
  return requireCount >= count, count, requireCount
end

function BonusCalcService:_CalChessDeadPlayerPawnCount(param)
  local requireCount = param.count
  local count = self._world:BattleStat():GetChessDeadPlayerPawnCount()
  return requireCount >= count, count, requireCount
end

function BonusCalcService:CalPopStarNumber(param)
  local requireNum = tonumber(param[1])
  local popStarSvc = self._world:GetService("PopStarLogic")
  if not popStarSvc and self._world:IsDevelopEnv() then
    Log.exception("！！！三星条件或胜利条件配置错误，使用了消灭星星模式特有的条件！！！")
  end
  local curNum = popStarSvc:GetPopGridNum()
  return requireNum <= curNum, curNum, requireNum
end

function BonusCalcService:CalcBonusObjective()
  local bonusCalcService = self._world:GetService("BonusCalc")
  local star3CalcService = self._world:GetService("Star3Calc")
  local conditionParser = ObjectiveConditionParamParser:New()
  local calcResultArray = {}
  local conditionIDArray = self._world:BattleWorldEnterData():GetBonusCondition()
  for _, conditionID in ipairs(conditionIDArray) do
    local conditionData = Cfg.cfg_threestarcondition[conditionID]
    if conditionData == nil then
      return
    end
    local conditionType = conditionData.ConditionType
    local conditionParamArray = star3CalcService:GetConditionNumber(conditionID)
    local conditionParam = conditionParser:ParseObjectiveConditionParam(conditionType, conditionParamArray)
    if conditionParam == nil then
      calcResultArray[#calcResultArray + 1] = conditionID
    else
      local matchRes = bonusCalcService:CalcCondition(conditionType, conditionParam)
      if matchRes == true then
        calcResultArray[#calcResultArray + 1] = conditionID
      end
    end
  end
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SetBonusMatchResult(calcResultArray)
end

function BonusCalcService:_CalcBossHealth(conditionParam)
  local gBoss = self._world:GetGroup(self._world.BW_WEMatchers.Boss)
  local eBossList = gBoss:GetEntities()
  if eBossList and table.count(eBossList) > 0 then
    for i, e in ipairs(eBossList) do
      if not e:HasDeadMark() then
        local curHp = e:Attributes():GetCurrentHP()
        local maxHp = e:Attributes():CalcMaxHp()
        local targetPercent = conditionParam / 100
        local curPercent = curHp / maxHp
        if targetPercent >= curPercent then
          return true
        else
          return false
        end
      else
        return false
      end
    end
  else
    return false
  end
  return false
end
