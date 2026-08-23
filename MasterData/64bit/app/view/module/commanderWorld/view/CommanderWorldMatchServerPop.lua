local var_0_0 = g.core.model.User.commanderWorldData
local CommanderWorldMatchServerPop = class("CommanderWorldMatchServerPop", require("app.fairyGUI.commanderWorld.UI_CommanderWorldMatchServerPop"), function()
	return fgui.GComponent:create({
		pkgName = "commanderWorld",
		isFullScreen = false,
		pkgPath = "ui/commanderWorld/commanderWorld",
		resName = "CommanderWorldMatchServerPop"
	}, ...)
end)

function CommanderWorldMatchServerPop:ctor()
	self._serverInfo = {}

	self:showAtCenter()
	self.m_serverList:setVirtual()
	self.m_serverList:setItemRenderer(handler(self, self._onServerListRenderer))
end

function CommanderWorldMatchServerPop:onLoad()
	self._serverInfo = var_0_0:getServerInfo()

	self.m_serverList:setNumItems(#self._serverInfo)
end

function CommanderWorldMatchServerPop:_onServerListRenderer(arg_4_1, arg_4_2)
	arg_4_2:setTitle(self._serverInfo[arg_4_1 + 1].serverName or "")
end

return CommanderWorldMatchServerPop
