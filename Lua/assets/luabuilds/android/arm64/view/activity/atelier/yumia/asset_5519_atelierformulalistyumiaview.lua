local AtelierFormulaListYumiaView = class("AtelierFormulaListYumiaView", import("view.activity.Atelier.base.AtelierFormulaListView"))

AtelierFormulaListYumiaView.FilterAll = bit.bor(1)
AtelierFormulaListYumiaView.FORMULA_TYPE = {
	EQUIP = 1,
	ITEM = 2
}

function AtelierFormulaListYumiaView:InitCustom()
	self.formulaFilterButtons = _.map({
		1,
		2
	}, function(arg_2_0)
		return self._tf:Find("Frame/Tabs"):GetChild(arg_2_0 - 1)
	end)

	setText(self._tf:Find("Bar/Text"), i18n("yumia_atelier_tip5"))
	setText(self._tf:Find("Frame/Tabs/Equip/UnSelected/Text"), i18n("yumia_atelier_tip2"))
	setText(self._tf:Find("Frame/Tabs/Equip/Selected/Text"), i18n("yumia_atelier_tip2"))
	setText(self._tf:Find("Frame/Tabs/Item/UnSelected/Text"), i18n("yumia_atelier_tip3"))
	setText(self._tf:Find("Frame/Tabs/Item/Selected/Text"), i18n("yumia_atelier_tip3"))
	setText(self._tf:Find("Frame/title/Text"), i18n("yumia_atelier_tip4"))
	setCanvasGroupAlpha(self._tf:Find("Frame"), 0)

	return
end

function AtelierFormulaListYumiaView:didEnter()
	self.contextData.filterType = AtelierFormulaListYumiaView.FORMULA_TYPE.EQUIP

	for iter_3_0, iter_3_1 in pairs(self.formulaFilterButtons) do
		onButton(self, iter_3_1, function()
			self.contextData.filterType = iter_3_0

			self:UpdateFilterButtons()
			self:FilterFormulas()
			self:UpdateFormulaList()

			return
		end, SFX_PANEL)
	end

	onToggle(self, self._tf:Find("Frame/Filter/Toggle"), function(arg_5_0)
		self.showOnlyComposite = arg_5_0

		self:FilterFormulas()
		self:UpdateFormulaList()

		return
	end)

	return
end

function AtelierFormulaListYumiaView:UpdateFilterButtons()
	for iter_6_0, iter_6_1 in pairs(self.formulaFilterButtons) do
		setActive(iter_6_1:Find("Selected"), self.contextData.filterType == iter_6_0)
	end

	return
end

function AtelierFormulaListYumiaView:FilterFormulas()
	self.filterFormulas = {}

	for iter_7_0, iter_7_1 in pairs(self.activity:GetFormulasByVersion(self.contextData.versionIndex)) do
		if self:IsFormulaTypeFit(iter_7_1) then
			if not self.showOnlyComposite then
				table.insert(self.filterFormulas, iter_7_1)
			elseif iter_7_1:IsAvaliable() and AtelierFormula.IsFormualCanComposite(iter_7_1, self.activity, self.contextData.versionIndex) then
				table.insert(self.filterFormulas, iter_7_1)
			end
		end
	end

	table.sort(self.filterFormulas, function(arg_8_0, arg_8_1)
		for iter_8_0, iter_8_1 in ipairs({
			function(arg_9_0)
				return arg_9_0:IsAvaliable() and 0 or 1
			end,
			function(arg_10_0)
				if arg_10_0:GetType() ~= AtelierFormula.TYPE.TOOL and not self.activity:IsCompleteAllTools(arg_10_0:getConfig("version")) then
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

function AtelierFormulaListYumiaView:IsFormulaTypeFit(arg_12_1)
	local var_12_0 = self.contextData.filterType

	return switch(arg_12_1:GetType(), {
		[AtelierFormula.TYPE.EQUIP] = function()
			return var_12_0 == AtelierFormulaListYumiaView.FORMULA_TYPE.EQUIP
		end,
		[AtelierFormula.TYPE.ITEM] = function()
			return var_12_0 == AtelierFormulaListYumiaView.FORMULA_TYPE.ITEM
		end,
		[AtelierFormula.TYPE.TOOL] = function()
			return var_12_0 == AtelierFormulaListYumiaView.FORMULA_TYPE.ITEM
		end,
		[AtelierFormula.TYPE.OTHER] = function()
			return var_12_0 == AtelierFormulaListYumiaView.FORMULA_TYPE.ITEM
		end
	})
end

return AtelierFormulaListYumiaView
