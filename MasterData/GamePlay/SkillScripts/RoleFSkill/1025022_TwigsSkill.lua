local bs_1025022 = class("bs_1025022", LuaSkillBase)
local base = LuaSkillBase
bs_1025022.config = {
  skill_time = 31,
  start_time = 17,
  actionId = 1002,
  action_speed = 1,
  audioId1 = 251,
  audioId_hit = 253,
  buffId_Hua = 10250201,
  buffId_CH = 10250101,
  buffId_170 = 170,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 10
  },
  effectId_trail = 102503,
  effectId_P = 102506,
  effectId_hit2 = 102505,
  effectId_new = 102507,
  HurtConfig = {basehurt_formula = 3000},
  ex_hurttime = 3,
  buffId_tip = 10250301
}

function bs_1025022:ctor()
end

function bs_1025022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.skill_arg = self.arglist[2]
  self:AddBuffDieTrigger("bs_1025022_buff_die", 1, self.OnBuffDie, nil, nil, self.config.buffId_Hua)
end

function bs_1025022:PlaySkill(data)
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
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1] + self.config.start_time)
end

function bs_1025022:OnAttackTrigger(target)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Hua, 1, self.arglist[1], false)
  local cusEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId_P, self)
  local collisionTrigger = BindCallback(self, self.OnCollision, target)
  LuaSkillCtrl:CallCircledEmissionStraightlyWithThreeExtraChild(self, self.caster, target, 15, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, 16, true, true, nil, nil)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_new, self)
end

function bs_1025022:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_Hua and removeType == eBuffRemoveType.Timeout then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.Aoe)
    if skillResult.roleList.Count > 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        if 0 < role:GetBuffTier(self.config.buffId_CH) then
          LuaSkillCtrl:DispelBuff(role, self.config.buffId_CH, 0)
        end
      end
    end
    skillResult:EndResult()
  end
end

function bs_1025022:OnCollision(target, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or 0 < entity:GetBuffTier(self.config.buffId_tip) then
    return
  end
  local arg1 = self.caster.recordTable.skill_arg
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit2, self)
  local _Cskill = self.caster.recordTable.cs_Skill
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {arg1})
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_tip, 1, 1)
  LuaSkillCtrl:PlayAuSource(entity, self.config.audioId_hit)
end

function bs_1025022:OnBreakSkill(role)
  if role == self.caster and self.isSkillUncompleted == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_1025022:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_1025022:LuaDispose()
  base.LuaDispose(self)
end

return bs_1025022
