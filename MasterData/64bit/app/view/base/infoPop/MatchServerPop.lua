local MatchServerPop = class("MatchServerPop", require("app.fairyGUI.infoPop.UI_MatchServerPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		isFullScreen = false,
		pkgPath = "ui/infoPop/infoPop",
		resName = "MatchServerPop"
	}, ...)
end)

function MatchServerPop:ctor(arg_2_1)
	self:showAtCenter()

	self._serverInfo = arg_2_1.serverInfo

	self.m_serverList:setVirtual()
	self.m_serverList:setItemRenderer(handler(self, self._onServerListRenderer))
end

function MatchServerPop:onLoad()
	self.m_serverList:setNumItems(#self._serverInfo)
end

function MatchServerPop:_onServerListRenderer(arg_4_1, arg_4_2)
	local var_4_0 = self._serverInfo[arg_4_1 + 1].serverName or self._serverInfo[arg_4_1 + 1].name

	var_4_0 = var_4_0 or ""

	arg_4_2:setTitle(var_4_0)
end

return MatchServerPop
