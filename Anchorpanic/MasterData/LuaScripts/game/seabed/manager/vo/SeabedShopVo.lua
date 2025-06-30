module("seabed.SeabedShopVo", Class.impl())

function parseData(self,id,data)
    self.id = id
    self.param = data.param
    self.shopWeight = data.shop_weight
    self.payPrice = data.pay_price
end


return _M