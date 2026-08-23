local ObtUserComp = class("ObtUserComp", require("app.fairyGUI.debug.UI_ObtUserComp"))

function ObtUserComp:updateUser(arg_1_1)
	self.m_userIcon:updateAsUser(arg_1_1)
	self.m_userName:setText(arg_1_1.name or "")
	self.m_fightValue:setText(arg_1_1.fight_value or 0)
	self.m_server:setText("(" .. (arg_1_1.server_name or 0) .. ")")
end

return ObtUserComp
