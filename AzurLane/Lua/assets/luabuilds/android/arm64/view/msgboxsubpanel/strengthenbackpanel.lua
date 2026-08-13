class = var_0_10000

local var_0_0 = "StrengthenBackPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MsgboxSubPanel"))

var_0_1.ConfigData = {
	content = "equipment_info_change_strengthen",
	btnTxt = "text_forward",
	isOpen = true,
	icon = "equips/56000",
	equipID = 96000
}

function var_0_1.getUIName(arg_1_0)
	return "StrengthenBackBox"
end

function var_0_1.UpdateView(arg_2_0, arg_2_1)
	arg_2_0:PreRefresh(arg_2_1)

	rtf = var_2

	local var_2_0 = var_2(arg_2_0.viewParent._window)

	Vector2 = var_1_10003
	var_2_0.sizeDelta = var_1_10003.New(1000, 638)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "info_view/Viewport/Content/Text")

	Equipment = var_3

	local var_2_3 = var_3.getConfigData(var_0_1.ConfigData.equipID).name

	setText = var_2_1

	local var_2_4 = var_2_2

	i18n = var_1_10007

	var_2_1(var_2_4, var_1_10007(var_0_1.ConfigData.content, var_2_3))

	local var_2_5 = arg_2_0._tf
	local var_2_6

	var_2_6, setText = var_4.Find(var_2_5, "button_container/custom_button_1(Clone)/pic", arg_2_0._tf.parent), var_5
	i18n = var_8

	var_5(var_2_6, var_8(var_0_1.ConfigData.btnTxt))

	local var_2_7 = arg_2_0._tf
	local var_2_8

	var_2_8, setImageSprite = var_5.Find(var_2_7, "icon_bg/icon"), var_2_5
	LoadSprite = var_9

	var_2_5(var_2_8, var_9(var_0_1.ConfigData.icon))

	if arg_2_1.windowSize then
		local var_2_9 = arg_2_0._tf.parent

		Vector2 = var_2_7
		var_2_9.sizeDelta = var_2_7(arg_2_1.windowSize.x, arg_2_1.windowSize.y)
	end

	arg_2_0:PostRefresh(arg_2_1)

	return
end

return var_0_1
