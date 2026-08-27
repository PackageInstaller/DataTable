local bs_91005 = class("bs_91005", LuaSkillBase)
local base = LuaSkillBase
bs_91005.config = {buffId = 2005, buffTier = 1}

function bs_91005:ctor()
end

function bs_91005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_91005_1", 1, self.OnAfterPlaySkill)
end

function bs_91005:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_91005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91005
