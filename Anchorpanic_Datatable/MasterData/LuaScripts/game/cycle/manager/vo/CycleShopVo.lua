module("cycle.CycleShopVo", Class.impl())

function parseShop(self,id,data)
    self.id = id
    
    self.type = data.type
    self.param = data.param 
    self.price = data.pay_price
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
