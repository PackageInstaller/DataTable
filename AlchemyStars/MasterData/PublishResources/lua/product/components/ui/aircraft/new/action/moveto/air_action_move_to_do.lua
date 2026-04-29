_class("AirActionMoveToDo", Object)
AirActionMoveToDo = AirActionMoveToDo

function AirActionMoveToDo:Constructor(pet, targetFloor, actionPos, moveType, main)
  self._pet = pet
  if targetFloor == nil then
    Log.exception("目标楼层为空：", debug.traceback())
  end
  self._targetFloor = targetFloor
  self._actionPos = actionPos
  self._moveType = moveType
  self._main = main
  self._moveAction = nil
  self._state = AircraftPetMoveToDoState.Stop
end

function AirActionMoveToDo:Start()
  local curF = self._pet:GetFloor()
  local tarF = self._targetFloor
  if curF == tarF then
    self._state = AircraftPetMoveToDoState.MoveToActionTarget
    self._moveAction = AirActionMove:New(self._pet, self._actionPos, curF, self._main, "走向行为点")
    self._moveAction:Start()
    self._running = true
  elseif curF == 1 and tarF == 2 or curF == 2 and tarF == 1 then
    self._state = AircraftPetMoveToDoState.MoveToStair
    local spos = self._main:GetStairTarget(curF)
    self._moveAction = AirActionMove:New(self._pet, spos, curF, self._main, "走向楼梯")
    self._moveAction:Start()
    self._running = true
    self._pet:SetMoveTarget(spos)
  else
    self._state = AircraftPetMoveToDoState.MoveToElevator
    local epos = self._main:Elevator():GetLineTarget(curF)
    self._moveAction = AirActionMove:New(self._pet, epos, curF, self._main, "走向电梯")
    self._moveAction:Start()
    self._running = true
    self._pet:SetMoveTarget(epos)
  end
end

function AirActionMoveToDo:IsOver()
  return not self._running
end

function AirActionMoveToDo:Update(deltaTimeMS)
  if self._running then
    if self._state == AircraftPetMoveToDoState.Wait then
      return
    elseif self._state == AircraftPetMoveToDoState.MoveToStair then
      self._moveAction:Update(deltaTimeMS)
      if self._moveAction:IsOver() then
        self._pet:SetTargetFloor(self._targetFloor)
        self._main:OnPetArriveStair(self._pet)
        self._pet:SetMoveTarget(nil)
        self._pet:SetMoveToAction(self)
        self._moveAction = nil
        self._state = AircraftPetMoveToDoState.Wait
      end
    elseif self._state == AircraftPetMoveToDoState.MoveToElevator then
      self._moveAction:Update(deltaTimeMS)
      if self._moveAction:IsOver() then
        self._pet:SetMoveTarget(nil)
        self:OnArriveElevator()
      end
    elseif self._state == AircraftPetMoveToDoState.MoveToActionTarget then
      self._moveAction:Update(deltaTimeMS)
      if self._moveAction:IsOver() then
        self._running = false
        self:Stop()
      end
    end
  end
end

function AirActionMoveToDo:OnArriveElevator()
  local full = self._main:Elevator():IsFull(self._pet:GetFloor())
  if full then
    if self._pet:IsWorkingPet() then
      AirLog("电梯排队人数已满，工作星灵直接回到工作房间，当前楼层:", self._pet:GetFloor())
      self._main:PetStartWork(self._pet:TemplateID(), self._pet:GetSpace())
    elseif self._pet:IsLeavingPet() then
      AirLog("电梯排队人数已满，离开星灵直接销毁，当前楼层:", self._pet:GetFloor())
      self._main:RemoveRestPet(self._pet:TemplateID())
    else
      AirLog("电梯排队人数已满，星灵重新随机行为，当前楼层:", self._pet:GetFloor())
      self._main:RandomActionForPet(self._pet)
    end
    return
  end
  self._pet:SetTargetFloor(self._targetFloor)
  self._main:Elevator():ArriveLineTarget(self._pet, self._pet:GetFloor())
  self._pet:SetMoveToAction(self)
  self._moveAction = nil
  self._state = AircraftPetMoveToDoState.Wait
end

function AirActionMoveToDo:ArriveFloor()
  if self._state ~= AircraftPetMoveToDoState.Wait then
    Log.exception("跨楼层后星灵的状态错误：", self._state)
  end
  self._pet:SetFloor(self._targetFloor)
  self._pet:SetTargetFloor(nil)
  self._pet:SetState(AirPetState.Transiting)
  self._state = AircraftPetMoveToDoState.MoveToActionTarget
  self._moveAction = AirActionMove:New(self._pet, self._actionPos, self._targetFloor, self._main, "跨层后走向行为点")
  self._moveAction:Start()
end

function AirActionMoveToDo:Duration()
  return nil
end

function AirActionMoveToDo:CurrentTime()
  return nil
end

function AirActionMoveToDo:Stop()
  if self._running then
    self._running = false
    if self._moveAction and not self._moveAction:IsOver() then
      self._moveAction:Stop()
    end
  end
  self._pet:SetMoveTarget(nil)
end

function AirActionMoveToDo:Dispose()
  self:Stop()
end

function AirActionMoveToDo:Pets()
  return {
    self._pet
  }
end
