local TreasureInfoTxtDescComp = class("TreasureInfoTxtDescComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureInfoTxtDescComp"))

function TreasureInfoTxtDescComp:ctor()
	return
end

function TreasureInfoTxtDescComp:updateView(arg_2_1)
	self.m_title:setText(arg_2_1.name)
	self.m_numLabel:setText(arg_2_1.value)
end

return TreasureInfoTxtDescComp
