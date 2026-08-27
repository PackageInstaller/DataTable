local bs_100602 = class("bs_100602", LuaSkillBase)
local base = LuaSkillBase
bs_100602.config = {
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
  HurtConfig3 = 39,
  actionId = 1002,
  action_speed = 1,
  skill_time = 15,
  start_time = 8,
  effectId_skill = 100608,
  effectId_light1 = 100609,
  effectId_light2 = 100610,
  effectId_lz = 100307,
  effectHit = 100617,
  buffId_lz1 = 100601,
  buffId_lz2 = 100301,
  buffId_fire = 3011,
  buffId_rj = 107101,
  radius = 50,
  spd = 15,
  weaponLv = 0,
  buff_rj_times = 120
}

function bs_100602:ctor()
end

function bs_100602:InitSkill(isMidwaySkill)
  if self.config.weaponLv >= 1 then
    self:AddAfterAddBuffTrigger("bs_100602_8", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.buffId_rj)
  else
    self:AddAfterAddBuffTrigger("bs_100602_8", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.buffId_lz1)
  end
  self:AddBeforeBuffDispelTrigger("bs_100602_10", 1, self.OnBeforBuffDispel, nil, nil, self.config.buffId_lz1)
end

function bs_100602:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget == nil then
    return
  end
  local realtargetrole = moveTarget.targetRole
  self:SetLastSelectTarget(moveTarget)
  self.caster:LookAtTarget(realtargetrole)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, realtargetrole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.acton_speed, self.config.start_time, attackTrigger)
end

function bs_100602:OnAttackTrigger(target, data)
  local cusEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, self.config.radius, self.config.spd, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, false, EmissionArrive)
  local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, self.config.effectId_light1, self, nil, nil, nil, true)
  local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, self.config.effectId_light2, self, nil, nil, nil, true)
  self:SetLastSelectTarget(nil)
end

function bs_100602:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    self:SetLastSelectTarget(nil)
  end
end

function bs_100602:OnCollision(collider, index, entity)
  if entity.intensity == 0 and entity.career == 1 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:PlayAuHit(self, entity)
  if 1 <= self.config.weaponLv then
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig3, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(entity, self.config.effectHit, self)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_rj, 1, self.config.buff_rj_times)
  else
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_lz1, 1)
  end
end

function bs_100602:OnEmissionArrive(skillEmission)
  local EmissionArrive2 = BindCallback(self, self.OnEmissionArrive2)
  LuaSkillCtrl:CallRestartEmit(self, skillEmission, self.config.spd, self.caster, true, true, EmissionArrive2)
end

function bs_100602:OnEmissionArrive2()
  self:OnSkillDamageEnd()
end

function bs_100602:OnAfterAddBuff(buff, target)
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

function bs_100602:OnBeforBuffDispel(target, context)
  if context.buffId == self.config.buffId_lz1 and target.belongNum ~= self.caster.belongNum then
    local _1tier = target:GetBuffTier(self.config.buffId_lz1)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = self.arglist[2] * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig2, {hurt_arg})
    skillResult:EndResult()
  end
end

function bs_100602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100602
