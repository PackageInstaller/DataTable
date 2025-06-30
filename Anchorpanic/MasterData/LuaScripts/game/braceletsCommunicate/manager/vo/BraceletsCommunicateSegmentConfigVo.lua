module("braceletsCommunicate.BraceletsCommunicateSegmentConfigVo", Class.impl())

function ctor(self)
end

-- 解析消息
function parseData(self, talkId, cusData)
    -- 聊天频道类型
    self.talkId = talkId
    self.nextId = cusData.next_id
    self.type = cusData.type
    self.msg = cusData.msg
    self.talkerId = cusData.talker_id
    self.reward = cusData.reward
    self.relation = cusData.relation
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
