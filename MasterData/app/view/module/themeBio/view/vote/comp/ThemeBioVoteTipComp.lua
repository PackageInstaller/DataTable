local ThemeBioVoteTipComp = class("ThemeBioVoteTipComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteTipComp"))

function ThemeBioVoteTipComp:ctor()
	return
end

function ThemeBioVoteTipComp:updateTipComp(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.goalText then
		self.m_goalTxt:setText(arg_2_1.goalText)
	end

	if arg_2_1.waitText then
		self.m_waitTxt:setText(arg_2_1.waitText)
	end

	if arg_2_1.state then
		self.m_stateController:setSelectedIndex(arg_2_1.state)
	end
end

return ThemeBioVoteTipComp
