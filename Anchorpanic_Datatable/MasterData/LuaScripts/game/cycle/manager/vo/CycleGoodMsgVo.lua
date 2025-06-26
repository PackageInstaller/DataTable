module("cycle.CycleGoodMsgVo", Class.impl())

function parseGoodMsgVo(self,data)
    --id
    self.id = data.id 

    --1 收藏品  2 招募卷
    self.type = data.type
    --价格
    self.price = data.price
    --是否已经购买
    self.isBuy =  data.is_buy
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
