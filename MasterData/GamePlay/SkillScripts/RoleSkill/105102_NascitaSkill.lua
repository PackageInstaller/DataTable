local bs_105102 = class("bs_105102", LuaSkillBase)
local base = LuaSkillBase
bs_105102.config = {
  effectId_nomal = 105106,
  effectId_breaksheild = 105108,
  effectId_hit_normal = 105107,
  effectId_hit_breaksheild = 105109,
  actionId_normal = 1002,
  skill_time_normal = 20,
  start_time_normal = 7,
  actionId_breaksheild = 1020,
  skill_time_breaksheild = 22,
  start_time_breaksheild = 8,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  },
  buffId_ult = 1051031,
  weaponLv = 0
}

function bs_105102:ctor()
end

function bs_105102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105102:PlaySkill(data)
  local target = self:SetSkillTarget()
  if target ~= nil then
    self.caster:LookAtTarget(target)
    local TargetSheild = self:TargetSheild(target)
    local action = self.config.actionId_normal
    local skill_time = self.config.skill_time_normal
    local start_time = self.config.start_time_normal
    local effect_start = self.config.effectId_nomal
    local effect_hit = self.config.effectId_hit_normal
    local skillRatio = self.arglist[1]
    self.caster.recordTable.TargetSheildstate = false
    if 0 < TargetSheild then
      action = self.config.actionId_breaksheild
      skill_time = self.config.skill_time_breaksheild
      start_time = self.config.start_time_breaksheild
      effect_start = self.config.effectId_breaksheild
      effect_hit = self.config.effectId_hit_breaksheild
      skillRatio = self.arglist[1] * (1000 + self.arglist[2]) // 1000
      self.caster.recordTable.TargetSheildstate = true
    end
    self:CallCasterWait(skill_time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, effect_hit, skillRatio)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, action, self.config.action_speed, start_time, attackTrigger)
    LuaSkillCtrl:CallEffect(target, effect_start, self, nil, nil, nil, true)
  end
end

function bs_105102:SetSkillTarget()
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  return target
end

function bs_105102:OnAttackTrigger(target, effect_hit, skillRatio)
  if target == nil or target.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {skillRatio})
  skillResult:EndResult()
  self:OnSkillDamageEnd()
  if self.caster.recordTable.ult_skill == true then
    self.caster.recordTable.ult_skill = false
    LuaSkillCtrl:CallResetCDForSingleSkill(self.cskill, self.caster.recordTable.ultSkill * self.cskill.totalCDTime // 1000)
  end
  LuaSkillCtrl:CallEffect(target, effect_hit, self)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnNascitaAttack, target, self.caster, self.cskill)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnNascitaAttack, target, self.caster, self.cskill)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnNascitaAttack, target, self.caster, self.cskill)
end

function bs_105102:TargetSheild(target)
  if target == nil or target.hp <= 0 then
    return
  end
  local totalShieldNum = 4
  local sheildValueSum = 0
  for i = 0, totalShieldNum - 1 do
    sheildValueSum = sheildValueSum + LuaSkillCtrl:GetShield(target, i)
  end
  return sheildValueSum
end

function bs_105102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105102
