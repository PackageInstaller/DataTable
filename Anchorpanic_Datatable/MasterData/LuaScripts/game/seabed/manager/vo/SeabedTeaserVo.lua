module("seabed.SeabedTeaserVo", Class.impl())

function parseData(self,id,data)
    --难度
    self.id = id 
    --难题描述
    self.des = data.des
    --额外的行动点
    self.extraActionPoint = data.extra_action_point
end

return _M