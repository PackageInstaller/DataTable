module("purchase.RechargeCostVo", Class.impl())

function parseData(self, cusData, id)
    self.id = id
    --非首充额外获得道具Id
    self.nofirstId = cusData.non_first_id
    --首充额外获得道具Id
    self.firstIid = cusData.first_id
    --图标
    self.icon = cusData.pic
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]