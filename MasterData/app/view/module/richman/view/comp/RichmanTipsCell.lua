local var_0_0 = g.core.config.richman_event_text_info
local RichmanTipsCell = class("RichmanTipsCell", require("app.fairyGUI.richman.UI_RichmanTipsCell"))

function RichmanTipsCell:updateRichmanTipsCell(arg_1_1)
	local var_1_0 = var_0_0.get(arg_1_1)

	self.m_title:setText(var_1_0.name)
	self.m_descTxt:setText(var_1_0.text)
	self.m_icon:setURL("pic/richman/event/" .. var_1_0.res .. ".png")
end

return RichmanTipsCell
