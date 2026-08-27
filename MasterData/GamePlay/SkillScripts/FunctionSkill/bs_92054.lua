local bs_92054 = class("bs_92054", LuaSkillBase)
local base = LuaSkillBase
bs_92054.config = {}

function bs_92054:ctor()
end

function bs_92054:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_92054_2", 2, self.OnAfterHeal, nil, self.caster)
  self.totalHp = (self.arglist[1] / 1000 + 1) * self.caster.maxHp
end

function bs_92054:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if not isTriggerSet then
    if target.maxHp + heal < self.totalHp then
      self:PlayChipEffect()
      LuaSkillCtrl:CallAddRoleProperty(target, eHeroAttr.maxHp, heal, eHeroAttrType.Extra)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {heal}, true, true)
    else
      self:PlayChipEffect()
      LuaSkillCtrl:CallAddRoleProperty(target, eHeroAttr.maxHp, self.totalHp - target.maxHp, eHeroAttrType.Extra)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HealResultWithConfig(self, skillResult, 6, {
        self.totalHp - target.maxHp
      }, true, true)
    end
  end
end

function bs_92054:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92054
