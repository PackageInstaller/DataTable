local bs_207602 = class("bs_207602", LuaSkillBase)
local base = LuaSkillBase
bs_207602.config = {BuffId_bleed = 195}

function bs_207602:ctor()
end

function bs_207602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_207602_1", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_207602:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and sender == self.caster and not isMiss then
    LuaSkillCtrl:CallBuff(self, target, self.config.BuffId_bleed, self.arglist[1] / 10, self.arglist[2])
  end
end

function bs_207602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207602
