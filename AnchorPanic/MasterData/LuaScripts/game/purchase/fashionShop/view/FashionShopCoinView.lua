--[[ 
-----------------------------------------------------
@filename       : FashionShopCoinView
@Description    : 时装币商店
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.FashionShopCoinView', Class.impl(purchase.FashionShopView))

function getPageType(self)
    return fashionShop.ShopType.FASHIONCOIN
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]