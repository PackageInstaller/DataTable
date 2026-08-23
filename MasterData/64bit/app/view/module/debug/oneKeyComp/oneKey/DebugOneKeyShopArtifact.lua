local var_0_0 = g.core.model.User.resourceData
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.config.shop_flush_goods_info
local var_0_5 = g.core.event.enum
local var_0_6 = g.core.const.ConstMgr.ShopConst
local var_0_8 = g.core.model.User.shopFlushData
local DebugOneKeyShopArtifact = class("DebugOneKeyShopArtifact", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))
local var_0_10 = g.core.const.ConstMgr.ShopConst.SHOP_FLUSH_TYPE.ARTIFACT
local var_0_11 = g.core.const.ConstMgr.QUALITY_TYPE.SR

function DebugOneKeyShopArtifact:initData()
	self._oneKeyName = "一键专武商店购买"
	self._isEnough = true
	self._needAddEventList = {
		[var_0_5.EVENT_NET_S2C_FLUSH_SHOP_INFO] = handler(self, self._onS2CGetInfo),
		[var_0_5.EVENT_NET_S2C_FLUSH_SHOP_BUY] = handler(self, self._onFlushShopBuy),
		[var_0_5.EVENT_NET_S2C_FLUSH_SHOP_FLUSH] = handler(self, self._onFlushShop)
	}
end

function DebugOneKeyShopArtifact:doOneKey()
	if not var_0_8:hasData(var_0_10) or var_0_8:isExpired(var_0_10) then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_FlushShop_Info({
				shop_id = var_0_10
			})
		end)

		return
	end

	for iter_2_0, iter_2_1 in pairs(var_0_8:getShopFlushInfo(var_0_10).normal_goods) do
		local var_2_0 = var_0_3.get(iter_2_1.id)

		if iter_2_1.buy_count < var_2_0.total_limit and self:isNeedBuy(var_2_0) then
			self:send(function()
				g.core.network.GameNetProxy:send_C2S_FlushShop_Buy({
					goods_type = 1,
					num = 1,
					shop_id = var_0_10,
					index = iter_2_0
				})
			end)

			return
		end
	end

	if var_0_0:getArtifactShopFreeNum() > 0 and self._isEnough then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_FlushShop_Flush({
				flush_type = 0,
				shop_id = var_0_10
			})
		end)

		return
	end

	self._isFinish = true
end

function DebugOneKeyShopArtifact:_onS2CGetInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	return "专武商店info更新中"
end

function DebugOneKeyShopArtifact:_onFlushShop(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return "专武商店刷新成功"
end

function DebugOneKeyShopArtifact:_onFlushShopBuy(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = var_0_3.get(var_0_8:getShopFlushInfo(var_0_10).normal_goods[arg_8_4.index].id)
	local var_8_1 = var_0_2:convert({
		type = var_8_0.goods_type,
		value = var_8_0.goods_value,
		size = var_8_0.goods_size
	})

	return "购买：" .. var_8_1.name .. "*" .. var_8_1.size
end

function DebugOneKeyShopArtifact:isNeedBuy(arg_9_1)
	if not self:isEnoughAndNotGold(arg_9_1) then
		return false
	end

	if arg_9_1.goods_type == var_0_2.TYPE_FRAGMENT then
		local var_9_0 = g.core.model.User.fragmentsData:getFragmentNumById(arg_9_1.goods_value)
		local var_9_1 = 0
		local var_9_2 = g.core.config.fragment_info.get(arg_9_1.goods_value)
		local var_9_3 = g.core.model.User.artifactData:getArtifactByAdvacnceId(var_9_2.fragment_value)

		if var_9_3:isOwn() then
			local var_9_4 = var_9_3:getCfg()

			var_9_1 = var_9_4.next_star_num ~= 0 and var_9_4.next_star_num or 0
		else
			var_9_1 = var_9_2.combine_num
		end

		return var_0_2:convert({
			type = var_9_2.fragment_type,
			value = var_9_2.fragment_value,
			size = arg_9_1.goods_size
		}).quality >= var_0_11 or var_9_0 < var_9_1
	end
end

function DebugOneKeyShopArtifact:isEnoughAndNotGold(arg_10_1)
	self._isEnough = true

	for iter_10_0 = 1, var_0_6.FLUSH_COST_MAX_NUM do
		local var_10_0

		if arg_10_1["price_type_" .. iter_10_0] == var_0_2.TYPE_GOLD then
			do return false end

			var_10_0 = arg_10_1["price_type_" .. iter_10_0]
		end

		if arg_10_1["price_size_" .. iter_10_0] > var_0_1:getOwnNum(arg_10_1["price_type_" .. iter_10_0], arg_10_1["price_value_" .. iter_10_0]) then
			self:insertLog("专武商店货币不足")

			self._isEnough = false

			return false
		end
	end

	return true
end

return DebugOneKeyShopArtifact
