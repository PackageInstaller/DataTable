local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User
local var_0_4 = g.core.const.ConstMgr.RechargeConst
local RechargeGiftPop = class("RechargeGiftPop", require("app.fairyGUI.recharge.UI_RechargeGiftPop"), function()
	return fgui.GComponent:create({
		resName = "RechargeGiftPop",
		pkgPath = "ui/recharge/recharge",
		pkgName = "recharge"
	})
end)

function RechargeGiftPop:ctor(arg_2_1, arg_2_2)
	self._info = arg_2_1

	if self._info.recharge_type ~= 0 then
		self._rechargeInfo = var_0_3.rechargeData:getRechargeInfoByTypeAndPrice(self._info.recharge_type, self._info.recharge_money, self._info.special)
	end

	self._canBuy = true
	self._dropMode = 0
	self._freeBuyCallBack = arg_2_1.freeCallBack
	self._clickCall = arg_2_1.clickCall
	self._isCrossDayClose = arg_2_2 or false

	self:showAtCenter()
	self:_initComp()
	self:_addListener()
end

function RechargeGiftPop:onLoad()
	self:_addNetWorkListener()
	self:_updateView()
end

function RechargeGiftPop:_initComp()
	self:_initData()
	self:_initUI()
end

function RechargeGiftPop:_initData()
	return
end

function RechargeGiftPop:_initUI()
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))
end

function RechargeGiftPop:_addListener()
	self.m_confirmBtn:addClickListener(handler(self, self._onBuy))
end

function RechargeGiftPop:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
end

function RechargeGiftPop:_onCrossDay()
	if self._isCrossDayClose then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RechargeGiftPop:_onItemRenderer(arg_10_1, arg_10_2)
	self._giftList[arg_10_1 + 1].hideNum = false

	arg_10_2:updateIcon(self._giftList[arg_10_1 + 1])
end

function RechargeGiftPop:_updateView()
	self.m_baseItem:setURL(g.core.common.Path:getRechargeIconById(self._info.icon or self._info.res))
	self.m_itemBg:setURL(var_0_2:getBaseBuyPopItemBg(self._info.quality or 0))
	self.m_nameTxt:setText(self._info.name)

	if self.m_nameTxt:getWidth() > 436 then
		self.m_nameTxt:setWidth(436)
		self.m_nameTxt:setAutoSize(3)
	end

	self.m_nameBg:setURL(var_0_2:getBaseBuyPopNameBg(self._info.quality or 0))
	self:_initGiftInfo(self._info.value)

	if self._info.recharge_money == 0 and (not self._info.diamond_price or self._info.diamond_price == 0) and (not self._info.free_diamond or self._info.free_diamond == 0) then
		self.m_isFreeController:setSelectedIndex(1)

		if self._dropMode == var_0_4.FREE_GIFT_DROP_MODE.RANDOM_MODE then
			self.m_giftDesc:setText(g.core.lang:get(407001))
		elseif self._dropMode == var_0_4.FREE_GIFT_DROP_MODE.ALL_MODE then
			self.m_giftDesc:setText(g.core.lang:get(407002))
		end
	elseif self._info.forceShowReceive then
		self.m_isFreeController:setSelectedIndex(1)

		if self._rechargeInfo then
			self.m_priceComp:setPriceByInfo(self._rechargeInfo)
		elseif self._info.diamond_price then
			self.m_priceComp:setGoldBig(self._info.diamond_price)
		else
			self.m_priceComp:setDiamond(self._info.recharge_money)
		end
	else
		self.m_isFreeController:setSelectedIndex(0)

		if self._rechargeInfo then
			if self._rechargeInfo.recharge_type == var_0_4.RECHARGE_TYPE.USER_BACK then
				self.m_showOriginController:setSelectedIndex(1)

				if self._info.isDiamond then
					self.m_originPriceComp:setGold(self._info.recharge_money, self._info.original_price, true)
				else
					self.m_originPriceComp:setTitle(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)
					self.m_originPriceComp:getChild("originNum"):setText(self._rechargeInfo.moneyUnit .. ((config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA or nil) and g.core.model.User.rechargeData:safeCalPriceString(self._rechargeInfo.id, self._info.origin_price / self._info.pay_value, "*")))
				end
			else
				self.m_priceComp:setPriceByInfo(self._rechargeInfo)
				self.m_showOriginController:setSelectedIndex(0)
			end
		elseif self._info.diamond_price > 0 then
			self.m_priceComp:setGoldBig(self._info.diamond_price)

			if self._info.original_price then
				self.m_showOriginController:setSelectedIndex(1)
				self.m_originPriceComp:setGold(self._info.diamond_price, self._info.original_price, true)
			else
				self.m_showOriginController:setSelectedIndex(0)
			end
		elseif self._info.free_diamond and self._info.free_diamond > 0 then
			self.m_priceComp:setDiamond(self._info.free_diamond)
		else
			self.m_priceComp:setDiamond(self._info.recharge_money)
		end
	end

	if self._info.limit_type == var_0_4.GIFT_LIMIT_TYPE.NORMAL then
		self.m_isLimitController:setSelectedIndex(0)
		self.m_hasNumController:setSelectedIndex(1)
	else
		self.m_isLimitController:setSelectedIndex(1)

		local var_11_2 = self._info.times - self._info.buyTimes
		local var_11_3 = 107063

		if self._info.limit_type == var_0_4.GIFT_LIMIT_TYPE.DAILY then
			var_11_3 = 107061
		elseif self._info.limit_type == var_0_4.GIFT_LIMIT_TYPE.WEEKLY then
			var_11_3 = 107062
		elseif self._info.limit_type == var_0_4.GIFT_LIMIT_TYPE.MONTHLY then
			var_11_3 = 107064
		elseif self._info.limit_type == 4 and self._info.activity_type == 40 or self._info.limit_type == 4 and self._info.activity_type == 32 or self._info.limit_type == 4 and self._info.activity_type == 42 then
			var_11_3 = 410314
		end

		self.m_limitTxt:setText(g.core.lang:get(var_11_3) .. " " .. g.core.lang:get(107056, {
			num = var_11_2,
			maxNum = self._info.times
		}))

		if var_11_2 > 0 then
			self.m_hasNumController:setSelectedIndex(1)
		else
			self._canBuy = false

			self.m_hasNumController:setSelectedIndex(0)
		end
	end

	if self._info.buy_level and self._info.buy_level > 0 then
		if var_0_3:getLevel() < self._info.buy_level then
			self.m_hasNumController:setSelectedIndex(2)
			self.m_levelText:setText(g.core.lang:get(107028, {
				level = self._info.buy_level
			}))
		end
	end

	if self._info.discount ~= 100 and self._info.discount ~= 0 then
		self.m_isDiscountController:setSelectedIndex(1)
		self.m_discountTitle:setTitle(self._info.discount .. "%")
	else
		self.m_isDiscountController:setSelectedIndex(0)
	end

	if self._info.buy_activated ~= nil and self._info.buy_activated == false then
		self.m_isActivatedController:setSelectedIndex(0)
		self.m_popPanel:setTitle(g.core.lang:get(408311))
	else
		self.m_isActivatedController:setSelectedIndex(1)
	end
end

function RechargeGiftPop:_getGiftInfo(arg_12_1)
	local var_12_0 = {}

	for iter_12_0 = 1, g.core.config.drop_info.getLength() do
		local var_12_1 = g.core.config.drop_info.indexOf(iter_12_0)

		if var_12_1.id == arg_12_1 then
			table.insert(var_12_0, var_12_1)
		end
	end

	return var_12_0
end

function RechargeGiftPop:_initGiftInfo(arg_13_1)
	self._giftList = {}

	for iter_13_0, iter_13_1 in ipairs((self:_getGiftInfo(arg_13_1))) do
		for iter_13_2 = 1, 5 do
			if iter_13_1["reward_type_" .. iter_13_2] > 0 then
				local var_13_0 = {
					type = iter_13_1["reward_type_" .. iter_13_2],
					value = iter_13_1["reward_value_" .. iter_13_2]
				}

				if iter_13_1["reward_min_" .. iter_13_2] ~= iter_13_1["reward_max_" .. iter_13_2] then
					var_13_0.min = iter_13_1["reward_min_" .. iter_13_2]
					var_13_0.max = iter_13_1["reward_max_" .. iter_13_2]
				else
					var_13_0.size = iter_13_1["reward_min_" .. iter_13_2]
				end

				table.insert(self._giftList, var_13_0)
			end
		end

		self._dropMode = iter_13_1.drop_mode
	end

	self.m_itemList:setNumItems(#self._giftList)
end

function RechargeGiftPop:_quickBuy()
	g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeGiftAward({
		id = self._info.id
	})
end

function RechargeGiftPop:_onBuy()
	if self._canBuy then
		if self._clickCall then
			self._clickCall()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		elseif self._info.recharge_money == 0 then
			if self._freeBuyCallBack then
				self._freeBuyCallBack()

				self._freeBuyCallBack = nil
			elseif self._info.diamond_price and self._info.diamond_price > 0 and self._info.diamond_price > g.core.model.User:getGold() then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = 999,
					value = 1,
					funcParams = {
						id = self._info.id
					},
					needSize = self._info.diamond_price,
					curSize = g.core.model.User:getGold(),
					func = function(arg_16_0)
						g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeGiftAward(arg_16_0)
					end
				})
			elseif self._info.free_diamond and self._info.free_diamond > 0 and self._info.free_diamond > g.core.model.User:getFreeGold() then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					type = 999,
					value = 0,
					funcParams = {
						id = self._info.id
					},
					needSize = self._info.free_diamond,
					curSize = g.core.model.User:getFreeGold(),
					func = function(arg_17_0)
						g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeGiftAward(arg_17_0)
					end
				})
			else
				g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeGiftAward({
					id = self._info.id
				})
			end

			if not self._hasPop then
				self._hasPop = true

				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end
		elseif not self._info.task_id then
			g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, self._info.id, 0)

			if not self._hasPop then
				self._hasPop = true

				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end
		else
			if self._info.gift_type == 1 then
				g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, self._info.id, self._info.task_id)
			elseif self._info.gift_type == 2 then
				local var_15_0 = g.core.model.User:getFreeGold()

				if var_15_0 < self._info.gift_price then
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						value = 0,
						type = 999,
						curSize = var_15_0,
						needSize = self._info.gift_price
					})
					g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

					return
				end

				g.core.network.GameNetProxy:send_C2S_Recharge_BuyRechargeRebateGift({
					id = self._info.task_id
				})
			else
				local var_15_1 = g.core.model.User:getGold()

				if var_15_1 < self._info.gift_price then
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						type = 999,
						value = 1,
						curSize = var_15_1,
						needSize = self._info.gift_price,
						funcParams = {
							id = self._info.task_id
						},
						func = function(arg_18_0)
							g.core.network.GameNetProxy:send_C2S_Recharge_BuyRechargeRebateGift(arg_18_0)
						end
					})
					g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

					return
				end

				g.core.network.GameNetProxy:send_C2S_Recharge_BuyRechargeRebateGift({
					id = self._info.task_id
				})
			end

			if not self._hasPop then
				self._hasPop = true

				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end
		end
	end
end

return RechargeGiftPop
