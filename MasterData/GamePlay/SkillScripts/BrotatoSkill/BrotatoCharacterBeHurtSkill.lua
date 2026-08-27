local BrotatoCharacterBeHurtSkill = class("BrotatoCharacterBeHurtSkill", LuaSkillBase)
local base = LuaSkillBase
BrotatoCharacterBeHurtSkill.config = {invincibleBuffId = 101000}

function BrotatoCharacterBeHurtSkill:ctor()
end

function BrotatoCharacterBeHurtSkill:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("BrotatoCharacterBeHurtSkill_1", 1, self.OnAfterHurt, nil, self.caster)
end

function BrotatoCharacterBeHurtSkill:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.caster:GetBuffTier(self.config.invincibleBuffId) <= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.invincibleBuffId, 1, nil, true)
  end
end

function BrotatoCharacterBeHurtSkill:OnCasterDie()
  base.OnCasterDie(self)
end

return BrotatoCharacterBeHurtSkill
