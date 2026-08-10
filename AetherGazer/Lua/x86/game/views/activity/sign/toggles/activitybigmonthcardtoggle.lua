local var_0_0 = class("ActivityBigMonthCardToggle", ActivityBaseToggle)

function var_0_0.GetName(arg_1_0)
	return "ActivityBigMonthCardToggle"
end

function var_0_0.IsActivity(arg_2_0)
	return true
end

function var_0_0.UIClass(arg_3_0)
	return BigMonthCardPage
end

function var_0_0.Check(arg_4_0)
	return BigMonthCardData:HaveMonthCard() and (not BigMonthCardData:IsSignToday() or BigMonthCardData:IsNeedAccumulatSign()) or not BigMonthCardData:HaveMonthCard() and BigMonthCardData:IsExpireTip() == 1
end

function var_0_0.Title(arg_5_0)
	return GetTips("SIGN_TITLE_BIGMONTHCARD")
end

function var_0_0.Image(arg_6_0)
	return "big_monthCard"
end

function var_0_0.RedPointKey(arg_7_0)
	return RedPointConst.BIG_MONTH_CARD
end

function var_0_0.Order(arg_8_0)
	return 5
end

function var_0_0.GetSystemID(arg_9_0)
	return ViewConst.SYSTEM_ID.BIG_MONTH_CARD
end

return var_0_0
