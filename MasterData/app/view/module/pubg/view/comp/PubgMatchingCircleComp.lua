local PubgMatchingCircleComp = class("PubgMatchingCircleComp", require("app.fairyGUI.pubg.UI_PubgMatchingCircleComp"))

function PubgMatchingCircleComp:playEnterAni()
	self.m_enterTransition:play()
end

function PubgMatchingCircleComp:playTurnAroundAni()
	if self.m_enterTransition:isPlaying() then
		self.m_enterTransition:stop()
	end

	self.m_loopTransition:play(-1, 0)
end

return PubgMatchingCircleComp
