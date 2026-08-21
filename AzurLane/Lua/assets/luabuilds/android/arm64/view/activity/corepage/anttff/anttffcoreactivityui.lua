local var_0_0 = class("ANTTFFCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))

function var_0_0.getUIName(arg_1_0)
	return "ANTTFFCoreActivityUI"
end

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)
	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text"), i18n("ANTTFFCoreActivity_title"))
	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("ANTTFFCoreActivity_title2"))

	return
end

function var_0_0.OnToggleName(arg_3_0, arg_3_1, arg_3_2)
	setText(arg_3_1:Find("on/name"), i18n(arg_3_2:getConfig("title_res_tag")))
	setText(arg_3_1:Find("name"), i18n(arg_3_2:getConfig("title_res_tag")))

	return
end

function var_0_0.OnAnimations(arg_4_0, arg_4_1, arg_4_2)
	return
end

return var_0_0
