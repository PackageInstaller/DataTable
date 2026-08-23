local ActivityFundRewardCell = class("ActivityFundRewardCell", require("app.fairyGUI.activity.UI_ActivityFundRewardCell"))

function ActivityFundRewardCell:ctor()
	self._fundInfo = {}

	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._updateAwardCell))

	self._state = 0

	self.m_takeRewardBtn:addClickListener(handler(self, self._onClickReceive))
end

function ActivityFundRewardCell:updateAward(arg_2_1)
	local var_2_0 = arg_2_1.data or {}

	self._fundInfo = var_2_0.info

	self.m_timesTxt:setText(self._fundInfo.num)

	if var_2_0.state == 0 then
		self.m_processTxt:setText(g.core.model.User.activityFundData:getActiveNumByType(self._fundInfo.fund_type) .. "/" .. self._fundInfo.num)
	elseif var_2_0.state == 1 then
		-- block empty
	elseif var_2_0.state == 2 then
		-- block empty
	end

	self.m_stateController:setSelectedIndex(var_2_0.state)

	self._state = var_2_0.state

	local var_2_1 = 0

	for iter_2_0 = 1, 3 do
		if self._fundInfo["reward_type_" .. iter_2_0] > 0 then
			var_2_1 = var_2_1 + 1
		end
	end

	self.m_rewardList:setNumItems(var_2_1)
end

function ActivityFundRewardCell:_updateAwardCell(arg_3_1, arg_3_2)
	arg_3_2:updateIcon({
		type = self._fundInfo["reward_type_" .. arg_3_1 + 1],
		value = self._fundInfo["reward_value_" .. arg_3_1 + 1],
		size = self._fundInfo["reward_size_" .. arg_3_1 + 1]
	})
end

function ActivityFundRewardCell:_onClickReceive()
	if self._state ~= 1 then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Recharge_GetFundRechargeAward({
		id = self._fundInfo.id
	})
end

return ActivityFundRewardCell
