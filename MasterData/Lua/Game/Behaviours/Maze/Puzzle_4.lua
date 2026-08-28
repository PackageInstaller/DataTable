---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28


---@class Puzzle_4
---@field statue_1           UnityEngine.Transform -- 8 个谜题雕像, 需要严格指定好
---@field statue_2           UnityEngine.Transform
---@field statue_3           UnityEngine.Transform
---@field statue_4           UnityEngine.Transform
---@field statue_5           UnityEngine.Transform
---@field statue_6           UnityEngine.Transform
---@field statue_7           UnityEngine.Transform
---@field statue_8           UnityEngine.Transform
---@field pos_1           UnityEngine.Transform -- 4个放置 迷宫雕像 的位置
---@field pos_2           UnityEngine.Transform
---@field pos_3           UnityEngine.Transform
---@field pos_4           UnityEngine.Transform
---@field leafGroup_3           UnityEngine.Transform
---@field leafGroup_5           UnityEngine.Transform
---@field leafGroup_7           UnityEngine.Transform
---@field leafGroup_9           UnityEngine.Transform
local Puzzle_4 = Class('Puzzle_4')



local Button = CS.UnityEngine.UI.Button
local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3
local Mathf = CS.UnityEngine.Mathf


local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders


local EventKey = import('Game.Behaviours.Maze.EventKey')
local ChildPuzzle = import('Game.Behaviours.Maze.Puzzle_4_ChildPuzzle')
local HandleMazeTableFile = import('Game.Behaviours.Maze.HandleMazeTableFile')
local MazeMain = import('Game.Behaviours.Maze.MazeMain')

---@type MazeMainUI
local MazeMainUI = import('Game.Behaviours.Maze.MazeMainUI')

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')

---@type Maze2DUtils
local Maze2DUtils = import('Game.Behaviours.Maze.Maze2DUtils'):GetInstance()

---@type Maze2DSounds
local Maze2DSounds = import('Game.Behaviours.Maze.Maze2DSounds'):GetInstance()

--- funtoy:
local KTool = CS.Engine.Lib.KTool
local IDComp = CS.Game.Native.Common.ID
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local Time = CS.UnityEngine.Time
local Quaternion = CS.UnityEngine.Quaternion


-- ========================================================

local statueRotateSpeed = 10.0

local failureStoryId = 3007270

-- ========================================================


function Puzzle_4:__init()
    --print("   ~~~~~~~ Puzzle_4:__init() ~~~~~~~")
    --self.controller = nil

    self._isInit = false
end


function Puzzle_4:__delete()
    --print("   ~~~~~~~ Puzzle_4:__delete() ~~~~~~~")
    Maze2DStates.ClearUIFunctions()
end


-- =============================================================== Self -> ================================================================== -- 


---@param mazeMain_ MazeMain
---@param handleMazeTableFile_ HandleMazeTableFile
---@return void
function Puzzle_4:SelfInit( mazeMain_, handleMazeTableFile_ )

    assert( self.statue_1 and self.statue_2 and self.statue_3 and self.statue_4 and self.statue_5 and self.statue_6 and self.statue_7 and self.statue_8 )
    assert( self.pos_1 and self.pos_2 and self.pos_3 and self.pos_4 )
    assert( self.leafGroup_3 and self.leafGroup_5 and self.leafGroup_7 and self.leafGroup_9 )

    -- ==============================:
    -- 绑定 Update() 函数:
    local behaviourAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    if behaviourAction then
        behaviourAction.UpdateAction = function(behaviourAction)
            self:Update()
        end
    end

    self.mazeMain = mazeMain_ -- 本 calss 和 mazeMain 紧密相连;

    self.cameraPivot = self.mazeMain.cameraPivot
    self.mazeInput = mazeMain_.mazeInput
    self.handleMazeTableFile = handleMazeTableFile_

    self.statues = {} -- Dictionary<string,Transform>
    self.statues["1"] = self.statue_1
    self.statues["2"] = self.statue_2
    self.statues["3"] = self.statue_3
    self.statues["4"] = self.statue_4
    self.statues["5"] = self.statue_5
    self.statues["6"] = self.statue_6
    self.statues["7"] = self.statue_7
    self.statues["8"] = self.statue_8

    self.statueUpDir = self.statue_1.up

    self.statuePoses = { -- List<Transform> table
        self.pos_1,
        self.pos_2,
        self.pos_3,
        self.pos_4
    }

    -- 一口气把 4 个 谜题配表都读完, 同时初始化实例:
    local rightIdxs = {1,2,3,4}
    table.shuffle( rightIdxs )
    self.childPuzzles = {} --  Dictionary<string,ChildPuzzle>
    self.childPuzzles["21-condition"] = ChildPuzzle.New(self, "21-condition", rightIdxs[1] )
    self.childPuzzles["22-condition"] = ChildPuzzle.New(self, "22-condition", rightIdxs[2] )
    self.childPuzzles["23-condition"] = ChildPuzzle.New(self, "23-condition", rightIdxs[3] )
    self.childPuzzles["24-condition"] = ChildPuzzle.New(self, "24-condition", rightIdxs[4] )

    self.saveData = {} -- string[] table, -- 类似: {"21-condition","22-condition"} 表示谜题 21,22 已经解开了;
    self.currentEventKey = nil -- EventKey, role 不在某个 gear 节点上时, 此值为 null;

    -- btn.onClick:AddListener()
    Maze2DStates.WhenPushBtns.Choose = Bind(self,self.WhenPushBtnChoose)
    Maze2DStates.WhenPushBtns.Dismantle = Bind(self,self.WhenPushBtnDismantle)
    -- 此处无需绑定 btn_reset, 因为这个按钮在本迷宫中是 哑的
    Maze2DStates.BindAllBtnFuncs()

    -- 叶子道路:
    self.leafs_3 = {} 
    self.leafs_5 = {} 
    self.leafs_7 = {} 
    self.leafs_9 = {} 

    self.leaf_3_parent = self.leafGroup_3.parent -- Transform
    self.leaf_5_parent = self.leafGroup_5.parent -- Transform
    self.leaf_7_parent = self.leafGroup_7.parent -- Transform
    self.leaf_9_parent = self.leafGroup_9.parent -- Transform
    assert( self.leaf_3_parent and self.leaf_5_parent and self.leaf_7_parent and self.leaf_9_parent )

    self.leafs_3 = self:LeafsInit( self.leafGroup_3 )
    self.leafs_5 = self:LeafsInit( self.leafGroup_5 )
    self.leafs_7 = self:LeafsInit( self.leafGroup_7 )
    self.leafs_9 = self:LeafsInit( self.leafGroup_9 )

    -- self:DebugLeafs( self.leafs_3 )
    -- self:DebugLeafs( self.leafs_5 )
    -- self:DebugLeafs( self.leafs_7 )
    -- self:DebugLeafs( self.leafs_9 )

    self._isInit = true

end



function Puzzle_4:Update()
    if self._isInit == false then
        return
    end

    local speed = statueRotateSpeed * Time.deltaTime
    for i,statue in pairs(self.statues) do  
        statue.rotation = Quaternion.AngleAxis( speed, self.statueUpDir ) * statue.rotation
    end
end


---@return void
function Puzzle_4:WhenPushBtnChoose()
    --if Maze2DStates.isInAutoControl <= 0 and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then

        -- todo: 只是检测而已, 可被省略...
        assert( not isNull(self.currentEventKey) ) 
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Choose)
        self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.FirstFrame
    end
end




---@return void
function Puzzle_4:WhenPushBtnDismantle()
    print("按下 skip 按钮")
    if Maze2DStates.IsInAutoControlLegal() == true and self.mazeMain.puzzleHanleState == Maze2DStates.PuzzleHandleState.Idle  then
        
        print("------ 谜题解开了 !!!!! -------")
        MazeMainUI.GetCurrentInstance():PlayBtnPushAnimation(Maze2DStates.Btns.Dismantle)
        local conditionKeyStr = self:GetCurrentConditionKeyStr() -- string
        self:DoWhenSolved( conditionKeyStr )
    end
end



---@param eventKey EventKey
---@return void
function Puzzle_4:WhenEnterGear( eventKey )

    print( "eventKey = " .. eventKey.keyStr )
    assert( EventKey.CheckType(eventKey) )

    if EventKey.IsSame(self.currentEventKey, eventKey) == false  then
        --print("WhenEnterGear")
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, true )
        MazeMainUI.SetBtnActive( Maze2DStates.Btns.Choose, true )

        self.currentEventKey = eventKey
    end
end




---@return void
function Puzzle_4:WhenLeaveGear()
    print( "-1- WhenLeaveGear() currentEventKey = " .. (isNull(self.currentEventKey) and "null" or self.currentEventKey.keyStr) )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Dismantle, false )
    MazeMainUI.SetBtnActive( Maze2DStates.Btns.Choose, false )

    self.currentEventKey = nil
end



---@return string
function Puzzle_4:GetCurrentConditionKeyStr()
    assert( not isNull(self.currentEventKey) )
    local eventData = self.handleMazeTableFile.eventDatas[self.currentEventKey.keyStr] -- EventData
    assert( not isNull( eventData.gearConditionEventKey ) )
    return eventData.gearConditionEventKey.keyStr -- string
end



---@return System.Collections.IEnumerator
function Puzzle_4:HandlePuzzle()

    -- ----- 无需更新 按钮状态 -----:
    local conditionKeyStr = self:GetCurrentConditionKeyStr()
    local childPuzzle = self.childPuzzles[conditionKeyStr] -- ChildPuzzle

    -- ---- 每次状态变化, 都要主动检查下, 谜底是否被解开, 若解开了, 则要强制去播放 解谜后的 事件 ----:
    if( childPuzzle:IsSolved( self.currentEventKey.keyStr ) ) then
        self:DoWhenSolved(conditionKeyStr)
    else 
        -- 解密失败
        cs_coroutine.yield_return(self:HandleFailure()) 
        self.mazeMain:AddToCatchedEventKeys( childPuzzle.failureEventKey )
    end

    self.mazeMain.puzzleHanleState = Maze2DStates.PuzzleHandleState.Idle
end




---@param conditionKeyStr string
---@return void
function Puzzle_4:DoWhenSolved( conditionKeyStr )
    print("------ 谜题解开了 !!!!! -------")
    local childPuzzle = self.childPuzzles[conditionKeyStr] -- ChildPuzzle
    -- 删除掉原来的 4个 gear bubble;
    for i,k in ipairs(childPuzzle.gearEventKeys) do
        self.mazeMain:HideBubble( k.id )
    end

    -- 停止 雕像旋转 音效: 
    Maze2DSounds.Stop( Maze2DSounds.musics.ui_festival_map_rotate )

    -- 解谜成功音效
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_unlock )


    self:HideAllStatues()
    self.mazeMain:AddToCatchedEventKeys( childPuzzle.solvedEventKey )
    -- 更新存储数据:
    table.insert( self.saveData, conditionKeyStr )
end



---@return System.Collections.IEnumerator
function Puzzle_4:HandleFailure()
    --print(" !!!!!!! 解谜失败 !!!!!!!")

    -- 播放 解谜失败 音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_leaf_lose )

    -- 抖动相机版:
    cs_coroutine.yield_return( Maze2DUtils.DoShake({ 
        transform = self.mazeMain.cameraPivot,
        totalTime = 0.6,
        totalAmplitude = 1.5,
        sinFreq = 75.0,
        peak = 0.3,
    }))

    -- ----- 播放剧情, 告诉玩家踩到死区了 -----:
    cs_coroutine.yield_return( Maze2DStates.Wait_0D5_Seconds )
    cs_coroutine.yield_return( self.mazeMain:PlayStory( failureStoryId, false ) )

    -- 开始播放 雕像旋转的 音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_rotate )

    cs_coroutine.yield_return( Maze2DStates.Wait_0D3_Seconds )
end



function Puzzle_4:HideAllStatues()
    for i,statue in pairs(self.statues) do  
        statue.position = Vector3( 300.0, 300.0, 300.0 ) -- 放到远方
    end
end



---@param eventKeyStr string
---@return void
function Puzzle_4:PuzzleCustomFunc( eventKeyStr )

    print( "puzzle 4 PuzzleCustomFunc(); keyStr = " .. eventKeyStr )
    local eventData = self.handleMazeTableFile.eventDatas[eventKeyStr] -- EventData
    assert( not isNull(eventData.gearConditionEventKey) )
    self.childPuzzles[eventData.gearConditionEventKey.keyStr]:SelfInit( self )

    -- 开始播放 雕像旋转的 音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_rotate )
end


        
---@param skipTagWhenReload_ string
---@return boolean
function Puzzle_4:IsSkipWhenReload( skipTagWhenReload_ )
    --print("skipTagWhenReload_ = " .. skipTagWhenReload_)
    for i,s in ipairs(self.saveData) do
        if s == skipTagWhenReload_  then
            return true
        end
    end
    return false
end




---@param savedData_ string
---@return void
function Puzzle_4:ReadSavedDataToPuzzle( savedData_ )
    assert( type(savedData_) == "string" )
    print( "读取存档信息: " .. savedData_ )
    self.saveData = string.split(savedData_, ';') -- string[] table
end



---@return string
function Puzzle_4:SaveDataFromPuzzle()

    local s = self.saveData[1] -- 先存入 第一元素 
    for i=2, #self.saveData do -- 从第二元素开始
        s = s .. ";" .. self.saveData[i]
    end
    print( "写入存档数据: " .. s )
    return s
end



---@param customJobTagWhenAfter string
---@return System.Collections.IEnumerator
function Puzzle_4:CustomJobWhenAfter( customJobTagWhenAfter ) 

    local leafParent = nil 
    local leafGroup = nil 
    local leafs = nil
    ---:
    local tag = string.lower(customJobTagWhenAfter)
    if tag == string.lower("leaf_3") then 
        print( "处理 叶子 3" )
        leafParent = self.leaf_3_parent
        leafGroup = self.leafGroup_3
        leafs = self.leafs_3

    elseif tag == string.lower("leaf_5") then 
        print( "处理 叶子 5" )
        leafParent = self.leaf_5_parent
        leafGroup = self.leafGroup_5
        leafs = self.leafs_5

    elseif tag == string.lower("leaf_7") then 
        print( "处理 叶子 7" )
        leafParent = self.leaf_7_parent
        leafGroup = self.leafGroup_7
        leafs = self.leafs_7

    elseif tag == string.lower("leaf_9") then 
        print( "处理 叶子 9" )
        leafParent = self.leaf_9_parent
        leafGroup = self.leafGroup_9
        leafs = self.leafs_9

    else
        assert( false, "配表 customJobTagWhenAfter 出错: " .. customJobTagWhenAfter )
    end

    ---:
    cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(leafParent.position), {smoothTime = 0.25, maxSpeed = 30.0} ) )
    cs_coroutine.yield_return( Maze2DStates.Wait_0D2_Seconds )
    cs_coroutine.yield_return(self:DoLeafsMove( leafs ))
    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))

end




---@param leafGroup_ UnityEngine.Transform @ 比如: self.leafGroup_3 
---@return table @               比如: self.leafs_3
function Puzzle_4:LeafsInit( leafGroup_ ) 
    assert( not isNull(leafGroup_) )

    local leafs_ = {} -- clear 
    local idComps = leafGroup_:GetComponentsInChildren(typeof(IDComp),true) -- 包含自己, Array
    for i=0, idComps.Length-1 do 
        local idComp = idComps[i] -- 只有叶子才绑定 IDComp
        assert( idComp.stringId == "Leaf" and idComp.gameObject~=leafGroup_.gameObject ) -- 不能是父节点自己

        local initPosTF = idComp.transform:Find("initPos")
        assert( initPosTF )

        local leafNode = {
            transform = idComp.transform,
            initPos = initPosTF.position, 
            tgtPos  = idComp.transform.position
        }
        -- 先初始为 init pos
        leafNode.transform.position = leafNode.initPos
        
        table.insert( leafs_, leafNode )
    end
        -- local s = "leafs:"
        -- for _,e in pairs(leafs_) do 
        --     s = s .. "\n   initPos = " .. e.initPos:ToString()  
        --     s = s .. "\n   tgtPos = "  .. e.tgtPos:ToString() 
        -- end
        -- print(s)
    return leafs_
end 






---@param leafs_  table,        比如: self.leafs_3
---@return System.Collections.IEnumerator
function Puzzle_4:DoLeafsMove( leafs_ ) 

    -- 播放 叶子移动 音效: 
    Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_leaf )

    -- 让叶子们都移动到 tgtPos:
    local t = 0.0 
    local tSpeed = 1.8
    while t < 1.0 do 
        for _,leafNode in pairs(leafs_) do 
            leafNode.transform.position = Vector3.Lerp( leafNode.initPos, leafNode.tgtPos, Mathf.SmoothStep( 0,1,t) )
        end
        ---
        t = t + Time.deltaTime * tSpeed
        coroutine.yield(Yielders.EndOfFrame)
    end 
end








return Puzzle_4
