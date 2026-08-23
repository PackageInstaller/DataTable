local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.hotSaleGMGiftData
local var_0_2 = g.core.const.ConstMgr.PushGiftConst
local MultilingualMgr = require("app.core.lang.MultilingualMgr")
local RechargeGMGiftBuyPop = class("RechargeGMGiftBuyPop", require("app.fairyGUI.recharge.UI_RechargeGMGiftBuyPop"), function()
	return fgui.GComponent:create({
		resName = "RechargeGMGiftBuyPop",
		pkgName = "recharge",
		pkgPath = "ui/recharge/recharge"
	})
end)

function RechargeGMGiftBuyPop:ctor(arg_2_1)
	self:showAtCenter()

	self._info = arg_2_1
	self._giftAwards = {}

	self:_initBuyPopUI()
end

function RechargeGMGiftBuyPop:_initBuyPopUI()
	self.m_itemList:setVirtual()
	self.m_itemList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_confirmBtn:addClickListener(handler(self, self._onBuyGMPushGift))
end

function RechargeGMGiftBuyPop:_onItemRenderer(arg_4_1, arg_4_2)
	self._giftAwards[arg_4_1 + 1].hideNum = false

	arg_4_2:updateIcon(self._giftAwards[arg_4_1 + 1])
end

function RechargeGMGiftBuyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_OPRECHARGE, handler(self, self._onOpRecharge), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_BUY, handler(self, self._onOpGoldBuyGift), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD, handler(self, self._onPushGiftAwardRecv), self)
	self:_updateView()
end

function RechargeGMGiftBuyPop:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

function RechargeGMGiftBuyPop:_updateView()
	self._giftId = self._info.id
	self._pushGiftInfo = var_0_1:getPushGiftInfo(self._info.push_gift_id)
	self._contentInfo = var_0_1:getPushGiftContentInfo(self._info.gift_id)

	if not self._pushGiftInfo or not self._contentInfo then
		return
	end

	self.m_baseItem:setURL((g.core.common.Path:getRechargeIconById(self._pushGiftInfo.icon_id)))

	self._giftAwards = var_0_1:getGiftAwardsByGiftId(self._info.gift_id)

	self.m_itemList:setNumItems(#self._giftAwards)

	local var_7_0 = self:getGMGiftQuality()

	self.m_itemBg:setURL(var_0_0:getBaseBuyPopItemBg(var_7_0 or 0))

	local var_7_1 = json.decode(self._contentInfo.name)

	if var_7_1 and var_7_1[MultilingualMgr:getUseLang()] then
		self.m_nameTxt:setText(var_7_1[MultilingualMgr:getUseLang()])
	else
		self.m_nameTxt:setText(g.core.lang:get(408326))
	end

	if self.m_nameTxt:getWidth() > 436 then
		self.m_nameTxt:setWidth(436)
		self.m_nameTxt:setAutoSize(3)
	end

	self.m_nameBg:setURL(var_0_0:getBaseBuyPopNameBg(var_7_0 or 0))

	local var_7_2 = var_0_1:getGiftDiscountById(self._info.gift_id)

	self.m_discountTitle:setTitle(g.core.lang:get(307005, {
		num = var_7_2
	}))
	self.m_discountTitle:setVisible(var_7_2 ~= 100)
	self.m_isFreeController:setSelectedIndex(self._contentInfo.price == 0 and 1 or 0)

	if self._contentInfo.buy_type == var_0_2.GOLD_TYPE then
		self.m_priceComp:setDiamond(self._contentInfo.price, self._contentInfo.original_price, true)
	elseif self._contentInfo.buy_type == var_0_2.GOLD_EXCHANGE_TYPE then
		self.m_priceComp:setGold(self._contentInfo.price, self._contentInfo.original_price, true)
	else
		local var_7_3 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.PUSH_GIFT, self._contentInfo.price)

		if var_7_3 then
			self.m_priceComp:setTitle(var_7_3.moneyUnit .. var_7_3.realMoney)
			self.m_priceComp:getChild("originNum"):setText((g.core.model.User.rechargeData:safeCalPriceString(var_7_3.id, self._contentInfo.original_price / self._contentInfo.price, "*")))
		else
			self.m_priceComp:setVisible(false)
		end
	end
end

function RechargeGMGiftBuyPop:_onBuyGMPushGift()
	if self._info then
		g.core.network.GameNetProxy:send_C2S_PushGift_Info({})
		g.core.network.GameNetProxy:send_C2S_PushGift_GetGmActInfo({})

		if not self._info.type or self._info.type == 0 then
			local var_8_0 = var_0_1:getPushGiftContentInfo(self._info.gift_id)

			if var_8_0.buy_type == var_0_2.GOLD_TYPE or var_8_0.buy_type == var_0_2.GOLD_EXCHANGE_TYPE then
				local var_8_1 = g.core.model.User:getFreeGold()

				if var_8_0.buy_type == var_0_2.GOLD_EXCHANGE_TYPE then
					var_8_1 = g.core.model.User:getGold()
				end

				if var_8_1 < var_8_0.price then
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						type = 999,
						value = var_8_0.buy_type == var_0_2.GOLD_EXCHANGE_TYPE and 1 or 0,
						needSize = var_8_0.price,
						curSize = var_8_1,
						func = function(arg_9_0)
							g.core.network.GameNetProxy:send_C2S_PushGift_Buy(arg_9_0)
						end,
						funcParams = {
							id = self._info.id
						}
					})

					return
				end

				g.core.network.GameNetProxy:send_C2S_PushGift_Buy({
					id = self._info.id
				})
			else
				g.core.common.GlobalFunc:checkBagBeforeOpRecharge(g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.PUSH_GIFT, var_8_0.price), self._info.id, 0)
			end
		end
	end
end

function RechargeGMGiftBuyPop:_onCrossDayNotify()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RechargeGMGiftBuyPop:getGMGiftQuality()
	local var_11_0 = 1

	for iter_11_0, iter_11_1 in ipairs(self._giftAwards) do
		local var_11_1 = g.core.common.Goods:convert(iter_11_1)

		if var_11_1 and var_11_0 < var_11_1.quality then
			var_11_0 = var_11_1.quality
		end
	end

	return var_11_0
end

function RechargeGMGiftBuyPop:_onPushGiftAwardRecv(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_12_4.awards)
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RechargeGMGiftBuyPop:_onOpGoldBuyGift(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	g.core.module.ModuleManager:tip(g.core.lang:get(406505))
end

function RechargeGMGiftBuyPop:_onOpRecharge(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	g.core.network.GameNetProxy:send_C2S_PushGift_Info({})
	g.core.network.GameNetProxy:send_C2S_PushGift_GetGmActInfo({})
end

return RechargeGMGiftBuyPop
