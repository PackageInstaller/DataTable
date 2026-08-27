local base = require("GamePlay.SkillScripts.RoleUltSkill.102203_AkiUlt")
local bs_206920 = class("bs_206920", base)
bs_206920.config = {
  delayInvoke = 20,
  buffId_Super = 196,
  actionId_start = 1005
}
bs_206920.config = setmetatable(bs_206920.config, {
  __index = base.config
})

function bs_206920:HandleSelectTarget()
  local role = self.caster.recordTable.lastAttackRole
  if role == nil or not LuaSkillCtrl:IsAbleAttackTarget(self.caster, role, self.cskill.SkillRange) then
    local target = self:GetMoveSelectTarget()
    role = target.targetRole
  end
  self.caster:LookAtInstantly(role)
  return role
end

function bs_206920:PlaySkill(data, selectTargetCoord, selectRoles)
  self.invokeTimer = self:PlayMonsterUltSkill(40, self.config)
end

function bs_206920:InternalInvoke(data, role)
  base.PlaySkill(self, data, role, role, SelectRolesType.SingleRole)
end

function bs_206920:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

return bs_206920
