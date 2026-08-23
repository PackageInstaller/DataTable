local var_0_0 = g.core.model.User.mysteryData
local var_0_1 = g.core.const.ConstMgr.MysteryConst
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.config.mystery_task_info
local MysteryTaskComp = class("MysteryTaskComp", require("app.fairyGUI.mystery.UI_MysteryTaskComp"))

function MysteryTaskComp:ctor()
	self.m_taskList:setIniter()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskListItemRender))
end

function MysteryTaskComp:_onTaskListItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateCell(self._taskTypeMap[arg_2_1 + 1], arg_2_1 + 1)
end

function MysteryTaskComp:onLoad()
	self:updateMainTaskComp()
end

function MysteryTaskComp:updateMainTaskComp()
	self._taskTypeMap = var_0_0:getChapterDataById((var_0_0:getCurChapterId())):getChapterTasks()

	self:checkIsAddBossTask()

	local var_4_0 = table.nums(self._taskTypeMap)

	self.m_taskList:setNumItems(var_4_0)
	self.m_taskList:resizeToFit(var_4_0)
end

function MysteryTaskComp:checkIsAddBossTask()
	local var_5_0 = var_0_4.match(function(arg_6_0)
		return arg_6_0.task_type == var_0_1.TASK_TYPE.BOSS
	end)

	if var_5_0 and next(var_5_0) and var_0_3:isModuleUnlock(var_0_2.MYSTERY_BOSS) then
		self._taskTypeMap[var_0_1.TASK_TYPE.BOSS] = var_5_0
	end
end

return MysteryTaskComp
