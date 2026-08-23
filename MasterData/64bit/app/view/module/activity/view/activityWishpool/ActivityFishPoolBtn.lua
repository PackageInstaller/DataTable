local var_0_0 = g.core.model.User.activityWishpoolData
local ActivityFishPoolBtn = class("ActivityFishPoolBtn", require("app.fairyGUI.activity.UI_ActivityFishPoolBtn"))

function ActivityFishPoolBtn:updateFishNum()
	for iter_1_0, iter_1_1 in ipairs((var_0_0:getAllTypeFishNum())) do
		self["m_fish" .. iter_1_0]:setURL("ui://activity/icon_wish_fish" .. iter_1_0)
		self["m_fishNumTxt" .. iter_1_0]:setText(iter_1_1.curNum)
	end

	if self._disappearIndex then
		self.m_fishCostTransition:play()

		self._disappearIndex = nil
	end

	if self._isTenFish then
		self.m_fishCostTenTransition:play()

		self._isTenFish = false
	end
end

function ActivityFishPoolBtn:setDescFishId(arg_2_1)
	if #arg_2_1 == 1 then
		self._disappearIndex = g.core.config.wishpool_drop_info.get(arg_2_1[1]).fish_appear

		self.m_fishChangeController:setSelectedIndex(self._disappearIndex - 1)
		self.m_isTenController:setSelectedIndex(0)
	else
		local var_2_0 = {}

		for iter_2_0 = 1, #arg_2_1 do
			local var_2_1 = g.core.config.wishpool_drop_info.get(arg_2_1[iter_2_0])

			var_2_0[var_2_1.fish_appear] = (var_2_0[var_2_1.fish_appear] or 0) + 1
		end

		for iter_2_1 = 1, 3 do
			if var_2_0[iter_2_1] and var_2_0[iter_2_1] > 0 then
				self["m_fishCostText" .. iter_2_1]:setText("-" .. var_2_0[iter_2_1])
			else
				self["m_fishCostText" .. iter_2_1]:setText("")
			end
		end

		self.m_isTenController:setSelectedIndex(1)

		self._isTenFish = true
	end
end

return ActivityFishPoolBtn
