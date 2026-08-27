local bs_91000 = class("bs_91000", LuaSkillBase)
local base = LuaSkillBase
bs_91000.config = {buffId = 2000, buffTier = 1}

function bs_91000:ctor()
end

function bs_91000:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_91000_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_91000:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_91000:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91000
