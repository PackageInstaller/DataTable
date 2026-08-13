class = var_0_10000

local var_0_0 = "Msgbox4BlueprintUnlockItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "Msgbox4BlueprintUnlockItem"
end

function var_0_1.OnRefresh(arg_2_0, arg_2_1)
	rtf = var_1_10002

	local var_2_0 = var_1_10002(arg_2_0.viewParent._window)

	Vector2 = var_1_10003
	var_2_0.sizeDelta = var_1_10003(1010, 685)

	local var_2_1 = arg_2_1.item
	local var_2_2 = arg_2_1.blueprints

	updateDrop = var_4

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_6.Find(var_2_3, "IconTpl")
	local var_2_5 = {}

	DROP_TYPE_ITEM = var_2_3
	var_2_5.type = var_2_3
	var_2_5.id = var_2_1.id

	var_4(var_2_4, var_2_5)

	setText = var_4

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_6.Find(var_2_6, "content_unlock/title/bg/Text")

	i18n = var_2_5

	var_4(var_2_7, var_2_5("tech_select_tip1"))

	setText = var_4

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_6.Find(var_2_8, "content_unlock/title/Text")

	i18n = var_7

	var_4(var_2_9, var_7("tech_select_tip2"))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_4.Find(var_2_10, "content_unlock/mask/list")

	UIItemList = var_5

	local var_2_12 = var_5.New
	local var_2_13 = var_2_11
	local var_2_14 = var_2_11
	local var_2_15 = var_2_12(var_2_13, var_2_11.GetChild(var_2_14, 0))

	var_5.make(var_2_15, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			updateDrop = var_3

			local var_3_0 = arg_3_2
			local var_3_1 = arg_3_2.Find(var_3_0, "IconTpl")
			local var_3_2 = {}

			DROP_TYPE_SHIP = var_3_0
			var_3_2.type = var_3_0
			ShipGroup = var_3_0
			var_3_2.id = var_3_0.getDefaultShipConfig(var_2_2[arg_3_1].id).id

			var_3(var_3_1, var_3_2)

			setActive = var_3

			local var_3_3 = arg_3_2:Find("IconTpl/mask")
			local var_3_4 = var_2_2[arg_3_1]

			var_3(var_3_3, var_6.isUnlock(var_3_4))

			setText = var_3

			local var_3_5 = arg_3_2:Find("IconTpl/mask/Text")

			i18n = var_6

			var_3(var_3_5, var_6("tech_select_tip3"))
		end

		return
	end)
	var_5:align(#var_2_2)

	local var_2_16 = var_2_1
	local var_2_17 = var_2_1.getConfig(var_2_16, "display_icon")

	setText = var_2_13

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_9.Find(var_2_18, "content_after/title/bg/Text")

	i18n = var_2_14

	var_2_13(var_2_19, var_2_14("tech_select_tip4"))

	setText = var_2_13

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_9.Find(var_2_20, "content_after/title/Text")

	i18n = var_10

	var_2_13(var_2_21, var_10("tech_select_tip5"))

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_7.Find(var_2_22, "content_after/list")

	UIItemList = var_2_16

	local var_2_24 = var_2_16.New(var_2_23, var_2_23:GetChild(0))

	var_8.make(var_2_24, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			unpack = var_3

			local var_4_0, var_4_1, var_4_2 = var_3(var_2_17[arg_4_1])

			updateDrop = var_2_10006

			var_2_10006(arg_4_2:Find("IconTpl"), {
				type = var_4_0,
				id = var_4_1,
				count = var_4_2
			})
		end

		return
	end)
	var_8:align(#var_2_17)

	return
end

return var_0_1
