local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_206700 = class("bs_206700", bs_1)
local base = bs_1
bs_206700.config = {
  effectId_normalAttack = 2067002,
  effectId_start1 = 2067002,
  effectId_start2 = 2067004,
  effectId_hit = 2067001,
  effectId_attackPlus = 2067003,
  buffId_attackPlus = 2067032,
  buffId_curse = 2067012,
  buffId_hit = 2067001,
  buffId_curseLabel1 = 2067013,
  buffId_curseLabel2 = 2067014,
  buffId_curseLabel3 = 2067015,
  action1 = 1001,
  action2 = 1004,
  action_time = 25,
  start_time = 6,
  audioId1 = 456,
  audioId2 = 457,
  audioId_normalAttack = nil
}
bs_206700.config = setmetatable(bs_206700.config, {
  __index = base.config
})

function bs_206700:ctor()
end

function bs_206700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.frontTarget = nil
end

function bs_206700:RealPlaySkill(target, data)
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  if 1 < self.attackNum then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    if prob == 1 then
      if data.audioId2 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * self.config.baseActionSpd
      atkActionId = data.action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
      self.attackNum = 0
    else
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = data.action1
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * self.config.baseActionSpd
      self.attackNum = self.attackNum + 1
    end
  else
    if data.audioId1 ~= nil then
      LuaSkillCtrl:StartTimer(self, data.time1, function()
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
      end)
    end
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * self.config.baseActionSpd
    atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
    atkActionId = data.action1
    self.attackNum = self.attackNum + 1
  end
  self.caster.recordTable.lastAttackRole = target
  if LuaSkillCtrl.IsInTDBattle and self.caster.belongNum == 2 then
    self.caster.recordTable.lastAttackRole = nil
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, 3, attackTrigger)
  local isAttackPlus = self.caster:GetBuffTier(self.config.buffId_attackPlus)
  if 0 < isAttackPlus then
    return
  end
  if self.caster.attackRange == 1 then
    if data.effectId_1 ~= nil then
      if atkActionId == data.action1 then
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_1, self, nil, nil, atkSpeedRatio, true)
      else
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_2, self, nil, nil, atkSpeedRatio, true)
      end
    end
    if data.effectId_3 ~= nil then
      LuaSkillCtrl:StartTimer(self, atkTriggerFrame, function()
        LuaSkillCtrl:CallEffect(target, data.effectId_3, self, nil, nil, atkSpeedRatio)
      end)
    end
  end
  if data.effectId_start1 ~= nil then
    if atkActionId == data.action1 then
      LuaSkillCtrl:CallEffect(target, data.effectId_start1, self, nil, nil, atkSpeedRatio, true)
    else
      LuaSkillCtrl:CallEffect(target, data.effectId_start2, self, nil, nil, atkSpeedRatio, true)
    end
  end
end

function bs_206700:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local isAttackPlus = self.caster:GetBuffTier(self.config.buffId_attackPlus)
  if isAttackPlus <= 0 then
    self:normalAttack(target, data)
  end
  if 0 < isAttackPlus then
    self:AttackPlus(target, data)
  end
end

function bs_206700:normalAttack(target, data)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if data.audioId_normalAttack ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId_normalAttack)
    end
    if data.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    self:HurtResult(target)
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
end

function bs_206700:AttackPlus(target, data)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    local grid = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
    if data.audioId_normalAttack ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId_normalAttack)
    end
    if data.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    LuaSkillCtrl:CallEffect(grid, self.config.effectId_attackPlus, self)
    local OnCollition = BindCallback(self, self.OnCollision)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 30, 15, eColliderInfluenceType.Enemy, OnCollition, nil, nil, nil, true, true)
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
end

function bs_206700:OnCollision(collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 then
    return
  end
  if entity.belongNum == self.caster.belongNum or entity == nil or entity.hp <= 0 then
    return
  end
  self:HurtResult(entity)
  if self.caster.recordTable.RootGroupCurse ~= nil then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_curse, 1)
    self:CurseLabel(entity)
  end
  if self.caster.recordTable.completeFirstComatk == nil then
    self.caster.recordTable.completeFirstComatk = true
  end
end

function bs_206700:HurtResult(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  local attackDamageUp = target:GetBuffTier(self.config.buffId_curse)
  local curse = self.caster.recordTable.curse
  local skillRatio = 1000 * (1000 + curse) ^ attackDamageUp // 1000 ^ attackDamageUp
  local isAttackPlus = self.caster:GetBuffTier(self.config.buffId_attackPlus)
  local attackup = self.caster.recordTable.attackUp
  if 0 < isAttackPlus then
    skillRatio = attackup * skillRatio // 1000
  end
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, 10, {skillRatio})
  LuaSkillCtrl:CallEffect(target, self.config.effectId_hit, self)
end

function bs_206700:AddCurse(target)
  if target == nil or target.hp <= 0 then
    return
  end
  local frontTarget = self.caster.recordTable.frontTarget
  if frontTarget ~= nil and frontTarget ~= target then
    local falseGodEnermy = eBattleRoleBelong.player
    if self.caster.belongNum == eBattleRoleBelong.player then
      falseGodEnermy = eBattleRoleBelong.enemy
    end
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(falseGodEnermy)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        frontTarget = targetList[i]
        LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curse, 0, true)
        LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curseLabel1, 0, true)
        LuaSkillCtrl:DispelBuff(frontTarget, self.config.buffId_curseLabel3, 0, true)
      end
    end
  end
  self.caster.recordTable.frontTarget = target
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curse, 1)
  self:CurseLabel(target)
  if self.caster.recordTable.RootCurseUp ~= nil then
    local extraCurse = LuaSkillCtrl:CallRange(1, 1000)
    if extraCurse <= self.caster.recordTable.RootCurseUp then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curse, 1)
      self:CurseLabel(target)
    end
  end
end

function bs_206700:CurseLabel(target)
  local labelTier = target:GetBuffTier(self.config.buffId_curse)
  if labelTier <= 6 then
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_curseLabel3, 0, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curseLabel1, 1)
  else
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_curseLabel1, 0, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_curseLabel3, 1)
  end
end

function bs_206700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206700
