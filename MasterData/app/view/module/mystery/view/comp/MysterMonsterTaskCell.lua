local var_0_0 = g.core.model.User.mysteryData
local var_0_1 = g.core.const.ConstMgr.MysteryConst
local MysterMonsterTaskCell = class("MysterMonsterTaskCell", require("app.fairyGUI.mystery.UI_MysterMonsterTaskCell"))

function MysterMonsterTaskCell:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardItemRender))
	self.m_goBtn:addClickListener(handler(self, self._onClickGoBtn))
	self.m_getBtn:addClickListener(handler(self, self._onClickGetBtn))
end

function MysterMonsterTaskCell:_onRewardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self.awards[arg_2_1 + 1])
end

function MysterMonsterTaskCell:updateCell(arg_3_1, arg_3_2, arg_3_3)
	self._taskInfo = arg_3_1
	self._curTaskId = arg_3_2

	self.m_title:setText(arg_3_1.task_title)
	self.m_title:setText(g.core.lang:get(423022, {
		num = g.core.utils.Number.toChineseNumber(arg_3_3)
	}))
	self.m_descTxt:setText(arg_3_1.task_desc)

	local var_3_0 = var_0_0:getTaskProgById(arg_3_1.id)

	self.m_progressTxt:setText((g.core.lang:get(423002, {
		cur = (var_3_0 or nil) and (var_3_0.progress or 0),
		max = arg_3_1.task_size
	})))

	self.awards = self:_getTaskAwards()

	self.m_rewardList:setNumItems(#self.awards)
	self:_updateTaskState()
end

function MysterMonsterTaskCell:_updateTaskState()
	if var_0_0:getLastUnlockChapterId() < self._taskInfo.chapter_id then
		self.m_taskStateController:setSelectedIndex(0)

		return
	end

	self._taskState = var_0_0:getTaskStateById(self._taskInfo.id)

	if self._taskState == var_0_1.TASK_STATE.UNDONE then
		if self._taskInfo.id <= self._curTaskId then
			self.m_taskStateController:setSelectedIndex(1)
		else
			self.m_taskStateController:setSelectedIndex(0)
		end
	end

	if self._taskState == var_0_1.TASK_STATE.CAN_AWARD then
		self.m_taskStateController:setSelectedIndex(2)
	elseif self._taskState == var_0_1.TASK_STATE.DONE then
		self.m_taskStateController:setSelectedIndex(3)
	end
end

function MysterMonsterTaskCell:_getTaskAwards()
	local var_5_0 = {}

	for iter_5_0 = 1, 4 do
		if self._taskInfo["reward_type_" .. iter_5_0] > 0 then
			table.insert(var_5_0, {
				type = self._taskInfo["reward_type_" .. iter_5_0],
				value = self._taskInfo["reward_value_" .. iter_5_0],
				size = self._taskInfo["reward_size_" .. iter_5_0]
			})
		end
	end

	return var_5_0
end

function MysterMonsterTaskCell:_onClickGetBtn()
	if self._taskState == var_0_1.TASK_STATE.CAN_AWARD then
		g.core.network.GameNetProxy:send_C2S_Mystery_Award({
			task_id = self._taskInfo.id
		})
	end
end

function MysterMonsterTaskCell:_onClickGoBtn()
	for iter_7_0, iter_7_1 in ipairs((var_0_0:getChapterDataById(self._taskInfo.chapter_id):getMonsterListByGroup(self._taskInfo.target_value))) do
		if var_0_0:getStageDataById(iter_7_1.id):isMonsterExist() then
			self:dispatchCompEvent("CELL_CLICK_GO", iter_7_1.number, self._taskInfo.chapter_id)

			break
		end
	end
end

return MysterMonsterTaskCell
