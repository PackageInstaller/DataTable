local var_0_0 = g.core.model.User.activityDailyBoxData
local var_0_1 = g.core.module.ModuleManager
local ActivityDailyBoxWeekCardBtn = class("ActivityDailyBoxWeekCardBtn", require("app.fairyGUI.activity.UI_ActivityDailyBoxWeekCardBtn"))
local var_0_4 = g.core.const.ConstMgr.ActivityConst.DAILY_BOX_DRAW_STATUS
local var_0_5 = g.core.const.ConstMgr.ActivityConst.DAILY_SALE_INFO_INDEX

function ActivityDailyBoxWeekCardBtn:ctor()
	self._dailyBoxInfo = var_0_0:getDailyBoxData()

	self:addClickListener(handler(self, self._onClickSelf))
end

function ActivityDailyBoxWeekCardBtn:updateView()
	local var_2_0 = var_0_4.DEFAULT

	var_2_0 = var_0_0:isWeekCardValid() and var_0_0:checkWeekCardDrawStatus() or var_0_0:checkWeekCardDrawStatusNotFree()

	self.m_canDrawController:setSelectedIndex(var_2_0)

	if var_2_0 >= var_0_4.NOT_DRAW then
		self.m_leftTimeTxt:setText((var_0_0:getWeekCardRemainTimeString()))
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})

	local var_2_1 = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(self._dailyBoxInfo[var_0_5.WEEK_CARD].chargeInfo.recharge_type, self._dailyBoxInfo[var_0_5.WEEK_CARD].chargeInfo.money)

	if var_2_0 < var_0_4.NOT_DRAW then
		self.m_priceDesc:setText(g.core.lang:get(404507, {
			num = var_2_1.moneyUnit .. var_2_1.realMoney
		}))
	end
end

function ActivityDailyBoxWeekCardBtn:_onClickSelf()
	local var_3_1 = self._dailyBoxInfo[var_0_5.WEEK_CARD].chargeInfo
	local var_3_2 = self._dailyBoxInfo[var_0_5.WEEK_CARD].info.id

	if var_0_0:isWeekCardValid() then
		local var_3_3 = var_0_0:checkWeekCardDrawStatus()

		if var_3_3 == var_0_4.NOT_DRAW then
			g.core.network.GameNetProxy:send_C2S_Recharge_GetAllDailySaleAward({})
		elseif var_3_3 == var_0_4.HAS_DRAW then
			var_0_1:tip(g.core.lang:get(404017))
		end
	else
		local var_3_4 = var_0_0:checkWeekCardDrawStatusNotFree()

		if var_3_4 == var_0_4.NO_PRIVILEGE then
			g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, self._dailyBoxInfo[var_0_5.WEEK_CARD].chargeInfo, self._dailyBoxInfo[var_0_5.WEEK_CARD].info.id, 0)
		elseif var_3_4 == var_0_4.NO_PRIVILEGE_PART_DRAW then
			var_0_1:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(404020),
				desc = g.core.lang:get(404015),
				confirmText = g.core.lang:get(404019),
				cancelText = g.core.lang:get(404018),
				onConfirm = handler(self, function()
					g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, var_3_1, var_3_2, 0)
				end)
			}))
		elseif var_3_4 == var_0_4.NO_PRIVILEGE_HAS_DRAW then
			var_0_1:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(404020),
				desc = g.core.lang:get(404016),
				confirmText = g.core.lang:get(404019),
				cancelText = g.core.lang:get(404018),
				onConfirm = handler(self, function()
					g.core.common.GlobalFunc.checkBagBeforeOpRecharge(self, var_3_1, var_3_2, 0)
				end)
			}))
		end
	end
end

return ActivityDailyBoxWeekCardBtn
