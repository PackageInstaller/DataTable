local var_0_0 = g.core.config.war_zone_name_info
local AllianceAreaPop = class("AllianceAreaPop", require("app.fairyGUI.alliance.UI_AllianceAreaPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceAreaPop",
		pkgName = "alliance",
		pkgPath = "ui/alliance/alliance"
	}, ...)
end)

function AllianceAreaPop:ctor()
	self:showAtCenter()
	self:initView()
end

function AllianceAreaPop:initView()
	return
end

function AllianceAreaPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SERVERINFOS, handler(self, self._onGetServerData), self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ServerInfos({})
end

function AllianceAreaPop:_onGetServerData(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_4.server_infos or {}
	local var_5_1 = {}

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		return arg_6_0.long_sid < arg_6_1.long_sid
	end)

	local var_5_2 = ""

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1.sid == arg_5_4.sid then
			var_5_2 = iter_5_1.serverName
		end

		table.insert(var_5_1, iter_5_1.serverName)
	end

	self.m_allServerText:setText((table.concat(var_5_1, ",")))
	self.m_curServerText:setText(var_5_2)
	self.m_areaName:setText((var_0_0.fetch(arg_5_4.area) or {}).name or "")
end

return AllianceAreaPop
