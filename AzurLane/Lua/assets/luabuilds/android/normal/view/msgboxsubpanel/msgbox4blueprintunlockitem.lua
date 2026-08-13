class = var_0_10000

local var_0_0 = "Msgbox4BlueprintUnlockItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "Msgbox4BlueprintUnlockItem"
end

function var_0_1.OnRefresh(arg_2_0, arg_2_1)
	rtf = var_1_10002

	local var_2_0 = var_1_10002(arg_2_0.viewParent._window)

	Vector2 = var_3
	var_2_0.sizeDelta = var_3(1010, 685)

	local var_2_1 = arg_2_1.item
	local var_2_2 = arg_2_1.blueprints

	updateDrop = var_4

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_5.Find(var_2_3, "IconTpl")
	local var_2_5 = {}

	DROP_TYPE_ITEM = var_7
	var_2_5.type = var_7
	var_2_5.id = var_2_1.id

	var_4(var_2_4, var_2_5)

	setText = var_4

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_5.Find(var_2_6, "content_unlock/title/bg/Text")

	i18n = var_2_6

	var_4(var_2_7, var_2_6("tech_select_tip1"))

	setText = var_4

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_5.Find(var_2_8, "content_unlock/title/Text")

	i18n = var_2_8

	var_4(var_2_9, var_2_8("tech_select_tip2"))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_4.Find(var_2_10, "content_unlock/mask/list")

	UIItemList = var_2_10

	local var_2_12 = var_2_10.New(var_2_11, var_2_11:GetChild(0))

	var_5.make(var_2_12, function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			updateDrop = var_3

			local var_3_0 = arg_3_2:Find("IconTpl")
			local var_3_1 = {}

			DROP_TYPE_SHIP = var_6
			var_3_1.type = var_6
			ShipGroup = var_6
			var_3_1.id = var_6.getDefaultShipConfig(var_2_2[arg_3_1].id).id

			var_3(var_3_0, var_3_1)

			setActive = var_3

			local var_3_2 = arg_3_2:Find("IconTpl/mask")
			local var_3_3 = var_2_2[arg_3_1]

			var_3(var_3_2, var_5.isUnlock(var_3_3))

			setText = var_3

			local var_3_4 = arg_3_2
			local var_3_5 = arg_3_2.Find(var_3_4, "IconTpl/mask/Text")

			i18n = var_3_4

			var_3(var_3_5, var_3_4("tech_select_tip3"))
		end

		return
	end)
	var_5:align(#var_2_2)

	local var_2_13 = var_2_1
	local var_2_14 = var_2_1.getConfig(var_2_13, "display_icon")

	setText = var_2_13

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_8.Find(var_2_15, "content_after/title/bg/Text")

	i18n = var_2_15

	var_2_13(var_2_16, var_2_15("tech_select_tip4"))

	setText = var_2_13

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_8.Find(var_2_17, "content_after/title/Text")

	i18n = var_2_17

	var_2_13(var_2_18, var_2_17("tech_select_tip5"))

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_7.Find(var_2_19, "content_after/list")

	UIItemList = var_2_19

	local var_2_21 = var_2_19.New(var_2_20, var_2_20:GetChild(0))

	var_8.make(var_2_21, function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			unpack = var_3

			local var_4_0, var_4_1, var_4_2 = var_3(var_2_14[arg_4_1])

			updateDrop = var_2_10006

			var_2_10006(arg_4_2:Find("IconTpl"), {
				type = var_4_0,
				id = var_4_1,
				count = var_4_2
			})
		end

		return
	end)
	var_8:align(#var_2_14)

	return
end

return var_0_1
