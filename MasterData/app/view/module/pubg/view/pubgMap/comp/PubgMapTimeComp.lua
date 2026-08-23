local PubgMapTimeComp = class("PubgMapTimeComp", require("app.fairyGUI.pubg.UI_PubgMapTimeComp"))

function PubgMapTimeComp:ctor()
	self._lastShowTime = 0
end

function PubgMapTimeComp:setInCountdown(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.m_isCountdownController:setSelectedIndex(1)

		if self._lastShowTime ~= arg_2_2 then
			self._lastShowTime = arg_2_2

			self.m_countdownTransition:play()
		end
	else
		self.m_isCountdownController:setSelectedIndex(0)
	end
end

return PubgMapTimeComp
