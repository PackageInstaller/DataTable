-------------------------------------------------------------------------------
-- 成就任务vo
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-20 14:59:51
-------------------------------------------------------------------------------

local SettingRefBase = require('Game.Setting.SettingRefBase')
---@class AchievementTaskVo : SettingRefBase
local AchievementTaskVo = Class("AchievementTaskVo", SettingRefBase)


function AchievementTaskVo:__init()
    self.taskAchId       = nil -- 任务的ID（筛选分类（1-5）+任务组分类（01-99）+任务序号（01-99）
    self.reputationType  = nil -- 筛选分类（1 收集 2养成 3挑战 4 其他
    self.taskTitle       = nil -- 任务标题
    self.taskIcon        = nil -- 任务ICON
    self.desc            = nil -- 任务说明（备注用，具体需要程序自动生成描述）
    self.Numtype         = nil -- 计数类型
    self.taskContentType = nil -- 任务目标类型
    self.taskContentId   = nil -- 任务目标
    self.taskContenNum   = nil -- 任务值
    self.taskGroup       = nil -- 任务组分类（每种成就内的一组任务填写相同的ID）
    self.successorTasks  = nil -- 后续任务ID（后续任务继承上个任务的数值。填写0时，则无后续任务填充作用。）
    self.point           = nil -- 成就点奖励（显示排在最后）
    self.rewardId        = nil -- 任务奖励
    self.rewardNum       = nil -- 任务数量
    self.openType        = nil -- 跳转目标
    self.status          = nil -- 状态
end


function AchievementTaskVo:__delete()
    self.taskAchId       = nil
    self.reputationType  = nil
    self.taskTitle       = nil
    self.taskIcon        = nil
    self.desc            = nil
    self.Numtype         = nil
    self.taskContentType = nil
    self.taskContentId   = nil
    self.taskContenNum   = nil
    self.taskGroup       = nil
    self.successorTasks  = nil
    self.point           = nil
    self.rewardId        = nil
    self.rewardNum       = nil
    self.openType        = nil
    self.status          = nil
end


---@param row TableML.TableFileRow
function AchievementTaskVo:FillVo(row)
    SettingRefBase.FillVo(self, row)
    self.taskAchId       = parse_number(row, "taskAchId")
    self.reputationType  = parse_number(row, "reputationType")
    self.taskTitle       = parse_localizeText(row, "taskTitle")
    self.taskIcon        = parse_pathName(row, "taskIcon")
    self.desc            = parse_localizeText(row, "desc")
    self.Numtype         = parse_number(row, "Numtype")
    self.taskContentType = parse_number(row, "taskContentType")
    self.taskContentId   = parse_number(row, "taskContentId")
    self.taskContenNum   = parse_number(row, "taskContenNum")
    self.taskGroup       = parse_number(row, "taskGroup")
    self.successorTasks  = parse_number(row, "successorTasks")
    self.point           = parse_number(row, "point")
    self.rewardId        = parse_string(row, "rewardId")
    self.rewardNum       = parse_string(row, "rewardNum")
    self.openType        = parse_string(row, "openType")
    self.status          = parse_number(row, "status")
end


return AchievementTaskVo
