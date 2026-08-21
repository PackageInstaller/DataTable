local var_0_0 = class("ActivityTarotSignToggle", ActivityBaseToggle)

function var_0_0.GetName(arg_1_0)
	return "ActivityTarotSignToggle"
end

function var_0_0.IsActivity(arg_2_0)
	return ActivityData:GetActivityIsOpen(ActivityConst.SIGN)
end

function var_0_0.UIClass(arg_3_0)
	return TarotSignPage
end

function var_0_0.RedPointKey(arg_4_0)
	return RedPointConst.TAROT_SIGN
end

function var_0_0.Check(arg_5_0)
	return (TarotSignTools.CanSignToday())
end

function var_0_0.Title(arg_6_0)
	return GetTips("SIGN_TITLE_DAILY")
end

function var_0_0.Image(arg_7_0)
	return "everyday"
end

function var_0_0.Order(arg_8_0)
	return 4
end

return var_0_0
