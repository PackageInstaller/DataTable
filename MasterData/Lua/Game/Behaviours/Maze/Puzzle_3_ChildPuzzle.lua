---
--- Created by zou hanjie.
--- DateTime: 2022/11/29 12:48

-- 子谜题, 全部子谜题解锁后, 本章节的谜题算是彻底解锁;
---@class Puzzle_3_ChildPuzzle
local Puzzle_3_ChildPuzzle = Class('Puzzle_3_ChildPuzzle')


local EventKey = import('Game.Behaviours.Maze.EventKey')


---@param solvedLayout_ integer[]
---@param solvedEventKey_ EventKey
function Puzzle_3_ChildPuzzle:__init( solvedLayout_, solvedEventKey_ )
    assert( isTable(solvedLayout_) and EventKey.CheckType(solvedEventKey_) == true )
    self.solvedLayout = solvedLayout_ -- int[] table, 获胜条件, -1元素表示不检测 
    self.solvedEventKey =solvedEventKey_ -- 若为空, 则跳过
end


function Puzzle_3_ChildPuzzle:__delete()
    self.solvedLayout = nil 
    self.solvedEventKey = nil
end



return Puzzle_3_ChildPuzzle
