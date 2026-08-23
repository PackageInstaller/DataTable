local ThemeTurnCardTitleComp = class("ThemeTurnCardTitleComp", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardTitleComp"))

function ThemeTurnCardTitleComp:setEnglishTitle(arg_1_1)
	self.m_englishTitle:setText(arg_1_1)
end

function ThemeTurnCardTitleComp:setDescText(arg_2_1)
	self.m_descTxt:setText(arg_2_1)
end

return ThemeTurnCardTitleComp
