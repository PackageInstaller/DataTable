local AwakerFaceManager, Super = System.NewClass("AwakerFaceManager", Manager)

function AwakerFaceManager:ctor()
  Super.ctor(self)
  self.currAwakerTid = 0
  self.faceTimers = {}
end

function AwakerFaceManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
end

function AwakerFaceManager:SwitchFace(awakerTid, facialExpressionSwitch)
  local isHaveZeroTimeFace = self:GetZeroFace(facialExpressionSwitch)
  self:StopSwitchFace(isHaveZeroTimeFace)
  self:_StartFaceChange(awakerTid, facialExpressionSwitch)
end

function AwakerFaceManager:_StartFaceChange(awakerTid, facialExpressionSwitch)
  if not awakerTid or 0 == awakerTid or not facialExpressionSwitch then
    return
  end
  self.currAwakerTid = awakerTid
  local faceChangeList = facialExpressionSwitch:split(",")
  for idx = 1, #faceChangeList, 2 do
    local time = tonumber(faceChangeList[idx])
    local face = faceChangeList[idx + 1]
    local timer = self.binder:BindTimer(time, 0, nil, function()
      EventMgr.Instance.AwakerFaceChange:Dispatch(self:GetFaceTarget(), "" ~= face and face or nil)
    end)
    table.insert(self.faceTimers, timer)
  end
end

function AwakerFaceManager:GetZeroFace(facialExpressionSwitch)
  if not facialExpressionSwitch then
    return
  end
  local faceChangeList = facialExpressionSwitch:split(",")
  if "0" == faceChangeList[1] then
    return faceChangeList[2]
  end
end

function AwakerFaceManager:StopSwitchFace(isHaveZeroTimeFace)
  for idx = #self.faceTimers, 1, -1 do
    local timer = table.remove(self.faceTimers, idx)
    self.binder:StopTimer(timer)
  end
  if not isHaveZeroTimeFace and 0 ~= self.currAwakerTid then
    EventMgr.Instance.AwakerFaceChange:Dispatch(self:GetFaceTarget())
    self.currAwakerTid = 0
  end
end

function AwakerFaceManager:GetFaceTarget()
  do return AwakerDataUtils.GetAwakerResNum end
  return AwakerDataUtils.GetAwakerResNum, self.currAwakerTid
end

function AwakerFaceManager:OnDestroy()
  Super.OnDestroy(self)
  self:StopSwitchFace()
end

return AwakerFaceManager
