---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28



---@class Puzzle_2
---@field vertex_up               UnityEngine.Transform
---@field vertex_down             UnityEngine.Transform
---@field vertex_left             UnityEngine.Transform
---@field vertex_right            UnityEngine.Transform
---@field guard_1                 UnityEngine.Transform
---@field guard_2                 UnityEngine.Transform -- 可为空
---@field dangerZonePrefab        UnityEngine.Transform
---@field obstacleObj              UnityEngine.Transform
local Puzzle_2 = Class('Puzzle_2')


-- ========================================================

---@type SettingMgr
local settingMgr = SettingMgr:GetInstance()


local Button = CS.UnityEngine.UI.Button
local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3
local Vector2Int = CS.UnityEngine.Vector2Int
local SpriteRenderer = CS.UnityEngine.SpriteRenderer


local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders


local TrackBrain            = import('Game.Behaviours.SimpleTrack.TrackBrain')
local TrackNodeGO           = import('Game.Behaviours.SimpleTrack.TrackNodeGO')
local MazeEventType         = import('Game.Behaviours.Maze.MazeEventType')
local EventKey              = import('Game.Behaviours.Maze.EventKey')
local EventData             = import('Game.Behaviours.Maze.EventData')
local HandleMazeTableFile   = import('Game.Behaviours.Maze.HandleMazeTableFile')
local Chessman              = import('Game.Behaviours.Maze.Puzzle_2_Chessman')
local Guard                 = import('Game.Behaviours.Maze.Puzzle_2_Guard')
local MazeMain              = import('Game.Behaviours.Maze.MazeMain')

---@type MazeMainUI
local MazeMainUI = import('Game.Behaviours.Maze.MazeMainUI')

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')


---@type Maze2DUtils
local Maze2DUtils = import('Game.Behaviours.Maze.Maze2DUtils'):GetInstance()


---@type Maze2DSounds
local Maze2DSounds = import('Game.Behaviours.Maze.Maze2DSounds'):GetInstance()

local SortedHeap = import('Game.DreamSpace.Tools.SortedHeap')

--- funtoy:
local KTool = CS.Engine.Lib.KTool
local IDComp = CS.Game.Native.Common.ID


-- ========================================================





-- ========================================================


function Puzzle_2:__init()
    --print("   ~~~~~~~ Puzzle_2:__init() ~~~~~~~")
    self.controller = nil

    -- 填充到 棋盘数组中的 标识符:
    self.OBSTACLE_EMPTY = -1    -- int  空元素
    self.OBSTACLE_STATIC = -2   -- int  遮挡物


end


function Puzzle_2:__delete()
    --print("   ~~~~~~~ Puzzle_2:__delete() ~~~~~~~")
    self.gear_3_Key = nil 
    self.gear_4_Key = nil 
    self.gear_5_Key = nil 
    self.gearTables = nil 
    self.mazeMain = nil
    self.currentEventKey = nil
    self.isSolved = nil
end


function Puzzle_2:OnDestroy()

    Maze2DStates.ClearUIFunctions()

    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象

    if self.co_1 then
        cs_coroutine.stop(self.co_1)
        self.co_1 = nil
    end
    self:Delete()    
    --print("   ~~~~~~~ Puzzle_2:OnDestroy(): End ~~~~~~~")
end



-- =============================================================== Self -> ================================================================== -- 

  
---@param mazeMain_ MazeMain
---@param trackBrain_ TrackBrain
---@param handleMazeTableFile_ HandleMazeTableFile
---@param mazeChapter string 
function Puzzle_2:SelfInit( mazeMain_, trackBrain_, handleMazeTableFile_, mazeChapter )

    assert( 
            self.vertex_up and self.vertex_down and self.vertex_left and self.vertex_right
            and self.dangerZonePrefab and self.obstacleObj
    )
    assert( mazeMain_ and trackBrain_ )

    -- ================================== 直接读取配表 ===============================================:
    local tableFile = settingMgr:Get(AutoIds.IdSetting3003) -- TableFile,  迷宫2棋盘配置表 

    local tgtRow = nil -- TableFileRow, 一个章节 只需要 一行信息
    -- 找到目标行
    local length = tableFile:GetRowCount()
    for i=1,length do -- (实际从表格第 5 行开始读)
        local row = tableFile:GetRow(i) -- TableFileRow
        local chapterInfo = string.lower( row:Get("group") ) -- string
        if chapterInfo == mazeChapter  then
            assert( tgtRow == nil )
            tgtRow = row
            break
        end
    end
    assert( tgtRow ~= nil )    
    
    local widthNum  = tonumber( tgtRow:Get("widthNum") ) -- int     -- todo: 无法确认这一定是 整数
    local heightNum = tonumber( tgtRow:Get("heightNum") ) -- int  -- todo: 无法确认这一定是 整数

    -- roleChessman_:
    local roleInletIdx  = HandleMazeTableFile.StringToCheckerboardIdx( string.lower( tgtRow:Get("roleInlet") ) ) -- Vector2Int
    local roleOutletIdx = HandleMazeTableFile.StringToCheckerboardIdx( string.lower( tgtRow:Get("roleOutlet") ) ) -- Vector2Int 
    local roleChessman_ = Chessman.New( roleInletIdx, roleOutletIdx, true )
    assert( roleChessman_ )

    -- guards:
    local guards_ = {} -- List<Guard> table
    local guardStrs = string.split( string.lower(tgtRow:Get("guardInlets")), ';' ) -- string[] table 
    for i,s in pairs(guardStrs) do
        table.insert( guards_, Guard.New( HandleMazeTableFile.StringToCheckerboardIdx(s) ) )
    end
    assert( #guards_ > 0  )

    -- obstacles:
    local obstacleIdxs_ = {} -- List<Vector2Int> table
    local obstacleStrs = string.split( string.lower(tgtRow:Get("obstacles")), ';' ) -- string[] table, 可能为空
    for i,s in pairs(obstacleStrs) do
        if s ~= ""  then
            table.insert( obstacleIdxs_, HandleMazeTableFile.StringToCheckerboardIdx(s) )
        end
    end 
    -- obstacleIdxs_ 允许为空

    local gearKey_     = EventKey.New({ keyStr = string.lower(tgtRow:Get("gearKey")) })
    local solvedKey_   = EventKey.New({ keyStr = string.lower(tgtRow:Get("solvedKey")) })
    local failureKey_ = EventKey.New({ keyStr = string.lower(tgtRow:Get("failureKey")) })

    assert( not isNull( handleMazeTableFile_.eventDatas[solvedKey_.keyStr] )
        and not isNull( handleMazeTableFile_.eventDatas[failureKey_.keyStr] )
    )   

    local roleOutletTrackNodeGO_ = trackBrain_:FindTrackNodeGO( TrackNodeGO.StringToTrackNodeID( string.lower(tgtRow:Get("targetNode")) ) ) -- 找不到会报错

    -- ================================== 依据读取的配表数据 初始化本实例 ===============================================:

    self.mazeMain = mazeMain_ -- 本 calss 和 mazeMain 紧密相连;


    -- btn.onClick:AddListener()
    Maze2DStates.WhenPushBtns.Up2       = Bind(self,self.WhenPushBtnUp)
    Maze2DStates.WhenPushBtns.Down2     = Bind(self,self.WhenPushBtnDown)
    Maze2DStates.WhenPushBtns.Left2     = Bind(self,self.WhenPushBtnLeft)
    Maze2DStates.WhenPushBtns.Right2    = Bind(self,self.WhenPushBtnRight)
    Maze2DStates.WhenPushBtns.Dismantle = Bind(self,self.WhenPushBtnDismantle)
    Maze2DStates.WhenPushBtns.Reset     = Bind(self,self.WhenPushBtnReset)
    Maze2DStates.BindAllBtnFuncs()

    self.isBtnUp2Show       = true
    self.isBtnDown2Show     = true
    self.isBtnLeft2Show     = true
    self.isBtnRight2Show    = true

    -- 这是 guard gos 的真正本体, (为了免于 异步加载资源, 直接改为本地绑定...)
    -- 本 class 内的 guards, 仅仅是对此处的 gos 的控制者;
    self.guardTransforms = {}
    assert( self.guard_1 )
    table.insert( self.guardTransforms, self.guard_1 )

    if not isNull(self.guard_2) then 
        table.insert( self.guardTransforms, self.guard_2 )
    end
    assert( #self.guardTransforms >= #guards_, "guardTransforms num = " .. #self.guardTransforms .. "; guards_ num = " .. #guards_ )


    self.roleChessman = roleChessman_ -- Chessman
    self.guards = guards_ -- List<Guard> table, 接管了 guardTransforms 中 gameobj 的控制权
    self.gearEventKey = gearKey_
    self.solvedEventKey = solvedKey_
    self.failureEventKey = failureKey_
    
    self.mazeInput = mazeMain_.mazeInput
    self.isSolved = false -- 一旦解谜成功, 再次进入迷宫将不会触发谜题;

    self.cameraPivot = self.mazeMain.cameraPivot
    self.elementNums = Vector2Int( widthNum, heightNum ) -- 棋盘内的元素个数; 
    self.roleOutletTrackNodeGO = roleOutletTrackNodeGO_

    --self.roleTransform = self.mazeMain.ui.role.roleTF -- 暂存, 晚点塞到 role 里
    self.roleTransform = self.mazeMain.uiRole:RolePivotTF()

    self.pos_00  = self.vertex_left.position      -- Vector3, leftDown
    local pos_01 = self.vertex_down.position      -- rightDown
    local pos_10 = self.vertex_up.position        -- leftUp
    local pos_11 = self.vertex_right.position     -- rightUp

    self.moveUpFull      = pos_10 - self.pos_00 -- Vector3
    self.moveRightFull   = pos_01 - self.pos_00

    self.moveUpStep    = self.moveUpFull / self.elementNums.y
    self.moveRightStep = self.moveRightFull / self.elementNums.x 

    local centerPos_00 = self.pos_00 + self.moveUpStep * 0.5 + self.moveRightStep * 0.5



    -- ===== gridCells =====:
    -- 
    --     棋盘格每一格的信息:
    --       obstacle:
    --          -1:         空
    --          -2:         预设遮挡物, guard 不可通行, roleChessman 可通行
    --          [1,+inf):   登记在地块上的 guard idx, 1-based
    --       orderInLayer:
    -- 
    self.gridCells = {} -- List<List<int>>  双层table,  0-based
    for j=0, self.elementNums.y-1 do -- 0-based-idx   H
        local singleLine = {} -- 单行初始数据,   0-based
        for i=0, self.elementNums.x-1 do -- 0-based-idx   W
            local cell_idx = j * self.elementNums.x + i 

            singleLine[i] = {
                obstacle = self.OBSTACLE_EMPTY,
                orderInLayer = 1
                --cellIdx = cell_idx
            }
        end
        self.gridCells[j] = singleLine
    end


    -- 根据每个 棋盘格子的 y 值排序, 最上面的排前面:
    -- todo: 目前国服里没有 SortedDictionary
    -- local SortedDicType = CS.System.Collections.Generic.SortedDictionary(CS.System.Single, CS.System.Int32) -- 从小到大排序
    -- local sortedDic = SortedDicType()


    -- 根据每个 棋盘格子的 y 值排序, 最上面的排前面:
    -- 根据 k 值 从小到大排序
    local sortedHeap = SortedHeap.New( 100, function( a, b )
        return a.k < b.k
    end)

    for j=0, self.elementNums.y-1 do -- 0-based-idx   H
        for i=0, self.elementNums.x-1 do -- 0-based-idx   W
            local cell_idx = j * self.elementNums.x + i 
            local cellPos = centerPos_00 + self.moveUpStep * j + self.moveRightStep * i
            --sortedDic:Add( -cellPos.z, cell_idx )
            sortedHeap:Add( { k = -cellPos.z, v = cell_idx } )
        end 
    end 
    ---
    
    local tmpOrderInLayer = 10
    local sortedHeapLen = sortedHeap:Count()

    for i=1,sortedHeapLen do
        local pop = sortedHeap:PopTop()
        assert( isNotNull(pop) )
        local k = pop.k
        local idx = pop.v

    --for k,idx in pairs(sortedDic) do 
        local h = idx // self.elementNums.x
        local w = idx % self.elementNums.x
        --print( "h:" .. h .. ", w:" .. w )
        self.gridCells[h][w].orderInLayer = tmpOrderInLayer
        tmpOrderInLayer = tmpOrderInLayer + 1
    end 
    -- 现在, 最上方的格子的 orderInLayer 值最小, 往下依次递增



    -- 目前只有一个 遮挡物 (纸箱子)
    -- 直接手动设置它的 sortingOrder 吧,  未来万一 遮挡物数量变多, 就需要批量管理了..
    local srComps = self.obstacleObj:GetComponentsInChildren(typeof(SpriteRenderer),true) -- 包含自己
    assert( srComps.Length == 1 )
    local obstacleObjSRenderer = srComps[0]

    -- 登记 gridCells: 遮挡物
    if #obstacleIdxs_ > 0 then
        for i,e in pairs(obstacleIdxs_) do
            self.gridCells[e.y][e.x].obstacle = self.OBSTACLE_STATIC
            -- 其实目前此处只会被调用一次..
            obstacleObjSRenderer.sortingOrder = self.gridCells[e.y][e.x].orderInLayer
        end
    end
    

    self:Debug_obstacles()
end



---@return void
function Puzzle_2:Debug_obstacles()

    local ss = "gridCells:\n"
    for j=0, self.elementNums.y-1 do -- 0-based-idx   H
        local s = "\n"
        for i=0, self.elementNums.x-1 do -- 0-based-idx   W
            local n = self.gridCells[j][i]
            --s = s .. " 挡:" .. n.obstacle .. ", 序:" ..  n.orderInLayer .. ",    "
            s = s .. " 挡:" .. n.obstacle ..  ",    "
        end 
        ss = ss .. s
    end

    print(ss)
end



-- Chessman 每移动一步, 都会更新自己在 obstacles 的信息;
---@param oldIdx UnityEngine.Vector2Int
---@param newIdx UnityEngine.Vector2Int
---@param id integer
---@return void
function Puzzle_2:ResetChessmanInObstacles(  oldIdx, newIdx, id )
    
    assert( self:IsIdxInBounds(oldIdx) and self:IsIdxInBounds(newIdx) )
    assert( self.gridCells[oldIdx.y][oldIdx.x].obstacle >= 0 )
    self.gridCells[oldIdx.y][oldIdx.x].obstacle = self.OBSTACLE_EMPTY
    self.gridCells[newIdx.y][newIdx.x].obstacle = id
end




---@return void
function Puzzle_2:WhenPushBtnUp()
    if self.isBtnUp2Show  then
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Up2)
        self:HandleButtonPush( Vector2Int( 0,1 ) )
    end
end
---@return void
function Puzzle_2:WhenPushBtnDown() 
    if self.isBtnDown2Show  then
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Down2)
        self:HandleButtonPush( Vector2Int( 0,-1 ) )
    end
end
---@return void
function Puzzle_2:WhenPushBtnLeft() 
    if self.isBtnLeft2Show  then
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Left2)
        self:HandleButtonPush( Vector2Int( -1,0 ) )
    end
end
---@return void
function Puzzle_2:WhenPushBtnRight() 
    if self.isBtnRight2Show  then
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Right2)
        self:HandleButtonPush( Vector2Int( 1,0 ) )
    end
end


---@param offset UnityEngine.Vector2Int
---@return void
function Puzzle_2:HandleButtonPush( offset )

    --if (Maze2DStates.isInAutoControl <= 0) and (self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle)  then
    if (Maze2DStates.IsInAutoControlLegal() == true) and (self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle)  then
        --print("按钮, 移动: " .. offset:ToString() )

        local isRoleNeedMove = self.roleChessman:PrepareForNewMove( offset ) -- boolean
        if isRoleNeedMove == true then 
            --self:CheckRoleAndHideBtn()
            -- 先初始化各个 guard 的状态
            for i,g in pairs(self.guards) do
                g:Reset()
            end
            -- todo: 可否合到上一个 for 中去 ???
            for i,g in pairs(self.guards) do
                g:PrepareForNewMoveRecursive( offset * -1 )
            end
            -- 单独设置一遍 deadZones 是否显示, 这是避免某个 deadZone 盖在别的 guard 上面的最简单的方法
            for i,g in pairs(self.guards) do
                g:ResetDanderZonesTgtAlpha()
            end

            self:Debug_obstacles()
            self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.FirstFrame
        end
    end

end




---@return void
function Puzzle_2:WhenPushBtnDismantle()
    print("按下 skip 按钮")
    if self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        -- 在一帧内就能完成, 就不设置状态了
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Dismantle)
        self:HandleSolved();
    end
end



---@return void
function Puzzle_2:WhenPushBtnReset()
    print("按下 reset 按钮")
    if self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Handling
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Reset)
        self.co_1 = cs_coroutine.start(self.HandleReset, self)
    end
end


---@param eventKey EventKey
---@return void
function Puzzle_2:WhenEnterGear( eventKey )

    print("WhenEnterGear" .. "eventKey = " .. eventKey.keyStr)
    assert( EventKey.CheckType(eventKey) )

    if self.isSolved then
        return
    end 
    -- todo: 粗暴地隐藏 按钮的显示...
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Up2, true )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Down2, true )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Left2, true )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Right2, true )

    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, true )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Reset, true )

    self.roleChessman:Init( self, self.roleTransform, nil )
    self:CheckRoleAndHideBtn()

    for i,g in pairs(self.guards) do
        g:Init( self, self.guardTransforms[i], self.dangerZonePrefab.gameObject )
        g.id = i -- 1-based idx
        --g:Update4DangerZones()
    end 

    -- 守卫登场时需要声音:
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_guard )

    -- 登记 obstacles: guards
    for i,g in pairs(self.guards) do
        self.gridCells[g.initIdx.y][g.initIdx.x].obstacle = i -- 1-based
    end

    self.mazeMain.isInPuzzle = true -- !!!!! MUST
end




---@return void
function Puzzle_2:WhenLeaveGear()
    print( "-1- WhenLeaveGear() currentEventKey = " .. (isNull(self.currentEventKey) and "null" or self.currentEventKey.keyStr) )

    -- !!! 此处不能根据 isSolved 跳过下方操作;
    -- todo: 粗暴地隐藏 按钮的显示...
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Up2, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Down2, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Left2, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Right2, false )

    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Reset, false )

    -- todo: ...

    self.mazeMain.isInPuzzle = false -- !!!!! MUST
end



-- 若 role 在棋盘格边缘, 需要直接影藏部分 方向按钮,(同时点亮一些方向按钮)
---@return void
function Puzzle_2:CheckRoleAndHideBtn()

    local idx = self.roleChessman.currentIdx
    self.isBtnUp2Show       = (idx.y ~= self.elementNums.y-1)
    self.isBtnDown2Show     = (idx.y ~= 0)
    self.isBtnLeft2Show     = (idx.x ~= 0)
    self.isBtnRight2Show    = (idx.x ~= self.elementNums.x-1)

    -- print("=== 方向按钮 隐藏/显示; ")
    -- print("=== up: " .. tostring(self.isBtnUp2Show))
    -- print("=== down: " .. tostring(self.isBtnDown2Show))
    -- print("=== left: " .. tostring(self.isBtnLeft2Show))
    -- print("=== right: " .. tostring(self.isBtnRight2Show))
    ---:

    self.ui = MazeMainUI.GetCurrentInstance() 
    assert( not isNull( self.ui ) )
    self.ui:PlayBtnHideOrShowAnimation(Maze2DStates.Btns.Up2,      self.isBtnUp2Show)
    self.ui:PlayBtnHideOrShowAnimation(Maze2DStates.Btns.Down2,    self.isBtnDown2Show)
    self.ui:PlayBtnHideOrShowAnimation(Maze2DStates.Btns.Left2,    self.isBtnLeft2Show)
    self.ui:PlayBtnHideOrShowAnimation(Maze2DStates.Btns.Right2,   self.isBtnRight2Show)
end



---@return System.Collections.IEnumerator
function Puzzle_2:HandlePuzzle()

    -- ===== roleChessman 行动 =====:
    cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(self.roleChessman.tgtPos), {smoothTime = 0.25, maxSpeed = 30.0} ) )

    -- 开始播放 role 走路 音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_walk )

    while self.roleChessman:MoveOneFrame() == false do
        coroutine.yield(Yielders.EndOfFrame)
    end
    self.roleChessman:EndTheMove(true)

    -- 停止播放 走路 音效: 
    Maze2DSounds.Stop( Maze2DSounds.musics.ui_festival_map_walk )

    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.1))

    -- ===== 检查解谜是否失败 -1- =====:
    -- 若 roleChessman 踩入危险区, 将跳入失败 event, 然后把玩家传入起点重来;
    if self:IsRoleInDanger() == true  then
        -- guards 善后:
        for i,g in pairs(self.guards) do
            g:EndTheMove( false )
        end
    
        cs_coroutine.yield_return(self:HandleFailure()) 
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
        self:CheckRoleAndHideBtn()
        return
    end

    -- ===== guards 行动 =====:

    -- 计算所有 guards 中点pos, 让 cameraPivot 对齐到它;
    local centerPos = Vector3.zero -- Vector3
    for i,g in pairs(self.guards) do
        centerPos = centerPos + g.tgtPos
    end
    centerPos = centerPos / (#self.guards + 0.0) -- todo: '/' 操作似乎能自动获得 float, 这意味着后面的 "转 float" 操作可能是多余的...
    cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(centerPos), {smoothTime = 0.25, maxSpeed = 30.0} ) )

    -- 守卫移动的声音:
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_guard )

    -- 同时移动所有 guards:
    local isAnyGuardMoving = true -- boolean
    while isAnyGuardMoving == true  do
        isAnyGuardMoving = false
        for i,g in pairs(self.guards) do
            local bb = g:MoveOneFrame() -- 必须提前算
            isAnyGuardMoving = isAnyGuardMoving or (bb == false) -- "|="
        end
        coroutine.yield(Yielders.EndOfFrame)
    end

    -- guards 善后:
    for i,g in pairs(self.guards) do
        g:EndTheMove(true)
        --g:ResetDanderZones() -- 再设置一遍, 这是避免 deadZone 盖在别的 guard 上面的最简单的方法
    end

    
    -- ===== 检查解谜是否失败 -2- =====:
    -- 若 roleChessman 踩入危险区, 将跳入失败 event, 然后把玩家传入起点重来;
    if self:IsRoleInDanger() == true  then
    
        cs_coroutine.yield_return(self:HandleFailure()) 
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
        self:CheckRoleAndHideBtn()
        return
    end

    self:CheckRoleAndHideBtn()

    -- todo: 判断 角色是否走到终点 outlet;
    -- 如果走到, 跳入 谜题解开的 event;
    if self.roleChessman:IsReachOutlet() == true  then
        self:HandleSolved()
    end
    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end




---@return void
function Puzzle_2:HandleSolved()

    -- 本函数被单独调用时 不需要考虑设置 self.mazeMain.puzzleHanleState, 因为会在第一时间把 所有 功能按钮都关闭, 玩家没法误触

    print( "------ 谜题解开了 !!!!! -------" )

    -- 解谜成功音效
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_unlock )

    -- 将 guards 隐藏起来
    for i,g in pairs(self.guards) do
        g:Hide()
    end
    -- 从结束点, 移动到棋盘外的 2.2, 然后关闭 棋盘, 
    self.mazeMain:HideBubble( self.gearEventKey.id )
    self.roleChessman:SkipToOutletPos()
    self.mazeMain:MoveRoleToTrackNodeGOImmediately( self.roleOutletTrackNodeGO )
    self.mazeMain:AddToCatchedEventKeys( self.solvedEventKey )
    self.isSolved = true
end



---@return void
function Puzzle_2:IsPuzzleBeSolved()
    return self.isSolved
end


---@param savedData string
---@return void
function Puzzle_2:ReadSavedDataToPuzzle( savedData )
    assert( type(savedData) == "string" )
    assert( savedData == "solved" or savedData == "notSolved", "savedData = " .. savedData )

    self.isSolved = (savedData == "solved")
    if self.isSolved then
        self:SkipToFinalState()
    end
end


function Puzzle_2:SkipToFinalState()

end


---@return string
function Puzzle_2:SaveDataFromPuzzle()
    return self.isSolved and "solved" or "notSolved"
end



---@return System.Collections.IEnumerator
function Puzzle_2:HandleFailure()
    print(" !!!!!!! 解谜失败 !!!!!!!")

    -- todo: 最干净的做法, 在这里显示 文本框 交互信息;
    -- 目前被实现到当下方了...
    cs_coroutine.yield_return( self.mazeMain:HandleMazeEvent( self.failureEventKey ) )

    -- 播放音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_guard_lose )

    -- 抖动 role 版:
    cs_coroutine.yield_return( Maze2DUtils.DoShake({ 
        transform = self.mazeMain.uiRole.transform, -- todo 用这个值有点奇怪...
        totalTime = 0.45,
        totalAmplitude = 0.4,
        sinFreq = 75.0,
        peak = 0.3,
    }))
    
    -- 抖动相机版:
    -- cs_coroutine.yield_return( Maze2DUtils.DoShake({ 
    --     transform = self.mazeMain.cameraPivot,
    --     totalTime = 0.55,
    --     totalAmplitude = 0.8,
    --     sinFreq = 75.0,
    --     peak = 0.3,
    -- }))

    -- ----- 播放剧情, 告诉玩家踩到死区了 -----:
    local failureStoryId = 3007350 -- 3007270
    cs_coroutine.yield_return( Maze2DStates.Wait_0D5_Seconds )
    cs_coroutine.yield_return( self.mazeMain:PlayStory( failureStoryId, false ) )
    cs_coroutine.yield_return( Maze2DStates.Wait_0D3_Seconds )


    -- ----- 将 roleChessman 和 guard 归位 -----:

    -- 守卫移动的声音:
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_guard )

    self.roleChessman:BackToInitPos()
    for i,g in pairs(self.guards) do
        g:BackToInitPos()
    end

    -- 执行复原过程:
    -- roleChessman 和 guard 同时归位:
    local isMoving = true -- boolean
    while isMoving == true do
        isMoving = self.roleChessman:MoveOneFrame() == false
        for i,g in pairs(self.guards) do
            local guardRet = g:MoveOneFrame()
            isMoving = isMoving or (guardRet == false)
        end
        self.cameraPivot.position = self.mazeInput:CalcSafetyPos(self.roleChessman.tgtPos)
        coroutine.yield(Yielders.EndOfFrame)
    end

    self.roleChessman:EndTheMove(true)
    for i,g in pairs(self.guards) do
        g:EndTheMove(true)
        --g:Update4DangerZones()
    end
    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end


---@return System.Collections.IEnumerator
function Puzzle_2:HandleReset()

    -- ----- 将 roleChessman 和 guard 归位 -----:
    self.roleChessman:BackToInitPos()

    -- 先让相机对准 role 运动重点, 然后再让 role 瞬移:
    cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(self.roleChessman.tgtPos), {smoothTime = 0.25, maxSpeed = 30.0} ) )
    cs_coroutine.yield_return( Maze2DStates.Wait_0D3_Seconds )

    -- 守卫移动的声音:
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_guard )

    self.roleChessman:EndTheMove(true)
    for i,g in pairs(self.guards) do    
        g:BackToInitPos()
        g:EndTheMove(true)
        --g:Update4DangerZones()
    end

    self:CheckRoleAndHideBtn()

    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end 



---@param tgtIdx UnityEngine.Vector2Int
---@param iSNeedLegal boolean
---@param canPassObstacle boolean
---@return Vector3
function Puzzle_2:CalcNodePos( tgtIdx, iSNeedLegal, canPassObstacle )

    if iSNeedLegal and (self:IsIdxLegal(tgtIdx,canPassObstacle) == false) then
        assert( false, "参数 tgtIdx 不可通行, 出界 或 有障碍物: " .. tgtIdx:ToString())
    end

    local ret = self.pos_00 +   self.moveRightFull * (tgtIdx.x+0.5) / (self.elementNums.x) +
                                self.moveUpFull    * (tgtIdx.y+0.5) / (self.elementNums.y);
    return ret
end 


-- -1-: 是否超出 棋盘格
-- -2-: 是否踩到遮挡物
-- -3-: roleChessman, guard 是否相互重叠
---@param idx UnityEngine.Vector2Int
---@param canPassObstacle boolean
---@return boolean
function Puzzle_2:IsIdxLegal( idx, canPassObstacle )

    if self:IsIdxInBounds(idx) == false  then
        return false -- 棋盘格出界
    end

    print( "idx = " .. tostring(idx.x) .. ", " .. tostring(idx.y) )

    local x = idx.x 
    local y = idx.y 
    assert( type(x) == "number" )
    assert( type(y) == "number" )

    --local registeredVal = self.obstacles.y.x -- int
    --assert( type(registeredVal) == "number" )
    
    local registeredVal = self.gridCells[idx.y][idx.x].obstacle -- int
    if     registeredVal >= 0  -- 碰到了 guard
        or ( canPassObstacle == false and registeredVal == self.OBSTACLE_STATIC ) -- guard 碰到了 "障碍物"
    then
        return false
    end

    return true
end


-- ret: true 表示在棋盘内
---@param idx UnityEngine.Vector2Int
---@return boolean
function Puzzle_2:IsIdxInBounds( idx )
    return ( idx.x >= 0 and idx.x < self.elementNums.x and idx.y >= 0 and idx.y < self.elementNums.y )
end


-- 目标位置上是否存在 guard
---@param idx UnityEngine.Vector2Int
---@return boolean
function Puzzle_2:IsCollideAnyGuard( idx )

    local ret = false -- boolean
    for i,g in pairs(self.guards) do
        ret = ret or (idx == g.currentIdx)
    end
    return ret
end



---@return boolean
function Puzzle_2:IsRoleInDanger()

    -- 如果 roleChessman 踩到 "遮挡物" 上, 此时可与 guard 相邻:
    if self.gridCells[self.roleChessman.currentIdx.y][self.roleChessman.currentIdx.x].obstacle == self.OBSTACLE_STATIC  then
        return false
    end

    for i,g in pairs(self.guards) do
        local offset = self.roleChessman.currentIdx - g.currentIdx -- Vector2Int
        if (math.abs(offset.x) + math.abs(offset.y)) <= 1  then
            return true
        end
    end
    
    return false
end



return Puzzle_2
