local var_0_0 = g.core.model.User.activityWishpoolData
local ActivityFishDailyProgressComp = class("ActivityFishDailyProgressComp", require("app.fairyGUI.activity.UI_ActivityFishDailyProgressComp"))

function ActivityFishDailyProgressComp:updateProgressComp()
	local var_1_0 = var_0_0:getActCfg()
	local var_1_1 = g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.BAIT
	})

	self.m_yuerIcon:setURL(var_1_1.icon_mini)
	self.m_yuerIcon2:setURL(var_1_1.icon_mini)

	local var_1_2 = var_0_0:getRechargeMoney()
	local var_1_3 = g.core.config.recharge_exchange_rate_info.fetch((tonumber((g.core.platform.PlatformProxy:getGameId())))) or g.core.config.recharge_exchange_rate_info.indexOf(2)
	local var_1_5 = g.core.model.User.rechargeData:getPriceByNum(var_1_3.wishpool_local, true)

	if var_1_3.sort == 2 then
		self.m_rechargeTxt:setText(g.core.lang:get(409020, {
			num = var_1_5 .. var_1_3.money
		}))
	else
		self.m_rechargeTxt:setText(g.core.lang:get(409020, {
			num = var_1_3.money .. var_1_5
		}))
	end

	self.m_rechargeProgress:setMax(var_1_3.wishpool_local)

	if var_0_0:getTodayRechargeBait() >= var_1_0.bait_limit then
		self.m_progressTxt:setText(g.core.model.User.rechargeData:getPriceByNum((var_1_2 > var_1_3.wishpool_local or nil) and (var_1_3.wishpool_local or var_1_2), true) .. "/" .. var_1_5)
		self.m_rechargeProgress:setValue(var_0_0:getRechargeMoney())
	else
		self.m_progressTxt:setText(g.core.model.User.rechargeData:getPriceByNum(var_1_2, true) % var_1_5 .. "/" .. var_1_5)
		self.m_rechargeProgress:setValue(var_0_0:getRechargeMoney() % var_1_3.wishpool_local)
	end

	self.m_activeTxt:setText(g.core.lang:get(409019, {
		num = var_1_0.action_cost
	}))
	self.m_rechargeMaxTxt:setText(g.core.lang:get(409018, {
		max = var_1_0.bait_limit,
		num = var_0_0:getTodayRechargeBait()
	}))
	self.m_activeMaxTxt:setText(g.core.lang:get(409018, {
		max = var_1_0.active_bait_limit,
		num = var_0_0:getTodayActiveBait()
	}))
end

return ActivityFishDailyProgressComp
