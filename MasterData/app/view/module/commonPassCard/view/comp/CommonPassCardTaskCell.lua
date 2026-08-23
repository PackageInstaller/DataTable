local var_0_0 = g.core.const.ConstMgr.CommonPassCardConst
local var_0_1 = g.core.model.User.commonPassCardDataMgr
local CommonPassCardTaskCell = class("CommonPassCardTaskCell", require("app.fairyGUI.commonPassCard.UI_CommonPassCardTaskCell"))

function CommonPassCardTaskCell:ctor()
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskAction))
end

function CommonPassCardTaskCell:updatePassCardNewTask(arg_2_1, arg_2_2)
	self._actId = arg_2_2
	self._commonPassCardData = var_0_1:getPassCardData(self._actId)

	local var_2_0 = arg_2_1.cfg

	self._cfg = arg_2_1.cfg

	self.m_descTxt:setText(g.core.lang:getByString(var_2_0.des, {
		num = var_2_0.action_value
	}))
	self.m_scoreTxt:setText(var_2_0.reward_size)
	self.m_allNumTxt:setText("/" .. var_2_0.action_value)
	self.m_numTxt:setText((arg_2_1.curValue > var_2_0.action_value or nil) and (var_2_0.action_value or arg_2_1.curValue))

	if var_2_0.action_value == 0 then
		self.m_numTxt:setText("1")
		self.m_allNumTxt:setText("/1")
	end

	self.m_itemIcon:setURL(g.core.common.Goods:convert({
		type = var_2_0.reward_type,
		value = var_2_0.reward_value
	}).icon)
	self.m_stateController:setSelectedIndex(arg_2_1.state)
end

function CommonPassCardTaskCell:_onClickTaskAction()
	if self._cfg then
		local var_3_0 = self._commonPassCardData:getTaskState(self._cfg)

		if var_3_0 == var_0_0.TASK_STATE.FINISH then
			g.core.network.GameNetProxy:send_C2S_CommonPasscard_TaskAward({
				id = self._actId,
				task_ids = {
					self._cfg.id
				}
			})
		elseif var_3_0 == var_0_0.TASK_STATE.NOT_FINISH then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._cfg.route)
		elseif var_3_0 == var_0_0.TASK_STATE.GET then
			g.core.module.ModuleManager:tip(g.core.lang:get(422503))
		end
	end
end

return CommonPassCardTaskCell
