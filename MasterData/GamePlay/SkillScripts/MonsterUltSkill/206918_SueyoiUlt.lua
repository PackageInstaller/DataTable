local base = require("GamePlay.SkillScripts.RoleUltSkill.104503_SueyoiUlt")
local bs_206918 = class("bs_206918", base)
bs_206918.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1005
}
bs_206918.config = setmetatable(bs_206918.config, {
  __index = base.config
})

function bs_206918:PlaySkill(data, selectTargetCoord, selectRoles)
  local casterWaitTime = 40 + self.arglist[1] + self.config.end_time
  self.invokeTimer = self:PlayMonsterUltSkill(casterWaitTime, self.config)
end

function bs_206918:InternalInvoke(data, role)
  local roles = {
    [0] = role
  }
  base.PlaySkill(self, data, role, roles)
end

function bs_206918:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206918
