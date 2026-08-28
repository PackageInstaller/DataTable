-------------------------------------------------------------------------------
-- 夜寻迷宫 - 层级节点数据
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-03 20:38:57
-------------------------------------------------------------------------------

local BaseDojo = import('Game.Dojo.BaseDojo')
---@class PatrolMazeFloorLevelDojo : BaseDojo
---@field New fun():PatrolMazeFloorLevelDojo
local PatrolMazeFloorLevelDojo = Class('PatrolMazeFloorLevelDojo', BaseDojo)


function PatrolMazeFloorLevelDojo:__init()
    ---@type integer @ 层级位置
    self.floorLevel = 0

    ---@type PatrolMazeUtils.QuestType @ 关卡类型
    self.questType = 0

    ---@type integer @ 对应的类型配表id
    self.typeRefId = 0

    -------------------------------------------------

    ---@type table<string, boolean> @ 父级层级map（key：父级的层级位置，value：是否有效）
    self.parentsMap = {}

    ---@type table<string, boolean> @ 子级层级map（key：子级的层级位置，value：是否有效）
    self.childrenMap = {}

    ---@type integer @ 补给关：助战角色id列表
    self.assistIdList = {}

    ---@type PatrolMazeQuestMonsterDojo[] @ 挑战关：怪物信息
    self.monsterDojoList = {}

    ---@type PatrolMazeQuestProducttDojo[] @ 商店关：商品信息
    self.producttDojoList = {}
end


function PatrolMazeFloorLevelDojo:__delete()
    self.floorLevel       = nil
    self.questType        = nil
    self.typeRefId        = nil
    --                    = 
    self.parentsMap       = nil
    self.childrenMap      = nil
    self.assistIdList     = nil
    self.monsterDojoList  = nil
    self.producttDojoList = nil
end


---@param jsonData table
---@return PatrolMazeFloorLevelDojo
function PatrolMazeFloorLevelDojo:Fill(jsonData)
    self.floorLevel = checkInt(jsonData.level)
    self.questType  = checkInt(jsonData.type)
    self.typeRefId  = checkInt(jsonData.refId)
    return self
end


function PatrolMazeFloorLevelDojo:ToString()
    local parentsList  = {}
    local childrenList = {}
    for parentLevel, isInvalid in pairs(self.parentsMap) do
        table.insert(parentsList, string.fmt('%1:%2', parentLevel, isInvalid))
    end
    for childLevel, isInvalid in pairs(self.childrenMap) do
        table.insert(childrenList, string.fmt('%1:%2', childLevel, isInvalid))
    end
    return string.fmt('{%1 <%2|%3> P[%4] C[%5]}', self.floorLevel, self.questType, self.typeRefId, table.concat(parentsList), table.concat(childrenList))
end


-------------------------------------------------------------------------------
-- levels
-------------------------------------------------------------------------------

function PatrolMazeFloorLevelDojo:AddParentLevel(parentLevel)
    self.parentsMap[tostring(parentLevel)] = true
end


function PatrolMazeFloorLevelDojo:AddChildLevel(childLevel)
    self.childrenMap[tostring(childLevel)] = true
end


function PatrolMazeFloorLevelDojo:InvalidParentLevel(parentLevel)
    self.parentsMap[tostring(parentLevel)] = false
end


function PatrolMazeFloorLevelDojo:InvalidChildLevel(childLevel)
    self.childrenMap[tostring(childLevel)] = false
end


---@return boolean
function PatrolMazeFloorLevelDojo:IsInvalidParentLevel(parentLevel)
    return checkBool(self.parentsMap[tostring(parentLevel)])
end


---@return boolean
function PatrolMazeFloorLevelDojo:IsInvalidChildLevel(childLevel)
    return checkBool(self.childrenMap[tostring(childLevel)])
end


--- 是否 节点为有效的（通往父节点路线全不可用，表示无法到达此位置）
---@return boolean
function PatrolMazeFloorLevelDojo:IsInvalidLevel()
    local isInvalid = false
    if next(self.parentsMap) ~= nil then
        for _, isParentInvalid in pairs(self.parentsMap) do
            if isParentInvalid then
                isInvalid = true
                break
            end
        end
    else
        -- 没有父节点就是根节点，始终有效
        isInvalid = true
    end
    return isInvalid
end


-------------------------------------------------------------------------------
-- outhers
-------------------------------------------------------------------------------

--- 挑战关 怪物信息
---@param jsonData table
---@return PatrolMazeFloorLevelDojo
function PatrolMazeFloorLevelDojo:FillMonsterInfo(jsonData)
    self.monsterDojoList = {}
    for monsterIndex, monsterData in ipairs(checkTable(jsonData.monsters)) do
        local monsterDojo = import('Game.Dojo.PatrolMaze.PatrolMazeQuestMonsterDojo').New()
        self.monsterDojoList[monsterIndex] = monsterDojo:Fill(monsterData)
    end
end


--- 补给关 助战卡牌
---@param jsonData table
---@return PatrolMazeFloorLevelDojo
function PatrolMazeFloorLevelDojo:FillAssistsInfo(jsonData)
    self.assistIdList = {}
    for assistIndex, assistId in ipairs(checkTable(jsonData.assists)) do
        self.assistIdList[assistIndex] = checkInt(assistId)
    end
end


--- 商店关 商品信息
---@param jsonData table
---@return PatrolMazeFloorLevelDojo
function PatrolMazeFloorLevelDojo:FillProductsInfo(jsonData)
    self.producttDojoList = {}
    for productIndex, productData in ipairs(checkTable(jsonData.products)) do
        local productDojo = import('Game.Dojo.PatrolMaze.PatrolMazeQuestProducttDojo').New()
        self.producttDojoList[productIndex] = productDojo:Fill(productData)
    end
end


return PatrolMazeFloorLevelDojo
