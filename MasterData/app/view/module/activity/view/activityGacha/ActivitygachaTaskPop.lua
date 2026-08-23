local var_0_0 = g.core.model.User.activityMonthGachaData
local ActivitygachaTaskPop = class("ActivitygachaTaskPop", require("app.fairyGUI.activity.UI_ActivitygachaTaskPop"), function()
	return fgui.GComponent:create({
		resName = "ActivitygachaTaskPop",
		pkgPath = "ui/activity/activity",
		pkgName = "activity"
	})
end)

function ActivitygachaTaskPop:ctor()
	self:showAtCenter()
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskCellRenderer))
	self.m_taskList:doFairyBatching(false)
end

function ActivitygachaTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKAWARD, handler(self, self._onTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MONTH_GACHA_TASKINFO, handler(self, self._onTaskInfo), self)
	g.core.network.GameNetProxy:send_C2S_MonthGacha_TaskInfo({})
end

function ActivitygachaTaskPop:_onTaskAward(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self:onUpdatePop()
end

function ActivitygachaTaskPop:_onTaskInfo(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:onUpdatePop()
end

function ActivitygachaTaskPop:onUpdatePop()
	self._listData = var_0_0:getTaskData()

	self.m_taskList:setNumItems(#self._listData)
	self.m_taskList:transitionShowCells("enter_down", 0.03)
end

function ActivitygachaTaskPop:_onTaskCellRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._listData[arg_7_1 + 1])
end

return ActivitygachaTaskPop
