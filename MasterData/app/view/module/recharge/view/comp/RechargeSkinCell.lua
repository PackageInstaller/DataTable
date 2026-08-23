local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User
local var_0_2 = g.core.const.ConstMgr.ShopConst
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.model.User.skinData
local var_0_5 = g.core.model.User.skinGoodsData
local RechargeSkinCell = class("RechargeSkinCell", require("app.fairyGUI.recharge.UI_RechargeSkinCell"))

function RechargeSkinCell:ctor()
	self._canBuy = false

	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)

	self.m_buttonController = self:getController("button")
	self._skinGoods = nil

	self.m_buyTouchBg:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onBuy))
	self.m_buyTouchBg2:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onBuyByTicket))
	self.m_buyTouchBg3:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onBuy))
	self:addClickListener(handler(self, self._onClickSelf))

	self._limitTimeEffNode = nil
	self._skinEffNode = nil
end

function RechargeSkinCell:updateCell(arg_2_1)
	self.m_normalTransition:play()

	self._skinGoods = arg_2_1

	self.m_picComp:getChild("picComp"):setIcon(var_0_0:getKnightPicRes(arg_2_1.resInfo.painted_id))

	if arg_2_1.sale_value == var_0_2.SHOP_SKIN_TYPE.GM_SKIN then
		if arg_2_1.gmActivityInfo then
			self:_updateGmSkinInfo()
		end
	else
		self:_updateConfigSkinInfo()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			skinId = self._skinGoods.skin_id
		}
	})
	var_0_1.skinGoodsData:markOldSkin(self._skinGoods.skin_id)
	self:_createLimitTimeEffect()
end

function RechargeSkinCell:_onBuy()
	if self._skinGoods.sale_value == var_0_2.SHOP_SKIN_TYPE.GM_SKIN and self._canBuy == 1 or self._skinGoods.sale_value == var_0_2.SHOP_SKIN_TYPE.DIRECT_BUY and self._canBuy then
		self:dispatchCompEvent("SKIN_BUY", {
			curSkin = self._skinGoods
		})
	end
end

function RechargeSkinCell:_onBuyByTicket()
	if self._skinGoods.sale_value == var_0_2.SHOP_SKIN_TYPE.GM_SKIN and self._canBuy == 1 or self._skinGoods.sale_value == var_0_2.SHOP_SKIN_TYPE.DIRECT_BUY and self._canBuy then
		self:dispatchCompEvent("SKIN_BUY_BY_TICKET", {
			isTicket = true,
			curSkin = self._skinGoods
		})
	end
end

function RechargeSkinCell:_updateGmSkinInfo()
	self.m_isTimeLimitController:setSelectedIndex(0)
	self.m_isDiscountController:setSelectedIndex(0)

	local var_5_0 = self._skinGoods

	self.m_isLimitController:setSelectedIndex(self._skinGoods.skinInfo.limit == 1 and 1 or 0)

	if var_5_0.skinInfo.limit == 1 then
		self.m_limitComp:addEffect()
	end

	self.m_scaleValueController:setSelectedIndex(var_0_5:isCanTicketBuy(var_5_0) == true and 3 or 2)

	local var_5_1, var_5_2 = var_0_1.skinData:isActivitySkinInDiscountTime(var_5_0.gmActivityInfo.skinId)
	local var_5_3, var_5_4 = var_0_1.skinData:isActivitySkinInSellTime(var_5_0.gmActivityInfo.skinId)

	self._gmSkinState = var_0_1.skinData:getGmSkinState(var_5_0.gmActivityInfo.skinId)

	if var_5_1 and self._gmSkinState ~= 1 then
		self.m_isDiscountController:setSelectedIndex(1)
		self.m_discountComp:setTitle(var_5_0.gmActivityInfo.discountValue .. "%")

		local var_5_5 = var_0_4:getGMSkinDiscountEndTime(self._skinGoods.skin_id)

		if var_5_5 ~= 0 then
			local var_5_6, var_5_7 = g.core.common.ServerTime:getLeftTimeParts(var_5_5)

			self.m_timeLimit:setText(g.core.lang:get(107101, {
				day = var_5_6,
				hour = var_5_7
			}))
		else
			self.m_isDiscountController:setSelectedIndex(2)
		end
	end

	local var_5_8 = tonumber(var_0_1.skinData:getGmSkinEndTime(var_5_0.gmActivityInfo.skinId)) or 0

	self._isShowTimeLimit = false

	if var_5_8 > 0 and self._gmSkinState ~= 1 then
		self._isShowTimeLimit = true

		self.m_isTimeLimitController:setSelectedIndex(1)
		self.m_timeLeftComp:updateTimeOneByOne(var_5_8, handler(self, self._timeEnd))
	end

	local var_5_9 = var_0_1.skinData:getGmSkinBuyState(var_5_0.gmActivityInfo.skinId)

	self._canBuy = var_5_9

	if var_5_9 == 2 then
		self.m_isTimeLimitController:setSelectedIndex(2)

		self._isShowTimeLimit = false
	end

	self.m_canBuyController:setSelectedIndex(self._canBuy)
	self.m_discountLabel:setVisible(false)
	self.m_priceTxt:setText("")

	if var_5_9 == 1 then
		self.m_ticketPriceTxt:setText(g.core.lang:get(204028, {
			price = var_0_5:getTicketPrice(var_5_0)
		}))

		if var_5_1 then
			self.m_discountLabel:setVisible(true)
			self.m_discountLabel:updateCell(var_5_0.gmActivityInfo.discount_price, var_5_0.gmActivityInfo.original_price, true)
			self.m_priceTxt:setText("")
		else
			self.m_priceTxt:setText(g.core.lang:get(407912, {
				price = var_5_0.gmActivityInfo.original_price
			}))
			self.m_discountLabel:setVisible(false)
		end
	end
end

function RechargeSkinCell:_updateConfigSkinInfo()
	self.m_isLimitController:setSelectedIndex(self._skinGoods.limit == 1 and 1 or 0)

	if self._skinGoods.skinInfo.limit == 1 then
		self.m_limitComp:addEffect()
	end

	if var_0_5:isCanTicketBuy(self._skinGoods) then
		self.m_scaleValueController:setSelectedIndex(3)
	else
		self.m_scaleValueController:setSelectedIndex(0)
	end

	if self._skinGoods.time_limit == 0 then
		self.m_isTimeLimitController:setSelectedIndex(0)
	else
		self.m_isTimeLimitController:setSelectedIndex(1)
		self.m_timeLimit:setText(g.core.lang:get(107065, {
			time = self._skinGoods.remainingTime
		}))
	end

	self._canBuy = var_0_1.skinData:getSkinState(self._skinGoods.skin_id) ~= 1

	self.m_canBuyController:setSelectedIndex(self._canBuy and 1 or 0)

	if self._canBuy then
		if self._skinGoods.sale_value == var_0_2.SHOP_SKIN_TYPE.DIRECT_BUY then
			if var_0_5:isCanTicketBuy(self._skinGoods) then
				self.m_ticketPriceTxt:setText(g.core.lang:get(204028, {
					price = var_0_5:getTicketPrice(self._skinGoods)
				}))
			end

			self._rechargeInfo = var_0_1.rechargeData:getRechargeInfoByTypeAndPrice(self._skinGoods.recharge_type, self._skinGoods.recharge_money)

			self.m_priceTxt:setText(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)
		else
			self.m_scaleValueController:setSelectedIndex(1)
			self.m_resPriceComp:updateByTVS({
				showLack = true,
				type = var_0_3.TYPE_RESOURCE,
				value = var_0_3.RESOURCE.TYPE_SKIN_FRAG,
				size = self._skinGoods.price
			})
		end
	end
end

function RechargeSkinCell:_timeEnd()
	self:dispatchCompEvent("SKIN_TIME_END")
end

function RechargeSkinCell:_createLimitTimeEffect()
	if self._limitTimeEffNode then
		self._limitTimeEffNode:removeFromParent()

		self._limitTimeEffNode = nil
	end

	if self._isShowTimeLimit and self.m_limitTimeEfft then
		self._limitTimeEffNode = self.m_limitTimeEfft:addEffectSpine({
			anim = "play",
			name = "eff_ui_recharge_limitmark",
			isLoop = true
		})

		self.m_limitTimeEfft:setScaleX(self.m_timeLimitBg:getSize().width / 60)
	end
end

function RechargeSkinCell:_onClickSelf()
	self:_createSkinEffect()
end

function RechargeSkinCell:_createSkinEffect()
	if self._skinEffNode then
		self._skinEffNode:removeFromParent()

		self._skinEffNode = nil
	end

	if self.m_skinEfft then
		if self.m_isTimeLimitController:getSelectedIndex() == 1 or self.m_isDiscountController:getSelectedIndex() == 1 then
			self._skinEffNode = self.m_skinEfft:addEffectSpine({
				anim = "play",
				name = "eff_ui_recharge_skinglow",
				isLoop = false
			})
		end
	end
end

return RechargeSkinCell
