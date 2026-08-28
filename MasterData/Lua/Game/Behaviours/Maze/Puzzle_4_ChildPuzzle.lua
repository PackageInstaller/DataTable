---
--- Created by zou hanjie.
--- DateTime: 2022/12/08 12:48

---@class Puzzle_4_ChildPuzzle
local Puzzle_4_ChildPuzzle = Class('Puzzle_4_ChildPuzzle')

-- ========================================================

local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders
local LuaBehaviour = CS.Engine.Modules.LuaBehaviour


local MazeEventType = import('Game.Behaviours.Maze.MazeEventType')
local EventKey = import('Game.Behaviours.Maze.EventKey')


---@type SettingMgr
local settingMgr = SettingMgr:GetInstance() -- 读取配表


-- ========================================================



---@param puzzle_ Puzzle_4
---@param childPuzzleIdStr_ string
---@param rightIdx_ integer 
---@return void
function Puzzle_4_ChildPuzzle:__init( puzzle_, childPuzzleIdStr_, rightIdx_ )
    --print("   ~~~~~~~ Puzzle_4_ChildPuzzle:__init() ~~~~~~~")

    -- ------------- 读取配表信息 -----------------
    local tableFile = settingMgr:Get(AutoIds.IdSetting3005) -- TableFile,  迷宫4配置表 

    local tgtRow = nil -- 一个章节 只需要 一行信息;
    -- 找到目标行
    local length = tableFile:GetRowCount()
    for i=1,length do -- (实际从表格第 5 行开始读)
        local row = tableFile:GetRow(i) -- TableFileRow
        local chapterInfo = string.lower( row:Get("childPuzzleID") )
        if chapterInfo == childPuzzleIdStr_  then
            tgtRow = row
            break
        end
    end
    assert( not isNull(tgtRow) )

    local correntEntId = string.lower(tgtRow:Get("correctElementID")) -- string -- 表中数据; 这些 string 可以索引到 8 个迷宫元素中的一个;
    local oth3ElementIDs = string.split( string.lower(tgtRow:Get("oth3ElementIDs")), ';' ) -- string[] table -- 表中数据; 这些 string 可以索引到 8 个迷宫元素中的一个;
    assert( #oth3ElementIDs == 3 )

    self.failureEventKey = EventKey.New({keyStr = string.lower(tgtRow:Get("failueEventKey")) }) -- 解谜失败时触发的事件
    self.solvedEventKey = EventKey.New({keyStr = string.lower(tgtRow:Get("solvedEventKey")) }) -- 解谜成功时触发的事件

    self.gearEventKeys = {} -- EventKey[] table
    local gearEventKeysStrs = string.split( string.lower(tgtRow:Get("gearEventKeys")), ';' ) -- string[] table
    for i,s in ipairs(gearEventKeysStrs) do 
        table.insert( self.gearEventKeys, EventKey.New({keyStr=s}) );
    end

    -- ------------------------------------------------
    self.puzzle = puzzle_
    
    -- Shuffle:
    self.elementIDs = oth3ElementIDs -- 先装入 3 个oth 元素
    table.shuffle( self.elementIDs )
    --  
    --local rightIdx_ = math.random( 1,4 ) -- {1,2,3,4} 里三选一
    -- swap:
    if rightIdx_ == 4 then 
        table.insert( self.elementIDs, correntEntId )
    else 
        local tmpEntId = self.elementIDs[rightIdx_]
        self.elementIDs[rightIdx_] = correntEntId
        table.insert( self.elementIDs, tmpEntId )
    end 
    ---:
    self.correctEventKey = self.gearEventKeys[rightIdx_] -- 正确答案的 eventkey

    -- debug: 
    local ss = "---- 迷宫4 数据: rightIdx_ = " .. rightIdx_
    for k,v in pairs(self.elementIDs) do 
        ss = ss .. "\n   " .. v
    end 
    print(ss)
end





function Puzzle_4_ChildPuzzle:__delete()
    --print("   ~~~~~~~ Puzzle_4_ChildPuzzle:__delete() ~~~~~~~")
end



-- =============================================================== Self -> ================================================================== -- 




function Puzzle_4_ChildPuzzle:SelfInit() 
    
    -- 先熄灭所有 statues:
    self.puzzle:HideAllStatues()
    -- 再点亮本次的 4 个:
    for i=1, 4 do 
        local id = self.elementIDs[i] -- string 
        local statue = self.puzzle.statues[id] -- Transform
        local tgtPos = self.puzzle.statuePoses[i].position -- Vector3
        -- todo: 可能要修改 tgtPos..
        statue.position = tgtPos
    end
end



---@param eventKeyStr string
---@return boolean
function Puzzle_4_ChildPuzzle:IsSolved( eventKeyStr_ )
    return eventKeyStr_ == self.correctEventKey.keyStr
end




return Puzzle_4_ChildPuzzle
