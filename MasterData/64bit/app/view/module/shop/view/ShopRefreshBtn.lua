local ShopRefreshBtn = class("ShopRefreshBtn", require("app.fairyGUI.shop.UI_ShopRefreshBtn"))
local var_0_1 = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE
local var_0_2 = g.core.model.User.shopFlushData
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.model.User.bagData

function ShopRefreshBtn:ctor()
	return
end

function ShopRefreshBtn:updateComp(arg_2_1)
	self.m_isMaxController:setSelectedIndex(arg_2_1.curFreeNum <= 0 and arg_2_1.buyNum == arg_2_1.maxNum and 1 or 0)

	if arg_2_1.curFreeNum <= 0 then
		self.m_freeNumTxt:setText("")
		self.m_isFreeController:setSelectedIndex(0)

		local var_2_0 = var_0_2:getConsumeItem(arg_2_1.shopType, arg_2_1.num)
		local var_2_1 = var_0_4:convert({
			type = var_2_0.costType,
			value = var_2_0.costValue,
			size = var_2_0.size
		})
		local var_2_2

		if arg_2_1.shopType == var_0_1.MYSTERY then
			var_2_2 = {
				type = var_0_4.TYPE_ITEM,
				value = var_0_4.ITEM.TYPE_FLUSH_ITEM
			}
		end

		if var_2_2 then
			local var_2_3 = var_0_5:getOwnNum(var_2_2.type, var_2_2.value)

			var_2_2.size = var_2_3

			if var_2_3 > 0 then
				self.m_consumeComp:updateByTVS(var_2_2)
			else
				self.m_consumeComp:updateByTVS(var_2_1)
			end
		else
			self.m_consumeComp:updateByTVS(var_2_1)
		end
	else
		self.m_isFreeController:setSelectedIndex(1)
		self.m_freeNumTxt:setText(g.core.lang:get(107055, {
			num = arg_2_1.curFreeNum
		}))
	end
end

function ShopRefreshBtn:addRefreshListener(arg_3_1)
	self.m_refreshBtn:addClickListener(arg_3_1)
end

return ShopRefreshBtn
