_class("MonsterIDComponent", Object)
MonsterIDComponent = MonsterIDComponent

function MonsterIDComponent:Constructor(monsterID, raceType, nMonsterType, nGroupID, classID, campType)
  self._monsterID = monsterID
  self._raceType = raceType
  self._monsterType = nMonsterType
  self._campType = campType
  self._groupID = nGroupID
  self._classID = classID
  self._gridDownEnable = true
  self._outLineEnable = true
  self._multiHP = false
  self._multiHPData = {}
  self._multiHPStage = 1
  self._multiHPSwitchRound = {}
  self._isWorldBoss = false
  self._initStageHPData = {}
  self._initStageBuffData = {}
  self._initStageAttrData = {}
  self._curStage = 1
  self._curBeHitDamage = 0
  self._curRoundChangeStageCount = 0
  self._eliteIDArray = {}
  self._eliteIDArrayAttach = {}
  self._eliteIDArrayOri = {}
  self._monsterDamageSyncMonsterID = nil
  self._monsterDamageSyncFindType = nil
  self._snakeBodyEffectID = nil
  self._uiBossHPBarType = BossUIHPType.Normal
  self._auraRangeSkillID = nil
  self._auraGroupID = nil
  self._auraRange = {}
  self._doppelgangerValue = nil
  self._doppelgangerParam = {}
  self._skipComplateCondition = false
  self._moveGroupID = nil
  self._hasMoveGroupLine = false
end

function MonsterIDComponent:HasMoveGroupLine()
  return self._hasMoveGroupLine
end

function MonsterIDComponent:SetMoveGroupLineState(state)
  self._hasMoveGroupLine = state
end

function MonsterIDComponent:SetMoveGroupID(groupID)
  self._moveGroupID = groupID
end

function MonsterIDComponent:GetMoveGroupID()
  return self._moveGroupID
end

function MonsterIDComponent:SetAuraRangeData(auraRangeSkillID, groupID)
  self._auraRangeSkillID = auraRangeSkillID
  self._auraGroupID = groupID
end

function MonsterIDComponent:GetAuraRangeSkillID()
  return self._auraRangeSkillID
end

function MonsterIDComponent:GetAuraGroupID()
  return self._auraGroupID
end

function MonsterIDComponent:GetAuraRange()
  return self._auraRange
end

function MonsterIDComponent:SetAuraRange(range)
  self._auraRange = range
end

function MonsterIDComponent:SetUIBossHPBarType(type)
  if type then
    self._uiBossHPBarType = type
  end
end

function MonsterIDComponent:GetUIBossHPBarType()
  return self._uiBossHPBarType
end

function MonsterIDComponent:GetCampType()
  return self._campType
end

function MonsterIDComponent:SetSnakeBodyEffect(effectID)
  self._snakeBodyEffectID = effectID
end

function MonsterIDComponent:GetSnakeBodyEffectID()
  return self._snakeBodyEffectID
end

function MonsterIDComponent:SetDamageSyncMonsterID(monsterID)
  self._monsterDamageSyncMonsterID = monsterID
end

function MonsterIDComponent:SetDamageSyncFindType(findType)
  self._monsterDamageSyncFindType = findType
end

function MonsterIDComponent:GetDamageSyncFindType()
  return self._monsterDamageSyncFindType
end

function MonsterIDComponent:GetDamageSyncMonsterID()
  return self._monsterDamageSyncMonsterID
end

function MonsterIDComponent:SetDamageSyncEffect(effectID)
  self._monsterDamageSyncEffectID = effectID
end

function MonsterIDComponent:GetDamageSyncEffect()
  return self._monsterDamageSyncEffectID
end

function MonsterIDComponent:GetMonsterID()
  return self._monsterID
end

function MonsterIDComponent:GetMonsterClassID()
  return self._classID
end

function MonsterIDComponent:GetMonsterType()
  return self._monsterType
end

function MonsterIDComponent:GetMonsterGroupID()
  return self._groupID
end

function MonsterIDComponent:GetMonsterRaceType()
  return self._raceType
end

function MonsterIDComponent:GetMonsterBlockData()
  if MonsterRaceType.Fly == self._raceType then
    return BlockFlag.MonsterFly
  end
  return BlockFlag.MonsterLand
end

function MonsterIDComponent:IsNeedGridDown()
  return self._gridDownEnable
end

function MonsterIDComponent:SetNeedGridDownEnable(enable)
  self._gridDownEnable = enable
end

function MonsterIDComponent:IsNeedOutLine()
  return self._outLineEnable
end

function MonsterIDComponent:SetNeedOutLineEnable(enable)
  self._outLineEnable = enable
end

function MonsterIDComponent:InitWorldBossStageData(stageData)
  for _, v in ipairs(stageData) do
    local stageIndex = v.stage
    self._initStageHPData[stageIndex] = v.hp
    self._initStageBuffData[stageIndex] = {}
    for _, buffID in ipairs(v.buffIDList) do
      table.insert(self._initStageBuffData[stageIndex], buffID)
    end
    self._initStageAttrData[stageIndex] = table.cloneconf(v.attr)
  end
  self._curStage = 1
end

function MonsterIDComponent:AddMonsterBeHitDamage(damage)
  self._curBeHitDamage = self._curBeHitDamage + damage
end

function MonsterIDComponent:WorldBossSwitchStage()
  local needAddBuffList = {}
  local newAttrData
  if self._curBeHitDamage >= self._initStageHPData[self._curStage] and self._curStage < table.count(self._initStageHPData) then
    while self._curBeHitDamage >= self._initStageHPData[self._curStage] and self._curStage < table.count(self._initStageHPData) do
      self._curBeHitDamage = self._curBeHitDamage - self._initStageHPData[self._curStage]
      self._curStage = self._curStage + 1
      if self._curStage > table.count(self._initStageHPData) then
        self._curStage = table.count(self._initStageHPData)
      else
        self._curRoundChangeStageCount = self._curRoundChangeStageCount + 1
        local addBuffList = self._initStageBuffData[self._curStage]
        for _, buffID in ipairs(addBuffList) do
          table.insert(needAddBuffList, buffID)
        end
        local attrData = self._initStageAttrData[self._curStage]
        newAttrData = attrData
      end
    end
  end
  return needAddBuffList, newAttrData
end

function MonsterIDComponent:GetCurRoundChangeStageCount()
  return self._curRoundChangeStageCount
end

function MonsterIDComponent:ResetCurRoundChangeStageCount()
  self._curRoundChangeStageCount = 0
end

function MonsterIDComponent:SetWorldBossState(state)
  self._isWorldBoss = state
end

function MonsterIDComponent:IsWorldBoss()
  return self._isWorldBoss
end

function MonsterIDComponent:GetCurStage()
  return self._curStage
end

function MonsterIDComponent:SetEliteIDArray(t)
  self._eliteIDArray = t
  self._eliteIDArrayOri = table.cloneconf(t)
end

function MonsterIDComponent:GetEliteIDArray()
  return self._eliteIDArray
end

function MonsterIDComponent:IsEliteMonster()
  return #self._eliteIDArray > 0
end

function MonsterIDComponent:SetEliteIDArrayAttach(t)
  table.appendArray(self._eliteIDArrayAttach, t)
  table.appendArray(self._eliteIDArray, t)
end

function MonsterIDComponent:GetEliteIDArrayAttach()
  return self._eliteIDArrayAttach
end

function MonsterIDComponent:ClearEliteIDArrayAttach()
  if #self._eliteIDArrayAttach == 0 then
    return
  end
  self._eliteIDArrayAttach = {}
  self._eliteIDArray = table.cloneconf(self._eliteIDArrayOri)
end

function MonsterIDComponent:GetWorldBossStageAttrData(stage)
  local attrData = self._initStageAttrData[stage]
  return attrData
end

function MonsterIDComponent:GetWorldBossStageHPData(stage)
  local hp = self._initStageHPData[stage]
  return hp
end

function MonsterIDComponent:IsMultiHPMonster()
  return self._multiHP
end

function MonsterIDComponent:GetMultiHPStage()
  return self._multiHPStage
end

function MonsterIDComponent:HasNextMultiStageHPData()
  return self._multiHPStage < table.count(self._multiHPData)
end

function MonsterIDComponent:GetNextMultiStageHPData(curHP)
  local changeCount = 0
  while curHP <= 0 and self._multiHPStage < table.count(self._multiHPData) do
    self._multiHPStage = self._multiHPStage + 1
    local newHP = self._multiHPData[self._multiHPStage]
    curHP = curHP + newHP
    changeCount = changeCount + 1
  end
  return self._multiHPData[self._multiHPStage], curHP, self._multiHPStage, changeCount
end

function MonsterIDComponent:InitMultiHPData(hpData)
  self._multiHP = true
  for _, v in ipairs(hpData) do
    table.insert(self._multiHPData, v)
  end
  self._multiHPStage = 1
end

function MonsterIDComponent:AddMultiHPSwitchRound(round)
  table.insert(self._multiHPSwitchRound, round)
end

function MonsterIDComponent:IsRoundSwitchMultiHP(round)
  return table.intable(self._multiHPSwitchRound, round)
end

function MonsterIDComponent:GetDoppelgangerValue()
  return self._doppelgangerValue
end

function MonsterIDComponent:SetDoppelgangerValue(doppelganger)
  self._doppelgangerValue = doppelganger
end

function MonsterIDComponent:GetDoppelgangerParam()
  return self._doppelgangerParam or {}
end

function MonsterIDComponent:SetDoppelgangerParam(doppelgangerParam)
  self._doppelgangerParam = doppelgangerParam
end

function MonsterIDComponent:GetSkipComplateCondition()
  return self._skipComplateCondition
end

function MonsterIDComponent:SetSkipComplateCondition(skipComplateCondition)
  self._skipComplateCondition = skipComplateCondition
end

function Entity:MonsterID()
  return self:GetComponent(self.WEComponentsEnum.MonsterID)
end

function Entity:HasMonsterID()
  return self:HasComponent(self.WEComponentsEnum.MonsterID)
end

function Entity:AddMonsterID()
  local index = self.WEComponentsEnum.MonsterID
  local component = MonsterIDComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceMonsterID(monsterID, raceType, nMonsterType, nGroupID, monsterClassID, campType)
  local index = self.WEComponentsEnum.MonsterID
  local component = MonsterIDComponent:New(monsterID, raceType, nMonsterType, nGroupID, monsterClassID, campType)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMonsterID()
  if self:HasMonsterID() then
    self:RemoveComponent(self.WEComponentsEnum.MonsterID)
  end
end

function Entity:GetMonsterIDComponentEnum()
  local index = self.WEComponentsEnum.MonsterID
  return index
end

local MonsterSyncFindType = {MonsterClassID = 1, MonsterID = 2}
_enum("MonsterSyncFindType", MonsterSyncFindType)
