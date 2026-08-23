local ActivityPermanentRechargeCompleteComp = class("ActivityPermanentRechargeCompleteComp", require("app.fairyGUI.activity.UI_ActivityPermanentRechargeCompleteComp"))

function ActivityPermanentRechargeCompleteComp:ctor()
	return
end

function ActivityPermanentRechargeCompleteComp:setProgressText(arg_2_1, arg_2_2)
	self.m_needSizeTxt:setText("/" .. arg_2_1)
	self.m_ownSizeTxt:setText(arg_2_2)
end

return ActivityPermanentRechargeCompleteComp
