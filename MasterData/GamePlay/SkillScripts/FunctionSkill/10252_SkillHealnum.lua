local bs_10252 = class("bs_10252", LuaSkillBase)
local base = LuaSkillBase
bs_10252.config = {buffId = 1142, buffTier = 1}

function bs_10252:ctor()
end

function bs_10252:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10252_1", 2, self.OnAfterPlaySkill)
end

function bs_10252:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_10252:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10252
