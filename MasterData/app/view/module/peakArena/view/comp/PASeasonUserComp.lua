local var_0_0 = g.core.model.User
local PASeasonUserComp = class("PASeasonUserComp", require("app.fairyGUI.peakArena.UI_PASeasonUserComp"))

function PASeasonUserComp:ctor()
	self._userData = nil
end

function PASeasonUserComp:updateUserInfo(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._userData = arg_2_1

	self.m_name:setText(arg_2_1.name)
	self.m_level:setText(g.core.lang:get(2052, {
		level = arg_2_1.level
	}))
	self.m_serverName:setText((g.core.platform.ServerListProxy:getServerById(tonumber(arg_2_1.sid)) or {}).name or "")

	if arg_2_1.id == var_0_0:getId() then
		self.m_userIcon:updateAsUser(var_0_0:packUser())
	else
		self.m_userIcon:updateAsUser(arg_2_1)
	end
end

return PASeasonUserComp
