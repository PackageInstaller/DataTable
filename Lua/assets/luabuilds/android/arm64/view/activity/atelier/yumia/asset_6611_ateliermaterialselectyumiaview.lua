local AtelierMaterialSelectYumiaView = class("AtelierMaterialSelectYumiaView", import("view.activity.Atelier.base.AtelierMaterialSelectView"))

function AtelierMaterialSelectYumiaView:InitCustom()
	self.item = self._tf:Find("left/Icon")
	self.itemName = self._tf:Find("left/titleBg/Name")
	self.itemCnt = self._tf:Find("left/titleBg/cntText")
	self.itemDescription = self._tf:Find("left/Description/Text")

	setText(self._tf:Find("Frame/closeBtn/Text"), i18n("yumia_atelier_tip10"))
	setText(self._tf:Find("left/titleBg/Text_1"), i18n("yumia_atelier_tip8"))

	return
end

function AtelierMaterialSelectYumiaView:didEnter()
	AtelierMaterialSelectYumiaView.super.didEnter(self)
	onButton(self, self._tf:Find("Frame/closeBtn"), function()
		self:CloseCandicatePanel()

		return
	end, SFX_PANEL)

	return
end

function AtelierMaterialSelectYumiaView:UpdateCandicateItem(arg_4_1, arg_4_2)
	local var_4_0 = tf(arg_4_2)
	local var_4_1 = self.candicates[arg_4_1]

	self._parentClass:UpdateRyzaItem(var_4_0, self.candicates[arg_4_1], true)

	local var_4_2 = self.candicates[arg_4_1].count <= 0

	onButton(self, var_4_0, function()
		if var_4_2 then
			var_4_1 = CreateShell(var_4_1)
			var_4_1.count = false

			self._parentClass:ShowItemDetail(var_4_1)
		else
			self._parentClass:OnSelectMaterial(self.nodeTarget, var_4_1)
			self:HideCandicatePanel()
		end

		return
	end, SFX_PANEL)

	return
end

function AtelierMaterialSelectYumiaView:UpdateCandicatePanel(arg_6_1)
	self.candicates = {}

	local var_6_0 = self.activity:GetItems()
	local var_6_1 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_6_2 = _.map(pg.activity_ryza_item.all, function(arg_7_0)
		local var_7_0 = var_6_0[arg_7_0] or AtelierMaterial.New({
			configId = arg_7_0
		})

		if var_7_0:IsShow() ~= 0 and self.nodeTarget.Data:CanUseMaterial(var_7_0, var_6_1, self.contextData.versionIndex) then
			if var_6_0[arg_7_0] then
				var_7_0 = AtelierMaterial.New({
					configId = arg_7_0,
					count = var_6_0[arg_7_0].count
				})
				var_7_0.count = _.reduce(arg_6_1, var_7_0.count, function(arg_8_0, arg_8_1)
					if arg_8_1.Instance and arg_8_1.Instance:GetConfigID() == arg_7_0 then
						arg_8_0 = arg_8_0 - 1
					end

					return arg_8_0
				end)
			end

			return var_7_0
		end

		return
	end)

	table.sort(var_6_2, function(arg_9_0, arg_9_1)
		if arg_9_0.count * arg_9_1.count == 0 and arg_9_0.count - arg_9_1.count ~= 0 then
			return arg_9_0.count > arg_9_1.count
		else
			return arg_9_0:GetConfigID() < arg_9_1:GetConfigID()
		end

		return
	end)
	_.each(var_6_2, function(arg_10_0)
		table.insert(self.candicates, arg_10_0)

		return
	end)
	self.candicatesRect:SetTotalCount(#self.candicates, 0)

	return
end

function AtelierMaterialSelectYumiaView:ShowCandicatePanel(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = self._tf:Find("Target")

	setActive(self._go, true)
	SetComponentEnabled(self._parentClass.scrollView, typeof(ScrollRect), false)

	GetComponent(self._parentClass.scrollView, typeof(CanvasGroup)).blocksRaycasts = false

	setParent(self.BG, self._parentClass.layerFormulaDetailPanel)
	self.BG:SetSiblingIndex(0)

	self.nodeTarget = arg_11_2

	self:UpdateCandicatePanel(arg_11_3)
	self:RefreshFormula()
	tf(arg_11_2.GO):SetAsLastSibling()
	setActive(arg_11_2.GO:Find("select"), true)

	return
end

function AtelierMaterialSelectYumiaView:RefreshFormula()
	local var_12_0 = self.activity:GetFormulas()[self.contextData.formulaId]

	self._parentClass:UpdateRyzaDrop(self.item, {
		type = var_12_0:GetProduction()[1],
		id = var_12_0:GetProduction()[2]
	})
	setText(self.itemName, var_12_0:GetName())
	setText(self.itemDescription, var_12_0:GetDesc())

	local var_12_1 = tostring(var_12_0:GetMaxLimit() - var_12_0:GetUsedCount())

	setText(self.itemCnt, (var_12_0:GetMaxLimit() < 0 or nil) and "∞")

	return
end

function AtelierMaterialSelectYumiaView:CloseCandicatePanel()
	self:StopBgAnimation(function()
		self:HideCandicatePanel()

		return
	end)

	return
end

function AtelierMaterialSelectYumiaView:HideCandicatePanel()
	if not isActive(self._go) then
		return
	end

	setActive(self.nodeTarget.GO:Find("select"), false)
	setActive(self._go, false)

	GetComponent(self._parentClass.scrollView, typeof(CanvasGroup)).blocksRaycasts = true

	setParent(self.BG, self._tf)
	self._parentClass:RefreshScrollViewPosition()

	self.candicateTarget = nil

	return true
end

function AtelierMaterialSelectYumiaView:PlayBgAnimation()
	return
end

function AtelierMaterialSelectYumiaView:StopBgAnimation(arg_17_1)
	arg_17_1()

	return
end

return AtelierMaterialSelectYumiaView
