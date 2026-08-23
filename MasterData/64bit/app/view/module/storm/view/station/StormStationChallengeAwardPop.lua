local var_0_0 = g.core.const.ConstMgr.TaskConst
local StormStationChallengeAwardPop = class("StormStationChallengeAwardPop", require("app.fairyGUI.storm.UI_StormStationChallengeAwardPop"), function()
	return fgui.GComponent:create({
		resName = "StormStationChallengeAwardPop",
		pkgName = "storm",
		pkgPath = "ui/storm/storm"
	}, ...)
end)

function StormStationChallengeAwardPop:ctor()
	self:showAtCenter()
	self.m_rewardItemList:setVirtual()
	self.m_rewardItemList:setItemRenderer(handler(self, self._onChallengeListRenderer))
	self.m_rewardItemList:doFairyBatching(false)
end

function StormStationChallengeAwardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO, self._onStormCityGetTaskList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onStormCityGetTaskAward, self)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = g.core.const.ConstMgr.TaskConst.MODULE_ID.STORMCITY
	})
end

function StormStationChallengeAwardPop:_onStormCityGetTaskList(arg_4_1, arg_4_2, arg_4_3)
	local var_4_1 = {}
	local var_4_2 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_3.daily_tasks or {}) do
		var_4_1[iter_4_1.type] = iter_4_1.value
		var_4_2 = var_4_2 + iter_4_1.value
	end

	local var_4_3 = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_3.daily_awards or {}) do
		var_4_3[iter_4_3] = true
	end

	local var_4_4 = {}

	for iter_4_4, iter_4_5 in ipairs((g.core.config.action_task_info.match(function(arg_5_0)
		return arg_5_0.module == var_0_0.MODULE_ID.STORMCITY
	end))) do
		if iter_4_5.tab == 1 then
			local var_4_5 = self:_createTaskUnit(iter_4_5)

			table.insert(var_4_4, var_4_5)

			var_4_5.count = var_4_2
			var_4_5.got = var_4_3[iter_4_5.id]
		end
	end

	var_4_4.challengeCount = var_4_2
	self._rankDailyTaskData = var_4_4

	table.sort(var_4_4, function(arg_6_0, arg_6_1)
		if arg_6_0.got ~= arg_6_1.got then
			return arg_6_1.got
		else
			return arg_6_0.info.id < arg_6_1.info.id
		end
	end)
	self.m_rewardItemList:setNumItems(#self._rankDailyTaskData)
end

function StormStationChallengeAwardPop:_onStormCityGetTaskAward(arg_7_1, arg_7_2, arg_7_3)
	self:_updateTask(arg_7_3.task_id)
	self.m_rewardItemList:setNumItems(#self._rankDailyTaskData)
	g.core.module.ModuleManager:awardSummary(arg_7_3.awards)
end

function StormStationChallengeAwardPop:_onChallengeListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCellView(true, self._rankDailyTaskData[arg_8_1 + 1])
end

function StormStationChallengeAwardPop:_updateTask(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self._rankDailyTaskData) do
		if iter_9_1.info.id == arg_9_1 then
			iter_9_1.got = true

			break
		end
	end

	table.sort(self._rankDailyTaskData, function(arg_10_0, arg_10_1)
		if arg_10_0.got ~= arg_10_1.got then
			return arg_10_1.got
		else
			return arg_10_0.info.id < arg_10_1.info.id
		end
	end)
end

function StormStationChallengeAwardPop:_createTaskUnit(arg_11_1)
	return {
		count = 0,
		got = false,
		info = arg_11_1
	}
end

return StormStationChallengeAwardPop
