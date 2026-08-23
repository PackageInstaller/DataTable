local AncientsMessageCell = class("AncientsMessageCell", require("app.fairyGUI.ancients.UI_AncientsMessageCell"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.message

	self.m_Txt_Message:setText(arg_2_1.message.message)
	self.m_Txt_time:setText(g.core.common.ServerTime:getDateYMDFormat(var_2_0.create_time))

	if arg_2_1.snapshot then
		self.m_Comp_name:setText(arg_2_1.snapshot.name)
	else
		self.m_Comp_name:setText("")
	end

	if var_2_0.is_captain then
		self.m_is_captainController:setSelectedIndex(1)
	else
		self.m_is_captainController:setSelectedIndex(0)
	end
end

return var_0_0
