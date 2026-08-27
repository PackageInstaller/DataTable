local base = require("GamePlay.SkillScripts.RoleUltSkill.100203_AnnaInvasion")
local bs_206908 = class("bs_206908", base)
bs_206908.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1005
}
bs_206908.config = setmetatable(bs_206908.config, {
  __index = base.config
})

function bs_206908:PlaySkill(data)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206908:InternalInvoke(data, role)
  base.PlaySkill(self, data)
end

function bs_206908:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206908
