local ActivityMonthCardToggle = class("ActivityMonthCardToggle", ActivityBaseToggle)

function ActivityMonthCardToggle:GetName()
	return "ActivityMonthCardToggle"
end

function ActivityMonthCardToggle:IsActivity()
	return RechargeData:HaveMonthCard()
end

function ActivityMonthCardToggle:UIClass()
	return MonthCardPage
end

function ActivityMonthCardToggle:Check()
	return RechargeData:HaveMonthCard() and not RechargeData:IsSignToday()
end

function ActivityMonthCardToggle:Title()
	return GetTips("SIGN_TITLE_MONTHCARD")
end

function ActivityMonthCardToggle:Image()
	return "monthCard"
end

function ActivityMonthCardToggle:Order()
	return 21
end

return ActivityMonthCardToggle
