local HitBoxBaseCondition, Super = System.NewClass("HitBoxBaseCondition")

function HitBoxBaseCondition:ctor()
  Super.ctor(self)
  self.isSuccess = false
  self.checkSuccess = false
  self.isInitTrigger = false
end

function HitBoxBaseCondition:Awake(info, mainPos, uid, gameObj, triggerItemType)
end

function HitBoxBaseCondition:IsClickBox()
  return self.info.type == "Click"
end

function HitBoxBaseCondition:OnEnter()
  self.isSuccess = false
  self.checkSuccess = false
  self.state = CommonDefine.RunningStateType.Running
  self.player = RoleManager.Instance:GetRole(DataCenter.playerData.DRole.uid)
end

function HitBoxBaseCondition:Update()
end

function HitBoxBaseCondition:OnExit()
end

function HitBoxBaseCondition:IsSuccess()
  do return self.GetIsEnter end
  return self.GetIsEnter, self
end

function HitBoxBaseCondition:GetCheckSuccess()
  do return self.GetIsEnter end
  return self.GetIsEnter, self
end

function HitBoxBaseCondition:IsAwake()
  return self.state == CommonDefine.RunningStateType.Awake
end

function HitBoxBaseCondition:IsRunning()
  return self.state == CommonDefine.RunningStateType.Running
end

function HitBoxBaseCondition:IsEnd()
  return self.state == CommonDefine.RunningStateType.End
end

function HitBoxBaseCondition:GetIsEnter()
  if self.gearTrigger then
    return self.gearTrigger.isTriggered
  end
end

function HitBoxBaseCondition:InitSphereCheck()
  if not self.isInitTrigger and self.gearTrigger then
    self.isInitTrigger = true
    self.gearTrigger:InitSphereTrigger(self.length, System.fn(self, self.OnTriggerEnter), System.fn(self, self.OnTriggerExit))
    self:SetTriggerCenter()
  end
end

function HitBoxBaseCondition:InitRectCheck()
  if not self.isInitTrigger and self.gearTrigger then
    self.isInitTrigger = true
    local size = CS.UnityEngine.Vector3(self.rectInfo.x, self.rectInfo.y, self.rectInfo.z)
    self.gearTrigger:InitBoxTrigger(size, System.fn(self, self.OnTriggerEnter), System.fn(self, self.OnTriggerExit))
    self:SetTriggerCenter()
  end
end

function HitBoxBaseCondition:SetTriggerCenter()
  if self.gearTrigger and self.isShiftMainPos then
    local pos = self.gameObj.transform:InverseTransformPoint(CS.UnityEngine.Vector3(self.pos.x, self.pos.y, self.pos.z))
    self.gearTrigger:SetTriggerCenter(pos)
  end
end

function HitBoxBaseCondition:OnTriggerEnter()
  EventMgr.Instance.HitBoxEnter:Dispatch(self.uid, self.triggerItemType)
end

function HitBoxBaseCondition:OnTriggerExit()
  EventMgr.Instance.HitBoxExit:Dispatch(self.uid, self.triggerItemType)
end

function HitBoxBaseCondition:GetIsTriggered()
  if self.gearTrigger then
    return self.gearTrigger.isTriggered
  end
end

function HitBoxBaseCondition:SphereCheck()
  if self.gearTrigger then
    return self.gearTrigger.isTriggered
  end
end

function HitBoxBaseCondition:RectCheck()
  if self.gearTrigger then
    return self.gearTrigger.isTriggered
  end
end

return HitBoxBaseCondition
