local bs_10212 = class("bs_10212", LuaSkillBase)
local base = LuaSkillBase
bs_10212.config = {checkBuffId = 26, buffId = 1062}

function bs_10212:ctor()
end

function bs_10212:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10212_2", 1, self.OnSetHurt, self.caster)
end

function bs_10212:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:RoleContainsCtrlBuff(context.target) then
    self:PlayChipEffect()
    local preTier = self.caster:GetBuffTier(self.config.buffId)
    local tier = 1
    if preTier >= self.arglist[3] then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, tier, true)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, tier, nil, true)
  end
end

function bs_10212:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10212
