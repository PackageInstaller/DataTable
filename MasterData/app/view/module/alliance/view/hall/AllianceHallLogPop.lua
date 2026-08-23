local AllianceHallLogPop = class("AllianceHallLogPop", require("app.fairyGUI.alliance.UI_AllianceHallLogPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceHallLogPop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	}, ...)
end)

function AllianceHallLogPop:ctor()
	self:showAtCenter()
	self:_init()
end

function AllianceHallLogPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETLOG, handler(self, self._onRcvGetLog), self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GetLog({})
end

function AllianceHallLogPop:_init()
	self.m_logList:setVirtual()
	self.m_logList:setItemRenderer(handler(self, self._onLogCellRenderer))
	self.m_isEmptyController:setSelectedIndex(1)
end

function AllianceHallLogPop:_onLogCellRenderer(arg_5_1, arg_5_2)
	arg_5_2:setTouchable(false)
	arg_5_2:setData(self._logData[arg_5_1 + 1])
end

function AllianceHallLogPop:_onRcvGetLog()
	self._logData = g.core.model.User.allianceData:getAllianceLogList()

	if #self._logData > 0 then
		self.m_isEmptyController:setSelectedIndex(0)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end

	self.m_logList:setNumItems(#self._logData)
	self.m_logList:scrollToView(0)
end

return AllianceHallLogPop
