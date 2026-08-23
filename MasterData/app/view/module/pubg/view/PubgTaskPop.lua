local PubgTaskPop = class("PubgTaskPop", require("app.fairyGUI.pubg.UI_PubgTaskPop"), function()
	return fgui.GComponent:create({
		resName = "PubgTaskPop",
		pkgName = "pubg"
	}, ...)
end)

function PubgTaskPop:ctor()
	self:showAtCenter()
	self:_initRegisterUI()

	self._tasks = {}
end

function PubgTaskPop:_initRegisterUI()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
end

function PubgTaskPop:_onTaskItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateTaskCell(self._tasks[arg_4_1 + 1])
end

function PubgTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_TASKINFO, handler(self, self._updateTaskView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_TASKAWARD, handler(self, self._onPubgTaskAward), self)
	g.core.network.GameNetProxy:send_C2S_Pubg_TaskInfo({})
	self.m_enterTransition:play()
end

function PubgTaskPop:_updateTaskView()
	self._taskData = g.core.model.User.pubgData:getTaskData()
	self._tasks = self._taskData:getTaskList()

	self.m_taskList:setNumItems(#self._tasks)
end

function PubgTaskPop:_onPubgTaskAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards, true)
	self:_updateTaskView()
end

function PubgTaskPop:_onCrossDay()
	g.core.network.GameNetProxy:send_C2S_Pubg_TaskInfo({})
end

function PubgTaskPop:popSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function PubgTaskPop:_onClickClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.popSelf))
end

return PubgTaskPop
