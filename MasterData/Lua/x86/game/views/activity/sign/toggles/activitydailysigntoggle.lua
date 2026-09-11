local ActivityDailySignToggle = class("ActivityDailySignToggle", ActivityBaseToggle)

function ActivityDailySignToggle:GetName()
	return "ActivityDailySignToggle"
end

function ActivityDailySignToggle:IsActivity()
	return ActivityData:GetActivityIsOpen(ActivityConst.SIGN)
end

function ActivityDailySignToggle:UIClass()
	return DailySignPage
end

function ActivityDailySignToggle:RedPointKey()
	return RedPointConst.SIGN_DAILY
end

function ActivityDailySignToggle:Check()
	return SignTools.GetDailySignIndex() ~= 0
end

function ActivityDailySignToggle:Title()
	return GetTips("SIGN_TITLE_DAILY")
end

function ActivityDailySignToggle:Image()
	return "everyday"
end

function ActivityDailySignToggle:Order()
	return 31
end

return ActivityDailySignToggle
