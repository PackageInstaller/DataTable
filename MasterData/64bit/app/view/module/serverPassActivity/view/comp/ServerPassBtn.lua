local ServerPassBtn = class("ServerPassBtn", require("app.fairyGUI.serverPassActivity.UI_ServerPassBtn"))

function ServerPassBtn:setNormalTitle(arg_1_1)
	self.m_normalTitle:setText(arg_1_1)
	self.m_numberTitle:setText("")
end

function ServerPassBtn:setNumberTitle(arg_2_1)
	self.m_numberTitle:setText(arg_2_1)
	self.m_normalTitle:setText("")
end

return ServerPassBtn
