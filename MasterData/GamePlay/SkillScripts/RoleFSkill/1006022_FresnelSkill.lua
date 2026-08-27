local bs_1006022 = class("bs_1006022", LuaSkillBase)
local base = LuaSkillBase
bs_1006022.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  HurtConfig2 = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0,
    hurt_type = 2
  },
  actionId = 1002,
  action_speed = 1,
  skill_time = 15,
  start_time = 8,
  effectId_skill = 100608,
  effectId_light1 = 100609,
  effectId_light2 = 100610,
  effectId_lz = 100307,
  buffId_lz1 = 10060101,
  buffId_lz2 = 10030101,
  buffId_fire = 301101,
  radius = 50,
  spd = 15
}

function bs_1006022:ctor()
end

function bs_1006022:InitSkill(isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_1006022_8", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_lz1)
  self:AddBeforeBuffDispelTrigger("bs_1006022_10", 1, self.OnBeforBuffDispel, nil, nil, self.config.buffId_lz1)
end

function bs_1006022:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget == nil then
    return
  end
  local realtargetrole = moveTarget.targetRole
  self.caster:LookAtTarget(realtargetrole)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, realtargetrole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.acton_speed, self.config.start_time, attackTrigger)
end

function bs_1006022:OnAttackTrigger(target, data)
  local cusEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, self.config.radius, self.config.spd, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, false, EmissionArrive)
  local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, self.config.effectId_light1, self, nil, nil, nil, true)
  local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, self.config.effectId_light2, self, nil, nil, nil, true)
end

function bs_1006022:OnCollision(collider, index, entity)
  if entity.intensity == 0 and entity.career == 1 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuHit(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[1]
  })
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_lz1, 1)
end

function bs_1006022:OnEmissionArrive(skillEmission)
  LuaSkillCtrl:CallRestartEmit(self, skillEmission, self.config.spd, self.caster, true, true)
end

function bs_1006022:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId_lz1 and target ~= nil and target.hp > 0 and target:GetBuffTier(self.config.buffId_lz1) + target:GetBuffTier(self.config.buffId_lz2) >= 4 then
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if 0 >= buffs.Count then
      return
    end
    local _1tier = target:GetBuffTier(self.config.buffId_lz1)
    local _2tier = 0
    for i = 0, buffs.Count - 1 do
      if buffs[i].dataId == self.config.buffId_lz2 and buffs[i].maker ~= nil and 0 < buffs[i].maker.hp then
        _2tier = target:GetBuffTier(self.config.buffId_lz2)
      end
    end
    if _2tier == 0 then
      _1tier = 4
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = self.arglist[2] * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig2, {hurt_arg})
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effectId_lz, self)
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_lz1, 0, true)
    LuaSkillCtrl:DispelBuff(target, self.config.buffId_lz2, 0)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fire, 1)
  end
end

function bs_1006022:OnBeforBuffDispel(target, context)
  if context.buffId == self.config.buffId_lz1 then
    local _1tier = target:GetBuffTier(self.config.buffId_lz1)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = self.arglist[2] * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig2, {hurt_arg})
    skillResult:EndResult()
  end
end

function bs_1006022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1006022
