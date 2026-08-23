local var_0_0 = g.core.model.User.resourceData
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.shop_flush_goods_info
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.const.ConstMgr.ShopConst
local var_0_6 = g.core.model.User.shopFlushData
local DebugOneKeyShop = class("DebugOneKeyShop", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))
local var_0_8 = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE.MYSTERY
local var_0_9 = g.core.const.ConstMgr.QUALITY_TYPE.SR

function DebugOneKeyShop:initData()
	self._oneKeyName = "一键商店购买"
	self._isEnough = true
	self._needAddEventList = {
		[var_0_4.EVENT_NET_S2C_FLUSH_SHOP_INFO] = handler(self, self._onS2CGetInfo),
		[var_0_4.EVENT_NET_S2C_FLUSH_SHOP_BUY] = handler(self, self._onFlushShopBuy),
		[var_0_4.EVENT_NET_S2C_FLUSH_SHOP_FLUSH] = handler(self, self._onFlushShop)
	}
end

function DebugOneKeyShop:doOneKey()
	if not var_0_6:hasData(var_0_8) or var_0_6:isExpired(var_0_8) then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_FlushShop_Info({
				shop_id = var_0_8
			})
		end)

		return
	end

	for iter_2_0, iter_2_1 in pairs(var_0_6:getShopFlushInfo(var_0_8).normal_goods) do
		local var_2_0 = var_0_3.get(iter_2_1.id)

		if iter_2_1.buy_count < var_2_0.total_limit and self:isNeedBuy(var_2_0) then
			self:send(function()
				g.core.network.GameNetProxy:send_C2S_FlushShop_Buy({
					num = 1,
					goods_type = 1,
					shop_id = var_0_8,
					index = iter_2_0
				})
			end)

			return
		end
	end

	if var_0_0:getMysteryShopFreeNum() > 0 and self._isEnough then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_FlushShop_Flush({
				flush_type = 0,
				shop_id = var_0_8
			})
		end)

		return
	end

	self._isFinish = true
end

function DebugOneKeyShop:_onS2CGetInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	return "刷新商店info更新中"
end

function DebugOneKeyShop:_onFlushShop(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return "商店刷新成功"
end

function DebugOneKeyShop:_onFlushShopBuy(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = var_0_3.get(var_0_6:getShopFlushInfo(var_0_8).normal_goods[arg_8_4.index].id)
	local var_8_1 = var_0_2:convert({
		type = var_8_0.goods_type,
		value = var_8_0.goods_value,
		size = var_8_0.goods_size
	})

	return "购买：" .. var_8_1.name .. "*" .. var_8_1.size
end

function DebugOneKeyShop:isNeedBuy(arg_9_1)
	if arg_9_1.goods_type == var_0_2.TYPE_ITEM and arg_9_1.goods_value == var_0_2.ITEM.TYPE_TOKE_STONE then
		return self:isEnoughAndNotGold(arg_9_1)
	end

	if var_0_2:convert({
		type = arg_9_1.goods_type,
		value = arg_9_1.goods_value,
		size = arg_9_1.goods_size
	}).quality >= var_0_9 then
		return self:isEnoughAndNotGold(arg_9_1)
	end
end

function DebugOneKeyShop:isEnoughAndNotGold(arg_10_1)
	self._isEnough = true

	for iter_10_0 = 1, var_0_5.FLUSH_COST_MAX_NUM do
		local var_10_0

		if arg_10_1["price_type_" .. iter_10_0] == var_0_2.TYPE_GOLD then
			do return false end

			var_10_0 = arg_10_1["price_type_" .. iter_10_0]
		end

		if arg_10_1["price_size_" .. iter_10_0] > var_0_1:getOwnNum(arg_10_1["price_type_" .. iter_10_0], arg_10_1["price_value_" .. iter_10_0]) then
			self:insertLog("建构商店货币不足")

			self._isEnough = false

			return false
		end
	end

	return true
end

return DebugOneKeyShop
