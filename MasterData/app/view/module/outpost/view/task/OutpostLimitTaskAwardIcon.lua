local OutpostLimitTaskAwardIcon = class("OutpostLimitTaskAwardIcon", require("app.fairyGUI.outpost.UI_OutpostLimitTaskAwardIcon"))

function OutpostLimitTaskAwardIcon:ctor()
	self.m_effNode:addEffectSpine({
		anim = "play_0",
		name = "eff_ui_common_iconget",
		isLoop = true
	})
end

function OutpostLimitTaskAwardIcon:updateAwardIcon(arg_2_1, arg_2_2)
	if arg_2_2 then
		self.m_isShowEffController:setSelectedIndex(1)
	else
		self.m_isShowEffController:setSelectedIndex(0)
	end

	self.m_icon:updateIcon(arg_2_1)
end

return OutpostLimitTaskAwardIcon
