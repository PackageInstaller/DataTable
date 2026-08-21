local var_0_0 = class("AtelierFormulaListView", import("view.base.BasePanel"))

var_0_0.FilterAll = bit.bor(1, 2, 4)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	setActive(arg_2_0._tf:Find("Frame/Item"), false)

	arg_2_0.formulaRect = GetComponent(arg_2_0._tf:Find("Frame/ScrollView"), "LScrollRect")

	function arg_2_0.formulaRect.onUpdateItem(arg_3_0, arg_3_1)
		arg_2_0:UpdateFormulaItem(arg_3_0 + 1, arg_3_1)

		return
	end

	setActive(arg_2_0._go, false)
	arg_2_0:InitCustom()

	return
end

function var_0_0.InitCustom(arg_4_0)
	arg_4_0.formulaFilterButtons = _.map({
		1,
		2,
		3
	}, function(arg_5_0)
		return arg_4_0._tf:Find("Frame/Tabs"):GetChild(arg_5_0 - 1)
	end)

	setText(arg_4_0._tf:Find("Frame/Empty"), i18n("ryza_tip_no_recipe"))
	setText(arg_4_0._tf:Find("Frame/Filter/Text"), i18n("ryza_toggle_only_composite"))
	setText(arg_4_0._tf:Find("Frame/Item/Lock/Text"), i18n("ryza_tip_unlock_all_tools"))
	setText(arg_4_0._tf:Find("Bar/Text"), i18n("ryza_tip_select_recipe"))

	return
end

function var_0_0.SetContextData(arg_6_0, arg_6_1)
	arg_6_0.contextData = arg_6_1

	return
end

function var_0_0.SetActivity(arg_7_0, arg_7_1)
	arg_7_0.activity = arg_7_1

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0.contextData.filterType = var_0_0.FilterAll

	for iter_8_0, iter_8_1 in pairs(arg_8_0.formulaFilterButtons) do
		onButton(arg_8_0, iter_8_1, function()
			if arg_8_0.contextData.filterType == var_0_0.FilterAll then
				arg_8_0.contextData.filterType = bit.lshift(1, iter_8_0 - 1)
			else
				arg_8_0.contextData.filterType = bit.bxor(arg_8_0.contextData.filterType, bit.lshift(1, iter_8_0 - 1))

				if arg_8_0.contextData.filterType == 0 then
					arg_8_0.contextData.filterType = var_0_0.FilterAll
				end
			end

			arg_8_0:UpdateFilterButtons()
			arg_8_0:FilterFormulas()
			arg_8_0:UpdateFormulaList()

			return
		end, SFX_PANEL)
	end

	onToggle(arg_8_0, arg_8_0._tf:Find("Frame/Filter/Toggle"), function(arg_10_0)
		arg_8_0.showOnlyComposite = arg_10_0

		arg_8_0:FilterFormulas()
		arg_8_0:UpdateFormulaList()

		return
	end)

	return
end

function var_0_0.ShowFormulaList(arg_11_0)
	setActive(arg_11_0._go, true)
	setParent(arg_11_0._go, arg_11_0._parentClass.top)
	arg_11_0._tf:SetSiblingIndex(0)
	arg_11_0:UpdateFilterButtons()
	arg_11_0:FilterFormulas()
	arg_11_0:UpdateFormulaList()

	return
end

function var_0_0.UpdateFilterButtons(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.formulaFilterButtons) do
		local var_12_0 = arg_12_0.contextData.filterType ~= var_0_0.FilterAll and bit.band(arg_12_0.contextData.filterType, bit.lshift(1, iter_12_0 - 1)) > 0

		setActive(iter_12_1:Find("Selected"), var_12_0)
	end

	return
end

local var_0_1 = {
	[AtelierFormula.TYPE.EQUIP] = "ryza_word_equip",
	[AtelierFormula.TYPE.ITEM] = "word_item",
	[AtelierFormula.TYPE.TOOL] = "word_tool",
	[AtelierFormula.TYPE.OTHER] = "word_other"
}

function var_0_0.UpdateFormulaItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = tf(arg_13_2)
	local var_13_1 = arg_13_0.filterFormulas[arg_13_1]
	local var_13_2 = arg_13_0.filterFormulas[arg_13_1]:GetProduction()

	arg_13_0._parentClass:UpdateRyzaDrop(var_13_0:Find("BG/Icon"), {
		type = var_13_2[1],
		id = var_13_2[2]
	}, true)

	local var_13_3 = var_0_1[var_13_1:GetType()]
	local var_13_4 = var_13_1:GetType() ~= AtelierFormula.TYPE.TOOL and not arg_13_0.activity:IsCompleteAllTools(var_13_1:getConfig("version"))

	setActive(var_13_0:Find("Lock"), var_13_4)
	setActive(var_13_0:Find("BG"), not var_13_4)
	setText(var_13_0:Find("BG/Type"), i18n(var_13_3))
	setScrollText(var_13_0:Find("BG/Name/Text"), var_13_1:GetName())

	local var_13_5 = var_13_1:GetMaxLimit() > 0 and var_13_1:GetMaxLimit() - var_13_1:GetUsedCount() .. "/" .. var_13_1:GetMaxLimit() or "∞"
	local var_13_6 = var_13_1:IsAvaliable()

	setActive(var_13_0:Find("BG/Count"), var_13_6)
	setActive(var_13_0:Find("Completed"), not var_13_6)

	if var_13_6 then
		local var_13_7 = AtelierFormula.IsFormualCanComposite(var_13_1, arg_13_0.activity, arg_13_0.contextData.versionIndex)
		local var_13_8 = arg_13_0.contextData.versionIndex
		local var_13_9 = "ffffff"

		var_13_9 = arg_13_0.contextData.versionIndex and var_13_8 == 2 and SummerFeastScene.TransformColor(var_13_7 and "62e587" or "f27878") or SummerFeastScene.TransformColor(var_13_7 and "4fb3a3" or "d55a54")

		setTextColor(var_13_0:Find("BG/Count"), var_13_9)
	end

	setText(var_13_0:Find("BG/Count"), var_13_5)
	onButton(arg_13_0, var_13_0, function()
		if not var_13_6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

			return
		end

		if var_13_4 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_unlock_all_tools"))

			return
		end

		arg_13_0._parentClass:OnClickFormula(var_13_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.FilterFormulas(arg_15_0)
	arg_15_0.filterFormulas = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0.activity:GetFormulasByVersion(arg_15_0.contextData.versionIndex)) do
		if arg_15_0:IsFormulaTypeFit(iter_15_1) and (not arg_15_0.showOnlyComposite or iter_15_1:IsAvaliable() and AtelierFormula.IsFormualCanComposite(iter_15_1, arg_15_0.activity, arg_15_0.contextData.versionIndex)) then
			table.insert(arg_15_0.filterFormulas, iter_15_1)
		end
	end

	table.sort(arg_15_0.filterFormulas, function(arg_16_0, arg_16_1)
		for iter_16_0, iter_16_1 in ipairs({
			function(arg_17_0)
				return arg_17_0:IsAvaliable() and 0 or 1
			end,
			function(arg_18_0)
				if arg_18_0:GetType() ~= AtelierFormula.TYPE.TOOL and not arg_15_0.activity:IsCompleteAllTools(arg_18_0:getConfig("version")) then
					return 1
				else
					return 0
				end

				return
			end,
			function(arg_19_0)
				return arg_19_0:GetConfigID()
			end
		}) do
			local var_16_0 = iter_16_1(arg_16_0)
			local var_16_1 = iter_16_1(arg_16_1)

			if var_16_0 ~= var_16_1 then
				return var_16_0 < var_16_1
			end
		end

		return false
	end)

	return
end

function var_0_0.IsFormulaTypeFit(arg_20_0, arg_20_1)
	if arg_20_0.contextData.filterType == var_0_0.FilterAll then
		return true
	end

	return switch(arg_20_1:GetType(), {
		[AtelierFormula.TYPE.EQUIP] = function()
			return bit.band(var_0, 1) > 0
		end,
		[AtelierFormula.TYPE.ITEM] = function()
			return bit.band(var_0, 2) > 0
		end,
		[AtelierFormula.TYPE.TOOL] = function()
			return bit.band(var_0, 4) > 0
		end,
		[AtelierFormula.TYPE.OTHER] = function()
			return bit.band(var_0, 4) > 0
		end
	})
end

function var_0_0.UpdateFormulaList(arg_25_0)
	local var_25_0 = #arg_25_0.filterFormulas
	local var_25_1 = #arg_25_0.filterFormulas == 0

	setActive(arg_25_0._tf:Find("Frame/Empty"), #arg_25_0.filterFormulas == 0)
	setActive(arg_25_0._tf:Find("Frame/ScrollView"), not var_25_1)
	arg_25_0.formulaRect:SetTotalCount(var_25_0)

	return
end

function var_0_0.willExit(arg_26_0)
	arg_26_0:detach()

	return
end

return var_0_0
