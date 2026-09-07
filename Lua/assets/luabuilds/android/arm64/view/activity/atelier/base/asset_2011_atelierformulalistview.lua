local AtelierFormulaListView = class("AtelierFormulaListView", import("view.base.BasePanel"))

AtelierFormulaListView.FilterAll = bit.bor(1, 2, 4)

function AtelierFormulaListView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject
	self._tf = arg_1_1
	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AtelierFormulaListView:Init()
	setActive(self._tf:Find("Frame/Item"), false)

	self.formulaRect = GetComponent(self._tf:Find("Frame/ScrollView"), "LScrollRect")

	function self.formulaRect.onUpdateItem(arg_3_0, arg_3_1)
		self:UpdateFormulaItem(arg_3_0 + 1, arg_3_1)

		return
	end

	setActive(self._go, false)
	self:InitCustom()

	return
end

function AtelierFormulaListView:InitCustom()
	self.formulaFilterButtons = _.map({
		1,
		2,
		3
	}, function(arg_5_0)
		return self._tf:Find("Frame/Tabs"):GetChild(arg_5_0 - 1)
	end)

	setText(self._tf:Find("Frame/Empty"), i18n("ryza_tip_no_recipe"))
	setText(self._tf:Find("Frame/Filter/Text"), i18n("ryza_toggle_only_composite"))
	setText(self._tf:Find("Frame/Item/Lock/Text"), i18n("ryza_tip_unlock_all_tools"))
	setText(self._tf:Find("Bar/Text"), i18n("ryza_tip_select_recipe"))

	return
end

function AtelierFormulaListView:SetContextData(arg_6_1)
	self.contextData = arg_6_1

	return
end

function AtelierFormulaListView:SetActivity(arg_7_1)
	self.activity = arg_7_1

	return
end

function AtelierFormulaListView:didEnter()
	self.contextData.filterType = AtelierFormulaListView.FilterAll

	for iter_8_0, iter_8_1 in pairs(self.formulaFilterButtons) do
		onButton(self, iter_8_1, function()
			if self.contextData.filterType == AtelierFormulaListView.FilterAll then
				self.contextData.filterType = bit.lshift(1, iter_8_0 - 1)
			else
				self.contextData.filterType = bit.bxor(self.contextData.filterType, bit.lshift(1, iter_8_0 - 1))

				if self.contextData.filterType == 0 then
					self.contextData.filterType = AtelierFormulaListView.FilterAll
				end
			end

			self:UpdateFilterButtons()
			self:FilterFormulas()
			self:UpdateFormulaList()

			return
		end, SFX_PANEL)
	end

	onToggle(self, self._tf:Find("Frame/Filter/Toggle"), function(arg_10_0)
		self.showOnlyComposite = arg_10_0

		self:FilterFormulas()
		self:UpdateFormulaList()

		return
	end)

	return
end

function AtelierFormulaListView:ShowFormulaList()
	setActive(self._go, true)
	setParent(self._go, self._parentClass.top)
	self._tf:SetSiblingIndex(0)
	self:UpdateFilterButtons()
	self:FilterFormulas()
	self:UpdateFormulaList()

	return
end

function AtelierFormulaListView:UpdateFilterButtons()
	for iter_12_0, iter_12_1 in pairs(self.formulaFilterButtons) do
		setActive(iter_12_1:Find("Selected"), self.contextData.filterType ~= AtelierFormulaListView.FilterAll and bit.band(self.contextData.filterType, bit.lshift(1, iter_12_0 - 1)) > 0)
	end

	return
end

local var_0_1 = {
	[AtelierFormula.TYPE.EQUIP] = "ryza_word_equip",
	[AtelierFormula.TYPE.ITEM] = "word_item",
	[AtelierFormula.TYPE.TOOL] = "word_tool",
	[AtelierFormula.TYPE.OTHER] = "word_other"
}

function AtelierFormulaListView:UpdateFormulaItem(arg_13_1, arg_13_2)
	local var_13_0 = tf(arg_13_2)
	local var_13_1 = self.filterFormulas[arg_13_1]
	local var_13_2 = self.filterFormulas[arg_13_1]:GetProduction()

	self._parentClass:UpdateRyzaDrop(var_13_0:Find("BG/Icon"), {
		type = var_13_2[1],
		id = var_13_2[2]
	}, true)

	local var_13_3 = var_0_1[var_13_1:GetType()]
	local var_13_4 = var_13_1:GetType() ~= AtelierFormula.TYPE.TOOL and not self.activity:IsCompleteAllTools(var_13_1:getConfig("version"))

	setActive(var_13_0:Find("Lock"), var_13_4)
	setActive(var_13_0:Find("BG"), not var_13_4)
	setText(var_13_0:Find("BG/Type"), i18n(var_13_3))
	setScrollText(var_13_0:Find("BG/Name/Text"), var_13_1:GetName())

	local var_13_5 = var_13_1:GetMaxLimit() > 0 and var_13_1:GetMaxLimit() - var_13_1:GetUsedCount() .. "/" .. var_13_1:GetMaxLimit() or "∞"
	local var_13_6 = var_13_1:IsAvaliable()

	setActive(var_13_0:Find("BG/Count"), var_13_6)
	setActive(var_13_0:Find("Completed"), not var_13_6)

	if var_13_6 then
		local var_13_7 = AtelierFormula.IsFormualCanComposite(var_13_1, self.activity, self.contextData.versionIndex)

		setTextColor(var_13_0:Find("BG/Count"), self.contextData.versionIndex and self.contextData.versionIndex == 2 and SummerFeastScene.TransformColor(var_13_7 and "62e587" or "f27878") or SummerFeastScene.TransformColor(var_13_7 and "4fb3a3" or "d55a54"))
	end

	setText(var_13_0:Find("BG/Count"), var_13_5)
	onButton(self, var_13_0, function()
		if not var_13_6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

			return
		end

		if var_13_4 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_unlock_all_tools"))

			return
		end

		self._parentClass:OnClickFormula(var_13_1)

		return
	end, SFX_PANEL)

	return
end

function AtelierFormulaListView:FilterFormulas()
	self.filterFormulas = {}

	for iter_15_0, iter_15_1 in pairs(self.activity:GetFormulasByVersion(self.contextData.versionIndex)) do
		if self:IsFormulaTypeFit(iter_15_1) and (not self.showOnlyComposite or iter_15_1:IsAvaliable() and AtelierFormula.IsFormualCanComposite(iter_15_1, self.activity, self.contextData.versionIndex)) then
			table.insert(self.filterFormulas, iter_15_1)
		end
	end

	table.sort(self.filterFormulas, function(arg_16_0, arg_16_1)
		for iter_16_0, iter_16_1 in ipairs({
			function(arg_17_0)
				return arg_17_0:IsAvaliable() and 0 or 1
			end,
			function(arg_18_0)
				if arg_18_0:GetType() ~= AtelierFormula.TYPE.TOOL and not self.activity:IsCompleteAllTools(arg_18_0:getConfig("version")) then
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

function AtelierFormulaListView:IsFormulaTypeFit(arg_20_1)
	local var_20_0 = self.contextData.filterType

	if self.contextData.filterType == AtelierFormulaListView.FilterAll then
		return true
	end

	return switch(arg_20_1:GetType(), {
		[AtelierFormula.TYPE.EQUIP] = function()
			return bit.band(var_20_0, 1) > 0
		end,
		[AtelierFormula.TYPE.ITEM] = function()
			return bit.band(var_20_0, 2) > 0
		end,
		[AtelierFormula.TYPE.TOOL] = function()
			return bit.band(var_20_0, 4) > 0
		end,
		[AtelierFormula.TYPE.OTHER] = function()
			return bit.band(var_20_0, 4) > 0
		end
	})
end

function AtelierFormulaListView:UpdateFormulaList()
	local var_25_0 = #self.filterFormulas
	local var_25_1 = #self.filterFormulas == 0

	setActive(self._tf:Find("Frame/Empty"), #self.filterFormulas == 0)
	setActive(self._tf:Find("Frame/ScrollView"), not var_25_1)
	self.formulaRect:SetTotalCount(var_25_0)

	return
end

function AtelierFormulaListView:willExit()
	self:detach()

	return
end

return AtelierFormulaListView
