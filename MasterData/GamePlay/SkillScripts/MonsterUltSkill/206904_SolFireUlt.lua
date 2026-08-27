local base = require("GamePlay.SkillScripts.RoleUltSkill.100303_SolFireUlt")
local bs_206904 = class("bs_206904", base)
bs_206904.config = {
  delayInvoke = 7,
  buffId_Super = 196,
  actionId_start = 1001,
  radius = 300,
  arcAngleRange = 121
}
bs_206904.config = setmetatable(bs_206904.config, {
  __index = base.config
})

function bs_206904:HandleSelectTarget()
  local role = self.caster.recordTable.lastAttackRole
  if role == nil or not LuaSkillCtrl:IsAbleAttackTarget(self.caster, role, self.cskill.SkillRange) then
    local target = self:GetMoveSelectTarget()
    role = target.targetRole
  end
  self.selectRoles = {}
  local casterLsObj = self.caster.lsObject
  local selectTargetPos = role.lsObject.localPosition
  local forwardDir = CS.TrueSync.TSVector3.Subtract(selectTargetPos, casterLsObj.localPosition).normalized
  local ColliderEnter = BindCallback(self, self.OnColliderEnter, forwardDir, selectTargetPos)
  self.fireCollider = LuaSkillCtrl:CallGetCircleSkillCollider(self, self.config.radius, eColliderInfluenceType.Enemy, ColliderEnter)
  self.fireCollider.lsObject = CS.LSUnityObject()
  self.fireCollider:SetColiderObjPosForce(casterLsObj.localPosition)
  self.caster:LookAtInstantly(role)
  return role
end

function bs_206904:OnColliderEnter(forwardDir, selectTargetPos, collider, index, entity)
  local angle = 0
  if not entity.lsObject.localPosition:Equals(selectTargetPos) then
    local curdir = CS.TrueSync.TSVector3.Subtract(entity.lsObject.localPosition, selectTargetPos).normalized
    local quaForward = CS.TrueSync.TSQuaternion.LookRotation(forwardDir)
    local qua = CS.TrueSync.TSQuaternion.LookRotation(curdir)
    if not qua:Equals(quaForward) then
      angle = CS.TrueSync.TSQuaternion.PerigonAngle(quaForward, qua):AsInt()
    end
  end
  if 180 < angle then
    angle = 360 - angle
  end
  if angle > self.config.arcAngleRange then
    return
  end
  if self.caster == nil or 0 >= self.caster.hp then
    return
  end
  table.insert(self.selectRoles, entity)
end

function bs_206904:PlaySkill(data, selectTargetCoord, selectRoles)
  local targetRole = self:HandleSelectTarget()
  if targetRole == nil then
    return nil
  end
  self:CallCasterWait(43)
  LuaSkillCtrl:StartTimer(nil, 1, BindCallback(self, self.InternalPlay, targetRole))
end

function bs_206904:InternalPlay(targetRole)
  if self.fireCollider ~= nil then
    LuaSkillCtrl:ClearColliderOrEmission(self.fireCollider)
    self.fireCollider = nil
  end
  if self.config.buffId_Super ~= nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Super, 1, 15, true)
  end
  if self.config.actionId_start ~= nil then
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
  end
  self.invokeTimer = LuaSkillCtrl:StartTimer(nil, self.config.delayInvoke, BindCallback(self, self.InternalInvoke, self.config, targetRole, self.selectRoles))
end

function bs_206904:InternalInvoke(data, targetRole, roles)
  base.PlaySkill(self, data, targetRole, roles, SelectRolesType.LuaRoleArray)
end

function bs_206904:OnCasterDie()
  if self.invokeTimer ~= nil then
    self.invokeTimer:Stop()
    self.invokeTimer = nil
  end
  base.OnCasterDie(self)
end

function bs_206904:LuaDispose()
  base.LuaDispose(self)
  self.selectRoles = nil
end

return bs_206904
