local var_0_0 = g.core.const.ConstMgr.RechargeConst
local var_0_1 = g.core.model.User
local var_0_2 = g.core.model.User.giftData
local var_0_3 = g.core.common.Goods
local CommanderRechargeGiftCell = class("CommanderRechargeGiftCell", require("app.fairyGUI.commanderWorld.UI_CommanderRechargeGiftCell"))

function CommanderRechargeGiftCell:ctor()
	self._info = nil
	self._curInfo = nil
	self._isEnough = true
	self._canBuy = false

	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
	self:_initListeners()
end

function CommanderRechargeGiftCell:_initListeners()
	self.m_popBtn:addClickListener(handler(self, self._onClick))
	self.m_awardBtn:addClickListener(handler(self, self._onClick))
end

function CommanderRechargeGiftCell:_onClick()
	if self._canBuy then
		clone(self._curInfo).chargeInfo = self._rechargeInfo

		g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeGiftPop").new(self._curInfo))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(107118))
	end
end

function CommanderRechargeGiftCell:_onBtnClick()
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
				type = 999,
				value = 1
			})
		end
	end
end

function CommanderRechargeGiftCell:updateCell(arg_6_1, arg_6_2)
	if not arg_6_1 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	self._info = arg_6_1
	self._curInfo = self._info.id == self._info.curGiftId and self._info or var_0_2:getGiftDataById(self._info.curGiftId)

	if self._curInfo.diamond_price == 0 and self._curInfo.recharge_type == 0 then
		self.m_redPointComp:setId(709)
		self.m_redPointComp:setVisible(true)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	else
		self.m_redPointComp:setVisible(false)
	end

	self.m_iconLoader:setURL((g.core.common.Path:getRechargeIconById(self._curInfo.icon)))
	self.m_nameTxt:setText(self._curInfo.name)

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
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.WEEKLY then
			var_6_1 = 107062
		elseif self._curInfo.limit_type == var_0_0.GIFT_LIMIT_TYPE.MONTHLY then
			var_6_1 = 107064
		end

		self.m_limitTxt:setText(g.core.lang:get(var_6_1) .. " " .. g.core.lang:get(107056, {
			num = var_6_0,
			maxNum = self._curInfo.times
		}))
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

	if self._curInfo.discount ~= 100 and self._curInfo.discount ~= 0 then
		self.m_isDiscountController:setSelectedIndex(1)
		self.m_offText:setText(g.core.lang:get(108410, {
			num = self._curInfo.discount
		}))
	else
		self.m_isDiscountController:setSelectedIndex(0)
	end
end

return CommanderRechargeGiftCell
