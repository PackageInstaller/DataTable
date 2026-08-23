local EchoLabText = class("EchoLabText", require("app.fairyGUI.echoLab.UI_EchoLabText"))

function EchoLabText:ctor()
	self.m_title:enableRich()
end

function EchoLabText:updateView(arg_2_1)
	self.m_title:setText(arg_2_1, true)
end

return EchoLabText
