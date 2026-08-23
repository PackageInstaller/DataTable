local LoginServerMyItem = class("LoginServerMyItem", require("app.fairyGUI.login.UI_LoginServerMyCell"))

function LoginServerMyItem:updateServerCell(arg_1_1, arg_1_2)
	self._data = arg_1_2

	local var_1_0 = g.core.platform.ServerListProxy:getBaseMainServer(arg_1_2.sid)

	self.m_serverIdTxt:setText((var_1_0 or nil) and g.core.lang:get(100056, {
		mainServerName = var_1_0.name,
		curServerName = arg_1_2.name
	}))
	self.m_typeController:setSelectedIndex((g.core.platform.ServerListProxy:getServerState(arg_1_2)))
	self.m_userNameTxt:disableAutoChange()
	self.m_userNameTxt:setText(arg_1_2.playerName or "")
	self.m_levelTxt:setText(g.core.lang:get(100038, {
		level = arg_1_2.level
	}))

	local var_1_2 = g.core.config.knight_info.fetch(arg_1_2.base_id)

	if var_1_2 then
		self.m_serverIconComp:setProperties("icon", {
			icon = g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(var_1_2.res_id).icon_id)
		})
	end
end

return LoginServerMyItem
