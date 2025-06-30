module("training.TrainingEventConfigVo", Class.impl())

function ctor(self)
end

function parseData(self, eventId, eventData)
    self.eventId = eventId
    self.eventType = eventData.type
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
