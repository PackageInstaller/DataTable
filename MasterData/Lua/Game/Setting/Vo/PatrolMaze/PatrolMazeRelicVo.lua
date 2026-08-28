-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫圣物表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeRelicVo : SettingRefBase @ AutoIds.IdSetting357
local PatrolMazeRelicVo = Class('PatrolMazeRelicVo', SettingRefBase)


function PatrolMazeRelicVo:__init()
    ---@type integer @ 圣物id
    self.relicId = 0
    
    ---@type integer @ 圣物分组id
    self.teamId = 0
    
    ---@type string @ 名字
    self.name = 0

    ---@type string @ 描述
    self.descr = 0

    ---@type integer @ 品质(白1;绿2;蓝3;紫4;橙5)
    self.quality = 0

    ---@type integer @ 属性加成方式（0-直接加成 1-按圣物数量加成 2-按红色武装数量加成 3-按绿色武装数量加成 4-按蓝色武装数量加成5-按黑色和白色武装数量加成
    self.addType = 0

    ---@type integer @ 效果id
    self.buffId = 0

    ---@type string @ 图标路径
    self.iconPath = 0

    ---@type integer @ 标签id
    self.lableId = 0

    ---@type table<integer, boolean> @ 适用卡牌map
    self.cardIdMap = {}
end


function PatrolMazeRelicVo:__delete()
    self.relicId   = nil
    self.teamId    = nil
    self.name      = nil
    self.descr     = nil
    self.quality   = nil
    self.addType   = nil
    self.buffId    = nil
    self.iconPath  = nil
    self.lableId   = nil
    self.cardIdMap = nil
end


---@param row TableML.TableFileRow
function PatrolMazeRelicVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.relicId   = parse_number(row, 'Id')
    self.teamId    = parse_number(row, 'team')
    self.name      = parse_localizeText(row, 'name')
    self.descr     = parse_localizeText(row, 'description', true)
    self.quality   = parse_number(row, 'quality')
    self.addType   = parse_number(row, 'AddType')
    self.buffId    = parse_number(row, 'buffId')
    self.iconPath  = parse_pathName(row, 'photoId')
    self.lableId   = parse_number(row, 'lableId')

    self.cardIdMap = {}
    for _, cardId in ipairs(parse_numbers(row, 'recCard')) do
        self.cardIdMap[cardId] = true
    end
end


return PatrolMazeRelicVo
