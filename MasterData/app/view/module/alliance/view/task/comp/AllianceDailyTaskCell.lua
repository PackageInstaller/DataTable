local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local AllianceDailyTaskCell = class("AllianceDailyTaskCell", require("app.fairyGUI.alliance.UI_AllianceDailyTaskCell"))

function AllianceDailyTaskCell:ctor()
	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)

	self._taskInfo = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
	self.m_gotoBtn:addClickListener(handler(self, self._onClickGoBtn))
end

function AllianceDailyTaskCell:_onAwardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function AllianceDailyTaskCell:updateDailyTaskCell(arg_3_1)
	self._taskInfo = arg_3_1
	self._taskData = var_0_0:getTaskData()
	self._awards = self._taskData:getTaskAwardByCfg(arg_3_1)

	self.m_awardList:setNumItems(#self._awards)
	self.m_taskNameTxt:setText(arg_3_1.name)
	self.m_descTips:setTitle(arg_3_1.des)

	if arg_3_1.id ~= 201 then
		local var_3_0 = self._taskData:getTaskValue(arg_3_1.action_key, arg_3_1.action_id)

		if arg_3_1.action_value <= var_3_0 then
			var_3_0 = arg_3_1.action_value
		end

		self.m_progressTxt:setText(var_3_0 .. "/" .. arg_3_1.action_value)
	else
		self.m_progressTxt:setText("1/1")
	end

	self._state = self._taskData:getTaskState(arg_3_1.id)

	self:_updateTaskState()
end

function AllianceDailyTaskCell:_updateTaskState()
	if self._state == var_0_1.TASK_STATE.REWARD then
		self.m_stateController:setSelectedIndex(3)
	elseif self._state == var_0_1.TASK_STATE.FINISH then
		self.m_stateController:setSelectedIndex(2)
	elseif self._taskInfo.route_id == 0 then
		self.m_stateController:setSelectedIndex(4)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

function AllianceDailyTaskCell:_onClickGoBtn()
	if self._state == var_0_1.TASK_STATE.FINISH then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_JiaChengClick)
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_TaskAward({
			id = self._taskInfo.id
		})
	elseif self._state == var_0_1.TASK_STATE.NOT_FINISH then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._taskInfo.route_id)
	end
end

return AllianceDailyTaskCell
