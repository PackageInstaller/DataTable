local IllustrationShareBtn = class("IllustrationShareBtn", require("app.fairyGUI.illustration.UI_IllustrationShareBtn"))

function IllustrationShareBtn:update(arg_1_1)
	if arg_1_1.first then
		self.m_firstController:setSelectedIndex(1)
	else
		self.m_firstController:setSelectedIndex(0)
	end
end

return IllustrationShareBtn
