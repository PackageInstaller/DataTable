-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫区域信息表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeAreaInfoVo : SettingRefBase @ AutoIds.IdSetting368
local PatrolMazeAreaInfoVo = Class('PatrolMazeAreaInfoVo', SettingRefBase)


function PatrolMazeAreaInfoVo:__init()
    ---@type integer @ 表id
    self.openId = 0
    
    ---@type integer @ 区域id
    self.areaId = 0

    ---@type integer @ 解锁天数
    self.unlockDay = 0

    ---@type integer[] @ 出战卡牌列表
    self.initCards = {}

    ---@type integer @ 所需上一个区域通关层数
    self.prevFloor = 0

    ---@type string @ 区域介绍
    self.introduce = ''

    ---@type table<integer, boolean> @ 推荐卡牌id
    self.recommendMap = {}
end


function PatrolMazeAreaInfoVo:__delete()
    self.openId       = nil
    self.areaId       = nil
    self.unlockDay    = nil
    self.initCards    = nil
    self.prevFloor    = nil
    self.introduce    = nil
    self.recommendMap = nil
end


---@param row TableML.TableFileRow
function PatrolMazeAreaInfoVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.openId    = parse_number(row, 'id')
    self.areaId    = parse_number(row, 'region')
    self.unlockDay = parse_number(row, 'start_time')
    self.initCards = parse_numbers(row, 'card_id')
    self.prevFloor = parse_number(row, 'start_condition')
    self.introduce = parse_localizeText(row, 'regionalism', true)

    self.recommendMap = {}
    -- 推荐战斗员（设定按顺序显示的武装中前X名战斗员要添加推荐标签）
    for index = 1, parse_number(row, 'recCard') do
        local cardId = checkInt(self.initCards[index])
        if cardId > 0 then
            self.recommendMap[cardId] = true
        end
    end
end


return PatrolMazeAreaInfoVo
