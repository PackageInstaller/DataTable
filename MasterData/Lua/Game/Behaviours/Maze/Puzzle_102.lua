---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28


-- 迷宫1 章节1; 啥也不干, 仅仅关掉所有 按钮...

---@class Puzzle_102
---@field table_3             UnityEngine.Transform
---@field table_4             UnityEngine.Transform
---@field table_5             UnityEngine.Transform
---@field resetPosTF             UnityEngine.Transform
local Puzzle_102 = Class('Puzzle_102')



local Button = CS.UnityEngine.UI.Button
local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3


local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders


local EventKey = import('Game.Behaviours.Maze.EventKey')
local GearTable = import('Game.Behaviours.Maze.Puzzle_102_GearTable')
local TableState = GearTable.GetTableState()
local MazeMain   = import('Game.Behaviours.Maze.MazeMain')

---@type Engine.Lib.KCookie
local KCookie          = CS.Engine.Lib.KCookie

---@type MazeMainUI
local MazeMainUI = import('Game.Behaviours.Maze.MazeMainUI')

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')

---@type Maze2DSounds
local Maze2DSounds = import('Game.Behaviours.Maze.Maze2DSounds'):GetInstance()

-- ========================================================


local gear_3_KeyStr = "3-gear"
local gear_4_KeyStr = "4-gear"
local gear_5_KeyStr = "5-gear"
local tableHeightOffset = 0.33 -- up 和 down 状态间 垂直间距




function Puzzle_102:__init()
end


function Puzzle_102:__delete()
    self.gear_3_Key = nil 
    self.gear_4_Key = nil 
    self.gear_5_Key = nil 
    self.gearTables = nil 
    self.mazeMain = nil
    self.currentEventKey = nil
    self.isSolved = nil
    self.cameraPivot = nil
end


function Puzzle_102:OnDestroy()

    Maze2DStates.ClearUIFunctions()

    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象

    if self.co_1 then
        cs_coroutine.stop(self.co_1)
        self.co_1 = nil
    end
    if self.co_2 then
        cs_coroutine.stop(self.co_2)
        self.co_2 = nil
    end
    self:Delete()    
    --print("   ~~~~~~~ Puzzle_102:OnDestroy(): End ~~~~~~~")
end


-- =============================================================== Self -> ================================================================== -- 




---@param mazeMain_ MazeMain
---@return void
function Puzzle_102:SelfInit( mazeMain_ )

    assert( 
            self.table_3 and self.table_4 and self.table_5
            and self.resetPosTF
    )

    self.mazeMain = mazeMain_ -- 本 calss 和 mazeMain 紧密相连;


    self.mazeInput = mazeMain_.mazeInput
    self.cameraPivot = mazeMain_.cameraPivot
    self.currentEventKey = nil -- EventKey - role 不在某个 gear 节点上时, 此值为 null;
    self.isSolved = false

    -- btn.onClick:AddListener()
    Maze2DStates.WhenPushBtns.Up        = Bind(self,self.WhenPushBtnUp)
    Maze2DStates.WhenPushBtns.Down      = Bind(self,self.WhenPushBtnDown)
    Maze2DStates.WhenPushBtns.Dismantle = Bind(self,self.WhenPushBtnDismantle)
    Maze2DStates.WhenPushBtns.Reset     = Bind(self,self.WhenPushBtnReset)
    Maze2DStates.BindAllBtnFuncs()

    self.isBtnDownShow = true

    self.gear_3_Key =  EventKey.New({keyStr=gear_3_KeyStr})
    self.gear_4_Key =  EventKey.New({keyStr=gear_4_KeyStr})
    self.gear_5_Key =  EventKey.New({keyStr=gear_5_KeyStr})

    -- 三张 table 的初始状态:
    self.gearTables = {} -- Dictionary<EventKey.keyStr, GearTable>
    self.gearTables[self.gear_3_Key.keyStr] = GearTable.New( self.table_3.transform, TableState.Up,      tableHeightOffset )
    self.gearTables[self.gear_4_Key.keyStr] = GearTable.New( self.table_4.transform, TableState.Down,    tableHeightOffset )
    self.gearTables[self.gear_5_Key.keyStr] = GearTable.New( self.table_5.transform, TableState.Up,      tableHeightOffset )
end



---@return void
function Puzzle_102:WhenPushBtnUp()

    --if Maze2DStates.isInAutoControl <= 0 and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle and self.isBtnDownShow == false then
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle and self.isBtnDownShow == false then
    
        -- todo: 只是检测而已, 可被省略...
        assert( not isNull(self.currentEventKey) ) 
        local gearTable = self.gearTables[self.currentEventKey.keyStr]
        assert( not isNull(gearTable) )
        --assert( gearTable.currentState == TableState.Down )
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Up)
        if gearTable.currentState == TableState.Down then
            self:PrepareForNewMove();
            self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.FirstFrame
        end
    end
end


---@return void
function Puzzle_102:WhenPushBtnDown()

    --if Maze2DStates.isInAutoControl <= 0 and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle and self.isBtnDownShow == true  then
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle and self.isBtnDownShow == true  then
    
        -- todo: 只是检测而已, 可被省略...
        assert( not isNull(self.currentEventKey) ) 
        local gearTable = self.gearTables[self.currentEventKey.keyStr]
        assert( not isNull(gearTable) )
        --assert( gearTable.currentState == TableState.Up )
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Down)
        if gearTable.currentState == TableState.Up then
            self:PrepareForNewMove();
            self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.FirstFrame
        end
    end
end



---@return void
function Puzzle_102:WhenPushBtnDismantle()
    print("按下 skip 按钮")
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        -- 在一帧内就能完成, 就不设置状态了
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Dismantle)
        self.co_2 = cs_coroutine.start( self.PlaySounds, self, 3 )
        self:SkipToFinalState();
        self:HandleSolved();
    end
end


---@return void
function Puzzle_102:WhenPushBtnReset()
    print("按下 reset 按钮")

    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle and isNotNull(self.currentEventKey) then
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Handling
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Reset)
        self.co_1 = cs_coroutine.start(self.HandleReset, self)
    end
end



-- 要么只能 "上", 要么只能 "下"
---@param state TableState_
---@return void 
function Puzzle_102:CheckBtnShowOrHide( state )
    self.isBtnDownShow = (state == TableState.Up)
    MazeMainUI.GetCurrentInstance():PlayBtnHideOrShowAnimation(Maze2DStates.Btns.Up,      not self.isBtnDownShow)
    MazeMainUI.GetCurrentInstance():PlayBtnHideOrShowAnimation(Maze2DStates.Btns.Down,    self.isBtnDownShow)
end




-- 谜题的 核心部分:
-- 3桌 和 4,5 联动;
-- 4桌 和 5 联动;
---@return void
function Puzzle_102:PrepareForNewMove()

    if      EventKey.IsSame(self.currentEventKey, self.gear_3_Key) then 
        self.gearTables[self.gear_3_Key.keyStr]:PrepareForNewMove()
        self.gearTables[self.gear_4_Key.keyStr]:PrepareForNewMove()
        self.gearTables[self.gear_5_Key.keyStr]:PrepareForNewMove()

        self.co_2 = cs_coroutine.start( self.PlaySounds, self, 3 )

    elseif EventKey.IsSame(self.currentEventKey, self.gear_4_Key) then
        self.gearTables[self.gear_4_Key.keyStr]:PrepareForNewMove()
        self.gearTables[self.gear_5_Key.keyStr]:PrepareForNewMove()

        self.co_2 = cs_coroutine.start( self.PlaySounds, self, 2 )

    elseif EventKey.IsSame(self.currentEventKey, self.gear_5_Key) then
        self.gearTables[self.gear_5_Key.keyStr]:PrepareForNewMove()

        self.co_2 = cs_coroutine.start( self.PlaySounds, self, 1 )

    else 
        assert(false, "currentEventKey 存在问题... " .. self.currentEventKey.keyStr )
    end
end



function Puzzle_102:PlaySounds( num_ )
    -- 模仿数个桌子依次沉降
    for i=1, num_ do
        Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_table )
        cs_coroutine.yield_return( Maze2DStates.Wait_0D08_Seconds )
    end
end



---@param eventKey EventKey
---@return void
function Puzzle_102:WhenEnterGear( eventKey )

    print( "eventKey = " .. eventKey.keyStr )
    assert( EventKey.CheckType(eventKey) )
    

    if self.isSolved then
        return
    end 
    if EventKey.IsSame(self.currentEventKey,eventKey) == false  then
        print("WhenEnterGear")
        
        local state = self.gearTables[eventKey.keyStr].currentState

        -- 只能按下对应的按钮:
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Up, true )
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Down, true )

        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, true )
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Reset, true )

        -- "up" 和 "down" 两个按钮 只能显示一个
        self:CheckBtnShowOrHide(state)

        self.currentEventKey = eventKey
    end
end



---@return void
function Puzzle_102:WhenLeaveGear()
    print( "-1- WhenLeaveGear() currentEventKey = " .. (isNull(self.currentEventKey) and "null" or self.currentEventKey.keyStr) )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Up, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Down, false )

    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Reset, false )

    self.currentEventKey = nil
end




---@return System.Collections.IEnumerator
function Puzzle_102:HandlePuzzle()

    -- ----- 升降所有桌子 -----:
    local isAnyMoving = true -- boolean
    while isAnyMoving == true do
        isAnyMoving = false

        for i,gearTable in pairs(self.gearTables) do
            local ret = gearTable:MoveOneFrame() -- 必须提前算
            isAnyMoving = isAnyMoving or (ret == false) -- "|=""
        end
        coroutine.yield(Yielders.EndOfFrame)
    end

    for i,gearTable in pairs(self.gearTables) do
        gearTable:EndTheMove()
    end

    -- ----- 及时更新 按钮状态 -----:
    assert( not isNull(self.currentEventKey) )

    local gearTable = self.gearTables[self.currentEventKey.keyStr]; -- GearTable
    self:CheckBtnShowOrHide(gearTable.currentState)

    -- ---- 每次状态变化, 都要主动检查下, 谜底是否被解开, 若解开了, 则要强制去播放 解谜后的 事件 ----:
    if self:IsBeSolved()  then
        self:HandleSolved()
    end
    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end




---@return void
function Puzzle_102:HandleSolved()

    print( "------ 谜题解开了 !!!!! -------" )

    -- 解谜成功音效
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_unlock )

    -- todo: 删除掉原来的 3个 gear bubble;
    self.mazeMain:HideBubble( self.gear_3_Key.id )
    self.mazeMain:HideBubble( self.gear_4_Key.id )
    self.mazeMain:HideBubble( self.gear_5_Key.id )
    -- 点亮 2-down 房间, 点亮 3 个宝箱;
    self.mazeMain:AddToCatchedEventKeys( EventKey.New({keyStr="2.4-solved"}) ) -- todo: 这个 key 不要写在这里... 要走配表 !!!!
    self.isSolved = true
end


---@return System.Collections.IEnumerator
function Puzzle_102:HandleReset()
    cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(self.resetPosTF.position), {smoothTime = 0.25, maxSpeed = 30.0} ) )
    cs_coroutine.yield_return( Maze2DStates.Wait_0D3_Seconds )
    for i,gearTable in pairs(self.gearTables) do 
        gearTable:ResetToInit()
    end

    self.co_2 = cs_coroutine.start( self.PlaySounds, self, 3 )

    local gearTable = self.gearTables[self.currentEventKey.keyStr]; -- GearTable
    self:CheckBtnShowOrHide(gearTable.currentState)

    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end


---@return void
function Puzzle_102:IsPuzzleBeSolved()
    return self.isSolved
end


---@param savedData string
---@return void
function Puzzle_102:ReadSavedDataToPuzzle( savedData )
    assert( type(savedData) == "string" )
    assert( savedData == "solved" or savedData == "notSolved", "savedData = " .. savedData )

    self.isSolved = (savedData == "solved")
    if self.isSolved then
        self:SkipToFinalState()
    end
end


---@return string
function Puzzle_102:SaveDataFromPuzzle()
    return self.isSolved and "solved" or "notSolved"
end


-- 让谜题直接瞬变为 最终完成状态
---@return string
function Puzzle_102:SkipToFinalState()
    self.gearTables[self.gear_3_Key.keyStr]:SkipToDown()
    self.gearTables[self.gear_4_Key.keyStr]:SkipToDown()
    self.gearTables[self.gear_5_Key.keyStr]:SkipToDown()
end


-- 三张桌子 全部 down 了, 谜题就解开了;
---@return boolean
function Puzzle_102:IsBeSolved()
    for i,gearTable in pairs(self.gearTables) do
        if gearTable.currentState == TableState.Up then
            return false
        end
    end
    return true
end





return Puzzle_102
