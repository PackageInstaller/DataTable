local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostExchangeBuild = class("OutpostExchangeBuild", (require("app.view.module.outpost.model.struct.build.OutpostBuildBaseStruct")))

function OutpostExchangeBuild:ctor(arg_1_1, arg_1_2)
	self._groupToIdsDic = {}
	self._exchangeItemList = {}
	self._costIdToIdDic = {}
	self._curItems = {}
	self._sellDic = {}

	OutpostExchangeBuild.super.ctor(self, arg_1_1, arg_1_2)
end

function OutpostExchangeBuild:_initBuild()
	self._tab = g.core.config.outpost_exchange_building_info

	OutpostExchangeBuild.super._initBuild(self)

	for iter_2_0 = 1, g.core.config.outpost_exchange_item_info.getLength() do
		local var_2_0 = g.core.config.outpost_exchange_item_info.indexOf(iter_2_0)
		local var_2_1 = self._groupToIdsDic[var_2_0.commodity_group]

		if not self._groupToIdsDic[var_2_0.commodity_group] then
			var_2_1 = {}
			self._groupToIdsDic[var_2_0.commodity_group] = var_2_1
		end

		var_2_1[#var_2_1 + 1] = var_2_0.id
	end
end

function OutpostExchangeBuild:canChangePos()
	return true
end

function OutpostExchangeBuild:_updateByLevel(arg_4_1)
	OutpostExchangeBuild.super._updateByLevel(self)

	if arg_4_1 then
		self._costIdToIdDic = {}
		self._exchangeItemList = {}

		local var_4_0 = {}

		for iter_4_0 = 1, self._level do
			var_4_0[#var_4_0 + 1] = self._tab.get(self._levelToIdDic[iter_4_0]).commodity_group
		end

		self:_updateExchangeItem(var_4_0)
	end
end

function OutpostExchangeBuild:_updateExchangeItem(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		for iter_5_2, iter_5_3 in ipairs(self._groupToIdsDic[iter_5_1]) do
			local var_5_0 = g.core.config.outpost_exchange_item_info.get(iter_5_3)

			self._exchangeItemList[#self._exchangeItemList + 1] = var_5_0
			self._costIdToIdDic[var_5_0.item_value] = var_5_0.id
		end
	end
end

function OutpostExchangeBuild:getBuildInfo()
	return
end

function OutpostExchangeBuild:updateBuildBySvr(arg_7_1)
	OutpostExchangeBuild.super.updateBuildBySvr(self, arg_7_1)

	self._curItems = arg_7_1.cur_items or {}
end

function OutpostExchangeBuild:onEffect(arg_8_1)
	OutpostExchangeBuild.super.onEffect(self, arg_8_1)

	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1.orderType

	if var_0_0.EXCHANGE_TYPE.PRODUCE == arg_8_1.orderType then
		-- block empty
	elseif var_0_0.EXCHANGE_TYPE.PUBLISH == var_8_0 then
		self:_doPublish(arg_8_1)
	elseif var_0_0.EXCHANGE_TYPE.SELL == var_8_0 then
		self:_doSell(arg_8_1)
	end
end

function OutpostExchangeBuild:_doPublish(arg_9_1)
	if arg_9_1.isChanged then
		self:_sendOrderChangedToSever(arg_9_1)
	else
		self:_sendOrderProcessToSever(arg_9_1)
	end
end

function OutpostExchangeBuild:_doSell(arg_10_1)
	local var_10_0 = g.core.model.User.outpostData:getBagData():getOwnNum(var_0_0.KNIGHT_COIN_ID)

	for iter_10_0, iter_10_1 in ipairs((g.core.model.User.outpostData:getKnightsData():getKnightBySid(arg_10_1.knightId):getOwnBagData())) do
		local var_10_1, var_10_2, var_10_3 = self:canBuyItemByIdAndNum(iter_10_1.item_id, iter_10_1.item_num, var_10_0)

		if var_10_2 > 0 then
			local var_10_4 = math.min(var_10_2, iter_10_1.item_num)
			local var_10_5 = {
				knightId = arg_10_1.knightId,
				orderType = arg_10_1.orderType,
				itemId = self._costIdToIdDic[iter_10_1.item_id],
				num = var_10_4
			}
			local var_10_6 = self:getOrderInfo(self._costIdToIdDic[iter_10_1.item_id])

			var_10_6.tempNum = var_10_6.num - var_10_4

			if self:_checkIsNeedSendSell(var_10_5) then
				self:_sendOrderProcessToSever(var_10_5)
			end

			var_10_0 = var_10_3
		end
	end
end

function OutpostExchangeBuild:_checkIsNeedSendSell(arg_11_1)
	local var_11_0 = false
	local var_11_1 = self._sellDic[arg_11_1.knightId] or {}
	local var_11_2 = var_11_1[arg_11_1.itemId]

	if not var_11_1[arg_11_1.itemId] then
		self:_onAddSellInfo(arg_11_1.knightId, arg_11_1.itemId, arg_11_1.num)

		var_11_0 = true
	else
		var_11_2.enableCnt = var_11_2.enableCnt - 1

		if var_11_2.enableCnt <= 0 then
			self:_onSellInfoRemove(arg_11_1.knightId, arg_11_1.itemId)
		end
	end

	return var_11_0
end

function OutpostExchangeBuild:_sendOrderProcessToSever(arg_12_1)
	g.core.network.GameNetProxy:send_C2S_Outpost_Build_OrderProcess({
		build_tp = self._type,
		order_tp = arg_12_1.orderType,
		knight_id = arg_12_1.knightId,
		target_id = arg_12_1.itemId,
		target_num = arg_12_1.num
	})
end

function OutpostExchangeBuild:_sendOrderChangedToSever(arg_13_1)
	g.core.network.GameNetProxy:send_C2S_Outpost_Build_ChangeOrder({
		build_tp = self._type,
		order_id = arg_13_1.itemId,
		order_num = arg_13_1.num
	})
end

function OutpostExchangeBuild:getExchangeItemList(arg_14_1)
	local var_14_0 = self._exchangeItemList

	if arg_14_1 then
		var_14_0 = {}

		local var_14_1 = g.core.model.User.outpostData:getBuildData()

		for iter_14_0, iter_14_1 in ipairs(self._exchangeItemList) do
			if not var_14_1:getBuild({
				type = iter_14_1.building_type
			}):isLockBuild() then
				var_14_0[#var_14_0 + 1] = {
					cfg = iter_14_1,
					orderInfo = self:getOrderInfo(iter_14_1.id)
				}
			end
		end
	end

	return var_14_0
end

function OutpostExchangeBuild:setOrderInfoAndSyncTime(arg_15_1, arg_15_2)
	local var_15_0 = self:getOrderInfo(arg_15_1)

	if arg_15_2 > 0 then
		var_15_0 = var_15_0 or self:_createOrderInfo(arg_15_1, true)

		self:onEffect({
			knightId = 0,
			orderType = var_0_0.EXCHANGE_TYPE.PUBLISH,
			itemId = var_15_0.id,
			num = arg_15_2,
			isChanged = not var_15_0.isTemp
		})
	elseif var_15_0 and not var_15_0.isTemp then
		self:onEffect({
			knightId = 0,
			num = 0,
			isChanged = true,
			orderType = var_0_0.EXCHANGE_TYPE.PUBLISH,
			itemId = var_15_0.id
		})
	end
end

function OutpostExchangeBuild:_onOrderChanged(arg_16_1)
	if arg_16_1 and arg_16_1.num < 0 then
		self:_onSellInfoRemove(arg_16_1.knightSid, arg_16_1.id)
	end
end

function OutpostExchangeBuild:_onAddSellInfo(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = self._sellDic[arg_17_1] or {}

	var_17_0[arg_17_2] = {
		enableCnt = 100,
		num = arg_17_3
	}
	self._sellDic[arg_17_1] = var_17_0
end

function OutpostExchangeBuild:_onSellInfoRemove(arg_18_1, arg_18_2)
	if self._sellDic[arg_18_1] then
		self._sellDic[arg_18_1][arg_18_2] = nil
	end
end

function OutpostExchangeBuild:syncDirtyOrderInfo(arg_19_1)
	local var_19_0 = self:getOrderInfo(arg_19_1)

	if var_19_0.syncTime and g.core.common.ServerTime:getTime() >= var_19_0.syncTime then
		var_19_0.syncTime = nil

		self:onEffect({
			knightId = 0,
			orderType = var_0_0.EXCHANGE_TYPE.PUBLISH,
			itemId = var_19_0.id,
			num = var_19_0.num,
			isChanged = not var_19_0.isTemp
		})
	end
end

function OutpostExchangeBuild:canSellByKnightBag(arg_20_1)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		if self:canBuyItemByIdAndNum(iter_20_1.item_id, 1) then
			var_20_0 = true

			break
		end
	end

	return var_20_0
end

function OutpostExchangeBuild:canBuyItemByIdAndNum(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_1 == var_0_0.KNIGHT_COIN_ID then
		return false, 0
	end

	local var_21_0 = self._costIdToIdDic[arg_21_1]
	local var_21_1 = self:getOrderInfo(self._costIdToIdDic[arg_21_1])

	if not var_21_1 then
		return false, 0
	end

	local var_21_2 = g.core.config.outpost_exchange_item_info.get(var_21_0)
	local var_21_3 = math.min(arg_21_2, var_21_1.tempNum or var_21_1.num)
	local var_21_4 = var_21_3 * var_21_2.gold

	arg_21_3 = arg_21_3 or g.core.model.User.outpostData:getBagData():getOwnNum(var_0_0.KNIGHT_COIN_ID)

	local var_21_5 = var_21_4 <= arg_21_3

	if var_21_4 > arg_21_3 then
		var_21_3 = math.floor(arg_21_3 / var_21_2.gold)
	end

	return var_21_5, var_21_3, arg_21_3 - var_21_4
end

return OutpostExchangeBuild
