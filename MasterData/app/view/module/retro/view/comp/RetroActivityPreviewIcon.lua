local RetroActivityPreviewIcon = class("RetroActivityPreviewIcon", require("app.fairyGUI.retro.UI_RetroActivityPreviewIcon"))

function RetroActivityPreviewIcon:updatePreviewIcon(arg_1_1)
	self.m_icon:updateIcon({
		type = arg_1_1.info.type,
		value = arg_1_1.info.value
	})
	self.m_numText:setText(arg_1_1.info.size)

	if arg_1_1.info.prob > 0 then
		self.m_showUpTipController:setSelectedIndex(1)
		self.m_upText:setText(arg_1_1.info.prob / 100 .. "%")
	else
		self.m_showUpTipController:setSelectedIndex(1)
	end
end

return RetroActivityPreviewIcon
