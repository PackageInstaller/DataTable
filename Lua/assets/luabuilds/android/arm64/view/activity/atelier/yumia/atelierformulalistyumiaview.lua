local var_0_0 = class("AtelierFormulaListYumiaView", import("view.activity.Atelier.base.AtelierFormulaListView"))

var_0_0.FilterAll = bit.bor(1)
var_0_0.FORMULA_TYPE = {
	EQUIP = 1,
	ITEM = 2
}

function var_0_0.InitCustom(arg_1_0)
	arg_1_0.formulaFilterButtons = _.map({
		1,
		2
	}, function(arg_2_0)
		return arg_1_0._tf:Find("Frame/Tabs"):GetChild(arg_2_0 - 1)
	end)

	setText(arg_1_0._tf:Find("Bar/Text"), i18n("yumia_atelier_tip5"))
	setText(arg_1_0._tf:Find("Frame/Tabs/Equip/UnSelected/Text"), i18n("yumia_atelier_tip2"))
	setText(arg_1_0._tf:Find("Frame/Tabs/Equip/Selected/Text"), i18n("yumia_atelier_tip2"))
	setText(arg_1_0._tf:Find("Frame/Tabs/Item/UnSelected/Text"), i18n("yumia_atelier_tip3"))
	setText(arg_1_0._tf:Find("Frame/Tabs/Item/Selected/Text"), i18n("yumia_atelier_tip3"))
	setText(arg_1_0._tf:Find("Frame/title/Text"), i18n("yumia_atelier_tip4"))
	setCanvasGroupAlpha(arg_1_0._tf:Find("Frame"), 0)

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.contextData.filterType = var_0_0.FORMULA_TYPE.EQUIP

	for iter_3_0, iter_3_1 in pairs(arg_3_0.formulaFilterButtons) do
		onButton(arg_3_0, iter_3_1, function()
			arg_3_0.contextData.filterType = iter_3_0

			arg_3_0:UpdateFilterButtons()
			arg_3_0:FilterFormulas()
			arg_3_0:UpdateFormulaList()

			return
		end, SFX_PANEL)
	end

	onToggle(arg_3_0, arg_3_0._tf:Find("Frame/Filter/Toggle"), function(arg_5_0)
		arg_3_0.showOnlyComposite = arg_5_0

		arg_3_0:FilterFormulas()
		arg_3_0:UpdateFormulaList()

		return
	end)

	return
end

function var_0_0.UpdateFilterButtons(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.formulaFilterButtons) do
		setActive(iter_6_1:Find("Selected"), arg_6_0.contextData.filterType == iter_6_0)
	end

	return
end

function var_0_0.FilterFormulas(arg_7_0)
	arg_7_0.filterFormulas = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.activity:GetFormulasByVersion(arg_7_0.contextData.versionIndex)) do
		if arg_7_0:IsFormulaTypeFit(iter_7_1) then
			if not arg_7_0.showOnlyComposite then
				table.insert(arg_7_0.filterFormulas, iter_7_1)
			elseif iter_7_1:IsAvaliable() and AtelierFormula.IsFormualCanComposite(iter_7_1, arg_7_0.activity, arg_7_0.contextData.versionIndex) then
				table.insert(arg_7_0.filterFormulas, iter_7_1)
			end
		end
	end

	table.sort(arg_7_0.filterFormulas, function(arg_8_0, arg_8_1)
		for iter_8_0, iter_8_1 in ipairs({
			function(arg_9_0)
				return arg_9_0:IsAvaliable() and 0 or 1
			end,
			function(arg_10_0)
				if arg_10_0:GetType() ~= AtelierFormula.TYPE.TOOL and not arg_7_0.activity:IsCompleteAllTools(arg_10_0:getConfig("version")) then
					return 1
				else
					return 0
				end

				return
			end,
			function(arg_11_0)
				return arg_11_0:GetConfigID()
			end
		}) do
			local var_8_0 = iter_8_1(arg_8_0)
			local var_8_1 = iter_8_1(arg_8_1)

			if var_8_0 ~= var_8_1 then
				return var_8_0 < var_8_1
			end
		end

		return false
	end)

	return
end

function var_0_0.IsFormulaTypeFit(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.contextData.filterType

	return switch(arg_12_1:GetType(), {
		[AtelierFormula.TYPE.EQUIP] = function()
			return var_12_0 == var_0_0.FORMULA_TYPE.EQUIP
		end,
		[AtelierFormula.TYPE.ITEM] = function()
			return var_12_0 == var_0_0.FORMULA_TYPE.ITEM
		end,
		[AtelierFormula.TYPE.TOOL] = function()
			return var_12_0 == var_0_0.FORMULA_TYPE.ITEM
		end,
		[AtelierFormula.TYPE.OTHER] = function()
			return var_12_0 == var_0_0.FORMULA_TYPE.ITEM
		end
	})
end

return var_0_0
