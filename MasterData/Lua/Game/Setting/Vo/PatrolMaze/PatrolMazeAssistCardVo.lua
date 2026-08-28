-------------------------------------------------------------------------------
-- 夜巡迷宫 - 迷宫助战角色表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-26 20:13:30
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeAssistCardVo : SettingRefBase @ AutoIds.IdSetting361
local PatrolMazeAssistCardVo = Class('PatrolMazeAssistCardVo', SettingRefBase)


function PatrolMazeAssistCardVo:__init()
    ---@type integer @ 代理id
    self.assistId = 0

    ---@type integer @ 卡牌id
    self.cardId = 0

    ---@type integer @ 皮肤id
    self.skinId = 0

    ---@type integer @ 卡牌星级
    self.starNum = 0

    ---@type table<integer, number>> @ 属性加成map（key：属性id，value：加成系数值）
    self.additionMap = {}
end


function PatrolMazeAssistCardVo:__delete()
    self.assistId    = nil
    self.cardId      = nil
    self.skinId      = nil
    self.starNum     = nil
    self.additionMap = nil
end


---@param row TableML.TableFileRow
function PatrolMazeAssistCardVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.assistId = parse_number(row, 'id')
    self.cardId   = parse_number(row, 'assistId')
    self.skinId   = parse_number(row, 'cardSkin')
    self.starNum  = parse_number(row, 'star')

    self.additionMap = {}
    for _, coefficient in ipairs(parse_strings(parse_string(row, 'starCoefficient'))) do
        local values = string.split(coefficient, ',')
        self.additionMap[checkInt(values[1])] = checkNumber(values[2])
    end
end


return PatrolMazeAssistCardVo
