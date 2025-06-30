module("WelfareOptGoldWishingVo",Class.impl())

function parseGoldWishingData(self,cusData)
    --金币消耗
    self.goldCost = cusData.gold_cost
    --时间消耗
    self.timeCost = cusData.time_cost
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
