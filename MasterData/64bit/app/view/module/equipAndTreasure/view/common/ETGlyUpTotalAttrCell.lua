local ETGlyUpPopAttrCell = class("ETGlyUpPopAttrCell", require("app.fairyGUI.equipAndTreasure.UI_ETGlyUpTotalAttrCell"))

function ETGlyUpPopAttrCell:updateItem(arg_1_1)
	if arg_1_1.icon then
		self.m_curIcon:setURL(arg_1_1.icon)
	end

	self.m_curNameTxt:setText(arg_1_1.curName or "")
	self.m_preValueTxt:setText(arg_1_1.preValue or 0)
	self.m_curValueTxt:setText(arg_1_1.curValue or 0)
end

return ETGlyUpPopAttrCell
