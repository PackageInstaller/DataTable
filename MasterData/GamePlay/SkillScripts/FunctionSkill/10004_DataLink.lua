local bs_10004 = class("bs_10004", LuaSkillBase)
local base = LuaSkillBase
bs_10004.config = {}

function bs_10004:ctor()
end

function bs_10004:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_10004_2", 1, self.OnSetHurt, nil, nil, nil, self.caster.belongNum)
end

function bs_10004:OnSetHurt(context)
  if context.target ~= self.caster and context.target.belongNum == self.caster.belongNum and context.target.hp < self.caster.hp then
    self:PlayChipEffect()
    self.caster.recordTable.hurtOffSet = context.hurt * self.arglist[1] // 1000
    if self.caster.recordTable.hurtOffSet > 0 then
      context.hurt = context.hurt - self.caster.recordTable.hurtOffSet
      LuaSkillCtrl:RemoveLife(self.caster.recordTable.hurtOffSet, self, self.caster, true, nil, true, false, eHurtType.RealDmg)
    end
  end
end

function bs_10004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10004
