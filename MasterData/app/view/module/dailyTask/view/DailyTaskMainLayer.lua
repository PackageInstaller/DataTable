local var_0_0 = g.core.model.User.dailyTaskData
local var_0_1 = g.core.common.Goods
local DailyTaskMainLayer = class("DailyTaskMainLayer", require("app.fairyGUI.dailyTask.UI_DailyTaskMainLayer"), function()
	return fgui.GComponent:create({
		resName = "DailyTaskMainLayer",
		pkgPath = "ui/dailyTask/dailyTask",
		isFullScreen = true,
		pkgName = "dailyTask"
	}, ...)
end)

function DailyTaskMainLayer:ctor(arg_2_1)
	self:addBg("bg/dailyTask/bg_mrrw_meirirenwu.jpg")

	self._firstSort = true
	self._isFirstEnter = true
	self._taskListData = {}
	self._resList = {
		{
			type = var_0_1.TYPE_RESOURCE,
			value = var_0_1.RESOURCE.TYPE_COIN
		},
		{
			value = 0,
			type = var_0_1.TYPE_GOLD
		},
		{
			type = var_0_1.TYPE_RESOURCE,
			value = var_0_1.RESOURCE.TYPE_STAMINA
		}
	}

	self.m_taskList:setVirtual(self)
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRenderer))
	self.m_topBar:setResInfoById(14)
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyBtnClick))
	self.m_enterTransition:setHook("list", handler(self, self._updateTaskList))
end

function DailyTaskMainLayer:onLoad()
	if not var_0_0:hasData() or var_0_0:isExpired() then
		g.core.network.GameNetProxy:send_C2S_DailyTask_GetInfo({})
		var_0_0:resetExpired()
	else
		self:_updateTask(self._firstSort)
		self.m_dialogComp:updateDialog()

		self._firstSort = false
	end

	local var_3_0 = g.core.event.EventManager

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, handler(self, self._onStateFlush), self)
	var_3_0:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_GETINFO, handler(self, self._onTaskGetInfo), self)
	var_3_0:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_FINISHAWARD, handler(self, self._onTaskAwardsBack), self)
	var_3_0:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_DEGREEAWARD, handler(self, self._onDegreeAwardsBack), self)
	var_3_0:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_TASK_ONEKEY_FINISHAWARD, handler(self, self._onTaskAwardsBack), self)
	self.m_enterTransition:play()
end

function DailyTaskMainLayer:_updateTask(arg_4_1)
	self._taskListData = var_0_0:getFinalDailyTaskInfo(arg_4_1)

	self.m_showOneKeyController:setSelectedIndex(var_0_0:getIsShowOneKey() and 1 or 0)
	self:_updateProgress()

	if not self._isFirstEnter then
		self:_updateTaskList()
	end
end

function DailyTaskMainLayer:_updateProgress()
	self.m_progressComp:updateProgress()
end

function DailyTaskMainLayer:_updateTaskList()
	self.m_taskList:setNumItems(#self._taskListData)
	self.m_taskList:transitionShowCells("enter_right", 0.03, 1)

	self._isFirstEnter = false
end

function DailyTaskMainLayer:_onTaskItemRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateItem(self._taskListData[arg_7_1 + 1])
end

function DailyTaskMainLayer:_onStateFlush()
	self:_updateTask(self._firstSort)

	self._firstSort = false
end

function DailyTaskMainLayer:_onTaskGetInfo()
	self:_updateTask(self._firstSort)

	self._firstSort = false
end

function DailyTaskMainLayer:_onTaskAwardsBack()
	local var_10_0 = var_0_0:getDailyTaskAwards()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		iter_10_1.changeControllers = true
		iter_10_1.nameRow = 2
	end

	require("app.view.module.show.ShowFactory"):awardSummary(var_10_0)
	self:_updateTask(true)
	self.m_dialogComp:updateDialog(3)
end

function DailyTaskMainLayer:_onDegreeAwardsBack()
	local var_11_0 = var_0_0:getDailyTaskAwards()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		iter_11_1.changeControllers = true
		iter_11_1.nameRow = 2
	end

	require("app.view.module.show.ShowFactory"):awardSummary(var_11_0)
	self:_updateTask()
	self.m_dialogComp:updateDialog(3)
end

function DailyTaskMainLayer:_onOneKeyBtnClick()
	g.core.network.GameNetProxy:send_C2S_DailyTask_OneKey_FinishAward({})
end

return DailyTaskMainLayer
