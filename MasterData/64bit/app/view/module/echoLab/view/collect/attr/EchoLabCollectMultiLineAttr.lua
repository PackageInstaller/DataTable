local EchoLabCollectMultiLineAttr = class("EchoLabCollectMultiLineAttr", require("app.fairyGUI.echoLab.UI_EchoLabCollectMultiLineAttr"))

function EchoLabCollectMultiLineAttr:ctor()
	self.m_titleText1:enableRich()
	self.m_titleText2:enableRich()
	self.m_valueText1:enableRich()
	self.m_valueText2:enableRich()
end

function EchoLabCollectMultiLineAttr:updateView(arg_2_1)
	if arg_2_1.iconUrl then
		self:_updateTextIconView(arg_2_1)
	else
		self:_updateTextView(arg_2_1)
	end
end

function EchoLabCollectMultiLineAttr:_updateTextView(arg_3_1)
	for iter_3_0 = 1, 2 do
		if arg_3_1[iter_3_0] then
			self["m_titleText" .. iter_3_0]:setText(arg_3_1[iter_3_0].title, true, true)
			self["m_valueText" .. iter_3_0]:setText(arg_3_1[iter_3_0].value, true, true)
			self["m_titleText" .. iter_3_0]:setVisible(true)
			self["m_valueText" .. iter_3_0]:setVisible(true)
		else
			self["m_titleText" .. iter_3_0]:setVisible(false)
			self["m_valueText" .. iter_3_0]:setVisible(false)
		end
	end

	self.m_showIconController:setSelectedIndex(0)
end

function EchoLabCollectMultiLineAttr:_updateTextIconView(arg_4_1)
	self.m_titleText1:setText(arg_4_1.title, true, true)
	self.m_valueText2:setText(arg_4_1.value, true, true)
	self.m_icon:setURL(arg_4_1.iconUrl)
	self.m_showIconController:setSelectedIndex(1)
end

return EchoLabCollectMultiLineAttr
