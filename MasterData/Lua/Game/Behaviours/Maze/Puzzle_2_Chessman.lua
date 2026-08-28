---
--- Created by zou hanjie.
--- DateTime: 2022/11/28 12:48



-- =========================================================================================


local Puzzle_2_Chessman = Class('Puzzle_2_Chessman')

-- !!! 此处禁止循环引用 Puzzle_2 ...


local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3
local Vector2Int = CS.UnityEngine.Vector2Int
local SpriteRenderer = CS.UnityEngine.SpriteRenderer
local Mathf = CS.UnityEngine.Mathf
local Time = CS.UnityEngine.Time
        

-- =========================================



-- =========================================

-- 仅存入数据, 不做其它操作
---@class Puzzle_2_Chessman
---@param initIdx_ UnityEngine.Vector2Int
---@param outletIdx_ UnityEngine.Vector2Int
---@param canPassObstacle_ boolean
function Puzzle_2_Chessman:__init(initIdx_, outletIdx_, canPassObstacle_)


    self.initIdx = initIdx_     -- Vector2Int
    self.outletIdx = outletIdx_ -- Vector2Int 目的地, 只对 role 有效
    self.currentIdx = nil   -- Vector2Int
    self.tgtIdx = nil       -- Vector2Int
    self.canPassObstacle = canPassObstacle_ -- role 可穿过障碍物, guard 不行
    self.transform = nil -- Transform
    self.srcPos = nil -- Vector3
    self.tgtPos = nil -- Vector3
    self.puzzle = nil -- Puzzle_2
    self.t = 0.0

    self.moveSpeed =  3.5 -- 棋子移动的速度
end


function Puzzle_2_Chessman:__delete()
    print("   ~~~~~~~ Puzzle_2_Chessman:__delete() ~~~~~~~")
end


-- =============================================================== Self -> ================================================================== -- 


-- 在 role / guard 进入棋盘时执行;
-- virtual
---@param puzzle_ Puzzle_2
---@param transform_ UnityEngine.Transform
---@param dangerZonePrefab UnityEngine.GameObject
---@return void
function Puzzle_2_Chessman:Init(puzzle_, transform_, dangerZonePrefab)

    self.puzzle = puzzle_

    -- 为规避循环引用 而暂时存储的 函数指针: 
    self.CalcNodePos = self.puzzle.CalcNodePos
    self.IsIdxLegal = self.puzzle.IsIdxLegal
    self.IsIdxInBounds = self.puzzle.IsIdxInBounds
    self.IsCollideAnyGuard = self.puzzle.IsCollideAnyGuard
    self.ResetChessmanInObstacles = self.puzzle.ResetChessmanInObstacles

    self.transform = transform_
    self.currentIdx = self.initIdx
    self.tgtIdx = self.initIdx
    self.transform.position = self.CalcNodePos( self.puzzle, self.tgtIdx, true, self.canPassObstacle ) -- 函数指针
    self.srcPos = self.transform.position
    self.tgtPos = self.transform.position
    self.t = 0.0

end


-- ret: 移动指令是否有效
---@param offset UnityEngine.Vector2Int
---@return boolean
function Puzzle_2_Chessman:PrepareForNewMove(offset)

    assert( self.currentIdx == self.tgtIdx, "currentIdx = " .. self.currentIdx:ToString() .. "; tgtIdx = " .. self.tgtIdx:ToString() );

    local tmpTgtIdx = self.currentIdx + offset -- Vector2Int
    if self.IsIdxLegal(self.puzzle, tmpTgtIdx, self.canPassObstacle )  then -- 函数指针
    
        self.tgtIdx = tmpTgtIdx
        print( "tgtIdx = " .. self.tgtIdx:ToString() )
        self.tgtPos = self.CalcNodePos( self.puzzle, self.tgtIdx, true, self.canPassObstacle ) -- 函数指针
        self.t = 0.0
        return true
    end
    return false
end


-- ret: 移动到终点时, 返回 true;
---@param offset UnityEngine.Vector2Int
---@return boolean
function Puzzle_2_Chessman:MoveOneFrame()

    self.t = Mathf.Clamp01( self.t + Time.deltaTime * self.moveSpeed )
    self.transform.position = Vector3.Lerp( self.srcPos, self.tgtPos, Mathf.SmoothStep(0, 1, self.t) )

    return ( self.t > 0.999 ) -- todo: 阈值先随便写一个 
end


---@param isSetPos boolean @ 是否会改动 pos,
---@return void
function Puzzle_2_Chessman:EndTheMove( isSetPos )
    self.currentIdx = self.tgtIdx
    if isSetPos == true then
        self.transform.position = self.tgtPos
        self.srcPos = self.tgtPos
        self.t = 0.0
    end
end


-- virtual
---@return void
function Puzzle_2_Chessman:BackToInitPos()
    self.currentIdx = self.initIdx
    self.tgtIdx = self.initIdx
    self.tgtPos = self.CalcNodePos( self.puzzle, self.tgtIdx, false, self.canPassObstacle) -- 函数指针
    self.t = 0.0
end



---@return void
function Puzzle_2_Chessman:SkipToOutletPos()
    self.currentIdx = self.outletIdx
    self.tgtIdx = self.outletIdx
    self.transform.position = self.CalcNodePos( self.puzzle, self.tgtIdx, false, self.canPassObstacle) -- 函数指针
end


---@return boolean
function Puzzle_2_Chessman:IsReachOutlet()
    return self.currentIdx == self.outletIdx
end



return Puzzle_2_Chessman
