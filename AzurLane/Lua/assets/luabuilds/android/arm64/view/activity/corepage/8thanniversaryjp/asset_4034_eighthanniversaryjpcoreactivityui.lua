class = var_0_10000

local var_0_0 = "EighthAnniversaryJpCoreActivityUI"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreAdaptActivityMainScene"))

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryEightCoreActivityUI"
end

var_0_1.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_1.CustomInit(arg_2_0)
	quickPlayAnimation = var_1_10001

	local var_2_0 = arg_2_0._tf

	var_1_10001(var_3.Find(var_2_0, "adapt/TopPage/top"), "Anim_SecretsAbyssCoreActivityUI_top_In")

	setText = var_1_10001

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "adapt/TopPage/top/deco/Text")

	i18n = var_4

	var_1_10001(var_2_2, var_4("activity_ninjia_main_title"))

	setText = var_1_10001

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "adapt/TopPage/top/deco/Text/Text_1")

	i18n = var_4

	var_1_10001(var_2_4, var_4("activity_ninjia_main_title_en"))

	return
end

function var_0_1.GetButtonNameText(arg_3_0, arg_3_1)
	i18n = var_1_10002
	string = var_1_10004

	return var_1_10002(var_1_10004.format("activity_ninjia_main_sheet%s", arg_3_1:getConfig("is_show")))
end

function var_0_1.OnClickBtn(arg_4_0, arg_4_1, arg_4_2)
	quickPlayAnimation = var_1_10003

	var_1_10003(arg_4_1, "Anim_SecretsAbyssCoreActivityUI_tabs_on_In")

	return
end

return var_0_1
