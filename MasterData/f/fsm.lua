require "class"
require "DLuaUtil"

---@class FSMState
FSMState = class("FSMState")
  
function FSMState:ctor(n, id)
    ---@type string
    self.name = n
    ---@type number
    self.stateId = id
end

function FSMState:enter()  
    print(string.format("%s enter", self.name))  
end

function FSMState:update()  
    print(string.format("%s enter", self.name))  
end

function FSMState:exit()  
    print(string.format("%s exit", self.name))  
end

---@class FSM
FSM = class("FSM")

function FSM:ctor(tb)
    self.currentState = nil
    self.stateDic = {}
end

function FSM:getCurrentState()
    return self.currentState
end

function FSM:getCurrentStateId()
    if self.currentState then
        return self.currentState.stateId
    end
end

function FSM:getLastStateId()
    if self.lastState then
        return self.lastState.stateId
    end
end

function FSM:addState(state)
    self.stateDic[state.stateId] = state
end  
  
function FSM:changeState(stateId)
    local newState = self.stateDic[stateId]
    DLuaUtil.assert(newState)
    
    if self.currentState then
        self.currentState:exit()
    end

    self.lastState = self.currentState

    self.currentState = newState  
    self.currentState:enter() 
end

function FSM:update()
    if self.currentState then
        self.currentState:update()
    end
end