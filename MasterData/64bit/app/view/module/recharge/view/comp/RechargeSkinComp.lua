local var_0_0 = g.core.model.User.knightsData
local var_0_1 = g.core.model.User.rechargeData
local var_0_2 = g.core.model.User.skinData
local var_0_3 = g.core.model.User.skinGoodsData
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.const.ConstMgr.ShopConst
local var_0_6 = g.core.common.Goods
local var_0_7 = 0.5
local RechargeSkinComp = class("RechargeSkinComp", require("app.fairyGUI.recharge.UI_RechargeSkinComp"))

function RechargeSkinComp:ctor()
	self._info = nil
	self._skinGoodsList = nil
	self._screenData = nil
	self._curSkin = nil
	self._canBuy = false
	self._selectedIndex = 0
	self._themeIndex = 0
	self._isTicketBuy = false
	self._verticalDiff = 0
	self._horizontalDiff = 0

	self:_initView()
end

function RechargeSkinComp:_initView()
	self.m_skinBookBtn:addClickListener(handler(self, self._onShowSkinBook))
	self.m_showBtn:addClickListener(handler(self, self._onShowSkin))
	self.m_screenBtn:addClickListener(handler(self, self._onScreenStart))
	self.m_cancelScreenBtn:addClickListener(handler(self, self._onCancelScreen))
	self.m_ticketScreenBtn:addClickListener(handler(self, self._onTicketScreenStart))
	self.m_discountBuyBtn:addClickListener(handler(self, self._onBuy))
	self.m_buyBtn:addClickListener(handler(self, self._onBuy))
	self.m_ticketBtn:addClickListener(handler(self, self._onTicketBuy))
	self.m_touchBg:addClickListener(handler(self, self._onClickTouchBg))
	self.m_knightPicComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchSkinBegin))
	self.m_knightPicComp:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchSkinMove))
	self.m_knightPicComp:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchSkinEnd))
	self.m_skinList:setWidth(self:getWidth() - cc.Director:getInstance():getSafeAreaRect().x)
	self.m_skinList:setVirtual()
	self.m_skinList:doFairyBatching(false)
	self.m_skinList:setItemRenderer(handler(self, self._onSkinListRender))
	self.m_skinList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickList))
	self:addListen(self.m_skinList)
	self.m_skinAttrGroup:setVisible(false)

	if g.core.utils.Rule.isHideSkinHandbook() then
		self.m_skinBookBtn:setVisible(false)
	end
end

function RechargeSkinComp:_onTouchSkinBegin(arg_3_1)
	arg_3_1:captureTouch()

	local var_3_0 = arg_3_1:getInput()
	local var_3_1 = self:_coordinateRevert(var_3_0:getTouch():getLocation())

	self._verticalDiff = var_3_0.y - var_3_1.y
	self._horizontalDiff = var_3_1.x - self.m_knightPicComp:getPosition().x
end

function RechargeSkinComp:_onTouchSkinMove(arg_4_1)
	arg_4_1:captureTouch()

	local var_4_0 = self:_coordinateRevert(arg_4_1:getInput():getTouch():getLocation())
	local var_4_1 = cc.Director:getInstance():getSafeAreaRect()

	self.m_knightPicComp:setPosition(cc.p(math.clamp(var_4_0.x - self._horizontalDiff, var_4_1.x, display.width - var_4_1.x), (math.clamp(var_4_0.y + self._verticalDiff, -50, display.height - 130))))
end

function RechargeSkinComp:_coordinateRevert(arg_5_1)
	return cc.p(arg_5_1.x, display.height - arg_5_1.y)
end

function RechargeSkinComp:_onTouchSkinEnd(arg_6_1)
	self._verticalDiff = 0
end

function RechargeSkinComp:_onShowSkinBook()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SKIN_BOOK)
end

function RechargeSkinComp:_onShowSkin()
	if self._curSkin and self._curSkin.skin_id then
		g.core.common.GlobalFunc.pushInfoPop((var_0_6:convert({
			type = var_0_6.TYPE_SKIN,
			value = self._curSkin.skin_id
		})))
	end
end

function RechargeSkinComp:_onScreenStart()
	local var_9_0 = require("app.view.module.recharge.view.SkinScreenPop").new({
		index = self._themeIndex
	})

	self:addListen(var_9_0)
	g.core.module.ModuleManager:pushPopup(var_9_0)
end

function RechargeSkinComp:_onTicketScreenStart()
	self._isTicketBuy = not self._isTicketBuy

	self:_updateSkinList()
end

function RechargeSkinComp:_onCancelScreen()
	self:_onScreenStart()
end

function RechargeSkinComp:_onBuy(arg_12_1, arg_12_2)
	if self._curSkin then
		if self._curSkin.sale_value == var_0_5.SHOP_SKIN_TYPE.GM_SKIN then
			if self._canBuy == 1 then
				self:_buySkin(nil, arg_12_2)
			end
		elseif self._canBuy then
			if self._curSkin.sale_value == 1 then
				self:_buySkin(nil, arg_12_2)
			else
				g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.SkinBuyConfirmPop").new(self._curSkin))
			end
		elseif not self._canBuy then
			g.core.module.ModuleManager:tip(g.core.lang:get(107067))
		end
	end
end

function RechargeSkinComp:_onTicketBuy()
	self:_onBuy(nil, true)
end

function RechargeSkinComp:_onClickTouchBg()
	if self.m_isShowController:getSelectedIndex() == 1 then
		-- block empty
	end
end

function RechargeSkinComp:_onSkinListRender(arg_15_1, arg_15_2)
	if self._skinGoodsList and self._skinGoodsList[arg_15_1 + 1] then
		arg_15_2:updateCell(self._skinGoodsList[arg_15_1 + 1])
	end
end

function RechargeSkinComp:_onClickList()
	if self._selectedIndex ~= self.m_skinList:getSelectedIndex() then
		self.m_switchTransition:play()
		self:_updateSelectedSkin(true)
	end
end

function RechargeSkinComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SKIN_SCREEN, handler(self, self._onScreen), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SKINSHOPPING, handler(self, self._onShopping), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SKIN_SHOP_GM_INFO, handler(self, self._onRecGmSkinInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SKINSHOPBYITEM, handler(self, self._onShopping), self)

	if g.core.platform.ServerListProxy:isTesting() then
		self.m_skinBookBtn:setVisible(false)
	end
end

function RechargeSkinComp:onUnload()
	var_0_3:saveOldSkin()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RECHARGE_SKIN_REFRESH_POINT)

	if self._awardSchedule then
		self:cancelSchedule(self._awardSchedule)

		self._awardSchedule = nil
	end
end

function RechargeSkinComp:updateComp(arg_19_1)
	self._info = arg_19_1.info

	g.core.network.GameNetProxy:send_C2S_SkinShopGMInfo({})

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function RechargeSkinComp:_updateSkinList(arg_20_1)
	self:_getSkinGoodsInfo()
	self.m_screenGroup:setVisible(var_0_3:hasTheme())

	if #self._skinGoodsList > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_skinList:setNumItems(#self._skinGoodsList)

		self._selectedIndex = 0

		self.m_skinList:setSelectedIndex(self._selectedIndex)

		if not arg_20_1 then
			self.m_skinList:transitionShowCells("enter_left", 0.03)
		end

		self:_updateSelectedSkin()
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_ticketScreenGroup:setVisible(self:_needCheckTicket())
end

function RechargeSkinComp:_needCheckTicket()
	local var_21_0 = {}

	var_21_0 = self._info.shop_first == var_0_5.RECHARGE_SKIN_VALUE.RECHARGE and (var_0_3:getSkinGoodsListByForAllSkin(self._screenData) or {}) or var_0_3:getSkinGoodsListBySaleValue(2, self._screenData) or {}

	if not var_21_0 or #var_21_0 < 1 then
		return false
	end

	local var_21_1 = #var_21_0
	local var_21_2 = 0

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if var_0_3:isCanTicketBuy(iter_21_1) then
			var_21_2 = var_21_2 + 1
		end
	end

	return var_21_2 ~= 0 and var_21_2 ~= var_21_1
end

function RechargeSkinComp:_getSkinGoodsInfo()
	self._skinGoodsList = self._info.shop_first == var_0_5.RECHARGE_SKIN_VALUE.RECHARGE and (var_0_3:getSkinGoodsListByForAllSkin(self._screenData) or {}) or var_0_3:getSkinGoodsListBySaleValue(2, self._screenData) or {}

	self:_filterSkinGoodsList()
end

function RechargeSkinComp:_filterSkinGoodsList()
	if not self._isTicketBuy then
		return
	end

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in ipairs(self._skinGoodsList) do
		if var_0_3:isCanTicketBuy(iter_23_1) then
			table.insert(var_23_0, iter_23_1)
		end
	end

	self._skinGoodsList = var_23_0
end

function RechargeSkinComp:_updateSelectedSkin(arg_24_1)
	if #self._skinGoodsList < 1 then
		self._selectedIndex = 0

		self.m_skinAttrGroup:setVisible(false)

		return
	end

	self._selectedIndex = self.m_skinList:getSelectedIndex()

	if arg_24_1 and self._curSkin ~= nil then
		self.m_knightPicComp2:setVisible(true)
		self.m_knightPicComp2:updateKnight({
			resId = tonumber(self._curSkin.res)
		})
	else
		self.m_knightPicComp2:setVisible(false)
	end

	self._curSkin = self._skinGoodsList[self._selectedIndex + 1]

	self.m_skinNameTxt:setText(self._curSkin.name)
	self.m_knightNameTxt:setText(g.core.config.knight_info.get(self._curSkin.skinInfo.knight_advance_id).name)
	self.m_knightPicComp:updateKnight({
		isCustom = true,
		resId = tonumber(self._curSkin.skinInfo.res)
	})
	self.m_ticketBtn:setVisible(var_0_3:isCanTicketBuy(self._curSkin))
	self.m_ticketBtn:setTitle(g.core.lang:get(204025, {
		price = var_0_3:getTicketPrice(self._curSkin)
	}))
	self.m_isLimitController:setSelectedIndex(self._curSkin.skinInfo.limit == 1 and 1 or 0)

	if self._curSkin.time_limit == 0 then
		self.m_isTimeLimitController:setSelectedIndex(0)
	else
		self.m_isTimeLimitController:setSelectedIndex(1)
		self.m_timeTxt:setText(g.core.lang:get(107065, {
			time = self._curSkin.remainingTime
		}))
	end

	if self._curSkin.sale_value == g.core.const.ConstMgr.ShopConst.SHOP_SKIN_TYPE.GM_SKIN then
		self._canBuy = var_0_2:getGmSkinBuyState(self._curSkin.skin_id)

		self.m_canBuyController:setSelectedIndex(self._canBuy)

		local var_24_0 = var_0_2:getGMSkinSellEndTime(self._curSkin.skin_id)

		if var_24_0 ~= 0 then
			self.m_isTimeLimitController:setSelectedIndex(1)

			local var_24_1 = g.core.common.ServerTime:getLeftTimeParts(var_24_0)

			if var_24_1 > 0 then
				self.m_timeTxt:setText(g.core.lang:get(107065, {
					time = var_24_1
				}))
			else
				self.m_timeTxt:setText(g.core.lang:get(107100))
			end
		end
	else
		self._canBuy = var_0_2:getSkinState(self._curSkin.skin_id) ~= 1

		self.m_canBuyController:setSelectedIndex(self._canBuy and 1 or 0)
	end

	if self._curSkin then
		local var_24_2, var_24_3 = var_0_2:isActivitySkinInDiscountTime(self._curSkin.skin_id)

		self.m_discountBuyBtn:setVisible(var_24_2)
		self.m_buyBtn:setVisible(not var_24_2)

		if var_24_2 then
			self.m_discountBuyBtn:updateBtn(self._curSkin.gmActivityInfo.discount_price, self._curSkin.gmActivityInfo.original_price, true)
		else
			self.m_buyBtn:setTitle((self:_getBuyPriceWithoutDiscount()))
		end
	end

	self.m_skinAttrGroup:setVisible(true)

	local var_24_4, var_24_5 = var_0_3:getSkinTalentSkillBySkinId(self._curSkin.skin_id)

	self.m_attrTxt:setText((var_24_5 ~= "" or nil) and var_24_4 .. "\n" .. var_24_5)
end

function RechargeSkinComp:_getBuyPriceWithoutDiscount()
	local var_25_0 = ""

	if self._curSkin.sale_value == var_0_5.SHOP_SKIN_TYPE.GM_SKIN then
		var_25_0 = g.core.lang:get(407906, {
			price = self._curSkin.gmActivityInfo.original_price
		})
	else
		local var_25_1 = var_0_1:getRechargeInfoByTypeAndPrice(self._curSkin.recharge_type, self._curSkin.recharge_money)

		var_25_0 = var_25_1.moneyUnit .. var_25_1.realMoney
	end

	return var_25_0
end

function RechargeSkinComp:_onScreen(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if self:isVisible() then
		self._screenData = arg_26_4

		if next(arg_26_4.theme) == nil then
			self.m_isScreenController:setSelectedIndex(0)
		else
			self.m_isScreenController:setSelectedIndex(1)

			for iter_26_0, iter_26_1 in pairs(arg_26_4.theme) do
				self.m_cancelScreenBtn:setTitle(g.core.config.skin_theme_info.get(iter_26_1).name)
			end
		end

		self:_updateSkinList()
		g.core.module.ModuleManager:tip(g.core.lang:get(204013))
	end
end

function RechargeSkinComp:_onShopping(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if arg_27_4.awards and self:isVisible() then
		self:_updateSkinList(true)

		self._awardSchedule = self:newScheduleOnce(handler(self, function()
			g.core.module.ModuleManager:awardSummary(arg_27_4.awards)
		end), var_0_7)
	end
end

function RechargeSkinComp:checkSelectedSkinIndex(arg_29_1)
	local var_29_0 = false
	local var_29_1 = 0

	self:_getSkinGoodsInfo()

	if self._skinGoodsList and #self._skinGoodsList > 0 then
		for iter_29_0, iter_29_1 in ipairs(self._skinGoodsList) do
			if iter_29_1.skin_id and iter_29_1.skin_id == arg_29_1 then
				var_29_0 = true
				var_29_1 = iter_29_0 - 1

				break
			end
		end
	end

	if var_29_0 and self._selectedIndex ~= var_29_1 then
		self._selectedIndex = var_29_1

		self:_updateSkinList(false)
	end
end

function RechargeSkinComp:_onRecGmSkinInfo()
	self:_updateSkinList()
end

function RechargeSkinComp:_buySkin(arg_31_1, arg_31_2)
	local var_31_0 = self._curSkin

	if arg_31_1 then
		var_31_0 = arg_31_1
	end

	local var_31_1 = var_31_0.recharge_type
	local var_31_2 = var_31_0.recharge_money
	local var_31_3 = 0

	if var_31_0.sale_value == g.core.const.ConstMgr.ShopConst.SHOP_SKIN_TYPE.GM_SKIN then
		var_31_1 = 22
		var_31_2 = var_0_2:getGmSkinCurMoney(var_31_0.skin_id)
	end

	if arg_31_2 then
		var_31_1 = 3
		var_31_3 = 83
		var_31_2 = var_0_3:getTicketPrice(self._curSkin)
	end

	local var_31_4 = var_0_0:getKnightByAdvanceId(var_31_0.skinInfo.knight_advance_id or 0)

	if var_31_4 and not var_31_4:isOwn() then
		local var_31_5 = fgui.UIPackage:createObject("recharge", "RechargeSkinConFirmTxt")

		var_31_5:setTitle(g.core.lang:get(204018, {
			name = var_31_4:getName()
		}))
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(204017),
			childComp = var_31_5,
			onConfirm = handler(self, function()
				if arg_31_2 then
					if var_0_4:getOwnNum(var_31_1, var_31_3) < var_31_2 then
						g.core.module.ModuleManager:tip(g.core.lang:get(204026))
					else
						self:_ticketBuyConfirmPop(var_31_0)
					end
				else
					self:_goldBuyConfirmPop(var_31_0, var_31_2)
				end
			end)
		}))
	elseif arg_31_2 then
		if var_31_2 > var_0_4:getOwnNum(var_31_1, var_31_3) then
			g.core.module.ModuleManager:tip(g.core.lang:get(204026))
		else
			self:_ticketBuyConfirmPop(var_31_0)
		end
	else
		self:_goldBuyConfirmPop(var_31_0, var_31_2)
	end
end

function RechargeSkinComp:receiveCompEvent(arg_33_1)
	local var_33_0 = {
		...
	}

	if arg_33_1 == "SKIN_TIME_END" then
		self:_updateSkinList(true)
	elseif arg_33_1 == "SKIN_BUY" then
		if var_33_0[1].curSkin then
			self:_buySkin(var_33_0[1].curSkin)
		end
	elseif arg_33_1 == "SKIN_BUY_BY_TICKET" then
		if var_33_0[1].curSkin then
			self:_buySkin(var_33_0[1].curSkin, var_33_0[1].isTicket)
		end
	elseif arg_33_1 == "REFRESH_SKIN_INDEX" then
		self._themeIndex = var_33_0[1].index
	end
end

function RechargeSkinComp:_ticketBuyConfirmPop(arg_34_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
		title = g.core.lang:get(1178),
		text = g.core.lang:get(204024, {
			name = var_0_6:convert({
				value = 83,
				type = var_0_6.TYPE_ITEM
			}).name,
			num = var_0_3:getTicketPrice(self._curSkin)
		}),
		text_ok = g.core.lang:get(1153),
		text_cancel = g.core.lang:get(1147),
		info = self,
		handler_ok = function()
			g.core.network.GameNetProxy:send_C2S_Shop_SkinShopByItem({
				id = arg_34_1.id
			})
		end
	}), {
		touchDisappear = true
	})
end

function RechargeSkinComp:_goldBuyConfirmPop(arg_36_1, arg_36_2)
	if arg_36_2 <= g.core.model.User:getGold() then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
			title = g.core.lang:get(1178),
			text = g.core.lang:get(407908, {
				name = var_0_6:convert({
					value = 1,
					type = var_0_6.TYPE_GOLD
				}).name,
				num = arg_36_2
			}),
			text_ok = g.core.lang:get(1153),
			text_cancel = g.core.lang:get(1147),
			info = self,
			handler_ok = function()
				g.core.network.GameNetProxy:send_C2S_Shop_SkinShopByItem({
					id = arg_36_1.id,
					diamond_price = arg_36_2
				})
			end
		}), {
			touchDisappear = true
		})
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = 999,
			value = 1,
			needSize = arg_36_2,
			curSize = g.core.model.User:getGold(),
			func = function(arg_38_0)
				g.core.network.GameNetProxy:send_C2S_Shop_SkinShopByItem(arg_38_0)
			end,
			funcParams = {
				id = arg_36_1.id,
				diamond_price = arg_36_2
			}
		})
	end
end

return RechargeSkinComp
