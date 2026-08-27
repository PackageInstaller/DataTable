local bs_203602 = class("bs_203602", LuaSkillBase)
local base = LuaSkillBase
bs_203602.config = {
  skill_time = 18,
  start_time = 15,
  actionId = 1002,
  action_speed = 1,
  buffId_241 = 241,
  buffId_242 = 242,
  buffId_196 = 196,
  HurtConfig_ex = {
    hit_formula = 0,
    basehurt_formula = 10125,
    crit_formula = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  effectId_skill = 10779,
  effectId_bnfffire = 100307,
  audioId1 = 329
}

function bs_203602:ctor()
end

function bs_203602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_203602_3", 1, self.OnAfterHurt, self.caster)
end

function bs_203602:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skill, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, self.config.start_time, true)
end

function bs_203602:OnAttackTrigger()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_241, 1, nil, true)
  self.caster.recordTable.attack = 2
end

function bs_203602:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and self.caster.recordTable.attack == 2 then
    LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buffId_242, 1, self.arglist[2], nil, false, self.OnBuffExecute)
  end
end

function bs_203602:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig_ex, {
    buff.tier
  }, true)
  skillResult:EndResult()
end

function bs_203602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203602
