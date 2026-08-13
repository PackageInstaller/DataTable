class = var_0_10000

local var_0_0 = "AtelierFormulaListYumiaView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.Atelier.base.AtelierFormulaListView"))

bit = var_0_0
var_0_1.FilterAll = var_0_0.bor(1)
var_0_1.FORMULA_TYPE = {
	EQUIP = 1,
	ITEM = 2
}

function var_0_1.InitCustom(arg_1_0)
	_ = var_1_10001
	arg_1_0.formulaFilterButtons = var_1_10001.map({
		1,
		2
	}, function(arg_2_0)
		local var_2_0 = arg_1_0._tf
		local var_2_1 = var_1.Find(var_2_0, "Frame/Tabs")

		return var_1.GetChild(var_2_1, arg_2_0 - 1)
	end)
	setText = var_1

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "Bar/Text")

	i18n = var_1_0

	var_1(var_1_1, var_1_0("yumia_atelier_tip5"))

	setText = var_1

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_2.Find(var_1_2, "Frame/Tabs/Equip/UnSelected/Text")

	i18n = var_1_2

	var_1(var_1_3, var_1_2("yumia_atelier_tip2"))

	setText = var_1

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_2.Find(var_1_4, "Frame/Tabs/Equip/Selected/Text")

	i18n = var_1_4

	var_1(var_1_5, var_1_4("yumia_atelier_tip2"))

	setText = var_1

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_2.Find(var_1_6, "Frame/Tabs/Item/UnSelected/Text")

	i18n = var_1_6

	var_1(var_1_7, var_1_6("yumia_atelier_tip3"))

	setText = var_1

	local var_1_8 = arg_1_0._tf
	local var_1_9 = var_2.Find(var_1_8, "Frame/Tabs/Item/Selected/Text")

	i18n = var_1_8

	var_1(var_1_9, var_1_8("yumia_atelier_tip3"))

	setText = var_1

	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_2.Find(var_1_10, "Frame/title/Text")

	i18n = var_1_10

	var_1(var_1_11, var_1_10("yumia_atelier_tip4"))

	setCanvasGroupAlpha = var_1

	local var_1_12 = arg_1_0._tf

	var_1(var_2.Find(var_1_12, "Frame"), 0)

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0.contextData

	var_3_0.filterType = var_0_1.FORMULA_TYPE.EQUIP
	pairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(arg_3_0.formulaFilterButtons) do
		onButton = var_1_10006

		local var_3_1 = arg_3_0
		local var_3_2 = iter_3_1

		local function var_3_3()
			arg_3_0.contextData.filterType = iter_3_0

			local var_4_0 = arg_3_0

			var_0.UpdateFilterButtons(var_4_0)

			local var_4_1 = arg_3_0

			var_0.FilterFormulas(var_4_1)

			local var_4_2 = arg_3_0

			var_0.UpdateFormulaList(var_4_2)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_3_1, var_3_2, var_3_3, var_1_10010)
	end

	onToggle = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	var_1(var_3_4, var_3.Find(var_3_5, "Frame/Filter/Toggle"), function(arg_5_0)
		arg_3_0.showOnlyComposite = arg_5_0

		local var_5_0 = arg_3_0

		var_1.FilterFormulas(var_5_0)

		local var_5_1 = arg_3_0

		var_1.UpdateFormulaList(var_5_1)

		return
	end)

	return
end

function var_0_1.UpdateFilterButtons(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.formulaFilterButtons) do
		setActive = var_1_10006

		var_1_10006(iter_6_1:Find("Selected"), arg_6_0.contextData.filterType == iter_6_0)
	end

	return
end

function var_0_1.FilterFormulas(arg_7_0)
	arg_7_0.filterFormulas = {}

	local var_7_0 = arg_7_0.contextData.versionIndex

	pairs = var_1_10002

	local var_7_1 = arg_7_0.activity

	for iter_7_0, iter_7_1 in var_1_10002(var_3.GetFormulasByVersion(var_7_1, var_7_0)) do
		if arg_7_0:IsFormulaTypeFit(iter_7_1) then
			if not arg_7_0.showOnlyComposite then
				table = var_7

				var_7.insert(arg_7_0.filterFormulas, iter_7_1)
			elseif iter_7_1:IsAvaliable() then
				AtelierFormula = var_7

				if var_7.IsFormualCanComposite(iter_7_1, arg_7_0.activity, var_7_0) then
					table = var_7

					var_7.insert(arg_7_0.filterFormulas, iter_7_1)
				end
			end
		end
	end

	table = var_2

	var_2.sort(arg_7_0.filterFormulas, function(arg_8_0, arg_8_1)
		local var_8_0 = {
			function(arg_9_0)
				return arg_9_0:IsAvaliable() and 0 or 1
			end,
			function(arg_10_0)
				local var_10_0 = arg_10_0
				local var_10_1 = arg_10_0.GetType(var_10_0)

				AtelierFormula = var_10_0

				if var_10_1 ~= var_10_0.TYPE.TOOL then
					local var_10_2 = arg_7_0.activity

					if not var_1.IsCompleteAllTools(var_10_2, arg_10_0:getConfig("version")) then
						do return 1 end

						goto label_10_0
					end
				end

				do return 0 end

				::label_10_0::

				return
			end,
			function(arg_11_0)
				return arg_11_0:GetConfigID()
			end
		}

		ipairs = var_3

		for iter_8_0, iter_8_1 in var_3(var_8_0) do
			if iter_8_1(arg_8_0) ~= iter_8_1(arg_8_1) then
				return var_8 < var_9
			end
		end

		return false
	end)

	return
end

function var_0_1.IsFormulaTypeFit(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.contextData.filterType

	switch = var_1_10003

	local var_12_1 = arg_12_1:GetType()
	local var_12_2 = {}

	AtelierFormula = var_1_10006
	var_12_2[var_1_10006.TYPE.EQUIP] = function()
		return var_12_0 == var_0_1.FORMULA_TYPE.EQUIP
	end
	AtelierFormula = var_6
	var_12_2[var_6.TYPE.ITEM] = function()
		return var_12_0 == var_0_1.FORMULA_TYPE.ITEM
	end
	AtelierFormula = var_6
	var_12_2[var_6.TYPE.TOOL] = function()
		return var_12_0 == var_0_1.FORMULA_TYPE.ITEM
	end
	AtelierFormula = var_6
	var_12_2[var_6.TYPE.OTHER] = function()
		return var_12_0 == var_0_1.FORMULA_TYPE.ITEM
	end

	return var_1_10003(var_12_1, var_12_2)
end

return var_0_1
