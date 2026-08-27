local bs_10197 = class("bs_10197", LuaSkillBase)
local base = LuaSkillBase
bs_10197.config = {}

function bs_10197:ctor()
end

function bs_10197:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10197_2", 1, self.OnSetHurt, nil, self.caster, eBattleRoleBelong.neutral)
end

function bs_10197:OnSetHurt(context)
  if context.sender.belongNum == 0 and context.target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    self:PlayChipEffect()
    context.hurt = 0
  end
end

function bs_10197:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10197
