local ActivityReturnPreviewIcon = class("ActivityReturnPreviewIcon", require("app.fairyGUI.activityReturn.UI_ActivityReturnPreviewIcon"))

function ActivityReturnPreviewIcon:updateItem(arg_1_1)
	self.m_icon:updateIcon(arg_1_1)
end

return ActivityReturnPreviewIcon
