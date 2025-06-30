module("recruit.RecruitLogVo", Class.impl())

function ctor(self)
end

function parseMsgData(self, recruit_id, cusData)
    self.recruit_id = recruit_id
    self.time = cusData.time
    self.itemTid = cusData.item_tid
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
