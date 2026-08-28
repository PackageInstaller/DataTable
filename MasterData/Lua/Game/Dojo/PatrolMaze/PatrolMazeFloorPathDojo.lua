-------------------------------------------------------------------------------
-- 夜寻迷宫 - 层级路线数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-03 20:38:57
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PatrolMazeFloorPathDojo : BaseDojo
---@field New fun():PatrolMazeFloorPathDojo
local PatrolMazeFloorPathDojo = Class('PatrolMazeFloorPathDojo', BaseDojo)


function PatrolMazeFloorPathDojo:__init()
    ---@type integer @ 层数位置
    self.floorNum = 0

    ---@type integer @ 路径id
    self.floorPathId = 0

    ---@type integer @ 选中的层级
    self.selectLevel = 0

    ---@type PatrolMazeFloorLevelDojo[] @ 层级dojo列表
    self.levelDojoList = {}
end


function PatrolMazeFloorPathDojo:__delete()
    self.floorNum      = nil
    self.floorPathId   = nil
    self.selectLevel   = nil
    self.levelDojoList = nil
end


---@param jsonData table
---@return PatrolMazeFloorPathDojo
function PatrolMazeFloorPathDojo:Fill(jsonData)
    self.floorNum      = checkInt(jsonData.floor)
    self.floorPathId   = checkInt(jsonData.pathId)
    self.selectLevel   = checkInt(jsonData.select)

    self.levelDojoList = {}
    local floorPathVo = PatrolMazeUtils.GetFloorPathVo(self.floorPathId)
    for levelIndex, levelData in ipairs(checkTable(jsonData.levels)) do

        local levelDojo = import('Game.Dojo.PatrolMaze.PatrolMazeFloorLevelDojo').New()
        self.levelDojoList[levelIndex] = levelDojo:Fill(levelData)

        for _, childLevelNum in ipairs(floorPathVo.nextChilds[levelIndex] or {}) do
            levelDojo:AddChildLevel(childLevelNum)
        end
    end
    return self
end


return PatrolMazeFloorPathDojo
