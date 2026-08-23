local var_0_0 = g.core.model.User.guildWarData
local GuildWarMatchingShowPop = class("GuildWarMatchingShowPop", require("app.fairyGUI.guildWar.UI_GuildWarMatchingShowPop"), function()
	return fgui.GComponent:create({
		resName = "GuildWarMatchingShowPop",
		pkgPath = "ui/guildWar/guildWar",
		isFullScreen = false,
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarMatchingShowPop:ctor()
	self._serverList = {}

	self:_initView()
end

function GuildWarMatchingShowPop:_initView()
	self:showAtCenter()
	self.m_serverList:setVirtual()
	self.m_serverList:setItemRenderer(handler(self, self._onRendererServerList))
end

function GuildWarMatchingShowPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_GETSERVERINFO, self._onS2CServerList, self)

	local var_4_0 = var_0_0:getServerList()

	if var_4_0 and table.nums(var_4_0) > 0 then
		self._serverList = var_4_0

		self:updateView()
	else
		g.core.network.GameNetProxy:send_C2S_GuildWar_GetServerInfo({})
	end
end

function GuildWarMatchingShowPop:_onS2CServerList()
	self._serverList = var_0_0:getServerList()

	self:updateView()
end

function GuildWarMatchingShowPop:updateView()
	self.m_serverList:setNumItems(#self._serverList)
end

function GuildWarMatchingShowPop:_onRendererServerList(arg_7_1, arg_7_2)
	arg_7_2:update(self._serverList[arg_7_1 + 1])
end

return GuildWarMatchingShowPop
