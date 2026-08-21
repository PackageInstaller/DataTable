
module('purchase.FashionComboConfigVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id
    self.goodsList = cusData.goods_list
    self.type = cusData.type
    self.icon = cusData.icon
    self.img = cusData.img
    self.itemList = cusData.item_list
    self.scaleOff = cusData.sale_off
    self.name = cusData.name
    self.skinId = cusData.skin_id
    self.payType = cusData.pay_type
    self.cost = cusData.cost
    self.originalCost = cusData.original_cost
    self.main_img = cusData.main_img
end


return _M