local OutpostGuideTaskCell = class("OutpostGuideTaskCell", require("app.fairyGUI.outpost.UI_OutpostGuideTaskCell"))

function OutpostGuideTaskCell:ctor()
	self._taskInfo = nil

	self:_initCell()
end

function OutpostGuideTaskCell:_initCell()
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetBtnClicked))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function OutpostGuideTaskCell:updateTaskCell(arg_3_1)
	self.m_taskNameText:setText(arg_3_1.cfg.description)

	self._taskInfo = arg_3_1

	self.m_awardList:setNumItems(#self._taskInfo.awards)

	if arg_3_1.isLock then
		self.m_isGetController:setSelectedIndex(3)

		return
	end

	local var_3_0 = arg_3_1.action

	if arg_3_1.action and var_3_0.finished then
		self.m_isGetController:setSelectedIndex(2)

		return
	end

	local var_3_1 = 0

	if var_3_0 then
		var_3_1 = var_3_0.action_value
	end

	if var_3_1 >= arg_3_1.cfg.quest_value then
		self.m_isGetController:setSelectedIndex(1)
	else
		self.m_taskNumText:setText((g.core.lang:get(201017, {
			num = var_3_1,
			maxNum = arg_3_1.cfg.quest_value
		})))
		self.m_isGetController:setSelectedIndex(0)
	end
end

function OutpostGuideTaskCell:_onAwardItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._taskInfo.awards[arg_4_1 + 1])
end

function OutpostGuideTaskCell:_onGetBtnClicked()
	self:dispatchCompEvent("getTaskAward", {
		id = self._taskInfo.id,
		type = self._taskInfo.cfg.quest_type
	})
end

return OutpostGuideTaskCell
