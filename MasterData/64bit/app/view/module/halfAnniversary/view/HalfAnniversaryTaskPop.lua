local var_0_0 = g.core.model.User.halfAnniversaryData
local HalfAnniversaryTaskPop = class("HalfAnniversaryTaskPop", require("app.fairyGUI.halfAnniversary.UI_HalfAnniversaryTaskPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/halfAnniversary/halfAnniversary",
		resName = "HalfAnniversaryTaskPop",
		pkgName = "halfAnniversary"
	})
end)

function HalfAnniversaryTaskPop:ctor()
	self:showAtCenter()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskCellRenderer))
	self.m_popPanel:setTitleName(var_0_0:getHalfYearActivityCfg().name)
end

function HalfAnniversaryTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETAWARD, handler(self, self._onTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_NOTIFYTASK, handler(self, self._onRefreshTaskView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WELFAREFUND_GETINFO, handler(self, self._onRefreshTaskView), self)
	self:_onRefreshTaskView()
end

function HalfAnniversaryTaskPop:_onTaskAward(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_4_4.awards)
		self:_onRefreshTaskView()
	end
end

function HalfAnniversaryTaskPop:_onRefreshTaskView()
	self._listData = var_0_0:getActivityTaskInfo()

	self.m_taskList:setNumItems(#self._listData)
	self.m_taskList:transitionShowCells("enter_down", 0.03)
end

function HalfAnniversaryTaskPop:_onTaskCellRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._listData[arg_6_1 + 1])
end

return HalfAnniversaryTaskPop
