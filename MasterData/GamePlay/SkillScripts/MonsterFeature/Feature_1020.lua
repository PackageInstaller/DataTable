local Feature_1020 = class("Feature_1020", LuaSkillBase)
local base = LuaSkillBase
Feature_1020.config = {buffId = 2102}

function Feature_1020:ctor()
end

function Feature_1020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("Feature_1020_1", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil)
end

function Feature_1020:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.skillTag ~= eSkillTag.commonAttack and not isMiss and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, 1, self.arglist[2], true)
  end
end

function Feature_1020:OnCasterDie()
  base.OnCasterDie(self)
end

return Feature_1020
