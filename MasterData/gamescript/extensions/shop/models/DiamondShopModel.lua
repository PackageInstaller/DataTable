local DiamondShopModel = NewClass("DiamondShopModel", BaseModel)

function DiamondShopModel:OnReset()
  self.monthCardData = {}
  self.shopGoodsListMap = {}
  self.mainShopTypeList = nil
end

function DiamondShopModel:OnInit()
  self:OnReset()
end

return DiamondShopModel
