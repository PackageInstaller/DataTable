local GmPassCardConst = require("app.view.module.newPassCard.const.GmPassCardConst")
local var_0_1 = g.core.model.User.gmPassCardData
local PassCardNewTaskCell = class("PassCardNewTaskCell", require("app.fairyGUI.newPassCard.UI_PassCardNewTaskCell"))

function PassCardNewTaskCell:ctor()
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskAction))
end

function PassCardNewTaskCell:updatePassCardNewTask(arg_2_1)
	self._cfg = arg_2_1.cfg

	self.m_descTxt:setText(arg_2_1.cfg.des)
	self.m_scoreTxt:setText(arg_2_1.cfg.reward_size)
	self.m_allNumTxt:setText("/" .. arg_2_1.cfg.action_value)
	self.m_numTxt:setText((arg_2_1.curValue > arg_2_1.cfg.action_value or nil) and (arg_2_1.cfg.action_value or arg_2_1.curValue))

	if arg_2_1.cfg.action_value == 0 then
		self.m_numTxt:setText("1")
		self.m_allNumTxt:setText("/1")
	end

	self.m_itemIcon:setURL(g.core.common.Goods:convert({
		type = arg_2_1.cfg.reward_type,
		value = arg_2_1.cfg.reward_value
	}).icon)
	self.m_stateController:setSelectedIndex(arg_2_1.state)
end

function PassCardNewTaskCell:_onClickTaskAction()
	if self._cfg then
		local var_3_0 = var_0_1:getTaskState(self._cfg)

		if var_3_0 == GmPassCardConst.TASK_STATE.FINISH then
			g.core.network.GameNetProxy:send_C2S_PasscardActivity_TaskAward({
				ids = {
					self._cfg.id
				}
			})
		elseif var_3_0 == GmPassCardConst.TASK_STATE.NOT_FINISH then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._cfg.route)
		elseif var_3_0 == GmPassCardConst.TASK_STATE.GET then
			g.core.module.ModuleManager:tip(g.core.lang:get(422503))
		end
	end
end

return PassCardNewTaskCell
