class = var_0_10000

local var_0_0 = "IslandShopBuySuccessLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShopBuySuccessUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "awards")
	local var_2_3 = arg_2_0._tf

	arg_2_0.awardList = var_2_0(var_2_2, var_3.Find(var_2_3, "awards/item"))
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "tip/text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("island_3Dshop_close"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "award_window")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "tip")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	return
end

function var_0_1.SetUp(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.awardList

	var_2.make(var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_6_1[arg_7_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_7_2:Find("IslandItemTpl"), var_7_0, {
				style = "island"
			})

			setActive = var_4

			local var_7_1 = arg_7_2:Find("split")
			local var_7_2 = var_7_0.type

			VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_7

			var_4(var_7_1, var_7_2 == var_7)
		end

		return
	end)

	local var_6_1 = arg_6_0.awardList

	var_2.align(var_6_1, #arg_6_1)

	return
end

function var_0_1.OnShow(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:BlurPanel(arg_8_0._tf)

	table = var_3

	local var_8_0 = var_3.mergeArray
	local var_8_1

	if not arg_8_1.awards then
		var_8_1 = {}
	end

	local var_8_2

	if not arg_8_1.drops then
		var_8_2 = {}
	end

	local var_8_3 = var_8_0(var_8_1, var_8_2)

	table = var_8_1

	local var_8_4 = var_8_1.sort
	local var_8_5 = var_8_3

	CompareFuncs = var_1_10006

	var_8_4(var_8_5, var_1_10006({
		function(arg_9_0)
			local var_9_0 = arg_9_0.type

			VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_2_10002

			return var_9_0 == var_2_10002 and 0 or 1
		end
	}))
	arg_8_0:SetUp(var_8_3)

	arg_8_0.callback = arg_8_2
	arg_8_0.active = true

	return
end

function var_0_1.OnHide(arg_10_0)
	arg_10_0:UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	if arg_10_0.active then
		arg_10_0.active = false

		if arg_10_0.callback then
			arg_10_0.callback()
		end
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
