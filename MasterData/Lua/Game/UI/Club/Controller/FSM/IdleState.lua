---
--- 猫，空闲状态
--- Author: dawanfan
--- Date: 2024-5-6 16:31:24
---

local Time = CS.UnityEngine.Time

local BaseState = import("Game.UI.Club.Controller.FSM.BaseState")
local OverseaClubStateConstants = import("Game.UI.Club.Controller.FSM.OverseaClubStateConstants")

---@class OverseaClubIdleState: OverseaClubBaseState
local IdleState = Class("OverseaclubIdleState", BaseState)

function IdleState:OnEnterState(fsm)
    if fsm.controller:IsAutoMode() then
        self.duration = CS.UnityEngine.Random.Range(1.0, 4.0)
    else
        self.duration = 5
    end
    fsm.controller:_SwitchTo_Auto_TmpIdle()
end

function IdleState:OnUpdate(fsm)
    if fsm.controller.inMove then
        fsm:ChangeState(OverseaClubStateConstants.Walk)
    end

    if fsm.controller:IsAutoMode() then 
        if fsm.currentStateElapsedTime >= self.duration then 
            fsm:AutoMode_Switch()
        end 
    else 
        if fsm.currentStateElapsedTime >= self.duration then 
            fsm:ChangeState(OverseaClubStateConstants.Sit)
        end 
    end 
end

function IdleState:StateType()
    return OverseaClubStateConstants.Idle
end

return IdleState
