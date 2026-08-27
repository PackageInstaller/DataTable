local GuardMonsterCasterSkill = class("GuardMonsterCasterSkill", LuaSkillBase)
local Stack = require("Framework.Lib.Stack")
local base = LuaSkillBase
GuardMonsterCasterSkill.config = {
  effectId1 = 10263,
  buffId_196 = 196,
  buffId_1033 = 1033,
  buffId_175 = 175,
  buffId_88 = 88,
  skill_time = 18,
  buffId_513101 = 513101,
  casterWaveInterval = 375,
  countDownDuration = 75,
  latestAtkEffect = 12006,
  monsterBornInterval = 38,
  campNotBeSelectBuff = 50,
  beforeBornEffectTime = 36,
  bornEffectId = 70000
}

function GuardMonsterCasterSkill:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "GuardMonsterCasterSkill_start", 0, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "GuardMonsterCasterSkill_roleDie", 1, self.OnRoleDie)
  self.aliveMonsterList = {}
  self.isAbleCallNextWave = true
end

function GuardMonsterCasterSkill:OnRoleDie(killer, role, killSkill)
  if role.belongNum == self.caster.belongNum then
    table.removebyvalue(self.aliveMonsterList, role)
  end
  if not self:IsAbleToCallNextWaveByManual() then
    return
  end
  self.loopCasterTimer:Start()
  if self.loopCallBeforeBornEffectTimer ~= nil then
    self.loopCallBeforeBornEffectTimer:Start()
  end
end

function GuardMonsterCasterSkill:IsAbleToCallNextWave(nextWave)
  nextWave = nextWave or self.waveRound
  if nextWave > self.maxWave or self.maxIndexPerWave[nextWave] == nil or self.maxIndexPerWave[nextWave] <= 0 or 0 >= self.totalRoleCount then
    return false
  end
  return true
end

function GuardMonsterCasterSkill:IsAbleToCallNextWaveByManual(curWave)
  curWave = curWave or self.waveRound
  if #self.aliveMonsterList > 0 or curWave >= self.maxWave or self.maxIndexPerWave[curWave] == nil or 0 < self.maxIndexPerWave[curWave] or 0 >= self.totalRoleCount then
    return false
  end
  return true
end

function GuardMonsterCasterSkill:OnAfterBattleStart()
  self.roleTag = LuaSkillCtrl:GetRoleTag(self.caster)
  self:MakeUpCampRole()
  self:MakeUpWaitToCasterMonsters()
  self.delayTimerDictPerWave = {}
  self.waveRound = 0
  self.loopCasterTimer = LuaSkillCtrl:StartTimer(nil, self.config.casterWaveInterval, self.LoopCaster, self, -1, self.config.casterWaveInterval)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1033, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_88, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_175, 1, nil, true)
end

function GuardMonsterCasterSkill:SetNextWaveCasterRemainTime(value, overideInterval)
  if value == nil then
    return
  end
  if self.loopCasterTimer == nil then
    return
  end
  self.loopCasterTimer.left = value
  if overideInterval then
    self.loopCasterTimer.delay = value
  end
  if value > self.config.beforeBornEffectTime and overideInterval then
    local tempTime = value - self.config.beforeBornEffectTime
    if self.loopCallBeforeBornEffectTimer ~= nil then
      self.loopCallBeforeBornEffectTimer.left = tempTime
    else
      self.loopCallBeforeBornEffectTimer = LuaSkillCtrl:StartTimer(nil, tempTime, self.CreateBeforeBornEffect, self)
    end
    self.loopCallBeforeBornEffectTimer:Pause()
  end
end

function GuardMonsterCasterSkill:CreateBeforeBornEffect(skill)
  LuaSkillCtrl:CallEffect(self.caster, self.config.bornEffectId, self)
end

function GuardMonsterCasterSkill:MakeUpWaitToCasterMonsters()
  local battleRoomId = LuaSkillCtrl:GetBattleRoomId()
  local monsterTeamCfg = ConfigData.defend_monster_team[battleRoomId]
  local monsters = LuaSkillCtrl:GetAllWaitToCasteMonsters()
  local tempMonsters = {}
  self.waveIntervals = {}
  self.curMonsters = {}
  self.maxIndexPerWave = {}
  self.maxRoleCount = 0
  self.maxWave = 0
  self.bornPosList = {}
  for i = 0, monsters.Count - 1 do
    local monsterData = monsters[i]
    local roleTag = monsterData.roleTag
    if roleTag == self.roleTag then
      self.maxRoleCount = self.maxRoleCount + 1
      local monsterCfg
      if monsterTeamCfg ~= nil then
        monsterCfg = monsterTeamCfg[monsterData.uid]
      end
      local wave, intervalPerWave, eachBornDelay, index
      if monsterCfg ~= nil and monsterCfg.monster_id == monsterData.dataId then
        wave = monsterCfg.wave_Index
        intervalPerWave = monsterCfg.wave_interval
        eachBornDelay = monsterCfg.wave_offset
        index = monsterCfg.wave_monster_id
      else
        wave, intervalPerWave, eachBornDelay, index = self:GetMonsterBornData(monsterData.roleWave)
      end
      if self.curMonsters[wave] == nil then
        self.curMonsters[wave] = {}
      end
      local bornPos = BattleUtil.XYCoord2Pos(monsterData.x, monsterData.y)
      if self.curMonsters[wave][bornPos] == nil then
        self.curMonsters[wave][bornPos] = {}
      end
      if not table.contain(self.bornPosList, bornPos) then
        table.insert(self.bornPosList, bornPos)
      end
      if self.maxIndexPerWave[wave] == nil then
        self.maxIndexPerWave[wave] = 0
        self.waveIntervals[wave] = 0
      end
      self.maxIndexPerWave[wave] = self.maxIndexPerWave[wave] + 1
      if intervalPerWave > self.waveIntervals[wave] then
        self.waveIntervals[wave] = intervalPerWave + (self.roleTag - 1)
      end
      if wave > self.maxWave then
        self.maxWave = wave
      end
      local tempMonsters = self.curMonsters[wave]
      for _, v in pairs(tempMonsters) do
        for _, v2 in pairs(v) do
          if v2.bornDelay == eachBornDelay then
            eachBornDelay = eachBornDelay + 1
          end
        end
      end
      local roleModel = {
        role = monsterData,
        index = index,
        wave = wave,
        bornDelay = eachBornDelay
      }
      table.insert(self.curMonsters[wave][bornPos], roleModel)
    end
  end
  self.totalRoleCount = self.maxRoleCount
  for tempWave = 1, self.maxWave do
    local curGroupMonster = self.curMonsters[tempWave]
    if curGroupMonster ~= nil then
      for _, tempPos in ipairs(self.bornPosList) do
        if curGroupMonster[tempPos] ~= nil then
          table.sort(curGroupMonster[tempPos], function(a, b)
            return a.index > b.index
          end)
          local tempRoles = curGroupMonster[tempPos]
          curGroupMonster[tempPos] = Stack.New()
          for _, v in ipairs(tempRoles) do
            curGroupMonster[tempPos]:Push(v)
          end
        end
      end
    end
  end
end

function GuardMonsterCasterSkill:GetMonsterBornData(rawWave)
  local tempWave = rawWave // 10
  local eachBornDelay = 0
  local arg = 1
  local intervalPerWave = 0
  if 99 < rawWave then
    tempWave = rawWave // 10000000
    eachBornDelay = rawWave % 1000
    intervalPerWave = rawWave % 1000000 // 1000
    arg = 1000000
  else
    tempWave = rawWave // 10
  end
  local index = rawWave // arg % 10
  return tempWave, intervalPerWave, eachBornDelay, index
end

function GuardMonsterCasterSkill:MakeUpCampRole()
  local campRoles = LuaSkillCtrl:GetAllPlayerDungeonRoles()
  self.campRole = nil
  if campRoles.Count > 0 then
    self.campRole = campRoles[0]
  end
end

function GuardMonsterCasterSkill:GetWaveRoles(wave)
  local roles = self.allWaveMonsters[wave]
  return roles
end

function GuardMonsterCasterSkill:GetCampRole()
  return self.campRole
end

function GuardMonsterCasterSkill:LoopCaster()
  self:ClearLastWaveCaster()
  if table.count(self.curMonsters) < 1 then
    return
  end
  self.waveRound = self.waveRound + 1
  while self.curMonsters[self.waveRound] == nil do
    self.waveRound = self.waveRound + 1
  end
  if self:IsAbleToCallNextWave() then
    local nextWaveInterval = self.waveIntervals[self.waveRound]
    if nextWaveInterval ~= nil and 0 < nextWaveInterval then
      self:SetNextWaveCasterRemainTime(nextWaveInterval, true)
    end
  end
  local beforeTime = self.config.skill_time
  if self.waveRound == 1 then
    beforeTime = 12
  end
  local callRealCaster = BindCallback(self, self.CallRealCaster)
  LuaSkillCtrl:StartTimer(self, beforeTime, callRealCaster)
  self.loopCasterTimer:Pause()
end

function GuardMonsterCasterSkill:ClearLastWaveCaster()
  if self.casteForEachTagTimer ~= nil then
    self.casteForEachTagTimer:Stop()
    self.casteForEachTagTimer = nil
  end
  self:StopCurWaveDeloyBornTimer(self.waveRound)
  if self.waveRound <= 0 then
    return
  end
  local curTagWaveMonsters = self.curMonsters[self.waveRound]
  if curTagWaveMonsters == nil then
    return
  end
  for _, tempPos in ipairs(self.bornPosList) do
    if curTagWaveMonsters[tempPos] ~= nil then
      local count = curTagWaveMonsters[tempPos]:Count()
      if 0 < count then
        curTagWaveMonsters[tempPos]:Clear()
      end
      self.totalRoleCount = self.totalRoleCount - count
    end
  end
  self.maxIndexPerWave[self.waveRound] = 0
end

function GuardMonsterCasterSkill:CallRealCaster()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  local noMonsterCasted = false
  local loopCasterCount = self.maxIndexPerWave[self.waveRound]
  if loopCasterCount ~= nil and 0 < loopCasterCount and 0 < self.totalRoleCount then
    self.casteForEachTagTimer = LuaSkillCtrl:StartTimer(nil, self.config.monsterBornInterval, BindCallback(self, self.CasteMonsterForeach), nil, -1, self.config.monsterBornInterval)
  else
    noMonsterCasted = true
  end
  if self.waveRound >= self.maxWave then
    if self.loopCasterTimer ~= nil then
      self.loopCasterTimer:Stop()
      self.loopCasterTimer = nil
    end
    if noMonsterCasted then
      self:KillSelf()
    end
  end
end

function GuardMonsterCasterSkill:StopCurWaveDeloyBornTimer(curWave)
  if self.delayTimerDictPerWave == nil or self.delayTimerDictPerWave[curWave] == nil then
    return
  end
  local curTimers = self.delayTimerDictPerWave[curWave]
  for k, v in pairs(curTimers) do
    local timerPerPos = v
    if timerPerPos ~= nil then
      timerPerPos:Stop()
    end
  end
  self.delayTimerDictPerWave[curWave] = nil
end

function GuardMonsterCasterSkill:StopAllBornTimer()
  if self.maxWave == nil then
    return
  end
  for i = 0, self.maxWave do
    self:StopCurWaveDeloyBornTimer(i)
  end
end

function GuardMonsterCasterSkill:CasteMonsterForeach()
  local curMaxIndex = self.maxIndexPerWave[self.waveRound]
  if curMaxIndex == nil or curMaxIndex <= 0 then
    if self.casteForEachTagTimer ~= nil then
      self.casteForEachTagTimer:Stop()
      self.casteForEachTagTimer = nil
    end
    self:StopCurWaveDeloyBornTimer(self.waveRound)
    return
  end
  local tempMonsterBorntable = self.curMonsters[self.waveRound]
  if tempMonsterBorntable == nil then
    return
  end
  local delayTimers = self.delayTimerDictPerWave[self.waveRound]
  if delayTimers == nil then
    delayTimers = {}
    self.delayTimerDictPerWave[self.waveRound] = delayTimers
  end
  for _, tempPos in ipairs(self.bornPosList) do
    local tempMonsterStack = tempMonsterBorntable[tempPos]
    self:RealCallGuardMonster(tempMonsterStack, tempPos, delayTimers)
  end
end

function GuardMonsterCasterSkill:RealCallGuardMonster(tempMonsterStack, tempPos, delayTimers)
  if tempMonsterStack == nil or tempMonsterStack:Count() <= 0 then
    return
  end
  local tempMonsterData = tempMonsterStack:Pop()
  local coord = BattleUtil.XYCoord2Pos(tempMonsterData.role.x, tempMonsterData.role.y)
  local delayTime = tempMonsterData.bornDelay
  if delayTime <= 0 then
    self:CreateGuardMonster(tempMonsterStack, tempMonsterData)
  else
    local timer = LuaSkillCtrl:StartTimer(nil, delayTime, BindCallback(self, self.CreateGuardMonster, tempMonsterStack, tempMonsterData), nil)
    table.insert(delayTimers, timer)
  end
  self:RealCallGuardMonster(tempMonsterStack, tempPos, delayTimers)
end

function GuardMonsterCasterSkill:CreateGuardMonster(tempMonsterStack, tempMonsterData)
  local role = LuaSkillCtrl:CreateMonster(tempMonsterData.role, self, nil)
  if role == nil then
    return
  end
  local bloodNum = tempMonsterData.role:GetBossBloodNum()
  if 0 < bloodNum then
    role.recordTable.isTowerBoss = true
  end
  self.maxIndexPerWave[self.waveRound] = self.maxIndexPerWave[self.waveRound] - 1
  self.totalRoleCount = self.totalRoleCount - 1
  self:OnMonsterCastered(role)
  table.insert(self.aliveMonsterList, role)
end

function GuardMonsterCasterSkill:KillSelf()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_88, 0)
  LuaSkillCtrl:RemoveLife(self.caster.hp + 1, self, self.caster, false, nil, true, true, nil, true)
end

function GuardMonsterCasterSkill:OnMonsterCastered(role)
  local skillMgrComp = role:GetSkillComponent()
  if skillMgrComp ~= nil then
    skillMgrComp:BroadCastRoleAfterBattleStartTrigger(true)
  end
  if self.totalRoleCount <= 0 then
    self:KillSelf()
  end
end

function GuardMonsterCasterSkill:OnCasterDie()
end

function GuardMonsterCasterSkill:LuaDispose()
  base.LuaDispose(self)
  self.maxIndexPerWave = nil
  self.aliveMonsterList = nil
  self.allCampRoles = nil
  self.curMonsters = nil
  self.waveIntervals = nil
  self:StopAllBornTimer()
  self.delayTimerDictPerWave = nil
  if self.loopCasterTimer ~= nil then
    self.loopCasterTimer:Stop()
    self.loopCasterTimer = nil
  end
  if self.loopCallBeforeBornEffectTimer ~= nil then
    self.loopCallBeforeBornEffectTimer:Stop()
    self.loopCallBeforeBornEffectTimer = nil
  end
  if self.casteForEachTagTimer ~= nil then
    self.casteForEachTagTimer:Stop()
    self.casteForEachTagTimer = nil
  end
end

return GuardMonsterCasterSkill
