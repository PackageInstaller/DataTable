local var_0_0 = g.core.model.User.arenaData
local var_0_1 = g.core.const.ConstMgr
local ArenaTaskPop = class("ArenaTaskPop", require("app.fairyGUI.arena.UI_ArenaTaskPop"), function()
	return fgui.GComponent:create({
		pkgName = "arena",
		resName = "ArenaTaskPop"
	})
end)

function ArenaTaskPop:ctor(arg_2_1)
	self._dailyTaskData = nil

	self:showAtCenter()
	self:_initView()
end

function ArenaTaskPop:_initView()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))
	self:addListen(self.m_taskList)
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyClick))
	self.m_oneKeyBtn:setVisible(false)
end

function ArenaTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_INFO, self._onArenaGetTaskList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onArenaGetTaskAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD, self._onOneKeyGetTaskAward, self)
	self:_updateView(true)
end

function ArenaTaskPop:_onRenderTaskList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._dailyTaskData[arg_5_1 + 1])
end

function ArenaTaskPop:_onOneKeyClick()
	if not var_0_0:isExistTaskAward() then
		g.core.module.ModuleManager:tip(g.core.lang:get(302504))

		return
	end

	g.core.network.GameNetProxy:send_C2S_GetModuleOneKeyTaskAward({
		module_id = var_0_1.TaskConst.MODULE_ID.ARENA
	})
end

function ArenaTaskPop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "EVENT_ARENA_AWARD_GET" then
		g.core.network.GameNetProxy:send_C2S_GetModuleTaskAward({
			task_id = arg_7_2
		})
	end
end

function ArenaTaskPop:_onArenaGetTaskList(arg_8_1, arg_8_2, arg_8_3)
	self:_updateView()
end

function ArenaTaskPop:_onArenaGetTaskAward(arg_9_1, arg_9_2, arg_9_3)
	g.core.module.ModuleManager:awardSummary(arg_9_3.awards)
	self:_updateView()
end

function ArenaTaskPop:_onOneKeyGetTaskAward(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:awardSummary(arg_10_3.awards)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = var_0_1.TaskConst.MODULE_ID.ARENA
	})
end

function ArenaTaskPop:getOneKeyTaskAward()
	self:_onOneKeyClick()
end

function ArenaTaskPop:_updateView(arg_12_1)
	self._dailyTaskData = var_0_0:getDailyTaskList()

	self.m_taskList:setNumItems(#self._dailyTaskData)

	if arg_12_1 then
		self.m_taskList:transitionShowCells("enter_down", 0.03)
	end

	self.m_challengeNumText:setText(var_0_0:getDailyChallengeCount())
	self:updateOneKeyBtn()
end

function ArenaTaskPop:updateOneKeyBtn()
	self.m_oneKeyBtn:setVisible(checkbool((g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.FUNCTION_TYPE.ARENA_ONEKEY_GET))) and var_0_0:isExistTaskAward())
end

return ArenaTaskPop
