local AtelierMaterialSelectView = class("AtelierMaterialSelectView", import("view.base.BasePanel"))

function AtelierMaterialSelectView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject
	self._tf = arg_1_1
	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AtelierMaterialSelectView:Init()
	self.BG = self._tf:Find("BG")
	self.candicatesRect = GetComponent(self._tf:Find("Frame/List"), "LScrollRect")

	setActive(self._tf:Find("Frame/Item"), false)

	function self.candicatesRect.onUpdateItem(arg_3_0, arg_3_1)
		self:UpdateCandicateItem(arg_3_0 + 1, arg_3_1)

		return
	end

	setActive(self._go, false)
	self:InitCustom()

	return
end

function AtelierMaterialSelectView:InitCustom()
	setText(self._tf:Find("Frame/Item"):Find("IconBG/Lack/Text"), i18n("ryza_ui_show_acess"))

	return
end

function AtelierMaterialSelectView:SetContextData(arg_5_1)
	self.contextData = arg_5_1

	return
end

function AtelierMaterialSelectView:SetActivity(arg_6_1)
	self.activity = arg_6_1

	return
end

function AtelierMaterialSelectView:didEnter()
	onButton(self, self.BG, function()
		self:CloseCandicatePanel()

		return
	end, SFX_CANCEL)

	return
end

function AtelierMaterialSelectView:UpdateCandicateItem(arg_9_1, arg_9_2)
	local var_9_0 = tf(arg_9_2)
	local var_9_1 = self.candicates[arg_9_1]

	self._parentClass:UpdateRyzaItem(var_9_0:Find("IconBG"), self.candicates[arg_9_1], true)

	local var_9_2 = var_9_1.count <= 0

	setActive(var_9_0:Find("IconBG/Lack"), var_9_1.count <= 0)
	onButton(self, var_9_0, function()
		if var_9_2 then
			var_9_1 = CreateShell(var_9_1)
			var_9_1.count = false

			self._parentClass:ShowItemDetail(var_9_1)
		else
			self._parentClass:OnSelectMaterial(self.nodeTarget, var_9_1)
			self:HideCandicatePanel()
		end

		return
	end, SFX_PANEL)

	return
end

function AtelierMaterialSelectView:ShowCandicatePanel(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = self._tf:Find("Target")
	local var_11_1 = tf(Instantiate(arg_11_1))

	SetComponentEnabled(var_11_1, typeof(Button), false)
	removeAllChildren(self._tf:Find("Target"))
	setParent(var_11_1, var_11_0)
	setAnchoredPosition(var_11_1, Vector2.zero)
	self:HideNodeLinks(var_11_1)
	setAnchoredPosition(self._parentClass.scrollView:Find("Content"), var_11_0.anchoredPosition - (arg_11_1.anchoredPosition + self._parentClass.scrollView.anchoredPosition))
	pg.UIMgr.GetInstance():BlurPanel(self._parentClass.top)
	setActive(self._go, true)
	SetComponentEnabled(self._parentClass.scrollView, typeof(ScrollRect), false)

	self.nodeTarget = arg_11_2

	self:PlayBgAnimation()
	self:UpdateCandicatePanel(arg_11_3)

	return
end

function AtelierMaterialSelectView:CloseCandicatePanel()
	self:StopBgAnimation(function()
		self:HideCandicatePanel()

		return
	end)

	return
end

function AtelierMaterialSelectView:HideCandicatePanel()
	if not isActive(self._go) then
		return
	end

	pg.UIMgr.GetInstance():OverlayPanel(self._parentClass.top)
	self._parentClass.painting:SetSiblingIndex(1)
	setActive(self._go, false)
	removeAllChildren(self._tf:Find("Target"))
	SetComponentEnabled(self._parentClass.scrollView, typeof(ScrollRect), true)

	self.candicateTarget = nil

	return true
end

function AtelierMaterialSelectView:UpdateCandicatePanel(arg_15_1)
	self.candicates = {}

	local var_15_0 = self.activity:GetItems()
	local var_15_1 = self.activity:GetFormulas()[self.contextData.formulaId]
	local var_15_2 = _.map(pg.activity_ryza_item.all, function(arg_16_0)
		local var_16_0 = var_15_0[arg_16_0] or AtelierMaterial.New({
			configId = arg_16_0
		})

		if var_16_0:IsShow() ~= 0 and self.nodeTarget.Data:CanUseMaterial(var_16_0, var_15_1, self.contextData.versionIndex) then
			if var_15_0[arg_16_0] then
				var_16_0 = AtelierMaterial.New({
					configId = arg_16_0,
					count = var_15_0[arg_16_0].count
				})
				var_16_0.count = _.reduce(arg_15_1, var_16_0.count, function(arg_17_0, arg_17_1)
					if arg_17_1.Instance and arg_17_1.Instance:GetConfigID() == arg_16_0 then
						arg_17_0 = arg_17_0 - 1
					end

					return arg_17_0
				end)
			end

			return var_16_0
		end

		return
	end)

	table.sort(var_15_2, function(arg_18_0, arg_18_1)
		if arg_18_0.count * arg_18_1.count == 0 and arg_18_0.count - arg_18_1.count ~= 0 then
			return arg_18_0.count < arg_18_1.count
		else
			return arg_18_0:GetConfigID() < arg_18_1:GetConfigID()
		end

		return
	end)
	_.each(var_15_2, function(arg_19_0)
		for iter_19_0 = 1, math.max(arg_19_0.count, 1) do
			table.insert(self.candicates, arg_19_0)
		end

		return
	end)
	self.candicatesRect:SetTotalCount(#self.candicates, 0)

	return
end

function AtelierMaterialSelectView:willExit()
	self:detach()

	return
end

function AtelierMaterialSelectView:HideNodeLinks(arg_21_1)
	for iter_21_0 = 1, 6 do
		setActive(arg_21_1:Find("Links"):GetChild(iter_21_0 - 1), false)
	end

	return
end

function AtelierMaterialSelectView:PlayBgAnimation()
	local var_22_0 = self._tf:Find("TargetBG")

	var_22_0.localRotation = Quaternion.identity

	local var_22_1 = self.nodeTarget.Data:GetType() == AtelierFormulaCircle.TYPE.BASE and 300 or 245

	setSizeDelta(var_22_0, {
		x = var_22_1,
		y = var_22_1
	})
	GetComponent(var_22_0, typeof(Animator)):SetBool("Selecting", true)

	return
end

function AtelierMaterialSelectView:StopBgAnimation(arg_23_1)
	self._parentClass:LoadingOn()

	local var_23_0 = GetComponent(self._tf:Find("TargetBG"), typeof(DftAniEvent))

	var_23_0:SetEndEvent(function()
		self._parentClass:LoadingOff()
		arg_23_1()
		var_23_0:SetEndEvent(nil)

		return
	end)
	GetComponent(self._tf:Find("TargetBG"), typeof(Animator)):SetBool("Selecting", false)

	return
end

return AtelierMaterialSelectView
