local base = require("GamePlay.SkillScripts.RoleUltSkill.101803_FlorenceUlt")
local bs_206926 = class("bs_206926", base)
bs_206926.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1001
}
bs_206926.config = setmetatable(bs_206926.config, {
  __index = base.config
})

function bs_206926:PlaySkill(data, selectTargetCoord, selectRoles)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206926:InternalInvoke(data, role)
  base.PlaySkill(self, data, nil, role, SelectRolesType.SingleRole)
end

function bs_206926:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206926
