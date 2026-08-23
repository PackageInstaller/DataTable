local LoginServerCell = class("LoginServerCell", require("app.fairyGUI.login.UI_LoginServerCell"))

function LoginServerCell:ctor()
	return
end

function LoginServerCell:updateServerCell(arg_2_1, arg_2_2)
	local var_2_0 = g.core.platform.ServerListProxy:getBaseMainServer(arg_2_2.sid)

	self.m_serverIdTxt:setText((var_2_0 or nil) and g.core.lang:get(100056, {
		mainServerName = var_2_0.name,
		curServerName = arg_2_2.name
	}))
	self.m_typeController:setSelectedIndex((g.core.platform.ServerListProxy:getServerState(arg_2_2)))
end

return LoginServerCell
