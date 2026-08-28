---
--- 猫，移动状态
--- Author: dawanfan
--- Date: 2024-5-6 17:00:54
---

local Time = CS.UnityEngine.Time

local BaseState = import("Game.UI.Club.Controller.FSM.BaseState")
local OverseaClubStateConstants = import("Game.UI.Club.Controller.FSM.OverseaClubStateConstants")
---@type UIOverseaClubHallCatControllerConstants
local ControllerConstants = import("Game.UI.Club.UIOverseaClubHallCatControllerConstants")



---@class OverseaClubWalkState: OverseaClubBaseState
local WalkState = Class("OverseaClubWalkState", BaseState)

function WalkState:OnEnterState(fsm)
    self.animatorInfo = fsm.controller.animator:GetCurrentAnimatorStateInfo(0)
    fsm.controller.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_walk_club )

    -- if fsm.controller:IsAutoMode() then 
    -- end 
end


function WalkState:OnUpdate(fsm)
    if fsm.controller:IsServerMode() then
        fsm.controller:_OnMove(self.animatorInfo)
    elseif fsm.controller:IsAutoMode() then
        -- if fsm.controller.isMainCat == false then 
        --     printError("walk OnUpdate - not serveMode")
        -- end
        fsm.controller:_OnMove(self.animatorInfo)
    else  
        -- ...
    end
end


function WalkState:StateType()
    return OverseaClubStateConstants.Walk
end

return WalkState
