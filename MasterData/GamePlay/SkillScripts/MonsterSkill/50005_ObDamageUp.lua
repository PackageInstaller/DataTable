local bs_50005 = class("bs_50005", LuaSkillBase)
local base = LuaSkillBase
bs_50005.config = {}

function bs_50005:ctor()
end

function bs_50005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_50005_2", 1, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.neutral)
end

function bs_50005:OnSetHurt(context)
  if context.sender == self.caster and context.target.belongNum == 0 then
    context.hurt = context.hurt * 2
  end
end

function bs_50005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50005
