class = var_0_10000

local var_0_0 = "IslandMsgBoxSingleMaterialWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandMsgBoxSingleItemWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxWithSingleMaterial"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.itemTr = var_1.Find(var_2_0, "IslandItemTpl")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "name")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "own")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.ownTxt = var_2_6(var_2_5, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_7 = var_1.New
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "list")
	local var_2_10 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_7(var_2_9, var_3.Find(var_2_10, "list/tpl"))
	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "label/Text")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("island_get_way"))

	local var_2_13 = arg_2_0._tf

	arg_2_0.valueInput = var_1.Find(var_2_13, "calc/value/InputField")

	local var_2_14 = arg_2_0._tf

	arg_2_0.addBtn = var_1.Find(var_2_14, "calc/add")

	local var_2_15 = arg_2_0._tf

	arg_2_0.reduceBtn = var_1.Find(var_2_15, "calc/reduce")

	local var_2_16 = arg_2_0._tf

	arg_2_0.sellBtn = var_1.Find(var_2_16, "calc/sell_btn")

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "calc/sell_btn/price/Text")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.priceTxt = var_2_19(var_2_18, var_3(var_4))
	LoadImageSpriteAsync = var_1

	local var_2_20 = "island/"

	getIslandSeasonPtInfo = var_3

	local var_2_21 = var_2_20 .. var_3().icon
	local var_2_22 = arg_2_0._tf

	var_1(var_2_21, var_3.Find(var_2_22, "calc/sell_btn/price/res"))

	setText = var_1

	local var_2_23 = arg_2_0._tf
	local var_2_24 = var_2.Find(var_2_23, "calc/sell_btn/Text")

	i18n = var_2_23

	var_1(var_2_24, var_2_23("island_word_convert"))

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)

	setActive = var_1

	local var_3_0 = arg_3_0._tf

	var_1(var_2.Find(var_3_0, "label"), false)

	local var_3_1 = arg_3_0.settings

	onButton = var_2

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.addBtn

	local function var_3_4()
		local var_4_0 = arg_3_0.value + 1
		local var_4_1 = arg_3_0

		var_1.UpdateValue(var_4_1, var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_2, var_3_3, var_3_4, var_1_10006)

	onButton = var_2

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.reduceBtn

	local function var_3_7()
		local var_5_0 = arg_3_0.value - 1
		local var_5_1 = arg_3_0

		var_1.UpdateValue(var_5_1, var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_5, var_3_6, var_3_7, var_1_10006)

	onButton = var_2

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.sellBtn

	local function var_3_10()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		_IslandCore = var_0

		if var_0 then
			_IslandCore = var_0

			local var_6_1 = var_0:GetView()
			local var_6_2 = var_0.NotifiyIsland

			ISLAND_EX_EVT = var_2_10002

			local var_6_3 = var_2_10002.SHOW_MSG
			local var_6_4 = {}

			i18n = var_2_10004
			var_6_4.content = var_2_10004("island_season_window_transformtip")

			function var_6_4.onYes()
				local var_7_0 = arg_3_0
				local var_7_1 = var_0.emit

				IslandMediator = var_3_10002

				var_7_1(var_7_0, var_3_10002.ON_CONVERT_SEASON_PT, {
					{
						id = arg_3_0.item.id,
						num = arg_3_0.value
					}
				})

				return
			end

			var_6_2(var_6_1, var_6_3, var_6_4)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_8, var_3_9, var_3_10, var_1_10006)

	onInputEndEdit = var_2

	var_2(arg_3_0, arg_3_0.valueInput, function(arg_8_0)
		local var_8_0 = 0

		if arg_8_0 and arg_8_0 ~= "" then
			tonumber = var_2_10002

			if not var_2_10002(arg_8_0) then
				local var_8_1 = 1
			end

			tonumber = var_2_10002

			local var_8_2 = var_2_10002(arg_8_0)
			local var_8_3 = arg_3_0

			var_2.UpdateValue(var_8_3, var_8_2)

			return
		end
	end)

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.bind

	GAME = var_4

	var_3_12(var_3_11, var_4.ISLAND_CONVERT_SEASON_PT_DONE, function()
		local var_9_0 = arg_3_0

		var_0.FlushCalc(var_9_0, arg_3_0.item.id)

		return
	end)

	local var_3_13 = var_3_1.itemId

	arg_3_0:FlushCalc(var_3_13)

	return
end

function var_0_1.FlushCalc(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_10_0 = var_1_10002(var_1_10003)
	local var_10_1 = var_2.GetIsland(var_10_0)
	local var_10_2 = var_2.GetInventoryAgency(var_10_1)
	local var_10_3

	if not var_2.GetItemById(var_10_2, arg_10_1) then
		IslandItem = var_10_3
		var_10_3 = var_10_3.New({
			id = arg_10_1
		})
	end

	arg_10_0.item = var_10_3
	arg_10_0.value = 1

	arg_10_0:UpdateValue(arg_10_0.value)

	return
end

function var_0_1.UpdateValue(arg_11_0, arg_11_1)
	math = var_1_10002

	local var_11_0 = var_1_10002.max
	local var_11_1 = 1

	math = var_1_10004

	local var_11_2 = var_1_10004.min
	local var_11_3 = arg_11_1
	local var_11_4 = arg_11_0.item

	arg_11_0.value = var_11_0(var_11_1, var_11_2(var_11_3, var_6.GetCount(var_11_4)))

	local var_11_5 = arg_11_0.priceTxt
	local var_11_6 = "x"
	local var_11_7 = arg_11_0.item

	var_11_5.text = var_11_6 .. var_4.GetConvertPt(var_11_7) * arg_11_0.value
	setInputText = var_11_5

	var_11_5(arg_11_0.valueInput, arg_11_0.value)

	return
end

return var_0_1
