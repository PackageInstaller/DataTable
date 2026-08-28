---
--- 社团大厅，猫状态机状态基类
--- Author: dawanfan
--- Date: 2024-5-6 16:03:41
---


---@class OverseaClubBaseState
local BaseState = Class("OverseaClubBaseState")

function BaseState:__init()
    self.duration = 0
end

---@param fsm OverseaClubFSM
function BaseState:OnEnterState(fsm)

end

---@param fsm OverseaClubFSM
function BaseState:OnUpdate(fsm)

end

---@param fsm OverseaClubFSM
function BaseState:OnExitState(fsm)
    fsm.controller:_SwitchTo_Auto_TmpIdle()
end

function BaseState:StateType()
    return 0
end

---@param fsm OverseaClubFSM
---@return boolean
function BaseState:CanEnter(fsm, stateType)
    return fsm.currentState:StateType() ~= stateType
end

return BaseState
