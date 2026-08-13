class = var_0_10000

local var_0_0 = "WinterFestival2025CoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreAdaptActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "WinterFestival2025CoreActivityUI"
end

function var_0_1.GetButtonNameText(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getConfig("type")

	ActivityConst = var_1_10003

	if var_2_0 ~= var_1_10003.ACTIVITY_TYPE_TASK_POOL then
		ActivityConst = var_3

		if var_2_0 == var_3.ACTIVITY_TYPE_SHRINE then
			i18n = var_3

			return var_3(arg_2_1:getConfig("title_res_tag"))
		end

		ActivityConst = var_3

		if var_2_0 == var_3.ACTIVITY_TYPE_PT_HEI5 then
			i18n = var_3

			return var_3("general_activity_side_bar2")
		end

		i18n = var_3

		return (var_3("general_activity_side_bar" .. arg_2_1:getConfig("is_show")))
	end
end

function var_0_1.didEnter(arg_3_0)
	var_0_1.super.didEnter(arg_3_0)

	if arg_3_0.contextData.actID then
		arg_3_0:verifyTabs(arg_3_0.contextData.actID)
	end

	return
end

function var_0_1.CustomInit(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_3.Find(var_4_0, "adapt/TopPage/top/deco/Text")

	i18n = var_1_10004

	var_1_10001(var_4_1, var_1_10004("HelenaCoreActivity_title"))

	setText = var_1_10001

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_3.Find(var_4_2, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_4

	var_1_10001(var_4_3, var_4("HelenaCoreActivity_title2"))

	return
end

function var_0_1.selectActivity(arg_5_0, arg_5_1)
	var_0_1.super.selectActivity(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getConfig(var_5_0, "type")

	ActivityConst = var_1_10003

	local var_5_2 = var_5_1 == var_1_10003.ACTIVITY_TYPE_SHRINE

	SetActive = var_5_0

	local var_5_3 = arg_5_0._tf

	var_5_0(var_6.Find(var_5_3, "adapt/bg"), not var_5_2)

	SetActive = var_5_0

	local var_5_4 = arg_5_0._tf

	var_5_0(var_6.Find(var_5_4, "adapt/bg_1"), not var_5_2)

	SetActive = var_5_0

	local var_5_5 = arg_5_0._tf

	var_5_0(var_6.Find(var_5_5, "adapt/bg_shrine"), var_5_2)

	SetActive = var_5_0

	local var_5_6 = arg_5_0._tf

	var_5_0(var_6.Find(var_5_6, "adapt/bg_shrine_1"), var_5_2)

	return
end

return var_0_1
