local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local AllianceAchievementTaskCell = class("AllianceAchievementTaskCell", require("app.fairyGUI.alliance.UI_AllianceAchievementTaskCell"))

function AllianceAchievementTaskCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self:addClickListener(handler(self, self._onClickGetAwardBtn))
	self.m_gotoBtn:addClickListener(handler(self, self._onClickGoBtn))
end

function AllianceAchievementTaskCell:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function AllianceAchievementTaskCell:updateAchievementTaskCell(arg_3_1)
	self._taskInfo = arg_3_1
	self._taskData = var_0_0:getTaskData()
	self._awards = self._taskData:getTaskAwardByCfg(arg_3_1)

	self.m_awardList:setNumItems(#self._awards)
	self.m_descTxt:setText(arg_3_1.des)
	self.m_taskNameTxt:setText(arg_3_1.name)

	local var_3_0 = self._taskData:getTaskValue(arg_3_1.action_key, arg_3_1.action_id)

	if arg_3_1.action_value <= var_3_0 then
		var_3_0 = arg_3_1.action_value
	end

	self.m_curTxt:setText(var_3_0)
	self.m_goalTxt:setText("/" .. arg_3_1.action_value)

	self._state = self._taskData:getTaskState(arg_3_1.id)

	self:_updateTaskState()
end

function AllianceAchievementTaskCell:_updateTaskState()
	if self._state == var_0_1.TASK_STATE.REWARD then
		self.m_stateController:setSelectedIndex(2)
	elseif self._state == var_0_1.TASK_STATE.FINISH then
		self.m_stateController:setSelectedIndex(1)
	elseif self._taskInfo.route_id == 0 then
		self.m_stateController:setSelectedIndex(3)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function AllianceAchievementTaskCell:_onClickGoBtn()
	if self._taskInfo.route_id == 80 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_SEND_BOX)

		return
	elseif self._taskInfo.route_id == 81 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_OPEN_BOX)

		return
	end

	if self._state == var_0_1.TASK_STATE.FINISH then
		-- block empty
	elseif self._state == var_0_1.TASK_STATE.NOT_FINISH then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._taskInfo.route_id)
	end
end

function AllianceAchievementTaskCell:_onClickGetAwardBtn()
	if self._state == var_0_1.TASK_STATE.FINISH then
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_TaskAward({
			id = self._taskInfo.id
		})
	end
end

return AllianceAchievementTaskCell
