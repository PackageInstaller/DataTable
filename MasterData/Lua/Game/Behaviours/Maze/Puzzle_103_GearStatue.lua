---
--- Created by zou hanjie.
--- DateTime: 2022/11/28 12:48
---@class Puzzle_103_GearStatue
local Puzzle_103_GearStatue = Class('Puzzle_103_GearStatue')



-- ========================================================================================= -

---@alias StatueState_ integer
local StatueState_ = {
    Up = 1, 
    Right = 2,
    Down = 3,
    Left = 4
}

-- 得到 目标类型
---@return TableState_
function Puzzle_103_GearStatue.GetTableStatueState() 
    return StatueState_
end

-- ========================================================================================= -

local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3
local Quaternion = CS.UnityEngine.Quaternion




-- 雕像 正交45度俯视, 绕着自己旋转;
local upQ    = Quaternion.Euler(45.0, 0.0, 0.0) * Quaternion.Euler(0.0, 0.0,   0.0) -- Quaternion
local rightQ = Quaternion.Euler(45.0, 0.0, 0.0) * Quaternion.Euler(0.0, 90.0,  0.0) -- Quaternion
local downQ  = Quaternion.Euler(45.0, 0.0, 0.0) * Quaternion.Euler(0.0, 180.0, 0.0) -- Quaternion
local leftQ  = Quaternion.Euler(45.0, 0.0, 0.0) * Quaternion.Euler(0.0, 270.0, 0.0) -- Quaternion



---@param statueTransform_ UnityEngine.Transform
---@param initState StatueState_
function Puzzle_103_GearStatue:__init( statueTransform_, initState_ )
    self.statueTransform = statueTransform_ -- 无需位移只需旋转
    self.initState = initState_
    --self.currentState = initState
    --self.tgtState = initState
    --self.statueTransform.rotation = self:GetQuaternion(initState)
    --self.tgtQuaternion = self:GetQuaternion( initState )
    self:ResetToInit()
end


function Puzzle_103_GearStatue:ResetToInit()
    self.currentState = self.initState
    self.tgtState = self.initState
    self.statueTransform.rotation = self:GetQuaternion(self.initState)
    self.tgtQuaternion = self:GetQuaternion( self.initState )
end



function Puzzle_103_GearStatue:__delete()
    --print("   ~~~~~~~ Puzzle_103_GearStatue:__delete() ~~~~~~~")
end

-- =============================================================== Self -> ================================================================== -- 



---@param isTurnLeft boolean
function Puzzle_103_GearStatue:PrepareForNewRotate( isTurnLeft ) 
    assert( self.currentState == self.tgtState )
    self.tgtState = isTurnLeft and self:NextLeftState(self.currentState) or self:NextRightState(self.currentState)
    self.tgtQuaternion = self:GetQuaternion( self.tgtState )
end



-- ret: 移动到终点时, 返回 true;
---@return boolean
function Puzzle_103_GearStatue:RotateOneFrame() 
    self.statueTransform.rotation = Quaternion.RotateTowards( self.statueTransform.rotation, self.tgtQuaternion, 1.2 ) -- todo: 速度先随便写一个
    return (Quaternion.Dot(self.statueTransform.rotation, self.tgtQuaternion) > 0.9999) -- todo: 阈值先随便写一个 
end 


---@return void
function Puzzle_103_GearStatue:EndTheRotate()
    self.currentState = self.tgtState
end


-- 瞬变为目标状态
---@param state StatueState_
---@return void
function Puzzle_103_GearStatue:SkipToTargetState( state )
    self.currentState = state
    self.tgtState = state
    self.statueTransform.rotation = self:GetQuaternion( self.tgtState )
end



---@param state StatueState_
---@return Quaternion
function Puzzle_103_GearStatue:GetQuaternion( state )

    if     state == StatueState_.Up then        return upQ
    elseif state == StatueState_.Right then     return rightQ
    elseif state == StatueState_.Down then      return downQ
    elseif state == StatueState_.Left then      return leftQ
    else 
        assert( false,"代码存在问题"  )
        return upQ
    end
end



---@param now StatueState_
---@return StatueState_
function Puzzle_103_GearStatue:NextLeftState( now )

    if     now == StatueState_.Up then        return StatueState_.Left
    elseif now == StatueState_.Right then     return StatueState_.Up
    elseif now == StatueState_.Down then      return StatueState_.Right
    elseif now == StatueState_.Left then      return StatueState_.Down
    else 
        assert( false,"代码存在问题"  )
        return StatueState_.Up
    end
end 


---@param now StatueState_
---@return StatueState_
function Puzzle_103_GearStatue:NextRightState( now )

    if     now == StatueState_.Up then        return StatueState_.Right
    elseif now == StatueState_.Right then     return StatueState_.Down
    elseif now == StatueState_.Down then      return StatueState_.Left
    elseif now == StatueState_.Left then      return StatueState_.Up
    else 
        assert( false,"代码存在问题"  )
        return StatueState_.Up
    end
end 



return Puzzle_103_GearStatue
