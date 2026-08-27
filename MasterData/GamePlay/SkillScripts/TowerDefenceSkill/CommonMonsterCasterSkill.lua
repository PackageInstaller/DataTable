local CommonMonsterCasterSkill = class("CommonMonsterCasterSkill", LuaSkillBase)
local Stack = require("Framework.Lib.Stack")
local base = LuaSkillBase
CommonMonsterCasterSkill.config = {
  effectId1 = 10263,
  startAnimId = 1002,
  buffId_196 = 196,
  buffId_1033 = 1033,
  buffId_175 = 175,
  buffId_286 = 286,
  buffId_88 = 88,
  buffId_1224 = 1224,
  skill_time = 18,
  buffId_1191 = 1191,
  buffId_513101 = 513101,
  abandonMoveBuff = 1196,
  casterWaveInterval = 375,
  countDownDuration = 75,
  BoomEffect = 12005,
  BoomEffectTime = 12007,
  BoomEffectTime2 = 12022,
  latestAtkEffect = 12006,
  monsterBornInterval = 38,
  routeMonsterId = 55555,
  route_monster_buff = 1201,
  callNextBtnRewardFormula = 10167,
  campNotBeSelectBuff = 50,
  commonMonsterAtkPassiveId = 540,
  hurtPerAtk = 1
}
local MonsterBornState = {
  eWaitBorn = 0,
  eBornDelaying = 1,
  eCompleteDelay = 2
}

function CommonMonsterCasterSkill:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "CommonMonsterCasterSkill_start", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "CommonMonsterCasterSkill_roleDie", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.OnCallNextWaveTowerMonster, "CommonMonsterCasterSkill_nextWave", 1, self.OnNextWave)
  self:AddLuaTrigger(eSkillLuaTrigger.OnTDTakeGrid, self.OnGridTake)
  self.aliveMonsterList = {}
  self.curTakedGridTimers = {}
end

function CommonMonsterCasterSkill:OnGridTake(x, y, role)
  local grid = LuaSkillCtrl:GetGridWithPos(x, y)
  if grid == nil then
    return
  end
  if grid.role ~= nil and grid.role ~= role then
    return
  end
  local duration = ConfigData.buildinConfig.CaptureGridDuration
  if self.curTakedGridTimers[grid] ~= nil then
    local timer = self.curTakedGridTimers[grid]
    grid.role = LuaSkillCtrl.battleCtrl.PlayerController.SkillCasterEntity
    timer.left = duration
    return
  end
  grid.role = LuaSkillCtrl.battleCtrl.PlayerController.SkillCasterEntity
  self.curTakedGridTimers[grid] = LuaSkillCtrl:StartTimer(nil, duration, function(tempGrid)
    if grid.role == LuaSkillCtrl.battleCtrl.PlayerController.SkillCasterEntity then
      grid.role = nil
    end
    self.curTakedGridTimers[grid] = nil
  end, grid)
end

function CommonMonsterCasterSkill:OnNextWave()
  if not self:IsAbleToCallNextWaveByManual() then
    return
  end
  local nextReward = self:CalculateNextWaveReward()
  self:SetNextWaveCasterRemainTime(0)
  if 0 < nextReward then
    LuaSkillCtrl:AddPlayerTowerMp(nextReward)
  end
  MsgCenter:Broadcast(eMsgEventId.TDNextClickActive, false)
end

function CommonMonsterCasterSkill:OnRoleDie(killer, role, killSkill)
  if role.belongNum == self.caster.belongNum then
    self:CheckAndKillCountDownEfc(role)
    table.removebyvalue(self.aliveMonsterList, role)
    if killSkill.dataId ~= self.config.commonMonsterAtkPassiveId then
      local reward = LuaSkillCtrl:GetTDMosterDieReward(role)
      if 0 < reward then
        LuaSkillCtrl:AddPlayerTowerMp(reward)
        if not LuaSkillCtrl.IsInVerify then
          local trans = role.lsObject.transform
          local worldPos
          if not IsNull(trans) then
            worldPos = trans.position
          end
          MsgCenter:Broadcast(eMsgEventId.EnemyIsDead, reward, worldPos)
        end
      end
    end
  end
  if not self:IsAbleToCallNextWaveByManual() then
    return
  end
  local nextReward = self:CalculateNextWaveReward()
  local curFrame = LuaSkillCtrl.battleCtrl.frame
  MsgCenter:Broadcast(eMsgEventId.TDNextClickActive, true, nextReward, self.__calculateNextReward)
end

function CommonMonsterCasterSkill:CalculateNextWaveReward()
  if self.loopCasterTimer == nil then
    return 0
  end
  local leftTime = self.loopCasterTimer.left
  local nextReward = self.nextWaveRewardArg * leftTime // 1000
  if 40 < nextReward then
    nextReward = 40
  end
  return nextReward
end

function CommonMonsterCasterSkill:IsAbleToCallNextWave(nextWave)
  nextWave = nextWave or self.waveRound
  if nextWave > self.maxWave or self.maxIndexPerWave[nextWave] == nil or self.maxIndexPerWave[nextWave] <= 0 or 0 >= self.totalRoleCount then
    return false
  end
  return true
end

function CommonMonsterCasterSkill:IsAbleToCallNextWaveByManual(curWave)
  curWave = curWave or self.waveRound
  if #self.aliveMonsterList > 0 or curWave >= self.maxWave or self.maxIndexPerWave[curWave] == nil or 0 < self.maxIndexPerWave[curWave] or 0 >= self.totalRoleCount then
    return false
  end
  return true
end

function CommonMonsterCasterSkill:OnAfterBattleStart()
  self.__calculateNextReward = BindCallback(self, self.CalculateNextWaveReward)
  self.nextWaveRewardArg = LuaSkillCtrl:CallFormulaNumber(self.config.callNextBtnRewardFormula, self.caster, self.caster)
  self:SetUpPlayerTowerMp()
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

function CommonMonsterCasterSkill:SetNextWaveCasterRemainTime(value, overideInterval)
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

function CommonMonsterCasterSkill:SetUpPlayerTowerMp()
  LuaSkillCtrl:AddPlayerTowerMp(0)
end

function CommonMonsterCasterSkill:MakeUpWaitToCasterMonsters()
  local monsters = LuaSkillCtrl:GetAllWaitToCasteMonsters()
  local tempMonsters = {}
  self.waveIntervals = {}
  self.curMonsters = {}
  self.maxIndexPerWave = {}
  self.tagRoute = {}
  self.totalRoleCount = monsters.Count
  self.maxRoleCount = monsters.Count
  self.maxWave = 0
  self.bornPosList = {}
  for i = 0, monsters.Count - 1 do
    local wave, intervalPerWave, eachBornDelay, index = self:GetMonsterBornData(monsters[i].roleWave)
    local roleTag = monsters[i].roleTag
    if self.tagRoute[roleTag] == nil then
      self.tagRoute[roleTag] = {}
    end
    if self.curMonsters[roleTag] == nil then
      self.curMonsters[roleTag] = {}
    end
    if self.curMonsters[roleTag][wave] == nil then
      self.curMonsters[roleTag][wave] = {}
    end
    local bornPos = BattleUtil.XYCoord2Pos(monsters[i].x, monsters[i].y)
    if self.curMonsters[roleTag][wave][bornPos] == nil then
      self.curMonsters[roleTag][wave][bornPos] = {}
    end
    if not table.contain(self.bornPosList, bornPos) then
      table.insert(self.bornPosList, bornPos)
    end
    if self.maxIndexPerWave[wave] == nil then
      self.maxIndexPerWave[wave] = 0
      self.waveIntervals[wave] = 0
    end
    if index > self.maxIndexPerWave[wave] then
      self.maxIndexPerWave[wave] = index
    end
    if intervalPerWave > self.waveIntervals[wave] then
      self.waveIntervals[wave] = intervalPerWave
    end
    if wave > self.maxWave then
      self.maxWave = wave
    end
    local roleModel = {
      role = monsters[i],
      index = index,
      wave = wave,
      bornDelay = eachBornDelay,
      bornState = MonsterBornState.eWaitBorn
    }
    table.insert(self.curMonsters[roleTag][wave][bornPos], roleModel)
  end
  for tempTag = 1, self.maxTag do
    local tagMonsters = self.curMonsters[tempTag]
    if tagMonsters ~= nil then
      for tempWave = 1, self.maxWave do
        local curGroupMonster = tagMonsters[tempWave]
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
  end
  local characterData = self.caster.character
  if characterData ~= nil then
    self.lastWaveBoomInterval = characterData.roleWave
  end
end

function CommonMonsterCasterSkill:GetMonsterBornData(rawWave)
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

function CommonMonsterCasterSkill:MakeUpCampRole()
  local campRoles = LuaSkillCtrl:GetAllPlayerDungeonRoles()
  self.allCampRoles = {}
  self.maxTag = 0
  for i = 0, campRoles.Count - 1 do
    LuaSkillCtrl:CallBuff(self, campRoles[i], self.config.campNotBeSelectBuff, 1, nil, true)
    local roleTag = LuaSkillCtrl:GetRoleTag(campRoles[i])
    self.allCampRoles[roleTag] = campRoles[i]
    if roleTag > self.maxTag then
      self.maxTag = roleTag
    end
  end
end

function CommonMonsterCasterSkill:GetWaveRoles(wave)
  local roles = self.allWaveMonsters[wave]
  return roles
end

function CommonMonsterCasterSkill:GetCampRole(camp)
  local role = self.allCampRoles[camp]
  return role
end

function CommonMonsterCasterSkill:LoopCaster()
  self:ClearLastWaveCaster()
  self.waveRound = self.waveRound + 1
  if self:IsAbleToCallNextWave() then
    local nextWaveInterval = self.waveIntervals[self.waveRound]
    if nextWaveInterval ~= nil and 0 < nextWaveInterval then
      self:SetNextWaveCasterRemainTime(nextWaveInterval, true)
    end
    if self.waveRound < self.maxWave then
      MsgCenter:Broadcast(eMsgEventId.TDNextCountDown, self.loopCasterTimer.left)
    end
  end
  MsgCenter:Broadcast(eMsgEventId.TDNextClickActive, false)
  local callRealCaster = BindCallback(self, self.CallRealCaster)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.startAnimId, 1)
  LuaSkillCtrl:StartTimer(self, self.config.skill_time, callRealCaster)
  MsgCenter:Broadcast(eMsgEventId.TDNextWava, self.waveRound, self.maxWave, self.maxIndexPerWave[self.waveRound])
end

function CommonMonsterCasterSkill:ClearLastWaveCaster()
  if self.casteForEachTagTimer ~= nil then
    self.casteForEachTagTimer:Stop()
    self.casteForEachTagTimer = nil
  end
  self:StopCurWaveDeloyBornTimer(self.waveRound)
  if self.waveRound <= 0 then
    return
  end
  for i = 1, self.maxTag do
    local curTagMonsters = self.curMonsters[i]
    if curTagMonsters ~= nil then
      local curTagWaveMonsters = curTagMonsters[self.waveRound]
      if curTagWaveMonsters ~= nil then
        for _, tempPos in ipairs(self.bornPosList) do
          if curTagWaveMonsters[tempPos] ~= nil then
            local count = curTagWaveMonsters[tempPos]:Count()
            if 0 < count then
              curTagWaveMonsters[tempPos]:Clear()
            end
            self.totalRoleCount = self.totalRoleCount - count
          end
        end
      end
    end
  end
  self.maxIndexPerWave[self.waveRound] = 0
end

function CommonMonsterCasterSkill:CallRealCaster()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  self:SetStateForLastWaveAliveMonster()
  if self.maxTag <= 0 then
    return
  end
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

function CommonMonsterCasterSkill:SetStateForLastWaveAliveMonster()
  if self.aliveMonsterList ~= nil then
    local aliveRoleCount = #self.aliveMonsterList
    if 0 < aliveRoleCount then
      for i = 1, aliveRoleCount do
        local role = self.aliveMonsterList[i]
        if role ~= nil and 0 < role.hp then
          LuaSkillCtrl:CallBuff(self, role, self.config.abandonMoveBuff, 1, self.config.countDownDuration, true)
          local second = self.config.countDownDuration // 15
          role.recordTable.boomLeftTime = second
          if not LuaSkillCtrl.IsInVerify then
            LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CallCountDownEffect, role, second), nil, second - 1, 14)
          end
        end
      end
      LuaSkillCtrl:StartTimer(nil, self.config.countDownDuration, BindCallback(self, self.KillAllMonsterAndDamageToCamp, self.aliveMonsterList))
      self.aliveMonsterList = {}
    end
  end
end

function CommonMonsterCasterSkill:SetStateForTheFinalWaveAliveMonster()
  self:ClearLastWaveCaster()
  self:SetStateForLastWaveAliveMonster()
  self:KillSelf()
  if self.lastBoomTimer ~= nil then
    self.lastBoomTimer:Stop()
    self.lastBoomTimer = nil
  end
end

function CommonMonsterCasterSkill:CallCountDownEffect(role, second)
  if role == nil or role.hp <= 0 then
    return
  end
  local leftTime = role.recordTable.boomLeftTime or second
  if second - leftTime == 0 then
    local countDownEffect = LuaSkillCtrl:CallEffect(role, self.config.BoomEffectTime, self)
    role.recordTable.countDownEffect = countDownEffect
  else
    local countDownEffect = LuaSkillCtrl:CallEffect(role, self.config.BoomEffectTime2, self)
    role.recordTable.countDownEffect = countDownEffect
    countDownEffect:SetCountValue(second - leftTime)
  end
  role.recordTable.boomLeftTime = leftTime - 1
end

function CommonMonsterCasterSkill:CheckAndKillCountDownEfc(role)
  local countDownEffect = role.recordTable.countDownEffect
  if countDownEffect ~= nil and not countDownEffect:IsDie() then
    countDownEffect:Die()
  end
  role.recordTable.countDownEffect = nil
end

function CommonMonsterCasterSkill:StopCurWaveDeloyBornTimer(curWave)
  if self.delayTimerDictPerWave == nil or self.delayTimerDictPerWave[curWave] == nil then
    return
  end
  local curTimers = self.delayTimerDictPerWave[curWave]
  for _, tempPos in ipairs(self.bornPosList) do
    local timerPerPos = curTimers[tempPos]
    if timerPerPos ~= nil then
      timerPerPos:Stop()
    end
  end
  self.delayTimerDictPerWave[curWave] = nil
end

function CommonMonsterCasterSkill:StopAllBornTimer()
  for i = 0, self.maxWave do
    self:StopCurWaveDeloyBornTimer(i)
  end
end

function CommonMonsterCasterSkill:CasteMonsterForeach()
  local curMaxIndex = self.maxIndexPerWave[self.waveRound]
  if curMaxIndex == nil or curMaxIndex <= 0 then
    if self.casteForEachTagTimer ~= nil then
      self.casteForEachTagTimer:Stop()
      self.casteForEachTagTimer = nil
    end
    self:StopCurWaveDeloyBornTimer(self.waveRound)
    return
  end
  for curTag = 1, self.maxTag do
    local campRole = self:GetCampRole(curTag)
    if campRole ~= nil then
      local curTagMonsters = self.curMonsters[curTag]
      if curTagMonsters ~= nil then
        local tempMonsterBorntable = curTagMonsters[self.waveRound]
        if tempMonsterBorntable ~= nil then
          local delayTimers = self.delayTimerDictPerWave[self.waveRound]
          if delayTimers == nil then
            delayTimers = {}
            self.delayTimerDictPerWave[self.waveRound] = delayTimers
          end
          for _, tempPos in ipairs(self.bornPosList) do
            local tempMonsterStack = tempMonsterBorntable[tempPos]
            self:RealCallTDMonster(tempMonsterStack, curTag, campRole, tempPos, delayTimers)
          end
        end
      end
    end
  end
end

function CommonMonsterCasterSkill:RealCallTDMonster(tempMonsterStack, curTag, campRole, tempPos, delayTimers)
  if tempMonsterStack == nil or tempMonsterStack:Count() <= 0 then
    return
  end
  local tempMonsterData = tempMonsterStack:Peek()
  local coord = BattleUtil.XYCoord2Pos(tempMonsterData.role.x, tempMonsterData.role.y)
  if self:CheckAndMarkRouteMonster(curTag, coord) then
    local routeSummoner = LuaSkillCtrl:CreateSummoner(self, self.config.routeMonsterId, tempMonsterData.role.x, tempMonsterData.role.y)
    routeSummoner:SetAttr(eHeroAttr.maxHp, 100)
    routeSummoner:SetAsRealEntity(7)
    local routeSummonerEntity = LuaSkillCtrl:AddSummonerRole(routeSummoner)
    routeSummonerEntity:SetRoleMoveFollowTarget(campRole, true, true)
    LuaSkillCtrl:CallBuff(self, routeSummonerEntity, self.config.route_monster_buff, 1, 99, true)
    return
  end
  if tempMonsterData.bornState == MonsterBornState.eBornDelaying then
    return
  elseif tempMonsterData.bornState == MonsterBornState.eCompleteDelay then
    self:CreateTDMonster(tempMonsterStack, tempMonsterData, campRole)
    return
  end
  local delayTime = tempMonsterData.bornDelay
  if delayTime <= 0 then
    self:CreateTDMonster(tempMonsterStack, tempMonsterData, campRole)
    return
  end
  local delayTimerPerPos = delayTimers[tempPos]
  if delayTimerPerPos == nil or delayTimerPerPos:IsOver() then
    delayTimerPerPos = LuaSkillCtrl:StartTimer(nil, delayTime, BindCallback(self, self.CreateTDMonster, tempMonsterStack, tempMonsterData, campRole), nil)
    tempMonsterData.bornState = MonsterBornState.eBornDelaying
    delayTimers[tempPos] = delayTimerPerPos
  end
end

function CommonMonsterCasterSkill:CreateTDMonster(tempMonsterStack, tempMonsterData, campRole)
  tempMonsterData.bornState = MonsterBornState.eCompleteDelay
  local role = LuaSkillCtrl:CreateTDMonster(tempMonsterData.role, self, campRole)
  if role == nil then
    return
  end
  local bloodNum = tempMonsterData.role:GetBossBloodNum()
  if 0 < bloodNum then
    role.recordTable.isTowerBoss = true
  end
  tempMonsterStack:Pop()
  self.maxIndexPerWave[self.waveRound] = self.maxIndexPerWave[self.waveRound] - 1
  self.totalRoleCount = self.totalRoleCount - 1
  self:OnMonsterCastered(role)
  table.insert(self.aliveMonsterList, role)
end

function CommonMonsterCasterSkill:KillSelf()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_88, 0)
  LuaSkillCtrl:RemoveLife(self.caster.hp + 1, self, self.caster, false, nil, true, true)
end

function CommonMonsterCasterSkill:CheckAndMarkRouteMonster(curTag, curCoord)
  local routeTag = self.tagRoute[curTag]
  if routeTag == nil then
    return false
  end
  local canCallRoute = routeTag[curCoord]
  if not canCallRoute then
    routeTag[curCoord] = true
    return true
  end
  return false
end

function CommonMonsterCasterSkill:OnMonsterCastered(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId_286, 1, nil, true)
  local skillMgrComp = role:GetSkillComponent()
  if skillMgrComp ~= nil then
    skillMgrComp:BroadCastRoleAfterBattleStartTrigger(true)
  end
  if self.totalRoleCount <= 0 then
    self:KillSelf()
  end
  if self.waveRound >= self.maxWave and self.lastWaveBoomInterval ~= nil and 0 < self.lastWaveBoomInterval and self.lastBoomTimer == nil then
    self.lastBoomTimer = LuaSkillCtrl:StartTimer(nil, self.lastWaveBoomInterval, self.SetStateForTheFinalWaveAliveMonster, self)
    MsgCenter:Broadcast(eMsgEventId.TDNextCountDown, self.lastWaveBoomInterval)
  end
  MsgCenter:Broadcast(eMsgEventId.TDMonsterBorn, self.maxIndexPerWave[self.waveRound])
end

function CommonMonsterCasterSkill:KillAllMonsterAndDamageToCamp(monsters)
  for i = 1, #monsters do
    local monster = monsters[i]
    if monster ~= nil and not (monster.hp <= 0) then
      local campRole = self:GetCampRole(monster:GetRoleTag())
      if campRole ~= nil then
        self:CheckAndKillCountDownEfc(monster)
        LuaSkillCtrl:CallEffect(monster, self.config.BoomEffect, self)
        LuaSkillCtrl:CallEffectWithArgAndSpeedOverride(campRole, self.config.latestAtkEffect, self, monster, 1, false, false, self.EffectEventTrigger, monster)
      end
    end
  end
end

function CommonMonsterCasterSkill:EffectEventTrigger(monster, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local playerEntity = LuaSkillCtrl.battleCtrl.PlayerController.SkillCasterEntity
    local atkOffset = 1
    if playerEntity ~= nil and 1 <= playerEntity.hp_regen then
      atkOffset = playerEntity.hp_regen
    end
    local hurt = self.config.hurtPerAtk * atkOffset
    local targetRole = target.targetRole
    if targetRole ~= nil and targetRole.hp > 0 then
      LuaSkillCtrl:RemoveLife(hurt, self, target, true, nil, true)
    end
    if monster.hp > 0 then
      LuaSkillCtrl:RemoveLife(monster.hp + 1, self, monster, true, nil)
    end
  end
end

function CommonMonsterCasterSkill:OnCasterDie()
end

function CommonMonsterCasterSkill:LuaDispose()
  base.LuaDispose(self)
  self.maxIndexPerWave = nil
  self.aliveMonsterList = nil
  self.allCampRoles = nil
  self.curMonsters = nil
  self.tagRoute = nil
  self.waveIntervals = nil
  self.lastWaveBoomInterval = nil
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
  if self.casteForEachTagTimer ~= nil then
    self.casteForEachTagTimer:Stop()
    self.casteForEachTagTimer = nil
  end
end

return CommonMonsterCasterSkill
