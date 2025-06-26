
module('purchase.FashionComboVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id
    self.goodsList = cusData.goods_list
    self.payType = cusData.pay_type
    self.cost = cusData.cost
    self.configVo = purchase.FashionShopManager:getFashionComboData(id)
end


return _M