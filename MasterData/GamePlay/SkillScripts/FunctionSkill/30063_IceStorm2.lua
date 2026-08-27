local bs_30063 = class("bs_30063", LuaSkillBase)
local base = LuaSkillBase
bs_30063.config = {checkBuffId = 1178}

function bs_30063:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_30063_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.ultSkill)
end

function bs_30063:OnSetHurt(context)
  if context.skill.skillType ~= eBattleSkillLogicType.Original then
    return
  end
  if context.sender == self.caster and context.target.belongNum ~= self.caster.belongNum then
    local buffTier = context.target:GetBuffTier(self.config.checkBuffId)
    context.hurt = context.hurt * (buffTier * self.arglist[1] + 1000) // 1000
  end
end

function bs_30063:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30063
