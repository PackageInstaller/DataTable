---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28


-- 迷宫1 章节1; 啥也不干, 仅仅关掉所有 按钮...

---@class Puzzle_103
---@field statue_1             UnityEngine.Transform
---@field statue_2             UnityEngine.Transform
---@field statue_3             UnityEngine.Transform
---@field statue_4             UnityEngine.Transform
---@field resetPosTF             UnityEngine.Transform
local Puzzle_103 = Class('Puzzle_103')



-- ===========================
local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders


local EventKey = import('Game.Behaviours.Maze.EventKey')
local GearStatue = import('Game.Behaviours.Maze.Puzzle_103_GearStatue')
local StatueState = GearStatue.GetTableStatueState()
local MazeMain   = import('Game.Behaviours.Maze.MazeMain')

---@type MazeMainUI
local MazeMainUI = import('Game.Behaviours.Maze.MazeMainUI')

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')

---@type Maze2DSounds
local Maze2DSounds = import('Game.Behaviours.Maze.Maze2DSounds'):GetInstance()

--- funtoy:
local KTool = CS.Engine.Lib.KTool

local Button = CS.UnityEngine.UI.Button
local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3

-- ========================================================


local gear_1_KeyStr = "8.1-gear"
local gear_2_KeyStr = "8.2-gear"
local gear_3_KeyStr = "8.3-gear"
local gear_4_KeyStr = "8.4-gear"



local tableHeightOffset = 1.0 -- up 和 down 状态间 垂直间距




function Puzzle_103:__init()
    --print("   ~~~~~~~ Puzzle_103:__init() ~~~~~~~")
end


function Puzzle_103:__delete()
    --print("   ~~~~~~~ Puzzle_103:__delete() ~~~~~~~")
    self.gear_3_Key = nil 
    self.gear_4_Key = nil 
    self.gear_5_Key = nil 
    self.gearTables = nil 
    self.mazeMain = nil
    self.currentEventKey = nil
    self.isSolved = nil
end


function Puzzle_103:OnDestroy()

    Maze2DStates.ClearUIFunctions()

    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象

    if self.co_1 then
        cs_coroutine.stop(self.co_1)
        self.co_1 = nil
    end
    self:Delete()    
    --print("   ~~~~~~~ Puzzle_103:OnDestroy(): End ~~~~~~~")
end


-- =============================================================== Self -> ================================================================== -- 



---@param mazeMain_ MazeMain
---@return void
function Puzzle_103:SelfInit( mazeMain_ )

    assert( 
        self.statue_1 and self.statue_2 and self.statue_3 and self.statue_4 and self.resetPosTF
    )

    self.mazeMain = mazeMain_ -- 本 calss 和 mazeMain 紧密相连;

    self.mazeInput = mazeMain_.mazeInput
    self.cameraPivot = mazeMain_.cameraPivot
    self.currentEventKey = nil -- EventKey - role 不在某个 gear 节点上时, 此值为 null;
    self.isSolved = false

    -- btn.onClick:AddListener()
    Maze2DStates.WhenPushBtns.Rotate1 = Bind(self,self.WhenPushBtnRotate1)
    Maze2DStates.WhenPushBtns.Rotate2 = Bind(self,self.WhenPushBtnRotate2)
    Maze2DStates.WhenPushBtns.Dismantle = Bind(self,self.WhenPushBtnDismantle)
    Maze2DStates.WhenPushBtns.Reset = Bind(self,self.WhenPushBtnReset)
    Maze2DStates.BindAllBtnFuncs()

    self.gear_1_Key =  EventKey.New({keyStr=gear_1_KeyStr})
    self.gear_2_Key =  EventKey.New({keyStr=gear_2_KeyStr})
    self.gear_3_Key =  EventKey.New({keyStr=gear_3_KeyStr})
    self.gear_4_Key =  EventKey.New({keyStr=gear_4_KeyStr})

    -- 4张 table 的初始状态:
    self.gearStatues = {} -- Dictionary<EventKey.keyStr, GearStatue>
    self.gearStatues[self.gear_1_Key.keyStr] = GearStatue.New( self.statue_1, StatueState.Up )
    self.gearStatues[self.gear_2_Key.keyStr] = GearStatue.New( self.statue_2, StatueState.Left)
    self.gearStatues[self.gear_3_Key.keyStr] = GearStatue.New( self.statue_3, StatueState.Up )
    self.gearStatues[self.gear_4_Key.keyStr] = GearStatue.New( self.statue_4, StatueState.Left )
end

    


---@return void
function Puzzle_103:WhenPushBtnRotate1()
    --if Maze2DStates.isInAutoControl <= 0 and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        -- todo: 只是检测而已, 可被省略...
        assert( not isNull(self.currentEventKey) ) 
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Rotate1)
        self:PrepareForNewRotate( true )
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.FirstFrame
    end
end



---@return void
function Puzzle_103:WhenPushBtnRotate2()

    --if Maze2DStates.isInAutoControl <= 0 and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        -- todo: 只是检测而已, 可被省略...
        assert( not isNull(self.currentEventKey) ) 
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Rotate2)
        self:PrepareForNewRotate( false )
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.FirstFrame
    end

end



---@return void
function Puzzle_103:WhenPushBtnDismantle()
    print("按下 skip 按钮")
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        -- 在一帧内就能完成, 就不设置状态了
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Dismantle)
        self.co = cs_coroutine.start( self.PlaySounds, self, 4 )
        self:SkipToFinalState();
        self:HandleSolved();
    end
end


---@return void
function Puzzle_103:WhenPushBtnReset()
    print("按下 reset 按钮")
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Handling
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Reset)
        self.co_1 = cs_coroutine.start(self.HandleReset, self)
    end
end


-- 谜题的 核心部分:
-- 1雕像 和 2,3,4 联动;
-- 2雕像 和 3,4 联动;
-- 3雕像 和 4 联动;
---@param isTurnLeft boolean
---@return void
function Puzzle_103:PrepareForNewRotate( isTurnLeft )

    if      EventKey.IsSame(self.currentEventKey, self.gear_1_Key) then 

        self.gearStatues[self.gear_1_Key.keyStr]:PrepareForNewRotate(isTurnLeft)
        self.gearStatues[self.gear_2_Key.keyStr]:PrepareForNewRotate(isTurnLeft)
        self.gearStatues[self.gear_3_Key.keyStr]:PrepareForNewRotate(isTurnLeft)
        self.gearStatues[self.gear_4_Key.keyStr]:PrepareForNewRotate(isTurnLeft)

        self.co = cs_coroutine.start( self.PlaySounds, self, 4 )

    elseif EventKey.IsSame(self.currentEventKey, self.gear_2_Key) then

        self.gearStatues[self.gear_2_Key.keyStr]:PrepareForNewRotate(isTurnLeft)
        self.gearStatues[self.gear_3_Key.keyStr]:PrepareForNewRotate(isTurnLeft)
        self.gearStatues[self.gear_4_Key.keyStr]:PrepareForNewRotate(isTurnLeft)

        self.co = cs_coroutine.start( self.PlaySounds, self, 3 )

    elseif EventKey.IsSame(self.currentEventKey, self.gear_3_Key) then

        self.gearStatues[self.gear_3_Key.keyStr]:PrepareForNewRotate(isTurnLeft)
        self.gearStatues[self.gear_4_Key.keyStr]:PrepareForNewRotate(isTurnLeft)

        self.co = cs_coroutine.start( self.PlaySounds, self, 2 )

    elseif EventKey.IsSame(self.currentEventKey, self.gear_4_Key) then

        self.gearStatues[self.gear_4_Key.keyStr]:PrepareForNewRotate(isTurnLeft)

        self.co = cs_coroutine.start( self.PlaySounds, self, 1 )

    else 
        assert(false, "currentEventKey 存在问题... " .. self.currentEventKey.keyStr )
    end
end


function Puzzle_103:PlaySounds( num_ )
    -- 模仿数个桌子依次沉降
    for i=1, num_ do
        Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_lion )
        cs_coroutine.yield_return( Maze2DStates.Wait_0D08_Seconds )
    end
end



---@param eventKey EventKey
---@return void
function Puzzle_103:WhenEnterGear( eventKey )

    print( "Puzzle_103: currentEventKey = " .. 
        ( self.currentEventKey == nil and "nil" or self.currentEventKey.keyStr) .. 
        "; new eventKey = " .. eventKey.keyStr 
    )
    assert( EventKey.CheckType(eventKey) )

    if self.isSolved then
        return
    end 
    if EventKey.IsSame(self.currentEventKey,eventKey) == false  then
        print("WhenEnterGear")

        -- 只能按下对应的按钮:
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Rotate1, true ) -- 统统打开
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Rotate2, true )
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, true )
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Reset, true )

        self.currentEventKey = eventKey
    end
end




---@return void
function Puzzle_103:WhenLeaveGear()
    print( "-1- WhenLeaveGear() currentEventKey = " .. (isNull(self.currentEventKey) and "null" or self.currentEventKey.keyStr) )

    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Rotate1, false ) -- 统统关闭
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Rotate2, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Reset, false )

    self.currentEventKey = nil
end






---@return System.Collections.IEnumerator
function Puzzle_103:HandlePuzzle()

    -- ----- 旋转所有雕像 -----:
    local isAnyRotating = true
    while isAnyRotating == true  do
    
        isAnyRotating = false;

        for i,gStatue in pairs(self.gearStatues) do
            local ret = gStatue:RotateOneFrame() -- 必须提前算
            isAnyRotating = isAnyRotating or (ret == false) -- "|=""
        end
        coroutine.yield(Yielders.EndOfFrame)
    end

    for i,gStatue in pairs(self.gearStatues) do
        gStatue:EndTheRotate()
    end

    -- ----- 无需更新 按钮状态 -----:
    assert( not isNull( self.currentEventKey ) )

    -- ---- 每次状态变化, 都要主动检查下, 谜底是否被解开, 若解开了, 则要强制去播放 解谜后的 事件 ----:
    if self:IsBeSolved()  then
        self:HandleSolved()
    end
    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end





---@return void
function Puzzle_103:HandleSolved()

    print( "------ 谜题解开了 !!!!! -------" )

    -- 解谜成功音效
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_unlock )
    
    -- todo: 删除掉原来的 4个 gear bubble;
    self.mazeMain:HideBubble( self.gear_1_Key.id )
    self.mazeMain:HideBubble( self.gear_2_Key.id )
    self.mazeMain:HideBubble( self.gear_3_Key.id )
    self.mazeMain:HideBubble( self.gear_4_Key.id )
    -- 点亮 8.5 宝箱;
    self.mazeMain:AddToCatchedEventKeys( EventKey.New({keyStr="8.5-solved"}) ) -- todo: 这个 key 不要写在这里... 要走配表 !!!!
    self.isSolved = true
end



---@return System.Collections.IEnumerator
function Puzzle_103:HandleReset()
    cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(self.resetPosTF.position), {smoothTime = 0.25, maxSpeed = 30.0} ) )
    cs_coroutine.yield_return( Maze2DStates.Wait_0D3_Seconds )
    for i,gearStatue in pairs(self.gearStatues) do 
        gearStatue:ResetToInit()
    end

    self.co = cs_coroutine.start( self.PlaySounds, self, 4 )

    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end



---@return void
function Puzzle_103:IsPuzzleBeSolved()
    return self.isSolved
end


---@param savedData string
---@return void
function Puzzle_103:ReadSavedDataToPuzzle( savedData )
    assert( type(savedData) == "string" )
    assert( savedData == "solved" or savedData == "notSolved", "savedData = " .. savedData )

    self.isSolved = (savedData == "solved")
    if self.isSolved then
        self:SkipToFinalState()
    end
end



---@return string
function Puzzle_103:SaveDataFromPuzzle()
    return self.isSolved and "solved" or "notSolved"
end


-- 让谜题直接瞬变为 最终完成状态
---@return string
function Puzzle_103:SkipToFinalState()

    self.gearStatues[self.gear_1_Key.keyStr]:SkipToTargetState( StatueState.Down )
    self.gearStatues[self.gear_2_Key.keyStr]:SkipToTargetState( StatueState.Left )
    self.gearStatues[self.gear_3_Key.keyStr]:SkipToTargetState( StatueState.Up )
    self.gearStatues[self.gear_4_Key.keyStr]:SkipToTargetState( StatueState.Right )
end


-- 三张桌子 全部 down 了, 谜题就解开了;
---@return boolean
function Puzzle_103:IsBeSolved()
    return 
    (
            self.gearStatues[self.gear_1_Key.keyStr].currentState == StatueState.Down
        and self.gearStatues[self.gear_2_Key.keyStr].currentState == StatueState.Left
        and self.gearStatues[self.gear_3_Key.keyStr].currentState == StatueState.Up
        and self.gearStatues[self.gear_4_Key.keyStr].currentState == StatueState.Right
    )
end


---@param customJobTagWhenAfter string
---@return System.Collections.IEnumerator
function Puzzle_103:CustomJobWhenAfter( customJobTagWhenAfter ) 
    local tag = string.lower(customJobTagWhenAfter)
    if tag == string.lower("showStates") then 
        
        print( "点亮 4 个雕塑" )
        KTool.SetActive( self.statue_1.gameObject, true )
        KTool.SetActive( self.statue_2.gameObject, true )
        KTool.SetActive( self.statue_3.gameObject, true )
        KTool.SetActive( self.statue_4.gameObject, true )

    else
        assert( false, "配表 customJobTagWhenAfter 出错: " .. customJobTagWhenAfter )
    end
end



return Puzzle_103
