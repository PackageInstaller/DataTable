local bs_50012 = class("bs_50012", LuaSkillBase)
local base = LuaSkillBase
bs_50012.config = {buffId = 1086, effectId = 10642}

function bs_50012:ctor()
end

function bs_50012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_50012_3", 2, self.OnAfterHurt, nil, self.caster)
end

function bs_50012:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss then
    local buffTier = target:GetBuffTier(self.config.buffId)
    if 0 < buffTier then
      if buffTier == 1 then
        LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      end
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
    end
  end
end

function bs_50012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50012
