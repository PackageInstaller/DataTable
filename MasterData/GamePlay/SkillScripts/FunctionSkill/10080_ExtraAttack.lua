local bs_10080 = class("bs_10080", LuaSkillBase)
local base = LuaSkillBase
bs_10080.config = {
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  damageFormula = 10007
}

function bs_10080:ctor()
end

function bs_10080:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10080_1", 1, self.OnAfterHurt, self.caster)
end

function bs_10080:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and skill.isCommonAttack and not isTriggerSet then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
    for i = 0, targetlist.Count - 1 do
      if targetlist[i].targetRole ~= target then
        local damage = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, self.caster, targetlist[i].targetRole, self)
        if not (damage <= 0) then
          LuaSkillCtrl:RemoveLife(damage, self, targetlist[i].targetRole)
        end
        break
      end
    end
  end
end

function bs_10080:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10080
