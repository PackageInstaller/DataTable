class = var_0_10000

local var_0_0 = "Msgbox4SpweaponConfirm"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "Msgbox4SpweaponConfirm"
end

function var_0_1.OnRefresh(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.op

	SpWeapon = var_1_10003

	local var_2_5

	if var_2_0 == var_1_10003.CONFIRM_OP_DISCARD then
		setText = var_2_5

		local var_2_1 = arg_2_0._tf
		local var_2_2 = var_5.Find(var_2_1, "Desc")

		i18n = var_1_10006

		var_2_5(var_2_2, var_1_10006("spweapon_ui_change_attr_text1"))

		setText = var_2_5

		local var_2_3 = arg_2_0._tf
		local var_2_4 = var_5.Find(var_2_3, "Tip")

		i18n = var_1_10006

		var_2_5(var_2_4, var_1_10006("spweapon_ui_change_attr_text2"))

		var_2_5 = arg_2_1.attrs[1]
		setText = var_1_10004

		local var_2_6 = arg_2_0._tf

		var_1_10004(var_1_10006.Find(var_2_6, "Desc (1)/Attr"), var_2_5[1])

		setText = var_1_10004

		local var_2_7 = arg_2_0._tf

		var_1_10006 = var_1_10006.Find(var_2_7, "Desc (1)/Value1")
		setColorStr = var_7

		var_1_10004(var_1_10006, var_7(var_2_5[2], "#ffde38"))

		setText = var_1_10004

		local var_2_8 = arg_2_0._tf

		var_1_10006 = var_1_10006.Find(var_2_8, "Desc (1)/Value2")
		setColorStr = var_7

		local var_2_9 = var_2_5[3]

		COLOR_GREY = var_10

		var_1_10004(var_1_10006, var_7(var_2_9, var_10))

		setText = var_1_10004

		local var_2_10 = arg_2_0._tf

		var_1_10004(var_1_10006.Find(var_2_10, "Desc (1)/Symbol"), "")

		var_1_10004 = arg_2_1.attrs[2]
		setText = var_2_4

		local var_2_11 = arg_2_0._tf

		var_2_4(var_7.Find(var_2_11, "Desc (2)/Attr"), var_1_10004[1])

		setText = var_2_4

		local var_2_12 = arg_2_0._tf
		local var_2_13 = var_7.Find(var_2_12, "Desc (2)/Value1")

		setColorStr = var_8

		var_2_4(var_2_13, var_8(var_1_10004[2], "#ffde38"))

		setText = var_2_4

		local var_2_14 = arg_2_0._tf
		local var_2_15 = var_7.Find(var_2_14, "Desc (2)/Value2")

		setColorStr = var_8

		local var_2_16 = var_1_10004[3]

		COLOR_GREY = var_11

		var_2_4(var_2_15, var_8(var_2_16, var_11))

		setText = var_2_4

		local var_2_17 = arg_2_0._tf

		var_2_4(var_7.Find(var_2_17, "Desc (2)/Symbol"), "")
	else
		SpWeapon = var_2_5

		if var_2_0 == var_2_5.CONFIRM_OP_EXCHANGE then
			setText = var_3

			local var_2_18 = arg_2_0._tf
			local var_2_19 = var_5.Find(var_2_18, "Desc")

			i18n = var_1_10006

			var_3(var_2_19, var_1_10006("spweapon_ui_keep_attr_text1"))

			setText = var_3

			local var_2_20 = arg_2_0._tf
			local var_2_21 = var_5.Find(var_2_20, "Tip")

			i18n = var_6

			var_3(var_2_21, var_6("spweapon_ui_keep_attr_text2"))

			local var_2_22 = arg_2_1.attrs[1]

			setText = var_1_10004

			local var_2_23 = arg_2_0._tf

			var_1_10004(var_6.Find(var_2_23, "Desc (1)/Attr"), var_2_22[1])

			setText = var_1_10004

			local var_2_24 = arg_2_0._tf

			var_1_10004(var_6.Find(var_2_24, "Desc (1)/Value1"), var_2_22[2])

			setText = var_1_10004

			local var_2_25 = arg_2_0._tf
			local var_2_26 = var_6.Find(var_2_25, "Desc (1)/Value2")

			setColorStr = var_7

			var_1_10004(var_2_26, var_7(var_2_22[3], "#92fc63"))

			setText = var_1_10004

			local var_2_27 = arg_2_0._tf

			var_1_10004(var_6.Find(var_2_27, "Desc (1)/Symbol"), ">")

			local var_2_28 = arg_2_1.attrs[2]

			setText = var_2_21

			local var_2_29 = arg_2_0._tf

			var_2_21(var_7.Find(var_2_29, "Desc (2)/Attr"), var_2_28[1])

			setText = var_2_21

			local var_2_30 = arg_2_0._tf

			var_2_21(var_7.Find(var_2_30, "Desc (2)/Value1"), var_2_28[2])

			setText = var_2_21

			local var_2_31 = arg_2_0._tf
			local var_2_32 = var_7.Find(var_2_31, "Desc (2)/Value2")

			setColorStr = var_8

			var_2_21(var_2_32, var_8(var_2_28[3], "#92fc63"))

			setText = var_2_21

			local var_2_33 = arg_2_0._tf

			var_2_21(var_7.Find(var_2_33, "Desc (2)/Symbol"), ">")
		end
	end

	return
end

return var_0_1
