local var_0_0 = class("ActivitySevenSignToggle", ActivityBaseToggle)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1
end

function var_0_0.GetName(arg_2_0)
	return "ActivitySevenSignToggle" .. arg_2_0.activityId
end

function var_0_0.IsActivity(arg_3_0)
	return ActivityData:GetActivityIsOpen(arg_3_0.activityId) and SignData:GetSevenDaySignInfo(arg_3_0.activityId) ~= nil
end

function var_0_0.UIClass(arg_4_0)
	return SevenDaySignPage
end

function var_0_0.RedPointKey(arg_5_0)
	return string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, arg_5_0.activityId)
end

function var_0_0.Check(arg_6_0)
	return SignTools.GetSevenDaySignIndex(arg_6_0.activityId) ~= 0
end

function var_0_0.Title(arg_7_0)
	if ActivityCumulativeSignCfg[arg_7_0.activityId] then
		return ActivityCumulativeSignCfg[arg_7_0.activityId].title
	end

	return ""
end

function var_0_0.Image(arg_8_0)
	return "sevendays"
end

function var_0_0.Order(arg_9_0)
	return 11
end

function var_0_0.GetParams(arg_10_0)
	return arg_10_0.activityId
end

function var_0_0.GetLimitLevel(arg_11_0)
	if ActivityCumulativeSignCfg[arg_11_0.activityId] then
		return ActivityCumulativeSignCfg[arg_11_0.activityId].limit_level
	end

	return 0
end

return var_0_0
