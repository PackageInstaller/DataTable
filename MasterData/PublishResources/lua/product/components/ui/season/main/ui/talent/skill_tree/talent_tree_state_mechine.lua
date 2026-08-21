local TalentTree_FSM_State_Type = {
  None = 0,
  Select_Skill = 1,
  Empty = 2,
  Select_Slot = 3,
  Drag_In_Begin = 4,
  Drag_In_End = 5,
  Drag_Out_Begin = 6,
  Drag_Out_End = 7
}
_enum("TalentTree_FSM_State_Type", TalentTree_FSM_State_Type)
local TalentTree_FSM_Event_Type = {
  None = 0,
  Drag_In_Begin = 1,
  Drag_In_Drag = 2,
  Drag_In_End = 3,
  Drag_Out_Begin = 4,
  Drag_Out_Drag = 5,
  Drag_Out_End = 6
}
_enum("TalentTree_FSM_Event_Type", TalentTree_FSM_Event_Type)
_class("TalentTree_FSM_Machine", Object)
TalentTree_FSM_Machine = TalentTree_FSM_Machine

function TalentTree_FSM_Machine:Constructor()
  self._currentState = TalentTree_FSM_State_Type.None
  self._stateMap = {}
end

function TalentTree_FSM_Machine:CurrentState()
  return self._currentState
end

function TalentTree_FSM_Machine:AddState(state, stateObj)
  self._stateMap[state] = stateObj
end

function TalentTree_FSM_Machine:ChangeState(state, params)
  if self._currentState ~= TalentTree_FSM_State_Type.None then
    self._stateMap[self._currentState]:Exit()
    Log.fatal("###[UISeasonTalentTreeController] state [" .. self._currentState .. "] exit !")
  end
  self._currentState = state
  if self._currentState ~= TalentTree_FSM_State_Type.None then
    self._stateMap[self._currentState]:Enter(params)
    Log.fatal("###[UISeasonTalentTreeController] state [" .. self._currentState .. "] enter !")
  end
end

function TalentTree_FSM_Machine:Update(params)
  if self._currentState ~= TalentTree_FSM_State_Type.None then
    self._stateMap[self._currentState]:Update(params)
  end
end

function TalentTree_FSM_Machine:Dispose()
  self._currentState = TalentTree_FSM_State_Type.None
  self._stateMap = {}
end

_class("TalentTree_FSM_State", Object)
TalentTree_FSM_State = TalentTree_FSM_State

function TalentTree_FSM_State:Constructor(stateType, enterFn, exitFn, updateFn)
  self.stateType = stateType
  self.enterFn = enterFn
  self.exitFn = exitFn
  self.updateFn = updateFn
  self.context = nil
end

function TalentTree_FSM_State:Enter(params)
  self.context = params
  if self.enterFn then
    self.enterFn(params)
  end
end

function TalentTree_FSM_State:Exit()
  if self.exitFn then
    self.exitFn(self.context)
  end
end

function TalentTree_FSM_State:Update(params)
  if self.updateFn then
    self.updateFn(params, self.context)
  end
end

function TalentTree_FSM_State:Dispose()
  self.enterFn = nil
  self.exitFn = nil
  self.updateFn = nil
end
