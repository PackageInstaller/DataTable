local base = require("GamePlay.SkillScripts.RoleUltSkill.103703_BlackHole")
local bs_206914 = class("bs_206914", base)
bs_206914.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1005
}
bs_206914.config = setmetatable(bs_206914.config, {
  __index = base.config
})

function bs_206914:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallRoleAction(self.caster, 1101)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, 10342, self)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206914:InternalInvoke(data, role)
  base.PlaySkill(self, data, role, role)
end

function bs_206914:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206914
