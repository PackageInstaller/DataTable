local RichmanWishTreeRewardComp = class("RichmanWishTreeRewardComp", require("app.fairyGUI.richman.UI_RichmanWishTreeRewardComp"))

function RichmanWishTreeRewardComp:lightStateChange(arg_1_1)
	self.m_lightController:setSelectedIndex(arg_1_1 and 1 or 0)
end

function RichmanWishTreeRewardComp:playFinish()
	self.m_eff:addEffectSpine({
		name = "eff_ui_richman_finish",
		remove = true,
		isLoop = false
	})
end

function RichmanWishTreeRewardComp:updateRewardItem(arg_3_1)
	local var_3_0 = g.core.common.Goods:convert(arg_3_1)

	self.m_rewardIcon:setURL(var_3_0.icon)
	self.m_rewardNumTxt:setText(var_3_0.size)
end

function RichmanWishTreeRewardComp:_onClickIcon()
	if self._clickData then
		g.core.common.GlobalFunc.pushInfoPop(self._clickData)
	end
end

function RichmanWishTreeRewardComp:setClickData(arg_5_1)
	self._clickData = arg_5_1

	self:addClickListener(handler(self, self._onClickIcon))
end

return RichmanWishTreeRewardComp
