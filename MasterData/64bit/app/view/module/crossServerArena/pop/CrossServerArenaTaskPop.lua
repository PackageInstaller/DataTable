local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.const.ConstMgr
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local CrossServerArenaTaskPop = class("CrossServerArenaTaskPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaTaskPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaTaskPop",
		pkgName = "crossServerArena",
		pkgPath = "ui/crossServerArena/crossServerArena"
	}, ...)
end)

function CrossServerArenaTaskPop:ctor(arg_2_1)
	self._dailyTaskData = nil

	self:showAtCenter()
	self:_initView()
end

function CrossServerArenaTaskPop:_initView()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))
	self:addListen(self.m_taskList)
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyClick))
	self.m_oneKeyBtn:setVisible(false)
end

function CrossServerArenaTaskPop:onLoad()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GET_MODULE_TASK_INFO, self._onArenaGetTaskList, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onArenaGetTaskAward, self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD, self._onOneKeyGetTaskAward, self)
	self:_updateView(true)
end

function CrossServerArenaTaskPop:_onRenderTaskList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._dailyTaskData[arg_5_1 + 1])
end

function CrossServerArenaTaskPop:_onOneKeyClick()
	if not var_0_0:isExistTaskAward() then
		g.core.module.ModuleManager:tip(g.core.lang:get(302504))

		return
	end

	g.core.network.GameNetProxy:send_C2S_GetModuleOneKeyTaskAward({
		module_id = var_0_1.TaskConst.MODULE_ID.CROSS_SERVER_ARENA
	})
end

function CrossServerArenaTaskPop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "EVENT_ARENA_AWARD_GET" then
		g.core.network.GameNetProxy:send_C2S_GetModuleTaskAward({
			task_id = arg_7_2
		})
	end
end

function CrossServerArenaTaskPop:_onArenaGetTaskList(arg_8_1, arg_8_2, arg_8_3)
	self:_updateView()
end

function CrossServerArenaTaskPop:_onArenaGetTaskAward(arg_9_1, arg_9_2, arg_9_3)
	g.core.module.ModuleManager:awardSummary(arg_9_3.awards)
	self:_updateView()
end

function CrossServerArenaTaskPop:_onOneKeyGetTaskAward(arg_10_1, arg_10_2, arg_10_3)
	g.core.module.ModuleManager:awardSummary(arg_10_3.awards)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = var_0_1.TaskConst.MODULE_ID.CROSS_SERVER_ARENA
	})
end

function CrossServerArenaTaskPop:getOneKeyTaskAward()
	self:_onOneKeyClick()
end

function CrossServerArenaTaskPop:_updateView(arg_12_1)
	self._dailyTaskData = var_0_0:getDailyTaskList()

	self.m_taskList:setNumItems(#self._dailyTaskData)

	local var_12_0

	if arg_12_1 then
		self.m_taskList:transitionShowCells("enter_down", 0.03)

		if self._dailyTaskData[1] then
			var_12_0 = self._dailyTaskData[1].count or 0
		end
	end

	self.m_challengeNumText:setText(var_12_0)
	self:updateOneKeyBtn()
end

function CrossServerArenaTaskPop:updateOneKeyBtn()
	self.m_oneKeyBtn:setVisible(checkbool((g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.FUNCTION_TYPE.CROSS_SERVER_ARENA_ONE_KEY))) and var_0_0:isExistTaskAward())
end

return CrossServerArenaTaskPop
