---@class Fsm
local Fsm = Class('Fsm')

function Fsm:__init()
    self._states = {}
    self._curState = nil
    self._preState = nil
end


function Fsm:__delete()
    for k, v in pairs(self._states) do
        v:Delete()
    end
end

function Fsm:AddState(state)
    if state == nil then
        return false
    end

    if self._states[state.type] ~= nil then
        return false
    end

    self._states[state.type] = state

    return true
end

function Fsm:SetStartState(type)
    if self._states[type] == nil then
        return false
    end

    local state = self._states[type]    
    state:OnEnter()

    self._curState = state
    self._preState = nil
    return true
end

function Fsm:ChangeState(type)
    local newState = self._states[type]
    if newState == nil then
        return false
    end

    if not newState.isForceReset and newState.type == self._curState.type then
        return false
    end

    if not newState:CheckEnterCondition() then
        return false
    end
    
    self._curState:OnLeave()
    newState:OnEnter()
    self._preState = self._curState
    self._curState = newState

    return true
end


return Fsm
