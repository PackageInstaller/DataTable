local var_0_0 = class("EighthAnniversaryJpCoreActivityUI", import("view.activity.CorePage.CoreAdaptActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return "AnniversaryEightCoreActivityUI"
end

var_0_0.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_0.CustomInit(arg_2_0)
	quickPlayAnimation(arg_2_0._tf:Find("adapt/TopPage/top"), "Anim_SecretsAbyssCoreActivityUI_top_In")
	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text"), i18n("activity_ninjia_main_title"))
	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("activity_ninjia_main_title_en"))

	return
end

function var_0_0.GetButtonNameText(arg_3_0, arg_3_1)
	return i18n(string.format("activity_ninjia_main_sheet%s", arg_3_1:getConfig("is_show")))
end

function var_0_0.OnClickBtn(arg_4_0, arg_4_1, arg_4_2)
	quickPlayAnimation(arg_4_1, "Anim_SecretsAbyssCoreActivityUI_tabs_on_In")

	return
end

return var_0_0
