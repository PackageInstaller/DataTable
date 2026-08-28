---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28



---@class Puzzle_101
---@field globeBall        UnityEngine.Transform
local Puzzle_101 = Class('Puzzle_101')



local Button = CS.UnityEngine.UI.Button
local Transform = CS.UnityEngine.Transform
local Vector3 = CS.UnityEngine.Vector3


local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders

local MazeMain = import('Game.Behaviours.Maze.MazeMain')

---@type Maze2DStates
local Maze2DStates = import('Game.Behaviours.Maze.Maze2DStates')

---@type Maze2DSounds
local Maze2DSounds = import('Game.Behaviours.Maze.Maze2DSounds'):GetInstance()


function Puzzle_101:__init()
    --print("   ~~~~~~~ Puzzle_101:__init() ~~~~~~~")
    --self.controller = nil
end


function Puzzle_101:__delete()
    --print("   ~~~~~~~ Puzzle_101:__delete() ~~~~~~~")
    Maze2DStates.ClearUIFunctions()
end


-- =============================================================== Self -> ================================================================== -- 


---@param mazeMain_ MazeMain
function Puzzle_101:SelfInit( mazeMain_ ) 
    
    assert( self.globeBall )

    self.initPos = self.globeBall.position
    self.tgtPos= self.initPos + Vector3( 0.0, 0.0, -2.3 ) -- 名义上是高度, 其实改写的是 z轴值;

    print( "tgtPos = " .. tostring(self.tgtPos.x) .. ", " .. tostring(self.tgtPos.y) .. ", " .. tostring(self.tgtPos.z) )

    self.mazeMain = mazeMain_
    self.cameraPivot = self.mazeMain.cameraPivot
    self.mazeInput = mazeMain_.mazeInput

end



---@param customJobTagWhenAfter string
---@return System.Collections.IEnumerator
function Puzzle_101:CustomJobWhenAfter( customJobTagWhenAfter ) 
    local tag = string.lower(customJobTagWhenAfter)
    if tag == string.lower("globeBallDown") then 
        print( "处理地球仪" )
        cs_coroutine.yield_return( MazeMain.MoveTo2( self.cameraPivot, self.mazeInput:CalcSafetyPos(self.initPos), {smoothTime = 0.25, maxSpeed = 30.0} ) )
        cs_coroutine.yield_return( Maze2DStates.Wait_0D3_Seconds )

        -- 播放音效: 
        Maze2DSounds.PlayMusic( Maze2DSounds.musics.ui_festival_map_down )

        cs_coroutine.yield_return( MazeMain.MoveTo2( self.globeBall, self.tgtPos, {smoothTime = 0.25, maxSpeed = 30.0} ) )

        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.3))
    else
        assert( false, "配表 customJobTagWhenAfter 出错: " .. customJobTagWhenAfter )
    end
end






return Puzzle_101
