local var_0_0 = g.core.model.User.outpostData:getTaskData()
local var_0_1 = g.core.const.ConstMgr.outpostConst
local OutpostLimitTimeTaskPop = class("OutpostLimitTimeTaskPop", require("app.fairyGUI.outpost.UI_OutpostLimitTimeTaskPop"), function()
	return fgui.GComponent:create({
		pkgName = "outpost",
		isFullScreen = false,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostLimitTimeTaskPop"
	}, ...)
end)

function OutpostLimitTimeTaskPop:ctor()
	self._tickTimer = nil
	self._taskInfoList = {}
	self._awards = {}

	self:_initPop()
	self:showAtCenter()
end

function OutpostLimitTimeTaskPop:_initPop()
	self.m_awardGetBtn:addClickListener(handler(self, self._sendGetTaskAward))
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_taskList:setVirtual(self)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))

	self._awards = g.core.common.Drops:getGoodsArray(g.core.config.outpost_parameter_info.get(var_0_1.ParameterID.LIMIT_TASK_DROP).parameter)

	if var_0_0:canGetLimitTaskAward() then
		self._canReward = true

		self.m_canGetAwardController:setSelectedIndex(1)
	else
		self.m_canGetAwardController:setSelectedIndex(0)
	end

	self.m_rewardList:setNumItems(#self._awards)
end

function OutpostLimitTimeTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_SYNCTASK, self.updateTaskPop, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_GETTASKAWARD, handler(self, self._onGetTaskAward), self)
	self:updateTaskPop()
end

function OutpostLimitTimeTaskPop:onUnload()
	self._tickTimer = nil
end

function OutpostLimitTimeTaskPop:updateTaskPop()
	if not var_0_0:isTriggerLimit() then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

		return
	end

	self._taskInfoList = {}

	for iter_6_0, iter_6_1 in ipairs((var_0_0:getLimitTaskList())) do
		local var_6_0 = var_0_0:getAction(iter_6_1.id, var_0_1.TASK_TYPE.LIMIT)

		self._taskInfoList[#self._taskInfoList + 1] = {
			cfg = iter_6_1,
			action = var_6_0,
			isLock = var_6_0 == nil
		}
	end

	self.m_taskList:setNumItems(#self._taskInfoList)

	local var_6_1 = var_0_0:getLimitPassEndTime() - g.core.common.ServerTime:getTime()

	if not self._tickTimer and var_6_1 > 0 then
		self._tickTimer = self:newSchedule(handler(self, self._tickTime), 1)

		self:_tickTime()
	elseif var_6_1 <= 0 then
		self.m_timeTickEndController:setSelectedIndex(1)
	end
end

function OutpostLimitTimeTaskPop:_onAwardItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateAwardIcon(self._awards[arg_7_1 + 1], self._canReward)
end

function OutpostLimitTimeTaskPop:_onTaskItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateTaskCell(self._taskInfoList[arg_8_1 + 1])
end

function OutpostLimitTimeTaskPop:_tickTime()
	local var_9_0 = var_0_0:getLimitPassEndTime() - g.core.common.ServerTime:getTime()

	self.m_timeTxt:setText(g.core.common.ServerTime:secondToHMSString(var_9_0))

	if var_9_0 <= 0 then
		self:cancelSchedule(self._tickTimer)

		self._tickTimer = nil

		self.m_timeTickEndController:setSelectedIndex(1)
	else
		self.m_timeTickEndController:setSelectedIndex(0)
	end
end

function OutpostLimitTimeTaskPop:_sendGetTaskAward()
	local var_10_0

	if not var_0_0:canGetLimitTaskAward() then
		do return end

		var_10_0 = {}
	end

	var_10_0.task_id = self._taskInfoList[1].cfg.group
	var_10_0.task_tp = var_0_1.TASK_TYPE.LIMIT

	g.core.network.GameNetProxy:send_C2S_Outpost_GetTaskAward(var_10_0)
end

function OutpostLimitTimeTaskPop:_onGetTaskAward(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	g.core.module.ModuleManager:awardSummary(arg_11_4.awards, false, nil, nil, handler(self, function(arg_12_0)
		g.core.module.ModuleManager:onlyPopSelfByDisplay(arg_12_0)
	end))

	if self._tickTimer then
		self:cancelSchedule(self._tickTimer)
	end

	self.m_timeTickEndController:setSelectedIndex(1)
end

return OutpostLimitTimeTaskPop
