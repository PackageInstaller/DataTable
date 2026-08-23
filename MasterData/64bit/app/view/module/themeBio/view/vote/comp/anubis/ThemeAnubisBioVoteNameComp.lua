local ThemeAnubisBioVoteNameComp = class("ThemeAnubisBioVoteNameComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteNameComp"))

function ThemeAnubisBioVoteNameComp:ctor()
	return
end

function ThemeAnubisBioVoteNameComp:updateNameComp(arg_2_1)
	self:setTitle(arg_2_1.name or "")

	if arg_2_1.subTitle then
		self.m_subTitleController:setSelectedIndex(arg_2_1.subTitle)
	end

	if arg_2_1.state then
		self.m_stateController:setSelectedIndex(arg_2_1.state)
	end
end

return ThemeAnubisBioVoteNameComp
