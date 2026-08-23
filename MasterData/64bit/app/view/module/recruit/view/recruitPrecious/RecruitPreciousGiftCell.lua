local var_0_0 = g.core.const.ConstMgr.RechargeConst
local var_0_1 = g.core.model.User
local var_0_2 = g.core.model.User.giftData
local var_0_3 = g.core.common.Goods
local RecruitPreciousGiftCell = class("RecruitPreciousGiftCell", require("app.fairyGUI.recruitPrecious.UI_RecruitPreciousGiftCell"))

function RecruitPreciousGiftCell:ctor()
	self._info = nil
	self._curInfo = nil
	self._isEnough = true
	self._canBuy = false
	self._dailyTimer = nil
	self._dailyEndTime = 0

	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
	self:_initListeners()
	self.m_redPointComp:setId(195)
end

function RecruitPreciousGiftCell:_initListeners()
	self.m_popBtn:addClickListener(handler(self, self._onClick))
	self.m_awardBtn:addClickListener(handler(self, self._onClick))
end

function RecruitPreciousGiftCell:_onClick()
	if self._canBuy then
		clone(self._curInfo).chargeInfo = self._rechargeInfo

		g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeGiftPop").new(self._curInfo))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(107118))
	end
end

function RecruitPreciousGiftCell:_onBtnClick()
	if self._canBuy then
		if self._curInfo.buy_level > 0 then
			if var_0_1:getLevel() < self._curInfo.buy_level then
				g.core.module.ModuleManager:tip(g.core.lang:get(107028, {
					level = self._curInfo.buy_level
				}))

				return
			end
		end

		if self._curInfo.diamond_price == 0 then
			g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeGiftAward({
				id = self._curInfo.id
			})
		elseif self._curInfo.diamond_price <= g.core.model.User:getGold() then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
				title = g.core.lang:get(1178),
				text = g.core.lang:get(407909, {
					name = var_0_3:convert({
						value = 1,
						type = var_0_3.TYPE_GOLD
					}).name,
					num = self._curInfo.diamond_price
				}),
				text_ok = g.core.lang:get(1153),
				text_cancel = g.core.lang:get(1147),
				info = self,
				handler_ok = handler(self, function()
					g.core.network.GameNetProxy:send_C2S_Recharge_GetFreeGiftAward({
						id = self._curInfo.id
					})
				end)
			}), {
				touchDisappear = true
			})
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				value = 1,
				type = 999
			})
		end
	end
end

function RecruitPreciousGiftCell:updateCell(arg_6_1)
	if not arg_6_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._info = arg_6_1
	self._curInfo = self._info.id == self._info.curGiftId and self._info or var_0_2:getGiftDataById(self._info.curGiftId)

	self.m_iconLoader:setURL((g.core.common.Path:getRechargeIconById(self._curInfo.icon)))
	self.m_nameTxt:setText(self._curInfo.name)
	self.m_showRefreshTimeController:setSelectedIndex(0)
	self:_stopDailyTimer()

	if self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.NORMAL then
		self.m_isLimitController:setSelectedIndex(0)

		self._canBuy = true
	else
		self.m_isLimitController:setSelectedIndex(1)

		local var_6_0 = self._curInfo.times - self._curInfo.buyTimes

		self._canBuy = self._curInfo.times - self._curInfo.buyTimes > 0

		local var_6_1 = 410314

		if self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.DAILY then
			var_6_1 = 107061

			if not self._canBuy then
				self._dailyEndTime = g.core.common.ServerTime:getTime() + g.core.common.ServerTime:secondsToTommorrow((g.core.common.ServerTime:getTime()))

				self:_startDailyTimer()
				self:_onDailyTimeUpdate()
				self.m_showRefreshTimeController:setSelectedIndex(1)
			end
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.WEEKLY then
			var_6_1 = 107062
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.MONTHLY then
			var_6_1 = 107064
		end

		local var_6_2 = g.core.lang:get(var_6_1) .. " " .. g.core.lang:get(107056, {
			num = var_6_0,
			maxNum = self._curInfo.times
		})

		self.m_limitTxt:setText(var_6_2)
		self.m_limitNumText:setText(var_6_2)
	end

	self.m_isUnBuyController:setSelectedIndex(self._canBuy and 0 or 1)

	if self._curInfo.diamond_price == 0 and self._curInfo.recharge_type == 0 then
		self.m_isFreeController:setSelectedIndex(1)
	else
		self.m_isFreeController:setSelectedIndex(0)

		if self._curInfo.diamond_price > 0 then
			self.m_priceComp:setGold(self._curInfo.diamond_price, self._curInfo.original_price)
		else
			self._rechargeInfo = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(self._curInfo.recharge_type, self._curInfo.recharge_money)

			self.m_priceComp:setTitle(self._rechargeInfo.moneyUnit .. self._rechargeInfo.realMoney)
			self.m_priceComp:getChild("originNum"):setText((config.PUBLISH_REGION ~= g.core.const.ConstMgr.PlatformConst.REGION.CHINA or nil) and g.core.model.User.rechargeData:safeCalPriceString(self._rechargeInfo.id, self._curInfo.discount / 100, "*"))
		end
	end

	local var_6_4

	if self._curInfo.discount ~= 100 and self._curInfo.discount ~= 0 then
		self.m_isDiscountController:setSelectedIndex(1)
		self.m_offComp:setTitle(g.core.lang:get(307005, {
			num = self._curInfo.discount
		}))
	else
		self.m_isDiscountController:setSelectedIndex(0)

		var_6_4 = {}
	end

	var_6_4.id = self._curInfo.id

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = var_6_4
	})
end

function RecruitPreciousGiftCell:_startDailyTimer()
	self._dailyTimer = self._dailyTimer or self:newSchedule(handler(self, self._onDailyTimeUpdate, 1))
end

function RecruitPreciousGiftCell:_stopDailyTimer()
	if not self._dailyTimer then
		self:cancelSchedule(self._dailyTimer)
	end

	self._dailyTimer = nil
end

function RecruitPreciousGiftCell:_onDailyTimeUpdate()
	local var_9_0 = self._dailyEndTime - g.core.common.ServerTime:getTime()

	if var_9_0 > 0 then
		self.m_refreshTimeTxt:setText(g.core.lang:get(420110, {
			time = g.core.common.ServerTime:getCountDownBySecond(var_9_0)
		}))
	else
		self.m_showRefreshTimeController:setSelectedIndex(0)
		self:_stopDailyTimer()
	end
end

return RecruitPreciousGiftCell
