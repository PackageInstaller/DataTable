local bs_92053 = class("bs_92053", LuaSkillBase)
local base = LuaSkillBase
bs_92053.config = {buffId = 2037, buffTier = 1}

function bs_92053:ctor()
end

function bs_92053:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92053_2", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_92053:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if not isMiss then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_92053:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92053
