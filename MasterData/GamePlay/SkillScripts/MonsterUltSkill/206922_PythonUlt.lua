local base = require("GamePlay.SkillScripts.RoleUltSkill.104303_PythonUlt")
local bs_206922 = class("bs_206922", base)
bs_206922.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1005
}
bs_206922.config = setmetatable(bs_206922.config, {
  __index = base.config
})

function bs_206922:PlaySkill(data, selectTargetCoord, selectRoles)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206922:InternalInvoke(data, role)
  base.PlaySkill(self, data, role, role)
end

function bs_206922:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206922
