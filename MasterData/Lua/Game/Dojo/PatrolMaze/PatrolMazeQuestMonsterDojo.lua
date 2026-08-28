-------------------------------------------------------------------------------
-- 夜寻迷宫 - 关卡怪物数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-03 20:38:57
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PatrolMazeQuestMonsterDojo : BaseDojo
---@field New fun():PatrolMazeQuestMonsterDojo
local PatrolMazeQuestMonsterDojo = Class('PatrolMazeQuestMonsterDojo', BaseDojo)


function PatrolMazeQuestMonsterDojo:__init()
    ---@type integer @ 怪物id
    self.monsterId = 0

    ---@type number @ 血量百分比
    self.hpPercent = 1

    ---@type integer @ 能量
    self.energy = 0
end


function PatrolMazeQuestMonsterDojo:__delete()
    self.monsterId = nil
    self.hpPercent = nil
    self.energy    = nil
end


---@param jsonData table
---@return PatrolMazeQuestMonsterDojo
function PatrolMazeQuestMonsterDojo:Fill(jsonData)
    self.monsterId = checkInt(jsonData.monsterId)
    self.hpPercent = checkNumber(jsonData.hpPercent)
    self.energy    = checkInt(jsonData.energy)
    return self
end


return PatrolMazeQuestMonsterDojo
