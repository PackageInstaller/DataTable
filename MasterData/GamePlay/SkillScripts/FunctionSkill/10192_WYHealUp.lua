local bs_10192 = class("bs_10192", LuaSkillBase)
local base = LuaSkillBase
bs_10192.config = {buffId = 1070}

function bs_10192:ctor()
end

function bs_10192:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10192_4", 1, self.OnSetHeal, self.caster, nil, nil, self.caster.belongNum)
end

function bs_10192:OnSetHeal(context)
  if context.target.belongNum == self.caster.belongNum and context.sender == self.caster and not context.isTriggerSet and LuaSkillCtrl:GetRoleEfcGrid(context.target) == 10 then
    self:PlayChipEffect()
    context.heal = context.heal + context.heal * self.arglist[2] // 1000
  end
end

function bs_10192:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10192
