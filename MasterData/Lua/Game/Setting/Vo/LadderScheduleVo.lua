-------------------------------------------------------------------------------
-- 天梯竞技 - 排期表结构
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-08-08 16:16:28
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class LadderScheduleVo : SettingRefBase
local LadderScheduleVo = Class('LadderScheduleVo', SettingRefBase)


function LadderScheduleVo:__init()
    self.id        = nil  -- id
    self.startTime = nil  -- 开始时间
    self.endTime   = nil  -- 结束时间
    self.nextId    = nil  -- 下一期id
    self.banIdList = nil  -- 禁用角色id
end


function LadderScheduleVo:__delete()
end


---@param row TableML.TableFileRow
function LadderScheduleVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    
    self.id        = parse_number(row, 'id')
    self.startTime = parse_string(row, 'startDay')
    self.endTime   = parse_string(row, 'endDay')
    self.nextId    = parse_number(row, 'nextId')
    self.banIdList = string.split2(parse_string(row, 'roleId'), ';')
end


return LadderScheduleVo
