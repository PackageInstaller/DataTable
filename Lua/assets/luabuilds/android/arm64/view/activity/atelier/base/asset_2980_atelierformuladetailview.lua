local AtelierFormulaDetailView = class("AtelierFormulaDetailView", import("view.base.BasePanel"))
local PoolPlural = import("Mgr.Pool.PoolPlural")

function AtelierFormulaDetailView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject
	self._tf = arg_1_1
	self._parentClass = arg_1_2
	self.bundleName = arg_1_2.bundleName
	self.commonBundleName = arg_1_2.commonBundleName

	self:attach(arg_1_2)
	self:Init()
	self:InitStr()

	self.layerFormulaDescriptionPanel = self._tf:Find("Overlay/Description")

	self:InitCustom()

	return
end

function AtelierFormulaDetailView:InitCustom()
	self.atelierFormulaOverlayView = AtelierFormulaOverlayView.New(self.layerFormulaDescriptionPanel, self._parentClass)

	return
end

function AtelierFormulaDetailView:Init()
	self.viewContent = self._parentClass.scrollView:Find("Content")

	setActive(self._go, false)

	return
end

function AtelierFormulaDetailView:SetContextData(arg_4_1)
	self.contextData = arg_4_1

	self.atelierFormulaOverlayView:SetContextData(arg_4_1)

	return
end

function AtelierFormulaDetailView:SetActivity(arg_5_1)
	self.activity = arg_5_1

	self.atelierFormulaOverlayView:SetActivity(arg_5_1)

	return
end

function AtelierFormulaDetailView:didEnter()
	onButton(self, self._tf:Find("Composite"), function()
		self:OnClickComposite()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("AutoFill"), function()
		self:OnClickAutoFill()

		return
	end, SFX_PANEL)
	self.atelierFormulaOverlayView:didEnter()

	return
end

function AtelierFormulaDetailView:Show(arg_9_1)
	setActive(self._go, true)
	self.atelierFormulaOverlayView:RefreshFormulaInfo(arg_9_1)

	self.unLockLayerIndex = 1

	if not self.nodePools then
		self.nodePools = {
			circle = PoolPlural.New(self._tf:Find("CircleNode").gameObject, 100),
			hexagon = PoolPlural.New(self._tf:Find("HexagonNode").gameObject, 100),
			anyHexagon = PoolPlural.New(self._tf:Find("AnyHexagonNode").gameObject, 100),
			doubleHexagon = PoolPlural.New(self._tf:Find("DoubleHexagonNode").gameObject, 100)
		}

		table.Foreach(self.nodePools, function(arg_10_0, arg_10_1)
			setActive(arg_10_1.prefab, false)

			return
		end)
	end

	self.pluralRoot = self.pluralRoot or pg.PoolMgr.GetInstance().root
	self.nodeList = self.nodeList or {}

	_.each(self.nodeList, function(arg_11_0)
		local var_11_0 = tf(arg_11_0.GO)

		SetComponentEnabled(var_11_0:Find("Item"), typeof(Image), false)
		self._parentClass.loader:ClearRequest(var_11_0:Find("Ring"))
		self:CleanNodeLinks(arg_11_0)
		self._parentClass.loader:ClearRequest(var_11_0)

		if not self.nodePools[self.poolNames[arg_11_0.Data:GetType()]]:Enqueue(go(arg_11_0.GO)) then
			setParent(go(arg_11_0.GO), self.pluralRoot)
			setActive(go(arg_11_0.GO), false)
		end

		return
	end)
	table.clean(self.nodeList)
	setAnchoredPosition(self.viewContent, Vector2.zero)

	local var_9_0 = 0

	_.each(arg_9_1:GetCircleList(), function(arg_12_0)
		local var_12_0 = AtelierFormulaCircle.New({
			configId = arg_12_0
		})
		local var_12_1 = self.nodePools[self.poolNames[var_12_0:GetType()]]:Dequeue()

		var_12_1.name = arg_12_0

		setActive(var_12_1, true)
		setParent(tf(var_12_1), self.viewContent)

		var_9_0 = var_9_0 + 1

		table.insert(self.nodeList, {
			Change = true,
			ID = var_9_0,
			Data = var_12_0,
			GO = var_12_1
		})

		return
	end)
	self:InitNodeLayer()
	self:SetCirclePanel()
	self:UpdateFormulaDetail()

	return
end

function AtelierFormulaDetailView:OnClickComposite()
	if not _.all(self.nodeList, function(arg_14_0)
		return arg_14_0.Instance
	end) then
		self._parentClass:ShowMaterialsPreview()

		return
	end

	if not self.activity:GetFormulas()[self.contextData.formulaId]:IsAvaliable() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_composite_invalid"))

		return
	end

	self._parentClass:ShowCompositeConfirmWindow(self.nodeList)

	return
end

function AtelierFormulaDetailView:OnClickAutoFill()
	self.temps = {}

	local var_15_0 = {}

	_.each(self.nodeList, function(arg_16_0)
		if arg_16_0.Instance then
			self:UseMat(arg_16_0.Instance)
		else
			table.insert(var_15_0, arg_16_0)
		end

		return
	end)

	if #var_15_0 <= 0 then
		return
	end

	self:AutoFillAllNode(var_15_0)

	return
end

function AtelierFormulaDetailView:UseMat(arg_17_1)
	local var_17_0 = self.temps[arg_17_1:GetConfigID()] or Clone(self.activity:GetItems()[arg_17_1:GetConfigID()])

	var_17_0.count = var_17_0.count - 1
	self.temps[arg_17_1:GetConfigID()] = var_17_0

	return
end

function AtelierFormulaDetailView:FillNode(arg_18_1, arg_18_2)
	local var_18_0 = {}

	table.insert(var_18_0, function(arg_19_0)
		self:FillNodeAndPlayAnim(arg_18_1, AtelierMaterial.New({
			count = 1,
			configId = arg_18_2:GetConfigID()
		}), arg_19_0, true)

		return
	end)

	local var_18_1 = self.unLockLayerIndex
	local var_18_2 = _.select(self.nodeLayer[self.unLockLayerIndex], function(arg_20_0)
		return self.nodeList[arg_20_0].Instance == nil
	end)

	if self.unLockLayerIndex < #self.nodeLayer and #var_18_2 == 1 and var_18_2[1] == arg_18_1.ID then
		table.insert(var_18_0, function(arg_21_0)
			self:DisPlayUnlockEffect(var_18_1 + 1, arg_21_0)

			return
		end)
	end

	table.insert(var_18_0, function(arg_22_0)
		self:UpdateFormulaDetail()
		arg_22_0()

		return
	end)
	seriesAsync(var_18_0)

	return
end

function AtelierFormulaDetailView:AutoFillAllNode(arg_23_1)
	local var_23_0 = {}
	local var_23_1 = false

	for iter_23_0, iter_23_1 in ipairs(self.nodeLayer) do
		local var_23_2 = {}

		for iter_23_2, iter_23_3 in ipairs(iter_23_1) do
			if self.nodeList[iter_23_3] and self.nodeList[iter_23_3].Instance ~= nil then
				-- block empty
			else
				table.insert(var_23_2, self.nodeList[iter_23_3])
			end
		end

		if #var_23_2 > 0 then
			local var_23_3 = false

			if iter_23_0 == 1 then
				for iter_23_4, iter_23_5 in ipairs(var_23_2) do
					local var_23_4 = iter_23_5.Data:GetLimitItemID()

					if var_23_4 ~= 0 then
						local var_23_5 = self.temps[var_23_4] or self.activity:GetItems()[var_23_4]

						if var_23_5 and var_23_5.count > 0 then
							self:UseMat(var_23_5)
							table.insert(var_23_0, function(arg_24_0)
								self:FillNodeAndPlayAnim(iter_23_5, AtelierMaterial.New({
									count = 1,
									configId = var_23_4
								}), arg_24_0, true)

								return
							end)
						else
							var_23_3 = true
						end
					else
						local var_23_6 = self.activity:GetFormulas()[self.contextData.formulaId]

						for iter_23_6, iter_23_7 in ipairs(self.circleTypeList) do
							if iter_23_5.Data:GetType() == iter_23_7 then
								local var_23_7 = false

								for iter_23_8, iter_23_9 in ipairs(pg.activity_ryza_item.all) do
									local var_23_8 = self.temps[iter_23_9] or self.activity:GetItems()[iter_23_9]

									if var_23_8 and var_23_8.count > 0 and var_23_8:IsNormal() and iter_23_5.Data:CanUseMaterial(var_23_8, var_23_6, self.contextData.versionIndex) then
										self:UseMat(var_23_8)
										table.insert(var_23_0, function(arg_25_0)
											self:FillNodeAndPlayAnim(iter_23_5, AtelierMaterial.New({
												count = 1,
												configId = var_23_8:GetConfigID()
											}), arg_25_0, true)

											return
										end)

										var_23_7 = true

										break
									end
								end

								if not var_23_7 then
									var_23_3 = true
								end
							end
						end
					end
				end
			else
				table.insert(var_23_0, function(arg_26_0)
					self._parentClass:PlaySoundEffect(self._parentClass.soundStr.formulaDetail)
					arg_26_0()

					return
				end)

				local var_23_9 = self.activity:GetFormulas()[self.contextData.formulaId]
				local var_23_10 = {}

				for iter_23_10, iter_23_11 in ipairs(self.circleTypeList) do
					_.each(var_23_2, function(arg_27_0)
						if arg_27_0.Data:GetType() == iter_23_11 then
							local var_27_0 = false

							for iter_27_0, iter_27_1 in ipairs(pg.activity_ryza_item.all) do
								local var_27_1 = self.temps[iter_27_1] or self.activity:GetItems()[iter_27_1]

								if var_27_1 and var_27_1.count > 0 and var_27_1:IsNormal() and arg_27_0.Data:CanUseMaterial(var_27_1, var_23_9, self.contextData.versionIndex) then
									self:UseMat(var_27_1)
									table.insert(var_23_10, function()
										self:FillNodeAndPlayAnim(arg_27_0, AtelierMaterial.New({
											count = 1,
											configId = var_27_1:GetConfigID()
										}), true)

										return
									end)

									var_27_0 = true

									break
								end
							end

							if not var_27_0 then
								var_23_3 = true
							end
						end

						return
					end)
				end

				if #var_23_10 > 0 then
					table.insert(var_23_0, function(arg_29_0)
						for iter_29_0, iter_29_1 in ipairs(var_23_10) do
							iter_29_1()
						end

						self._parentClass:managedTween(LeanTween.delayedCall, function()
							arg_29_0()

							return
						end, 0.7, nil)

						return
					end)
				end
			end

			if var_23_3 then
				var_23_1 = true

				table.insert(var_23_0, function(arg_31_0)
					pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_material_not_enough"))
					arg_31_0()

					return
				end)

				break
			end

			if iter_23_0 < #self.nodeLayer then
				table.insert(var_23_0, function(arg_32_0)
					self:DisPlayUnlockEffect(iter_23_0 + 1, arg_32_0)

					return
				end)
			end
		end
	end

	if #var_23_0 > 0 and (#var_23_0 ~= 1 or not var_23_1) then
		table.insert(var_23_0, 1, function(arg_33_0)
			self._parentClass:DispalyChat(self._parentClass.chatText.selectMaterial)
			arg_33_0()

			return
		end)
	end

	seriesAsync(var_23_0)

	return
end

function AtelierFormulaDetailView:FillNodeAndPlayAnim(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	self._parentClass:LoadingOn()

	arg_34_1.ChangeInstance = arg_34_1.ChangeInstance or tobool(arg_34_1.Instance) ~= tobool(arg_34_2)
	arg_34_1.Instance = arg_34_2
	arg_34_1.Change = true

	local var_34_0 = {}
	local var_34_1 = {}

	seriesAsync({
		function(arg_35_0)
			table.ParallelIpairsAsync({
				"ui/laisha_ui_wupinzhiru",
				"ui/laisha_ui_baoshi"
			}, function(arg_36_0, arg_36_1, arg_36_2)
				var_34_0[arg_36_0] = self._parentClass.loader:GetPrefab(arg_36_1, "", function(arg_37_0)
					setParent(arg_37_0, tf(arg_34_1.GO))
					setAnchoredPosition(arg_37_0, Vector2.zero)

					var_34_1[arg_36_0] = arg_37_0

					setActive(arg_37_0, false)
					arg_36_2()

					return
				end)

				return
			end, arg_35_0)

			return
		end,
		function(arg_38_0)
			setActive(var_34_1[1], true)
			self._parentClass:managedTween(LeanTween.delayedCall, function()
				if not arg_34_4 then
					for iter_39_0, iter_39_1 in ipairs(self.nodeLayer[self.unLockLayerIndex]) do
						self:UpdateNodeView(self.nodeList[iter_39_1])
					end
				else
					self:UpdateNodeView(arg_34_1)
				end

				self._parentClass:PlaySoundEffect(self._parentClass.soundStr.formulaDetailFill)
				arg_38_0()

				return
			end, 0.2, nil)

			return
		end,
		function(arg_40_0)
			setActive(var_34_1[2], true)
			self._parentClass:managedTween(LeanTween.delayedCall, function()
				arg_40_0()

				return
			end, 0.5, nil)

			return
		end,
		function(arg_42_0)
			self._parentClass.loader:ClearRequest(var_34_0[1])
			self._parentClass.loader:ClearRequest(var_34_0[2])
			self._parentClass:LoadingOff()
			self:RefreshBtn()
			existCall(arg_34_3)

			return
		end
	})

	return
end

function AtelierFormulaDetailView:DisPlayUnlockEffect(arg_43_1, arg_43_2)
	self._parentClass:LoadingOn()

	local var_43_0 = {}

	for iter_43_0, iter_43_1 in ipairs(self.nodeLayer[arg_43_1]) do
		local var_43_1 = self.nodeList[iter_43_1]

		table.insert(var_43_0, (self._parentClass.loader:GetPrefab("ui/" .. self.unlockEffect, "", function(arg_44_0)
			setParent(arg_44_0, tf(var_43_1.GO))
			setAnchoredPosition(arg_44_0, Vector2.zero)

			return
		end)))
	end

	self._parentClass:managedTween(LeanTween.delayedCall, function()
		self._parentClass:PlaySoundEffect(self._parentClass.soundStr.formulaDetailUnlock)

		return
	end, 0.7, nil)
	self._parentClass:managedTween(LeanTween.delayedCall, function()
		_.each(var_43_0, function(arg_47_0)
			self._parentClass.loader:ClearRequest(arg_47_0)

			return
		end)
		self._parentClass:LoadingOff()

		self.unLockLayerIndex = arg_43_1

		existCall(arg_43_2)

		return
	end, 1.7, nil)

	return
end

function AtelierFormulaDetailView:UpdateFormulaDetail()
	_.each(self.nodeList, function(arg_49_0)
		self:UpdateNodeView(arg_49_0)

		return
	end)
	self:RefreshBtn()

	return
end

function AtelierFormulaDetailView:RefreshBtn()
	local var_50_0 = #self.nodeList
	local var_50_1 = #_.select(self.nodeList, function(arg_51_0)
		return arg_51_0.Instance ~= nil
	end)

	setText(self._tf:Find("Bar/Text"), i18n("ryza_tip_put_materials", var_50_1, #self.nodeList))
	setGray(self._tf:Find("AutoFill"), not self.activity:GetFormulas()[self.contextData.formulaId]:IsAvaliable())
	setActive(self._tf:Find("Composite/Disabled"), var_50_1 < var_50_0)

	return
end

function AtelierFormulaDetailView:UpdateNodeView(arg_52_1)
	self:RefreshNodeLinks(arg_52_1)

	local var_52_0 = tf(arg_52_1.GO)
	local var_52_1 = arg_52_1.Data
	local var_52_2 = arg_52_1.Data:GetElementName()
	local var_52_3 = self:IsLockNode(arg_52_1)

	setActive(var_52_0:Find("Lock"), var_52_3)

	if var_52_3 then
		if var_52_1:GetType() ~= AtelierFormulaCircle.TYPE.ANY then
			self._parentClass.loader:GetSpriteQuiet(self.commonBundleName, "element_" .. var_52_2, var_52_0:Find("Lock/Require/Icon"))
		end

		setText(var_52_0:Find("Lock/Require/Text"), "X" .. var_52_1:GetLevel())
	end

	for iter_52_0 = 3, var_52_1:GetLevel() + 1, -1 do
		self._parentClass.loader:GetSpriteQuiet(self.bundleName, "slot_BLOCKED", var_52_0:Find("Slots"):GetChild(iter_52_0 - 1):Find("Image"))
	end

	local var_52_4 = arg_52_1.Instance
	local var_52_5 = var_52_0:Find("Item")

	if not arg_52_1.Instance then
		if var_52_1:GetType() == AtelierFormulaCircle.TYPE.ANY then
			setActive(var_52_0:Find("All"), true)
		else
			setActive(var_52_0:Find("Icon"), true)
			self._parentClass.loader:GetSpriteQuiet(self.bundleName, "icon_" .. var_52_2, var_52_0:Find("Icon"), true)
		end

		setActive(var_52_5, false)

		if var_52_1:GetType() == AtelierFormulaCircle.TYPE.BASE or var_52_1:GetType() == AtelierFormulaCircle.TYPE.SAIREN then
			local var_52_6 = AtelierMaterial.New({
				configId = var_52_1:GetLimitItemID()
			})

			setActive(var_52_0:Find("Name"), true)
			setScrollText(var_52_0:Find("Name/Rect/Text"), var_52_6:GetName())
		else
			setActive(var_52_0:Find("Name"), false)
		end

		for iter_52_1 = 1, var_52_1:GetLevel() do
			self._parentClass.loader:GetSpriteQuiet(self.bundleName, "slot_NULL", var_52_0:Find("Slots"):GetChild(iter_52_1 - 1):Find("Image"))
		end
	else
		local var_52_7 = AtelierFormulaCircle.ELEMENT_NAME[var_52_1:GetRingElement(var_52_4)]

		if var_52_1:GetType() == AtelierFormulaCircle.TYPE.ANY then
			setActive(var_52_0:Find("All"), false)
		else
			setActive(var_52_0:Find("Icon"), false)
		end

		setActive(var_52_5, true)

		local var_52_8 = (var_52_1:GetType() == AtelierFormulaCircle.TYPE.BASE or var_52_1:GetType() == AtelierFormulaCircle.TYPE.SAIREN) and var_52_4:GetBaseCircleTransform() or var_52_4:GetNormalCircleTransform()

		setLocalScale(var_52_5, Vector3.New(unpack(var_52_8, 1, 3)))
		setAnchoredPosition(var_52_5, Vector2.New(unpack(var_52_8, 4, 5)))
		self._parentClass.loader:GetSpriteQuiet(var_52_4:GetIconPath(), "", var_52_5, true)
		setActive(var_52_0:Find("Name"), true)
		setScrollText(var_52_0:Find("Name/Rect/Text"), var_52_4:GetName())

		for iter_52_2 = 1, var_52_1:GetLevel() do
			self._parentClass.loader:GetSpriteQuiet(self.bundleName, "slot_" .. var_52_7, var_52_0:Find("Slots"):GetChild(iter_52_2 - 1):Find("Image"))
		end
	end

	local var_52_9 = var_52_0:Find("Ring")

	setImageColor(var_52_9, var_52_1:GetElementRingColor(var_52_4))

	if arg_52_1.Change then
		local var_52_10 = arg_52_1.Data:GetRingElement(var_52_4)

		if var_52_3 then
			var_52_10 = nil
		end

		if self.ringEffect[var_52_10] then
			self._parentClass.loader:GetPrefab("ui/" .. self.ringEffect[var_52_10] .. (arg_52_1.Data:GetType() == AtelierFormulaCircle.TYPE.BASE and "_o" or "_6"), "", function(arg_53_0)
				setParent(arg_53_0, var_52_9)
				setAnchoredPosition(arg_53_0, Vector2.zero)

				return
			end, var_52_9)
		else
			self._parentClass.loader:ClearRequest(var_52_9)
		end

		self:RefreshNodeLinkEffects(var_52_0, arg_52_1, var_52_3)

		arg_52_1.Change = nil
	end

	if arg_52_1.ChangeInstance then
		if var_52_4 then
			self._parentClass.loader:GetPrefab("ui/" .. self.deployEffect, "", function(arg_54_0)
				setParent(arg_54_0, var_52_5)
				setAnchoredPosition(arg_54_0, Vector2.zero)

				return
			end, var_52_0)
		else
			self._parentClass.loader:ClearRequest(var_52_0)
		end

		arg_52_1.ChangeInstance = nil
	end

	onButton(self, var_52_0, function()
		if var_52_3 then
			return
		end

		self._parentClass:ShowMaterialSelectWindow(var_52_0, arg_52_1, self.nodeList)

		return
	end, SFX_PANEL)

	return
end

function AtelierFormulaDetailView:IsLockNode(arg_56_1)
	local var_56_0 = 1

	for iter_56_0, iter_56_1 in ipairs(self.nodeLayer) do
		if _.detect(iter_56_1, function(arg_57_0)
			return self.nodeList[arg_57_0] == arg_56_1
		end) ~= ni then
			var_56_0 = iter_56_0

			break
		end
	end

	if var_56_0 > self.unLockLayerIndex then
		return true
	end

	return false
end

function AtelierFormulaDetailView:willExit()
	self.atelierFormulaOverlayView:willExit()

	self.atelierFormulaOverlayView = nil

	self:detach()

	return
end

function AtelierFormulaDetailView:InitStr()
	self.poolNames = {
		[AtelierFormulaCircle.TYPE.BASE] = "circle",
		[AtelierFormulaCircle.TYPE.NORMAL] = "hexagon",
		[AtelierFormulaCircle.TYPE.SAIREN] = "doubleHexagon",
		[AtelierFormulaCircle.TYPE.ANY] = "anyHexagon",
		[AtelierFormulaCircle.TYPE.NONE] = "circle",
		[AtelierFormulaCircle.TYPE.ELEMENT] = "hexagon",
		[AtelierFormulaCircle.TYPE.CATEGORY] = "doubleHexagon",
		[AtelierFormulaCircle.TYPE.ELEMENT_CATEGORY] = "doubleHexagon"
	}
	self.lineEffect = {
		"laisha_ui_lianjie01",
		"laisha_ui_lianjie02",
		"laisha_ui_lianjie_qiehuan"
	}
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
		AtelierFormulaCircle.TYPE.BASE,
		AtelierFormulaCircle.TYPE.NORMAL,
		AtelierFormulaCircle.TYPE.SAIREN,
		AtelierFormulaCircle.TYPE.ANY
	}

	return
end

function AtelierFormulaDetailView:InitNodeLayer()
	self.nodeLayer = {
		{}
	}

	for iter_60_0, iter_60_1 in pairs(self.nodeList) do
		local var_60_0 = iter_60_1.Data:GetType()

		if var_60_0 == AtelierFormulaCircle.TYPE.BASE or var_60_0 == AtelierFormulaCircle.TYPE.SAIREN then
			self.nodeLayer[1] = self.nodeLayer[1] or {}

			table.insert(self.nodeLayer[1], iter_60_0)
		else
			self.nodeLayer[2] = self.nodeLayer[2] or {}

			table.insert(self.nodeLayer[2], iter_60_0)
		end
	end

	for iter_60_2 = #self.nodeLayer, 1, -1 do
		if #self.nodeLayer[iter_60_2] == 0 then
			table.remove(self.nodeLayer, iter_60_2)
		end
	end

	return
end

function AtelierFormulaDetailView:SetCirclePanel()
	self.axisX, self.axisY = 280 * Vector2.New(math.cos(math.deg2Rad * 30), math.sin(math.deg2Rad * 30)), 280 * Vector2(0, 1)
	self.viewMax = Vector2.zero

	self:SetCirclePosition(self.nodeList[1], Vector2.zero)
	setSizeDelta(self.viewContent, (self.viewMax + Vector2.New(280, 280)) * 2)

	return
end

local var_0_2 = {
	{
		0,
		1
	},
	{
		-1,
		1
	},
	{
		-1,
		0
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	},
	{
		1,
		0
	}
}

function AtelierFormulaDetailView:SetCirclePosition(arg_62_1, arg_62_2)
	setAnchoredPosition(arg_62_1.GO, arg_62_2)

	arg_62_1.links = {}

	_.each(arg_62_1.Data:GetNeighbors(), function(arg_63_0)
		local var_63_0 = arg_63_0[2]
		local var_63_1 = var_0_2[arg_63_0[1]][1] * self.axisX + var_0_2[arg_63_0[1]][2] * self.axisY
		local var_63_2 = _.detect(self.nodeList, function(arg_64_0)
			return arg_64_0.Data:GetConfigID() == var_63_0
		end)

		var_63_2.prevLink = {
			(arg_63_0[1] + 2) % 5 + 1,
			arg_62_1
		}
		arg_62_1.links[arg_63_0[1]] = var_63_2

		self:SetCirclePosition(var_63_2, arg_62_2 + var_63_1)

		self.viewMax = Vector2.Max(self.viewMax, -(arg_62_2 + var_63_1))
		self.viewMax = Vector2.Max(self.viewMax, arg_62_2 + var_63_1)

		return
	end)

	return
end

function AtelierFormulaDetailView:RefreshNodeLinks(arg_65_1)
	local var_65_0 = tf(arg_65_1.GO)

	for iter_65_0 = 1, 6 do
		setActive(var_65_0:Find("Links"):GetChild(iter_65_0 - 1), false)
	end

	_.each(arg_65_1.Data:GetNeighbors(), function(arg_66_0)
		setActive(var_65_0:Find("Links"):GetChild(arg_66_0[1] - 1), true)

		return
	end)

	return
end

function AtelierFormulaDetailView:RefreshNodeLinkEffects(arg_67_1, arg_67_2, arg_67_3)
	table.Foreach(arg_67_2.links, function(arg_68_0, arg_68_1)
		local var_68_0 = arg_67_1:Find("Links/" .. arg_68_0)
		local var_68_1 = self.lineEffect[3]

		if arg_68_1.Lock and arg_67_3 then
			var_68_1 = self.lineEffect[1]
		elseif not arg_68_1.Lock and not arg_67_3 then
			var_68_1 = self.lineEffect[2]
		end

		self._parentClass.loader:GetPrefab("ui/" .. var_68_1, "", function(arg_69_0)
			setParent(arg_69_0, var_68_0:Find("Link"))
			setAnchoredPosition(arg_69_0, Vector2.New(0, -15))

			return
		end, var_68_0)

		return
	end)

	return
end

function AtelierFormulaDetailView:CleanNodeLinks(arg_70_1)
	table.Foreach(arg_70_1.links, function(arg_71_0)
		self._parentClass.loader:ClearRequest((nodeTF:Find("Links/" .. arg_71_0)))

		return
	end)

	return
end

return AtelierFormulaDetailView
