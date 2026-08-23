local var_0_0 = g.core.model.User.retroData
local var_0_1 = g.core.const.ConstMgr.RetroConst
local RetroStageAwardCell = class("RetroStageAwardCell", require("app.fairyGUI.retro.UI_RetroStageAwardCell"))

function RetroStageAwardCell:ctor()
	self.m_icon:addClickListener(handler(self, self._onClick))
end

function RetroStageAwardCell:updateCell(arg_2_1, arg_2_2)
	self.m_isFirstController:setSelectedIndex(arg_2_2 == 1 and 1 or 0)

	self._taskId = arg_2_1.id
	self._taskData = var_0_0:getTaskData()

	local var_2_0 = self._taskData:getTaskAwardByCfg(arg_2_1)
	local var_2_1 = g.core.common.Goods:convert(var_2_0[1])

	if var_2_1 then
		self._awards = var_2_1

		self.m_icon:setIcon(self._awards.icon_mini)
		self.m_num:setText(var_2_0[1].size)
		self.m_score:setText(arg_2_1.action_value)
	end

	self._state = var_0_0:getTaskData():getTaskState(self._taskId)

	self.m_isReachController:setSelectedIndex(self._taskData:getCurStageProgress() >= arg_2_1.action_value and 1 or 0)
	self.m_isAwardController:setSelectedIndex(self._state == var_0_1.TASK_STATE.REWARD and 1 or 0)
	self.m_isBigController:setSelectedIndex(arg_2_1.reward_mark == 1 and 1 or 0)
	self.m_effIcon:removeAllEffect()
	self.m_effArrow:removeAllEffect()

	if self._state == var_0_1.TASK_STATE.FINISH then
		self.m_effIcon:addEffectSpine({
			isLoop = true,
			name = "eff_ui_retro_reward"
		})
		self.m_effArrow:addEffectSpine({
			isLoop = true,
			name = "eff_ui_retro_arrow"
		})
	end
end

function RetroStageAwardCell:_onClick()
	if self._state == var_0_1.TASK_STATE.FINISH then
		g.core.network.GameNetProxy:send_C2S_Retro_TaskAward({
			task_id = self._taskId
		})
	elseif self._awards then
		g.core.common.GlobalFunc.pushInfoPop(self._awards)
	end
end

return RetroStageAwardCell
