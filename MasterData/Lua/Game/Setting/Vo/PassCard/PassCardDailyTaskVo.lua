-------------------------------------------------------------------------------
-- Pass卡 - 每日任务表
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 10:43:02
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class PassCardDailyTaskVo : SettingRefBase @see AutoIds.IdSetting4054
local PassCardDailyTaskVo = Class('PassCardDailyTaskVo', SettingRefBase)


function PassCardDailyTaskVo:__init()
    ---@type integer @ 任务ID
    self.taskId = nil

    ---@type integer @ 排期ID
    self.scheduleId = nil

    ---@type string @ 任务说明
    self.taskDescr = nil

    ---@type integer @ 区域解锁条件类型，对应解锁条件表
    self.unlockType = nil

    ---@type integer @ 解锁的目标ID
    self.unlockId = nil

    ---@type integer @ 解锁条件参数
    self.unlockNum = nil

    ---@type integer @ 任务目标类型
    self.taskContentType = nil

    ---@type integer @ 任务目标ID
    self.taskContentId = nil

    ---@type integer @ 任务目标值
    self.taskContenNum = nil

    ---@type integer @ 合约经验值
    self.expPoint = nil

    ---@type integer @ 跳转目标
    self.openType = nil

    ---@type integer @ 跳转参数
    self.openParameter = nil
end


function PassCardDailyTaskVo:__delete()
    self.taskId          = nil
    self.scheduleId      = nil
    self.taskDescr       = nil
    self.unlockType      = nil
    self.unlockId        = nil
    self.unlockNum       = nil
    self.taskContentType = nil
    self.taskContentId   = nil
    self.taskContenNum   = nil
    self.expPoint        = nil
    self.openType        = nil
    self.openParameter   = nil
end


---@param row TableML.TableFileRow
function PassCardDailyTaskVo:FillVo(row)
    SettingRefBase.FillVo(self, row)

    self.taskId          = parse_number(row, 'id')
    self.scheduleId      = parse_number(row, 'ScheduleId')
    self.taskDescr       = parse_localizeText(row, 'desc')
    self.unlockType      = parse_number(row, 'unlockType')
    self.unlockId        = parse_number(row, 'unlockId')
    self.unlockNum       = parse_number(row, 'unlockNum')
    self.taskContentType = parse_number(row, 'taskContentType')
    self.taskContentId   = parse_number(row, 'taskContentId')
    self.taskContenNum   = parse_number(row, 'taskContenNum')
    self.expPoint        = parse_number(row, 'point')
    self.openType        = parse_number(row, 'openType')
    self.openParameter   = parse_number(row, 'openParameter')
    self.openParameter   = self.openParameter > 0 and self.openParameter or nil
end


return PassCardDailyTaskVo
