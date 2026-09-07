local AtelierCompositeBaseScene = class("AtelierCompositeBaseScene", import("view.base.BaseUI"))

function AtelierCompositeBaseScene:getUIName()
	return "AtelierCompositeUI"
end

function AtelierCompositeBaseScene:InitStr()
	self.bundleName = "ui/AtelierCompositeUI_atlas"
	self.commonBundleName = "ui/AtelierCommonUI_atlas"
	self.chatText = {
		idle = {
			"ryza_atellier1"
		},
		clickFormula = {
			"ryza_atellier2",
			"ryza_atellier3",
			"ryza_atellier4"
		},
		showMaterialSelectWindow = {
			"ryza_atellier2",
			"ryza_atellier3",
			"ryza_atellier4"
		},
		selectMaterial = {
			"ryza_atellier5",
			"ryza_atellier6",
			"ryza_atellier7"
		},
		compositeResult = {
			"ryza_atellier8",
			"ryza_atellier9"
		},
		compositeResult2 = {
			"ryza_atellier10",
			"ryza_atellier11"
		}
	}
	self.soundStr = {
		formulaDetailUnlock = "event:/ui/ryza_atellier_ui_3",
		showMaterialSelectWindow = "event:/ui/ryza_atellier_ui_1",
		compositeConfirm = "event:/ui/ryza_atellier_ui_6",
		selectMaterial = "event:/ui/ryza_atellier_ui_2",
		formulaDetail = "event:/ui/ryza_atellier_ui_5",
		clickFormula = "event:/ui/ryza_atellier_ui_1",
		formulaDetailFill = "event:/ui/ryza_atellier_ui_4"
	}
	self.helpStr = "ryza_composite_help_tip"
	self.tipStr = "ryza_composite_words"
	self.unlockText = "ryza_tip_composite_unlock"

	return
end

function AtelierCompositeBaseScene:InitView()
	self.atelierFormulaListView = AtelierFormulaListView.New(self.layerFormulaPanel, self)
	self.atelierFormulaDetailView = AtelierFormulaDetailView.New(self.layerFormulaDetailPanel, self)
	self.atelierMaterialSelectView = AtelierMaterialSelectView.New(self.materialSelectPanel, self)
	self.atelierMaterialsPreview = AtelierFormulaMaterialsPreview.New(self.materialsPreviewPanel, self)
	self.atelierCompositeConfirmView = AtelierCompositeConfirmView.New(self.compositeConfirmPanel, self)
	self.atelierCompositeResultView = AtelierCompositeResultView.New(self.compositeResultPanel, self)

	return
end

function AtelierCompositeBaseScene:OnClickStore()
	addSubLayer(Context.New({
		mediator = AtelierStoreBaseMediator,
		viewComponent = AtelierStoreBaseScene,
		data = {
			activity = self.activity
		}
	}), (getProxy(ContextProxy):getCurrentContext():getContextByMediator(AtelierCompositeMediator)))

	return
end

function AtelierCompositeBaseScene:preload(arg_5_1)
	self:InitStr()

	self.loader = AutoLoader.New()

	table.ParallelIpairsAsync({
		self.bundleName,
		self.commonBundleName
	}, function(arg_6_0, arg_6_1, arg_6_2)
		self.loader:LoadBundle(arg_6_1, arg_6_2)

		return
	end, arg_5_1)

	return
end

function AtelierCompositeBaseScene:init()
	self.top = self._tf:Find("Top")
	self.layerFormulaPanel = self._tf:Find("FormulaList")
	self.layerFormulaOverlayPanel = self._tf:Find("FormulaDetail/Overlay")
	self.layerFormulaDetailPanel = self._tf:Find("FormulaDetail")
	self.scrollView = self._tf:Find("FormulaDetail/ScrollView")
	self.materialSelectPanel = self._tf:Find("FormulaDetail/Overlay/AvaliableMaterials")
	self.materialsPreviewPanel = self._tf:Find("FormulaMaterialsPreview")
	self.compositeConfirmPanel = self._tf:Find("CompositeConfirmWindow")
	self.compositeResultPanel = self._tf:Find("CompositeResultWindow")

	self:InitCustom()
	setActive(self.layerEmpty, false)

	return
end

function AtelierCompositeBaseScene:InitCustom()
	self.layerEmpty = self._tf:Find("Empty")

	setText(self._tf:Find("Empty/Bar/Text"), i18n(self.unlockText))

	self.painting = self._tf:Find("Painting")
	self.chat = self.painting:Find("Chat")

	setActive(self.chat, false)
	pg.ViewUtils.SetSortingOrder(self._tf:Find("Mask/BG"):GetChild(0), -1)

	return
end

function AtelierCompositeBaseScene:SetContextData(arg_9_1)
	self.contextData = arg_9_1

	self.atelierFormulaListView:SetContextData(arg_9_1)
	self.atelierFormulaDetailView:SetContextData(arg_9_1)
	self.atelierMaterialSelectView:SetContextData(arg_9_1)
	self.atelierMaterialsPreview:SetContentData(arg_9_1)
	self.atelierCompositeConfirmView:SetContentData(arg_9_1)
	self.atelierCompositeResultView:SetContentData(arg_9_1)

	return
end

function AtelierCompositeBaseScene:SetActivity(arg_10_1)
	self.activity = arg_10_1

	self.atelierFormulaListView:SetActivity(arg_10_1)
	self.atelierFormulaDetailView:SetActivity(arg_10_1)
	self.atelierMaterialSelectView:SetActivity(arg_10_1)
	self.atelierMaterialsPreview:SetActivity(arg_10_1)
	self.atelierCompositeConfirmView:SetActivity(arg_10_1)
	self.atelierCompositeResultView:SetActivity(arg_10_1)

	return
end

function AtelierCompositeBaseScene:SetEnabled(arg_11_1)
	self.unlockSystem = arg_11_1

	return
end

function AtelierCompositeBaseScene:didEnter()
	self:RefreshEmptyPanel()
	self.atelierFormulaListView:didEnter()
	self.atelierFormulaDetailView:didEnter()
	self.atelierMaterialSelectView:didEnter()
	self.atelierMaterialsPreview:didEnter()
	self.atelierCompositeConfirmView:didEnter()
	self.atelierCompositeResultView:didEnter()
	onButton(self, self._tf:Find("Top/TopBar/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/TopBar/Home"), function()
		self:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/TopBar/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n(self.helpStr)
		})

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Top/TopBar/StoreHouse"), function()
		self:OnClickStore()

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():OverlayPanel(self.top)

	if self.unlockSystem then
		if self.contextData.formulaId then
			self:ShowFormulaDetail(self.activity:GetFormulas()[self.contextData.formulaId])
		else
			self:DispalyChat(self.chatText.idle)
			self:ShowFormulaList()
		end
	end

	self:PlayGuide()

	return
end

function AtelierCompositeBaseScene:PlayGuide()
	if self.unlockSystem then
		if PlayerPrefs.GetInt(string.format("first_enter_ryza_atelier_%s_%s", getProxy(PlayerProxy):getRawData().id, self.activity.id), 0) == 0 then
			triggerButton(self._tf:Find("Top/TopBar/Help"))
			PlayerPrefs.SetInt(string.format("first_enter_ryza_atelier_%s_%s", getProxy(PlayerProxy):getRawData().id, self.activity.id), 1)
		end
	end

	return
end

function AtelierCompositeBaseScene:willExit()
	self.loader:Clear()
	self:LoadingOff()
	self:HideChat()
	self:ClearSound()
	self.atelierMaterialsPreview:HideMaterialsPreview()
	self.atelierCompositeResultView:HideCompositeResult()
	self.atelierCompositeConfirmView:HideCompositeConfirmWindow()
	self.atelierMaterialSelectView:HideCandicatePanel()
	self:HideFormulaDetail()
	self:HideFormulaList()
	self.atelierFormulaListView:willExit()

	self.atelierFormulaListView = nil

	self.atelierFormulaDetailView:willExit()

	self.atelierFormulaDetailView = nil

	self.atelierMaterialSelectView:willExit()

	self.atelierMaterialSelectView = nil

	self.atelierMaterialsPreview:willExit()

	self.atelierMaterialsPreview = nil

	self.atelierCompositeConfirmView:willExit()

	self.atelierCompositeConfirmView = nil

	self.atelierCompositeResultView:willExit()

	self.atelierCompositeResultView = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(self.top, self._tf)

	if self.nodePools then
		for iter_18_0, iter_18_1 in pairs(self.nodePools) do
			iter_18_1:ClearItems()
		end
	end

	return
end

function AtelierCompositeBaseScene:UpdateRyzaDrop(arg_19_1, arg_19_2, arg_19_3)
	updateDrop(arg_19_1, arg_19_2)
	SetCompomentEnabled(arg_19_1:Find("icon_bg"), typeof(Image), false)
	setActive(arg_19_1:Find("bg"), false)
	setActive(arg_19_1:Find("icon_bg/frame"), false)
	setActive(arg_19_1:Find("icon_bg/stars"), false)

	local var_19_0 = arg_19_2:getConfig("rarity")

	if arg_19_2.type == DROP_TYPE_EQUIP or arg_19_2.type == DROP_TYPE_EQUIPMENT_SKIN then
		var_19_0 = var_19_0 - 1
	end

	local var_19_1 = "icon_frame_" .. var_19_0

	if arg_19_3 then
		var_19_1 = var_19_1 .. "_small"
	end

	self.loader:GetSpriteQuiet(self.commonBundleName, var_19_1, arg_19_1)

	if arg_19_2.type ~= DROP_TYPE_RYZA_DROP then
		onButton(self, arg_19_1, function()
			self:emit(AtelierCompositeBaseScene.ON_DROP, arg_19_2)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_19_1)
	end

	return
end

function AtelierCompositeBaseScene:UpdateRyzaItem(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = "icon_frame_" .. arg_21_2:GetRarity()

	if arg_21_3 then
		var_21_0 = var_21_0 .. "_small"
	end

	self.loader:GetSpriteQuiet(self.commonBundleName, var_21_0, arg_21_1)
	self.loader:GetSpriteQuiet(arg_21_2:GetIconPath(), "", arg_21_1:Find("Icon"))

	if not IsNil(arg_21_1:Find("Lv")) then
		setText(arg_21_1:Find("Lv/Text"), arg_21_2:GetLevel())
	end

	local var_21_1 = arg_21_2:GetProps()

	for iter_21_0, iter_21_1 in ipairs((CustomIndexLayer.Clone2Full(arg_21_1:Find("List"), #var_21_1))) do
		self.loader:GetSpriteQuiet(self.commonBundleName, "element_" .. AtelierFormulaCircle.ELEMENT_NAME[var_21_1[iter_21_0]], iter_21_1)
	end

	if not IsNil(arg_21_1:Find("Text")) then
		setText(arg_21_1:Find("Text"), arg_21_2.count)
	end

	return
end

function AtelierCompositeBaseScene:OnClickFormula(arg_22_1)
	self:HideFormulaList()
	self:ShowFormulaDetail(arg_22_1)
	self:DispalyChat(self.chatText.clickFormula)
	self:PlaySoundEffect(self.soundStr.clickFormula)

	return
end

function AtelierCompositeBaseScene:OnClickFormulaBack()
	self:HideFormulaDetail()

	self.contextData.formulaId = nil

	self:ShowFormulaList()

	return
end

function AtelierCompositeBaseScene:ShowMaterialSelectWindow(arg_24_1, arg_24_2, arg_24_3)
	self:DispalyChat(self.chatText.showMaterialSelectWindow)
	self:PlaySoundEffect(self.soundStr.showMaterialSelectWindow)
	self.atelierMaterialSelectView:ShowCandicatePanel(arg_24_1, arg_24_2, arg_24_3)

	return
end

function AtelierCompositeBaseScene:ShowCompositeConfirmWindow(arg_25_1)
	self.atelierCompositeConfirmView:ShowCompositeConfirmWindow(arg_25_1)

	return
end

function AtelierCompositeBaseScene:OnSelectMaterial(arg_26_1, arg_26_2)
	self:DispalyChat(self.chatText.selectMaterial)
	self:PlaySoundEffect(self.soundStr.selectMaterial)
	self.atelierFormulaDetailView:FillNode(arg_26_1, arg_26_2)

	return
end

function AtelierCompositeBaseScene:RefreshEmptyPanel()
	setActive(self.layerEmpty, not self.unlockSystem)
	setActive(self.painting, self.unlockSystem)

	return
end

function AtelierCompositeBaseScene:ShowFormulaList()
	self:AddIdleTimer()
	self.atelierFormulaListView:ShowFormulaList()

	return
end

function AtelierCompositeBaseScene:HideFormulaList()
	if not self.layerFormulaPanel then
		return
	end

	self:RemoveIdleTimer()
	setParent(self.layerFormulaPanel, self._tf)
	setActive(self.layerFormulaPanel, false)

	return true
end

function AtelierCompositeBaseScene:ShowFormulaDetail(arg_30_1)
	self.contextData.formulaId = arg_30_1:GetConfigID()

	self.atelierFormulaDetailView:Show(arg_30_1)
	setParent(self.layerFormulaOverlayPanel, self.top)
	self.layerFormulaOverlayPanel:SetSiblingIndex(0)
	setParent(self.painting, self.layerFormulaOverlayPanel)
	setActive(self.materialSelectPanel, false)

	return
end

function AtelierCompositeBaseScene:HideFormulaDetail()
	if not isActive(self.layerFormulaDetailPanel) then
		return
	end

	self.atelierMaterialSelectView:HideCandicatePanel()
	setParent(self.painting, self._tf)
	self.painting:SetSiblingIndex(1)
	setParent(self.layerFormulaOverlayPanel, self.layerFormulaDetailPanel)
	setActive(self.layerFormulaDetailPanel, false)

	return true
end

function AtelierCompositeBaseScene:ShowMaterialsPreview()
	self.atelierMaterialsPreview:ShowMaterialsPreview(self.atelierFormulaDetailView.nodeList)

	return
end

function AtelierCompositeBaseScene:DispalyChat(arg_33_1)
	self:HideChat()
	setActive(self.chat, true)

	self.chatTween = LeanTween.delayedCall(go(self.chat), 4, System.Action(function()
		self:HideChat()

		return
	end)).uniqueId

	local var_33_0 = arg_33_1[math.random(#arg_33_1)]
	local var_33_1 = _.detect(pg.gametip[self.tipStr].tip, function(arg_35_0)
		return arg_35_0[1] == var_33_0
	end)

	setText(self.chat:Find("Text"), var_33_1 and var_33_1[2])
	self:PlaySound(self:GetSoundPath() .. var_33_0)

	return
end

function AtelierCompositeBaseScene:GetSoundPath()
	return "event:/cv/" .. 1090001 .. "/"
end

function AtelierCompositeBaseScene:PlaySoundEffect(arg_37_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_37_1)

	return
end

function AtelierCompositeBaseScene:ShowItemDetail(arg_38_1)
	self:emit(AtelierMaterialDetailMediator.SHOW_DETAIL, arg_38_1)

	return
end

function AtelierCompositeBaseScene:LoadingOn()
	if self.animating then
		return
	end

	self.animating = true

	pg.UIMgr.GetInstance():LoadingOn(false)

	return
end

function AtelierCompositeBaseScene:LoadingOff()
	if not self.animating then
		return
	end

	pg.UIMgr.GetInstance():LoadingOff()

	self.animating = false

	return
end

function AtelierCompositeBaseScene:PlaySound(arg_41_1, arg_41_2)
	if not self.playbackInfo or arg_41_1 ~= self.prevCvPath or self.playbackInfo.channelPlayer == nil then
		self:StopSound()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_41_1, function(arg_42_0)
			if arg_42_0 then
				self.playbackInfo = arg_42_0

				self.playbackInfo:SetIgnoreAutoUnload(true)

				if arg_41_2 then
					arg_41_2(self.playbackInfo.cueInfo)
				end
			elseif arg_41_2 then
				arg_41_2()
			end

			return
		end)

		self.prevCvPath = arg_41_1

		if self.playbackInfo == nil then
			return nil
		end

		return self.playbackInfo.cueInfo
	elseif self.playbackInfo then
		self.playbackInfo:PlaybackStop()
		self.playbackInfo:SetStartTimeAndPlay()

		if arg_41_2 then
			arg_41_2(self.playbackInfo.cueInfo)
		end

		return self.playbackInfo.cueInfo
	elseif arg_41_2 then
		arg_41_2()
	end

	return nil
end

function AtelierCompositeBaseScene:StopSound()
	if self.playbackInfo then
		pg.CriMgr.GetInstance():StopPlaybackInfoForce(self.playbackInfo)
		self.playbackInfo:SetIgnoreAutoUnload(false)
	end

	return
end

function AtelierCompositeBaseScene:ClearSound()
	self:StopSound()

	if self.playbackInfo then
		self.playbackInfo:Dispose()

		self.playbackInfo = nil
	end

	return
end

function AtelierCompositeBaseScene:HideChat()
	if self.chatTween then
		LeanTween.cancel(self.chatTween)

		self.chatTween = nil
	end

	setActive(self.chat, false)

	return
end

function AtelierCompositeBaseScene:AddIdleTimer()
	self:RemoveIdleTimer()

	self.idleTimer = Timer.New(function()
		self:DispalyChat(self.chatText.idle)
		self:AddIdleTimer()

		return
	end, 8 + math.random() * 4)

	self.idleTimer:Start()

	return
end

function AtelierCompositeBaseScene:RemoveIdleTimer()
	if not self.idleTimer then
		return
	end

	self.idleTimer:Stop()

	self.idleTimer = nil

	return
end

function AtelierCompositeBaseScene:GetAtelierCompositEffect()
	return "laisha_lianjin"
end

function AtelierCompositeBaseScene:GetAtelierCompositEffectPos()
	return Vector2.zero
end

function AtelierCompositeBaseScene:OnCompositeResult(arg_51_1)
	self:LoadingOn()
	self:DispalyChat(self.chatText.compositeResult)

	local var_51_0 = 1.5
	local var_51_1 = 0.5

	self.loader:GetPrefab("ui/" .. self:GetAtelierCompositEffect(), "", function(arg_52_0)
		pg.UIMgr.GetInstance():OverlayPanel(tf(arg_52_0))
		setAnchoredPosition(arg_52_0, self:GetAtelierCompositEffectPos())
		self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self._tf, typeof(CanvasGroup)), 0, var_51_0):setFrom(1)
		self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self.top, typeof(CanvasGroup)), 0, var_51_0):setFrom(1)
		self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self.compositeConfirmPanel, typeof(CanvasGroup)), 0, var_51_0):setFrom(1)
		self:managedTween(LeanTween.delayedCall, function()
			self.atelierCompositeConfirmView:HideCompositeConfirmWindow()
			setCanvasGroupAlpha(self.compositeConfirmPanel, 1)
			self:CleanNodeInstance()
			self.atelierCompositeResultView:ShowCompositeResult(arg_51_1)
			self:DispalyChat(self.chatText.compositeResult2)
			self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self._tf, typeof(CanvasGroup)), 1, var_51_1):setFrom(0)
			self:managedTween(LeanTween.alphaCanvas, nil, GetComponent(self.top, typeof(CanvasGroup)), 1, var_51_1):setFrom(0)
			self:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(self.compositeResultPanel, typeof(CanvasGroup)), 1, var_51_1):setFrom(0)
			self:managedTween(LeanTween.delayedCall, function()
				self:LoadingOff()
				pg.UIMgr.GetInstance():UnOverlayPanel(tf(arg_52_0), self._tf)
				self.loader:ClearRequest("CompositeResult")

				return
			end, go(self.compositeResultPanel), var_51_1, nil)

			return
		end, go(self.compositeResultPanel), var_51_0, nil)

		return
	end, "CompositeResult")

	return
end

function AtelierCompositeBaseScene:OnReceiveFormualRequest(arg_55_1)
	self.atelierMaterialSelectView:HideCandicatePanel()
	self.atelierCompositeConfirmView:HideCompositeConfirmWindow()
	self.atelierCompositeResultView:HideCompositeResult()
	self.atelierMaterialsPreview:HideMaterialsPreview()
	self:HideFormulaList()
	self:ShowFormulaDetail(self.activity:GetFormulas()[arg_55_1])

	return
end

function AtelierCompositeBaseScene:CleanNodeInstance()
	local var_56_0 = self.activity:GetFormulas()[self.contextData.formulaId]

	if not var_56_0:IsAvaliable() then
		self:HideFormulaDetail()

		self.contextData.formulaId = nil

		self:ShowFormulaList()

		return
	end

	_.each(self.atelierFormulaDetailView.nodeList, function(arg_57_0)
		arg_57_0.Instance = nil
		arg_57_0.Change = true

		return
	end)
	self:ShowFormulaDetail(var_56_0)

	return
end

function AtelierCompositeBaseScene:onBackPressed()
	if self.animating then
		return true
	end

	if self.atelierMaterialsPreview:HideMaterialsPreview() then
		return true
	end

	if self.atelierCompositeResultView:HideCompositeResult() then
		return true
	end

	if self.atelierCompositeConfirmView:HideCompositeConfirmWindow() then
		return true
	end

	if self.atelierMaterialSelectView:HideCandicatePanel() then
		return true
	end

	if self:HideFormulaDetail() then
		self.contextData.formulaId = nil

		self:ShowFormulaList()

		return true
	end

	self:emit(AtelierCompositeBaseScene.ON_BACK_PRESSED)

	return
end

return AtelierCompositeBaseScene
