local bs_30047 = class("bs_30047", LuaSkillBase)
local base = LuaSkillBase
bs_30047.config = {buffId_shixue = 257, buffId_baoji = 1220}

function bs_30047:ctor()
end

function bs_30047:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30047_12", 1, self.OnAfterPlaySkill)
end

function bs_30047:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_shixue, self.arglist[1])
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_baoji, 1)
  end
end

function bs_30047:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30047
