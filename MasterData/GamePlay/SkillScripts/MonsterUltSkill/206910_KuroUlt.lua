local base = require("GamePlay.SkillScripts.RoleUltSkill.104403_KuroUlt")
local bs_206910 = class("bs_206910", base)
bs_206910.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1005
}
bs_206910.config = setmetatable(bs_206910.config, {
  __index = base.config
})

function bs_206910:HandleSelectTarget()
  local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(eBattleRoleBelong.player)
  local targetGrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  self.caster:LookAtTarget(targetGrid)
  return grid
end

function bs_206910:PlaySkill(data, selectTargetCoord, selectRolesdata)
  self.invokeTimer = self:PlayMonsterUltSkill(30, self.config)
end

function bs_206910:InternalInvoke(data, role)
  base.PlaySkill(self, data, role)
end

function bs_206910:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206910
