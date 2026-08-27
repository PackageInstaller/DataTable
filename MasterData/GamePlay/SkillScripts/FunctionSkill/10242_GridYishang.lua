local bs_10242 = class("bs_10242", LuaSkillBase)
local base = LuaSkillBase
bs_10242.config = {buffId = 1093, buffTier = 1}

function bs_10242:ctor()
end

function bs_10242:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10242_1", 1, self.OnHurtResultStart)
  self:AddAfterHurtTrigger("bs_10242_2", 2, self.OnAfterHurt, self.caster)
end

function bs_10242:OnHurtResultStart(skill, context)
  if context.sender == self.caster and LuaSkillCtrl:GetRoleEfcGrid(context.target) ~= 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_10242:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isTriggerSet then
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    if buffTier <= 0 then
      return
    end
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_10242:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10242
