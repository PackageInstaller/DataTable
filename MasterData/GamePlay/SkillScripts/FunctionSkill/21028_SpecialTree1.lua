local bs_21028 = class("bs_21028", LuaSkillBase)
local base = LuaSkillBase
bs_21028.config = {buffId = 1059}

function bs_21028:ctor()
end

function bs_21028:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_21028_1", 2, self.OnSetHurt, self.caster)
end

function bs_21028:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and not context.isTriggerSet and context.skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, 1, 75)
  end
end

function bs_21028:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21028
