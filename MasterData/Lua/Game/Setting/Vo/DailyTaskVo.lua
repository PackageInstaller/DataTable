-------------------------------------------------------------------------------
-- 日常任务vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-20 14:59:51
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class DailyTaskVo : SettingRefBase
local DailyTaskVo = Class("DailyTaskVo", SettingRefBase)


function DailyTaskVo:__init()
    self.taskId          = nil  -- 任务id
    self.taskTitle       = nil  -- 任务描述
    self.taskIcon        = nil  -- 任务图标
    self.unlockId        = nil  -- 解锁条件（1-主线 2-支线 3-好感度等级）
    self.unlockValue     = nil  -- 解锁参数
    self.taskGroup       = nil  -- 任务组
    self.before          = nil  -- 前置任务
    self.taskContentType = nil  -- 任务目标类型
    self.taskContentId   = nil  -- 任务目标id
    self.taskContent     = nil  -- 任务目标值
    self.rewardId        = nil  -- 任务奖励
    self.rewardNum       = nil  -- 任务数量
    self.openType        = nil  -- 跳转目标
    self.point           = nil  -- 活跃值
    self.status          = nil  -- 状态
end


function DailyTaskVo:__delete()
    self.taskId          = nil
    self.taskTitle       = nil
    self.taskIcon        = nil
    self.unlockId        = nil
    self.unlockValue     = nil
    self.taskGroup       = nil
    self.before          = nil
    self.taskContentType = nil
    self.taskContentId   = nil
    self.taskContent     = nil
    self.rewardId        = nil
    self.rewardNum       = nil
    self.openType        = nil
    self.point           = nil
    self.status          = nil
end


---@param row TableML.TableFileRow
function DailyTaskVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    self.taskId          = parse_number(row, "taskAchId")
    self.taskTitle       = parse_localizeText(row, "taskTitle", '')
    self.taskIcon        = parse_pathName(row, "taskIcon")
    self.unlockId        = parse_number(row, "unlock")
    self.unlockValue     = parse_number(row, "unlockParameter")
    self.taskGroup       = parse_number(row, "taskGroup")
    self.before          = parse_number(row, "before")
    self.taskContentType = parse_number(row, "taskContentType")
    self.taskContentId   = parse_number(row, "taskContentId")
    self.taskContent     = parse_number(row, "taskContenNum")
    self.rewardId        = parse_string(row, "rewardId")
    self.rewardNum       = parse_string(row, "rewardNum")
    self.openType        = parse_string(row, "openType")
    self.point           = parse_number(row, "point")
    self.status          = parse_number(row, "status")
end


return DailyTaskVo
