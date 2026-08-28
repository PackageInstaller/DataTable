---
--- Created by zou hanjie.
--- DateTime: 2022/11/28 12:48



-- =========================================================================================




local Chessman = import('Game.Behaviours.Maze.Puzzle_2_Chessman')

---@class Puzzle_2_Guard
local Puzzle_2_Guard = Class('Puzzle_2_Guard', Chessman )

-- !!! 此处禁止循环引用 Puzzle_2 ...

local Object = CS.UnityEngine.Object
local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3
local Vector2Int = CS.UnityEngine.Vector2Int
local SpriteRenderer = CS.UnityEngine.SpriteRenderer
local Color = CS.UnityEngine.Color
local Mathf = CS.UnityEngine.Mathf
local Time = CS.UnityEngine.Time

-- =========================================


local near4IdxOffsets = {
    Vector2Int( 0, 1 ),
    Vector2Int( 0,-1 ),
    Vector2Int(-1, 0 ),
    Vector2Int( 1, 0 )
}


local dangerZoneAlphaMax = 0.9


-- =========================================


---@param initIdx_ UnityEngine.Vector2Int
function Puzzle_2_Guard:__init( initIdx_ )
    self.super.__init(self, initIdx_, Vector2Int(0, 0), false )
end


function Puzzle_2_Guard:__delete()
    print("   ~~~~~~~ Puzzle_2_Guard:__delete() ~~~~~~~")
end


-- =============================================================== Self -> ================================================================== -- 




---@override
---@param puzzle_ Puzzle_2
---@param transform_ UnityEngine.Transform
---@param dangerZonePrefab UnityEngine.GameObject
---@return void
function Puzzle_2_Guard:Init(puzzle_, transform_, dangerZonePrefab )

    self.super.Init(self, puzzle_, transform_, dangerZonePrefab )


    local srComps = self.transform:GetComponentsInChildren(typeof(SpriteRenderer),true) -- 包含自己
    assert( srComps.Length == 1 )
    self.ChessmanSRenderer = srComps[0]
    --self.ChessmanSRenderer.color = Color( 0.6, 0.6, 1, 0.8 )


    self.dangerZones = {} --
    for i=1, 4 do 
        local newgo = Object.Instantiate( dangerZonePrefab, self.transform ) -- todo: 记得释放资源  GameObject
        newgo.name = "--KK--"
        newgo:SetActive( true )
        local srs = newgo.transform:GetComponentsInChildren(typeof(SpriteRenderer),true) -- 包含自己
        assert( srs.Length == 1 )
        local sRenderer = srs[0]
        sRenderer.color = Color( 1,1,1, 0.9 )

        ----------
        local newIdx = self.currentIdx + near4IdxOffsets[i] -- Vector2Int
        newgo.transform.position = self.CalcNodePos( self.puzzle, newIdx, false, true ) -- 函数指针
        ---
        table.insert( self.dangerZones, {
            gameObj = newgo,
            transform = newgo.transform, 
            sRenderer = sRenderer, 
            tgtAlpha = 1.0
        })
    end

    self.id = nil -- int, 存储在 guards 中的 idx,  1-based idx
    self.isDetect = nil -- boolean 本回合是否执行过预测
    self.canMoveFromDetect = nil -- boolean 在预测中, 是否可移动

    self:ResetDanderZones()
end



-- 覆写基类的:
-- ret: 移动到终点时, 返回 true;
---@param offset UnityEngine.Vector2Int
---@return boolean
function Puzzle_2_Guard:MoveOneFrame()

    self.t = Mathf.Clamp01( self.t + Time.deltaTime * self.moveSpeed )
    self.transform.position = Vector3.Lerp( self.srcPos, self.tgtPos, Mathf.SmoothStep(0, 1, self.t) )

    -- dangerZone alpha: 
    for i=1, 4 do 
        local dangerZone = self.dangerZones[i]
        dangerZone.sRenderer.color = Color( 1,1,1, Mathf.Lerp( dangerZone.sRenderer.color.a, dangerZone.tgtAlpha, self.t ) )
    end 
    --- 
    return ( self.t > 0.999 ) -- todo: 阈值先随便写一个 
end



function Puzzle_2_Guard:Reset()
    self.isDetect = false
    self.canMoveFromDetect = false
end



function Puzzle_2_Guard:ResetDanderZonesTgtAlpha()
    print( "~~~ 重置 dangerZone alpha 值 ~~~" )
    -- 处理 4 个 deadzone:
    for i=1, 4 do 
        local tmpTgtIdx = self.tgtIdx + near4IdxOffsets[i] -- Vector2Int
        local isShow = self:IsDanderZonesShow( tmpTgtIdx )
        self.dangerZones[i].tgtAlpha = (isShow==true) and (1.0 * dangerZoneAlphaMax) or 0.0
    end
end


-- ret: boolean
function Puzzle_2_Guard:IsDanderZonesShow( tmpTgtIdx )
  
    if ( self.IsIdxInBounds(self.puzzle, tmpTgtIdx) == false ) then -- 函数指针, 棋盘格出界
        return false 
    end

    local registeredID = self.puzzle.gridCells[tmpTgtIdx.y][tmpTgtIdx.x].obstacle -- int
    if ( registeredID ~= self.puzzle.OBSTACLE_EMPTY ) then -- 会被 "遮挡物" 阻挡
        return false 
    end

    return true
end 





function Puzzle_2_Guard:ResetDanderZones()
    self:ResetDanderZonesTgtAlpha() 
    for i=1, 4 do 
        self.dangerZones[i].sRenderer.color = Color( 1,1,1, self.dangerZones[i].tgtAlpha )
    end 
end 



function Puzzle_2_Guard:SetOrderInLayers()
    -- 改写 守卫的:
    self.ChessmanSRenderer.sortingOrder = self.puzzle.gridCells[self.tgtIdx.y][self.tgtIdx.x].orderInLayer
    -- 改写 dangerZones 的:
    for i=1, 4 do 
        local idx = self.tgtIdx + near4IdxOffsets[i] -- Vector2Int
        if self.dangerZones[i].tgtAlpha > 0.1 then 
            self.dangerZones[i].sRenderer.sortingOrder = self.puzzle.gridCells[idx.y][idx.x].orderInLayer
        end 
    end 
end




-- ret: 移动指令是否有效
---@param offset UnityEngine.Vector2Int
---@return boolean
function Puzzle_2_Guard:PrepareForNewMoveRecursive(offset)

    if self.isDetect == false  then
        self.isDetect = true
        self.canMoveFromDetect = self:PrepareForNewMove_Inn( offset )
        if self.canMoveFromDetect == true  then
        
            local tmpTgtIdx = self.currentIdx + offset -- Vector2Int
            self.ResetChessmanInObstacles(self.puzzle, self.currentIdx, tmpTgtIdx, self.id ) -- 函数指针
            self.tgtIdx = tmpTgtIdx;
            print( "tgtIdx = " .. self.tgtIdx:ToString() )
            self.tgtPos = self.CalcNodePos(self.puzzle, self.tgtIdx, false, self.canPassObstacle ) -- 函数指针
            -- 处理 4 个 deadzone:
            self:ResetDanderZonesTgtAlpha()
        end
    end

    if self.canMoveFromDetect == true then 
        --self.puzzle.gridCells[self.tgtIdx.y][self.tgtIdx.x].orderInLayer
        self:SetOrderInLayers()
    end 
    
    return self.canMoveFromDetect
end


-- ret: 移动指令是否有效
---@param offset UnityEngine.Vector2Int
---@return boolean
function Puzzle_2_Guard:PrepareForNewMove_Inn(offset)

    assert( self.currentIdx == self.tgtIdx, "currentIdx = " .. self.currentIdx:ToString() .. "; tgtIdx = " .. self.tgtIdx:ToString() )
    local tmpTgtIdx = self.currentIdx + offset -- Vector2Int

    if self.IsIdxInBounds(self.puzzle, tmpTgtIdx) == false  then -- 函数指针
        return false -- 棋盘格出界
    end

    local registeredID = self.puzzle.gridCells[tmpTgtIdx.y][tmpTgtIdx.x].obstacle -- int

    if registeredID == self.puzzle.OBSTACLE_STATIC then
        return false -- guard 会被 "遮挡物" 阻挡
    elseif registeredID == self.puzzle.OBSTACLE_EMPTY then
        return true
    end


    -- 发现目标格上存在另一个 guard:
    assert( registeredID > 0, "registeredID = " .. registeredID )  -- 此时,只可能存储 guard id
    assert( registeredID <= #self.puzzle.guards )               -- 存储值必须是有效的;

    local othGuard = self.puzzle.guards[registeredID] -- Guard

    -- 链式反应:
    -- othGuard 可能已经计算过了, 那直接拿数据;
    -- othGuard 也可能尚未计算, 那个递归地让它先去计算;
    return othGuard.isDetect and othGuard.canMoveFromDetect or othGuard:PrepareForNewMoveRecursive(offset) -- 它走我们也能走, 它堵塞我们也堵塞
end 


---@override
---@return void
function Puzzle_2_Guard:BackToInitPos()
    self.ResetChessmanInObstacles(self.puzzle, self.currentIdx, self.initIdx, self.id ) -- 函数指针
    self.super.BackToInitPos(self)
    self:ResetDanderZones()
    self:SetOrderInLayers()
end 


-- 隐藏起来
---@return void
function Puzzle_2_Guard:Hide()
    self.transform.gameObject:SetActive( false ) -- 粗暴的方式
    for i,e in pairs(self.dangerZones) do
        e.transform.gameObject:SetActive( false ) -- 粗暴的方式
    end
end


return Puzzle_2_Guard
