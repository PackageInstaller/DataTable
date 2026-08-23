local var_0_0 = g.core.model.User.spiritHelpData
local SpiritHelpHistoryPop = class("SpiritHelpHistoryPop", require("app.fairyGUI.spiritHelp.UI_SpiritHelpHistoryPop"), function()
	return fgui.GComponent:create({
		resName = "SpiritHelpHistoryPop",
		pkgPath = "ui/spiritHelp/spiritHelp",
		isFullScreen = false,
		pkgName = "spiritHelp"
	}, ...)
end)

function SpiritHelpHistoryPop:ctor()
	self._logList = {}

	self:initView()
end

function SpiritHelpHistoryPop:initView()
	self:showAtCenter()
	self.m_historyList:setVirtual()
	self.m_historyList:doFairyBatching(false)
	self.m_historyList:setItemRenderer(handler(self, self._onHistoryListRenderer))
	self.m_endComp:setTitle(g.core.lang:get(409506, {
		count = var_0_0:getMaxHistoryLogLength()
	}))
end

function SpiritHelpHistoryPop:_onHistoryListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateLogCell(self._logList[arg_4_1 + 1])
end

function SpiritHelpHistoryPop:onLoad()
	self._logList = var_0_0:getShowHistoryList(var_0_0:getAllLogList(), var_0_0:getMaxHistoryLogLength())

	if #self._logList > 0 then
		table.sort(self._logList, function(arg_6_0, arg_6_1)
			return (arg_6_0.time or 0) < (arg_6_1.time or 0)
		end)
		self.m_historyList:setNumItems(#self._logList)
		self.m_historyList:scrollToView(#self._logList - 1)
		self.m_isEmptyController:setSelectedIndex(0)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

return SpiritHelpHistoryPop
