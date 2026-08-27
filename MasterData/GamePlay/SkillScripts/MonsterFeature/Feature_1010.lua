local bs_1010 = class("bs_1010", LuaSkillBase)
local base = LuaSkillBase
bs_1010.config = {buffId_unarm = 205}

function bs_1010:ctor()
end

function bs_1010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1010", 9, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_1010:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isTriggerSet ~= true and 0 < hurt and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.buffId_unarm, 1, self.arglist[2], true)
  end
end

function bs_1010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1010
