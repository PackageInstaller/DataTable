local bs_107910 = class("bs_107910", LuaSkillBase)
local base = LuaSkillBase
bs_107910.config = {
  buffId = 107901,
  hurt_config = {crit_formula = 9992, crithur_ratio = 9995}
}

function bs_107910:ctor()
end

function bs_107910:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultStartTrigger("bs_107910_15", 40, self.OnHurtResultStart, self.caster)
end

function bs_107910:OnHurtResultStart(skill, context)
  if skill.skillType == eBattleSkillLogicType.Original and not skill.isCommonAttack and context.sender:GetBuffTier(self.config.buffId) > 0 and context.sender == self.caster and context.hurt_type ~= 2 then
    local critFurmula = context.config.crit_formula
    if critFurmula == nil or critFurmula == 0 then
      context.new_config = self.config.hurt_config
      setmetatable(context.new_config, {
        __index = context.config
      })
    end
  end
end

function bs_107910:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107910
