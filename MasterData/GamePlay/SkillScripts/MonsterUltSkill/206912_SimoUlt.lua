local base = require("GamePlay.SkillScripts.RoleUltSkill.100403_SimoUlt")
local bs_206912 = class("bs_206912", base)
bs_206912.config = {delayInvoke = 10, actionId_start = 1005}
bs_206912.config = setmetatable(bs_206912.config, {
  __index = base.config
})

function bs_206912:PlaySkill(data)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206912:InternalInvoke(data, role)
  base.PlaySkill(self, data)
end

function bs_206912:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206912
