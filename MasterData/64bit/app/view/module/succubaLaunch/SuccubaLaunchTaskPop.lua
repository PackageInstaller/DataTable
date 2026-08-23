local var_0_0 = g.core.model.User.succubaLaunchData
local SuccubaLaunchTaskPop = class("SuccubaLaunchTaskPop", require("app.fairyGUI.succubaLaunch.UI_SuccubaLaunchTaskPop"), function()
	return fgui.GComponent:create({
		pkgName = "succubaLaunch",
		isFullScreen = false,
		pkgPath = "ui/succubaLaunch/succubaLaunch",
		resName = "SuccubaLaunchTaskPop"
	}, ...)
end)

function SuccubaLaunchTaskPop:ctor()
	self:showAtCenter()
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self.onTaskItemRenderer))
	self:updateTaskList()
end

function SuccubaLaunchTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_ACTIVITY_GETINFO, handler(self, self.updateTaskList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUCCUBA_ACTIVITY_FINISHTASK, handler(self, self._onTaskAward), self)
end

function SuccubaLaunchTaskPop:_onTaskAward(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	g.core.module.ModuleManager:awardSummary(arg_4_4.awards or {})
	self:updateTaskList()
end

function SuccubaLaunchTaskPop:updateTaskList()
	self._tasks = var_0_0:getAllShowTasks()

	self.m_taskList:setNumItems(#self._tasks)
end

function SuccubaLaunchTaskPop:onTaskItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateSuccubaTask(self._tasks[arg_6_1 + 1])
end

return SuccubaLaunchTaskPop
