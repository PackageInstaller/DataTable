local bs_306 = class("bs_306", LuaSkillBase)
local base = LuaSkillBase
bs_306.config = {effectId1 = 10138, buffId1 = 136}

function bs_306:ctor()
end

function bs_306:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_306_1", 1, self.OnSetHurt, nil, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_306_2", 1, self.OnBuffDie)
end

function bs_306:OnSetHurt(context)
  if self.caster:GetBuffTier(self.config.buffId1) ~= 0 and context.skill.isCommonAttack and 0 < context.hurt and context.target == self.caster then
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, 7)
  end
  if context.sender == self.caster and 0 <= self.arglist[3] then
    LuaSkillCtrl:CallHeal(context.hurt * 300 // 1000, self, self.caster, true)
  end
end

function bs_306:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

function bs_306:OnAttackTrigger(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, self.arglist[1])
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
end

function bs_306:OnBuffDie(buff, target, removeType)
  if target == self.caster and buff.dataId == self.config.buffId1 and self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_306:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

function bs_306:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_306
