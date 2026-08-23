local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.cultivateDataMgr
local var_0_3 = g.core.common.Path
local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_5 = {
	[CultivateConst.TASK_TYPE.DAILY_TASK] = 772,
	[CultivateConst.TASK_TYPE.ACHIEVEMENT_TASK] = 773
}
local CultivateTaskLayer = class("CultivateTaskLayer", require("app.fairyGUI.cultivate.UI_CultivateTaskLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/cultivate/cultivate",
		resName = "CultivateTaskLayer",
		pkgName = "cultivate"
	}, ...)
end)

function CultivateTaskLayer:ctor(arg_2_1)
	self._actId = type(arg_2_1) ~= "table" and arg_2_1 or arg_2_1.route1
	self._actData = var_0_2:getCultivateData(self._actId)
	self._taskList = {}

	self:initTaskMainView()
end

function CultivateTaskLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CULTIVATE_ACTIVITY_UPDATETASK, handler(self, self._onCultivateActivityUpdateTask), self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_CULTIVATE_ACTIVITY_TASKAWARD, handler(self, self._onCultivateActivityGetTaskReward), self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:newSchedule(handler(self, self.updatePassCardTime), CultivateConst.UPDATE_TIME_SCHEDULER)
	self.m_enterTransition:play()

	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end

	self:updateTaskList(true)
	self:updatePassCardTime()
end

function CultivateTaskLayer:_onCrossDayUpdate()
	if not self._actData:isInNormalOpenTime() then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	if self._actId then
		g.core.network.GameNetProxy:send_C2S_CultivateActivity_GetInfo({
			activity_id = self._actId
		})
	end
end

function CultivateTaskLayer:initTaskMainView()
	local var_5_0 = self._actData:getActivityCfg()
	local var_5_1 = g.core.config.cultivate_activity_display_info.get(var_5_0.id)

	self:addBg("bg/cultivate/" .. var_0_2:getResDirId(var_5_0.id) .. "/bg_main.jpg")
	self.m_topBarComp:setResInfoById(var_5_1.interface_task)
	self.m_topBarComp:setTitle(var_5_1.module_task)
	self.m_titleTextIcon:setURL(var_0_3:getCultivateMulLangImage("txt_main_gwcs", var_0_2:getResDirId(var_5_0.id)))
	self.m_lineLoader:setIcon(var_0_3:getCultivateImage("pic_mainzs", var_0_2:getResDirId(var_5_0.id)))
	self.m_timeDiGraph:setColor(cc.c3b(CultivateConst.hexToRgb(var_5_1.color_time)))
	self.m_tabList:setIniter()
	self.m_taskList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabItemRenderer))
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRenderer))
	self.m_taskList:doFairyBatching(false)
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabItem))

	local var_5_2 = self._actData:getTaskData():getAllTaskType()

	self._taskTaskType = var_5_2

	self.m_tabList:setNumItems(#var_5_2)
	self.m_tabList:setSelectedIndex(0)

	self._curSelIndex = 0

	self:updateTaskList(true)
	self:updatePassCardTime()
end

function CultivateTaskLayer:updatePassCardTime()
	local var_6_0, var_6_1, var_6_2, var_6_3 = g.core.common.ServerTime:getLeftTimeParts((self._actData:getEndTime()))

	self.m_timeTxt:setText(g.core.lang:get(421407, {
		day = var_6_0,
		hour = var_6_1
	}))

	if self._taskTaskType[self._curSelIndex + 1] == CultivateConst.TASK_TYPE.DAILY_TASK then
		self.m_dailyRefreshTxt:setText(g.core.lang:get(421409, {
			timeStr = g.core.common.ServerTime:getLeftSecondsString(g.core.common.ServerTime:getNextNDayZeroTime(nil, 1) + 86400)
		}))
	end
end

function CultivateTaskLayer:_onClickTabItem()
	self._curSelIndex = self.m_tabList:getSelectedIndex()

	self:updateTaskList(true)
end

function CultivateTaskLayer:_onCultivateActivityUpdateTask()
	self:updateTaskList()
end

function CultivateTaskLayer:_onTabItemRenderer(arg_9_1, arg_9_2)
	arg_9_2:setRedPoint(var_0_5[self._taskTaskType[arg_9_1 + 1]], self._actId)
	arg_9_2:updateTaskTab(self._taskTaskType[arg_9_1 + 1], self._actId)
end

function CultivateTaskLayer:updateTaskList(arg_10_1)
	self._taskList = self._actData:getTaskData():getTargetTasks(self._taskTaskType[self._curSelIndex + 1])

	self.m_taskList:setNumItems(#self._taskList)

	if arg_10_1 then
		self.m_taskList:transitionShowCells("enter_left", 0.03, 1)
	end

	self.m_dailyGroup:setVisible(self._taskTaskType[self._curSelIndex + 1] == CultivateConst.TASK_TYPE.DAILY_TASK)
end

function CultivateTaskLayer:_onTaskItemRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateCultivateCell(self._taskList[arg_11_1 + 1], self._actId)
end

function CultivateTaskLayer:_onCultivateActivityGetTaskReward(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	g.core.module.ModuleManager:awardSummary(arg_12_4.awards)
	self:updateTaskList()
end

return CultivateTaskLayer
