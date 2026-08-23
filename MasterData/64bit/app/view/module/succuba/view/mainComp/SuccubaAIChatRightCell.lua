local SuccubaAIChatRightCell = class("SuccubaAIChatRightCell", require("app.fairyGUI.succuba.UI_SuccubaAIChatRightCell"))

function SuccubaAIChatRightCell:ctor()
	self._chatInfo = nil
end

function SuccubaAIChatRightCell:updateChatItem(arg_2_1)
	self._chatInfo = arg_2_1

	self.m_userIcon:getChild("iconComp"):updateAsSelf()
	self.m_nameTxt:setText(table.concat({
		g.core.model.User:getName(),
		arg_2_1.time
	}, " "))
	self.m_content:setText(arg_2_1.content)
	self.m_sizeLabel:setText(arg_2_1.content)

	local var_2_0 = self.m_sizeLabel:getSize()

	if math.ceil(var_2_0.width / 400) > 1 then
		var_2_0 = self.m_content:getSize()
		var_2_0.width = 400
	else
		var_2_0.width = math.min(400, var_2_0.width + 25)
	end

	self.m_content:setSize(var_2_0)
end

return SuccubaAIChatRightCell
