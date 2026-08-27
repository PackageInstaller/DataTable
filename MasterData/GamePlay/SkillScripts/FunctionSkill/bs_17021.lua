local bs_17021 = class("bs_17021", LuaSkillBase)
local base = LuaSkillBase
bs_17021.config = {buffId_drug = 2099}

function bs_17021:ctor()
end

function bs_17021:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_17021_1", 99, self.OnSetDeadHurt, self.caster)
end

function bs_17021:OnSetDeadHurt(context)
  if context.target.belongNum == eBattleRoleBelong.enemy and context.target:GetBuffTier(self.config.buffId_drug) > 0 and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] then
    local grid = LuaSkillCtrl:GetGridWithRole(context.target)
    LuaSkillCtrl:CallHurtPool(self, 3, grid.x, grid.y)
  end
end

function bs_17021:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17021
