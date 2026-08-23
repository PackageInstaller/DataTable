local TeamPVPMatchingDiskComp = class("TeamPVPMatchingDiskComp", require("app.fairyGUI.teamPVP.UI_TeamPVPMatchingDiskComp"))

function TeamPVPMatchingDiskComp:playEnterAni()
	self.m_enterTransition:play()
end

function TeamPVPMatchingDiskComp:playTurnAroundAni()
	if self.m_enterTransition:isPlaying() then
		self.m_enterTransition:stop()
	end

	self.m_loopTransition:play(-1, 0)
end

return TeamPVPMatchingDiskComp
