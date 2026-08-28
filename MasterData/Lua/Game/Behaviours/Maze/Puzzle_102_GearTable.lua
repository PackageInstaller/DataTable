---
--- Created by zou hanjie.Puzzle_102_GearTable
--- DateTime: 2022/11/28 18:28
---@class Puzzle_102_GearTable
local Puzzle_102_GearTable = Class('Puzzle_102_GearTable')



-- =========================================================================================

---@alias TableState_ integer
local TableState_ = {
    Up = 1, 
    Down = 2
}

-- 得到 目标类型
---@return TableState_
function Puzzle_102_GearTable.GetTableState() 
    return TableState_
end

-- =========================================================================================


local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3



---@param tableTransform_ UnityEngine.Transform
---@param initState TableState_
---@param tableHeightOffset_ number
function Puzzle_102_GearTable:__init( tableTransform_, initState_, tableHeightOffset_ )
    --print("   ~~~~~~~ Puzzle_102_GearTable:__init() ~~~~~~~")

    self.tableTransform = tableTransform_ -- Transform
    --self.downPos = tableTransform_.position
    --self.upPos = self.downPos + Vector3( 0.0, 0.0, tableHeightOffset_ )  -- 名义上是高度, 其实改写的是 z轴值;
    self.upPos = tableTransform_.position
    self.downPos = self.upPos - Vector3( 0.0, 0.0, tableHeightOffset_ )  -- 名义上是高度, 其实改写的是 z轴值;
    self.initState = initState_
    --self.currentState = initState_
    --self.tgtState = initState_

    --self.tableTransform.position = ((self.tgtState == TableState_.Up) and self.upPos or self.downPos)
    self:ResetToInit()
end


function Puzzle_102_GearTable:__delete()
    --print("   ~~~~~~~ Puzzle_102_GearTable:__delete() ~~~~~~~")
end


-- =============================================================== Self -> ================================================================== -- 


function Puzzle_102_GearTable:ResetToInit()
    self.currentState = self.initState
    self.tgtState = self.initState
    self.tableTransform.position = (self.initState == TableState_.Up) and self.upPos or self.downPos
end





function Puzzle_102_GearTable:PrepareForNewMove()
    assert( self.currentState == self.tgtState )
    self.tgtState = (self.tgtState == TableState_.Up) and TableState_.Down or TableState_.Up -- flip
end


-- ret: 移动到终点时, 返回 true;
---@return boolean
function Puzzle_102_GearTable:MoveOneFrame()
    
    local tgtPos = (self.tgtState == TableState_.Up) and self.upPos or self.downPos -- Vector3
    self.tableTransform.position = Vector3.Lerp( self.tableTransform.position, tgtPos, 0.1 ) -- todo: 速度先随便写一个
    return ( (tgtPos-self.tableTransform.position).magnitude < 0.03 ) -- todo: 阈值先随便写一个 
end


-- ret: 移动到终点时, 返回 true;
---@return void
function Puzzle_102_GearTable:EndTheMove()
    self.currentState = self.tgtState
    self.tableTransform.position = ((self.tgtState == TableState_.Up) and self.upPos or self.downPos)
end


-- 瞬变为 down 状态;
---@return void
function Puzzle_102_GearTable:SkipToDown()
    self.currentState = TableState_.Down
    self.tgtState = TableState_.Down
    self.tableTransform.position = self.downPos
end 



return Puzzle_102_GearTable
