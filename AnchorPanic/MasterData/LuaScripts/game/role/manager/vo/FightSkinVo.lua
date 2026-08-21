
module("role.FightSkinVo", Class.impl())

function parseData(self, id, cusData)
    self.id = id
    self.unlockType = cusData.unlock_type
    self.unlockList = cusData.unlock_list
    self.resName = cusData.res_name
    self.prefabName = "arts/prefabs/ui/" .. cusData.prefab_name 

    self.sort = cusData.sort
    self.icon = cusData.icon
    self.preImg= cusData.pre_img
    self.tap = cusData.tap

    self.shopIcon = cusData.shop_icon
    self.shopMinIcon = cusData.shop_min_icon
end


return _M