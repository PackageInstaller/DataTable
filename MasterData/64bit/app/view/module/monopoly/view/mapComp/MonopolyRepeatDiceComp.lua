local MonopolyRepeatDiceComp = class("MonopolyRepeatDiceComp", require("app.fairyGUI.monopoly.UI_MonopolyRepeatDiceComp"))

function MonopolyRepeatDiceComp:updateProgress(arg_1_1)
	if arg_1_1 then
		local var_1_0 = arg_1_1.fullNum

		self.m_progressTxt:setText(g.core.lang:get(431101, {
			num = arg_1_1.index,
			max = arg_1_1.fullNum
		}))

		if not self:isVisible() then
			self.m_enterTransition:play()
		end

		self:setVisible(var_1_0 > 1)
	else
		self:setVisible(false)
	end
end

function MonopolyRepeatDiceComp:playHideAnim(arg_2_1)
	self.m_backTransition:play(arg_2_1)
end

return MonopolyRepeatDiceComp
