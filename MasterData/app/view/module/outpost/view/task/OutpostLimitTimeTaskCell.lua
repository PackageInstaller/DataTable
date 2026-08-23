local OutpostLimitTimeTaskCell = class("OutpostLimitTimeTaskCell", require("app.fairyGUI.outpost.UI_OutpostLimitTimeTaskCell"))

function OutpostLimitTimeTaskCell:ctor()
	self._taskCfg = nil

	self.m_goToBtn:addClickListener(handler(self, self._onGoToBtnClicked))
end

function OutpostLimitTimeTaskCell:updateTaskCell(arg_2_1)
	self._taskCfg = arg_2_1.cfg

	self.m_titleTxt:setText(arg_2_1.cfg.description)

	if arg_2_1.isLock then
		self.m_openStateController:setSelectedIndex(0)

		return
	end

	if ((arg_2_1.action or nil) and arg_2_1.action.action_value) >= arg_2_1.cfg.quest_value then
		self.m_openStateController:setSelectedIndex(2)
	else
		self.m_openStateController:setSelectedIndex(1)
	end
end

function OutpostLimitTimeTaskCell:_onGoToBtnClicked()
	g.view.entrance.ModuleGotoProxy:gotoModule(self._taskCfg.jump_id)
end

return OutpostLimitTimeTaskCell
