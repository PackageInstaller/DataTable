--
-- Author:luqucheng
-- Date: 2019-11-08 12:00:09
--
local TriggerRecord = Class("TriggerRecord")


function  TriggerRecord:__init(triggerBuffId, triggerId, ownerId, targetId)
    self.triggerBuffId = triggerBuffId
    self.triggerId = triggerId
    self.ownerId = ownerId
    self.targetId = targetId
end

function TriggerRecord:ToData()
    return {
        r = Constants.RecordType.Trigger,--战报类型
        bId = self.triggerBuffId,--触发器类型
        tId = self.triggerId,
        t = self.targetId,
        o = self.ownerId,
    }
end

return  TriggerRecord