local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.model.User.blazingArenaData
local BlazingArenaMatchServerPop = class("BlazingArenaMatchServerPop", require("app.fairyGUI.blazingArena.UI_BlazingArenaMatchServerPop"), function()
	return fgui.GComponent:create({
		resName = "BlazingArenaMatchServerPop",
		pkgName = "blazingArena"
	}, ...)
end)

function BlazingArenaMatchServerPop:ctor(arg_2_1)
	self:showAtCenter()

	self._serverList = {}

	self:_initListView()
end

function BlazingArenaMatchServerPop:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_BLAZING_ARENA_SERVERINFOS, self._onS2CGetServerInfo, self)
	var_0_2:send_C2S_BlazingArena_ServerInfos({})
end

function BlazingArenaMatchServerPop:_initListView()
	self.m_serverList:setVirtual()
	self.m_serverList:setItemRenderer(handler(self, self._onRenderServerList))
end

function BlazingArenaMatchServerPop:_onRenderServerList(arg_5_1, arg_5_2)
	arg_5_2:setTitle((g.core.platform.ServerListProxy:getServerById(self._serverList[arg_5_1 + 1].long_sid) or {
		name = self._serverList[arg_5_1 + 1].serverName
	}).name)
end

function BlazingArenaMatchServerPop:_updateView()
	self._serverList = var_0_3:getGameServerList()

	self.m_serverList:setNumItems(#self._serverList)
end

function BlazingArenaMatchServerPop:_onS2CGetServerInfo(arg_7_1, arg_7_2, arg_7_3)
	self:_updateView()
end

return BlazingArenaMatchServerPop
