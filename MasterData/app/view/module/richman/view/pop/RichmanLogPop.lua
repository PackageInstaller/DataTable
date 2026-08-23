local var_0_0 = g.core.model.User.richmanData
local RichmanLogPop = class("RichmanLogPop", require("app.fairyGUI.richman.UI_RichmanLogPop"), function()
	return fgui.GComponent:create({
		resName = "RichmanLogPop",
		pkgPath = "ui/richman/richman",
		pkgName = "richman"
	})
end)

function RichmanLogPop:ctor()
	self:showAtCenter()
	self.m_logList:setVirtual()
	self.m_logList:setItemRenderer(handler(self, self._onLogRenderer))
	self.m_closeGraph:addClickListener(handler(self, self._onClosePop))
end

function RichmanLogPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETLOG, self._onLogInfoBack, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateLogCell, self)
	g.core.network.GameNetProxy:send_C2S_RichMan_GetLog({})
end

function RichmanLogPop:_onLogInfoBack(arg_4_1, arg_4_2, arg_4_3)
	var_0_0:saveStealCache()

	self._log = arg_4_3.logs or {}

	table.sort(self._log, function(arg_5_0, arg_5_1)
		return arg_5_0.time > arg_5_1.time
	end)

	if #self._log > 0 then
		self.m_logList:setNumItems(#self._log)
		self.m_emptyController:setSelectedIndex(0)
	else
		self.m_emptyController:setSelectedIndex(1)
	end
end

function RichmanLogPop:_updateLogCell(arg_6_1, arg_6_2, arg_6_3)
	self.m_logList:setNumItems(#self._log)
end

function RichmanLogPop:_onLogRenderer(arg_7_1, arg_7_2)
	arg_7_2:onShowRichmanLog(self._log[arg_7_1 + 1])
end

function RichmanLogPop:_onClosePop()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function RichmanLogPop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RichmanLogPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RICHMAN_LOG_REFRESH)
end

return RichmanLogPop
