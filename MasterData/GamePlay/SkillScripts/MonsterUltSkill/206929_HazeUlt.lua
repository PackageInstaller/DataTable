local base = require("GamePlay.SkillScripts.RoleUltSkill.104603_HazeUlt")
local bs_206929 = class("bs_206929", base)
bs_206929.config = {
  delayInvoke = 20,
  actionId_start = 1005,
  buffId_Super = 196
}
bs_206929.config = setmetatable(bs_206929.config, {
  __index = base.config
})

function bs_206929:PlaySkill(data, selectTargetCoord, selectRoles)
  local time = self.arglist[3] + self.config.start_time + self.config.end_time + 20
  self.invokeTimer = self:PlayMonsterUltSkill(time, self.config)
end

function bs_206929:InternalInvoke(data, role)
  base.PlaySkill(self, data, role)
end

function bs_206929:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206929
