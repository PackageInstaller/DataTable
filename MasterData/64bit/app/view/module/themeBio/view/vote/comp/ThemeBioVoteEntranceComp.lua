local ThemeBioVoteEntranceComp = class("ThemeBioVoteEntranceComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteEntranceComp"))

function ThemeBioVoteEntranceComp:ctor()
	return
end

function ThemeBioVoteEntranceComp:updateVoteEntrance(arg_2_1)
	if arg_2_1.state then
		self.m_stateController:setSelectedIndex(arg_2_1.state)
	end
end

return ThemeBioVoteEntranceComp
