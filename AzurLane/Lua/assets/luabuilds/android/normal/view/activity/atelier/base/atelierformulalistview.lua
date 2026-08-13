class = var_0_10000

local var_0_0 = "AtelierFormulaListView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

bit = var_0_0
var_0_1.FilterAll = var_0_0.bor(1, 2, 4)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Frame/Item")

	setActive = var_2_0

	var_2_0(var_2_1, false)

	GetComponent = var_2_0

	local var_2_2 = arg_2_0._tf

	arg_2_0.formulaRect = var_2_0(var_3.Find(var_2_2, "Frame/ScrollView"), "LScrollRect")

	local var_2_3 = arg_2_0.formulaRect

	function var_2_3.onUpdateItem(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.UpdateFormulaItem(var_3_0, arg_3_0 + 1, arg_3_1)

		return
	end

	setActive = var_2_3

	var_2_3(arg_2_0._go, false)
	arg_2_0:InitCustom()

	return
end

function var_0_1.InitCustom(arg_4_0)
	_ = var_1_10001
	arg_4_0.formulaFilterButtons = var_1_10001.map({
		1,
		2,
		3
	}, function(arg_5_0)
		local var_5_0 = arg_4_0._tf
		local var_5_1 = var_1.Find(var_5_0, "Frame/Tabs")

		return var_1.GetChild(var_5_1, arg_5_0 - 1)
	end)
	setText = var_1

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_2.Find(var_4_0, "Frame/Empty")

	i18n = var_4_0

	var_1(var_4_1, var_4_0("ryza_tip_no_recipe"))

	setText = var_1

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_2.Find(var_4_2, "Frame/Filter/Text")

	i18n = var_4_2

	var_1(var_4_3, var_4_2("ryza_toggle_only_composite"))

	setText = var_1

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_2.Find(var_4_4, "Frame/Item/Lock/Text")

	i18n = var_4_4

	var_1(var_4_5, var_4_4("ryza_tip_unlock_all_tools"))

	setText = var_1

	local var_4_6 = arg_4_0._tf
	local var_4_7 = var_2.Find(var_4_6, "Bar/Text")

	i18n = var_4_6

	var_1(var_4_7, var_4_6("ryza_tip_select_recipe"))

	return
end

function var_0_1.SetContextData(arg_6_0, arg_6_1)
	arg_6_0.contextData = arg_6_1

	return
end

function var_0_1.SetActivity(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1

	return
end

function var_0_1.didEnter(arg_8_0)
	local var_8_0 = arg_8_0.contextData

	var_8_0.filterType = var_0_1.FilterAll
	pairs = var_8_0

	for iter_8_0, iter_8_1 in var_8_0(arg_8_0.formulaFilterButtons) do
		onButton = var_1_10006

		local var_8_1 = arg_8_0
		local var_8_2 = iter_8_1

		local function var_8_3()
			if arg_8_0.contextData.filterType == var_0_1.FilterAll then
				local var_9_0 = arg_8_0.contextData

				bit = var_1
				var_9_0.filterType = var_1.lshift(1, iter_8_0 - 1)
			else
				local var_9_1 = arg_8_0.contextData

				bit = var_1

				local var_9_2 = var_1.bxor
				local var_9_3 = arg_8_0.contextData.filterType

				bit = var_2_10003
				var_9_1.filterType = var_9_2(var_9_3, var_2_10003.lshift(1, iter_8_0 - 1))

				if arg_8_0.contextData.filterType == 0 then
					arg_8_0.contextData.filterType = var_0_1.FilterAll
				end
			end

			local var_9_4 = arg_8_0

			var_0.UpdateFilterButtons(var_9_4)

			local var_9_5 = arg_8_0

			var_0.FilterFormulas(var_9_5)

			local var_9_6 = arg_8_0

			var_0.UpdateFormulaList(var_9_6)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_8_1, var_8_2, var_8_3, var_1_10010)
	end

	onToggle = var_1

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0._tf

	var_1(var_8_4, var_3.Find(var_8_5, "Frame/Filter/Toggle"), function(arg_10_0)
		arg_8_0.showOnlyComposite = arg_10_0

		local var_10_0 = arg_8_0

		var_1.FilterFormulas(var_10_0)

		local var_10_1 = arg_8_0

		var_1.UpdateFormulaList(var_10_1)

		return
	end)

	return
end

function var_0_1.ShowFormulaList(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0._go, true)

	setParent = var_1_10001

	var_1_10001(arg_11_0._go, arg_11_0._parentClass.top)

	local var_11_0 = arg_11_0._tf

	var_1.SetSiblingIndex(var_11_0, 0)
	arg_11_0:UpdateFilterButtons()
	arg_11_0:FilterFormulas()
	arg_11_0:UpdateFormulaList()

	return
end

function var_0_1.UpdateFilterButtons(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.formulaFilterButtons) do
		local var_12_0, var_12_2

		if arg_12_0.contextData.filterType ~= var_0_1.FilterAll then
			bit = var_12_0
			var_12_0 = var_12_0.band

			local var_12_1 = arg_12_0.contextData.filterType

			bit = var_1_10009
			var_12_2 = var_12_0(var_12_1, var_1_10009.lshift(1, iter_12_0 - 1)) > 0
		end

		setActive = var_12_0
		var_1_10009 = iter_12_1

		var_12_0(iter_12_1.Find(var_1_10009, "Selected"), var_12_2)
	end

	return
end

local var_0_2 = {}

AtelierFormula = var_2
var_0_2[var_2.TYPE.EQUIP] = "ryza_word_equip"
AtelierFormula = var_2
var_0_2[var_2.TYPE.ITEM] = "word_item"
AtelierFormula = var_2
var_0_2[var_2.TYPE.TOOL] = "word_tool"
AtelierFormula = var_2
var_0_2[var_2.TYPE.OTHER] = "word_other"

function var_0_1.UpdateFormulaItem(arg_13_0, arg_13_1, arg_13_2)
	tf = var_1_10003

	local var_13_0 = var_1_10003(arg_13_2)
	local var_13_1 = arg_13_0.filterFormulas[arg_13_1]
	local var_13_2 = var_4.GetProduction(var_13_1)
	local var_13_3 = arg_13_0._parentClass

	var_6.UpdateRyzaDrop(var_13_3, var_13_0:Find("BG/Icon"), {
		type = var_13_2[1],
		id = var_13_2[2]
	}, true)

	local var_13_4 = var_0_2[var_4:GetType()]
	local var_13_5 = var_4
	local var_13_6 = var_4.GetType(var_13_5)

	AtelierFormula = var_13_5

	local var_13_7, var_13_8

	if var_13_6 ~= var_13_5.TYPE.TOOL then
		var_13_7 = arg_13_0.activity
		var_13_8 = not var_7.IsCompleteAllTools(var_13_7, var_4:getConfig("version"))
	else
		var_13_8 = false
	end

	if false then
		var_13_8 = true
	end

	setActive = var_13_7

	var_13_7(var_13_0:Find("Lock"), var_13_8)

	setActive = var_13_7

	var_13_7(var_13_0:Find("BG"), not var_13_8)

	setText = var_13_7

	local var_13_9 = var_13_0
	local var_13_10 = var_13_0.Find(var_13_9, "BG/Type")

	i18n = var_13_9

	var_13_7(var_13_10, var_13_9(var_13_4))

	setScrollText = var_13_7

	var_13_7(var_13_0:Find("BG/Name/Text"), var_4:GetName())

	local var_13_11

	if var_4:GetMaxLimit() > 0 then
		var_13_11 = var_4:GetMaxLimit() - var_4:GetUsedCount() .. "/" .. var_4:GetMaxLimit()
	else
		var_13_11 = "∞"
	end

	local var_13_12 = var_4
	local var_13_13 = var_4.IsAvaliable(var_13_12)

	setActive = var_13_12

	var_13_12(var_13_0:Find("BG/Count"), var_13_13)

	setActive = var_13_12

	var_13_12(var_13_0:Find("Completed"), not var_13_13)

	if var_13_13 then
		AtelierFormula = var_13_12
		var_13_12 = var_13_12.IsFormualCanComposite(var_4, arg_13_0.activity, arg_13_0.contextData.versionIndex)

		local var_13_14 = arg_13_0.contextData.versionIndex
		local var_13_15 = "ffffff"
		local var_13_16

		if var_13_14 and var_13_14 == 2 then
			SummerFeastScene = var_13_16
			var_13_16 = var_13_16.TransformColor
			var_1_10014 = var_13_12 and "62e587" or "f27878"
			var_13_15 = var_13_16(var_1_10014)
		else
			SummerFeastScene = var_13_16
			var_13_16 = var_13_16.TransformColor
			var_1_10014 = var_13_12 and "4fb3a3" or "d55a54"
			var_13_15 = var_13_16(var_1_10014)
		end

		setTextColor = var_13_16

		var_13_16(var_13_0:Find("BG/Count"), var_13_15)
	end

	setText = var_13_12

	var_13_12(var_13_0:Find("BG/Count"), var_13_11)

	onButton = var_13_12

	local var_13_17 = arg_13_0
	local var_13_18 = var_13_0

	local function var_13_19()
		if not var_13_13 then
			pg = var_0

			local var_14_0 = var_0.TipsMgr.GetInstance()
			local var_14_1 = var_0.ShowTips

			i18n = var_2_10002

			var_14_1(var_14_0, var_2_10002("ryza_tip_composite_invalid"))

			return
		end

		if var_13_8 then
			pg = var_0

			local var_14_2 = var_0.TipsMgr.GetInstance()
			local var_14_3 = var_0.ShowTips

			i18n = var_2_10002

			var_14_3(var_14_2, var_2_10002("ryza_tip_unlock_all_tools"))

			return
		end

		local var_14_4 = arg_13_0._parentClass

		var_0.OnClickFormula(var_14_4, var_0)

		return
	end

	SFX_PANEL = var_1_10014

	var_13_12(var_13_17, var_13_18, var_13_19, var_1_10014)

	return
end

function var_0_1.FilterFormulas(arg_15_0)
	arg_15_0.filterFormulas = {}

	local var_15_0 = arg_15_0.contextData.versionIndex

	pairs = var_1_10002

	local var_15_1 = arg_15_0.activity

	for iter_15_0, iter_15_1 in var_1_10002(var_3.GetFormulasByVersion(var_15_1, var_15_0)) do
		if arg_15_0:IsFormulaTypeFit(iter_15_1) then
			if arg_15_0.showOnlyComposite then
				if iter_15_1:IsAvaliable() then
					AtelierFormula = var_7

					if var_7.IsFormualCanComposite(iter_15_1, arg_15_0.activity, var_15_0) then
						table = var_7

						var_7.insert(arg_15_0.filterFormulas, iter_15_1)
					end
				end
			end
		end
	end

	table = var_2

	var_2.sort(arg_15_0.filterFormulas, function(arg_16_0, arg_16_1)
		local var_16_0 = {
			function(arg_17_0)
				return arg_17_0:IsAvaliable() and 0 or 1
			end,
			function(arg_18_0)
				local var_18_0 = arg_18_0
				local var_18_1 = arg_18_0.GetType(var_18_0)

				AtelierFormula = var_18_0

				if var_18_1 ~= var_18_0.TYPE.TOOL then
					local var_18_2 = arg_15_0.activity

					if not var_1.IsCompleteAllTools(var_18_2, arg_18_0:getConfig("version")) then
						do return 1 end

						goto label_18_0
					end
				end

				do return 0 end

				::label_18_0::

				return
			end,
			function(arg_19_0)
				return arg_19_0:GetConfigID()
			end
		}

		ipairs = var_3

		for iter_16_0, iter_16_1 in var_3(var_16_0) do
			if iter_16_1(arg_16_0) ~= iter_16_1(arg_16_1) then
				return var_8 < var_9
			end
		end

		return false
	end)

	return
end

function var_0_1.IsFormulaTypeFit(arg_20_0, arg_20_1)
	if arg_20_0.contextData.filterType == var_0_1.FilterAll then
		return true
	end

	switch = var_3

	local var_20_0 = arg_20_1:GetType()
	local var_20_1 = {}

	AtelierFormula = var_1_10006
	var_20_1[var_1_10006.TYPE.EQUIP] = function()
		bit = var_2_10000

		return var_2_10000.band(var_0, 1) > 0
	end
	AtelierFormula = var_6
	var_20_1[var_6.TYPE.ITEM] = function()
		bit = var_2_10000

		return var_2_10000.band(var_0, 2) > 0
	end
	AtelierFormula = var_6
	var_20_1[var_6.TYPE.TOOL] = function()
		bit = var_2_10000

		return var_2_10000.band(var_0, 4) > 0
	end
	AtelierFormula = var_6
	var_20_1[var_6.TYPE.OTHER] = function()
		bit = var_2_10000

		return var_2_10000.band(var_0, 4) > 0
	end

	return var_3(var_20_0, var_20_1)
end

function var_0_1.UpdateFormulaList(arg_25_0)
	local var_25_0 = #arg_25_0.filterFormulas == 0

	setActive = var_1_10003

	local var_25_1 = arg_25_0._tf

	var_1_10003(var_4.Find(var_25_1, "Frame/Empty"), var_25_0)

	setActive = var_1_10003

	local var_25_2 = arg_25_0._tf

	var_1_10003(var_4.Find(var_25_2, "Frame/ScrollView"), not var_25_0)

	local var_25_3 = arg_25_0.formulaRect

	var_3.SetTotalCount(var_25_3, var_1)

	return
end

function var_0_1.willExit(arg_26_0)
	arg_26_0:detach()

	return
end

return var_0_1
