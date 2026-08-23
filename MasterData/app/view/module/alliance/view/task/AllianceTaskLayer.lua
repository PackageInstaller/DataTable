local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local AllianceTaskLayer = class("AllianceTaskLayer", require("app.fairyGUI.alliance.UI_AllianceTaskLayer"), function()
	return fgui.GComponent:create({
		resName = "AllianceTaskLayer",
		pkgPath = "ui/alliance/alliance",
		isFullScreen = true,
		pkgName = "alliance"
	}, ...)
end)

function AllianceTaskLayer:ctor()
	self:addBg("bg/alliance/bg_ghlm_datingbg.jpg", nil, nil, 1)
	self:_initRegisterUI()
	self.m_enterTransition:play()
end

function AllianceTaskLayer:_initRegisterUI()
	self.m_topBarComp:setResInfoById(340)
	self.m_dailyTaskList:setVirtual()
	self.m_dailyTaskList:doFairyBatching(false)
	self.m_dailyTaskList:setItemRenderer(handler(self, self._onDailyTaskItemRender))
	self.m_achievementTaskList:setVirtual()
	self.m_achievementTaskList:doFairyBatching(false)
	self.m_achievementTaskList:setItemRenderer(handler(self, self._onAchievementTaskItemRender))
	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickTabChanged))
end

function AllianceTaskLayer:_onDailyTaskItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateDailyTaskCell(self._dailyTasks[arg_4_1 + 1])
end

function AllianceTaskLayer:_onAchievementTaskItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateAchievementTaskCell(self._achieveTasks[arg_5_1 + 1])
end

function AllianceTaskLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_TASKAWARD, handler(self, self._onGetTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_TASKLIST, handler(self, self.updateTaskView), self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_TaskList({})
end

function AllianceTaskLayer:_onGetTaskAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards, true)
	self:updateTaskView()
end

function AllianceTaskLayer:_onCrossDay()
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_TaskList({})
end

function AllianceTaskLayer:updateTaskView()
	self._taskData = var_0_0:getTaskData()
	self._dailyTasks = self._taskData:getTaskList(var_0_1.TASK_TYPE.DAILY)

	self.m_dailyTaskList:setNumItems(#self._dailyTasks)

	self._achieveTasks = self._taskData:getTaskList(var_0_1.TASK_TYPE.ACHIEVEMENT)

	self.m_achievementTaskList:setNumItems(#self._achieveTasks)
	self:_updateTaskTimeCountDown()
	self:playListAnimation()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_dailyTaskTab
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_achievementTab
	})
end

function AllianceTaskLayer:_updateTaskTimeCountDown()
	self.m_coutdown:resetCooldownTs((g.core.common.ServerTime:getOpenLeftTime(24, 0, 0)))
end

function AllianceTaskLayer:_onClickTabChanged()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_select_switch)
	self:updateTaskView()
end

function AllianceTaskLayer:playListAnimation()
	if self.m_typeController:getSelectedIndex() == 0 then
		self.m_dailyTaskList:transitionShowCells("listCardAUiScaleIn", 0.1, 1)
	else
		self.m_achievementTaskList:transitionShowCells("enter_left", 0.03, 1)
	end
end

return AllianceTaskLayer
