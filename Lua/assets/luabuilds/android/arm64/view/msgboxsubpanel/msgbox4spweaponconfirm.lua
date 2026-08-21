local var_0_0 = class("Msgbox4SpweaponConfirm", import(".MsgboxSubPanel"))

function var_0_0.getUIName(arg_1_0)
	return "Msgbox4SpweaponConfirm"
end

function var_0_0.OnRefresh(arg_2_0, arg_2_1)
	if arg_2_1.op == SpWeapon.CONFIRM_OP_DISCARD then
		setText(arg_2_0._tf:Find("Desc"), i18n("spweapon_ui_change_attr_text1"))
		setText(arg_2_0._tf:Find("Tip"), i18n("spweapon_ui_change_attr_text2"))
		setText(arg_2_0._tf:Find("Desc (1)/Attr"), arg_2_1.attrs[1][1])
		setText(arg_2_0._tf:Find("Desc (1)/Value1"), setColorStr(arg_2_1.attrs[1][2], "#ffde38"))
		setText(arg_2_0._tf:Find("Desc (1)/Value2"), setColorStr(arg_2_1.attrs[1][3], COLOR_GREY))
		setText(arg_2_0._tf:Find("Desc (1)/Symbol"), "")
		setText(arg_2_0._tf:Find("Desc (2)/Attr"), arg_2_1.attrs[2][1])
		setText(arg_2_0._tf:Find("Desc (2)/Value1"), setColorStr(arg_2_1.attrs[2][2], "#ffde38"))
		setText(arg_2_0._tf:Find("Desc (2)/Value2"), setColorStr(arg_2_1.attrs[2][3], COLOR_GREY))
		setText(arg_2_0._tf:Find("Desc (2)/Symbol"), "")
	elseif arg_2_1.op == SpWeapon.CONFIRM_OP_EXCHANGE then
		setText(arg_2_0._tf:Find("Desc"), i18n("spweapon_ui_keep_attr_text1"))
		setText(arg_2_0._tf:Find("Tip"), i18n("spweapon_ui_keep_attr_text2"))
		setText(arg_2_0._tf:Find("Desc (1)/Attr"), arg_2_1.attrs[1][1])
		setText(arg_2_0._tf:Find("Desc (1)/Value1"), arg_2_1.attrs[1][2])
		setText(arg_2_0._tf:Find("Desc (1)/Value2"), setColorStr(arg_2_1.attrs[1][3], "#92fc63"))
		setText(arg_2_0._tf:Find("Desc (1)/Symbol"), ">")
		setText(arg_2_0._tf:Find("Desc (2)/Attr"), arg_2_1.attrs[2][1])
		setText(arg_2_0._tf:Find("Desc (2)/Value1"), arg_2_1.attrs[2][2])
		setText(arg_2_0._tf:Find("Desc (2)/Value2"), setColorStr(arg_2_1.attrs[2][3], "#92fc63"))
		setText(arg_2_0._tf:Find("Desc (2)/Symbol"), ">")
	end

	return
end

return var_0_0
