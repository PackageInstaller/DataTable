local LotteryTaskPop = class("LotteryTaskPop", require("app.fairyGUI.lottery.UI_LotteryTaskPop"), function()
	return fgui.GComponent:create({
		resName = "LotteryTaskPop",
		pkgPath = "ui/lottery/lottery",
		pkgName = "lottery"
	})
end)

function LotteryTaskPop:ctor(arg_2_1)
	self._listData = arg_2_1

	self:showAtCenter()
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskCellRenderer))
	self.m_taskList:doFairyBatching(false)
end

function LotteryTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_LOTTERY_TASKAWARD, handler(self, self._onTaskAward), self)
	self:onUpdatePop()
end

function LotteryTaskPop:_onTaskAward(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	g.core.module.ModuleManager:awardSummary(arg_4_4.awards)
	self:onUpdatePop()
end

function LotteryTaskPop:onUpdatePop()
	self.m_taskList:setNumItems(#self._listData)
	self.m_taskList:transitionShowCells("enter_down", 0.03)
end

function LotteryTaskPop:_onTaskCellRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._listData[arg_6_1 + 1])
end

return LotteryTaskPop
