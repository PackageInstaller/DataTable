local var_0_0 = class("ItemShowPanel", import(".MsgboxSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "ItemChangeNoticeBox"
end

function var_0_0.UpdateView(arg_2_0, arg_2_1)
	arg_2_0:PreRefresh(arg_2_1)

	rtf(arg_2_0.viewParent._window).sizeDelta = Vector2.New(1000, 638)

	setText(arg_2_0._tf:Find("title"), i18n(arg_2_1.configData.title))
	setText(arg_2_0._tf:Find("name_origin"), i18n(arg_2_1.configData.name_old))
	setText(arg_2_0._tf:Find("name_now"), i18n(arg_2_1.configData.name_new))
	setText(arg_2_0._tf:Find("before/Text"), i18n(arg_2_1.configData.tip_old))
	setText(arg_2_0._tf:Find("after/Text"), i18n(arg_2_1.configData.tip_new))
	setImageSprite(arg_2_0._tf:Find("icon_origin"), LoadSprite(arg_2_1.configData.icon_old))
	setImageSprite(arg_2_0._tf:Find("icon_now"), LoadSprite(arg_2_1.configData.icon_new))
	arg_2_0:PostRefresh(arg_2_1)

	return
end

return var_0_0
