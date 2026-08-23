local OutpostDebugDescCell = class("OutpostDebugDescCell", require("app.fairyGUI.outpost.UI_OutpostDebugDescCell"))

function OutpostDebugDescCell:ctor()
	self:disableAutoChange()
end

function OutpostDebugDescCell:updateDesc(arg_2_1)
	self.m_desc:setText(arg_2_1, nil, true)
end

return OutpostDebugDescCell
