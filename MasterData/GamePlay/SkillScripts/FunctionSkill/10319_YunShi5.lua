local bs_10319 = class("bs_10319", LuaSkillBase)
local base = LuaSkillBase
bs_10319.config = {ysBuff = 1227}

function bs_10319:ctor()
end

function bs_10319:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10319_1", 1, self.OnSetHurt, nil, self.caster, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
end

function bs_10319:OnSetHurt(context)
  if self:IsReadyToTake() then
    local buffTier = context.sender:GetBuffTier(self.config.ysBuff)
    if 0 < buffTier then
      context.hurt = context.hurt - context.hurt * self.arglist[1] * buffTier // 1000
      self:PlayChipEffect()
    end
  end
end

function bs_10319:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10319
