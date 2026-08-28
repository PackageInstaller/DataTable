local SettingRefBase = require('Game.Setting.SettingRefBase')
local base = SettingRefBase
local ParseUtils = CS.ParseUtils

-- 微缩世界三星条件表

---@class MiniWorldThreeStarsConditionVO
local MiniWorldThreeStarsConditionVO = Class("MiniWorldThreeStarsConditionVO", SettingRefBase)

function MiniWorldThreeStarsConditionVO:__init()
    self.id = nil
    self.activityId = nil            --活动id
    self.levelId = nil            --对应跑酷关卡id
    self.taskTitle = nil            --任务标题
    self.taskContentType = nil            --任务目标类型
    self.taskContentId = nil            --任务目标
    self.taskContenNum = nil            --任务值
    self.starNum = nil            --星数
    self.rewardId = nil -- 奖励道具id
    self.rewardNum = nil -- 奖励道具数量
    self.status = nil               --状态
end

---FillVo
---@param row TableML.TableFileRow
function MiniWorldThreeStarsConditionVO:FillVo(row)
    base.FillVo(self,row)
    self.id = parse_number(row, "id")
    self.activityId = parse_number(row, "activityId")
    self.levelId = parse_number(row, "levelId")
    self.taskTitle = ParseUtils.ParseLocalizeText(row, "taskTitle")  
    self.taskContentType = parse_number(row, "taskContentType")
    self.taskContentId = parse_number(row, "taskContentId")
    self.taskContenNum = parse_number(row, "taskContenNum")
    self.starNum = parse_number(row, "starNum")     
    self.rewardId = parse_number(row, "rewardId")    
    self.rewardNum = parse_number(row, "rewardNum")    
    self.status = parse_number(row, "status")
end

function MiniWorldThreeStarsConditionVO:__delete()
    self.id = nil
    self.activityId = nil            --活动id
    self.levelId = nil            --对应跑酷关卡id
    self.taskTitle = nil            --任务标题
    self.taskContentType = nil            --任务目标类型
    self.taskContentId = nil            --任务目标
    self.taskContenNum = nil            --任务值
    self.starNum = nil            --星数
    self.rewardId = nil -- 奖励道具id
    self.rewardNum = nil -- 奖励道具数量
    self.status = nil               --状态
end

return MiniWorldThreeStarsConditionVO
