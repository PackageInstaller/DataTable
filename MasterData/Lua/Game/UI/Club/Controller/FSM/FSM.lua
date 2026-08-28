---
--- 社团大厅，猫状态机
--- Author: dawanfan
--- Date: 2024-5-6 15:59:10
---

local OverseaClubStateConstants = import("Game.UI.Club.Controller.FSM.OverseaClubStateConstants")
local Time = CS.UnityEngine.Time
local Random = CS.UnityEngine.Random


local stateDict = {
    [OverseaClubStateConstants.Idle] = import("Game.UI.Club.Controller.FSM.IdleState"),
    [OverseaClubStateConstants.Interact] = import("Game.UI.Club.Controller.FSM.InteractState"),
    [OverseaClubStateConstants.Sit] = import("Game.UI.Club.Controller.FSM.SitState"),
    [OverseaClubStateConstants.Sleep] = import("Game.UI.Club.Controller.FSM.SleepState"),
    [OverseaClubStateConstants.Walk] = import("Game.UI.Club.Controller.FSM.WalkState")
}



---@class OverseaClubFSM
---@field controller UIOverseaClubHallCatController
---@field states table<number, OverseaClubBaseState>
local FSM = Class("OverseaClubFSM")

function FSM:__init()
    self.lastState = nil
    self.currentState = nil
    self.states = {}
    self.controller = nil
    self.currentStateElapsedTime = 0
    self.changeTime = 0
end

function FSM:Init(controller, stateTypes, defaultState)
    self.controller = controller
    for _, stateType in pairs(stateTypes) do
        local stateCls = stateDict[stateType]
        if stateCls then
            self.states[stateType] = stateCls.New()
        end
    end

    self.currentState = self.states[defaultState]
    self.changeTime = Time.time

    if self.currentState == nil then
        printError("[OverseaclubFSM][Init] default state not exist")
        return
    else
        self.currentState:OnEnterState(self)
    end
end

function FSM:ChangeState(stateType)
    -- if self.controller.isMainCat == false then 
    --     printError("fsm ChangeState: " ..tostring(stateType))
    -- end 

    local state = self.states[stateType]
    if state == nil then
        printError("[OverseaClubFSM][ChangeState] state no exist, stateType %s", stateType)
        return
    end

    if not state:CanEnter(self, stateType) then
        return
    end

    self.lastState = self.currentState -- cached
    self.currentState = state
    ---
    self.lastState:OnExitState(self)
    self.currentState:OnEnterState(self)
    self.currentStateElapsedTime = 0
    self.changeTime = Time.time
end

function FSM:OnUpdate()
    self.currentState:OnUpdate(self)
    self.currentStateElapsedTime = self.currentStateElapsedTime + Time.deltaTime
end



function FSM:AutoMode_Switch()
    -- if self.controller.isMainCat == false then 
    --     printError("do AutoMode_Switch")
    -- end 

    local stateType = self.currentState.StateType()
    local random1 = Random.Range(0.0,1.0)
    if  random1 < 0.5 then         
        if stateType ~= OverseaClubStateConstants.Walk or Random.value < 0.3 then 
            self.controller:_SwitchTo_Auto_Walk()
            --self:AutoMode_SwitchWithoutMove() -- !! tmp
            self:ChangeState( OverseaClubStateConstants.Walk )
        end
    else 
        self:AutoMode_SwitchWithoutMove()
    end
end



function FSM:AutoMode_SwitchWithoutMove()
    
    local stateType = self.currentState.StateType()

    local randomVV = Random.Range(0.0, 3.0)
    if      randomVV < 1 then 
        if stateType ~= OverseaClubStateConstants.Sit then -- sit 动画有个缺陷, 就是它不存在 sit<->idle 的过度动画, 这导致进出它的过程有点生硬;
            --self:_SwitchTo_Auto_Sit()  -- 占: 1
            self:ChangeState( OverseaClubStateConstants.Sit )
        end
    elseif randomVV < 2 then
        if stateType ~= OverseaClubStateConstants.Sleep then
            --self:_SwitchTo_Auto_Sleep() -- 占: 1
            self:ChangeState( OverseaClubStateConstants.Sleep )
        end
    else
        if stateType ~= OverseaClubStateConstants.Interact then
            --self:_SwitchTo_Auto_Touch_01() -- 占: 1
            self:ChangeState( OverseaClubStateConstants.Interact )
        end
    end
end




return FSM
