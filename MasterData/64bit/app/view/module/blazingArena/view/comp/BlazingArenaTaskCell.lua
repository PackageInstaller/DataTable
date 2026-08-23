local var_0_0 = g.core.const.ConstMgr.BlazingArenaConst
local var_0_1 = g.core.model.User.blazingArenaData
local BlazingArenaTaskCell = class("BlazingArenaTaskCell", require("app.fairyGUI.blazingArena.UI_BlazingArenaTaskCell"))

function BlazingArenaTaskCell:ctor()
	self._taskInfo = nil
	self._awardList = {}

	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
	self.m_taskNumText:enableRich()
	self:_initBtn()
	self:_initListView()
end

function BlazingArenaTaskCell:_initBtn()
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetAwardBtnClick))
end

function BlazingArenaTaskCell:_initListView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function BlazingArenaTaskCell:_onRenderAwardList(arg_4_1, arg_4_2)
	self._awardList[arg_4_1 + 1].scaleIndex = 2
	self._awardList[arg_4_1 + 1].hideNum = false

	arg_4_2:updateIcon(self._awardList[arg_4_1 + 1])
end

function BlazingArenaTaskCell:updateCell(arg_5_1)
	if not arg_5_1 then
		return
	end

	self._taskInfo = arg_5_1
	self._taskData = var_0_1:getTaskData()
	self._awardList = self._taskData:getTaskAwardByCfg(arg_5_1)

	self.m_awardList:setNumItems(#self._awardList)
	self.m_taskNameText:setText(g.core.lang:getByString(arg_5_1.description, {
		num = arg_5_1.goal
	}))
	self.m_taskNumText:setText(g.core.lang:get(302515, {
		curNum = math.min(self._taskData:getTaskValue(arg_5_1.action_key, arg_5_1.action_type), arg_5_1.goal),
		targetNum = arg_5_1.goal
	}))
	self.m_isDailyController:setSelectedIndex(arg_5_1.reset == var_0_0.TASK_TYPE.DAILY and 1 or 0)

	self._state = self._taskData:getTaskState(arg_5_1.id)

	self:_updateTaskState()
end

function BlazingArenaTaskCell:_updateTaskState()
	if self._state == var_0_0.TASK_STATE.REWARD then
		self.m_isGetController:setSelectedIndex(2)
	elseif self._state == var_0_0.TASK_STATE.FINISH then
		self.m_isGetController:setSelectedIndex(1)
	else
		self.m_isGetController:setSelectedIndex(0)
	end
end

function BlazingArenaTaskCell:_onGetAwardBtnClick()
	if not self._taskInfo then
		return
	end

	self:dispatchCompEvent("EVENT_BLAZING_ARENA_AWARD_GET", self._taskInfo.id)
end

return BlazingArenaTaskCell
