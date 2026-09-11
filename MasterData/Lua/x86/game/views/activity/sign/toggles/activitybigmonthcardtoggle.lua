local ActivityBigMonthCardToggle = class("ActivityBigMonthCardToggle", ActivityBaseToggle)

function ActivityBigMonthCardToggle:GetName()
	return "ActivityBigMonthCardToggle"
end

function ActivityBigMonthCardToggle:IsActivity()
	return true
end

function ActivityBigMonthCardToggle:UIClass()
	return BigMonthCardPage
end

function ActivityBigMonthCardToggle:Check()
	if BigMonthCardData:HaveMonthCard() then
		local var_4_0

		if BigMonthCardData:IsSignToday() then
			var_4_0 = BigMonthCardData:IsNeedAccumulatSign() or not (BigMonthCardData:HaveMonthCard() or BigMonthCardData:IsExpireTip() ~= 1)
		end
	end

	return var_4_0
end

function ActivityBigMonthCardToggle:Title()
	return GetTips("SIGN_TITLE_BIGMONTHCARD")
end

function ActivityBigMonthCardToggle:Image()
	return "big_monthCard"
end

function ActivityBigMonthCardToggle:RedPointKey()
	return RedPointConst.BIG_MONTH_CARD
end

function ActivityBigMonthCardToggle:Order()
	return 5
end

function ActivityBigMonthCardToggle:GetSystemID()
	return ViewConst.SYSTEM_ID.BIG_MONTH_CARD
end

return ActivityBigMonthCardToggle
