local OutpostBuildDailyReportPop = class("OutpostBuildDailyReportPop", require("app.fairyGUI.outpost.UI_OutpostBuildDailyReportPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostBuildDailyReportPop",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = false,
		pkgName = "outpost"
	}, ...)
end)

function OutpostBuildDailyReportPop:ctor(arg_2_1)
	self._dailyReport = arg_2_1:getDailyReportInfo()

	self:_initListPop()
	self:showAtCenter()
end

function OutpostBuildDailyReportPop:_initListPop()
	self.m_logList:setVirtual(self)
	self.m_logList:setItemRenderer(handler(self, self._onLogItemRender))
	self.m_itemIcon:setURL((g.core.common.Path:getIconByTypeValue(g.core.const.ConstMgr.outpostConst.EXCHANGE_ITEM_TYPE, g.core.const.ConstMgr.outpostConst.KNIGHT_COIN_ID)))
	self.m_rewardNumTxt:setText(self._dailyReport.total)
end

function OutpostBuildDailyReportPop:onLoad()
	self.m_logList:setNumItems(#self._dailyReport.list)
end

function OutpostBuildDailyReportPop:_onLogItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateDailyCell(self._dailyReport.list[#self._dailyReport.list - arg_5_1])
end

return OutpostBuildDailyReportPop
