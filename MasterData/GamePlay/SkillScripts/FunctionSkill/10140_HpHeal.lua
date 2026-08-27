local bs_10140 = class("bs_10140", LuaSkillBase)
local base = LuaSkillBase
bs_10140.config = {buffTierFormula = 10039}

function bs_10140:ctor()
end

function bs_10140:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10140_1", 1, self.OnSetHeal, self.caster)
end

function bs_10140:OnSetHeal(context)
  if context.skill.maker == self.caster then
    local target = context.target
    if target.maxHp == 0 then
      return
    end
    local healUpgrade = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, target, self)
    context.heal = context.heal + context.heal * healUpgrade // 1000
  end
end

function bs_10140:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10140
