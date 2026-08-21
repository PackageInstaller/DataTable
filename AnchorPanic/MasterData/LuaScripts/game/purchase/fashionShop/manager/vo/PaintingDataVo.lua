--图册配置数据
module('purchase.PaintingDataVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id
    self.unlockType = cusData.unlock_type
    self.unlockList = cusData.unlock_list
    self.resName = cusData.res_name
    self.preImg = cusData.pre_img
    self.prefabPath = cusData.prefab_name
    self.sort = cusData.sort
    self.icon = cusData.icon
    self.tapList = cusData.tap
    self.interactModels = cusData.interact_models
    self.isUnique = cusData.isUnique

    --self.shopData = purchase.FashionShopManager:getCurShopVo(self.id)
end


return _M