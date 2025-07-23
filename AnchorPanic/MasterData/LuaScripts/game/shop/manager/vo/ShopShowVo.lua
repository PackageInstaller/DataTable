--[[ 
-----------------------------------------------------
@filename       : ShopShowVo
@Description    : 商店展示规则数据
@date           : 2020-08-31 11:41:39
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.shop.manager.vo.ShopShowVo', Class.impl())

function parseConfigData(self, cusId, cusData)
    self.id = cusId
    self.pageType = cusData.page_type
    self.shopType = cusData.shop_type
    --self.lvl = cusData.level
    self.pageFuncId = cusData.page_func_id
    self.sort = cusData.sort
    self.shopLang = cusData.shop_lang
    self.pageLang = cusData.page_lang
    self.engLang = cusData.eng_lang
    self.payType = cusData.pay_type
    self.funcId = cusData.func_id
end

function minLvl(self)
    local lv = nil
    for i, v in ipairs(self.lvl) do
        lv = lv or v
        lv = math.min(v, lv)
    end
    return lv
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
