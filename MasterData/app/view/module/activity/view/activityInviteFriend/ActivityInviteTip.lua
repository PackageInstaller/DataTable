local ActivityInviteTip = class("ActivityInviteTip", require("app.fairyGUI.activity.UI_ActivityInviteTip"))

function ActivityInviteTip:ctor()
	return
end

function ActivityInviteTip:updateView()
	return
end

function ActivityInviteTip:updateStatus(arg_3_1)
	if arg_3_1 then
		self.m_statusController:setSelectedIndex(1)
	else
		self.m_statusController:setSelectedIndex(0)
	end
end

return ActivityInviteTip
