local AtelierFormulaOverlayView = class("AtelierFormulaOverlayView", import("view.base.BasePanel"))

function AtelierFormulaOverlayView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject
	self._tf = arg_1_1
	self._parentClass = arg_1_2
	self.bundleName = arg_1_2.bundleName

	self:attach(arg_1_2)
	self:Init()

	return
end

function AtelierFormulaOverlayView:Init()
	self:InitCustom()

	return
end

function AtelierFormulaOverlayView:InitCustom()
	return
end

function AtelierFormulaOverlayView:SetContextData(arg_4_1)
	self.contextData = arg_4_1

	return
end

function AtelierFormulaOverlayView:SetActivity(arg_5_1)
	self.activity = arg_5_1

	return
end

function AtelierFormulaOverlayView:didEnter()
	onButton(self, self._tf:Find("List"), function()
		self._parentClass:OnClickFormulaBack()

		return
	end)

	return
end

local var_0_1 = {
	[AtelierFormula.TYPE.EQUIP] = "text_equip",
	[AtelierFormula.TYPE.ITEM] = "text_item",
	[AtelierFormula.TYPE.TOOL] = "text_other",
	[AtelierFormula.TYPE.OTHER] = "text_other"
}

function AtelierFormulaOverlayView:RefreshFormulaInfo(arg_8_1)
	self.contextData.formulaId = arg_8_1:GetConfigID()

	self._parentClass.loader:GetSpriteQuiet(self.bundleName, var_0_1[arg_8_1:GetType()], description:Find("Type"))
	self._parentClass:UpdateRyzaDrop(self._tf:Find("Icon"), {
		type = arg_8_1:GetProduction()[1],
		id = arg_8_1:GetProduction()[2]
	})
	setText(self._tf:Find("Name"), arg_8_1:GetName())
	setText(self._tf:Find("Description/Text"), arg_8_1:GetDesc())

	local var_8_0 = tostring(arg_8_1:GetMaxLimit() - arg_8_1:GetUsedCount())

	setText(self._tf:Find("RestCount/Text"), i18n("ryza_rest_produce_count", (arg_8_1:GetMaxLimit() < 0 or nil) and "∞"))

	return
end

function AtelierFormulaOverlayView:willExit()
	self:detach()

	return
end

return AtelierFormulaOverlayView
