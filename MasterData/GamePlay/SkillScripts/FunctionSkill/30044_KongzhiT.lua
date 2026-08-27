local bs_30044 = class("bs_30044", LuaSkillBase)
local base = LuaSkillBase
bs_30044.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0
  }
}

function bs_30044:ctor()
end

function bs_30044:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_30044_2", 1, self.OnBeforeAddBuff, self.caster)
end

function bs_30044:OnBeforeAddBuff(target, context)
  if context.buff.buffCfg.IsControl then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_30044:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30044
