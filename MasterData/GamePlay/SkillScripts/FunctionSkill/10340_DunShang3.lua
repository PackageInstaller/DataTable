local bs_10340 = class("bs_10340", LuaSkillBase)
local base = LuaSkillBase
bs_10340.config = {buffId = 1272, duration = 75}

function bs_10340:ctor()
end

function bs_10340:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10340_1", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_10340:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.caster == target and not isMiss and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_10340:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10340
