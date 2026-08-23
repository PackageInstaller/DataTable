local var_0_0 = g.core.const.ConstMgr.TeamPvpConst
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.teamPvpData
local var_0_4 = g.core.config.group_battle_task_info
local var_0_5 = g.core.const.ConstMgr.ShopConst
local TeamPVPTaskPop = class("TeamPVPTaskPop", require("app.fairyGUI.teamPVP.UI_TeamPVPTaskPop"), function()
	return fgui.GComponent:create({
		pkgName = "teamPVP",
		resName = "TeamPVPTaskPop",
		pkgPath = "ui/teamPVP/teamPVP"
	}, ...)
end)

function TeamPVPTaskPop:ctor(arg_2_1)
	self:showAtCenter()

	self._taskList = {}

	self:_initView()
end

function TeamPVPTaskPop:_initView()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))
	self:addListen(self.m_taskList)
end

function TeamPVPTaskPop:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_GROUP_BATTLE_TASKAWARD, self._onGetTaskAward, self)
	self:_updateView(true)
end

function TeamPVPTaskPop:_onRenderTaskList(arg_5_1, arg_5_2)
	arg_5_2:updateTaskCell(self._taskList[arg_5_1 + 1])
end

function TeamPVPTaskPop:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "EVENT_TEAM_PVP_AWARD_GET" then
		g.core.network.GameNetProxy:send_C2S_GroupBattle_TaskAward({
			task_id = arg_6_2
		})
	end
end

function TeamPVPTaskPop:_onGetTaskList(arg_7_1, arg_7_2, arg_7_3)
	self:_updateView()
end

function TeamPVPTaskPop:_onGetTaskAward(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
	self:_updateView()
end

function TeamPVPTaskPop:_onOneKeyGetTaskAward(arg_9_1, arg_9_2, arg_9_3)
	g.core.module.ModuleManager:awardSummary(arg_9_3.awards)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = g.core.const.ConstMgr.TaskConst.MODULE_ID.TEAM_PVP
	})
end

function TeamPVPTaskPop:getOneKeyTaskAward()
	self:_onOneKeyClick()
end

function TeamPVPTaskPop:_updateView(arg_11_1)
	self._taskList = {}

	for iter_11_0, iter_11_1 in var_0_4.ipairs() do
		table.insert(self._taskList, iter_11_1)
	end

	table.sort(self._taskList, function(arg_12_0, arg_12_1)
		local var_12_0 = var_0_3:isTaskCanGet(arg_12_0.id) and 1 or 0
		local var_12_1 = var_0_3:isTaskCanGet(arg_12_1.id) and 1 or 0

		if var_12_0 ~= var_12_1 then
			return var_12_1 < var_12_0
		end

		local var_12_2 = var_0_3:isGotTaskById(nil, arg_12_0) and 1 or 0
		local var_12_3 = var_0_3:isGotTaskById(nil, arg_12_1) and 1 or 0

		if var_12_2 ~= var_12_3 then
			return var_12_2 < var_12_3
		end

		return arg_12_0.id < arg_12_1.id
	end)
	self.m_taskList:setNumItems(#self._taskList)

	if arg_11_1 then
		self.m_taskList:transitionShowCells("enter_down", 0.03)
	end

	self.m_todayChallengeText:setText(var_0_3:getTaskProgress(var_0_0.TASK_SHOW_TYPE.ALL_CHALLENGE_COUNT, var_0_5.NUM_BAN_TYPE.DAY))
	self.m_allWinText:setText(var_0_3:getTaskProgress(var_0_0.TASK_SHOW_TYPE.ALL_WIN_COUNT, var_0_5.NUM_BAN_TYPE.TEAM_PVP))
	self.m_activeChallengeText:setText(var_0_3:getTaskProgress(var_0_0.TASK_SHOW_TYPE.ALL_CHALLENGE_COUNT, var_0_5.NUM_BAN_TYPE.TEAM_PVP))
end

return TeamPVPTaskPop
