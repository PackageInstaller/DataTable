local StormOverlordAwardPop = class("StormOverlordAwardPop", require("app.fairyGUI.storm.UI_StormOverlordAwardPop"), function()
	return fgui.GComponent:create({
		resName = "StormOverlordAwardPop",
		pkgPath = "ui/storm/storm",
		pkgName = "storm"
	}, ...)
end)

function StormOverlordAwardPop:ctor()
	self:showAtCenter()

	self._awards = nil

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRenderer))
	self.m_rewardBtn:addClickListener(handler(self, self._onGetRewardClick))
	self:updateView()
end

function StormOverlordAwardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORM_CITY_GETMAXLORDAWARD, self.updateView, self)
end

function StormOverlordAwardPop:updateView()
	local var_4_0, var_4_1 = g.core.model.User.stormCityData:canRcvOverLordAward()

	self._awards = g.core.common.Drops:getGoodsArray(g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.STORM_OVERLORD_AWARD_ID).parameter)

	self.m_rewardList:setNumItems(#self._awards)

	if var_4_1 == 0 then
		self.m_stateController:setSelectedIndex(0)
	elseif var_4_1 == 1 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(2)
	end
end

function StormOverlordAwardPop:_onRewardItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._awards[arg_5_1 + 1])
end

function StormOverlordAwardPop:_onGetRewardClick()
	local var_6_0, var_6_1 = g.core.model.User.stormCityData:canRcvOverLordAward()

	if var_6_0 then
		g.core.network.GameNetProxy:send_C2S_StormCity_GetMaxLordAward({})
	end
end

return StormOverlordAwardPop
