local AtelierFormulaMaterialsYumiaPreview = class("AtelierFormulaMaterialsYumiaPreview", import("view.activity.Atelier.base.AtelierFormulaMaterialsPreview"))

function AtelierFormulaMaterialsYumiaPreview:InitCustom()
	setText(self._tf:Find("Frame/closeText"), i18n("yumia_atelier_tip13"))
	setText(self._tf:Find("Frame/Text"), i18n("yumia_atelier_tip11"))
	setText(self._tf:Find("Frame/Text_1"), i18n("yumia_atelier_tip12"))

	return
end

function AtelierFormulaMaterialsYumiaPreview:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:HideMaterialsPreview(true)

		return
	end, SFX_CANCEL)

	return
end

function AtelierFormulaMaterialsYumiaPreview:ShowMaterialsPreview(arg_4_1)
	GetComponent(self._tf, typeof(Animation)):Play("Anim_AtelierCompositeYumiaUI_FormulaMaterialPreview_In")
	setActive(self._go, true)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	local var_4_0 = self.activity:GetItems()
	local var_4_1 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_4_2 = AtelierMaterial.bindConfigTable()
	local var_4_3 = {}
	local var_4_4 = {}
	local var_4_5 = {}

	local function var_4_6(arg_5_0)
		local var_5_0 = var_4_5[arg_5_0:GetConfigID()] or Clone(var_4_0[arg_5_0:GetConfigID()])

		assert(var_5_0, "Using Unexist material")

		var_5_0.count = var_5_0.count - 1
		var_4_5[arg_5_0:GetConfigID()] = var_5_0

		return
	end

	_.each(arg_4_1, function(arg_6_0)
		local var_6_0 = arg_6_0.Data:GetLimitItemID()

		if var_6_0 ~= 0 then
			local var_6_1 = var_4_5[var_6_0] or var_4_0[var_6_0]

			if var_6_1 and var_6_1.count > 0 then
				var_4_3[var_6_0] = (var_4_3[var_6_0] or 0) + 1

				var_4_6(var_6_1)
			else
				var_4_4[var_6_0] = ((not var_4_4[var_6_0] or nil) and 0) + 1
			end
		end

		return
	end)

	local function var_4_7(arg_7_0)
		if arg_7_0.Instance then
			if arg_7_0.Data:GetLimitItemID() == 0 then
				var_4_3[arg_7_0.Instance:GetConfigID()] = (var_4_3[arg_7_0.Instance:GetConfigID()] or 0) + 1

				var_4_6(arg_7_0.Instance)
			end

			return
		end

		local var_7_0 = arg_7_0.Data
		local var_7_1

		for iter_7_0, iter_7_1 in ipairs(var_4_2.all) do
			local var_7_2 = var_4_5[iter_7_1] or var_4_0[iter_7_1] or AtelierMaterial.New({
				configId = iter_7_1
			})

			if var_7_2:IsNormal() and var_7_0:CanUseMaterial(var_7_2, var_4_1, self.contextData.versionIndex) then
				var_7_1 = var_7_1 or iter_7_1

				if var_7_2.count > 0 then
					var_4_3[var_7_1] = (var_4_3[var_7_1] or 0) + 1

					var_4_6(var_7_2)

					return
				end
			end
		end

		if var_7_1 then
			var_4_4[var_7_1] = (var_4_4[var_7_1] or 0) + 1
		else
			assert(false, string.format("节点 %s 找不到合适的材料", var_7_0:GetConfigID()))
		end

		return
	end

	_.each(arg_4_1, function(arg_8_0)
		if arg_8_0.Data:GetType() == AtelierFormulaCircle.TYPE.NORMAL then
			var_4_7(arg_8_0)
		end

		return
	end)
	_.each(arg_4_1, function(arg_9_0)
		if arg_9_0.Data:GetType() == AtelierFormulaCircle.TYPE.ANY then
			var_4_7(arg_9_0)
		end

		return
	end)
	_.each(arg_4_1, function(arg_10_0)
		if arg_10_0.Data:GetType() == AtelierFormulaCircle.TYPE.ELEMENT_CATEGORY then
			var_4_7(arg_10_0)
		end

		return
	end)
	_.each(arg_4_1, function(arg_11_0)
		if arg_11_0.Data:GetType() == AtelierFormulaCircle.TYPE.CATEGORY then
			var_4_7(arg_11_0)
		end

		return
	end)
	_.each(arg_4_1, function(arg_12_0)
		if arg_12_0.Data:GetType() == AtelierFormulaCircle.TYPE.ELEMENT then
			var_4_7(arg_12_0)
		end

		return
	end)
	_.each(arg_4_1, function(arg_13_0)
		if arg_13_0.Data:GetType() == AtelierFormulaCircle.TYPE.NONE then
			var_4_7(arg_13_0)
		end

		return
	end)

	local function var_4_8(arg_14_0, arg_14_1)
		return arg_14_0 < arg_14_1
	end

	local var_4_9 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_3) do
		table.insert(var_4_9, iter_4_0)
	end

	local var_4_10 = {}

	for iter_4_2, iter_4_3 in pairs(var_4_4) do
		table.insert(var_4_10, iter_4_2)
	end

	table.sort(var_4_9, var_4_8)
	table.sort(var_4_10, var_4_8)
	;(function()
		local var_15_0 = self._tf:Find("Frame/Scroll/Content")

		setActive(var_15_0.parent, #var_4_9 > 0)

		if #var_4_9 == 0 then
			return
		end

		table.Foreach(CustomIndexLayer.Clone2Full(var_15_0, #var_4_9), function(arg_16_0, arg_16_1)
			local var_16_0 = AtelierMaterial.New({
				configId = var_4_9[arg_16_0]
			})

			var_16_0.count = var_4_3[var_4_9[arg_16_0]]

			self._parentClass:UpdateRyzaItem(arg_16_1, var_16_0, true)
			onButton(self, arg_16_1, function()
				self._parentClass:ShowItemDetail(var_16_0)

				return
			end, SFX_PANEL)

			return
		end)

		return
	end)()
	;(function()
		local var_18_0 = self._tf:Find("Frame/LackScroll/Content")

		setActive(var_18_0.parent, #var_4_10 > 0)

		if #var_4_10 == 0 then
			return
		end

		table.Foreach(CustomIndexLayer.Clone2Full(var_18_0, #var_4_10), function(arg_19_0, arg_19_1)
			local var_19_0 = AtelierMaterial.New({
				configId = var_4_10[arg_19_0]
			})

			var_19_0.count = var_4_4[var_4_10[arg_19_0]]

			self._parentClass:UpdateRyzaItem(arg_19_1, var_19_0, true)
			onButton(self, arg_19_1, function()
				self._parentClass:ShowItemDetail(var_19_0)

				return
			end, SFX_PANEL)

			return
		end)

		return
	end)()
	self:AddTimer(#var_4_9, #var_4_10)

	return
end

function AtelierFormulaMaterialsYumiaPreview:HideMaterialsPreview(arg_21_1)
	if not isActive(self._go) then
		return
	end

	local var_21_0 = GetComponent(self._tf, typeof(Animation))

	var_21_0:Play("Anim_AtelierCompositeYumiaUI_FormulaMaterialPreview_Out")
	pg.UIMgr.GetInstance():LoadingOn(false)

	if not arg_21_1 then
		self:StopCloseTimer()
		pg.UIMgr.GetInstance():LoadingOff()
		self:StopTimer()
		AtelierFormulaMaterialsYumiaPreview.super.HideMaterialsPreview(self)

		return
	end

	self.closeTimer = FrameTimer.New(function()
		if not var_21_0:IsPlaying("Anim_AtelierCompositeYumiaUI_FormulaMaterialPreview_Out") then
			self:StopCloseTimer()
			pg.UIMgr.GetInstance():LoadingOff()
			self:StopTimer()
			AtelierFormulaMaterialsYumiaPreview.super.HideMaterialsPreview(self)
		end

		return
	end, 1, -1)

	self.closeTimer:Start()

	return true
end

function AtelierFormulaMaterialsYumiaPreview:StopCloseTimer()
	if self.closeTimer then
		self.closeTimer:Stop()

		self.closeTimer = nil
	end

	return
end

function AtelierFormulaMaterialsYumiaPreview:AddTimer(arg_24_1, arg_24_2)
	local var_24_1 = self._tf:Find("Frame/Scroll/Content")
	local var_24_2 = self._tf:Find("Frame/LackScroll/Content")

	self.timer = FrameTimer.New(function()
		local var_25_0 = 0

		for iter_25_0 = 0, var_24_1.childCount - 1 do
			if var_24_1:GetChild(iter_25_0).gameObject.activeSelf then
				var_25_0 = var_25_0 + 1
			end
		end

		local var_25_1 = 0

		for iter_25_1 = 0, var_24_2.childCount - 1 do
			if var_24_2:GetChild(iter_25_1).gameObject.activeSelf then
				var_25_1 = var_25_1 + 1
			end
		end

		if math.min(var_25_0, math.min(arg_24_1, 8)) <= arg_24_1 and math.min(var_25_1, math.min(arg_24_2, 8)) <= arg_24_2 then
			self:StopTimer()
			self:AddTimer2()
		end

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function AtelierFormulaMaterialsYumiaPreview:AddTimer2()
	local var_26_0 = self._tf:Find("Frame/Scroll/Content")
	local var_26_1 = self._tf:Find("Frame/LackScroll/Content")
	local var_26_2 = var_26_0.childCount
	local var_26_3 = var_26_1.childCount

	for iter_26_0 = 0, var_26_0.childCount - 1 do
		SetComponentEnabled(var_26_0:GetChild(iter_26_0), typeof(Animation), false)

		GetComponent(var_26_0:GetChild(iter_26_0), typeof(CanvasGroup)).alpha = 0
	end

	for iter_26_1 = 0, var_26_1.childCount - 1 do
		SetComponentEnabled(var_26_1:GetChild(iter_26_1), typeof(Animation), false)

		GetComponent(var_26_1:GetChild(iter_26_1), typeof(CanvasGroup)).alpha = 0
	end

	local var_26_4 = 0

	self.timer = Timer.New(function()
		if var_26_4 >= var_26_2 and var_26_4 >= var_26_3 then
			self:StopTimer()

			return
		end

		if var_26_4 < var_26_2 then
			local var_27_0 = GetComponent(var_26_0:GetChild(var_26_4), typeof(Animation))

			var_27_0.enabled = true

			var_27_0:Stop()
			var_27_0:Play("Anim_AtelierStoreYumiaUI_Tpl_In")
		end

		if var_26_4 < var_26_3 then
			local var_27_1 = GetComponent(var_26_1:GetChild(var_26_4), typeof(Animation))

			var_27_1.enabled = true

			var_27_1:Stop()
			var_27_1:Play("Anim_AtelierStoreYumiaUI_Tpl_In")
		end

		var_26_4 = var_26_4 + 1

		return
	end, 0.08, -1)

	self.timer:Start()

	return
end

function AtelierFormulaMaterialsYumiaPreview:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return AtelierFormulaMaterialsYumiaPreview
