---
--- 寻路
--- Author: dawanfan
--- Date: 2024-1-25 14:28:52
---

--- AutoWalk 需配合 Volume 使用，不适用于任意位置寻路移动，故而新增此脚本

--- lua:
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local InputManager = import('Game.DreamSpace.CharacterController.InputManager')
---@type DreamSpaceStates
local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')
local GlobalsInDreamSpace = CS.DreamSpace.GlobalsInDreamSpace
local Time = CS.UnityEngine.Time

--- from:  > name: PathFinder
---@class PathFinder
---@field Env                           	PathFinder                              
---@field controller                    	Engine.Modules.LuaBehaviour             
local PathFinder = Class("PathFinder")

function PathFinder:__init()
    self.isInit = false
end

function PathFinder:__delete()
    self.move_co = nil
end

function PathFinder:Start()

end

function PathFinder:OnDestroy()
    if self.move_co then
        cs_coroutine.stop(self.move_co)
    end
end

function PathFinder:MoveTo(position, minDistance, stopCallback)
    self.role = GlobalsInDreamSpace.FindComponent("vTargetFollow")
    if IsNull(self.role) then
        return
    end

    if IsNull(minDistance) then
        minDistance = 0.5
    end


    self.target = position
    if self.move_co then
        cs_coroutine.stop(self.move_co)
    end

    self.move_co = cs_coroutine.start(self.WalkingUpdate, self, minDistance, stopCallback)
end

function PathFinder:WalkAround(position, minSec)
    self.role = GlobalsInDreamSpace.FindComponent("vTargetFollow")
    if IsNull(self.role) then
        return
    end

    if IsNull(minSec) then
        minSec = 1
    end

    self.target = position
    if self.move_co then
        cs_coroutine.stop(self.move_co)
    end

    self.move_co = cs_coroutine.start(self.WalkingAroundUpdate, self, minSec, 0.5)
end


function PathFinder:WalkingUpdate(minDistance, stopCallback)

    InputManager.SetInputMode(DreamSpaceStates.InputMode.FromCode)

    local framePos = self:GetRolePos()

    local moveVec = self.target - framePos
    moveVec.y = 0
    InputManager.SetMoveInputFromCode(moveVec.normalized)
    coroutine.yield(Yielders.EndOfFrame)

    local moveVecOneFrame = self:GetRolePos() - framePos
    local moveDistanceOneFrame = moveVecOneFrame.magnitude * 1.3
    local disVec = self.target - self:GetRolePos()
    disVec.y = 0
    local distance = disVec.magnitude

    while (distance > moveDistanceOneFrame and distance > minDistance) do
        framePos = self:GetRolePos()
        moveVec = self.target - framePos
        moveVec.y = 0
        if moveVec.magnitude > minDistance then
            moveVec = moveVec.normalized
        end
        InputManager.SetMoveInputFromCode( moveVec )

        coroutine.yield(Yielders.EndOfFrame)

        disVec = self.target - self:GetRolePos()
        disVec.y = 0
        distance = disVec.magnitude
        moveVecOneFrame = self:GetRolePos() - framePos
        moveDistanceOneFrame = math.max(moveVecOneFrame.magnitude * 1.3, moveDistanceOneFrame)
        -- print(string.format("[PathFinder] distance: %s, moveDistanceOneFrame: %s", distance, moveDistanceOneFrame))
    end

    InputManager.SetInputMode( DreamSpaceStates.InputMode.FromDevice )

    if stopCallback then
        stopCallback()
    end
end

function PathFinder:WalkingAroundUpdate(minSec, minDistance)
    InputManager.SetInputMode(DreamSpaceStates.InputMode.FromCode)

    local framePos = self:GetRolePos()
    local sec = 0

    local moveVec = self.target - framePos
    while sec < minSec do
        framePos = self:GetRolePos()
        moveVec = self.target - framePos
        moveVec.y = 0
        InputManager.SetMoveInputFromCode( moveVec.normalized )

        coroutine.yield(Yielders.EndOfFrame)

        sec = sec + Time.deltaTime
    end

    InputManager.SetInputMode( DreamSpaceStates.InputMode.FromDevice )
end

function PathFinder:StopWalking()
    if self.move_co then
        cs_coroutine.stop(self.move_co)
        InputManager.SetInputMode( DreamSpaceStates.InputMode.FromDevice )
    end
end

function PathFinder:GetRolePos()
    if self.role == nil then
        self.role = GlobalsInDreamSpace.FindComponent("vTargetFollow")
    end
    return self.role.position + self.role.forward * 0.3
end


return PathFinder