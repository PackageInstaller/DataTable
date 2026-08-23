local var_0_0 = g.core.model.User.blazingArenaData
local BlazingArenaTaskPop = class("BlazingArenaTaskPop", require("app.fairyGUI.blazingArena.UI_BlazingArenaTaskPop"), function()
	return fgui.GComponent:create({
		resName = "BlazingArenaTaskPop",
		pkgName = "blazingArena"
	}, ...)
end)

function BlazingArenaTaskPop:ctor(arg_2_1)
	self:showAtCenter()

	self._taskList = {}

	self:_initBtn()
	self:_initListView()
	self:_updateView(true)
end

function BlazingArenaTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_BLAZING_ARENA_TASKAWARD, self._onBlazingArenaGetTaskAward, self)
end

function BlazingArenaTaskPop:_initBtn()
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyBtnClick))
end

function BlazingArenaTaskPop:_initListView()
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onRenderTaskList))
	self:addListen(self.m_taskList)
end

function BlazingArenaTaskPop:_onRenderTaskList(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._taskList[arg_6_1 + 1])
end

function BlazingArenaTaskPop:_updateView(arg_7_1)
	self._taskList = var_0_0:getTaskData():getTaskList()

	self.m_taskList:setNumItems(#self._taskList)

	if arg_7_1 then
		self.m_taskList:transitionShowCells("enter_down", 0.03)
	end

	self.m_challengeNumText:setText(var_0_0:getTodayChallengeNum())
end

function BlazingArenaTaskPop:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "EVENT_BLAZING_ARENA_AWARD_GET" then
		g.core.network.GameNetProxy:send_C2S_BlazingArena_TaskAward({
			task_ids = {
				arg_8_2
			}
		})
	end
end

function BlazingArenaTaskPop:_onBlazingArenaGetTaskAward(arg_9_1, arg_9_2, arg_9_3)
	g.core.module.ModuleManager:awardSummary(arg_9_3.awards)
	self:_updateView()
end

function BlazingArenaTaskPop:_onOneKeyBtnClick()
	local var_10_0 = var_0_0:getTaskData():getCanRewardTaskList()

	if #var_10_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(431408))
	else
		g.core.network.GameNetProxy:send_C2S_BlazingArena_TaskAward({
			task_ids = var_10_0
		})
	end
end

return BlazingArenaTaskPop
