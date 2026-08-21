local var_0_0 = class("ActivityBossZhangwuScene", import(".ActivityBossJianwuScene"))

function var_0_0.getUIName(arg_1_0)
	return "ActivityBossZhangwuUI"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)
	setText(arg_2_0.right:Find("1/Image"), i18n("word_easy"))
	setText(arg_2_0.right:Find("2/Image"), i18n("word_normal_junhe"))
	setText(arg_2_0.right:Find("3/Image"), i18n("word_hard"))
	setText(arg_2_0.top:Find("ticket/Desc"), i18n("word_special_challenge_ticket"))
	setAnchoredPosition(arg_2_0.left, {
		x = 0
	})
	setAnchoredPosition(arg_2_0.right, {
		x = 0
	})

	return
end

return var_0_0
