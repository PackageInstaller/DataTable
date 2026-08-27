local Feature_1019 = class("Feature_1019", LuaSkillBase)
local base = LuaSkillBase
Feature_1019.config = {buffId = 2101}

function Feature_1019:ctor()
end

function Feature_1019:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("Feature_1019", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil)
end

function Feature_1019:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.skillTag == eSkillTag.commonAttack and not isMiss and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId, 1, self.arglist[2], true)
  end
end

function Feature_1019:OnCasterDie()
  base.OnCasterDie(self)
end

return Feature_1019
