_class("AircraftElevatorLine", Object)
AircraftElevatorLine = AircraftElevatorLine

function AircraftElevatorLine:Constructor(floor, main)
  self._main = main
  self._floor = floor
  self:Init()
end

function AircraftElevatorLine:Init()
  local parent = UnityEngine.GameObject.Find("Elevator").transform:Find("Floors")
  local t = parent:GetChild(self._floor - 1)
  self._pos = self:_getPoint(t:Find("pos"))
  self._exit = self:_getPoint(t:Find("exit"))
  self._target = self:_getPoint(t:Find("target"))
  local line = t:Find("line")
  local linePos = {}
  for i = 1, line.childCount do
    local point = line:GetChild(i - 1)
    linePos[i] = self:_getPoint(point)
  end
  self._linePos = linePos
  self._lineCount = #linePos
  self._movers = {}
end

function AircraftElevatorLine:_getPoint(t)
  return t.position:Clone()
end

function AircraftElevatorLine:Update(deltaTimeMS)
  if #self._movers > 0 then
    for idx, mover in ipairs(self._movers) do
      mover:Update(deltaTimeMS)
    end
  end
end

function AircraftElevatorLine:Dispose()
  self._movers = nil
end

function AircraftElevatorLine:IsFull()
  return #self._movers >= self._lineCount
end

function AircraftElevatorLine:OnPetArriveTarget(pet)
  if self:IsFull() then
    Log.exception("[AircraftElevator] 严重错误，排队点用尽，楼层：", self._floor, "，个数：", self._lineCount)
  end
  pet:SetState(AirPetState.WaitingElevator)
  local idx = #self._movers + 1
  local pos = self._linePos[idx]
  local mover = AircraftPetWaitElevator:New(self._main, pet, idx, pos)
  self._movers[idx] = mover
end

function AircraftElevatorLine:Pos()
  return self._pos
end

function AircraftElevatorLine:Target()
  return self._target
end

function AircraftElevatorLine:Exit()
  return self._exit
end

function AircraftElevatorLine:HasWaitingPet()
  if #self._movers > 0 then
    return self._movers[1]:IsWaiting()
  end
  return false
end

function AircraftElevatorLine:FirstPetWaitTime()
  local pet = self._movers[1]:Pet()
  return pet:GetWaitElevatorTime()
end

function AircraftElevatorLine:PopPet()
  local first = self._movers[1]
  table.remove(self._movers, 1)
  if #self._movers > 0 then
    for idx, mover in ipairs(self._movers) do
      local idx = mover:Index() - 1
      local pos = self._linePos[idx]
      mover:ResetIndex(idx, pos)
    end
  end
  return first:Pet()
end

function AircraftElevatorLine:OnPetRemove(pet)
  if #self._movers == 0 then
    return
  end
  local target
  for idx, mover in ipairs(self._movers) do
    if mover:CheckPet(pet) then
      target = idx
      break
    end
  end
  if target then
    AirLog("删除1个等电梯的星灵:", pet:TemplateID(), "，索引:", target, "，楼层:", self._floor)
    table.remove(self._movers, target)
    if #self._movers > 0 then
      for i = target, #self._movers do
        local pos = self._linePos[i]
        self._movers[i]:ResetIndex(i, pos)
      end
    end
  end
end
