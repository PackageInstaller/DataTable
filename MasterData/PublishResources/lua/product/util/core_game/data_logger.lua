_class("DataLogger", Object)
DataLogger = DataLogger

function DataLogger:Constructor(world)
  self._world = world
  self._enabled = false
  self._logger = {}
  self._round = 0
  self._roundData = {}
  self._auroraData = {}
  self._maxPetBehitDamage = 0
  self._totalAddBlood = 0
  self._overflowAddBlood = 0
  self._chainSkillAddBlood = 0
  self._activeSkillAddBlood = 0
  self._alwaysAutoFight = 1
end

function DataLogger:EnableDataLog()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    return
  end
  self._enabled = false
end

function DataLogger:Dispose()
end

function DataLogger:GetLog()
  if not self._enabled then
    return ""
  end
  local t = table.toArray(DataPointType)
  table.sort(t)
  local logtb = {}
  for i, k in ipairs(t) do
    logtb[#logtb + 1] = self:_MakeLogString(k, self._logger[k])
  end
  local log = table.concat(logtb, ",")
  Log.debug("[DataLogger] ", log)
  return log
end

function DataLogger:_MakeLogString(key, value)
  if value == nil then
    return 0
  end
  local log = ""
  if type(value) == "table" then
    local t = {}
    for k, v in pairs(value) do
      local n1, n2 = math.modf(v)
      if n2 ~= 0 then
        v = v - v % 1.0E-4
      end
      t[#t + 1] = v
    end
    log = table.concat(t, "|")
  elseif type(value) == "number" then
    local n1, n2 = math.modf(value)
    if n2 ~= 0 then
      value = value - value % 0.01
    end
    log = value
  else
    log = value
  end
  return log
end

function DataLogger:AddDataLog(funcname, ...)
  if not self._enabled then
    return
  end
  self[funcname](self, ...)
end

function DataLogger:OnMatchEnd(teamid, loopid)
  self._logger[DataPointType.TeamId] = teamid
  self._logger[DataPointType.LoopId] = loopid
end

function DataLogger:OnBattleStart()
  self._battleStartTime = os.clock()
  self._logger[DataPointType.BattleStartTime] = os.date("%Y-%m-%d %H:%M:%S", os.time())
  self._logger[DataPointType.LevelId] = self._world.BW_WorldInfo.level_id
  self._logger[DataPointType.PlayerId] = tostring(self._world.BW_WorldInfo:GetPlayerPstID())
  self._logger[DataPointType.PlayerLevel] = self._world.BW_WorldInfo:GetPlayerLevel()
  self._logger[DataPointType.MatchType] = self._world:MatchType()
  local pets = self._world:GetLocalMatchPetList()
  local petIds = {
    0,
    0,
    0,
    0,
    0
  }
  local petAttacks = {
    0,
    0,
    0,
    0,
    0
  }
  local petDefenses = 0
  local petHealths = 0
  local petAwakes = {
    0,
    0,
    0,
    0,
    0
  }
  local petGrades = {
    0,
    0,
    0,
    0,
    0
  }
  local petEquips = {
    0,
    0,
    0,
    0,
    0
  }
  local petAffinitys = {
    0,
    0,
    0,
    0,
    0
  }
  local petLevels = {
    0,
    0,
    0,
    0,
    0
  }
  for i, pet in ipairs(pets) do
    petIds[i] = pet:GetTemplateID()
    petAttacks[i] = pet:GetPetAttack()
    petDefenses = petDefenses + pet:GetPetDefence()
    petHealths = petHealths + pet:GetPetHealth()
    petAwakes[i] = pet:GetPetAwakening()
    petGrades[i] = pet:GetPetGrade()
    petEquips[i] = pet:GetEquipLv()
    petAffinitys[i] = pet:GetPetAffinityLevel()
    petLevels[i] = pet:GetPetLevel()
  end
  self._logger[DataPointType.PetId] = petIds
  self._logger[DataPointType.PetAttack] = petAttacks
  self._logger[DataPointType.PetDefense] = petDefenses
  self._logger[DataPointType.PetHP] = petHealths
  self._logger[DataPointType.PetAwake] = petAwakes
  self._logger[DataPointType.PetGrade] = petGrades
  self._logger[DataPointType.PetEquip] = petEquips
  self._logger[DataPointType.PetAffinity] = petAffinitys
  self._logger[DataPointType.PetLevel] = petLevels
end

function DataLogger:OnBattleEnd()
  local battleStatCmpt = self._world:BattleStat()
  local pass = {
    0,
    0,
    0
  }
  local allStarConditions = self._world:BattleWorldEnterData():GetBonusCondition() or {}
  local cur3StarMatchResult = battleStatCmpt:GetBonusMatchResult()
  for i = 1, #allStarConditions do
    for _, conditionId in ipairs(cur3StarMatchResult) do
      if conditionId == allStarConditions[i] then
        pass[i] = 1
        break
      end
    end
  end
  local victory = battleStatCmpt:GetBattleLevelResult()
  local isFirstPass = 0
  if victory and not self._world.BW_WorldInfo.level_is_pass then
    isFirstPass = 1
  end
  if battleStatCmpt:GetAutoFight() == false then
    self._alwaysAutoFight = 0
  end
  self._logger[DataPointType.MatchResult] = victory and 1 or 0
  self._logger[DataPointType.OneStarPass] = pass[1]
  self._logger[DataPointType.TwoStarPass] = pass[2]
  self._logger[DataPointType.ThreeStarPass] = pass[3]
  self._logger[DataPointType.BattleEndTime] = os.date("%Y-%m-%d %H:%M:%S")
  self._logger[DataPointType.BattleTotalTime] = os.clock() - self._battleStartTime
  self._logger[DataPointType.BattleRoundCount] = self._round
  self._logger[DataPointType.IsFirstPassLevel] = isFirstPass
  self._logger[DataPointType.AlwaysAutoFight] = self._alwaysAutoFight
  local sumRoundTime = 0
  local sumLinkTime = 0
  local sumShowTime = 0
  local lowChainCount = 0
  for i, t in ipairs(self._roundData) do
    sumRoundTime = sumRoundTime + t.roundtime
    sumLinkTime = sumLinkTime + t.linktime
    sumShowTime = sumShowTime + t.showtime
    if t.chain and 3 >= t.chain then
      lowChainCount = lowChainCount + 1
    end
  end
  local avgRoundTime = sumRoundTime / self._round
  local avgLinkTime = sumLinkTime / self._round
  local avgShowTime = sumShowTime / self._round
  local lowChainRate = lowChainCount / self._round
  local varRoundTime = self:_Var(self._roundData, "roundtime")
  self._logger[DataPointType.AvgRoundTime] = avgRoundTime
  self._logger[DataPointType.AvgLinkTime] = avgLinkTime
  self._logger[DataPointType.AvgShowTime] = avgShowTime
  self._logger[DataPointType.LowChainRate] = lowChainRate
  self._logger[DataPointType.VarRoundTime] = varRoundTime
  self._logger[DataPointType.AuroraTimeCount] = #self._auroraData
  local maxChain = self:_Max(self._roundData, "chain")
  local avgChain = self:_Avg(self._roundData, "chain")
  local stdChain = self:_Std(self._roundData, "chain")
  self._logger[DataPointType.ChainMax] = maxChain
  self._logger[DataPointType.ChainAvg] = avgChain
  self._logger[DataPointType.ChainStd] = stdChain
  local maxCombo = self:_Max(self._roundData, "combo")
  local sumCombo = self:_Sum(self._roundData, "combo")
  local avgCombo = self:_Avg(self._roundData, "combo")
  self._logger[DataPointType.ComboMax] = maxCombo
  self._logger[DataPointType.ComboSum] = sumCombo
  self._logger[DataPointType.ComboAvg] = avgCombo
  local avgAuroraChain = self:_Avg(self._auroraData, "chain")
  self._logger[DataPointType.AuroraChainAvg] = avgAuroraChain
  local avgAuroraCombo = self:_Avg(self._auroraData, "combo")
  self._logger[DataPointType.AuroraComboAvg] = avgAuroraCombo
  local initConnectRate = 0
  if 0 < #self._roundData then
    initConnectRate = self._roundData[1].connectrate or 0
  end
  self._logger[DataPointType.InitConnectRate] = initConnectRate
  local avgConnectRate = self:_Avg(self._roundData, "connectrate")
  self._logger[DataPointType.ConnectRateAvg] = avgConnectRate
  local stdConnectRate = self:_Std(self._roundData, "connectrate")
  self._logger[DataPointType.ConnectRateStd] = stdConnectRate
  local normalSkillCount = 0
  local petNormalDamageSum = 0
  local petNormalSkillCount = {
    0,
    0,
    0,
    0,
    0
  }
  local petNormalDamage = {
    0,
    0,
    0,
    0,
    0
  }
  for i, t in ipairs(self._roundData) do
    t.sumNormalDamage = 0
    if t.normalskill then
      for i = 1, 5 do
        local d = t.normalskill[i]
        if 0 < d then
          normalSkillCount = normalSkillCount + 1
          petNormalSkillCount[i] = petNormalSkillCount[i] + 1
          petNormalDamage[i] = petNormalDamage[i] + d
          petNormalDamageSum = petNormalDamageSum + d
          t.sumNormalDamage = t.sumNormalDamage + d
        end
      end
    end
  end
  local petNormalDamageRate = {}
  for i = 1, 5 do
    petNormalDamageRate[i] = petNormalDamage[i] / petNormalDamageSum
  end
  local avgRoundNormalDamage = self:_Avg(self._roundData, "sumNormalDamage")
  local stdRoundNormalDamage = self:_Std(self._roundData, "sumNormalDamage")
  self._logger[DataPointType.PetNormalDamage] = petNormalDamage
  self._logger[DataPointType.PetNormalDamageRate] = petNormalDamageRate
  self._logger[DataPointType.SumNormalDamage] = petNormalDamageSum
  self._logger[DataPointType.AvgRoundNormalDamage] = avgRoundNormalDamage
  self._logger[DataPointType.StdRoundNormalDamage] = stdRoundNormalDamage
  local chainSkillCount = 0
  local chainSkillLevelSum = 0
  local chainSkillLevel = {
    0,
    0,
    0
  }
  local petChainSkillCount = {
    0,
    0,
    0,
    0,
    0
  }
  local petChainDamage = {
    0,
    0,
    0,
    0,
    0
  }
  local petChainDamageSum = 0
  for i, t in ipairs(self._roundData) do
    t.sumChainDamage = 0
    if t.chainskill then
      for i = 1, 5 do
        local d = t.chainskill[i]
        local v = t.chainlevel[i]
        if 0 < d then
          chainSkillCount = chainSkillCount + 1
          petChainSkillCount[i] = petChainSkillCount[i] + 1
          petChainDamage[i] = petChainDamage[i] + d
          petChainDamageSum = petChainDamageSum + d
          t.sumChainDamage = t.sumChainDamage + d
        end
        if 0 < v then
          chainSkillLevel[v] = chainSkillLevel[v] + 1
          chainSkillLevelSum = chainSkillLevelSum + v
        end
      end
    end
  end
  self._logger[DataPointType.ChainSkillFrequency] = chainSkillCount / self._round
  self._logger[DataPointType.ChainSkillStrength] = chainSkillLevelSum / chainSkillCount
  self._logger[DataPointType.ChainComboRealFrequency] = chainSkillLevel
  self._logger[DataPointType.PetChainSkillCount] = petChainSkillCount
  self._logger[DataPointType.PetChainSkillDamage] = petChainDamage
  self._logger[DataPointType.SumChainDamage] = petChainDamageSum
  local petChainDamageRate = {}
  for i = 1, 5 do
    petChainDamageRate[i] = petChainDamage[i] / petChainDamageSum
  end
  self._logger[DataPointType.PetChainSkillDamageRate] = petChainDamageRate
  local avgRoundChainDamage = self:_Avg(self._roundData, "sumChainDamage")
  local stdRoundChainDamage = self:_Std(self._roundData, "sumChainDamage")
  self._logger[DataPointType.AvgRoundChainDamage] = avgRoundChainDamage
  self._logger[DataPointType.StdRoundChainDamage] = stdRoundChainDamage
  local activeSkillCount = 0
  local petActiveDamageSum = 0
  local petActiveSkillCount = {
    0,
    0,
    0,
    0,
    0
  }
  local petActiveDamage = {
    0,
    0,
    0,
    0,
    0
  }
  for i, t in ipairs(self._roundData) do
    t.sumActiveDamage = 0
    if t.activeskill then
      for i = 1, 5 do
        local d = t.activeskill[i]
        if d then
          activeSkillCount = activeSkillCount + 1
          petActiveSkillCount[i] = petActiveSkillCount[i] + 1
          petActiveDamage[i] = petActiveDamage[i] + d
          petActiveDamageSum = petActiveDamageSum + d
          t.sumActiveDamage = t.sumActiveDamage + d
        end
      end
    end
  end
  self._logger[DataPointType.TeamActiveSkillDamage] = petActiveDamage
  self._logger[DataPointType.TeamActiveSkillCount] = petActiveSkillCount
  self._logger[DataPointType.ActiveSkillDamageSum] = petActiveDamageSum
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamMaxHP = teamEntity:Attributes():CalcMaxHp()
  self._logger[DataPointType.MaxPetBehitDamage] = self._maxPetBehitDamage / teamMaxHP
  local maxRoundPetBehitDamage = self:_Max(self._roundData, "petbehitval")
  self._logger[DataPointType.MaxRoundPetBehitDamage] = maxRoundPetBehitDamage / teamMaxHP
  local avgRoundPetBehitCount = self:_Avg(self._roundData, "petbehitcount")
  self._logger[DataPointType.AvgRoundPetBehitCount] = avgRoundPetBehitCount
  local avgRoundPetBehitVal = self:_Avg(self._roundData, "petbehitval")
  self._logger[DataPointType.AvgRoundPetBehitVal] = avgRoundPetBehitVal / teamMaxHP
  local totalDamage = petNormalDamageSum + petChainDamageSum + petActiveDamageSum
  local skillTypeRate = {
    petNormalDamageSum / totalDamage,
    petChainDamageSum / totalDamage,
    petActiveDamageSum / totalDamage
  }
  self._logger[DataPointType.DamageTypeRate] = skillTypeRate
  local petTotalDamageRate = {
    0,
    0,
    0,
    0,
    0
  }
  for i = 1, 5 do
    petTotalDamageRate[i] = (petNormalDamage[i] + petChainDamage[i] + petActiveDamage[i]) / totalDamage
  end
  self._logger[DataPointType.PetDamageRate] = petTotalDamageRate
  self._logger[DataPointType.AvgRoundPetDamage] = totalDamage / self._round
  local skillAddBlood = 0
  if 0 < self._totalAddBlood then
    skillAddBlood = self._chainSkillAddBlood / self._totalAddBlood
  end
  self._logger[DataPointType.AddBloodTotal] = self._totalAddBlood / teamMaxHP
  self._logger[DataPointType.ChainSkillAddBlood] = skillAddBlood
  self._logger[DataPointType.AddBloodSpilled] = self._overflowAddBlood / teamMaxHP
  if self._world:MatchType() == MatchType.MT_Maze then
    local mazePetBloods = {
      0,
      0,
      0,
      0,
      0
    }
    local mazePetPower = {
      0,
      0,
      0,
      0,
      0
    }
    local es = self._world:Player():GetLocalTeamEntity():Team():GetTeamPetEntities()
    for _, e in ipairs(es) do
      local slot = e:MatchPet():GetMatchPet():GetTeamSlot()
      mazePetPower[slot] = e:Attributes():GetAttribute("Power")
      local hp = e:Attributes():GetCurrentHP()
      mazePetBloods[slot] = hp / e:Attributes():CalcMaxHp()
    end
    local mazeCreateInfo = self._world.BW_WorldInfo.mazeCreateInfo
    self._logger[DataPointType.MazeLight] = self._world:GetService("Maze"):GetLightCount()
    self._logger[DataPointType.MazeLayer] = mazeCreateInfo.maze_layer
    self._logger[DataPointType.MazeVersion] = mazeCreateInfo.maze_version
    self._logger[DataPointType.MazeRoomIndex] = mazeCreateInfo.maze_room_index
    self._logger[DataPointType.MazePetBlood] = mazePetBloods
    self._logger[DataPointType.MazePetPower] = mazePetPower
  end
end

function DataLogger:OnRoundStart(connectRate)
  self._round = self._round + 1
  self._roundData[self._round] = {}
  self._roundData[self._round].roundtime = 0
  self._roundData[self._round].connectrate = connectRate
  self._roundData[self._round].chain = 0
  self._roundData[self._round].combo = 0
  self._roundData[self._round].petbehitval = 0
  self._roundData[self._round].petbehitcount = 0
  self._roundData[self._round].linktime = 0
  self._roundData[self._round].showtime = 0
  self._roundData[self._round].roundstart = os.clock()
end

function DataLogger:OnRoundEnd()
  local deltatime = os.clock() - self._roundData[self._round].roundstart
  self._roundData[self._round].roundtime = deltatime
end

function DataLogger:OnLinkStart()
  self._roundData[self._round].linkstart = os.clock()
end

function DataLogger:OnLinkEnd()
  if self._round == 0 then
    return
  end
  if not self._roundData[self._round].linkstart then
    return
  end
  local deltatime = os.clock() - self._roundData[self._round].linkstart
  self._roundData[self._round].linktime = deltatime
  self._roundData[self._round].linkstart = nil
end

function DataLogger:OnChainPath(chain, combo)
  self._roundData[self._round].chain = chain
  self._roundData[self._round].combo = combo
  if self._isAuroraTime then
    table.insert(self._auroraData, {chain = chain, combo = combo})
  end
end

function DataLogger:OnShowStart()
  self._roundData[self._round].showstart = os.clock()
end

function DataLogger:OnShowEnd()
  if self._round == 0 then
    return
  end
  if not self._roundData[self._round].showstart then
    return
  end
  local deltatime = os.clock() - self._roundData[self._round].showstart
  self._roundData[self._round].showtime = self._roundData[self._round].showtime + deltatime
  self._roundData[self._round].showstart = nil
end

function DataLogger:OnAuroraStart()
  self._isAuroraTime = true
end

function DataLogger:OnAuroraEnd()
  self._isAuroraTime = false
end

function DataLogger:OnNormalSkillEnd(petEntity, skillId, totalDamage)
  local data = self._roundData[self._round]
  if not data.normalskill then
    data.normalskill = {
      0,
      0,
      0,
      0,
      0
    }
  end
  local matchPet = petEntity:MatchPet():GetMatchPet()
  local slot = matchPet:GetTeamSlot()
  data.normalskill[slot] = data.normalskill[slot] + totalDamage
end

function DataLogger:OnChainSkillEnd(petEntity, skillId, totalDamage)
  local data = self._roundData[self._round]
  if not data.chainskill then
    data.chainskill = {
      0,
      0,
      0,
      0,
      0
    }
    data.chainlevel = {
      0,
      0,
      0,
      0,
      0
    }
  end
  local matchPet = petEntity:MatchPet():GetMatchPet()
  local slot = matchPet:GetTeamSlot()
  data.chainskill[slot] = data.chainskill[slot] + totalDamage
  local lv = petEntity:SkillInfo():GetChainSkillLevel(skillId)
  data.chainlevel[slot] = lv
end

function DataLogger:OnActiveSkillEnd(petEntity, skillId, totalDamage)
  local data = self._roundData[self._round]
  if not data.activeskill then
    data.activeskill = {}
  end
  local matchPet = petEntity:MatchPet():GetMatchPet()
  local slot = matchPet:GetTeamSlot()
  data.activeskill[slot] = (data.activeskill[slot] or 0) + totalDamage
end

function DataLogger:OnPetBehit(petEntity, totalDamage)
  if self._round == 0 then
    return
  end
  local data = self._roundData[self._round]
  data.petbehitval = data.petbehitval + totalDamage
  data.petbehitcount = data.petbehitcount + 1
  if totalDamage > self._maxPetBehitDamage then
    self._maxPetBehitDamage = totalDamage
  end
end

function DataLogger:OnPetAddBlood(addValue, overflowValue)
  if self._round == 0 then
    return
  end
  self._totalAddBlood = self._totalAddBlood + addValue
  self._overflowAddBlood = self._overflowAddBlood + overflowValue
end

function DataLogger:OnSkillAddBlood(skillType, entity, addValue)
  if skillType == SkillType.Chain then
    self._chainSkillAddBlood = self._chainSkillAddBlood + addValue
  elseif skillType == SkillType.Active then
    self._activeSkillAddBlood = self._activeSkillAddBlood + addValue
  end
end

function DataLogger:OnCancelAutoFight()
  self._alwaysAutoFight = 0
end

function DataLogger:_Min(t, field)
  if #t == 0 then
    return 0
  end
  local min = 0
  for i, v in ipairs(t) do
    if min > v[field] then
      min = v[field]
    end
  end
  return min
end

function DataLogger:_Max(t, field)
  if #t == 0 then
    return 0
  end
  local max = 0
  for i, v in ipairs(t) do
    if max < v[field] then
      max = v[field]
    end
  end
  return max
end

function DataLogger:_Sum(t, field)
  if #t == 0 then
    return 0
  end
  local sum = 0
  for i, v in ipairs(t) do
    sum = sum + v[field]
  end
  return sum
end

function DataLogger:_Avg(t, field)
  local n = #t
  if n == 0 then
    return 0
  end
  local sum = 0
  for i, v in ipairs(t) do
    sum = sum + v[field]
  end
  local avg = sum / n
  return avg
end

function DataLogger:_Var(t, field)
  local n = #t
  if n == 0 then
    return 0
  end
  local avg = self:_Avg(t, field)
  local sum = 0
  for i, v in ipairs(t) do
    sum = sum + (v[field] - avg) ^ 2
  end
  local var = sum / n
  return var
end

function DataLogger:_Std(t, field)
  if #t == 0 then
    return 0
  end
  return math.sqrt(self:_Var(t, field))
end
