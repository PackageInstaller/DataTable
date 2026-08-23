local var_0_0 = g.core.const.ConstMgr.PubgConst
local PubgTaskCell = class("PubgTaskCell", require("app.fairyGUI.pubg.UI_PubgTaskCell"))

function PubgTaskCell:ctor()
	self._taskInfo = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_getAwardBtn:addClickListener(handler(self, self._onClickGetAwardBtn))
end

function PubgTaskCell:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function PubgTaskCell:updateTaskCell(arg_3_1)
	self._taskInfo = arg_3_1
	self._taskData = g.core.model.User.pubgData:getTaskData()
	self._awards = self._taskData:getTaskAwardByCfg(arg_3_1)

	self.m_awardList:setNumItems(#self._awards)
	self.m_taskNameText:setText(g.core.lang:getByString(arg_3_1.task_describe, {
		num = arg_3_1.goal
	}))
	self.m_curNumTxt:setText((math.min(self._taskData:getTaskValue(arg_3_1.action_key, arg_3_1.action_type), arg_3_1.goal)))
	self.m_targetNumTxt:setText("/" .. arg_3_1.goal)
	self.m_isDailyController:setSelectedIndex(arg_3_1.refresh == var_0_0.TASK_TYPE.DAILY and 1 or 0)

	self._state = self._taskData:getTaskState(arg_3_1.id)

	self:_updateTaskState()
end

function PubgTaskCell:_updateTaskState()
	if self._state == var_0_0.TASK_STATE.REWARD then
		self.m_isGetController:setSelectedIndex(2)
	elseif self._state == var_0_0.TASK_STATE.FINISH then
		self.m_isGetController:setSelectedIndex(1)
	else
		self.m_isGetController:setSelectedIndex(0)
	end
end

function PubgTaskCell:_onClickGetAwardBtn()
	if self._state == var_0_0.TASK_STATE.FINISH then
		g.core.network.GameNetProxy:send_C2S_Pubg_TaskAward({
			task_id = self._taskInfo.id
		})
	end
end

return PubgTaskCell
