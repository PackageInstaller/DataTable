local WeddingActivityTaskItem = class("WeddingActivityTaskItem", require("app.fairyGUI.weddingActivity.UI_WeddingActivityTaskItem"))

function WeddingActivityTaskItem:updateTask(arg_1_1)
	self.m_taskDesTxt:setText(arg_1_1.des)
	self.m_taskProTaskTxt:setText(g.core.lang:get(201607, {
		num = arg_1_1.cur,
		max = arg_1_1.target
	}))
	self.m_isFinishController:setSelectedIndex(arg_1_1.cur >= arg_1_1.target and 1 or 0)
end

return WeddingActivityTaskItem
