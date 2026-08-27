local bs_10148 = class("bs_10148", LuaSkillBase)
local base = LuaSkillBase
bs_10148.config = {buffId = 1016}

function bs_10148:ctor()
end

function bs_10148:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10148_2", 2, self.OnAfterPlaySkill)
end

function bs_10148:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], self.arglist[2], true)
  end
end

function bs_10148:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10148
