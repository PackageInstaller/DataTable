local InputKeyBordManager, Super = System.NewClass("InputKeyBordManager", Manager, IUpdater)

function InputKeyBordManager:ctor()
  Super.ctor(self)
end

function InputKeyBordManager:Awake(binder)
  Super.Awake(self)
  self.openKey = false
  self.bandMove = {}
  binder:BindEvent(EventMgr.Instance.MoveBanned, System.fn(self, self.MoveBanned))
end

function InputKeyBordManager:MoveBanned(type, ret)
  if self.bandMove then
    self.bandMove[type] = ret
  end
end

function InputKeyBordManager:IsBanned()
  local ret = false
  if not self.bandMove then
    return ret
  end
  for _, value in pairs(self.bandMove) do
    if value then
      ret = true
    end
  end
  return ret
end

function InputKeyBordManager:Update()
  if DataCenter.mapData.InputKeyOpen and not self:IsBanned() then
    self:CheckMouseMove()
  elseif self.openKey then
    EventMgr.Instance.MoveEnd:Dispatch()
    self.openKey = false
  end
end

function InputKeyBordManager:CheckMouseMove()
  local additionX = CS.UnityEngine.Input.GetAxis("Horizontal")
  local additionY = CS.UnityEngine.Input.GetAxis("Vertical")
  if math.abs(additionX) > 0 or math.abs(additionY) > 0 then
    EventMgr.Instance.Move:Dispatch(additionX, additionY)
    self.openKey = true
  elseif self.openKey then
    EventMgr.Instance.MoveEnd:Dispatch()
    self.openKey = false
  end
end

function InputKeyBordManager:OnDestroy()
  Super.OnDestroy(self)
end

return InputKeyBordManager
