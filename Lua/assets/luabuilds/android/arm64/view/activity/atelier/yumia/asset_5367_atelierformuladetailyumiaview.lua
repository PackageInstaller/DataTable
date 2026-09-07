local AtelierFormulaDetailYumiaView = class("AtelierFormulaDetailYumiaView", import("view.activity.Atelier.base.AtelierFormulaDetailView"))
local PoolPlural = import("Mgr.Pool.PoolPlural")

function AtelierFormulaDetailYumiaView:InitCustom()
	self.atelierFormulaOverlayView = AtelierFormulaOverlayYumiaView.New(self.layerFormulaDescriptionPanel, self._parentClass)
	self.compositePanel = self._tf:Find("Overlay/compositePanel")
	self.tipsText = self._tf:Find("tips/Text")

	setText(self._tf:Find("Overlay/compositePanel/backBtn/Text"), i18n("yumia_atelier_tip9"))
	setText(self._tf:Find("Overlay/compositePanel/CompositeBtn/Text"), i18n("yumia_atelier_tip18"))
	setText(self._tf:Find("Overlay/compositePanel/autoBtn/Text"), i18n("yumia_atelier_tip23"))

	self.lineGoList = {
		self._tf:Find("ScrollView/Content/lineGo1"),
		self._tf:Find("ScrollView/Content/lineGo2"),
		self._tf:Find("ScrollView/Content/lineGo3")
	}

	SetComponentEnabled(self._parentClass.scrollView, typeof(ScrollRect), false)

	return
end

function AtelierFormulaDetailYumiaView:didEnter()
	self.atelierFormulaOverlayView:didEnter()
	onButton(self, self._tf:Find("Overlay/compositePanel/CompositeBtn"), function()
		self:OnClickComposite()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Overlay/compositePanel/backBtn"), function()
		self._parentClass:OnClickFormulaBack()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Overlay/compositePanel/autoBtn"), function()
		self:OnClickAutoFill()

		return
	end, SFX_PANEL)

	return
end

function AtelierFormulaDetailYumiaView:Show(arg_6_1)
	setActive(self._go, true)

	self.unLockLayerIndex = 1

	if not self.nodePools then
		self.nodePools = {
			core = PoolPlural.New(self._tf:Find("coreNode").gameObject, 100),
			material = PoolPlural.New(self._tf:Find("materialNode").gameObject, 100)
		}

		table.Foreach(self.nodePools, function(arg_7_0, arg_7_1)
			setActive(arg_7_1.prefab, false)

			return
		end)
	end

	self.pluralRoot = self.pluralRoot or pg.PoolMgr.GetInstance().root
	self.nodeList = self.nodeList or {}

	_.each(self.nodeList, function(arg_8_0)
		self._parentClass.loader:ClearRequest((tf(arg_8_0.GO)))

		if not self.nodePools[arg_8_0.GoType]:Enqueue(go(arg_8_0.GO)) then
			setParent(go(arg_8_0.GO), self.pluralRoot)
			setActive(go(arg_8_0.GO), false)
		end

		return
	end)
	table.clean(self.nodeList)
	setAnchoredPosition(self.viewContent, Vector2.zero)

	local var_6_0 = 0

	_.each(arg_6_1:GetCircleList(), function(arg_9_0)
		local var_9_0 = AtelierFormulaCircle.New({
			configId = arg_9_0
		})
		local var_9_1 = var_9_0:GetNeighbors()[1] == 1 and "core" or "material"
		local var_9_3 = self.nodePools[nil]:Dequeue()

		var_9_3.name = arg_9_0

		setActive(var_9_3, true)
		setParent(tf(var_9_3), self.viewContent)

		var_6_0 = var_6_0 + 1

		local var_9_4 = {
			Change = true,
			ID = var_6_0,
			Data = var_9_0,
			GO = var_9_3,
			GoType = var_9_1
		}

		table.insert(self.nodeList, var_9_4)

		if var_9_0:GetNeighbors()[1] ~= 1 then
			self:HideNodeLight(var_9_4)
		end

		setActive(var_9_3:Find("select"), false)

		return
	end)
	self:InitNodeLayer()
	self:SetCirclePanel()
	self:UpdateFormulaDetail()
	self:InitLine(arg_6_1)
	self.atelierFormulaOverlayView:RefreshFormulaInfo(arg_6_1)
	self:RefreshScrollViewPosition()

	return
end

function AtelierFormulaDetailYumiaView:UpdateNodeView(arg_10_1)
	local var_10_0 = tf(arg_10_1.GO)
	local var_10_1 = arg_10_1.Data:GetElementName()
	local var_10_2 = self:IsLockNode(arg_10_1)

	setActive(arg_10_1.GO, not var_10_2)

	local var_10_3 = arg_10_1.Instance

	if table.contains(self.nodeLayer[1], arg_10_1.ID) then
		-- block empty
	else
		local var_10_4 = arg_10_1.Data:GetType()

		if var_10_4 == AtelierFormulaCircle.TYPE.NONE then
			self:RefreshElement(arg_10_1)
			self:HideCategory(arg_10_1)
		elseif var_10_4 == AtelierFormulaCircle.TYPE.ELEMENT then
			self:RefreshElement(arg_10_1)
			self:HideCategory(arg_10_1)
		elseif var_10_4 == AtelierFormulaCircle.TYPE.CATEGORY then
			self:RefreshElement(arg_10_1)
			self:RefreshCategory(arg_10_1)
		elseif var_10_4 == AtelierFormulaCircle.TYPE.ELEMENT_CATEGORY then
			self:RefreshElement(arg_10_1)
			self:RefreshCategory(arg_10_1)
		end

		if var_10_3 == nil then
			self:AddStarList(arg_10_1)
		end
	end

	onButton(self, var_10_0, function()
		if var_10_2 then
			return
		end

		self._parentClass:ShowMaterialSelectWindow(var_10_0, arg_10_1, self.nodeList)

		return
	end, SFX_PANEL)

	return
end

function AtelierFormulaDetailYumiaView:RefreshElement(arg_12_1)
	local var_12_0 = tf(arg_12_1.GO)

	GetImageSpriteFromAtlasAsync("ui/ateliercommonyumiaui_atlas", "slot_" .. AtelierFormulaCircle.ELEMENT_NAME[arg_12_1.Data:GetProp()], var_12_0:Find("icon"))
	setImageColor(var_12_0:Find("light"), arg_12_1.Data:GetElementLightColor(instance))

	return
end

function AtelierFormulaDetailYumiaView:RefreshCategory(arg_13_1)
	local var_13_0 = tf(arg_13_1.GO)
	local var_13_1 = arg_13_1.Data:GetCategory()

	if var_13_1 ~= 0 then
		GetImageSpriteFromAtlasAsync("ui/ateliercommonyumiaui_atlas", "category" .. var_13_1, var_13_0:Find("categoryBg/category"))
	end

	setActive(var_13_0:Find("categoryBg"), true)

	return
end

function AtelierFormulaDetailYumiaView:HideCategory(arg_14_1)
	setActive(tf(arg_14_1.GO):Find("categoryBg"), false)

	return
end

function AtelierFormulaDetailYumiaView:DisPlayUnlockEffect(arg_15_1, arg_15_2)
	self.unLockLayerIndex = arg_15_1

	self:RefreshLine()

	for iter_15_0, iter_15_1 in ipairs(self.nodeLayer[arg_15_1]) do
		self:UpdateNodeView(self.nodeList[iter_15_1])
	end

	existCall(arg_15_2)

	return
end

function AtelierFormulaDetailYumiaView:FillNodeAndPlayAnim(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self._parentClass:LoadingOn()

	arg_16_1.ChangeInstance = arg_16_1.ChangeInstance or tobool(arg_16_1.Instance) ~= tobool(arg_16_2)
	arg_16_1.Instance = arg_16_2
	arg_16_1.Change = true

	local var_16_0 = {}
	local var_16_1 = {}

	seriesAsync({
		function(arg_17_0)
			table.ParallelIpairsAsync({
				"ui/laisha_ui_wupinzhiru",
				"ui/laisha_ui_baoshi"
			}, function(arg_18_0, arg_18_1, arg_18_2)
				var_16_0[arg_18_0] = self._parentClass.loader:GetPrefab(arg_18_1, "", function(arg_19_0)
					setParent(arg_19_0, tf(arg_16_1.GO))
					setAnchoredPosition(arg_19_0, Vector2.zero)

					var_16_1[arg_18_0] = arg_19_0

					setActive(arg_19_0, false)
					arg_18_2()

					return
				end)

				return
			end, arg_17_0)

			return
		end,
		function(arg_20_0)
			setActive(var_16_1[1], true)
			self:PlayStarAnimation(arg_16_1)
			self._parentClass:managedTween(LeanTween.delayedCall, function()
				if not arg_16_4 then
					for iter_21_0, iter_21_1 in ipairs(self.nodeLayer[self.unLockLayerIndex]) do
						self:UpdateNodeView(self.nodeList[iter_21_1])
					end
				else
					self:UpdateNodeView(arg_16_1)
				end

				self._parentClass:PlaySoundEffect(self._parentClass.soundStr.formulaDetailFill)
				arg_20_0()

				return
			end, 0.2, nil)

			return
		end,
		function(arg_22_0)
			setActive(var_16_1[2], true)
			self._parentClass:managedTween(LeanTween.delayedCall, function()
				arg_22_0()

				return
			end, 0.5, nil)

			return
		end,
		function(arg_24_0)
			self._parentClass.loader:ClearRequest(var_16_0[1])
			self._parentClass.loader:ClearRequest(var_16_0[2])
			self._parentClass:LoadingOff()
			self:RefreshBtn()
			existCall(arg_16_3)

			return
		end
	})

	return
end

function AtelierFormulaDetailYumiaView:InitLine(arg_25_1)
	local var_25_0 = arg_25_1:GetShapeID()

	for iter_25_0, iter_25_1 in ipairs(self.lineGoList) do
		setActive(iter_25_1, iter_25_0 == var_25_0)

		if iter_25_0 == var_25_0 then
			self.lineGo = iter_25_1
		end
	end

	self:RefreshLine()

	return
end

function AtelierFormulaDetailYumiaView:RefreshLine()
	for iter_26_0 = 0, self.lineGo.childCount - 1 do
		setActive(self.lineGo:GetChild(iter_26_0), iter_26_0 < self.unLockLayerIndex - 1)
	end

	return
end

function AtelierFormulaDetailYumiaView:RefreshBtn()
	return
end

function AtelierFormulaDetailYumiaView:RefreshScrollViewPosition()
	if self.nodeList[1].Instance == nil then
		setAnchoredPosition(self._parentClass.scrollView, Vector2.zero)
		setAnchoredPosition(self.viewContent, Vector2.zero)
		self.atelierFormulaOverlayView:Show(true)
		self._parentClass:ShowTopBar(false)
		self:HideCompositePanel()
		setText(self.tipsText, i18n("yumia_atelier_tip7"))
	else
		self:HideDescriptionView()
		self:ShowCompositePanel()
		setText(self.tipsText, i18n("yumia_atelier_tip17"))
	end

	return
end

function AtelierFormulaDetailYumiaView:HideDescriptionView()
	self.atelierFormulaOverlayView:Show(false)
	self._parentClass:ShowTopBar(true)
	setAnchoredPosition(self._parentClass.scrollView, Vector2(-397, 0))

	return
end

function AtelierFormulaDetailYumiaView:ShowCompositePanel()
	setActive(self.compositePanel, true)

	return
end

function AtelierFormulaDetailYumiaView:HideCompositePanel()
	setActive(self.compositePanel, false)

	return
end

function AtelierFormulaDetailYumiaView:AddStarList(arg_32_1)
	local var_32_0 = arg_32_1.GO:Find("starContant")

	self:HideStarList(arg_32_1)

	if type((arg_32_1.Data:GetStarList())) ~= "table" then
		return
	end

	for iter_32_0, iter_32_1 in ipairs(arg_32_1.Data:GetStarList()) do
		local var_32_1 = iter_32_0 <= var_32_0.childCount and var_32_0:GetChild(iter_32_0 - 1) or cloneTplTo(var_32_0:GetChild(0), var_32_0)

		setActive(var_32_1, true)
		setAnchoredPosition(var_32_1, Vector2(unpack(iter_32_1)))
	end

	return
end

function AtelierFormulaDetailYumiaView:PlayStarAnimation(arg_33_1)
	self:ShowNodeLight(arg_33_1)

	if type((arg_33_1.Data:GetStarList())) ~= "table" then
		return
	end

	local var_33_0 = arg_33_1.GO:Find("starContant")

	for iter_33_0 = 0, var_33_0.childCount - 1 do
		self._parentClass:managedTween(LeanTween.moveLocal, nil, var_33_0:GetChild(iter_33_0).gameObject, Vector3.zero, 0.5)
	end

	self._parentClass:managedTween(LeanTween.delayedCall, function()
		self:HideStarList(arg_33_1)

		return
	end, 0.5, nil)

	return
end

function AtelierFormulaDetailYumiaView:HideStarList(arg_35_1)
	local var_35_0 = arg_35_1.GO:Find("starContant")

	for iter_35_0 = 0, var_35_0.childCount - 1 do
		setActive(var_35_0:GetChild(iter_35_0), false)
	end

	return
end

function AtelierFormulaDetailYumiaView:ShowNodeLight(arg_36_1)
	if arg_36_1.Data:GetNeighbors()[1] == 1 then
		return
	end

	setActive(arg_36_1.GO:Find("light"), true)

	return
end

function AtelierFormulaDetailYumiaView:HideNodeLight(arg_37_1)
	setActive(arg_37_1.GO:Find("light"), false)

	return
end

function AtelierFormulaDetailYumiaView:InitStr()
	self.ringEffect = {
		[AtelierFormulaCircle.ELEMENT_TYPE.PYRO] = "laisha_ui_huo",
		[AtelierFormulaCircle.ELEMENT_TYPE.CRYO] = "laisha_ui_bing",
		[AtelierFormulaCircle.ELEMENT_TYPE.ELECTRO] = "laisha_ui_lei",
		[AtelierFormulaCircle.ELEMENT_TYPE.ANEMO] = "laisha_ui_feng",
		[AtelierFormulaCircle.ELEMENT_TYPE.SAIREN] = "laisha_ui_sairen"
	}
	self.deployEffect = "laisha_ui_wupinshanguang"
	self.unlockEffect = "laisha_ui_jiesuo"
	self.circleTypeList = {
		AtelierFormulaCircle.TYPE.ELEMENT_CATEGORY,
		AtelierFormulaCircle.TYPE.CATEGORY,
		AtelierFormulaCircle.TYPE.ELEMENT,
		AtelierFormulaCircle.TYPE.NONE
	}

	return
end

function AtelierFormulaDetailYumiaView:InitNodeLayer()
	self.nodeLayer = {
		{}
	}

	for iter_39_0, iter_39_1 in ipairs(self.nodeList) do
		local var_39_0 = iter_39_1.Data:GetNeighbors()

		self.nodeLayer[var_39_0[1]] = self.nodeLayer[var_39_0[1]] or {}

		table.insert(self.nodeLayer[var_39_0[1]], iter_39_0)
	end

	return
end

function AtelierFormulaDetailYumiaView:SetCirclePanel()
	self:SetCirclePosition()
	setSizeDelta(self.viewContent, (self.viewMax + Vector2.New(280, 280)) * 2)

	return
end

function AtelierFormulaDetailYumiaView:SetCirclePosition()
	local var_41_0 = 0
	local var_41_1 = 0

	_.each(self.nodeList, function(arg_42_0)
		local var_42_0 = arg_42_0.Data:GetNeighbors()

		setAnchoredPosition(arg_42_0.GO, (Vector2(var_42_0[2], var_42_0[3])))

		var_41_0 = math.max(var_41_0, math.abs(var_42_0[2]))
		var_41_1 = math.max(var_41_1, math.abs(var_42_0[3]))

		return
	end)

	self.viewMax = Vector2(0, 0)

	return
end

return AtelierFormulaDetailYumiaView
