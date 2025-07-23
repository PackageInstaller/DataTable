--[[ 
-----------------------------------------------------
@filename       : MainActivityShopVo
@Description    : 商店
@date           : 2023-05-22 15:45:15
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('mainActivity.MainActivityShopVo', Class.impl())

function parseConfigData(self, id, data)
    self.id = id
    --道具tid
    self.itemTid = data.item_tid
    -- 出售数量
    self.sellNum = data.item_num
    -- 出售价格
    self.price = data.price
    -- 商品名称
    self.name = data.name
    -- 商品描述
    self.des = data.resume
    -- 商品上限
    self.limitNum = data.limit_num
    -- 道具排序
    self.sort = data.sort
end

return _M