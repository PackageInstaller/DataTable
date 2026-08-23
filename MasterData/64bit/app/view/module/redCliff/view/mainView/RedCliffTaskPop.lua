local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.redCliffData
local var_0_3 = g.core.config.chibi_achievement_info
local RedCliffTaskPop = class("RedCliffTaskPop", require("app.fairyGUI.redCliff.UI_RedCliffTaskPop"), function()
	return fgui.GComponent:create({
		resName = "RedCliffTaskPop",
		pkgName = "redCliff",
		pkgPath = "ui/redCliff/redCliff"
	}, ...)
end)

function RedCliffTaskPop:ctor()
	self:showAtCenter()

	self._taskList = {}

	self:_initView()
end

function RedCliffTaskPop:_initView()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))
	self:addListen(self.m_taskList)
end

function RedCliffTaskPop:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_CHI_BI_ACHIEVEMENTAWARD, self._onGetTaskAward, self)
	self:_updateView(true)
end

function RedCliffTaskPop:_onRenderTaskList(arg_5_1, arg_5_2)
	arg_5_2:updateTaskCell(self._taskList[arg_5_1 + 1])
end

function RedCliffTaskPop:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "EVENT_RED_CLIFF_TASK_AWARD_GET" then
		g.core.network.GameNetProxy:send_C2S_ChiBi_AchievementAward({
			award_id = arg_6_2
		})
	end
end

function RedCliffTaskPop:_onGetTaskList(arg_7_1, arg_7_2, arg_7_3)
	self:_updateView()
end

function RedCliffTaskPop:_onGetTaskAward(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
	self:_updateView()
end

function RedCliffTaskPop:_updateView(arg_9_1)
	self._taskList = {}

	for iter_9_0, iter_9_1 in var_0_3.ipairs() do
		table.insert(self._taskList, iter_9_1)
	end

	table.sort(self._taskList, function(arg_10_0, arg_10_1)
		local var_10_0 = var_0_2:isTaskCanGet(arg_10_0.id) and 1 or 0
		local var_10_1 = var_0_2:isTaskCanGet(arg_10_1.id) and 1 or 0

		if var_10_0 ~= var_10_1 then
			return var_10_1 < var_10_0
		end

		local var_10_2 = var_0_2:isGotTaskById(nil, arg_10_0) and 1 or 0
		local var_10_3 = var_0_2:isGotTaskById(nil, arg_10_1) and 1 or 0

		if var_10_2 ~= var_10_3 then
			return var_10_2 < var_10_3
		end

		return arg_10_0.order < arg_10_1.order
	end)
	self.m_taskList:setNumItems(#self._taskList)

	if arg_9_1 then
		self.m_taskList:transitionShowCells("enter_down", 0.03)
	end
end

return RedCliffTaskPop
