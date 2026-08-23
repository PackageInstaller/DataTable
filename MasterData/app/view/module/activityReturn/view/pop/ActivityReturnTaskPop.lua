local ActivityReturnTaskPop = class("ActivityReturnTaskPop", require("app.fairyGUI.activityReturn.UI_ActivityReturnTaskPop"), function()
	return fgui.GComponent:create({
		resName = "ActivityReturnTaskPop",
		pkgPath = "ui/activityReturn/activityReturn",
		pkgName = "activityReturn"
	}, ...)
end)

function ActivityReturnTaskPop:ctor(arg_2_1)
	self:showAtCenter()

	self._taskList = arg_2_1.task
	self._activityInfo = arg_2_1.activityInfo

	self.m_popPanel:setText("")
	self.m_title:setText(arg_2_1.name)
	self:_initPop()
end

function ActivityReturnTaskPop:_sortTask()
	table.sort(self._taskList, function(arg_4_0, arg_4_1)
		if arg_4_0.state ~= arg_4_1.state then
			if arg_4_0.state == 1 or arg_4_1.state == 1 then
				return arg_4_0.state == 1
			elseif arg_4_0.state == 0 or arg_4_1.state == 0 then
				return arg_4_0.state == 0
			else
				return arg_4_0.state ~= 2
			end
		end

		return arg_4_0.cfg.id > arg_4_1.cfg.id
	end)
end

function ActivityReturnTaskPop:_initPop()
	self.m_taskList:setVirtual(self)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
	self.m_taskList:doFairyBatching(false)
end

function ActivityReturnTaskPop:_onTaskItemRender(arg_6_1, arg_6_2)
	arg_6_2:updateTaskCell(self._taskList[arg_6_1 + 1])
end

function ActivityReturnTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RERUN_TASKAWARD, handler(self, self._onReturnAwardReceive), self)
	self:_onStartTimer()
	self:_updateView()
end

function ActivityReturnTaskPop:onUnload()
	self:_onStopTimer()
end

function ActivityReturnTaskPop:_updateView()
	self:_sortTask()
	self.m_taskList:setNumItems(#self._taskList)
end

function ActivityReturnTaskPop:_onStartTimer()
	self._cdTimer = self._cdTimer or self:newSchedule(handler(self, self._updateTimer), 60)

	self:_updateTimer()
end

function ActivityReturnTaskPop:_onStopTimer()
	if self._cdTimer then
		self:cancelSchedule(self._cdTimer)
	end

	self._cdTimer = nil
end

function ActivityReturnTaskPop:_updateTimer()
	if self._activityInfo.end_time < g.core.common.ServerTime:getTime() then
		self:_onStopTimer()
		self.m_timeTxt:setText("")

		return
	end

	local var_12_0, var_12_1, var_12_2, var_12_3 = g.core.common.ServerTime:getLeftTimeParts(self._activityInfo.end_time)

	self.m_timeTxt:setText(var_12_0 >= 1 and g.core.lang:get(425504, {
		day = var_12_0,
		hour = var_12_1
	}) or g.core.lang:get(425505, {
		hour = var_12_1,
		minute = var_12_2
	}))
end

function ActivityReturnTaskPop:receiveCompEvent(arg_13_1, arg_13_2)
	if arg_13_1 == "getTaskAward" then
		self:_onReqTasksAward({
			arg_13_2.task.cfg.id
		})

		return true
	end
end

function ActivityReturnTaskPop:_onReqTasksAward(arg_14_1)
	g.core.network.GameNetProxy:send_C2S_Rerun_TaskAward({
		ids = arg_14_1
	})
end

function ActivityReturnTaskPop:_onReturnAwardReceive(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = false

	for iter_15_0, iter_15_1 in ipairs(arg_15_4.ids) do
		if g.core.config.activity_rerun_task_info.get(iter_15_1).task_type < 3 then
			var_15_0 = true

			break
		end
	end

	if not var_15_0 then
		return
	end

	local var_15_1 = {
		showNow = true
	}
	local var_15_2 = {}

	var_15_2.awards = arg_15_4.awards or {}
	var_15_1.award = var_15_2

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_15_1)
	self:_updateView()
end

return ActivityReturnTaskPop
