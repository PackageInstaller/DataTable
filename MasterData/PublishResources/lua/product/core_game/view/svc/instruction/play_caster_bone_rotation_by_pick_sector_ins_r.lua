require("base_ins_r")
_class("PlayCasterBoneRotationByPickSectorInstruction", BaseInstruction)
PlayCasterBoneRotationByPickSectorInstruction = PlayCasterBoneRotationByPickSectorInstruction

function PlayCasterBoneRotationByPickSectorInstruction:Constructor(paramList)
  self._bone = paramList.bone
  local absAngle = paramList.absAngle
  local absAangleNum = 45
  if absAngle then
    absAangleNum = tonumber(absAngle)
  end
  self._absAngleNum = absAangleNum
  local strDuration = paramList.duration
  self._duration = strDuration and tonumber(strDuration) or 0
end

function PlayCasterBoneRotationByPickSectorInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local tfBone = self:GetTransform(casterEntity)
  if not tfBone then
    Log.fatal("### PlayCasterBoneRotationByPickSectorInstruction cant find bone", self._bone)
  end
  local finalRotateAngle = 0
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local scopeGridList = renderPickUpComponent:GetAllValidPickUpGridPos()
  local curPos = casterEntity:GetGridPosition()
  if scopeGridList and 2 <= #scopeGridList then
    local mainDirPos = scopeGridList[1]
    local expandDirPos = scopeGridList[2]
    local mainDir = mainDirPos - curPos
    local expandDir = expandDirPos - mainDirPos
    local mainDirVec3 = Vector3(mainDir.x, mainDir.y, 0)
    local expandDirVec3 = Vector3(expandDir.x, expandDir.y, 0)
    local crossRes = Vector3.Cross(mainDirVec3, expandDirVec3)
    local angleDirFlag = 0
    if 0 < crossRes.z then
      angleDirFlag = -1
    elseif 0 > crossRes.z then
      angleDirFlag = 1
    end
    finalRotateAngle = self._absAngleNum * angleDirFlag
  end
  self._rotation = Quaternion.Euler(0, finalRotateAngle, 0)
  self:DORotate(TT, casterEntity, world)
end

function PlayCasterBoneRotationByPickSectorInstruction:GetTransform(e)
  local cView = e:View()
  local tran = cView.ViewWrapper.Transform
  local tfBone = GameObjectHelper.FindChild(tran, self._bone)
  return tfBone
end

function PlayCasterBoneRotationByPickSectorInstruction:DORotate(TT, e, world)
  local skillEffectResultContainer = e:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.RotateByPickSector)
  local endRotation = Quaternion.identity
  if resultArray then
    for i, result in ipairs(resultArray) do
      local rotateAngle = result:GetRotateAngle()
      local dirNew = result:GetDirNew()
      local rotQua = Quaternion.Euler(0, rotateAngle, 0)
      local tfBone = self:GetTransform(e)
      endRotation = rotQua * tfBone.localRotation
      local oriRotation = tfBone.localRotation
      local tweener = tfBone:DOLocalRotateQuaternion(endRotation, self._duration * 0.001)
      tweener:OnComplete(function()
        local finalDir = tfBone.forward
        e:SetDirection(finalDir)
        tfBone.localRotation = oriRotation
      end)
    end
    if 0 < self._duration then
      YIELD(TT, self._duration)
    end
  else
    local tfBone = self:GetTransform(e)
    endRotation = self._rotation * tfBone.localRotation
    local oriRotation = tfBone.localRotation
    local tweener = tfBone:DOLocalRotateQuaternion(endRotation, self._duration * 0.001)
    tweener:OnComplete(function()
      local finalDir = tfBone.forward
      e:SetDirection(finalDir)
      tfBone.localRotation = oriRotation
    end)
    if 0 < self._duration then
      YIELD(TT, self._duration)
    end
  end
end
