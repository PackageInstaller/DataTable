local bs_15066 = class("bs_15066", LuaSkillBase)
local base = LuaSkillBase
bs_15066.config = {buffId = 1059}

function bs_15066:ctor()
end

function bs_15066:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15066_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_15066:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss and isCrit and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] and not isTriggerSet and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, 75)
  end
end

function bs_15066:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15066
