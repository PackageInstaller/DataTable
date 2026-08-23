local ActivityFishInfoRewardCell = class("ActivityFishInfoRewardCell", require("app.fairyGUI.activity.UI_ActivityFishInfoRewardCell"))

function ActivityFishInfoRewardCell:updateFishReward(arg_1_1)
	self.m_itemIcon:updateIcon(arg_1_1.reward)
	self.m_lastNumTxt:setText(g.core.lang:get(409004, {
		num = arg_1_1.lastNum
	}))
	self.m_curProbabilityTxt:setText(g.core.lang:get(409005, {
		probability = arg_1_1.probability
	}))

	if arg_1_1.lastNum > 0 then
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
	end
end

return ActivityFishInfoRewardCell
