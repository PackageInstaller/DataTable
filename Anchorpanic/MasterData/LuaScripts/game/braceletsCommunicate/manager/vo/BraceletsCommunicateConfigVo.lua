module("braceletsCommunicate.BraceletsCommunicateConfigVo", Class.impl())

function ctor(self)
end

-- 解析消息
function parseData(self, targetId, cusData)
    -- 聊天频道类型
    self.targetId = targetId
    self.type = cusData.type
    self.heroList = cusData.hero_id
    self.name = cusData.name
    self.segmentDic = {}
    for k,v in pairs(cusData.talk_part) do
        self.segmentDic[k] = {}
        for m,n in pairs(v.talk_group) do
            local vo = LuaPoolMgr:poolGet(braceletsCommunicate.BraceletsCommunicateSegmentConfigVo)
            vo:parseData(m, n)
            self.segmentDic[k][m] = vo
        end
    end
    self.signId = cusData.sign_id
end

function getTalkVo(self, segmentId, talkId)
    return self.segmentDic[segmentId][talkId]
end

function getTalkMsg(self, segmentId, talkId)
    local talkVo = self:getTalkVo(segmentId, talkId)
    if talkVo == nil then 
        logError("获取对话内容错误，检查配置--TargetId:"..self.targetId.."segId:"..segmentId.. "TalkId:".. talkId)
    end
    return talkVo.msg
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
