--[[ 
-----------------------------------------------------
@filename       : ShopFramgmentRuleVo
@Description    : 碎片商店规则数据
@date           : 2022-02-23 11:14:50
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('game.shop.manager.vo.ShopFragmentRuleVo', Class.impl())

function priceConfigData(self, cusTid, cusData)
    self.Id = cusTid
    self.price = cusData.price
    self.max_buy_num = cusData.max_buy_num
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
