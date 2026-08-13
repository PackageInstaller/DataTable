class = var_0_10000

local var_0_0 = "Msgbox4SpweaponConfirm"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

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
		local var_2_2 = var_4.Find(var_2_1, "Desc")

		i18n = var_2_1

		var_2_5(var_2_2, var_2_1("spweapon_ui_change_attr_text1"))

		setText = var_2_5

		local var_2_3 = arg_2_0._tf
		local var_2_4 = var_4.Find(var_2_3, "Tip")

		i18n = var_2_3

		var_2_5(var_2_4, var_2_3("spweapon_ui_change_attr_text2"))

		var_2_5 = arg_2_1.attrs[1]
		setText = var_2_4

		local var_2_6 = arg_2_0._tf

		var_2_4(var_5.Find(var_2_6, "Desc (1)/Attr"), var_2_5[1])

		setText = var_2_4

		local var_2_7 = arg_2_0._tf
		local var_2_8 = var_5.Find(var_2_7, "Desc (1)/Value1")

		setColorStr = var_2_7

		var_2_4(var_2_8, var_2_7(var_2_5[2], "#ffde38"))

		setText = var_2_4

		local var_2_9 = arg_2_0._tf
		local var_2_10 = var_5.Find(var_2_9, "Desc (1)/Value2")

		setColorStr = var_2_9

		local var_2_11 = var_2_5[3]

		COLOR_GREY = var_8

		var_2_4(var_2_10, var_2_9(var_2_11, var_8))

		setText = var_2_4

		local var_2_12 = arg_2_0._tf

		var_2_4(var_5.Find(var_2_12, "Desc (1)/Symbol"), "")

		local var_2_13 = arg_2_1.attrs[2]

		setText = var_5

		local var_2_14 = arg_2_0._tf

		var_5(var_6.Find(var_2_14, "Desc (2)/Attr"), var_2_13[1])

		setText = var_5

		local var_2_15 = arg_2_0._tf
		local var_2_16 = var_6.Find(var_2_15, "Desc (2)/Value1")

		setColorStr = var_2_15

		var_5(var_2_16, var_2_15(var_2_13[2], "#ffde38"))

		setText = var_5

		local var_2_17 = arg_2_0._tf
		local var_2_18 = var_6.Find(var_2_17, "Desc (2)/Value2")

		setColorStr = var_2_17

		local var_2_19 = var_2_13[3]

		COLOR_GREY = var_9

		var_5(var_2_18, var_2_17(var_2_19, var_9))

		setText = var_5

		local var_2_20 = arg_2_0._tf

		var_5(var_6.Find(var_2_20, "Desc (2)/Symbol"), "")
	else
		SpWeapon = var_2_5

		if var_2_0 == var_2_5.CONFIRM_OP_EXCHANGE then
			setText = var_3

			local var_2_21 = arg_2_0._tf
			local var_2_22 = var_4.Find(var_2_21, "Desc")

			i18n = var_2_21

			var_3(var_2_22, var_2_21("spweapon_ui_keep_attr_text1"))

			setText = var_3

			local var_2_23 = arg_2_0._tf
			local var_2_24 = var_4.Find(var_2_23, "Tip")

			i18n = var_2_23

			var_3(var_2_24, var_2_23("spweapon_ui_keep_attr_text2"))

			local var_2_25 = arg_2_1.attrs[1]

			setText = var_2_24

			local var_2_26 = arg_2_0._tf

			var_2_24(var_5.Find(var_2_26, "Desc (1)/Attr"), var_2_25[1])

			setText = var_2_24

			local var_2_27 = arg_2_0._tf

			var_2_24(var_5.Find(var_2_27, "Desc (1)/Value1"), var_2_25[2])

			setText = var_2_24

			local var_2_28 = arg_2_0._tf
			local var_2_29 = var_5.Find(var_2_28, "Desc (1)/Value2")

			setColorStr = var_2_28

			var_2_24(var_2_29, var_2_28(var_2_25[3], "#92fc63"))

			setText = var_2_24

			local var_2_30 = arg_2_0._tf

			var_2_24(var_5.Find(var_2_30, "Desc (1)/Symbol"), ">")

			local var_2_31 = arg_2_1.attrs[2]

			setText = var_5

			local var_2_32 = arg_2_0._tf

			var_5(var_6.Find(var_2_32, "Desc (2)/Attr"), var_2_31[1])

			setText = var_5

			local var_2_33 = arg_2_0._tf

			var_5(var_6.Find(var_2_33, "Desc (2)/Value1"), var_2_31[2])

			setText = var_5

			local var_2_34 = arg_2_0._tf
			local var_2_35 = var_6.Find(var_2_34, "Desc (2)/Value2")

			setColorStr = var_2_34

			var_5(var_2_35, var_2_34(var_2_31[3], "#92fc63"))

			setText = var_5

			local var_2_36 = arg_2_0._tf

			var_5(var_6.Find(var_2_36, "Desc (2)/Symbol"), ">")
		end
	end

	return
end

return var_0_1
