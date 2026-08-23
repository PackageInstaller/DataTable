local ActivityRewardIcon = class("ActivityRewardIcon", require("app.fairyGUI.activity.UI_ActivityRewardIcon"))

function ActivityRewardIcon:ctor()
	return
end

function ActivityRewardIcon:updateIcon(arg_2_1)
	self.m_icon:updateIcon(arg_2_1)
end

function ActivityRewardIcon:updateStatus(arg_3_1)
	self:removeEffect()

	if arg_3_1 == 1 then
		self.m_statusController:setSelectedIndex(0)
	elseif arg_3_1 == 2 then
		self.m_statusController:setSelectedIndex(1)

		self._spineNode = self.m_rewardEffComp:addEffectSpine({
			isLoop = true,
			anim = "play",
			name = "eff_ui_passCard_award"
		})

		self._spineNode:setScale(0.86)
	elseif arg_3_1 == 3 then
		self.m_statusController:setSelectedIndex(2)
	end
end

function ActivityRewardIcon:removeEffect()
	if self._spineNode then
		self._spineNode:removeFromParent()

		self._spineNode = nil
	end
end

return ActivityRewardIcon
