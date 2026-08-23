local var_0_0 = g.core.model.User.crossServerArenaData
local CrossServerArenaMatchServerPop = class("CrossServerArenaMatchServerPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaMatchServerPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaMatchServerPop",
		pkgPath = "ui/crossServerArena/crossServerArena",
		isFullScreen = false,
		pkgName = "crossServerArena"
	}, ...)
end)

function CrossServerArenaMatchServerPop:ctor()
	self._serverInfo = {}

	self:showAtCenter()
	self.m_serverList:setVirtual()
	self.m_serverList:setItemRenderer(handler(self, self._onServerListRenderer))
end

function CrossServerArenaMatchServerPop:onLoad()
	self._serverInfo = var_0_0:getServerInfo()

	self.m_serverList:setNumItems(#self._serverInfo)
end

function CrossServerArenaMatchServerPop:_onServerListRenderer(arg_4_1, arg_4_2)
	arg_4_2:setTitle(self._serverInfo[arg_4_1 + 1].serverName or "")
end

return CrossServerArenaMatchServerPop
