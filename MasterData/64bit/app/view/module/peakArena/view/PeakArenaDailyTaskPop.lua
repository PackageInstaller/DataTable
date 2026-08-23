local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.peakArenaData
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.network.GameNetProxy
local PeakArenaDailyTaskPop = class("PeakArenaDailyTaskPop", require("app.fairyGUI.peakArena.UI_PeakArenaDailyTaskPop"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaDailyTaskPop",
		pkgName = "peakArena",
		pkgPath = "ui/peakArena/peakArena"
	}, ...)
end)

function PeakArenaDailyTaskPop:ctor()
	self._playEnterAni = true
	self._taskCfgArr = var_0_2:getTaskCfgArr()

	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskListRenderer))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyClick))
	self.m_oneKeyBtn:setVisible(false)
	self:showAtCenter()
end

function PeakArenaDailyTaskPop:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_MODULE_TASK_INFO, self._onGetTaskInfo, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_MODULE_TASK_AWARD, self._onGetTaskAward, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD, self._onGetOneKeyTaskAward, self)
	self:_updateView()
end

function PeakArenaDailyTaskPop:_onTaskListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._taskCfgArr[arg_4_1 + 1])
end

function PeakArenaDailyTaskPop:_onOneKeyClick()
	if var_0_2:isExistDailyTaskAward() then
		var_0_5:send_C2S_GetModuleOneKeyTaskAward({
			module_id = var_0_3.TaskConst.MODULE_ID.PEAK_ARENA
		})
	else
		var_0_4:tip(g.core.lang:get(302504))
	end
end

function PeakArenaDailyTaskPop:_onGetTaskInfo(arg_6_1, arg_6_2, arg_6_3)
	self:_updateView()
end

function PeakArenaDailyTaskPop:_onGetTaskAward(arg_7_1, arg_7_2, arg_7_3)
	var_0_4:awardSummary(arg_7_3.awards)
	self:_updateView()
end

function PeakArenaDailyTaskPop:_onGetOneKeyTaskAward(arg_8_1, arg_8_2, arg_8_3)
	var_0_4:awardSummary(arg_8_3.awards)
	var_0_5:send_C2S_GetModuleTaskInfo({
		module_id = var_0_3.TaskConst.MODULE_ID.PEAK_ARENA
	})
end

function PeakArenaDailyTaskPop:_updateView()
	self.m_taskList:setNumItems(#self._taskCfgArr)

	if self._playEnterAni then
		self._playEnterAni = false

		self.m_taskList:transitionShowCells("enter_down", 0.03)
	end

	self.m_oneKeyBtn:setVisible(var_0_2:isExistDailyTaskAward())
end

return PeakArenaDailyTaskPop
