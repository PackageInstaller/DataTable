local bs_15214 = class("bs_15214", LuaSkillBase)
local base = LuaSkillBase
bs_15214.config = {buffId = 110112}

function bs_15214:ctor()
end

function bs_15214:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15214_3", 1, self.OnAfterHurt, self.caster)
end

function bs_15214:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not isTriggerSet then
    local buffTier = target:GetBuffTier(self.config.buffId)
    if buffTier < self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, nil, true)
    end
  end
end

function bs_15214:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15214
