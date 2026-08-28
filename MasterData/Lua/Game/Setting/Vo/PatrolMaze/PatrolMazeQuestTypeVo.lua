-------------------------------------------------------------------------------
-- 夜巡迷宫 - 关卡点类型表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 11:08:20
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PatrolMazeQuestTypeVo : SettingRefBase @see AutoIds.IdSetting351
local PatrolMazeQuestTypeVo = Class('PatrolMazeQuestTypeVo', SettingRefBase)


function PatrolMazeQuestTypeVo:__init()
    ---@type integer @ 类型id
    self.typeId = nil

    ---@type string @ 类型名称
    self.typeName = nil

    ---@type string @ 类型描述
    self.typeDescr = nil

    ---@type string @ 按钮名字
    self.buttonName = nil
end


function PatrolMazeQuestTypeVo:__delete()
    self.typeId     = nil
    self.typeName   = nil
    self.typeDescr  = nil
    self.buttonName = nil
end


---@param row TableML.TableFileRow
function PatrolMazeQuestTypeVo:FillVo(row)
    SettingRefBase.FillVo(self,row)

    self.typeId     = parse_number(row, 'incidentId')
    self.typeName   = parse_localizeText(row, 'name')
    self.typeDescr  = parse_localizeText(row, 'desc', true)
    self.buttonName = parse_localizeText(row, 'butDesc', true)
end


return PatrolMazeQuestTypeVo
