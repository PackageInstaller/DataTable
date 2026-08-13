class = var_0_10000

local var_0_0 = "ActivityBossZhangwuScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ActivityBossJianwuScene"))

function var_0_1.getUIName(arg_1_0)
	return "ActivityBossZhangwuUI"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.right
	local var_2_1 = var_2.Find(var_2_0, "1/Image")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("word_easy"))

	setText = var_1

	local var_2_2 = arg_2_0.right
	local var_2_3 = var_2.Find(var_2_2, "2/Image")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("word_normal_junhe"))

	setText = var_1

	local var_2_4 = arg_2_0.right
	local var_2_5 = var_2.Find(var_2_4, "3/Image")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("word_hard"))

	setText = var_1

	local var_2_6 = arg_2_0.top
	local var_2_7 = var_2.Find(var_2_6, "ticket/Desc")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("word_special_challenge_ticket"))

	setAnchoredPosition = var_1

	var_1(arg_2_0.left, {
		x = 0
	})

	setAnchoredPosition = var_1

	var_1(arg_2_0.right, {
		x = 0
	})

	return
end

return var_0_1
