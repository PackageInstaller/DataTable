local ThemeBioVoteNameComp = class("ThemeBioVoteNameComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteNameComp"))

function ThemeBioVoteNameComp:ctor()
	return
end

function ThemeBioVoteNameComp:updateNameComp(arg_2_1)
	if arg_2_1.name then
		self:setTitle(arg_2_1.name)
		self.m_title1:setText(arg_2_1.name)
		self.m_title2:setText(arg_2_1.name)
	end

	if arg_2_1.subTitle then
		self.m_subTitleController:setSelectedIndex(arg_2_1.subTitle)
	end

	if arg_2_1.state then
		self.m_stateController:setSelectedIndex(arg_2_1.state)
	end
end

function ThemeBioVoteNameComp:onLoad()
	return
end

function ThemeBioVoteNameComp:onUnload()
	return
end

return ThemeBioVoteNameComp
