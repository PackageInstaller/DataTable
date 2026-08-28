---
--- 猫，交互状态
--- Author: dawanfan
--- Date: 2024-5-6 17:00:54
---

local Time = CS.UnityEngine.Time
local Random = CS.UnityEngine.Random

local BaseState = import("Game.UI.Club.Controller.FSM.BaseState")
local OverseaClubStateConstants = import("Game.UI.Club.Controller.FSM.OverseaClubStateConstants")
---@type UIOverseaClubHallCatControllerConstants
local ControllerConstants = import("Game.UI.Club.UIOverseaClubHallCatControllerConstants")



---@class OverseaClubInteractState: OverseaClubBaseState
local InteractState = Class("OverseaClubInteractState", BaseState)

function InteractState:OnEnterState(fsm)
    self.enterTime = Time.time
    
    ---
    if fsm.controller:IsAutoMode() then 

        self.index = -1
        local randomVV = Random.Range(0.0, 3.0)
        if      randomVV < 1 then 
            self.duration = ControllerConstants.randomDuration_Touch_01.max
            fsm.controller.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_01_club )
        elseif randomVV < 2 then 
            self.duration = ControllerConstants.randomDuration_Touch_02.max
            fsm.controller.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_02_club )
        else 
            self.duration = ControllerConstants.randomDuration_Touch_03.max
            fsm.controller.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_03_clb )
        end

    else 
        self.index = fsm.controller.interactIndex    
        if fsm.controller.interactIndex == 1 then
            self.duration = ControllerConstants.randomDuration_Touch_01.max
            fsm.controller.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_01_club )
        elseif fsm.controller.interactIndex == 2 then
            self.duration = ControllerConstants.randomDuration_Touch_02.max
            fsm.controller.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_02_club )
        elseif fsm.controller.interactIndex == 3 then
            self.duration = ControllerConstants.randomDuration_Touch_03.max
            fsm.controller.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_touch_03_clb )
        else
            self.duration = 0
            self.index = -1
        end
    end 
end


function InteractState:OnUpdate(fsm)
    -- if fsm.controller.isMainCat == false then 
    --     printError("Interact OnUpdate; duration = "..tostring(self.duration))
    -- end

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


function InteractState:OnExitState(fsm)
    self.index = -1
end


function InteractState:StateType()
    return OverseaClubStateConstants.Interact
end


function InteractState:CanEnter(fsm, stateType)
    if self.index == -1 then
        return true
    end

    return fsm.controller.interactIndex ~= self.index
end

return InteractState
