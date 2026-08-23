local ThemeAnubisBioVoteKnightPicComp = class("ThemeAnubisBioVoteKnightPicComp", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteKnightPicComp"))

function ThemeAnubisBioVoteKnightPicComp:ctor()
	return
end

function ThemeAnubisBioVoteKnightPicComp:updateKnightComp(arg_2_1)
	self.m_icon:getChild("icon"):setURL(g.core.common.Path:getMiddleKnightPicById(arg_2_1.optionNo))
	self.m_stateController:setSelectedIndex(arg_2_1.state)
	self.m_hasVotedController:setSelectedIndex(arg_2_1.hasVoted and 1 or 0)
	self:setGrayed(false)

	if arg_2_1.hasVoted == false and arg_2_1.isUnlockedEnding then
		self:setGrayed(true)
	end
end

return ThemeAnubisBioVoteKnightPicComp
