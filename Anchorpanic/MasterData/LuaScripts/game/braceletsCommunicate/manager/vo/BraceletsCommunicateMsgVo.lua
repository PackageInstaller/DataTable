module("braceletsCommunicate.BraceletsCommunicateMsgVo", Class.impl())

function ctor(self)
end

-- 解析消息
function parseData(self, cusData)
    -- 聊天频道类型
    self.targetId = cusData.target_id
    self.segmentDic = {}
    for k,v in pairs(cusData.part_list) do
        self.segmentDic[v.part_id] = v.talk_list
    end
    self:updateNewestInfo()
end

function getTalkList(self, segmentId)
    return self.segmentDic[segmentId]
end

function updateNewestInfo(self)
    self.newestSegId = #self.segmentDic
    for k,v in pairs(self.segmentDic[self.newestSegId]) do
        if v ~= 0 then 
            if self.newestTalkId ~= v or self.newestIndex ~= k then 
                braceletsCommunicate.BraceletsCommunicateManager:setNewestHasRead(self.targetId, self.newestTalkId, true)
            end
            self.newestTalkId = v  
            self.newestIndex = k  
            return self.newestSegId, self.newestTalkId, self.newestIndex
        end
    end
end

function getNewestSegmentId(self)
    return self.newestSegId, self.newestTalkId, self.newestIndex
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
