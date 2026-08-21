_class("AircraftStairs", Object)
AircraftStairs = AircraftStairs

function AircraftStairs:Constructor(main)
  self._main = main
  local parent = UnityEngine.GameObject.Find("Stairs").transform
  self._enters = {
    parent:GetChild(0):Find("enter").position,
    parent:GetChild(1):Find("enter").position
  }
  self._exits = {
    parent:GetChild(0):Find("exit").position,
    parent:GetChild(1):Find("exit").position
  }
  local root = UnityEngine.GameObject.Find("LogicRoot").transform
  local door1 = AircraftDoorOpener:New(root:Find("door_up/door_up_left"), root:Find("door_up/door_up_right"))
  door1:Init()
  local door2 = AircraftDoorOpener:New(root:Find("door_down/door_down_left"), root:Find("door_down/door_down_right"))
  door2:Init()
  self._doors = {door1, door2}
  self._moverList = ArrayList:New()
end

function AircraftStairs:Init()
end

function AircraftStairs:Update(deltaTimeMS)
  if self._moverList:Size() > 0 then
    self._moverList:ForEach(function(m)
      local mover = m
      mover:Update(deltaTimeMS)
    end)
    local first = self._moverList:Front()
    if first:IsFinish() then
      self._moverList:RemoveAt(1)
    end
  end
  for _, door in ipairs(self._doors) do
    door:Update(deltaTimeMS)
  end
end

function AircraftStairs:Dispose()
end

function AircraftStairs:GetMoveTarget(floor)
  local pos = self._enters[floor]
  if pos == nil then
    Log.exception("严重错误，找不到楼梯点，", "楼层:", floor, "，总数:", table.count(self._enters), "，", debug.traceback())
  end
  return pos
end

function AircraftStairs:GetStairExit(floor)
  return self._exits[floor]
end

function AircraftStairs:OnPetArrive(pet)
  local mover = AircraftStairMover:New(pet, self._exits[pet:GetTargetFloor()], self._doors)
  self._moverList:PushBack(mover)
end

function AircraftStairs:TryRemovePet(pet)
  if not pet then
    return
  end
  local target
  for i = 1, self._moverList:Size() do
    local mover = self._moverList:GetAt(i)
    if mover:Pet():TemplateID() == pet:TemplateID() then
      target = i
      break
    end
  end
  if target then
    AirLog("楼梯中的星灵被销毁：", pet:TemplateID())
    self._moverList:RemoveAt(target)
  end
end

_class("AircraftStairMover", Object)
AircraftStairMover = AircraftStairMover

function AircraftStairMover:Constructor(pet, exitPos, doors)
  self._pet = pet
  self._exitPos = exitPos
  self._doors = doors
  self._enterMover = AircraftPetMover:New(pet, pet:Transform().position + Vector3(0, 0, 2), 0.9)
  self._exitMover = AircraftPetMover:New(pet, self._exitPos, 0.9)
  self._enterMover:Begin()
  pet:SetState(AirPetState.Upstairs)
  self._doors[pet:GetFloor()]:Open()
  self._state = AirPetStairState.Enter
  self._timer = 0
end

function AircraftStairMover:Update(deltaTimeMS)
  if self._state == AirPetStairState.Enter then
    self._enterMover:Update(deltaTimeMS)
    if self._enterMover:IsArrive() then
      self._pet:GameObject():SetActive(false)
      self._timer = 700
      self._state = AirPetStairState.Hide
    end
  elseif self._state == AirPetStairState.Hide then
    self._timer = self._timer - deltaTimeMS
    if self._timer < 0 then
      self._pet:SetEuler(Vector3(0, 180, 0))
      self._pet:SetPosition(self._exitPos + Vector3(0, 0, 2))
      self._pet:GameObject():SetActive(true)
      self._timer = 200
      self._doors[self._pet:GetTargetFloor()]:Open()
      self._state = AirPetStairState.Wait
    end
  elseif self._state == AirPetStairState.Wait then
    self._timer = self._timer - deltaTimeMS
    if self._timer < 0 then
      self._exitMover:Begin()
      self._state = AirPetStairState.Exit
    end
  elseif self._state == AirPetStairState.Exit then
    self._exitMover:Update(deltaTimeMS)
    if self._exitMover:IsArrive() then
      local pet = self._pet
      local action = pet:GetMoveToDoAction()
      action:ArriveFloor()
      self._state = AirPetStairState.Finish
    end
  elseif self._state == AirPetStairState.Finish then
  end
end

function AircraftStairMover:IsFinish()
  return self._state == AirPetStairState.Finish
end

function AircraftStairMover:Pet()
  return self._pet
end
