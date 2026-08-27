local base = require("GamePlay.SkillScripts.RoleUltSkill.100503_Robot")
local bs_206906 = class("bs_206906", base)
bs_206906.config = {delayInvoke = 20, actionId_start = 1005}
bs_206906.config = setmetatable(bs_206906.config, {
  __index = base.config
})

function bs_206906:PlaySkill()
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206906:InternalInvoke()
  base.PlaySkill(self)
end

function bs_206906:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206906
