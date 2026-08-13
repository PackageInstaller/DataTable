class = var_0_10000

local var_0_0 = "AnniversaryIslandComposite2023Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

bit = var_0_0
var_0_1.FilterAll = var_0_0.bor(1, 2)

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	AutoLoader = var_1
	arg_1_0.loader = var_1.New()

	return
end

function var_0_1.getUIName(arg_2_0)
	return "AnniversaryIslandComposite2023UI"
end

local var_0_2 = "ui/AnniversaryIslandComposite2023UI_atlas"
local var_0_3 = "ui/AtelierCommonUI_atlas"

function var_0_1.preload(arg_3_0, arg_3_1)
	table = var_1_10002

	var_1_10002.ParallelIpairsAsync({
		var_0_2,
		var_0_3
	}, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_3_0.loader

		var_3.LoadBundle(var_4_0, arg_4_1, arg_4_2)

		return
	end, arg_3_1)

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.layerFormulaList = var_1.Find(var_5_0, "Panel/FormulaList")

	local var_5_1 = arg_5_0._tf

	arg_5_0.layerFormulaDetail = var_1.Find(var_5_1, "Panel/FormulaDetail")

	local var_5_2 = arg_5_0._tf

	arg_5_0.top = var_1.Find(var_5_2, "Top")

	local var_5_3 = arg_5_0.layerFormulaList
	local var_5_4 = var_1.Find(var_5_3, "ScrollView")

	arg_5_0.formulaRect = var_1.GetComponent(var_5_4, "LScrollRect")

	local var_5_5 = arg_5_0.layerFormulaList
	local var_5_6 = var_1.Find(var_5_5, "Item")

	setActive = var_5_5

	var_5_5(var_5_6, false)

	local var_5_7 = arg_5_0.formulaRect

	function var_5_7.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0

		var_2.UpdateFormulaListItem(var_6_0, arg_6_0 + 1, arg_6_1)

		return
	end

	_ = var_5_7
	arg_5_0.formulaFilterButtons = var_5_7.map({
		1,
		2
	}, function(arg_7_0)
		local var_7_0 = arg_5_0.layerFormulaList
		local var_7_1 = var_1.Find(var_7_0, "Tabs")

		return var_1.GetChild(var_7_1, arg_7_0 - 1)
	end)
	arg_5_0.lastEnv = nil
	arg_5_0.env = {}
	arg_5_0.listeners = {}
	setText = var_2

	local var_5_8 = arg_5_0.layerFormulaList
	local var_5_9 = var_3.Find(var_5_8, "Empty")

	i18n = var_5_8

	var_2(var_5_9, var_5_8("workbench_tips5"))

	setText = var_2

	local var_5_10 = arg_5_0.layerFormulaList
	local var_5_11 = var_3.Find(var_5_10, "Tabs/Furniture/UnSelected/Text")

	i18n = var_5_10

	var_2(var_5_11, var_5_10("word_furniture"))

	setText = var_2

	local var_5_12 = arg_5_0.layerFormulaList
	local var_5_13 = var_3.Find(var_5_12, "Tabs/Furniture/Selected/Text")

	i18n = var_5_12

	var_2(var_5_13, var_5_12("word_furniture"))

	setText = var_2

	local var_5_14 = arg_5_0.layerFormulaList
	local var_5_15 = var_3.Find(var_5_14, "Tabs/Item/UnSelected/Text")

	i18n = var_5_14

	var_2(var_5_15, var_5_14("workbench_tips7"))

	setText = var_2

	local var_5_16 = arg_5_0.layerFormulaList
	local var_5_17 = var_3.Find(var_5_16, "Tabs/Item/Selected/Text")

	i18n = var_5_16

	var_2(var_5_17, var_5_16("workbench_tips7"))

	setText = var_2

	local var_5_18 = arg_5_0.layerFormulaList
	local var_5_19 = var_3.Find(var_5_18, "Filter/Text")

	i18n = var_5_18

	var_2(var_5_19, var_5_18("workbench_tips10"))

	setText = var_2

	local var_5_20 = arg_5_0.layerFormulaDetail
	local var_5_21 = var_3.Find(var_5_20, "Counters/Text")

	i18n = var_5_20

	var_2(var_5_21, var_5_20("workbench_tips8"))

	setText = var_2

	local var_5_22 = arg_5_0.layerFormulaDetail
	local var_5_23 = var_3.Find(var_5_22, "MaterialsBG/MaterialsTitle")

	i18n = var_5_22

	var_2(var_5_23, var_5_22("workbench_tips9"))

	return
end

function var_0_1.didEnter(arg_8_0)
	local var_8_0 = arg_8_0.contextData
	local var_8_1

	if not arg_8_0.contextData.filterType then
		var_8_1 = var_0_1.FilterAll
	end

	var_8_0.filterType = var_8_1
	table = var_8_0

	var_8_0.Foreach(arg_8_0.formulaFilterButtons, function(arg_9_0, arg_9_1)
		onButton = var_2_10002

		local var_9_0 = arg_8_0
		local var_9_1 = arg_9_1

		local function var_9_2()
			bit = var_3_10000

			local var_10_0 = var_3_10000.lshift(1, arg_9_0 - 1)

			if arg_8_0.contextData.filterType == var_0_1.FilterAll then
				arg_8_0.contextData.filterType = var_10_0
			elseif arg_8_0.contextData.filterType == var_10_0 then
				arg_8_0.contextData.filterType = var_0_1.FilterAll
			else
				arg_8_0.contextData.filterType = var_10_0
			end

			local var_10_1 = arg_8_0

			var_1.UpdateFilterButtons(var_10_1)

			local var_10_2 = arg_8_0

			var_1.FilterFormulas(var_10_2)

			local var_10_3 = arg_8_0

			var_1.UpdateView(var_10_3)

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10002(var_9_0, var_9_1, var_9_2, var_2_10006)

		return
	end)

	PlayerPrefs = var_1
	arg_8_0.showOnlyComposite = var_1.GetInt("workbench_show_composite_avaliable", 0) == 1
	triggerToggle = var_1

	local var_8_2 = arg_8_0.layerFormulaList

	var_1(var_2.Find(var_8_2, "Filter/Toggle"), arg_8_0.showOnlyComposite)

	onToggle = var_1

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.layerFormulaList

	var_1(var_8_3, var_3.Find(var_8_4, "Filter/Toggle"), function(arg_11_0)
		local var_11_0 = arg_8_0

		var_11_0.showOnlyComposite = arg_11_0
		PlayerPrefs = var_11_0

		var_11_0.SetInt("workbench_show_composite_avaliable", arg_11_0 and 1 or 0)

		PlayerPrefs = var_1

		var_1.Save()

		local var_11_1 = arg_8_0

		var_1.FilterFormulas(var_11_1)

		local var_11_2 = arg_8_0

		var_1.UpdateView(var_11_2)

		return
	end)

	onButton = var_1

	local var_8_5 = arg_8_0
	local var_8_6 = arg_8_0._tf

	var_1(var_8_5, var_3.Find(var_8_6, "BG"), function()
		local var_12_0 = arg_8_0

		var_0.onBackPressed(var_12_0)

		return
	end)

	onButton = var_1

	local var_8_7 = arg_8_0
	local var_8_8 = arg_8_0._tf
	local var_8_9 = var_3.Find(var_8_8, "Top/Back")

	local function var_8_10()
		local var_13_0 = arg_8_0

		var_0.onBackPressed(var_13_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_8_7, var_8_9, var_8_10, var_5)

	onButton = var_1

	local var_8_11 = arg_8_0
	local var_8_12 = arg_8_0._tf
	local var_8_13 = var_3.Find(var_8_12, "Top/Home")

	local function var_8_14()
		local var_14_0 = arg_8_0

		var_0.quickExitFunc(var_14_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_8_11, var_8_13, var_8_14, var_5)

	onButton = var_1

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0._tf
	local var_8_17 = var_3.Find(var_8_16, "Top/Help")

	local function var_8_18()
		pg = var_2_10000

		local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_15_2.type = var_2_10003
		i18n = var_2_10003
		var_15_2.helps = var_2_10003("workbench_help")

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_8_15, var_8_17, var_8_18, var_5)

	onButton = var_1

	local var_8_19 = arg_8_0
	local var_8_20 = arg_8_0._tf
	local var_8_21 = var_3.Find(var_8_20, "Top/Upgrade")

	local function var_8_22()
		local var_16_0 = arg_8_0
		local var_16_1 = var_0.emit

		AnniversaryIslandComposite2023Mediator = var_2_10002

		var_16_1(var_16_0, var_2_10002.OPEN_UPGRADE_PANEL)

		return
	end

	SFX_PANEL = var_5

	var_1(var_8_19, var_8_21, var_8_22, var_5)

	onButton = var_1

	local var_8_23 = arg_8_0
	local var_8_24 = arg_8_0._tf
	local var_8_25 = var_3.Find(var_8_24, "Top/StoreHouse")

	local function var_8_26()
		local var_17_0 = arg_8_0
		local var_17_1 = var_0.emit

		AnniversaryIslandComposite2023Mediator = var_2_10002

		var_17_1(var_17_0, var_2_10002.OPEN_STOREHOUSE)

		return
	end

	SFX_PANEL = var_5

	var_1(var_8_23, var_8_25, var_8_26, var_5)
	arg_8_0:BindEnv({
		"filterFormulas",
		"formulas",
		"bagAct",
		"formulaId"
	}, function()
		local var_18_0 = arg_8_0

		var_0.UpdateFormulaList(var_18_0)

		return
	end)
	arg_8_0:BindEnv({
		"formulaId",
		"formulas",
		"bagAct"
	}, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0[1]
		local var_19_1 = arg_8_0

		var_3.UpdateFormulaDetail(var_19_1, var_19_0)

		return
	end)
	arg_8_0:BindEnv({
		"BuildingLv"
	}, function(arg_20_0)
		local var_20_0 = arg_20_0[1]
		local var_20_1 = arg_8_0.loader
		local var_20_2 = var_2.GetSpriteQuiet
		local var_20_3 = "ui/AnniversaryIslandComposite2023UI_atlas"
		local var_20_4 = "title_" .. var_20_0
		local var_20_5 = arg_8_0.top

		var_20_2(var_20_1, var_20_3, var_20_4, var_6.Find(var_20_5, "Title/Number"))

		return
	end)
	arg_8_0:BindEnv({
		"tip"
	}, function(arg_21_0)
		setActive = var_2_10001

		local var_21_0 = arg_8_0._tf

		var_2_10001(var_2.Find(var_21_0, "Top/Upgrade/Tip"), arg_21_0[1])

		return
	end)

	arg_8_0.env.formulaId = arg_8_0.contextData.formulaId

	arg_8_0:UpdateFilterButtons()
	arg_8_0:BuildActivityEnv()
	arg_8_0:UpdateView()

	return
end

function var_0_1.InitCounter(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	math = var_1_10005
	arg_22_2[2] = var_1_10005.max(arg_22_2[1], arg_22_2[2])

	local var_22_0 = arg_22_1
	local var_22_1 = arg_22_0.layerFormulaDetail
	local var_22_2 = var_6.Find(var_22_1, "Counters")

	assert = var_22_1

	var_22_1(var_22_2)
	;(function()
		local var_23_0 = var_22_0

		if var_22_0 == 0 then
			setColorStr = var_1
			var_23_0 = var_1(var_23_0, "#f9c461")
		end

		setText = var_1

		local var_23_1 = var_22_2

		var_1(var_2.Find(var_23_1, "Number"), var_23_0)
		arg_22_3(var_22_0)

		return
	end)()

	pressPersistTrigger = var_8

	local var_22_3 = var_22_2:Find("Plus")
	local var_22_4 = 0.5

	local function var_22_5(arg_24_0)
		local var_24_0 = var_22_0

		var_22_0 = var_22_0 + 1
		math = var_2
		var_22_0 = var_2.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_24_0 == var_22_0 then
			pg = var_2

			local var_24_1 = var_2.TipsMgr.GetInstance()
			local var_24_2 = var_2.ShowTips

			i18n = var_4

			var_24_2(var_24_1, var_4("workbench_tips3"))
			arg_24_0()

			return
		end

		var_0()

		return
	end

	local var_22_6
	local var_22_7 = true
	local var_22_8 = true
	local var_22_9 = 0.1

	SFX_PANEL = var_1_10016

	var_8(var_22_3, var_22_4, var_22_5, var_22_6, var_22_7, var_22_8, var_22_9, var_1_10016)

	pressPersistTrigger = var_8

	local var_22_10 = var_22_2:Find("Minus")
	local var_22_11 = 0.5

	local function var_22_12(arg_25_0)
		local var_25_0 = var_22_0

		var_22_0 = var_22_0 - 1
		math = var_2
		var_22_0 = var_2.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_25_0 == var_22_0 then
			arg_25_0()

			return
		end

		var_0()

		return
	end

	local var_22_13
	local var_22_14 = true
	local var_22_15 = true
	local var_22_16 = 0.1

	SFX_PANEL = var_1_10016

	var_8(var_22_10, var_22_11, var_22_12, var_22_13, var_22_14, var_22_15, var_22_16, var_1_10016)

	onButton = var_8

	var_8(arg_22_0, var_22_2:Find("Plus10"), function()
		local var_26_0 = var_22_0

		var_22_0 = var_22_0 + 10
		math = var_1
		var_22_0 = var_1.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		if var_26_0 == var_22_0 then
			pg = var_1

			local var_26_1 = var_1.TipsMgr.GetInstance()
			local var_26_2 = var_1.ShowTips

			i18n = var_3

			var_26_2(var_26_1, var_3("workbench_tips3"))

			return
		end

		var_0()

		return
	end)

	onButton = var_8

	var_8(arg_22_0, var_22_2:Find("Minus10"), function()
		var_22_0 = var_22_0 - 10
		math = var_0
		var_22_0 = var_0.clamp(var_22_0, arg_22_2[1], arg_22_2[2])

		var_0()

		return
	end)

	onButton = var_8

	local var_22_17 = arg_22_0
	local var_22_18 = arg_22_0.layerFormulaDetail
	local var_22_19 = var_10.Find(var_22_18, "Composite")

	local function var_22_20()
		existCall = var_2_10000

		var_2_10000(arg_22_4, var_22_0)

		return
	end

	SFX_PANEL = var_12

	var_8(var_22_17, var_22_19, var_22_20, var_12)

	return
end

local var_0_4 = {}

DROP_TYPE_FURNITURE = var_0_10004
var_0_4[var_0_10004] = "word_furniture"
DROP_TYPE_WORKBENCH_DROP = var_0_10004
var_0_4[var_0_10004] = "workbench_tips7"

function var_0_1.UpdateFormulaListItem(arg_29_0, arg_29_1, arg_29_2)
	tf = var_1_10003

	local var_29_0 = var_1_10003(arg_29_2)
	local var_29_1 = arg_29_0.env.filterFormulas[arg_29_1]
	local var_29_2 = var_4.GetProduction(var_29_1)
	local var_29_3 = var_29_0
	local var_29_4 = var_29_0.Find(var_29_3, "BG/Icon")

	assert = var_29_3

	var_29_3(var_29_4)
	arg_29_0:UpdateActivityDrop(var_29_4, {
		type = var_29_2[1],
		id = var_29_2[2]
	}, true)

	local var_29_5 = var_0_4[var_29_2[1]]
	local var_29_6 = var_4
	local var_29_7 = not var_4.IsUnlock(var_29_6)

	setActive = var_29_6

	var_29_6(var_29_0:Find("Lock"), var_29_7)

	setActive = var_29_6

	var_29_6(var_29_0:Find("BG"), not var_29_7)

	if var_29_7 then
		setText = var_29_6

		var_29_6(var_29_0:Find("Lock/Text"), var_4:GetLockDesc())
	end

	setText = var_29_6

	local var_29_8 = var_29_0
	local var_29_9 = var_29_0.Find(var_29_8, "BG/Type")

	i18n = var_29_8

	var_29_6(var_29_9, var_29_8(var_29_5))

	setScrollText = var_29_6

	var_29_6(var_29_0:Find("BG/Name/Text"), var_4:GetName())

	setActive = var_29_6

	var_29_6(var_29_0:Find("Selected"), var_4:GetConfigID() == arg_29_0.env.formulaId)

	local var_29_10 = var_4
	local var_29_11 = var_4.IsAvaliable(var_29_10)

	setActive = var_29_10

	var_29_10(var_29_0:Find("Completed"), not var_29_11)

	local var_29_12

	if var_4:GetMaxLimit() > 0 then
		if var_4:GetMaxLimit() - var_4:GetUsedCount() <= 0 then
			setColorStr = var_12

			local var_29_13

			if not var_12(var_11, "#bb6754") then
				var_29_13 = var_11
			end

			local var_29_14 = "/"

			var_1_10015 = var_4
			var_29_12 = var_29_13 .. var_29_14 .. var_4.GetMaxLimit(var_1_10015)

			if false then
				var_29_12 = "∞"
			end

			setText = var_11

			var_11(var_29_0:Find("BG/Count"), var_29_12)

			onButton = var_11

			local var_29_15 = arg_29_0
			local var_29_16 = var_29_0

			local function var_29_17()
				if not var_29_11 then
					pg = var_0

					local var_30_0 = var_0.TipsMgr.GetInstance()
					local var_30_1 = var_0.ShowTips

					i18n = var_2_10002

					var_30_1(var_30_0, var_2_10002("workbench_tips1"))

					return
				end

				if var_29_7 then
					local var_30_2 = var_0
					local var_30_3 = var_0.GetLockLimit(var_30_2)

					pg = var_30_2

					local var_30_4 = var_30_2.TipsMgr.GetInstance()
					local var_30_5 = var_1.ShowTips

					i18n = var_2_10003

					var_30_5(var_30_4, var_2_10003("workbench_tips4", var_30_3 and var_30_3[3]))

					return
				end

				local var_30_6 = arg_29_0.env
				local var_30_7 = var_0

				var_30_6.formulaId = var_1.GetConfigID(var_30_7)

				local var_30_8 = arg_29_0

				var_0.UpdateView(var_30_8)

				return
			end

			SFX_PANEL = var_1_10015

			var_11(var_29_15, var_29_16, var_29_17, var_1_10015)

			return
		end
	end
end

function var_0_1.UpdateFilterButtons(arg_31_0)
	table = var_1_10001

	var_1_10001.Foreach(arg_31_0.formulaFilterButtons, function(arg_32_0, arg_32_1)
		local var_32_0, var_32_2

		if arg_31_0.contextData.filterType ~= var_0_1.FilterAll then
			bit = var_32_0
			var_32_0 = var_32_0.band

			local var_32_1 = arg_31_0.contextData.filterType

			bit = var_2_10005
			var_32_2 = var_32_0(var_32_1, var_2_10005.lshift(1, arg_32_0 - 1)) > 0
		end

		setActive = var_32_0

		var_32_0(arg_32_1:Find("Selected"), var_32_2)

		setActive = var_32_0

		var_32_0(arg_32_1:Find("UnSelected"), not var_32_2)

		return
	end)

	return
end

function var_0_1.BuildActivityEnv(arg_33_0)
	local var_33_0 = arg_33_0.env

	_ = var_1_10002

	local var_33_1 = var_1_10002.map

	pg = var_1_10003
	var_33_0.formulas = var_33_1(var_1_10003.activity_workbench_recipe.all, function(arg_34_0)
		WorkBenchFormula = var_2_10001

		local var_34_0 = var_2_10001.New({
			configId = arg_34_0
		})

		var_1.BuildFromActivity(var_34_0)

		return var_1
	end)

	if arg_33_0.env.formulaId then
		_ = var_1

		if var_1.detect(arg_33_0.env.formulas, function(arg_35_0)
			return arg_35_0:GetConfigID() == arg_33_0.env.formulaId
		end) then
			local var_33_2 = var_1
			local var_33_3

			if not var_1.IsAvaliable(var_33_2) then
				var_33_3 = arg_33_0.env
				var_33_3.formulaId = nil
			end

			getProxy = var_1
			ActivityProxy = var_33_3

			local var_33_4 = var_1(var_33_3)
			local var_33_5 = var_1.getActivityByType

			ActivityConst = var_33_2

			local var_33_6

			var_33_6.bagAct, var_33_6 = var_33_5(var_33_4, var_33_2.ACTIVITY_TYPE_VIRTUAL_BAG), arg_33_0.env
			getProxy = var_33_6
			ActivityProxy = var_3

			local var_33_7 = var_33_6(var_3)
			local var_33_8 = var_2.getActivityByType

			ActivityConst = var_4

			local var_33_9 = var_33_8(var_33_7, var_4.ACTIVITY_TYPE_BUILDING_BUFF_2)
			local var_33_10 = arg_33_0.env
			local var_33_11 = var_33_9
			local var_33_12 = var_33_9.GetBuildingLevel

			table = var_1_10006

			local var_33_13 = var_1_10006.keyof

			AnniversaryIsland2023Scene = var_1_10007
			var_33_10.BuildingLv = var_33_12(var_33_11, var_33_13(var_1_10007.Buildings, "craft"))

			local var_33_14 = arg_33_0.env

			AnniversaryIsland2023Scene = var_4

			local var_33_15 = var_4.UpdateBuildingTip
			local var_33_16
			local var_33_17 = var_33_9

			table = var_7

			local var_33_18 = var_7.keyof

			AnniversaryIsland2023Scene = var_8
			var_33_14.tip = var_33_15(var_33_16, var_33_17, var_33_18(var_8.Buildings, "craft"))

			arg_33_0:FilterFormulas()

			return
		end
	end
end

function var_0_1.FilterFormulas(arg_36_0)
	local var_36_0 = {}
	local var_36_1 = arg_36_0.contextData.filterType

	local function var_36_2(arg_37_0)
		if var_36_1 == var_0_1.FilterAll then
			return true
		end

		switch = var_1

		local var_37_0 = arg_37_0:GetProduction()[1]
		local var_37_1 = {}

		DROP_TYPE_WORKBENCH_DROP = var_2_10004
		var_37_1[var_2_10004] = function()
			bit = var_3_10000

			return var_3_10000.band(var_36_1, 1) > 0
		end

		return var_1(var_37_0, var_37_1, function()
			bit = var_3_10000

			return var_3_10000.band(var_36_1, 2) > 0
		end)
	end

	ipairs = var_1_10004
	_ = var_1_10005

	for iter_36_0, iter_36_1 in var_1_10004(var_1_10005.values(arg_36_0.env.formulas)) do
		if var_36_2(iter_36_1) then
			if arg_36_0.showOnlyComposite then
				if iter_36_1:IsUnlock() and iter_36_1:IsAvaliable() then
					_ = var_9

					if var_9.all(iter_36_1:GetMaterials(), function(arg_40_0)
						local var_40_0 = arg_40_0[1]
						local var_40_1 = arg_40_0[2]
						local var_40_2 = arg_40_0[3]
						local var_40_3 = arg_36_0.env.bagAct

						return var_40_2 <= var_4.getVitemNumber(var_40_3, var_40_1)
					end) then
						table = var_9

						var_9.insert(var_36_0, iter_36_1)
					end
				end
			end
		end
	end

	CompareFuncs = var_4

	local var_36_3 = var_4({
		function(arg_41_0)
			return arg_41_0:IsAvaliable() and 0 or 1
		end,
		function(arg_42_0)
			return arg_42_0:IsUnlock() and 0 or 1
		end,
		function(arg_43_0)
			return arg_43_0:GetConfigID()
		end
	})

	table = var_5

	var_5.sort(var_36_0, var_36_3)

	arg_36_0.env.filterFormulas = var_36_0

	return
end

function var_0_1.UpdateFormulaList(arg_44_0)
	local var_44_0 = #arg_44_0.env.filterFormulas == 0

	setActive = var_1_10002

	local var_44_1 = arg_44_0.layerFormulaList

	var_1_10002(var_3.Find(var_44_1, "Empty"), var_44_0)

	setActive = var_1_10002

	local var_44_2 = arg_44_0.layerFormulaList

	var_1_10002(var_3.Find(var_44_2, "ScrollView"), not var_44_0)

	local var_44_3 = arg_44_0.formulaRect

	var_2.SetTotalCount(var_44_3, #arg_44_0.env.filterFormulas)

	return
end

function var_0_1.UpdateFormulaDetail(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0.contextData

	var_45_0.formulaId = arg_45_1
	setActive = var_45_0

	var_45_0(arg_45_0.layerFormulaDetail, arg_45_1)

	if not arg_45_1 then
		return
	end

	_ = var_45_0

	local var_45_1 = var_45_0.detect(arg_45_0.env.formulas, function(arg_46_0)
		return arg_46_0:GetConfigID() == arg_45_1
	end)

	assert = var_3

	var_3(var_45_1)

	local var_45_2 = var_45_1:GetProduction()
	local var_45_3 = var_45_1:GetMaterials()
	local var_45_4 = 100

	;(function()
		local var_47_0 = {
			type = var_45_2[1],
			id = var_45_2[2],
			count = var_45_2[3]
		}

		getProxy = var_1
		ActivityProxy = var_2_10002

		local var_47_1 = var_1(var_2_10002)
		local var_47_2 = var_1.getActivityByType

		ActivityConst = var_2_10003

		local var_47_3 = var_47_2(var_47_1, var_2_10003.ACTIVITY_TYPE_WORKBENCH)
		local var_47_4 = var_45_1

		if var_2.GetMaxLimit(var_47_4) > 0 then
			var_45_4 = var_2 - var_47_3:GetFormulaUseCount(arg_45_1)
		end

		local var_47_5 = arg_45_0.layerFormulaDetail
		local var_47_6 = var_3.Find(var_47_5, "Icon")

		assert = var_47_5

		var_47_5(var_47_6)

		local var_47_7 = arg_45_0

		var_4.UpdateActivityDrop(var_47_7, var_47_6, var_47_0)

		onButton = var_4

		var_4(arg_45_0, var_47_6, function()
			local var_48_0 = var_47_0.type

			DROP_TYPE_WORKBENCH_DROP = var_3_10001

			if var_48_0 == var_3_10001 then
				local var_48_1 = arg_45_0
				local var_48_2 = var_0.emit

				WorkBenchItemDetailMediator = var_3_10002
				var_3_10002 = var_3_10002.SHOW_DETAIL
				WorkBenchItem = var_3_10003

				var_48_2(var_48_1, var_3_10002, var_3_10003.New({
					configId = var_47_0.id,
					count = var_47_0.count
				}))
			else
				local var_48_3 = arg_45_0
				local var_48_4 = var_0.emit

				BaseUI = var_3_10002

				var_48_4(var_48_3, var_3_10002.ON_DROP, var_47_0)
			end

			return
		end)

		setText = var_4

		local var_47_8 = arg_45_0.layerFormulaDetail

		var_4(var_5.Find(var_47_8, "Name"), var_47_0:getConfig("name"))

		return
	end)()

	local var_45_5 = var_45_4
	local var_45_6 = arg_45_0.env.bagAct

	UIItemList = var_1_10009

	local var_45_7 = var_1_10009.StaticAlign
	local var_45_8 = arg_45_0.layerFormulaDetail
	local var_45_9 = var_10.Find(var_45_8, "Materials")
	local var_45_10 = arg_45_0.layerFormulaDetail

	var_45_7(var_45_9, var_11.Find(var_45_10, "Materials/Item"), #var_45_3, function(arg_49_0, arg_49_1, arg_49_2)
		UIItemList = var_2_10003

		if arg_49_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_49_0 = var_45_3[arg_49_1 + 1]
		local var_49_1 = {
			type = var_49_0[1],
			id = var_49_0[2],
			count = var_49_0[3]
		}
		local var_49_2 = arg_45_0

		var_5.UpdateActivityDrop(var_49_2, arg_49_2:Find("Icon"), var_49_1)

		onButton = var_5

		var_5(arg_45_0, arg_49_2:Find("Icon"), function()
			local var_50_0 = var_49_1.type

			DROP_TYPE_WORKBENCH_DROP = var_3_10001

			if var_50_0 == var_3_10001 then
				local var_50_1 = arg_45_0
				local var_50_2 = var_0.emit

				WorkBenchItemDetailMediator = var_3_10002
				var_3_10002 = var_3_10002.SHOW_DETAIL
				WorkBenchItem = var_3_10003

				var_50_2(var_50_1, var_3_10002, var_3_10003.New({
					configId = var_49_1.id,
					count = var_49_1.count
				}))
			else
				local var_50_3 = arg_45_0
				local var_50_4 = var_0.emit

				BaseUI = var_3_10002

				var_50_4(var_50_3, var_3_10002.ON_DROP, var_49_1)
			end

			return
		end)

		local var_49_3 = var_49_0[2]
		local var_49_4 = var_49_0[3]
		local var_49_5 = var_45_6
		local var_49_6 = var_7.getVitemNumber(var_49_5, var_49_3)

		if 0 < var_49_4 then
			math = var_8

			local var_49_7 = var_8.min
			local var_49_8 = var_45_5

			math = var_2_10010
			var_45_5 = var_49_7(var_49_8, var_2_10010.floor(var_49_6 / var_49_4))
		end

		return
	end)

	local function var_45_11(arg_51_0)
		UIItemList = var_2_10001

		local var_51_0 = var_2_10001.StaticAlign
		local var_51_1 = arg_45_0.layerFormulaDetail
		local var_51_2 = var_2.Find(var_51_1, "Materials")
		local var_51_3 = arg_45_0.layerFormulaDetail

		var_51_0(var_51_2, var_3.Find(var_51_3, "Materials/Item"), #var_45_3, function(arg_52_0, arg_52_1, arg_52_2)
			UIItemList = var_3_10003

			if arg_52_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_52_0 = var_45_3[arg_52_1 + 1][2]
			local var_52_1 = var_3[3]
			local var_52_2 = var_45_6
			local var_52_3 = var_6.getVitemNumber(var_52_2, var_52_0)

			math = var_52_2
			arg_51_0 = var_52_2.max(arg_51_0, 1)

			local var_52_4 = var_52_1 * arg_51_0

			setColorStr = var_8

			local var_52_5 = var_8(var_52_3, var_52_3 < var_52_4 and "#bb6754" or "#6b5a48")

			setText = var_9

			var_9(arg_52_2:Find("Text"), var_52_5 .. "/" .. var_52_4)

			return
		end)

		return
	end

	math = var_45_9

	local var_45_12 = var_45_9.min(1, var_45_5)

	arg_45_0:InitCounter(var_45_12, {
		0,
		var_45_5
	}, var_45_11, function(arg_53_0)
		local var_53_0 = arg_45_0
		local var_53_1 = var_1.emit

		GAME = var_2_10003

		var_53_1(var_53_0, var_2_10003.WORKBENCH_COMPOSITE, arg_45_1, arg_53_0)

		return
	end)
	var_45_11(var_45_12)

	return
end

function var_0_1.BindEnv(arg_54_0, arg_54_1, arg_54_2)
	table = var_1_10003

	var_1_10003.insert(arg_54_0.listeners, {
		keys = arg_54_1,
		func = arg_54_2
	})

	return
end

function var_0_1.RefreshData(arg_55_0)
	local var_55_0

	if not arg_55_0.lastEnv then
		var_55_0 = {}
	end

	arg_55_0.lastEnv = var_55_0

	local var_55_1 = {}
	local var_55_2

	local function var_55_3(arg_56_0, arg_56_1)
		if var_55_1[arg_56_0] then
			return
		end

		var_55_1[arg_56_0] = arg_56_1

		local var_56_0

		if not var_55_2 then
			var_56_0 = {}
		end

		var_55_2 = var_56_0
		_ = var_56_0

		local var_56_1 = var_56_0.select(arg_55_0.listeners, function(arg_57_0)
			table = var_3_10001

			return var_3_10001.contains(arg_57_0.keys, arg_56_0)
		end)

		_ = var_3

		var_3.each(var_56_1, function(arg_58_0)
			var_55_2[arg_58_0] = true

			return
		end)

		return
	end

	pairs = var_1_10004

	for iter_55_0, iter_55_1 in var_1_10004(arg_55_0.env) do
		if iter_55_1 ~= arg_55_0.lastEnv[iter_55_0] then
			var_55_3(iter_55_0, iter_55_1)
		end
	end

	pairs = var_4

	for iter_55_2, iter_55_3 in var_4(arg_55_0.lastEnv) do
		if iter_55_3 ~= arg_55_0.env[iter_55_2] then
			var_55_3(iter_55_2, var_9)
		end
	end

	if var_55_2 then
		table = var_4

		var_4.Foreach(var_55_2, function(arg_59_0)
			table = var_2_10001

			local var_59_0 = var_2_10001.map(arg_59_0.keys, function(arg_60_0)
				return arg_55_0.env[arg_60_0]
			end)

			table = var_2

			local var_59_1 = var_2.map(arg_59_0.keys, function(arg_61_0)
				return arg_55_0.lastEnv[arg_61_0]
			end)

			arg_59_0.func(var_59_0, var_59_1)

			return
		end)
	end

	table = var_4
	arg_55_0.lastEnv = var_4.shallowCopy(arg_55_0.env)

	return
end

function var_0_1.UpdateView(arg_62_0)
	arg_62_0:RefreshData()

	AnniversaryIsland2023Scene = var_1

	var_1.PlayStory()

	return
end

function var_0_1.OnReceiveFormualRequest(arg_63_0, arg_63_1)
	arg_63_0.env.formulaId = arg_63_1

	arg_63_0:UpdateView()

	return
end

function var_0_1.UpdateActivityDrop(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	updateDrop = var_1_10004

	var_1_10004(arg_64_1, arg_64_2)

	SetCompomentEnabled = var_1_10004

	local var_64_0 = arg_64_1
	local var_64_1 = arg_64_1.Find(var_64_0, "icon_bg")

	typeof = var_64_0
	Image = var_7

	var_1_10004(var_64_1, var_64_0(var_7), false)

	setActive = var_1_10004

	var_1_10004(arg_64_1:Find("bg"), false)

	setActive = var_1_10004

	var_1_10004(arg_64_1:Find("icon_bg/frame"), false)

	setActive = var_1_10004

	var_1_10004(arg_64_1:Find("icon_bg/stars"), false)

	local var_64_2 = arg_64_2:getConfig("rarity")
	local var_64_3 = arg_64_2.type

	DROP_TYPE_EQUIP = var_6

	if var_64_3 ~= var_6 then
		local var_64_4 = arg_64_2.type

		DROP_TYPE_EQUIPMENT_SKIN = var_6

		if var_64_4 == var_6 then
			var_64_2 = var_64_2 - 1
		end

		local var_64_5 = "icon_frame_" .. var_64_2

		if arg_64_3 then
			var_64_5 = var_64_5 .. "_small"
		end

		local var_64_6 = arg_64_0.loader

		var_6.GetSpriteQuiet(var_64_6, var_0_3, var_64_5, arg_64_1)

		return
	end
end

function var_0_1.willExit(arg_65_0)
	local var_65_0 = arg_65_0.loader

	var_1.Clear(var_65_0)

	return
end

return var_0_1
