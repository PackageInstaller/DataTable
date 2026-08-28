---
--- 猫，坐状态
--- Author: dawanfan
--- Date: 2024-5-6 17:00:54
---

local Time = CS.UnityEngine.Time

local BaseState = import("Game.UI.Club.Controller.FSM.BaseState")
local OverseaClubStateConstants = import("Game.UI.Club.Controller.FSM.OverseaClubStateConstants")
---@type UIOverseaClubHallCatControllerConstants
local ControllerConstants = import("Game.UI.Club.UIOverseaClubHallCatControllerConstants")



---@class OverseaClubSitState: OverseaClubBaseState
local SitState = Class("OverseaClubSitState", BaseState)

function SitState:OnEnterState(fsm)
    self.enterTime = Time.time
    fsm.controller.animator:SetInteger( ControllerConstants.param_club, ControllerConstants.int_sit_club )

    if fsm.controller:IsAutoMode() then 
        self.duration = CS.UnityEngine.Random.Range(1.0, 3.0)
    end
end

function SitState:OnUpdate(fsm)
    -- if fsm.controller.isMainCat == false then 
    --     printError("sit OnUpdate")
    -- end
    if fsm.controller:IsAutoMode() then 
        if fsm.currentStateElapsedTime >= self.duration then 
            fsm:AutoMode_Switch()
        end 
    else 
        --...
    end     
end


function SitState:StateType()
    return OverseaClubStateConstants.Sit
end

return SitState
