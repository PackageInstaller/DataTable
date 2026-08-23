local var_0_0 = {
	UNABLE_BUY = 2,
	HAS_BUY = 1,
	NOT_BUY = 0
}
local var_0_1 = {
	LIMIT = 0,
	NOT_LIMIT = 1
}
local var_0_3 = g.core.lang
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.model.User.activityPermanentRechargeData
local ActivityPermanentRechargeGiftCell = class("ActivityPermanentRechargeGiftCell", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeGiftCell"))
local var_0_8 = g.core.model.User.rechargeData
local var_0_10 = g.core.common.Path
local var_0_11 = g.core.common.Goods

function ActivityPermanentRechargeGiftCell:ctor()
	self._cdScheduler = nil
	self._nextStartTime = 0
	self._activityId = var_0_5:getActivityId()

	self.m_bgLoader:addClickListener(handler(self, self._onDetailClick))
	self.m_buyBtn:addClickListener(handler(self, self._onDetailClick))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function ActivityPermanentRechargeGiftCell:updateView(arg_2_1)
	self.m_offController:setSelectedIndex(0)

	self._giftData = arg_2_1
	self._giftInfo = clone(self._giftData)
	self._giftInfo.recharge_type = 25
	self._giftInfo.recharge_money = self._giftData.gift_price
	self._giftInfo.task_id = self._giftData.id

	if self._giftData.gift_type == 1 then
		self._rechargeInfo = var_0_8:getRechargeInfoByTypeAndPrice(self._giftInfo.recharge_type, self._giftInfo.recharge_money)
	end

	self.m_buyBtn:updatePrice(self._rechargeInfo, self._giftData)
	self.m_buildingLoader:setURL(var_0_10:getPermanentRechargeGiftRightIcon(self._giftData.stage_id))
	self.m_iconLoader:setURL(var_0_10:getRechargeIconById(self._giftData.res))
	self.m_nameTxt:setText(self._giftData.name)

	local var_2_0 = 0

	if self._giftData.times == 0 then
		self.m_typeController:setSelectedIndex(var_0_1.NOT_LIMIT)
		self.m_statusController:setSelectedIndex(0)
	else
		self.m_typeController:setSelectedIndex(var_0_1.LIMIT)

		local var_2_1 = self._giftData.times - self._giftData.buyTimes

		if self._giftData.times - self._giftData.buyTimes > 0 then
			self.m_statusController:setSelectedIndex(var_0_0.NOT_BUY)
		else
			self.m_statusController:setSelectedIndex(var_0_0.HAS_BUY)

			var_2_0 = 1
		end

		self.m_limitTxt:setText(g.core.lang:get(408302, {
			num = var_2_1,
			maxNum = arg_2_1.times
		}))
		self.m_limitGroup:setVisible(var_2_0 == 0)
		self.m_buyBtn:setSoldOut(var_2_0)
	end

	local var_2_2 = var_0_5:isGiftBuySatisfy(self._giftData.stage_id)

	self._giftInfo.buy_activated = var_2_2

	self.m_redPointComp:setVisible(var_2_2)

	if not var_2_2 then
		self.m_statusController:setSelectedIndex(var_0_0.UNABLE_BUY)
	end

	if self._giftData.discount ~= 100 then
		self.m_offText:setText(g.core.lang:get(108410, {
			num = self._giftData.discount
		}))
		self.m_offController:setSelectedIndex(1)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			stageId = self._giftData.stage_id
		}
	})
end

function ActivityPermanentRechargeGiftCell:_onDetailClick()
	var_0_4:pushPopup((require("app.view.module.recharge.view.RechargeGiftPop").new(self._giftInfo, false)))
end

function ActivityPermanentRechargeGiftCell:_onBuyBtnClick()
	local var_4_0 = self.m_statusController:getSelectedIndex()

	if var_4_0 == var_0_0.NOT_BUY then
		if self._giftData.gift_type == 1 then
			g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._rechargeInfo, self._activityId, self._giftData.id)
		elseif self._giftData.gift_type == 2 then
			local var_4_1 = g.core.model.User:getFreeGold()

			if var_4_1 < self._giftData.gift_price then
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					value = 0,
					type = var_0_11.TYPE_GOLD,
					curSize = var_4_1,
					needSize = self._giftData.gift_price
				})

				return
			end

			g.core.network.GameNetProxy:send_C2S_Recharge_BuyRechargeRebateGift({
				id = self._giftData.id
			})
		elseif self._giftData.gift_type == 3 then
			local var_4_2 = g.core.model.User:getGold()

			if var_4_2 < self._giftData.gift_price then
				g.core.module.ModuleManager:pushPopup(require("app.view.base.component.BaseAssistPopComp").new({
					title = g.core.lang:get(1257),
					text = g.core.lang:get(407910, {
						name = var_0_11:convert({
							value = 1,
							type = var_0_11.TYPE_GOLD
						}).name
					}),
					text_ok = g.core.lang:get(1153),
					text_cancel = g.core.lang:get(1147),
					info = self,
					handler_ok = function()
						g.core.module.ModuleManager:pushModule(g.view.entrance.RECHARGE, {
							shopType = 19
						})
					end,
					handler_cancel = function()
						g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
							value = 1,
							type = 999,
							curSize = var_4_2,
							needSize = self._giftData.gift_price
						})
					end
				}), {
					touchDisappear = true
				})

				return
			end

			g.core.network.GameNetProxy:send_C2S_Recharge_BuyRechargeRebateGift({
				id = self._giftData.id
			})
		end
	elseif var_4_0 == var_0_0.HAS_BUY then
		var_0_4:tip(var_0_3:get(408317))
	else
		var_0_4:tip(var_0_3:get(408315))
	end
end

return ActivityPermanentRechargeGiftCell
