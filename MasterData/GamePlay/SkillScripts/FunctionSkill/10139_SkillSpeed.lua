local bs_10139 = class("bs_10139", LuaSkillBase)
local base = LuaSkillBase
bs_10139.config = {buffId = 1156, buffTier = 1}

function bs_10139:ctor()
end

function bs_10139:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10139_1", 1, self.OnAfterPlaySkill)
end

function bs_10139:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
  end
end

function bs_10139:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10139
