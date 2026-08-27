local BrotatoMonsterCasterSkill = class("BrotatoMonsterCasterSkill", LuaSkillBase)
local Stack = require("Framework.Lib.Stack")
local base = LuaSkillBase
BrotatoMonsterCasterSkill.config = {
  effectId1 = 10263,
  startAnimId = 1002,
  buffId_198 = 198,
  buffId_1033 = 1033,
  buffId_175 = 175,
  buffId_88 = 88,
  skill_time = 18,
  buffId_1191 = 1191,
  buffId_513101 = 513101,
  casterWaveInterval = 375,
  countDownDuration = 75,
  latestAtkEffect = 12006,
  monsterBornInterval = 38,
  callNextBtnRewardFormula = 10167,
  campNotBeSelectBuff = 50,
  bornEffectId = 70003,
  borDelayTime = 7,
  roleDeadTime = 10
}

function BrotatoMonsterCasterSkill:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "CommonMonsterCasterSkill_start", 0, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "CommonMonsterCasterSkill_roleDie", 1, self.OnRoleDie)
  self.aliveMonsterList = {}
  self.curTakedGridTimers = {}
  self.isStopCreatMonster = false
  self.pauseFrame = 0
end

function BrotatoMonsterCasterSkill:OnRoleDie(killer, role, killSkill)
  if role.belongNum == self.caster.belongNum and table.contain(self.aliveMonsterList, role) then
    table.removebyvalue(self.aliveMonsterList, role)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnBrotatoMonsterDie, killer, role, killSkill)
    LuaSkillCtrl:StartTimer(nil, self.config.roleDeadTime, function(targetRole)
      targetRole.battleRoleView:SetRoleVisible(false)
    end, role)
    if self.isPauseCreat then
      local curFrame = LuaSkillCtrl.battleCtrl.frame
      local diffFrame = curFrame - self.pauseFrame
      if #self.aliveMonsterList < self.limitAliveMonsterCount then
        if self.loopCasterTimer ~= nil then
          self.loopCasterTimer.left = self.loopCasterTimer.left - diffFrame
          self.loopCasterTimer:Start()
        end
        self.isPauseCreat = false
        local tempMonsterBornList = self.curMonsters[self.waveRound]
        if tempMonsterBornList ~= nil then
          local bornPosEffects = {}
          self:RealCallBrotatoMonster(tempMonsterBornList, self.pauseIndex, bornPosEffects, self.pauseWave)
        end
      end
    end
  end
end

function BrotatoMonsterCasterSkill:IsAbleToCallNextWave(nextWave)
  nextWave = nextWave or self.waveRound
  if nextWave > self.maxWave or self.waveCount[nextWave] == nil or self.waveCount[nextWave] <= 0 then
    return false
  end
  return true
end

function BrotatoMonsterCasterSkill:IsAbleToCallNextWaveByManual(curWave)
  curWave = curWave or self.waveRound
  if #self.aliveMonsterList > 0 or curWave >= self.maxWave or self.waveCount[curWave] == nil or 0 < self.waveCount[curWave] then
    return false
  end
  return true
end

function BrotatoMonsterCasterSkill:OnAfterBattleStart()
  local curGrid = LuaSkillCtrl:GetGridWithRole(self.caster)
  curGrid.role = nil
  self.battleRoomId = LuaSkillCtrl:GetBattleRoomId()
  self.limitAliveMonsterCount = 3
  self.sectorStageExtracfg = ConfigData.brotato_sector_stage_extra[self.battleRoomId]
  if self.sectorStageExtracfg ~= nil then
    self.limitAliveMonsterCount = self.sectorStageExtracfg.limit_enemy_count
  end
  self:MakeUpWaitToCasterMonsters()
  self.delayTimerDictPerWave = {}
  self.waveRound = 0
  self.loopCasterTimer = LuaSkillCtrl:StartTimer(nil, self.config.casterWaveInterval, self.LoopCaster, self, -1, self.config.casterWaveInterval)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1033, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_88, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_175, 1, nil, true)
end

function BrotatoMonsterCasterSkill:SetNextWaveCasterRemainTime(value, overideInterval)
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
end

function BrotatoMonsterCasterSkill:MakeUpWaitToCasterMonsters()
  local monsterTeamCfg = ConfigData.brotato_monster_team[self.battleRoomId]
  local waitTempleMonsters = LuaSkillCtrl:GetAllWaitToCasteMonsters()
  local tempMonsters = {}
  self.waveIntervals = {}
  self.curMonsters = {}
  self.waveCount = {}
  self.maxRoleCount = 0
  self.maxWave = 0
  local index = 0
  for i, v in ipairs(monsterTeamCfg) do
    local wave = v.wave_Index
    local intervalPerWave = v.wave_interval
    if self.curMonsters[wave] == nil then
      self.curMonsters[wave] = {}
    end
    local centerPos = v.create_center_pos
    local bornPos = BattleUtil.XYCoord2Pos(centerPos[1], centerPos[2])
    if self.waveCount[wave] == nil then
      self.waveCount[wave] = 0
      self.waveIntervals[wave] = 0
    end
    if intervalPerWave > self.waveIntervals[wave] then
      self.waveIntervals[wave] = intervalPerWave
    end
    if wave > self.maxWave then
      self.maxWave = wave
    end
    local monsterData
    for i = 0, waitTempleMonsters.Count - 1 do
      if waitTempleMonsters[i].uid == v.id then
        monsterData = waitTempleMonsters[i]
        break
      end
    end
    if monsterData ~= nil then
      for k = 1, v.enemy_num do
        self.maxRoleCount = self.maxRoleCount + 1
        index = index + 1
        self.waveCount[wave] = self.waveCount[wave] + 1
        local roleModel = {
          role = monsterData,
          index = index,
          wave = wave,
          bornDelay = self.config.borDelayTime,
          bornPos = bornPos,
          dropBuffRate = v.drop_buff_rate,
          dropHpRate = v.drop_hp_rate,
          enemyType = v.enemy_type
        }
        table.insert(self.curMonsters[wave], roleModel)
      end
    end
  end
end

function BrotatoMonsterCasterSkill:GetWaveRoles(wave)
  local roles = self.allWaveMonsters[wave]
  return roles
end

function BrotatoMonsterCasterSkill:GetCampRole()
  return self.campRole
end

function BrotatoMonsterCasterSkill:ClearLastWaveCaster()
  if self.waveRound <= 0 then
    return
  end
  local curTagWaveMonsters = self.curMonsters[self.waveRound]
  if curTagWaveMonsters == nil then
    return
  end
  self.waveCount[self.waveRound] = 0
end

function BrotatoMonsterCasterSkill:StopAllBornTimer()
  if self.delayTimerDictPerWave ~= nil then
    for k, v in pairs(self.delayTimerDictPerWave) do
      v:Stop()
    end
    self.delayTimerDictPerWave = nil
  end
end

function BrotatoMonsterCasterSkill:LoopCaster()
  self:ClearLastWaveCaster()
  self.waveRound = self.waveRound + 1
  if self:IsAbleToCallNextWave() then
    local nextWaveInterval = self.waveIntervals[self.waveRound]
    if nextWaveInterval ~= nil and 0 < nextWaveInterval then
      self:SetNextWaveCasterRemainTime(nextWaveInterval, true)
    end
  end
  local callRealCaster = BindCallback(self, self.CallRealCaster, self.waveRound)
  LuaSkillCtrl:StartTimer(self, self.config.skill_time, callRealCaster)
end

function BrotatoMonsterCasterSkill:CallRealCaster(wave)
  local noMonsterCasted = false
  local loopCasterCount = self.waveCount[wave]
  if loopCasterCount ~= nil and 0 < loopCasterCount then
    self:CasteMonsterForeach(wave)
  else
    noMonsterCasted = true
  end
  if self.waveRound >= self.maxWave then
    if self.loopCasterTimer ~= nil then
      self.loopCasterTimer:Stop()
      self.loopCasterTimer = nil
    end
    if noMonsterCasted then
    end
  end
end

function BrotatoMonsterCasterSkill:CasteMonsterForeach(wave)
  local tempMonsterBornList = self.curMonsters[wave]
  if tempMonsterBornList == nil then
    return
  end
  if self.delayTimerDictPerWave == nil then
    self.delayTimerDictPerWave = {}
  end
  local bornPosEffects = {}
  self:RealCallBrotatoMonster(tempMonsterBornList, 1, bornPosEffects, wave)
end

function BrotatoMonsterCasterSkill:RealCallBrotatoMonster(tempMonsterList, index, bornPosEffects, wave)
  if tempMonsterList == nil or index > #tempMonsterList or self.isPauseCreat then
    return
  end
  local tempMonsterData = tempMonsterList[index]
  local aliveMonsterCount = #self.aliveMonsterList + index
  if aliveMonsterCount >= self.limitAliveMonsterCount then
    if self.loopCasterTimer ~= nil then
      self.loopCasterTimer:Pause()
    end
    self.isPauseCreat = true
    self.pauseFrame = LuaSkillCtrl.battleCtrl.frame
    self.pauseIndex = index + 1
    self.pauseWave = wave
  end
  index = index + 1
  local tempA = index
  local delayTime = tempMonsterData.bornDelay + tempA
  if delayTime <= 0 then
    self:CreateBrotatoMonster(tempMonsterData, wave)
  else
    if bornPosEffects[tempMonsterData.bornPos] == nil then
      local bornCoordX, bornCoordY = BattleUtil.Pos2XYCoord(tempMonsterData.bornPos)
      local target = LuaSkillCtrl:GetTargetWithGrid(bornCoordX, bornCoordY)
      LuaSkillCtrl:CallEffect(target, self.config.bornEffectId, self)
      bornPosEffects[tempMonsterData.bornPos] = true
    end
    local timer = LuaSkillCtrl:StartTimer(nil, delayTime, BindCallback(self, self.CreateBrotatoMonster, tempMonsterData, wave), nil)
    self.delayTimerDictPerWave[tempMonsterData.index] = timer
  end
  self:RealCallBrotatoMonster(tempMonsterList, index, bornPosEffects, wave)
end

function BrotatoMonsterCasterSkill:CreateBrotatoMonster(tempMonsterData, wave)
  local timer = self.delayTimerDictPerWave[tempMonsterData.index]
  if timer ~= nil then
    timer:Stop()
    self.delayTimerDictPerWave[tempMonsterData.index] = nil
  end
  local dynRole = tempMonsterData.role
  local bornCoordX, bornCoordY = BattleUtil.Pos2XYCoord(tempMonsterData.bornPos)
  dynRole.x = bornCoordX
  dynRole.y = bornCoordY
  local role = LuaSkillCtrl:CreateMonster(tempMonsterData.role, self, nil)
  if role == nil then
    return
  end
  local bloodNum = tempMonsterData.role:GetBossBloodNum()
  if 0 < bloodNum then
    role.recordTable.isTowerBoss = true
  end
  self.waveCount[wave] = self.waveCount[wave] - 1
  table.insert(self.aliveMonsterList, role)
  self:OnMonsterCastered(role, tempMonsterData.dropBuffRate, tempMonsterData.dropHpRate, tempMonsterData.enemyType)
end

function BrotatoMonsterCasterSkill:KillSelf()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_88, 0)
  LuaSkillCtrl:RemoveLife(self.caster.hp + 1, self, self.caster, false, nil, true, true)
end

function BrotatoMonsterCasterSkill:OnMonsterCastered(role, dropBuffRate, dropHpRate, enemyType)
  local randNum1 = LuaSkillCtrl:CallRange(0, 100)
  if dropBuffRate > randNum1 then
    role.recordTable.isCanDropBuff = true
  end
  local randNum2 = LuaSkillCtrl:CallRange(0, 100)
  if dropHpRate > randNum2 then
    role.recordTable.isCanDropHp = true
  end
  local moneyNum = 0
  if self.sectorStageExtracfg ~= nil then
    local rate = self.sectorStageExtracfg.drop_coin_extra_probity[enemyType]
    if rate ~= nil then
      local randNum3 = LuaSkillCtrl:CallRange(0, 100)
      if rate > randNum3 then
        local extraNum = self.sectorStageExtracfg.drop_coin_extra_num[enemyType]
        if extraNum ~= nil then
          moneyNum = moneyNum + extraNum
        end
      end
    end
    local baseNum = self.sectorStageExtracfg.drop_coin_num[enemyType]
    if baseNum ~= nil then
      moneyNum = moneyNum + baseNum
    end
  end
  role.recordTable.moneyNum = moneyNum
  local skillMgrComp = role:GetSkillComponent()
  if skillMgrComp ~= nil then
    skillMgrComp:BroadCastRoleAfterBattleStartTrigger(true)
  end
end

function BrotatoMonsterCasterSkill:OnCasterDie()
end

function BrotatoMonsterCasterSkill:LuaDispose()
  base.LuaDispose(self)
  self.waveCount = nil
  self.aliveMonsterList = nil
  self.allCampRoles = nil
  self.curMonsters = nil
  self.waveIntervals = nil
  self.curTakedGridTimers = nil
  self:StopAllBornTimer()
  self.delayTimerDictPerWave = nil
  if self.lastBoomTimer ~= nil then
    self.lastBoomTimer:Stop()
    self.lastBoomTimer = nil
  end
  if self.loopCasterTimer ~= nil then
    self.loopCasterTimer:Stop()
    self.loopCasterTimer = nil
  end
end

return BrotatoMonsterCasterSkill
