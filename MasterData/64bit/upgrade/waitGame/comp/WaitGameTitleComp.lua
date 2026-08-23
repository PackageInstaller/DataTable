local WaitGameTitleComp = class("WaitGameTitleComp", require("app.fairyGUI.upgrade.UI_WaitGameTitleComp"))

function WaitGameTitleComp:setEnglishTitle(arg_1_1)
	self.m_englishTitle:setText(arg_1_1)
end

function WaitGameTitleComp:setDescText(arg_2_1)
	self.m_descTxt:setText(arg_2_1)
end

return WaitGameTitleComp
