module("recruit.RecruitLogVo", Class.impl())

function ctor(self)
end

function parseMsgData(self, cusType, cusData)
    self.recruitType = cusType
    self.time = cusData.time
    self.itemTid = cusData.item_tid
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
