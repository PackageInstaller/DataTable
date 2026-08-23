local var_0_0 = g.core.model.User.peakArenaData
local PeakArenaMatchServerPop = class("PeakArenaMatchServerPop", require("app.fairyGUI.peakArena.UI_PeakArenaMatchServerPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/peakArena/peakArena",
		resName = "PeakArenaMatchServerPop",
		pkgName = "peakArena",
		isFullScreen = false
	}, ...)
end)

function PeakArenaMatchServerPop:ctor()
	self:showAtCenter()
	self.m_serverList:setVirtual()
	self.m_serverList:setItemRenderer(handler(self, self._onServerListRenderer))
end

function PeakArenaMatchServerPop:onLoad()
	self.m_serverList:setNumItems(#var_0_0:getServerSidArr())
end

function PeakArenaMatchServerPop:_onServerListRenderer(arg_4_1, arg_4_2)
	arg_4_2:getChild("serverNameTxt"):setText(var_0_0:getServerSidArr()[arg_4_1 + 1].serverName)
end

return PeakArenaMatchServerPop
