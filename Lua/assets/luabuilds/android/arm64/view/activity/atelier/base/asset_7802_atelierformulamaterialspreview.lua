local AtelierFormulaMaterialsPreview = class("AtelierFormulaMaterialsPreview", import("view.base.BasePanel"))

function AtelierFormulaMaterialsPreview:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject
	self._tf = arg_1_1
	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	setActive(self._go, false)
	self:Init()

	return
end

function AtelierFormulaMaterialsPreview:Init()
	self:InitCustom()

	return
end

function AtelierFormulaMaterialsPreview:InitCustom()
	setText(self._tf:Find("Frame/Text"), i18n("ryza_tip_item_access"))

	return
end

function AtelierFormulaMaterialsPreview:SetContextData(arg_4_1)
	self.contextData = arg_4_1

	return
end

function AtelierFormulaMaterialsPreview:SetActivity(arg_5_1)
	self.activity = arg_5_1

	return
end

function AtelierFormulaMaterialsPreview:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:HideMaterialsPreview()

		return
	end, SFX_CANCEL)

	return
end

function AtelierFormulaMaterialsPreview:ShowMaterialsPreview(arg_8_1)
	setActive(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_8_0 = self.activity:GetItems()
	local var_8_1 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_8_2 = AtelierMaterial.bindConfigTable()
	local var_8_3 = {}
	local var_8_4 = {}
	local var_8_5 = {}

	local function var_8_6(arg_9_0)
		local var_9_0 = var_8_5[arg_9_0:GetConfigID()] or Clone(var_8_0[arg_9_0:GetConfigID()])

		assert(var_9_0, "Using Unexist material")

		var_9_0.count = var_9_0.count - 1
		var_8_5[arg_9_0:GetConfigID()] = var_9_0

		return
	end

	_.each(arg_8_1, function(arg_10_0)
		local var_10_0 = arg_10_0.Data:GetLimitItemID()

		if var_10_0 ~= 0 then
			local var_10_1 = var_8_5[var_10_0] or var_8_0[var_10_0]

			if var_10_1 and var_10_1.count > 0 then
				local var_10_2 = AtelierMaterial.New({
					configId = var_10_0
				})

				var_10_2.count = false

				table.insert(var_8_3, var_10_2)
				var_8_6(var_10_1)
			else
				local var_10_3 = AtelierMaterial.New({
					configId = var_10_0
				})

				var_10_3.count = false

				table.insert(var_8_4, var_10_3)
			end
		end

		return
	end)

	local function var_8_7(arg_11_0)
		if arg_11_0.Instance then
			local var_11_0 = AtelierMaterial.New({
				configId = arg_11_0.Instance:GetConfigID()
			})

			var_11_0.count = false

			table.insert(var_8_3, var_11_0)
			var_8_6(arg_11_0.Instance)

			return
		end

		local var_11_1 = arg_11_0.Data
		local var_11_2

		for iter_11_0, iter_11_1 in ipairs(var_8_2.all) do
			local var_11_3 = var_8_5[iter_11_1] or var_8_0[iter_11_1] or AtelierMaterial.New({
				configId = iter_11_1
			})

			if var_11_3:IsNormal() and var_11_1:CanUseMaterial(var_11_3, var_8_1, self.contextData.versionIndex) then
				var_11_2 = var_11_2 or iter_11_1

				if var_11_3.count > 0 then
					local var_11_4 = AtelierMaterial.New({
						configId = iter_11_1
					})

					var_11_4.count = false

					table.insert(var_8_3, var_11_4)
					var_8_6(var_11_3)

					return
				end
			end
		end

		local var_11_5 = AtelierMaterial.New({
			configId = var_11_2
		})

		var_11_5.count = false

		table.insert(var_8_4, var_11_5)

		return
	end

	_.each(arg_8_1, function(arg_12_0)
		if arg_12_0.Data:GetType() == AtelierFormulaCircle.TYPE.NORMAL then
			var_8_7(arg_12_0)
		end

		return
	end)
	_.each(arg_8_1, function(arg_13_0)
		if arg_13_0.Data:GetType() == AtelierFormulaCircle.TYPE.ANY then
			var_8_7(arg_13_0)
		end

		return
	end)
	_.each(arg_8_1, function(arg_14_0)
		if arg_14_0.Data:GetType() == AtelierFormulaCircle.TYPE.ELEMENT_CATEGORY then
			var_8_7(arg_14_0)
		end

		return
	end)
	_.each(arg_8_1, function(arg_15_0)
		if arg_15_0.Data:GetType() == AtelierFormulaCircle.TYPE.CATEGORY then
			var_8_7(arg_15_0)
		end

		return
	end)
	_.each(arg_8_1, function(arg_16_0)
		if arg_16_0.Data:GetType() == AtelierFormulaCircle.TYPE.ELEMENT then
			var_8_7(arg_16_0)
		end

		return
	end)
	_.each(arg_8_1, function(arg_17_0)
		if arg_17_0.Data:GetType() == AtelierFormulaCircle.TYPE.NONE then
			var_8_7(arg_17_0)
		end

		return
	end)

	local function var_8_8(arg_18_0, arg_18_1)
		return arg_18_0:GetConfigID() < arg_18_1:GetConfigID()
	end

	table.sort(var_8_3, var_8_8)
	table.sort(var_8_4, var_8_8)
	;(function()
		local var_19_0 = self._tf:Find("Frame/Scroll/Content/Owned/List")

		setActive(var_19_0.parent, #var_8_3 > 0)

		if #var_8_3 == 0 then
			return
		end

		table.Foreach(CustomIndexLayer.Clone2Full(var_19_0, #var_8_3), function(arg_20_0, arg_20_1)
			local var_20_0 = var_8_3[arg_20_0]

			self._parentClass:UpdateRyzaItem(arg_20_1:Find("IconBG"), var_8_3[arg_20_0], true)
			onButton(self, arg_20_1, function()
				self._parentClass:ShowItemDetail(var_20_0)

				return
			end, SFX_PANEL)

			return
		end)

		return
	end)()
	;(function()
		local var_22_0 = self._tf:Find("Frame/Scroll/Content/Lack/List")

		setActive(var_22_0.parent, #var_8_4 > 0)

		if #var_8_4 == 0 then
			return
		end

		table.Foreach(CustomIndexLayer.Clone2Full(var_22_0, #var_8_4), function(arg_23_0, arg_23_1)
			local var_23_0 = var_8_4[arg_23_0]

			self._parentClass:UpdateRyzaItem(arg_23_1:Find("IconBG"), var_8_4[arg_23_0], true)
			onButton(self, arg_23_1, function()
				self._parentClass:ShowItemDetail(var_23_0)

				return
			end, SFX_PANEL)

			return
		end)

		return
	end)()

	return
end

function AtelierFormulaMaterialsPreview:HideMaterialsPreview()
	if not isActive(self._go) then
		return
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentClass._tf)
	setActive(self._go, false)

	return true
end

function AtelierFormulaMaterialsPreview:willExit()
	self:detach()

	return
end

return AtelierFormulaMaterialsPreview
