local base = require("GamePlay.SkillScripts.RoleUltSkill.103903_CentaureissUlt")
local bs_206925 = class("bs_206925", base)
bs_206925.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1005
}
bs_206925.config = setmetatable(bs_206925.config, {
  __index = base.config
})

function bs_206925:HandleSelectTarget()
  local role = self.caster.recordTable.lastAttackRole
  if role == nil or not LuaSkillCtrl:IsAbleAttackTarget(self.caster, role, self.cskill.SkillRange) then
    local target = self:GetMoveSelectTarget()
    role = target.targetRole
  end
  self.caster:LookAtInstantly(role)
  return role
end

function bs_206925:PlaySkill(data, selectTargetCoord, selectRoles)
  local casterWaitTime = self.arglist[2] * 2 + 20
  self.invokeTimer = self:PlayMonsterUltSkill(casterWaitTime, self.config)
end

function bs_206925:InternalInvoke(data, role)
  base.PlaySkill(self, data, role)
end

function bs_206925:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206925
