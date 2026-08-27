local bs_1012 = class("bs_1012", LuaSkillBase)
local base = LuaSkillBase
bs_1012.config = {buffId_slience = 26}

function bs_1012:ctor()
end

function bs_1012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1012", 9, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_1012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isTriggerSet ~= true and 0 < hurt and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId_slience, 1, self.arglist[2], true)
  end
end

function bs_1012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1012
