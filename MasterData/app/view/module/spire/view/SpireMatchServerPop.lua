local var_0_0 = g.core.model.User.spireData
local SpireMatchServerPop = class("SpireMatchServerPop", require("app.fairyGUI.spire.UI_SpireMatchServerPop"), function()
	return fgui.GComponent:create({
		resName = "SpireMatchServerPop",
		pkgName = "spire"
	}, ...)
end)

function SpireMatchServerPop:ctor(arg_2_1)
	self:showAtCenter()

	self._serverList = {}

	self:_initListView()
end

function SpireMatchServerPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_SERVERINFOS, self._onS2CGetServerInfo, self)
	g.core.network.GameNetProxy:send_C2S_Spire_ServerInfos({})
end

function SpireMatchServerPop:_initListView()
	self.m_serverList:setVirtual()
	self.m_serverList:setItemRenderer(handler(self, self._onRenderServerList))
end

function SpireMatchServerPop:_onRenderServerList(arg_5_1, arg_5_2)
	arg_5_2:setTitle((g.core.platform.ServerListProxy:getServerById(self._serverList[arg_5_1 + 1].long_sid) or {
		name = self._serverList[arg_5_1 + 1].serverName
	}).name)
end

function SpireMatchServerPop:_updateView()
	self._serverList = var_0_0:getGameServerList()

	self.m_serverList:setNumItems(#self._serverList)
end

function SpireMatchServerPop:_onS2CGetServerInfo(arg_7_1, arg_7_2, arg_7_3)
	self:_updateView()
end

return SpireMatchServerPop
