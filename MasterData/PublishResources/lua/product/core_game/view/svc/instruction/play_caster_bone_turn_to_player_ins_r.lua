require("base_ins_r")
_class("PlayCasterBoneTurnToPlayerInstruction", BaseInstruction)
PlayCasterBoneTurnToPlayerInstruction = PlayCasterBoneTurnToPlayerInstruction

function PlayCasterBoneTurnToPlayerInstruction:Constructor(paramList)
  self._bone = paramList.bone
  self._duration = tonumber(paramList.duration) or 0
  self._block = tonumber(paramList.block) or 0
end

function PlayCasterBoneTurnToPlayerInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local tfBone = self:GetTransform(casterEntity)
  if not tfBone then
    Log.fatal("### PlayCasterBoneRotationByPickSectorInstruction cant find bone", self._bone)
  end
  local oriEulerAngles = tfBone.localEulerAngles
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local targetEntity = teamEntity:GetTeamLeaderPetEntity()
  local holderTf = targetEntity:View().ViewWrapper.Transform
  local targetPos = holderTf.position
  tfBone:LookAt(targetPos, Vector3.up)
  local lookAtEulerAngles = tfBone.localEulerAngles
  tfBone.localEulerAngles = oriEulerAngles
  local endRotation = Quaternion.Euler(oriEulerAngles.x, lookAtEulerAngles.y, lookAtEulerAngles.z)
  local tweener = tfBone:DOLocalRotateQuaternion(endRotation, self._duration / 1000)
  if self._duration > 0 and self._block == 1 then
    YIELD(TT, self._duration)
  end
end

function PlayCasterBoneTurnToPlayerInstruction:GetTransform(e)
  local cView = e:View()
  local tran = cView.ViewWrapper.Transform
  local tfBone = GameObjectHelper.FindChild(tran, self._bone)
  return tfBone
end
