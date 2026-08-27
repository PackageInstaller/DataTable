local bs_17012 = class("bs_17012", LuaSkillBase)
local base = LuaSkillBase
bs_17012.config = {
  freezeBuff = 2097,
  freezeBuffDuration = 75,
  effectId = 10876
}

function bs_17012:ctor()
end

function bs_17012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_17012_10", 1, self.OnRoleDie)
end

function bs_17012:OnRoleDie(killer, role)
  if role.belongNum == eBattleRoleBelong.enemy then
    local grid = LuaSkillCtrl:GetGridWithRole(role)
    LuaSkillCtrl:CallHurtPool(self, 1, grid.x, grid.y)
  end
end

function bs_17012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17012
