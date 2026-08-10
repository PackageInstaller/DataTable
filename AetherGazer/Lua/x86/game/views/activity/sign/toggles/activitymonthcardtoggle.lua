local var_0_0 = class("ActivityMonthCardToggle", ActivityBaseToggle)

function var_0_0.GetName(arg_1_0)
	return "ActivityMonthCardToggle"
end

function var_0_0.IsActivity(arg_2_0)
	return RechargeData:HaveMonthCard()
end

function var_0_0.UIClass(arg_3_0)
	return MonthCardPage
end

function var_0_0.Check(arg_4_0)
	return RechargeData:HaveMonthCard() and not RechargeData:IsSignToday()
end

function var_0_0.Title(arg_5_0)
	return GetTips("SIGN_TITLE_MONTHCARD")
end

function var_0_0.Image(arg_6_0)
	return "monthCard"
end

function var_0_0.Order(arg_7_0)
	return 21
end

return var_0_0
