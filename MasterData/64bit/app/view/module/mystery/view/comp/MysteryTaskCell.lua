local var_0_0 = g.core.const.ConstMgr.MysteryConst
local var_0_1 = g.core.model.User.mysteryData
local MysteryTaskCell = class("MysteryTaskCell", require("app.fairyGUI.mystery.UI_MysteryTaskCell"))

function MysteryTaskCell:ctor()
	self:addClickListener(handler(self, self._onClick))
	self.m_locationBtn:addClickListener(handler(self, self._onClickLocationBtn))
end

function MysteryTaskCell:updateCell(arg_2_1, arg_2_2)
	if arg_2_2 == var_0_0.TASK_TYPE.MAIN then
		self.m_taskTypeController:setSelectedIndex(0)
	elseif arg_2_2 == var_0_0.TASK_TYPE.DAILY then
		self.m_taskTypeController:setSelectedIndex(1)
	else
		self.m_taskTypeController:setSelectedIndex(2)
	end

	self._taskType = arg_2_2
	self._taskArray = arg_2_1
	self._dailyTaskId = var_0_1:getDailyTaskId()
	self._curChapterId = var_0_1:getCurChapterId()

	if self._taskType == var_0_0.TASK_TYPE.DAILY then
		self.m_taskTitleTxt:setText(g.core.lang:get(423016))

		if var_0_1:isDaliyTaskDone() then
			self.m_taskDescTxt:setText(g.core.lang:get(423014))
		elseif self._dailyTaskId == 0 then
			self.m_taskDescTxt:setText(g.core.lang:get(423017))
		else
			self:updateTaskInfo()
		end

		self.m_redPointComp:setId(800)
	else
		self:updateTaskInfo()
		self.m_redPointComp:setId(801)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			taskType = self._taskType,
			chapterId = self._curChapterId
		}
	})
end

function MysteryTaskCell:updateTaskInfo()
	local var_3_0 = self:getFristShowTaskInfo()

	if var_3_0 then
		local var_3_1 = var_0_1:getTaskProgById(var_3_0.id)
		local var_3_2 = g.core.lang:get(423002, {
			cur = (var_3_1 or nil) and (var_3_1.progress or 0),
			max = var_3_0.task_size
		})

		self.m_taskTitleTxt:setText(var_3_0.task_title)
		self.m_taskDescTxt:setText(var_3_0.task_desc .. var_3_2)

		if var_3_0.task_type == var_0_0.TASK_TYPE.BOSS and var_0_1:getTaskStateById(var_3_0.id) == var_0_0.TASK_STATE.DONE then
			self.m_taskDescTxt:setText(g.core.lang:get(423028))
		end
	end
end

function MysteryTaskCell:getFristShowTaskInfo()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self._taskArray) do
		local var_4_2 = var_0_1:getTaskProgById(iter_4_1.id)

		if var_4_2 == nil or var_4_2.progress < iter_4_1.task_size then
			var_4_0 = iter_4_1

			break
		end

		var_4_0 = iter_4_1
	end

	return (self._taskType == var_0_0.TASK_TYPE.DAILY and self._dailyTaskId > 0 or nil) and g.core.config.mystery_task_info.get(self._dailyTaskId)
end

function MysteryTaskCell:_onClick()
	if self._taskType == var_0_0.TASK_TYPE.MAIN then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.mystery.view.infoPop.MysteryMonsterTaskPop").new(), {
			withoutAni = true
		})
	elseif self._taskType == var_0_0.TASK_TYPE.DAILY then
		if var_0_1:isDaliyTaskDone() then
			g.core.module.ModuleManager:tip(g.core.lang:get(423014))
		elseif self._dailyTaskId == 0 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(1257),
				desc = g.core.lang:get(423015, {
					name = var_0_1:getChapterDataById((var_0_1:getCurChapterId())):getTaskNpcCfg().stage_name
				}),
				onConfirm = handler(self, self._gotoNpcGetTask)
			}))
		else
			g.core.module.ModuleManager:pushPopup(require("app.view.module.mystery.view.infoPop.MysteryOtherTaskPop").new(), {
				withoutAni = true
			})
		end
	else
		self:dispatchCompEvent("MYSTERY_OTHER_OPE_COMP_OUT_SCREEN")
		g.core.module.ModuleManager:pushPopup(require("app.view.module.mystery.view.mysteryBoss.MysteryBossGoToDalilyTaskPop").new(self._taskArray), {
			withoutAni = true
		})
	end
end

function MysteryTaskCell:_onClickLocationBtn()
	if self._taskType == var_0_0.TASK_TYPE.DAILY then
		if var_0_1:isDaliyTaskDone() then
			g.core.module.ModuleManager:tip(g.core.lang:get(423014))

			return
		elseif self._dailyTaskId == 0 then
			self:_gotoNpcGetTask()

			return
		end
	elseif self._taskType == var_0_0.TASK_TYPE.BOSS then
		self:dispatchCompEvent("MYSTERY_OTHER_OPE_COMP_OUT_SCREEN")
		g.core.module.ModuleManager:pushPopup(require("app.view.module.mystery.view.mysteryBoss.MysteryBossGoToDalilyTaskPop").new(self._taskArray), {
			withoutAni = true
		})

		return
	end

	local var_6_0 = self:getFristShowTaskInfo()

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs((var_0_1:getChapterDataById(var_6_0.chapter_id):getMonsterListByGroup(var_6_0.target_value))) do
			if var_0_1:getStageDataById(iter_6_1.id):isMonsterExist() then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_GOTO_TERMINUS, true, {
					iter_6_1.number,
					var_6_0.chapter_id
				})

				break
			end
		end
	end
end

function MysteryTaskCell:_gotoNpcGetTask()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_GOTO_TERMINUS, true, {
		var_0_1:getChapterDataById((var_0_1:getCurChapterId())):getTaskNpcCfg().number
	})
end

return MysteryTaskCell
