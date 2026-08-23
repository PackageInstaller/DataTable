local var_0_0 = g.core.const.ConstMgr.RetroConst
local var_0_1 = g.core.model.User.retroData
local RetroActivityTaskCell = class("RetroActivityTaskCell", require("app.fairyGUI.retro.UI_RetroActivityTaskCell"))

function RetroActivityTaskCell:ctor()
	self._taskdata = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_goBtn:addClickListener(handler(self, self._onGoBtnClick))
end

function RetroActivityTaskCell:updateTaskCell(arg_2_1)
	self._taskInfo = arg_2_1
	self._taskData = var_0_1:getTaskData()

	local var_2_0 = self._taskData:getTaskValue(arg_2_1.action_key, arg_2_1.action_id)
	local var_2_1 = arg_2_1.action_value

	if arg_2_1.action_value == 0 then
		var_2_0 = 1
		var_2_1 = 1
	elseif var_2_1 <= var_2_0 then
		var_2_0 = var_2_1
	end

	self.m_name:setText(self._taskInfo.task_name)
	self.m_descText:setText(self._taskInfo.task_des)
	self.m_curProgressText:setText(var_2_0)
	self.m_destinNumText:setText(g.core.lang:get(201028, {
		num = var_2_1
	}))

	self._awards = self._taskData:getTaskAwardByCfg(arg_2_1)

	self.m_awardList:setNumItems(#self._awards)

	self._state = self._taskData:getTaskState(arg_2_1.id)

	self.m_drawStateController:setSelectedIndex(self._state)
end

function RetroActivityTaskCell:_onAwardItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

function RetroActivityTaskCell:_onGoBtnClick()
	if self._state == var_0_0.TASK_STATE.NOT_FINISH then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._taskInfo.route_id)
	elseif self._state == var_0_0.TASK_STATE.FINISH then
		g.core.network.GameNetProxy:send_C2S_Retro_TaskAward({
			task_id = self._taskInfo.id
		})
	elseif self._state == var_0_0.TASK_STATE.REWARD then
		g.core.module.ModuleManager:tip(g.core.lang:get(421413))
	end
end

return RetroActivityTaskCell
