local var_0_0 = g.core.model.User.outpostData:getTaskData()
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostGuideTaskPop = class("OutpostGuideTaskPop", require("app.fairyGUI.outpost.UI_OutpostGuideTaskPop"), function()
	return fgui.GComponent:create({
		resName = "OutpostGuideTaskPop",
		pkgPath = "ui/outpost/outpost",
		isFullScreen = false,
		pkgName = "outpost"
	}, ...)
end)

function OutpostGuideTaskPop:ctor()
	self._taskInfoList = {}

	self:_initTaskPop()
	self:_initTaskList()
	self:showAtCenter()
end

function OutpostGuideTaskPop:_initTaskPop()
	self.m_taskList:setVirtual(self)
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
end

function OutpostGuideTaskPop:_initTaskList()
	self._taskInfoList = {}

	for iter_4_0, iter_4_1 in ipairs((var_0_0:getTaskIdList(var_0_1.TASK_TYPE.MAIN))) do
		self._taskInfoList[iter_4_0] = {
			id = iter_4_1
		}
	end
end

function OutpostGuideTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETTASKAWARD, handler(self, self._onGetTaskAward), self)
	self:_updateList()
end

function OutpostGuideTaskPop:_updateList()
	self.m_taskList:setNumItems(#self._taskInfoList)
end

function OutpostGuideTaskPop:_onTaskItemRender(arg_7_1, arg_7_2)
	local var_7_0 = self._taskInfoList[arg_7_1 + 1]

	if not self._taskInfoList[arg_7_1 + 1].cfg then
		var_7_0.cfg = g.core.config.outpost_main_quest_info.get(var_7_0.id)
		var_7_0.awards = var_0_0:getTaskAward(var_7_0.cfg)
	end

	var_7_0.isLock = arg_7_1 + 1 > var_0_0:getCurTaskIdx()
	var_7_0.action = var_0_0:getAction(var_7_0.id)

	arg_7_2:updateTaskCell(var_7_0)
end

function OutpostGuideTaskPop:receiveCompEvent(arg_8_1)
	if arg_8_1 == "getTaskAward" then
		self:_sendGetTaskAward((...))

		return true
	end
end

function OutpostGuideTaskPop:_sendGetTaskAward(arg_9_1)
	g.core.network.GameNetProxy:send_C2S_Outpost_GetTaskAward({
		task_id = arg_9_1.id,
		task_tp = var_0_1.TASK_TYPE.MAIN
	})
end

function OutpostGuideTaskPop:_onGetTaskAward(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	g.core.module.ModuleManager:awardSummary(arg_10_4.awards)
	self:_updateList()
end

return OutpostGuideTaskPop
