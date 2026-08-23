local ActivitySubscriptionTxtComp = class("ActivitySubscriptionTxtComp", require("app.fairyGUI.activity.UI_ActivitySubscriptionTxtComp"))

function ActivitySubscriptionTxtComp:updateByData(arg_1_1, arg_1_2)
	self.m_oddController:setSelectedIndex(arg_1_1 % 2 == 0 and 1 or 0)

	arg_1_1 = g.core.utils.Number.getFormatNum(2, arg_1_1)

	self.m_indexTxt:setText(arg_1_1)
	self.m_descTxt:setText(arg_1_2, true)
end

return ActivitySubscriptionTxtComp
