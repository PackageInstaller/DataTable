local ThemeGuessSelectBtn = class("ThemeGuessSelectBtn", require("app.fairyGUI.summerThemeGame.UI_ThemeGuessSelectBtn"))

function ThemeGuessSelectBtn:onPlaySelectAnim(arg_1_1)
	if arg_1_1 then
		self.m_correctTransition:play()
	else
		self.m_selectTransition:play()
	end
end

return ThemeGuessSelectBtn
