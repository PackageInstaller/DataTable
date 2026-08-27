local bs_91002 = class("bs_91002", LuaSkillBase)
local base = LuaSkillBase
bs_91002.config = {buffId = 2002, buffTier = 1}

function bs_91002:ctor()
end

function bs_91002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_91002_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_91002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_91002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91002
