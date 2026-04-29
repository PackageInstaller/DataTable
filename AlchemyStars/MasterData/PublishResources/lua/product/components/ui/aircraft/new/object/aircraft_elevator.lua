_class("AircraftElevator", Object)
AircraftElevator = AircraftElevator

function AircraftElevator:Constructor(main)
  self._main = main
  self._lines = {
    AircraftElevatorLine:New(1, self._main),
    AircraftElevatorLine:New(2, self._main),
    AircraftElevatorLine:New(3, self._main),
    AircraftElevatorLine:New(4, self._main)
  }
  self._state = ElevatorState.Idle
  self._floor = 1
  self._elevatorT = UnityEngine.GameObject.Find("Elevator").transform:Find("E")
  self._curPet = nil
  self._petMover = nil
  self._elevatorMover = nil
end

function AircraftElevator:Init()
end

function AircraftElevator:Update(deltaTimeMS)
  if self._state == ElevatorState.Idle then
    local target = 0
    local time = self._main:Time()
    for floor, line in ipairs(self._lines) do
      if line:HasWaitingPet() then
        local firstTime = line:FirstPetWaitTime()
        if time > firstTime then
          time = firstTime
          target = floor
        end
      end
    end
    if 0 < target then
      self._state = ElevatorState.Moving
      self._floor = target
      self._elevatorMover = nil
    end
  elseif self._state == ElevatorState.Moving then
    if self._elevatorMover == nil then
      if self._floor == nil then
        self._state = ElevatorState.Idle
        return
      end
      local line = self._lines[self._floor]
      local pos = line:Pos()
      self._elevatorMover = AircraftMover:New(self._elevatorT, pos, AircraftSpeed.Elevator)
      self._elevatorMover:Begin()
    end
    self._elevatorMover:Update(deltaTimeMS)
    if self._elevatorMover:IsArrive() then
      self._elevatorMover = nil
      if self._floor == nil then
        self._state = ElevatorState.Idle
      else
        self._state = ElevatorState.WaitEnter
      end
    end
  elseif self._state == ElevatorState.WaitEnter then
    if self._petMover == nil then
      if not (self._floor and self._lines[self._floor]) or not self._lines[self._floor]:HasWaitingPet() then
        self._state = ElevatorState.Idle
        return
      end
      self._curPet = self._lines[self._floor]:PopPet()
      local line = self._lines[self._floor]
      local pos = line:Pos()
      self._petMover = AircraftPetMover:New(self._curPet, pos, AircraftSpeed.Pet)
      self._petMover:Begin()
    end
    if not self._curPet then
      self._state = ElevatorState.Idle
      return
    end
    self._petMover:Update(deltaTimeMS)
    if self._petMover:IsArrive() then
      self._petMover = nil
      self._state = ElevatorState.Delivering
      self._floor = self._curPet:GetTargetFloor()
      self._curPet:Anim_Stand()
      self._curPet:SetState(AirPetState.InElevator)
      self._curPet:SetEuler(Vector3(0, 180, 0))
    end
  elseif self._state == ElevatorState.Delivering then
    if self._elevatorMover == nil then
      if not (self._curPet and self._floor) or not self._lines[self._floor] then
        self._state = ElevatorState.Idle
        return
      end
      local line = self._lines[self._floor]
      local pos = line:Pos()
      self._elevatorMover = AircraftMover:New(self._elevatorT, pos, AircraftSpeed.Elevator)
      self._elevatorMover:Begin()
    end
    self._elevatorMover:Update(deltaTimeMS)
    if self._curPet then
      self._curPet:SetPosition(self._elevatorT.position)
    end
    if self._elevatorMover:IsArrive() then
      self._elevatorMover = nil
      self._state = ElevatorState.WaitExit
    end
  elseif self._state == ElevatorState.WaitExit then
    if not self._curPet then
      self._state = ElevatorState.Idle
      return
    end
    if self._petMover == nil then
      local line = self._lines[self._floor]
      local pos = line:Exit()
      self._petMover = AircraftPetMover:New(self._curPet, pos, AircraftSpeed.Pet)
      self._petMover:Begin()
    end
    self._petMover:Update(deltaTimeMS)
    if self._petMover:IsArrive() then
      self._state = ElevatorState.Idle
      local action = self._curPet:GetMoveToDoAction()
      action:ArriveFloor()
      self._petMover = nil
      self._curPet = nil
    end
  end
  for _, line in ipairs(self._lines) do
    line:Update(deltaTimeMS)
  end
end

function AircraftElevator:Dispose()
end

function AircraftElevator:GetLineTarget(floor)
  if not self._lines[floor] then
    Log.exception("[AircraftElevator] 找不到电梯楼层：", floor)
  end
  return self._lines[floor]:Target()
end

function AircraftElevator:GetLineExit(floor)
  if not self._lines[floor] then
    Log.exception("[AircraftElevator] 找不到电梯楼层：", floor)
  end
  return self._lines[floor]:Exit()
end

function AircraftElevator:ArriveLineTarget(pet, floor)
  AirLog("星灵到达楼梯点:", pet:TemplateID())
  self._lines[floor]:OnPetArriveTarget(pet)
end

function AircraftElevator:IsFull(floor)
  return self._lines[floor]:IsFull()
end

function AircraftElevator:TryRemovePet(pet)
  if not pet then
    return
  end
  if self._state == ElevatorState.Idle then
  elseif self._curPet and self._curPet:PstID() == pet:PstID() and self._state == ElevatorState.WaitEnter then
    AirLog("正在进入电梯的星灵被销毁：", pet:TemplateID())
    self._curPet = nil
    self._petMover = nil
    self._state = ElevatorState.Idle
  elseif self._curPet and self._curPet:PstID() == pet:PstID() and self._state == ElevatorState.WaitExit then
    AirLog("正在离开电梯的星灵被销毁：", pet:TemplateID())
    self._curPet = nil
    self._petMover = nil
    self._state = ElevatorState.Idle
  elseif self._state == ElevatorState.Moving then
    self._floor = nil
    AirLog("电梯正在移动向星灵，但是星灵被销毁", pet:TemplateID())
  elseif self._curPet and self._curPet:PstID() == pet:PstID() and self._state == ElevatorState.Delivering then
    AirLog("正在运送中的星灵被销毁：", pet:TemplateID())
    self._curPet = nil
  end
  if self._state == ElevatorState.Idle then
  end
  for _, line in ipairs(self._lines) do
    line:OnPetRemove(pet)
  end
end
