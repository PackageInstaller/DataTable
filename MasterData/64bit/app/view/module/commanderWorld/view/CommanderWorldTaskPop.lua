local var_0_0 = g.core.model.User.commanderWorldData
local var_0_1 = g.core.const.ConstMgr.CommanderWorldConst
local CommanderWorldTaskPop = class("CommanderWorldTaskPop", require("app.fairyGUI.commanderWorld.UI_CommanderWorldTaskPop"), function()
	return fgui.GComponent:create({
		resName = "CommanderWorldTaskPop",
		pkgPath = "ui/commanderWorld/commanderWorld",
		pkgName = "commanderWorld"
	}, ...)
end)

function CommanderWorldTaskPop:ctor()
	self:showAtCenter()

	self._taskData = {}

	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
end

function CommanderWorldTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO, self._onRcvCommanderWorldInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_TASKAWARD, self._onRcvTaskReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, self._onRcvTaskChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_INFO, self._onRcvTaskChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	self:_updateTaskList()
end

function CommanderWorldTaskPop:_onTaskItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateTaskCell(self._taskData[arg_4_1 + 1])
end

function CommanderWorldTaskPop:_updateTaskList()
	self._taskData = table.values((var_0_0:getTasks()))

	table.sort(self._taskData, function(arg_6_0, arg_6_1)
		if arg_6_0.hasReward ~= arg_6_1.hasReward then
			return arg_6_0.hasReward
		end

		if arg_6_0.isFinish ~= arg_6_1.isFinish then
			return not arg_6_0.isFinish
		end

		return arg_6_0.order < arg_6_1.order
	end)
	self.m_taskList:setNumItems(#self._taskData)
end

function CommanderWorldTaskPop:_onRcvTaskReward(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3.awards then
		g.core.module.ModuleManager:awardSummary(arg_7_3.awards)
		self:_updateTaskList()
	end
end

function CommanderWorldTaskPop:_onRcvTaskChange(arg_8_1, arg_8_2, arg_8_3)
	self:_updateTaskList()
end

function CommanderWorldTaskPop:_onRcvCommanderWorldInfo()
	if var_0_0:getActivityStageAndRemainTime() == var_0_1.STAGE.REWARDDAY then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		self:_updateTaskList()
	end
end

function CommanderWorldTaskPop:_onCrossDayUpdate()
	g.core.network.GameNetProxy:send_C2S_OrderWorld_Info({})
end

return CommanderWorldTaskPop
