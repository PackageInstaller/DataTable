--[[
    author:luqucheng
    time:2021-01-22 12:01:00
]]
local ConditionUpdateRecord = Class("ConditionUpdateRecord")

--@condition: [Game.Battle.Core.Condition#Condition]
function  ConditionUpdateRecord:__init(condition, condtionUsedTo)
    self.conditionType = condition.type
    self.value = condition.num
    self.condtionUsedTo = condtionUsedTo
    self.conditionState = condition:GetConditionState()
end

function ConditionUpdateRecord:ToData()
    return {
        r = Constants.RecordType.MissionUpdate,--战报类型
        type = self.conditionType,--任务序号
        value = self.value,
        condtionUsedTo = self.condtionUsedTo,
        conditionState = self.conditionState,
    }
end

return  ConditionUpdateRecord