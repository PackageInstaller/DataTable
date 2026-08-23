local RichmanRiceBtn = class("RichmanRiceBtn", require("app.fairyGUI.richman.UI_RichmanRiceBtn1"))

function RichmanRiceBtn:setNum(arg_1_1)
	self.m_numTxt:setText(arg_1_1)
end

return RichmanRiceBtn
