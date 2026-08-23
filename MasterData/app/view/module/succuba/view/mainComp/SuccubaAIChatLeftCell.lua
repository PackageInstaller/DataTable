local SuccubaAIChatLeftCell = class("SuccubaAIChatLeftCell", require("app.fairyGUI.succuba.UI_SuccubaAIChatLeftCell"))

function SuccubaAIChatLeftCell:ctor()
	self._chatInfo = nil
end

function SuccubaAIChatLeftCell:updateChatItem(arg_2_1)
	self._chatInfo = arg_2_1

	self.m_iconComp:getChild("iconComp"):setIcon(arg_2_1.icon)
	self.m_nameTxt:setText(table.concat({
		arg_2_1.name,
		arg_2_1.time
	}, " "))
	self.m_content:setText(arg_2_1.content)
	self.m_sizeLabel:setText(arg_2_1.content)

	local var_2_0 = self.m_sizeLabel:getSize()

	if math.ceil(var_2_0.width / 400) > 1 then
		var_2_0 = self.m_content:getSize()
		var_2_0.width = 400
	end

	self.m_content:setSize(var_2_0)
end

return SuccubaAIChatLeftCell
