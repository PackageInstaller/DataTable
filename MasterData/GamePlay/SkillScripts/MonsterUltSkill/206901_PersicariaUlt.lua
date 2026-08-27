local base = require("GamePlay.SkillScripts.RoleUltSkill.100103_PersicariaUlt")
local bs_206901 = class("bs_206901", base)
bs_206901.config = {delayInvoke = 20, actionId_start = 1005}
bs_206901.config = setmetatable(bs_206901.config, {
  __index = base.config
})

function bs_206901:PlaySkill(data, selectTargetCoord, selectRoles)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206901:InternalInvoke(data, role)
  base.PlaySkill(self, data, nil, role, SelectRolesType.SingleRole)
end

function bs_206901:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206901
