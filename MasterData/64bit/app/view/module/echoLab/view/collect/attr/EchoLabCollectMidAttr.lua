local EchoLabCollectMidAttr = class("EchoLabCollectMidAttr", require("app.fairyGUI.echoLab.UI_EchoLabCollectMidAttr"))

function EchoLabCollectMidAttr:ctor()
	return
end

function EchoLabCollectMidAttr:updateView(arg_2_1)
	self.m_titleComp:setTitle(arg_2_1.title)

	if arg_2_1.titleIcon then
		self.m_titleComp:setIcon(arg_2_1.titleIcon)
		self.m_titleComp:getChild("icon"):setVisible(true)
	else
		self.m_titleComp:getChild("icon"):setVisible(false)
	end

	self.m_descText:setText(arg_2_1.desc)
end

return EchoLabCollectMidAttr
