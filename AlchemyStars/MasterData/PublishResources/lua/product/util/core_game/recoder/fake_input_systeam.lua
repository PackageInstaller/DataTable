_class("FakeInputSystem", Object)
FakeInputSystem = FakeInputSystem

function FakeInputSystem:Constructor(world)
  self._world = world
  self._inputComponent = world:Input()
  self._pickUpCmpt = world:PickUp()
  self._progress = 1
  local md = GameGlobal.GetModule(FakeMatchModule)
  self._fakeMatchModule = md
  self._record = md:GetRecord()
  self._startTime = md:GetMatchStartTime()
end

function FakeInputSystem:Execute()
  if not self._fakeMatchModule:IsRunning() then
    return
  end
  if self._progress > #self._record then
    return
  end
  local curTime = GameGlobal:GetInstance():GetCurrentTime()
  local deltaTime = curTime - self._startTime
  local t = self._record[self._progress]
  if deltaTime < t.time then
    return
  end
  self._progress = self._progress + 1
  if t.action == GameRecordAction.TouchInput then
    self:FakeTouchInput(t)
  elseif t.action == GameRecordAction.UIInput then
    self:FakeUIInput(t)
  elseif t.action == GameRecordAction.NetInput then
    self:FakeCmdInput(t)
  end
end

function FakeInputSystem:FakeTouchInput(t)
  if t.input == "DoubleClick" then
    self._inputComponent:SetDoubleClickPos(t.hitPoint)
    self:InputDirty()
  elseif t.input == "Dragging" then
    self._inputComponent:SetTouchMovePositionList({
      t.hitPoint
    })
    self:InputDirty()
  elseif t.input == "BeginDrag" then
    self._inputComponent:SetTouchBeginPosition(t.hitPoint)
    self:InputDirty()
  elseif t.input == "EndDrag" then
    self._inputComponent:SetTouchEndPosition()
    self:InputDirty()
  elseif t.input == "PickUp" then
    self._pickUpCmpt:SetClickPos(t.hitPoint)
    self:_PickUpDirty()
  end
end

function FakeInputSystem:FakeUIInput(t)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, t)
end

function FakeInputSystem:FakeCmdInput(t)
  local cmd = table_to_class(t.cmd)
  self._world:Player():SendCommand(cmd)
end

function FakeInputSystem:InputDirty()
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.Input)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.Input, component)
end

function FakeInputSystem:_PickUpDirty()
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.PickUp)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.PickUp, component)
end
