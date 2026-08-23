local var_0_0 = g.core.common.Goods
local var_0_1 = {}
local var_0_2 = {
	tipEx = "",
	descIdEx = "",
	titleEx = "",
	tip = "",
	title = ""
}
local AutoBuyComp = class("AutoBuyComp")

function AutoBuyComp:bindComp()
	local var_1_0 = clone(AutoBuyComp)

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_0 ~= "ctor" and iter_1_0 ~= "onUnload" then
			self[iter_1_0] = iter_1_1
		end
	end

	var_1_0.ctor(self)
end

function AutoBuyComp:setDefaultHandler(arg_2_1, arg_2_2, arg_2_3)
	var_0_1[self] = arg_2_1

	if arg_2_2 then
		arg_2_2["_" .. self] = arg_2_1
	end

	if arg_2_3 then
		var_0_1[self](false)
	end
end

function AutoBuyComp:setDefaultConfirmTxtInfo(arg_3_1)
	var_0_2 = self

	if arg_3_1 then
		arg_3_1:setConfirmText(self)
	end
end

function AutoBuyComp:ctor()
	self._autoBuyList = {}
	self._clickHandler = var_0_1.clickHandler
	self._checkFlagHandler = var_0_1.checkFlagHandler
	self._setFlagHandler = var_0_1.setFlagHandler
	self._checkExFlagHandler = var_0_1.checkExFlagHandler
	self._setExFlagHandler = var_0_1.setExFlagHandler

	self:setConfirmText(var_0_2)

	self._lockTime = 0
	self._autoExchange = true
end

function AutoBuyComp:addAutoBuyCompListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, handler(self, self._onBuyItemSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_EXCHANGE, handler(self, self._onExchangeSuc), self)
end

function AutoBuyComp:setConfirmText(arg_6_1)
	self._confirmTitle = arg_6_1.title
	self._confirmDesId = arg_6_1.descId
	self._confirmTip = arg_6_1.tip
	self._confirmTitleEx = arg_6_1.titleEx
	self._confirmDesIdEx = arg_6_1.descIdEx
	self._confirmTipEx = arg_6_1.tipEx
end

function AutoBuyComp:setAutoBuyCompHandler(arg_7_1, arg_7_2)
	self[table.concat({
		"_",
		arg_7_1
	})] = arg_7_2
end

function AutoBuyComp:_getOwnNum(arg_8_1, arg_8_2)
	local var_8_0 = 0

	if arg_8_1 == 999 then
		if arg_8_2 == 0 then
			var_8_0 = g.core.model.User:getFreeGold()
		elseif arg_8_2 == 1 then
			var_8_0 = g.core.model.User:getGold()
		end
	else
		var_8_0 = g.core.model.User.bagData:getOwnNum(arg_8_1, arg_8_2)
	end

	return var_8_0
end

function AutoBuyComp:_lockTouch()
	self._lockTime = g.core.common.ServerTime:getTime() + 2

	g.core.common.Scheduler:newScheduleOnce(handler(self, self._unlockTouch), 1)
end

function AutoBuyComp:_unlockTouch()
	if self._lockTime and g.core.common.ServerTime:getTime() > self._lockTime then
		self._lockTime = 0
	end
end

function AutoBuyComp:setAutoExchangeEnable(arg_11_1)
	self._autoExchange = arg_11_1
end

function AutoBuyComp:_onDoingClick(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if self._lockTime > g.core.common.ServerTime:getTime() then
		return
	end

	local var_12_0 = 0

	if arg_12_1 then
		var_12_0 = self:_getOwnNum(arg_12_1.consumeInfo.type, arg_12_1.consumeInfo.value)
	end

	if not arg_12_1 or var_12_0 >= arg_12_1.consumeInfo.size then
		self._clickHandler(arg_12_2)

		return
	end

	if not self._autoExchange then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource(arg_12_1.consumeInfo)

		return
	end

	if arg_12_1.consumeInfo.type == var_0_0.TYPE_RESOURCE and arg_12_1.consumeInfo.value == var_0_0.RESOURCE.TYPE_GOLD then
		g.view.entrance.ModuleGotoProxy:gotoRechargeQuickPop({
			type = 0,
			needSize = arg_12_1.consumeInfo.size - var_12_0
		})

		return
	end

	if self._touchLock then
		return
	end

	if self._checkFlagHandler() then
		self:_onAutoBuyDoing(arg_12_1, arg_12_2, arg_12_3, arg_12_4)

		return
	end

	local var_12_2 = false

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = self._confirmTitle,
		desc = g.core.lang:get(self._confirmDesId, {
			itemNum = arg_12_1.num,
			itemName = arg_12_1.consumeInfo.name,
			coinNum = arg_12_1.priceInfo.size,
			coinName = arg_12_1.priceInfo.name
		}),
		tip = {
			txt = self._confirmTip
		},
		onCheck = function(arg_13_0)
			var_12_2 = arg_13_0
		end,
		onConfirm = handler(self, function()
			self:_setFlagHandler(var_12_2)
			self:newScheduleOnce(handler(self, function(arg_15_0)
				arg_15_0:_onAutoBuyDoing(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
			end), 0)
		end)
	}), {
		touchDisappear = true
	})
end

function AutoBuyComp:_onAutoBuyDoing(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self._exchangeSucData = arg_16_2
	self._shopId = arg_16_3
	self._costIdx = arg_16_4

	local var_16_0 = self:_getOwnNum(arg_16_1.priceInfo.type, arg_16_1.priceInfo.value)

	if var_16_0 < arg_16_1.priceInfo.size then
		if arg_16_1.priceInfo.type == var_0_0.TYPE_GOLD and arg_16_1.priceInfo.value == 1 then
			g.view.entrance.ModuleGotoProxy:gotoRechargeQuickPop({
				type = 0,
				needSize = arg_16_1.priceInfo.size - var_16_0
			})

			return
		end

		local var_16_1, var_16_2, var_16_3

		if self._checkExFlagHandler and self._checkExFlagHandler() then
			if var_16_0 + g.core.model.User:getGold() < arg_16_1.priceInfo.size then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					value = 1,
					type = 999,
					addFree = true,
					needSize = arg_16_1.priceInfo.size,
					curSize = var_16_0 + g.core.model.User:getGold()
				})
			else
				self._exchangeIng = true

				g.core.network.GameNetProxy:send_C2S_Gold_Exchange({
					gold = arg_16_1.priceInfo.size - var_16_0
				})
			end

			do return end

			var_16_1 = false
			var_16_2 = {
				title = self._confirmTitleEx
			}
			var_16_3 = {
				num = arg_16_1.priceInfo.size - var_16_0
			}
		end

		var_16_3.name = var_0_0:convert({
			type = 999,
			value = 1
		}).name
		var_16_2.desc1 = g.core.lang:get(self._confirmDesIdEx, var_16_3)
		var_16_2.tip = {
			txt = self._confirmTipEx
		}
		var_16_2.onConfirm = handler(self, function()
			if var_16_0 + g.core.model.User:getGold() < arg_16_1.priceInfo.size then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					value = 1,
					type = 999,
					addFree = true,
					needSize = arg_16_1.priceInfo.size,
					curSize = var_16_0 + g.core.model.User:getGold()
				})
			else
				self._exchangeIng = true

				g.core.network.GameNetProxy:send_C2S_Gold_Exchange({
					gold = arg_16_1.priceInfo.size - var_16_0
				})
			end

			self:_setExFlagHandler(var_16_1)
		end)

		function var_16_2.onCheck(arg_18_0)
			var_16_1 = arg_18_0
		end

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_16_2))

		return
	end

	table.insert(self._autoBuyList, arg_16_2)
	g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
		info = {
			id = arg_16_1.id,
			num = arg_16_1.num
		},
		shop_id = arg_16_3,
		cost_idx = arg_16_4
	})
	self:_lockTouch()
end

function AutoBuyComp:_onBuyItemSuc(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if tolua.isnull(self) then
		release_print("AutoBuyComp _onBuyItemSuc ERROR")

		return
	end

	local var_19_0 = arg_19_4.info.id
	local var_19_1

	for iter_19_0, iter_19_1 in ipairs(self._autoBuyList) do
		if iter_19_1.itemInfo.id == var_19_0 and iter_19_1.itemInfo.num == arg_19_4.info.num then
			var_19_1 = table.remove(self._autoBuyList, iter_19_0)

			break
		end
	end

	if var_19_1 then
		self:_unlockTouch()
		self._clickHandler(var_19_1)
	end
end

function AutoBuyComp:_onExchangeSuc(arg_20_1, arg_20_2, arg_20_3)
	if self._exchangeIng then
		self._exchangeIng = false

		table.insert(self._autoBuyList, self._exchangeSucData)
		g.core.network.GameNetProxy:send_C2S_Shop_Shopping({
			info = {
				id = self._exchangeSucData.itemInfo.id,
				num = self._exchangeSucData.itemInfo.num
			},
			shop_id = self._shopId,
			cost_idx = self._costIdx
		})
		self:_lockTouch()
	end
end

return AutoBuyComp
