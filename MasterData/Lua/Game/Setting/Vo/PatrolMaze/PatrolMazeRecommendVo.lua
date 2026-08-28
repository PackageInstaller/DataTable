-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫区域官方推荐表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-30 18:33:17
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeRecommendVo : SettingRefBase @ AutoIds.IdSetting386
local PatrolMazeRecommendVo = Class('PatrolMazeRecommendVo', SettingRefBase)


function PatrolMazeRecommendVo:__init()
    ---@type integer @ 自增id
    self.recommendId = 0

    ---@type integer @ 开启的区域id
    self.openAreaId = 0

    ---@type integer @ 推荐索引
    self.recommendIndex = 0

    ---@type string @ 推荐描述
    self.recommendDescr = ''

    ---@type integer @ 核心卡牌数量
    self.coreCardNum = 0

    ---@type integer[] @ 推荐卡牌id列表
    self.cardIdList = {}
    
    ---@type integer[] @ 推荐圣物id列表
    self.relicIdList = {}
end


function PatrolMazeRecommendVo:__delete()
    self.recommendId    = nil
    self.openAreaId     = nil
    self.recommendIndex = nil
    self.recommendDescr = nil
    self.coreCardNum    = nil
    self.cardIdList     = nil
    self.relicIdList    = nil
end


---@param row TableML.TableFileRow
function PatrolMazeRecommendVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.recommendId    = parse_number(row, 'id')
    self.openAreaId     = parse_number(row, 'areaId')
    self.recommendIndex = parse_number(row, 'schemeCount')
    self.recommendDescr = parse_localizeText(row, 'desc', true)
    self.coreCardNum    = parse_number(row, 'schemeCore')
    self.cardIdList     = parse_numbers(row, 'schemeCard')
    self.relicIdList    = parse_numbers(row, 'schemeBuff')
end


return PatrolMazeRecommendVo
