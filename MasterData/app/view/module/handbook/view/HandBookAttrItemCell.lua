local HandBookAttrItemCell = class("HandBookAttrItemCell", require("app.fairyGUI.handBook.UI_HandBookAttrItemCell"))

function HandBookAttrItemCell:updateAttrShow(arg_1_1)
	self.m_iconImg:setURL(arg_1_1.res)
	self.m_nameTxt:setText((arg_1_1.isAll or nil) and g.core.lang:get(2071, {
		name = arg_1_1.attr[1]
	}))
	self.m_valueTxt:setText(arg_1_1.attr[2])
end

return HandBookAttrItemCell
