local bs_10324 = class("bs_10324", LuaSkillBase)
local base = LuaSkillBase
bs_10324.config = {buffId = 1261, buffTier = 15}

function bs_10324:ctor()
end

function bs_10324:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10324_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10324:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit and self:IsReadyToTake() and not isTriggerSet then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil, true)
  end
end

function bs_10324:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10324
