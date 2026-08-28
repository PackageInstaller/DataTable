---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28


-- !!!! todo: 由于使用了 spriteRenderer, 渲染层次的控制不再依赖 深度值, 而是 order in layer; 此功能目前尚未实现


---@class Puzzle_3
---@field anchor_up               UnityEngine.Transform
---@field anchor_down             UnityEngine.Transform
---@field anchor_left             UnityEngine.Transform
---@field anchor_right            UnityEngine.Transform
---@field gearVCameraPos_12       UnityEngine.Transform
---@field gearVCameraPos_13       UnityEngine.Transform
---@field gearVCameraPos_14       UnityEngine.Transform
---@field gearVCameraPos_15       UnityEngine.Transform
---@field look_laser_red          UnityEngine.Transform
---@field look_laser_green        UnityEngine.Transform
---@field look_laser_blue         UnityEngine.Transform
---@field laserMeshRenderer_red       UnityEngine.Renderer -- todo: 临时物, 未来替换
---@field laserMeshRenderer_green     UnityEngine.Renderer -- todo: 临时物, 未来替换
---@field laserMeshRenderer_blue      UnityEngine.Renderer -- todo: 临时物, 未来替换
---@field rubiksParent            UnityEngine.Transform -- 魔方方块 parent
---@field resetPosTF            UnityEngine.Transform
local Puzzle_3 = Class('Puzzle_3')


---@type SettingMgr
local settingMgr = SettingMgr:GetInstance()



local Object = CS.UnityEngine.Object
local Button = CS.UnityEngine.UI.Button
local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3
local Vector2Int = CS.UnityEngine.Vector2Int
--local MeshRenderer = CS.UnityEngine.MeshRenderer
local SpriteRenderer = CS.UnityEngine.SpriteRenderer
local Quaternion = CS.UnityEngine.Quaternion
local Renderer = CS.UnityEngine.Renderer



local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders
local LuaBehaviour = CS.Engine.Modules.LuaBehaviour


local EventKey = import('Game.Behaviours.Maze.EventKey')
local RubikEntity = import('Game.Behaviours.Maze.Puzzle_3_RubikEntity')
local ChildPuzzle = import('Game.Behaviours.Maze.Puzzle_3_ChildPuzzle')
local HandleMazeTableFile = import('Game.Behaviours.Maze.HandleMazeTableFile')
local EventData = import('Game.Behaviours.Maze.EventData')
local MazeMain    = import('Game.Behaviours.Maze.MazeMain')

---@type MazeMainUI
local MazeMainUI = import('Game.Behaviours.Maze.MazeMainUI')

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')

---@type Maze2DSounds
local Maze2DSounds = import('Game.Behaviours.Maze.Maze2DSounds'):GetInstance()

--- funtoy:
local KTool = CS.Engine.Lib.KTool
local IDComp = CS.Game.Native.Common.ID


-- ========================================================


local gear_12_KeyStr = "1.2-gear"
local gear_13_KeyStr = "1.3-gear"
local gear_14_KeyStr = "1.4-gear"
local gear_15_KeyStr = "1.5-gear"

local EDGE_NUM = 3 -- int 单边 3 元素;

-- ========================================================

function Puzzle_3:__init()
    --print("   ~~~~~~~ Puzzle_3:__init() ~~~~~~~")

    self.isOpenHighLight = false -- 只有 302 会开启
end


function Puzzle_3:__delete()
    --print("   ~~~~~~~ Puzzle_3:__delete() ~~~~~~~")
  
    self.mazeMain = nil
    self.currentEventKey = nil
    self.isSolved = nil
end

function Puzzle_3:OnDestroy()

    Maze2DStates.ClearUIFunctions()
    
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象

    if self.co_1 then
        cs_coroutine.stop(self.co_1)
        self.co_1 = nil
    end
    self:Delete()    
    --print("   ~~~~~~~ Puzzle_3:OnDestroy(): End ~~~~~~~")
end


-- =============================================================== Self -> ================================================================== -- 


---@param mazeMain_ MazeMain
---@param handleMazeTableFile_ HandleMazeTableFile
---@param mazeChapter_ string
---@return void
function Puzzle_3:SelfInit( 
    mazeMain_,
    handleMazeTableFile_,
    mazeChapter_
)

    assert( 
        self.anchor_up and self.anchor_down and self.anchor_left and self.anchor_right
        and self.rubiksParent
        and self.laserMeshRenderer_red and self.laserMeshRenderer_green and self.laserMeshRenderer_blue
        and self.resetPosTF
    )

    assert( self.gearVCameraPos_12 and self.gearVCameraPos_13 and self.gearVCameraPos_14 and self.gearVCameraPos_15 )
    assert( self.look_laser_red and self.look_laser_green and self.look_laser_blue )


    -- ================================== 直接读取配表 ===============================================:

    local initLayout_  = nil -- int[] table
    local finalLayout_ = nil -- int[] table
    local teachingPuzzles_ = {} -- Dic<string,Puzzle_3.ChildPuzzle>
    local childPuzzles_ = {} -- List<ChildPuzzle> table
    local allSolvedEventKey_ = nil -- EventKey


    local tableFile = settingMgr:Get(AutoIds.IdSetting3004) -- TableFile,  迷宫3配置表 

    -- 找到目标行
    local length = tableFile:GetRowCount()
    for i=1,length do -- (实际从表格第 5 行开始读)
        local row = tableFile:GetRow(i) -- TableFileRow

        local chapterInfo = string.lower( row:Get("group") )
        if chapterInfo ~= mazeChapter_  then
            goto continue
        end

        local rowType  = row:Get("rowType") -- string
        if rowType == "BaseInfo" then
          
            initLayout_ = HandleMazeTableFile.String_2_InitLayout( row:Get("initLayout") )
            finalLayout_ = HandleMazeTableFile.String_2_InitLayout( row:Get("finalLayout") )
        
        elseif (rowType == "TeachingPuzzle") or (rowType == "ChildPuzzle") then

            local solvedLayout = { -1,-1,-1, -1,-1,-1, -1,-1,-1 } -- 9 个 -1

            local solvedLayoutStrs = string.split( string.lower(row:Get("solvedLayout")), ';' ) -- string[] table
            assert( #solvedLayoutStrs > 0 )
            for i,s in pairs(solvedLayoutStrs) do
            
                local pair = string.split( s, '=' ) -- string[] table

                local idx = HandleMazeTableFile.StringToCheckerboardIdx( pair[1] ) -- Vector2Int
                local id = idx.y * EDGE_NUM + idx.x -- int
                solvedLayout[id+1] = tonumber( pair[2] )
            end

            -- ---:
            local solvedEventKeyStr = string.lower(row:Get("solvedEventKey")) -- string
            local solvedEventKey = ( (solvedEventKeyStr == "") and nil or EventKey.New({keyStr=solvedEventKeyStr}) ) -- EventKey, 允许为 null
            -- ---:
            if rowType == "TeachingPuzzle"  then
            
                -- 教学谜题 必须指定对应的 事件
                local str = string.lower(row:Get("eventKey")) -- string
                assert( str ~= "" )
                local k = EventKey.New({keyStr=str}) -- EventKey
                assert( isNull( teachingPuzzles_[k.keyStr] ) )
                teachingPuzzles_[k.keyStr] = ChildPuzzle.New( solvedLayout, solvedEventKey )
            else 
                table.insert( childPuzzles_, ChildPuzzle.New(solvedLayout, solvedEventKey)  )
            end

        elseif ( rowType == "AllSolved" ) then
            assert( allSolvedEventKey_ == nil ) --  只允许被初始化一次
            allSolvedEventKey_ = EventKey.New({ keyStr=string.lower(row:Get("solvedEventKey")) })

        else 
            assert(false, "rowType 数据异常: " .. rowType)
        end
        :: continue ::
    end 

    -- ----- check -----:
    assert( initLayout_ ~= nil )

    -- ================================== 依据读取的配表数据 初始化本实例 ===============================================:

    self.mazeMain = mazeMain_

    -- btn.onClick:AddListener()
    Maze2DStates.WhenPushBtns.Left      = Bind(self,self.WhenPushBtnLeft)
    Maze2DStates.WhenPushBtns.Right     = Bind(self,self.WhenPushBtnRight)
    Maze2DStates.WhenPushBtns.Dismantle = Bind(self,self.WhenPushBtnDismantle)
    Maze2DStates.WhenPushBtns.Reset     = Bind(self,self.WhenPushBtnReset)
    Maze2DStates.BindAllBtnFuncs()
    
    self.mazeInput = mazeMain_.mazeInput
    self.handleMazeTableFile = handleMazeTableFile_ -- HandleMazeTableFile
    self.cameraPivot = self.mazeMain.cameraPivot -- Transform
    self.mazeChapter = mazeChapter_ -- string

    self.pos_00 = self.anchor_left.position -- Vector3
    local pos_10 = self.anchor_down.position
    local pos_01 = self.anchor_up.position
    self.moveUpFull      = pos_01 - self.pos_00
    self.moveRightFull   = pos_10 - self.pos_00

    self.gear_12_Key = EventKey.New({keyStr=gear_12_KeyStr})
    self.gear_13_Key = EventKey.New({keyStr=gear_13_KeyStr})
    self.gear_14_Key = EventKey.New({keyStr=gear_14_KeyStr})
    self.gear_15_Key = EventKey.New({keyStr=gear_15_KeyStr})

    self.isOpenHighLight = self.mazeChapter == "302"

    -- ----- 初始化 rubikEntitys, 固定的开场布置 ------:
    self.rubikEntityDict = {} -- Dictionary<int,RubikEntity>  key: RubikEntity.id

    local idComps = self.rubiksParent.gameObject:GetComponentsInChildren(typeof(IDComp),true) -- 包含自己 Array 
    for i=0, idComps.Length-1 do 
        local idComp = idComps[i]
        if idComp.stringId == RubikEntity.GetClassID() then
            self.rubikEntityDict[idComp.id] = RubikEntity.New(idComp)
        end
    end

    assert( table.count(self.rubikEntityDict) == 8 )

    self.initLayout = initLayout_ -- int[] 游戏初始状态
    self.finalLayout = finalLayout_ -- int[]  玩家打算跳过解谜时, 直接使用的 魔方布局;

    -- 读取 initLayout_ 中数据, 组装起 rubikEntitys:
    self.rubikEntitys = {  1,1,1,  1,1,1,  1,1,1 } -- RubikEntity[] table, 3x3 魔方盘面, 先随便塞一个元素进去
    self:SetToTgtLayout( self.initLayout )

    -- ------ solvedLayout ------:
    self.teachingPuzzles = teachingPuzzles_ -- Dictionary<EventKey.keyStr,ChildPuzzle>  剧情关联的解谜, 多出现在教学部分; key: gearCondition
    self.childPuzzles = childPuzzles_ -- List<ChildPuzzle>  主体谜题涉及的所有 子谜题
    self.allSolvedEventKey = allSolvedEventKey_ -- EventKey, 全部子谜题解锁后, 触发的事件, 可能为 null

    -- ---- lasers -----:
    KTool.SetActive( self.laserMeshRenderer_red.gameObject, true )
    KTool.SetActive( self.laserMeshRenderer_green.gameObject, true )
    KTool.SetActive( self.laserMeshRenderer_blue.gameObject, true )
    self.laserMeshRenderer_red.enabled = false
    self.laserMeshRenderer_green.enabled = false
    self.laserMeshRenderer_blue.enabled = false

    self.currentEventKey = nil -- EventKey, role 不在某个 gear 节点上时, 此值为 nil
    self.moveingRubikEnts = {} -- List<RubikEntity>, table 本回合需要移动的 4 个元素;
end



function Puzzle_3:WhenPushBtnLeft()
    --if Maze2DStates.isInAutoControl <= 0 and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then

        assert( not isNull( self.currentEventKey ) )
        print("left")
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Left)
        self:PrepareForNewRotate( true )
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.FirstFrame
    end
end


function Puzzle_3:WhenPushBtnRight()
    --if Maze2DStates.isInAutoControl <= 0 and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then

        assert( not isNull( self.currentEventKey ) )
        print("right")
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Right)
        self:PrepareForNewRotate( false )
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.FirstFrame
    end
end


---@return void
function Puzzle_3:WhenPushBtnDismantle()
    print("按下 skip 按钮")
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        -- 在一帧内就能完成, 就不设置状态了
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Dismantle)
        self:SetToTgtLayout( self.finalLayout )
        self:HandleThreeLaser(true)
        self:HandleSolved()
    end
end


---@return void
function Puzzle_3:WhenPushBtnReset()
    print("按下 reset 按钮")
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Handling
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Reset)
        self.co_1 = cs_coroutine.start(self.HandleReset, self)
    end
end



-- 谜题的 核心部分:
-- 旋转某一排 魔方元素
---@param isTurnLeft boolean
---@return void
function Puzzle_3:PrepareForNewRotate( isTurnLeft )
    assert( type(isTurnLeft) == "boolean" )

    if( EventKey.IsSame(self.currentEventKey, self.gear_12_Key) ) then  -- leftUp row
        self:PrepareForNewRotate_Inn( 
            Vector2Int(0,2),
            Vector2Int(0,1),
            Vector2Int(0,0),
            Vector2Int(0,-1),
            isTurnLeft
        )
    elseif( EventKey.IsSame(self.currentEventKey, self.gear_13_Key) ) then -- leftDown row
        self:PrepareForNewRotate_Inn( 
            Vector2Int(2,0),
            Vector2Int(1,0),
            Vector2Int(0,0),
            Vector2Int(-1,0),
            isTurnLeft
        )
    elseif( EventKey.IsSame(self.currentEventKey, self.gear_14_Key) ) then -- rightDown row
        self:PrepareForNewRotate_Inn( 
            Vector2Int(2,2),
            Vector2Int(2,1),
            Vector2Int(2,0),
            Vector2Int(0,-1),
            isTurnLeft
        )
    elseif( EventKey.IsSame(self.currentEventKey, self.gear_15_Key) ) then -- rightUp row
        self:PrepareForNewRotate_Inn( 
            Vector2Int(2,2),
            Vector2Int(1,2),
            Vector2Int(0,2), 
            Vector2Int(-1,0),
            isTurnLeft
        )
    else
        assert( false, "currentEventKey 存在问题... " .. self.currentEventKey.keyStr )
    end
end



-- 参数: idx_0,idx_2,idx_2: rubikEntitys 中的三个 idx, 
---@param idx_0 UnityEngine.Vector2Int
---@param idx_1 UnityEngine.Vector2Int
---@param idx_2 UnityEngine.Vector2Int
---@param idxOffset UnityEngine.Vector2Int
---@param isTurnLeft boolean
---@return void
function Puzzle_3:PrepareForNewRotate_Inn( idx_0, idx_1, idx_2, idxOffset, isTurnLeft )

    local idx1d_0 = isTurnLeft and self:Vec2_2_Idx(idx_0) or self:Vec2_2_Idx(idx_2) -- int
    local idx1d_1 = self:Vec2_2_Idx(idx_1) -- int
    local idx1d_2 = isTurnLeft and self:Vec2_2_Idx(idx_2) or self:Vec2_2_Idx(idx_0) -- int
    idxOffset = isTurnLeft and idxOffset or (-1)*idxOffset
    local newIdx = (isTurnLeft and idx_0 or idx_2) - idxOffset -- Vector2Int 新的 元素的 起始idx

    -- todo: 检测 上面的 idx 的合法性...

    local rubik_0 = self.rubikEntitys[idx1d_0+1]
    local rubik_1 = self.rubikEntitys[idx1d_1+1]
    local rubik_2 = self.rubikEntitys[idx1d_2+1]

    rubik_0:PrepareForNewMove( idxOffset, 1.0 )
    rubik_1:PrepareForNewMove( idxOffset, 1.0 )

    rubik_2:PrepareForNewMove( idxOffset, 0.0 ) -- 离开魔方, 渐渐变淡
    rubik_2.isOnDestroying = true               -- 允许离开后被释放

    -- 从 -1 位置补一个新的 rubik_2 进来:
    -- todo: 翻译成 lua 版之后, 要改用 对象池...
    local newgo = Object.Instantiate( 
        rubik_2.transform.gameObject,   -- !!!!! todo: 需要修改 rubikEnt class 的内容 才能实现...
        self:CalcRubicEntPos( newIdx ),
        Quaternion.Euler(90.0, 0.0, 0.0),
        self.rubiksParent
    ) -- GameObject
    -- todo: 暂时不管名字的膨胀, 反正后面要改成 pool 了

    local newgoIdComp = KTool.GetOrAddComponent(newgo, typeof(IDComp)) -- add 
    newgoIdComp.id = rubik_2.id 
    newgoIdComp.stringId = RubikEntity.GetClassID()
    local newRubik_2 = RubikEntity.New(newgoIdComp)

    newRubik_2:Init(self, newIdx, 0.0 )           
    newRubik_2:PrepareForNewMove( idxOffset, 1.0 )  -- 进场的同时渐渐增加透明度

    -- 更新 rubikEntitys 中 3个元素的 值;
    self.rubikEntitys[idx1d_0+1] = newRubik_2
    self.rubikEntitys[idx1d_1+1] = rubik_0
    self.rubikEntitys[idx1d_2+1] = rubik_1

    -- 填入 moveingRubikEnts:
    self.moveingRubikEnts = {} 

    table.insert( self.moveingRubikEnts, rubik_0 )
    table.insert( self.moveingRubikEnts, rubik_1 )
    table.insert( self.moveingRubikEnts, rubik_2 )
    table.insert( self.moveingRubikEnts, newRubik_2 )

    -- 更换 dict 元素;
    self.rubikEntityDict[rubik_2.id] = newRubik_2

    -- 提前关闭不符合条件的 镭射
    self:HandleThreeLaser(false)
end



---@param eventKey EventKey
---@return void
function Puzzle_3:WhenEnterGear( eventKey )

    print( "eventKey = " .. eventKey.keyStr )
    assert( EventKey.CheckType(eventKey) )

    if EventKey.IsSame(self.currentEventKey,eventKey) == false  then
        
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Left, true )
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Right, true )

        -- "301" 只有教学解谜, 那时不允许跳关;
        if( self.mazeChapter == "302" ) then
            MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, true )
            MazeMainUI.SetBtnActive( Maze2DStates.Btns.Reset, true )
        end
        self.currentEventKey = eventKey;
    end

    -- 只有 "301" 存在 教学谜题, 在此期间, 禁止玩家随便移动, 老老实实按要求解题;
    if( self.mazeChapter == "301" ) then
        self.mazeMain.isInPuzzle = true -- !!!!! MUST
    end
end





---@return void
function Puzzle_3:WhenLeaveGear()
    print( "-1- WhenLeaveGear() currentEventKey = " .. (isNull(self.currentEventKey) and "null" or self.currentEventKey.keyStr) )

    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Left, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Right, false )
    
    -- "301" 只有教学解谜, 那时不允许跳关;
    if( self.mazeChapter == "302" ) then
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, false )
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Reset, false )
    end
    self.currentEventKey = nil

    if( self.mazeChapter == "301" ) then
       self.mazeMain.isInPuzzle = false -- !!!!! MUST
    end
end




---@return System.Collections.IEnumerator
function Puzzle_3:HandlePuzzle()

    print( "koko -- 开始处理谜题: Puzzle_3:HandlePuzzle" )

    local tgtPos = self:GetGearVCameraPos(self.currentEventKey) 
    assert( self.cameraPivot )
    assert( tgtPos )
    cs_coroutine.yield_return( MazeMain.MoveTo2(self.cameraPivot, self.mazeInput:CalcSafetyPos(tgtPos), {smoothTime = 0.25, maxSpeed = 30.0} ))
    cs_coroutine.yield_return( Maze2DStates.Wait_0D1_Seconds )

    -- 播放滑块滑动音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_slide )

    -- 移动 一整条 魔方块快
    local isAnyMoving = true
    while( isAnyMoving == true ) do
        isAnyMoving = false
        for i,e in pairs(self.moveingRubikEnts) do
            local tmpRet = e:MoveOneFrame() -- 必须外置计算
            isAnyMoving = isAnyMoving or (tmpRet == false) -- "|="
        end
        coroutine.yield(Yielders.EndOfFrame)
    end

    -- 修改所有 RubikEnts 的 orderInLayer: 
    for i,e in pairs(self.moveingRubikEnts) do
        e:SetOrderInLayers()
    end 

    for i,e in pairs(self.moveingRubikEnts) do
        e:EndTheMove()
    end

    print("移动结束")

    -- 教学谜题
    if (self.mazeChapter == "301") and self:IsAnyTeachingPuzzleSolved() then
        self.isSolved = true
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
        return
    end

    local isAllSolved, isTrunOnRed, isTrunOnGreen, isTrunOnBlue = self:HandleThreeLaser(true)

    if isTrunOnRed == true then 
        cs_coroutine.yield_return( self:AfterTurnOnLaser( self.look_laser_red, (isTrunOnGreen == true or isTrunOnBlue == true) ) )
    end
    if isTrunOnGreen == true then 
        cs_coroutine.yield_return( self:AfterTurnOnLaser( self.look_laser_green, isTrunOnBlue == true ) )
    end
    if isTrunOnBlue == true then 
        cs_coroutine.yield_return( self:AfterTurnOnLaser( self.look_laser_blue ) )
    end
    
    -- 判断解谜是否成功的同时, 顺带点亮镭射
    if (self.mazeChapter == "302") and isAllSolved == true  then
        self:HandleSolved()
    end

    print( "koko -- 处理谜题结束: Puzzle_3:HandlePuzzle" )

    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end



---@param customJobTagWhenAfter string
---@return System.Collections.IEnumerator
function Puzzle_3:AfterTurnOnLaser( look_laser, isNeedWaitInEnd_ ) 
    cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(look_laser.position), {smoothTime = 0.25, maxSpeed = 30.0} ) )
    
    if isNeedWaitInEnd_ == true then 
        cs_coroutine.yield_return( Maze2DStates.Wait_0D4_Seconds )
    end 
end



---@return System.Collections.IEnumerator
function Puzzle_3:HandleReset()
    cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(self.resetPosTF.position), {smoothTime = 0.25, maxSpeed = 30.0} ) )
    cs_coroutine.yield_return( Maze2DStates.Wait_0D3_Seconds )
    self:SetToTgtLayout( self.initLayout )
    self:HandleThreeLaser(false)

    -- 播放滑块滑动音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_slide )

    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end




---@return void
function Puzzle_3:HandleSolved()
    print( "------ 谜题解开了 !!!!! -------" )

    -- 解谜成功音效
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_unlock )

    -- todo: 删除掉原来的 3个 gear bubble;
    self.mazeMain:HideBubble( self.gear_12_Key.id )
    self.mazeMain:HideBubble( self.gear_13_Key.id )
    self.mazeMain:HideBubble( self.gear_14_Key.id )
    self.mazeMain:HideBubble( self.gear_15_Key.id )

    -- 点亮后续 房间;
    self.mazeMain:AddToCatchedEventKeys( self.allSolvedEventKey )
    self.isSolved = true
end



---@return void
function Puzzle_3:IsPuzzleBeSolved()
    return self.isSolved
end


---@param savedData string
---@return void
function Puzzle_3:ReadSavedDataToPuzzle( savedData )
    assert( type(savedData) == "string" )

    local strs = string.split( string.lower(savedData), '_' ) -- string[] table
    assert( #strs == 2, "存储数据异常: ".. savedData )
    assert( strs[1] == "solved" or strs[1] == "notSolved", "存储数据异常: ".. savedData )

    print( "strs[1] = " .. strs[1] )
    print( "strs[2] = " .. strs[2] )

    self.isSolved = (strs[1] == "solved")

    -- rubikEntitys 数据是现成的, 我们只是对它们进行一次重新位置放置:
    local savedLayout = HandleMazeTableFile.String_2_InitLayout(strs[2]) -- int[] table
    self:SetToTgtLayout( savedLayout )

    self:HandleThreeLaser(true)
end


---@return string
function Puzzle_3:SaveDataFromPuzzle()
    
    local layout = {0,0,0,  0,0,0,  0,0,0}
    
    -- self.rubikEntitys 一定有 9 个 元素, 中间一个是 nil:
    for i=1, 9 do
        local rubikEntity = self.rubikEntitys[i]
        layout[i] = (rubikEntity == nil) and -1 or rubikEntity.id
    end

    local o = self.isSolved and "solved" or "notSolved" -- string
    o = o .. "_"
    o = o .. HandleMazeTableFile.InitLayout_2_String(layout)
    return o
end


-- 教学谜题, "301" 专用
---@return boolean
function Puzzle_3:IsAnyTeachingPuzzleSolved()

    local eventData = self.handleMazeTableFile.eventDatas[self.currentEventKey.keyStr] -- EventData
    if isNull( eventData.gearConditionEventKey ) then
        return false
    end

    local teachingPuzzle = self.teachingPuzzles[eventData.gearConditionEventKey.keyStr]

    -- 看是否满足 本次解谜条件
    local isPlotSolved = true 

    for i,e in pairs(teachingPuzzle.solvedLayout) do    
        if teachingPuzzle.solvedLayout[i] < 0  then -- -1元素表示不检测  
            -- continue
        else 
            if teachingPuzzle.solvedLayout[i] ~= self.rubikEntitys[i].id  then
                isPlotSolved = false
                break
            end
        end
    end

    if isPlotSolved  then
        local key = teachingPuzzle.solvedEventKey -- EventKey
        self.mazeMain:AddToCatchedEventKeys( key ) 
        --Debug.Log("成功: currentEventKey = " + currentEventKey.keyStr + "; \n plotPuzzle.solvedEventKey = " + key.keyStr);     
        return true
    end
    return false
end



-- 参数: isTurnOn: 尽可能开启 / 尽可能关闭
-- ret: 三组镭射是否都开启了
---@param isTurnOn boolean
---@return boolean
function Puzzle_3:HandleThreeLaser( isTurnOn )

    -- 有些 教学章节, 不存在自由解谜部分, 比如 "301" 
    if (#self.childPuzzles == 0) or isNull(self.allSolvedEventKey) then
        return false
    end

    local isFindFailure = false
    local isTurnOn_61 = false
    local isTurnOn_91 = false
    local isTurnOn_121 = false

    for k,childPuzzle in pairs(self.childPuzzles) do
    
        local isChildSolved = true

        for i=1, #childPuzzle.solvedLayout do
            if childPuzzle.solvedLayout[i] >= 0  then -- -1元素表示不检测  
                if childPuzzle.solvedLayout[i] ~= self.rubikEntitys[i].id  then
                    isChildSolved = false
                    break
                end
            end
        end

        if isChildSolved == true then
            local key = childPuzzle.solvedEventKey -- EventKey
            -- todo: 简易版实现: 从 主配表中找出对应 key 的事件; 然后点亮对应的 laser 
            if( self.mazeChapter == "302" and ( not isNull(key) ) ) then
                isTurnOn_61   = isTurnOn_61  or (key.keyStr == "6.1-solved")
                isTurnOn_91   = isTurnOn_91  or (key.keyStr == "9.1-solved")
                isTurnOn_121  = isTurnOn_121 or (key.keyStr == "12.1-solved")
            end
        end
        isFindFailure = isFindFailure or (isChildSolved == false)
    end 

    -- 是否要在本帧开启 镭射激光
    local isTrunOn_red_ThisFrame = false
    local isTrunOn_green_ThisFrame = false
    local isTrunOn_blue_ThisFrame = false

    if (self.mazeChapter == "302") and isTurnOn  then

        -- 此处只负责开, 不负责关;
        if self.laserMeshRenderer_red.enabled==false and isTurnOn_61==true then 
            self.laserMeshRenderer_red.enabled = true
            isTrunOn_red_ThisFrame = true
        end 

        if self.laserMeshRenderer_green.enabled==false and isTurnOn_91==true then 
            self.laserMeshRenderer_green.enabled = true
            isTrunOn_green_ThisFrame = true
        end 

        if self.laserMeshRenderer_blue.enabled==false and isTurnOn_121==true then 
            self.laserMeshRenderer_blue.enabled = true
            isTrunOn_blue_ThisFrame = true
        end 

    else 
        -- 此处只负责关, 不负责开;
        self.laserMeshRenderer_red.enabled   = isTurnOn_61   and self.laserMeshRenderer_red.enabled or false
        self.laserMeshRenderer_green.enabled = isTurnOn_91   and self.laserMeshRenderer_green.enabled or false
        self.laserMeshRenderer_blue.enabled  = isTurnOn_121  and self.laserMeshRenderer_blue.enabled or false
    end


    -- 播放音效: 
    if isTrunOn_red_ThisFrame==true or isTrunOn_green_ThisFrame==true or isTrunOn_blue_ThisFrame==true then 
        Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_light )
    end


    return (not isFindFailure), isTrunOn_red_ThisFrame, isTrunOn_green_ThisFrame, isTrunOn_blue_ThisFrame
end




---@param key EventKey
---@return Vector3
function Puzzle_3:GetGearVCameraPos( key )

    if( EventKey.IsSame(key, self.gear_12_Key) ) then
        return self.gearVCameraPos_12.position
    end

    if( EventKey.IsSame(key, self.gear_13_Key) ) then
        return self.gearVCameraPos_13.position
    end

    if( EventKey.IsSame(key, self.gear_14_Key) ) then
        return self.gearVCameraPos_14.position
    end

    if( EventKey.IsSame(key, self.gear_15_Key) ) then
        return self.gearVCameraPos_15.position
    end 

    assert( false, "异常的 key: " .. ( isNull(key) and "nil" or key.keyStr) )
    return Vector3.zero
end



---@param idx UnityEngine.Vector2Int
---@return Vector3
function Puzzle_3:CalcRubicEntPos( idx )

    local w = idx.x -- int
    local h = idx.y -- int
    assert( w>=-1 and w<=EDGE_NUM and h>=-1 and h<=EDGE_NUM, "w = " .. w .. ", h = " .. h  ) -- 宽松版, 支持 5x5
    local pos = self.pos_00 +
                self.moveRightFull * (w / (EDGE_NUM-1.0)) +
                self.moveUpFull    * (h / (EDGE_NUM-1.0))
    return pos
end 


-- todo: 危险, 最后被禁止使用 !!!!!!
---@param idx integer
---@return UnityEngine.Vector2Int
function Puzzle_3:Idx_2_Vec2( idx )

    assert( idx >=0 and idx < EDGE_NUM*EDGE_NUM, "idx = " .. idx ) -- 严格边界 3x3
    return Vector2Int( idx % EDGE_NUM, idx // EDGE_NUM )
end 


-- todo: 暂时为宽松版, 不检测参数 v 的合法性
---@param v UnityEngine.Vector2Int
---@return integer
function Puzzle_3:Vec2_2_Idx( v )
    local r = (v.y * EDGE_NUM + v.x) -- int
    assert( r >=0 and r < EDGE_NUM*EDGE_NUM )
    return r
end


-- 计算一个面片的 OrderInLayer 值, 基值为 baseLayer_, 越靠近屏幕 "上方" 的结果越小 
function Puzzle_3:Vec2_2_OrderInLayer( v, baseLayer_ )
    local v2 = Vector2Int( v.x, EDGE_NUM - 1 - v.y ) + Vector2Int(1,1)
    return baseLayer_ + v2.x + v2.y
end



-- 直接将 魔方盘面 摆放成目标阵型:
---@param layout integer[]
---@return void
function Puzzle_3:SetToTgtLayout( layout )
    assert( isTable(layout) )
    assert( #layout == 9 )

    for i=1, #layout do
        local id = layout[i] -- int
        if id >= 0  then
            assert( not isNull( self.rubikEntityDict[id] ), "id = " .. tostring(id) );
        end

        if id < 0 then 
            self.rubikEntitys[i] = nil
        else 
            self.rubikEntitys[i] = self.rubikEntityDict[id]:Init( self, self:Idx_2_Vec2(i-1), 1.0 )
        end
    end
end 



return Puzzle_3

