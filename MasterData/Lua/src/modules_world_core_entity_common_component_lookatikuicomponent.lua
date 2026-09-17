local this = class("lookAtIKUIComponent", L_EcsConst.component)

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:onBindGameObject(go)
  self:initHead()
end

function this:onDestroy()
  this.super.onDestroy(self)
  self:removeForwardIKPoint()
  self:disableIK()
  if self.lookAtControl ~= nil and not self.lookAtControl:IsNull() then
    self.lookAtControl = nil
  end
  if self.lookAtIK ~= nil and not self.lookAtIK:IsNull() then
    self.lookAtIK = nil
  end
end

function this:initHead()
  local go = self:getGameObject()
  if L_CommonUtil.isValid(go:GetComponent(typeof(C_LookAtIK))) then
    self.lookAtIK = go:PickComponent(typeof(C_LookAtIK))
    self.lookAtIK.enabled = true
    self.lookAtControl = go:PickComponent(typeof(C_LookAtController))
    self.lookAtControl.enabled = true
    local leftEye = L_GameUtil.findTranByName(go, "LeftHeadEyeA01")
    local rightEye = L_GameUtil.findTranByName(go, "RightHeadEyeA01")
    local neck = L_GameUtil.findTranByName(go, "Neck")
    local spine = L_GameUtil.findTranByName(go, "Spine")
    local spine1 = L_GameUtil.findTranByName(go, "Spine1")
    local spineArr = {
      spine,
      spine1,
      neck
    }
    local eyes = {leftEye, rightEye}
    self.head = self.lookAtIK.solver.head.transform
    if not table.isEmpty(eyes) then
      self.eyes = eyes
    end
    self.spineArr = spineArr
  else
    self.lookAtIK = go:PickComponent(typeof(C_LookAtIK))
    self.lookAtIK.enabled = true
    self.lookAtIK.fixTransforms = false
    self.lookAtControl = go:PickComponent(typeof(C_LookAtController))
    self.lookAtControl.enabled = true
    self.lookAtControl.ik = self.lookAtIK
    self.lookAtControl.pivotOffsetFromRoot = C_Vector3.zero
    local head = L_GameUtil.findTranByName(go, "Head")
    local leftEye = L_GameUtil.findTranByName(go, "LeftHeadEyeA01")
    local rightEye = L_GameUtil.findTranByName(go, "RightHeadEyeA01")
    local neck = L_GameUtil.findTranByName(go, "Neck")
    local spine = L_GameUtil.findTranByName(go, "Spine")
    local spine1 = L_GameUtil.findTranByName(go, "Spine1")
    local spineArr = {
      spine,
      spine1,
      neck
    }
    local eyes = {leftEye, rightEye}
    if head == nil then
      return
    end
    self.head = head
    if not table.isEmpty(eyes) then
      self.eyes = eyes
    end
    self.spineArr = spineArr
    self.lookAtIK.solver.bodyWeight = 0.4
    self.lookAtIK.solver.headWeight = 0.4
    self.lookAtIK.solver.eyesWeight = 0.2
    self.lookAtIK.solver.clampWeightEyes = 0.9
    self.lookAtIK.solver.clampWeightHead = 0.9
    self.lookAtIK.solver.clampWeight = 0.7
    self.lookAtIK.solver.head.transform = self.head
    local spineRootBone = C_IKSolverLookAt.LookAtBone()
    spineRootBone.transform = spine
    local spine1Bone = C_IKSolverLookAt.LookAtBone()
    spine1Bone.transform = spine1
    local neckBone = C_IKSolverLookAt.LookAtBone()
    neckBone.transform = neck
    self.lookAtIK.solver.spine = {
      spineRootBone,
      spine1Bone,
      neckBone
    }
    if self.eyes then
      local eye1 = C_IKSolverLookAt.LookAtBone()
      eye1.transform = self.eyes[1]
      local eye2 = C_IKSolverLookAt.LookAtBone()
      eye2.transform = self.eyes[2]
      self.lookAtIK.solver.eyes = {eye1, eye2}
    end
  end
end

function this:getHead()
  return self.head
end

function this:getHeadCenter()
  local center = L_Vector3.getTransformPoint(self.head, -0.06, 0, 0)
  return center
end

function this:enableIK(lookTran)
  if not self.head then
    return
  end
  self.lookAtControl.slerpSpeed = 0
  self.lookAtControl.target = nil
  self.lookAtControl.target = lookTran
  self.lookAtControl.slerpSpeed = 1
end

function this:enableIKImmediately(lookTran)
  if not self.head then
    return
  end
  self.lookAtControl.target = nil
  self.lookAtControl.weight = 1
  self.lookAtControl.weightSmoothTime = 0
  self.lookAtControl.smoothTurnTowardsTarget = false
  self.lookAtControl.target = lookTran
end

function this:setIKDistance(distance)
  self.lookAtIK.solver.lookatIkDistance = distance
end

function this:tryEnableIK(lookTran)
  if self.lookAtControl.target then
    return
  end
  self:enableIK(lookTran)
end

function this:disableIK()
  if not self.head then
    return
  end
  if L_CommonUtil.isValid(self.lookAtControl) then
    self.lookAtControl.target = nil
    self.lookAtControl.lastTarget = nil
  end
end

function this:getForwardIKPoint(reset)
  if self.ikPoint == nil then
    local trans = self:getTransform()
    self.ikPoint = trans:Find("ikPoint")
    if self.ikPoint then
    else
      self.ikPoint = C_GameObject("ikPoint").transform
      self.ikPoint:SetParent(trans)
    end
    reset = true
  end
  if reset then
    local trans = self:getTransform()
    local bindTrans = self.head or trans
    local pos = L_Vector3.getPos(bindTrans)
    L_Vector3.setPos(self.ikPoint, L_Vector3.getTemp(0, pos.y, 2))
    L_Vector3.setLocalRot(self.ikPoint, L_Vector3.getTemp())
  end
  return self.ikPoint
end

function this:removeForwardIKPoint()
  if self.ikPoint == nil then
    return
  end
  C_GameObject.Destroy(self.ikPoint.gameObject)
  self.ikPoint = nil
end

function this:addPostUpdate(action)
  if self.lookAtIK == nil then
    return
  end
  self.lookAtIK.solver.OnPostUpdate = action
end

function this:removePostUpdate(action)
  if self.lookAtIK == nil then
    return
  end
  self.lookAtIK.solver.OnPostUpdate = nil
end

return this
