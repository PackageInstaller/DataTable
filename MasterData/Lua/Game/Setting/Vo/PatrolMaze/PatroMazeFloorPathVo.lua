-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫路线表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-01-02 15:11:37
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatroMazeFloorPathVo : SettingRefBase @ AutoIds.IdSetting369
local PatroMazeFloorPathVo = Class('PatroMazeFloorPathVo', SettingRefBase)


function PatroMazeFloorPathVo:__init()
    ---@type integer @ 线路id
    self.pathId = nil
    
    ---@type integer @ 区域id
    self.areaId = nil

    ---@type integer @ 分组id
    self.groupId = nil

    ---@type integer @ 层数
    self.floorNum = nil

    ---@type integer @ 级数
    self.childNum = nil

    ---@type integer[][] @ 对应的下一层级关系（[位置level][包含的level]）
    self.nextChilds = {}

    ---@type integer @ 线路名字
    self.lineName = nil
end


function PatroMazeFloorPathVo:__delete()
    self.pathId     = nil
    self.areaId     = nil
    self.groupId    = nil
    self.floorNum   = nil
    self.childNum   = nil
    self.lineName   = nil
    self.nextChilds = nil
end


---@param row TableML.TableFileRow
function PatroMazeFloorPathVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.pathId     = parse_number(row, 'id')
    self.areaId     = parse_number(row, 'region')
    self.groupId    = parse_number(row, 'group')
    self.floorNum   = parse_number(row, 'floor')
    self.lineName   = parse_string(row, 'map_line')
    self.childNum   = parse_number(row, 'level_num')
    self.nextChilds = {}
    local nextLevel = parse_string(row, 'next_level')
    for childIndex, levels in ipairs(parse_strings(nextLevel)) do
        local levelList = {}
        for _, level in ipairs(string.split2(levels, ',')) do
            table.insert(levelList, checkInt(level))
        end
        self.nextChilds[childIndex] = levelList
    end
end


return PatroMazeFloorPathVo
