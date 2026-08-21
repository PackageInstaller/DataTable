--[[-----------------------------------------------------
@filename       : FashionShopTypeVo
@Description    : 皮肤商店数据
@date           : 2023-04-21 17:54:48
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('purchase.FashionShopTypeVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    --类型
    self.type = cusData.page_type
    -- 兑换道具tid排序
    self.sort = cusData.sort
    --语言包
    self.shopLang = cusData.shop_lang[1]
    -- 功能ID
    self.funcId = cusData.func_id
    --支付货币
    self.payType = cusData.pay_type[1][1]
end

--获取皮肤名称
function getFashionShopName(self)
    return _TT(self.shopLang)
end

function getMoneyTid(self)
    return self.payType
end

function getType(self)
    return self.type
end

--获取商店功能开启ID
function getFashionFuncid(self)
    return self.funcId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]