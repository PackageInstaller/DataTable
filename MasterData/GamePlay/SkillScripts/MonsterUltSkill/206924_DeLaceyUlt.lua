local base = require("GamePlay.SkillScripts.RoleUltSkill.104103_DeLaceyUlt")
local bs_206924 = class("bs_206924", base)
bs_206924.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1005
}
bs_206924.config = setmetatable(bs_206924.config, {
  __index = base.config
})

function bs_206924:PlaySkill(data, selectTargetCoord, selectRoles)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206924:InternalInvoke(data, role)
  base.PlaySkill(self, data)
end

function bs_206924:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206924
