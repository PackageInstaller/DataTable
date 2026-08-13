class = var_0_10000

local var_0_0 = "ItemShowPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "ItemChangeNoticeBox"
end

function var_0_1.UpdateView(arg_2_0, arg_2_1)
	arg_2_0:PreRefresh(arg_2_1)

	rtf = var_2

	local var_2_0 = var_2(arg_2_0.viewParent._window)

	Vector2 = var_1_10003
	var_2_0.sizeDelta = var_1_10003.New(1000, 638)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "title")
	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_3.Find(var_2_3, "icon_origin")
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_4.Find(var_2_5, "icon_now")
	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_5.Find(var_2_7, "name_origin")
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_6.Find(var_2_9, "name_now")
	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_7.Find(var_2_11, "before/Text")
	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_8.Find(var_2_13, "after/Text")
	local var_2_15 = arg_2_1.configData

	setText = var_2_13

	local var_2_16 = var_2_2

	i18n = var_1_10013

	var_2_13(var_2_16, var_1_10013(var_2_15.title))

	setText = var_2_13

	local var_2_17 = var_2_8

	i18n = var_13

	var_2_13(var_2_17, var_13(var_2_15.name_old))

	setText = var_2_13

	local var_2_18 = var_2_10

	i18n = var_13

	var_2_13(var_2_18, var_13(var_2_15.name_new))

	setText = var_2_13

	local var_2_19 = var_2_12

	i18n = var_13

	var_2_13(var_2_19, var_13(var_2_15.tip_old))

	setText = var_2_13

	local var_2_20 = var_2_14

	i18n = var_13

	var_2_13(var_2_20, var_13(var_2_15.tip_new))

	setImageSprite = var_2_13

	local var_2_21 = var_2_4

	LoadSprite = var_13

	var_2_13(var_2_21, var_13(var_2_15.icon_old))

	setImageSprite = var_2_13

	local var_2_22 = var_2_6

	LoadSprite = var_13

	var_2_13(var_2_22, var_13(var_2_15.icon_new))
	arg_2_0:PostRefresh(arg_2_1)

	return
end

return var_0_1
