local var_0_0 = class("WinterFestival2025CoreActivityUI", import("view.activity.CorePage.CoreAdaptActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return "WinterFestival2025CoreActivityUI"
end

function var_0_0.GetButtonNameText(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getConfig("type")

	if var_2_0 == ActivityConst.ACTIVITY_TYPE_TASK_POOL or var_2_0 == ActivityConst.ACTIVITY_TYPE_SHRINE then
		return i18n(arg_2_1:getConfig("title_res_tag"))
	end

	if var_2_0 == ActivityConst.ACTIVITY_TYPE_PT_HEI5 then
		return i18n("general_activity_side_bar2")
	end

	return (i18n("general_activity_side_bar" .. arg_2_1:getConfig("is_show")))
end

function var_0_0.didEnter(arg_3_0)
	var_0_0.super.didEnter(arg_3_0)

	if arg_3_0.contextData.actID then
		arg_3_0:verifyTabs(arg_3_0.contextData.actID)
	end

	return
end

function var_0_0.CustomInit(arg_4_0)
	setText(arg_4_0._tf:Find("adapt/TopPage/top/deco/Text"), i18n("HelenaCoreActivity_title"))
	setText(arg_4_0._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("HelenaCoreActivity_title2"))

	return
end

function var_0_0.selectActivity(arg_5_0, arg_5_1)
	var_0_0.super.selectActivity(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SHRINE

	SetActive(arg_5_0._tf:Find("adapt/bg"), not var_5_0)
	SetActive(arg_5_0._tf:Find("adapt/bg_1"), not var_5_0)
	SetActive(arg_5_0._tf:Find("adapt/bg_shrine"), var_5_0)
	SetActive(arg_5_0._tf:Find("adapt/bg_shrine_1"), var_5_0)

	return
end

return var_0_0
