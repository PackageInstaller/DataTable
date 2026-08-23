local NewSlgDevelopUpgradeCell = class("NewSlgDevelopUpgradeCell", require("app.fairyGUI.newSlg.UI_NewSlgDevelopUpgradeCell"))

function NewSlgDevelopUpgradeCell:ctor()
	return
end

function NewSlgDevelopUpgradeCell:updateUpgradeCell(arg_2_1)
	self.m_title:setText(arg_2_1.name)

	if arg_2_1.isPercent then
		arg_2_1.curNum = arg_2_1.curNum / 100 .. "%"

		if arg_2_1.nextNum then
			arg_2_1.nextNum = arg_2_1.nextNum / 100 .. "%"
		end
	end

	if arg_2_1.curNum ~= arg_2_1.nextNum then
		self.m_attrNumController:setSelectedIndex(2)
		self.m_firstAttValue:setText(arg_2_1.curNum)
		self.m_secondAttrValue:setText(arg_2_1.nextNum)
	else
		self.m_attrNumController:setSelectedIndex(1)
		self.m_firstAttValue:setText(arg_2_1.curNum)
	end
end

return NewSlgDevelopUpgradeCell
