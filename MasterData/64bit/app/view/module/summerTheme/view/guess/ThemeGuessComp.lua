local var_0_0 = 1
local ThemeGuessComp = class("ThemeGuessComp", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessComp"))

function ThemeGuessComp:ctor()
	for iter_1_0 = 1, 4 do
		self["m_selection" .. iter_1_0]:addClickListener(handler(self, self._onSelectClick))
	end
end

function ThemeGuessComp:updateQuestion(arg_2_1, arg_2_2)
	self._isStart = arg_2_2

	if self._question then
		for iter_2_0 = 1, 4 do
			self["m_selection" .. iter_2_0]:setTouchable(false)
		end

		self._question = arg_2_1

		self:showWithRightOption()
	else
		self._question = arg_2_1

		self:onChangeKnight()
	end
end

function ThemeGuessComp:setInit()
	self._question = nil
end

function ThemeGuessComp:showWithRightOption()
	self.m_knightComp:showAll()
	self.m_knightFrontComp:showAll()
	self:newScheduleOnce(handler(self, self.onChangeKnight), var_0_0)
end

function ThemeGuessComp:onChangeKnight()
	if self._isStart then
		self:onPlayCloseFinish()
	else
		self.m_knightFrontComp:playCloseAnim(handler(self, self.onPlayCloseFinish))
	end
end

function ThemeGuessComp:onPlayCloseFinish()
	self._rightSelection = self._question.right_option

	self.m_knightComp:changeKnight(self._question)
	self.m_knightFrontComp:changeKnight(self._question)

	for iter_6_0 = 1, 4 do
		self["m_selection" .. iter_6_0]:setTouchable(true)
		self["m_selection" .. iter_6_0]:setTitle(self._question["option_" .. iter_6_0])
		self["m_selection" .. iter_6_0]:setCtrlState("state", {
			index = 0
		})
	end
end

function ThemeGuessComp:_onSelectClick(arg_7_1)
	local var_7_0 = arg_7_1:getSender()

	for iter_7_0 = 1, 4 do
		if self["m_selection" .. iter_7_0] == var_7_0 then
			self:selectSelection(iter_7_0)

			break
		end
	end
end

function ThemeGuessComp:selectSelection(arg_8_1)
	if arg_8_1 == self._rightSelection then
		self["m_selection" .. arg_8_1]:setCtrlState("state", {
			index = 2
		})
		self["m_selection" .. arg_8_1]:onPlaySelectAnim(true)
		self:dispatchCompEvent("THEME_GUESS_SELECT_RIGHT_OPTION", self._question)
		self.m_effHolder:addEffectSpine({
			name = "eff_ui_themeguess_correct",
			remove = true,
			isLoop = false
		})
	else
		self:onSelectFalse()
		self["m_selection" .. arg_8_1]:setCtrlState("state", {
			index = 1
		})
		self["m_selection" .. arg_8_1]:onPlaySelectAnim(false)
		self["m_selection" .. arg_8_1]:setTouchable(false)
		self:dispatchCompEvent("THEME_GUESS_SELECT_FALSE_OPTION", self._question)
	end
end

function ThemeGuessComp:onSelectFalse()
	self.m_knightComp:onDefaultSelection()
	self.m_knightFrontComp:onDefaultSelection()
end

function ThemeGuessComp:setInGame(arg_10_1)
	self.m_inGameController:setSelectedIndex(arg_10_1 and 1 or 0)
end

return ThemeGuessComp
