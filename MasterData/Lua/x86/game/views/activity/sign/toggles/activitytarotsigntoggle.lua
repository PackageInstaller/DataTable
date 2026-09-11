local ActivityTarotSignToggle = class("ActivityTarotSignToggle", ActivityBaseToggle)

function ActivityTarotSignToggle:GetName()
	return "ActivityTarotSignToggle"
end

function ActivityTarotSignToggle:IsActivity()
	return ActivityData:GetActivityIsOpen(ActivityConst.SIGN)
end

function ActivityTarotSignToggle:UIClass()
	return TarotSignPage
end

function ActivityTarotSignToggle:RedPointKey()
	return RedPointConst.TAROT_SIGN
end

function ActivityTarotSignToggle:Check()
	return (TarotSignTools.CanSignToday())
end

function ActivityTarotSignToggle:Title()
	return GetTips("SIGN_TITLE_DAILY")
end

function ActivityTarotSignToggle:Image()
	return "everyday"
end

function ActivityTarotSignToggle:Order()
	return 4
end

return ActivityTarotSignToggle
