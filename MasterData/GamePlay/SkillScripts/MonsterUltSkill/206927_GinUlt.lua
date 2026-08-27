local base = require("GamePlay.SkillScripts.RoleUltSkill.100803_GinUlt")
local bs_206927 = class("bs_206927", base)
bs_206927.config = {delayInvoke = 20, actionId_start = 1005}
bs_206927.config = setmetatable(bs_206927.config, {
  __index = base.config
})

function bs_206927:PlaySkill(data, selectTargetCoord, selectRoles)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206927:InternalInvoke(data, role)
  base.PlaySkill(self, data)
end

function bs_206927:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206927
