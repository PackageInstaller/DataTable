---
--- 猫，睡觉状态
--- Author: dawanfan
--- Date: 2024-5-6 17:00:54
---

local Time = CS.UnityEngine.Time

local BaseState = import("Game.UI.Club.Controller.FSM.BaseState")
local OverseaClubStateConstants = import("Game.UI.Club.Controller.FSM.OverseaClubStateConstants")
---@type UIOverseaClubHallCatControllerConstants
local ControllerConstants = import("Game.UI.Club.UIOverseaClubHallCatControllerConstants")



---@class OverseaClubSleepState: OverseaClubBaseState
local SleepState = Class("OverseaClubSleepState", BaseState)

function SleepState:OnEnterState(fsm)
    self.enterTime = Time.time
    fsm.controller:_SwitchTo_Auto_Sleep()

    
    if fsm.controller:IsAutoMode() then 
        self.duration = CS.UnityEngine.Random.Range(1.0, 4.0)
    else 
        if fsm.controller.interactIndex == 5 then
            self.duration = ControllerConstants.randomDuration_Sleep.max
        else
            self.duration = -1
        end
    end
end


function SleepState:OnUpdate(fsm)
    -- if fsm.controller.isMainCat == false then 
    --     printError("sleep OnUpdate; duration = "..tostring(self.duration))
    -- end

    if fsm.controller:IsAutoMode()  then
        if fsm.currentStateElapsedTime >= self.duration then 
            fsm:AutoMode_Switch()
        end 
    else 

        if self.duration == -1 then
            return
        end
    
        if fsm.currentStateElapsedTime >= self.duration then
            fsm:ChangeState(OverseaClubStateConstants.Sit)
        end

    end
end


function SleepState:OnExitState(fsm)
    if fsm.controller.interactIndex == 5 then
        fsm.controller.interactIndex = -1
    end
end

function SleepState:StateType()
    return OverseaClubStateConstants.Sleep
end

return SleepState
