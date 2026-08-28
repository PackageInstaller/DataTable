

---@class TimeLimitedDoor
---@field parm1                  Engine.Modules.LuaBehaviour
---@field parm2                  UnityEngine.Transform
local TimeLimitedDoor = Class('TimeLimitedDoor')

-- 外部访问时
-- ---@type TimeLimitedDoor
-- local TimeLimitedDoor = import("Game.Activity.TimeLimitedRecruit.TimeLimitedDoor")



-- ========================================================

--[[
        门管理器
]]

--- lua:
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程
local UIModule = CS.Engine.UI.UIModule

local GameUtils = import('Game.Utils.GameUtils')
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf
local Random = CS.UnityEngine.Random
local Canvas = CS.UnityEngine.Canvas
local Physics = CS.UnityEngine.Physics
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local ImageAlterable = CS.Engine.UI.ImageAlterable
local Transform = CS.UnityEngine.Transform
local RectTransform = CS.UnityEngine.RectTransform
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Time = CS.UnityEngine.Time
local CanvasGroup = CS.UnityEngine.CanvasGroup


---@type TimeLimitedRecruitUtil
local TimeLimitedRecruitUtil = import("Game.Activity.TimeLimitedRecruit.TimeLimitedRecruitUtil")


-- ========================================================


function TimeLimitedDoor:__init( leftDoorTF_, rightDoorTF_, leftDoorClosePos_, leftDoorOpenPos_, rightDoorClosePos_, rightDoorOpenPos_, moveSpeed_,OpenCB_,CloseCB_)

    self.entNum = 0 -- 最简版本, 只计数, 不关心是谁

    self.doorState = TimeLimitedRecruitUtil.DoorState.Close
    self.tgtDoorState = self.doorState
    self.OpenCB = OpenCB_  -- maybe nil
    self.CloseCB = CloseCB_ -- maybe nil

    self.leftDoor = 
    {
        tf = leftDoorTF_,
        closePos = leftDoorClosePos_,
        openPos = leftDoorOpenPos_,
        tgtPos = leftDoorClosePos_
    }

    self.rightDoor = 
    {
        tf = rightDoorTF_,
        closePos = rightDoorClosePos_,
        openPos = rightDoorOpenPos_,
        tgtPos = rightDoorClosePos_
    }

    self.moveSpeed = checkNumber(moveSpeed_)
end



function TimeLimitedDoor:__delete()
end


function TimeLimitedDoor:SelfUpdate( deltaTime_ )
    self.leftDoor.tf.anchoredPosition = Vector2.Lerp( self.leftDoor.tf.anchoredPosition, self.leftDoor.tgtPos, deltaTime_ * self.moveSpeed )
    self.rightDoor.tf.anchoredPosition = Vector2.Lerp( self.rightDoor.tf.anchoredPosition, self.rightDoor.tgtPos, deltaTime_ * self.moveSpeed )
end


function TimeLimitedDoor:AddEnt()
    self.entNum = self.entNum + 1
    ---
    if self.entNum == 1 then 
        self.leftDoor.tgtPos = self.leftDoor.openPos
        self.rightDoor.tgtPos = self.rightDoor.openPos
        if isNotNull(self.OpenCB) then 
            self.OpenCB()
        end 
    end 
end



function TimeLimitedDoor:RemoveEnt()
    self.entNum = self.entNum - 1
    assert(self.entNum >= 0)
    ---
    if self.entNum == 0 then 
        self.leftDoor.tgtPos = self.leftDoor.closePos
        self.rightDoor.tgtPos = self.rightDoor.closePos
        if isNotNull(self.CloseCB) then 
            self.CloseCB()
        end 
    end 
end




return TimeLimitedDoor


