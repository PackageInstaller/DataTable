local ActivityWakePreviewItem = class("ActivityWakePreviewItem", require("app.fairyGUI.activity.UI_ActivityWakePreviewItem"))

function ActivityWakePreviewItem:ctor()
	return
end

function ActivityWakePreviewItem:updateView(arg_2_1)
	self.m_icon:updateIcon(arg_2_1.good)
	self.m_stateController:setSelectedIndex(arg_2_1.isGot and 0 or 1)
end

return ActivityWakePreviewItem
