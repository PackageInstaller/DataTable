local bs_207401 = class("bs_207401", LuaSkillBase)
local base = LuaSkillBase
bs_207401.config = {
  buffId_speed = 207401,
  buffId_damage_increase = 207402,
  effectId_loop = 207402,
  effectId_end = 207403,
  skill_time = 20,
  actionId = 1004,
  action_speed = 1,
  start_time = 10
}

function bs_207401:ctor()
end

function bs_207401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBuffDieTrigger("bs_207401_buff_die", 1, self.OnBuffDie, nil, nil, self.config.buffId_speed)
end

function bs_207401:PlaySkill()
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_207401:OnAttackTrigger()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_speed, 1, self.arglist[2])
  self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
  self:AddAfterHurtTrigger("bs_207401_1", 1, self.OnAfterHurt, self.caster)
  self.effect_loop_207401 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
end

function bs_207401:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and sender == self.caster and not isMiss then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_damage_increase, 1)
  end
end

function bs_207401:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.buffId_speed and removeType == eBuffRemoveType.Timeout then
    self:RemoveSkillTrigger(eSkillTriggerType.AfterHurt)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_damage_increase, 10, true)
    if self.effect_loop_207401 ~= nil then
      self.effect_loop_207401:Die()
      self.effect_loop_207401 = nil
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end, self)
  end
end

function bs_207401:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect_loop_207401 ~= nil then
    self.effect_loop_207401:Die()
    self.effect_loop_207401 = nil
  end
end

function bs_207401:LuaDispose()
  self.effect_loop_207401 = nil
  base.LuaDispose(self)
end

return bs_207401
