local bs_10132 = class("bs_10132", LuaSkillBase)
local base = LuaSkillBase
bs_10132.config = {buffId = 1030}

function bs_10132:ctor()
end

function bs_10132:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10132_3", 1, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10132_2", 1, self.OnAfterPlaySkill)
end

function bs_10132:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isTriggerSet and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
  end
end

function bs_10132:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_10132:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10132
