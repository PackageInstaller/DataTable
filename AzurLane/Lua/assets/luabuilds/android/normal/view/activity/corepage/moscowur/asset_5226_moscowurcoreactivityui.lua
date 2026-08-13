class = var_0_10000

local var_0_0 = "MoscowURCoreActivityUI"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function var_0_1.getUIName(arg_1_0)
	return "MoscowURCoreActivityUI"
end

function var_0_1.init(arg_2_0, ...)
	var_0_1.super.init(arg_2_0, ...)

	local var_2_0 = arg_2_0._tf

	arg_2_0.topPage = var_1.Find(var_2_0, "adapt/TopPage")
	setText = var_1

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "adapt/TopPage/top/deco/Text")

	i18n = var_2_1

	var_1(var_2_2, var_2_1("HelenaCoreActivity_title"))

	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("HelenaCoreActivity_title2"))

	return
end

function var_0_1.verifyTabs(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.activities
	local var_3_3

	if not arg_3_0:getActivityIndex(arg_3_1) then
		local var_3_1 = arg_3_0
		local var_3_2 = arg_3_0.getActivityIndex

		var_1_10006 = arg_3_0

		if not var_3_2(var_3_1, arg_3_0.GetActiveActivity(var_1_10006)) then
			var_3_3 = 1
		end
	end

	if var_3_0[var_3_3] == nil then
		return
	end

	local var_3_4 = var_2:getConfig("is_show")
	local var_3_5 = arg_3_0.tabs
	local var_3_6 = var_4.Find

	tostring = var_1_10006

	local var_3_7 = var_3_6(var_3_5, var_1_10006(var_3_4))

	triggerToggle = var_3_5

	var_3_5(var_3_7, true)

	return
end

function var_0_1.OnAnimations(arg_4_0, arg_4_1, arg_4_2)
	SetActive = var_1_10003

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_4.Find(var_4_0, "adapt/decorate")

	id = var_4_0

	local var_4_2

	if var_4_0 ~= 50261 then
		id = var_4_0

		if var_4_0 ~= 0 then
			var_4_2 = false

			goto label_4_0
		end
	end

	var_4_2 = true

	::label_4_0::

	var_1_10003(var_4_1, var_4_2)

	return
end

function var_0_1.OnToggleName(arg_5_0, arg_5_1, arg_5_2)
	setText = var_1_10003

	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.Find(var_5_0, "name")

	i18n = var_5_0

	var_1_10003(var_5_1, var_5_0(arg_5_2:getConfig("title_res_tag")))

	return
end

function var_0_1.willExit(arg_6_0)
	var_0_1.super.willExit(arg_6_0)

	return
end

return var_0_1
