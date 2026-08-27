local bs_30053 = class("bs_30053", LuaSkillBase)
local base = LuaSkillBase
bs_30053.config = {ysBuff = 1227}

function bs_30053:ctor()
end

function bs_30053:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_30053_1", 1, self.OnSetHurt, self.caster)
end

function bs_30053:OnSetHurt(context)
  if self:IsReadyToTake() then
    self:PlayChipEffect()
    local buffTier = context.target:GetBuffTier(self.config.ysBuff)
    if 0 < buffTier then
      context.hurt = context.hurt + context.hurt * buffTier * self.arglist[1] // 1000
    end
  end
end

function bs_30053:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30053
