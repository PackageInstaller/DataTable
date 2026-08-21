local var_0_0 = class("AtelierCompositeBaseScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AtelierCompositeUI"
end

function var_0_0.InitStr(arg_2_0)
	arg_2_0.bundleName = "ui/AtelierCompositeUI_atlas"
	arg_2_0.commonBundleName = "ui/AtelierCommonUI_atlas"
	arg_2_0.chatText = {
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
	arg_2_0.soundStr = {
		formulaDetailUnlock = "event:/ui/ryza_atellier_ui_3",
		showMaterialSelectWindow = "event:/ui/ryza_atellier_ui_1",
		compositeConfirm = "event:/ui/ryza_atellier_ui_6",
		selectMaterial = "event:/ui/ryza_atellier_ui_2",
		formulaDetail = "event:/ui/ryza_atellier_ui_5",
		clickFormula = "event:/ui/ryza_atellier_ui_1",
		formulaDetailFill = "event:/ui/ryza_atellier_ui_4"
	}
	arg_2_0.helpStr = "ryza_composite_help_tip"
	arg_2_0.tipStr = "ryza_composite_words"
	arg_2_0.unlockText = "ryza_tip_composite_unlock"

	return
end

function var_0_0.InitView(arg_3_0)
	arg_3_0.atelierFormulaListView = AtelierFormulaListView.New(arg_3_0.layerFormulaPanel, arg_3_0)
	arg_3_0.atelierFormulaDetailView = AtelierFormulaDetailView.New(arg_3_0.layerFormulaDetailPanel, arg_3_0)
	arg_3_0.atelierMaterialSelectView = AtelierMaterialSelectView.New(arg_3_0.materialSelectPanel, arg_3_0)
	arg_3_0.atelierMaterialsPreview = AtelierFormulaMaterialsPreview.New(arg_3_0.materialsPreviewPanel, arg_3_0)
	arg_3_0.atelierCompositeConfirmView = AtelierCompositeConfirmView.New(arg_3_0.compositeConfirmPanel, arg_3_0)
	arg_3_0.atelierCompositeResultView = AtelierCompositeResultView.New(arg_3_0.compositeResultPanel, arg_3_0)

	return
end

function var_0_0.OnClickStore(arg_4_0)
	addSubLayer(Context.New({
		mediator = AtelierStoreBaseMediator,
		viewComponent = AtelierStoreBaseScene,
		data = {
			activity = arg_4_0.activity
		}
	}), (getProxy(ContextProxy):getCurrentContext():getContextByMediator(AtelierCompositeMediator)))

	return
end

function var_0_0.preload(arg_5_0, arg_5_1)
	arg_5_0:InitStr()

	arg_5_0.loader = AutoLoader.New()

	table.ParallelIpairsAsync({
		arg_5_0.bundleName,
		arg_5_0.commonBundleName
	}, function(arg_6_0, arg_6_1, arg_6_2)
		arg_5_0.loader:LoadBundle(arg_6_1, arg_6_2)

		return
	end, arg_5_1)

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0.top = arg_7_0._tf:Find("Top")
	arg_7_0.layerFormulaPanel = arg_7_0._tf:Find("FormulaList")
	arg_7_0.layerFormulaOverlayPanel = arg_7_0._tf:Find("FormulaDetail/Overlay")
	arg_7_0.layerFormulaDetailPanel = arg_7_0._tf:Find("FormulaDetail")
	arg_7_0.scrollView = arg_7_0._tf:Find("FormulaDetail/ScrollView")
	arg_7_0.materialSelectPanel = arg_7_0._tf:Find("FormulaDetail/Overlay/AvaliableMaterials")
	arg_7_0.materialsPreviewPanel = arg_7_0._tf:Find("FormulaMaterialsPreview")
	arg_7_0.compositeConfirmPanel = arg_7_0._tf:Find("CompositeConfirmWindow")
	arg_7_0.compositeResultPanel = arg_7_0._tf:Find("CompositeResultWindow")

	arg_7_0:InitCustom()
	setActive(arg_7_0.layerEmpty, false)

	return
end

function var_0_0.InitCustom(arg_8_0)
	arg_8_0.layerEmpty = arg_8_0._tf:Find("Empty")

	setText(arg_8_0._tf:Find("Empty/Bar/Text"), i18n(arg_8_0.unlockText))

	arg_8_0.painting = arg_8_0._tf:Find("Painting")
	arg_8_0.chat = arg_8_0.painting:Find("Chat")

	setActive(arg_8_0.chat, false)
	pg.ViewUtils.SetSortingOrder(arg_8_0._tf:Find("Mask/BG"):GetChild(0), -1)

	return
end

function var_0_0.SetContextData(arg_9_0, arg_9_1)
	arg_9_0.contextData = arg_9_1

	arg_9_0.atelierFormulaListView:SetContextData(arg_9_1)
	arg_9_0.atelierFormulaDetailView:SetContextData(arg_9_1)
	arg_9_0.atelierMaterialSelectView:SetContextData(arg_9_1)
	arg_9_0.atelierMaterialsPreview:SetContentData(arg_9_1)
	arg_9_0.atelierCompositeConfirmView:SetContentData(arg_9_1)
	arg_9_0.atelierCompositeResultView:SetContentData(arg_9_1)

	return
end

function var_0_0.SetActivity(arg_10_0, arg_10_1)
	arg_10_0.activity = arg_10_1

	arg_10_0.atelierFormulaListView:SetActivity(arg_10_1)
	arg_10_0.atelierFormulaDetailView:SetActivity(arg_10_1)
	arg_10_0.atelierMaterialSelectView:SetActivity(arg_10_1)
	arg_10_0.atelierMaterialsPreview:SetActivity(arg_10_1)
	arg_10_0.atelierCompositeConfirmView:SetActivity(arg_10_1)
	arg_10_0.atelierCompositeResultView:SetActivity(arg_10_1)

	return
end

function var_0_0.SetEnabled(arg_11_0, arg_11_1)
	arg_11_0.unlockSystem = arg_11_1

	return
end

function var_0_0.didEnter(arg_12_0)
	arg_12_0:RefreshEmptyPanel()
	arg_12_0.atelierFormulaListView:didEnter()
	arg_12_0.atelierFormulaDetailView:didEnter()
	arg_12_0.atelierMaterialSelectView:didEnter()
	arg_12_0.atelierMaterialsPreview:didEnter()
	arg_12_0.atelierCompositeConfirmView:didEnter()
	arg_12_0.atelierCompositeResultView:didEnter()
	onButton(arg_12_0, arg_12_0._tf:Find("Top/TopBar/Back"), function()
		arg_12_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_12_0, arg_12_0._tf:Find("Top/TopBar/Home"), function()
		arg_12_0:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(arg_12_0, arg_12_0._tf:Find("Top/TopBar/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n(arg_12_0.helpStr)
		})

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0._tf:Find("Top/TopBar/StoreHouse"), function()
		arg_12_0:OnClickStore()

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():OverlayPanel(arg_12_0.top)

	if arg_12_0.unlockSystem then
		if arg_12_0.contextData.formulaId then
			arg_12_0:ShowFormulaDetail(arg_12_0.activity:GetFormulas()[arg_12_0.contextData.formulaId])
		else
			arg_12_0:DispalyChat(arg_12_0.chatText.idle)
			arg_12_0:ShowFormulaList()
		end
	end

	arg_12_0:PlayGuide()

	return
end

function var_0_0.PlayGuide(arg_17_0)
	if arg_17_0.unlockSystem then
		if PlayerPrefs.GetInt(string.format("first_enter_ryza_atelier_%s_%s", getProxy(PlayerProxy):getRawData().id, arg_17_0.activity.id), 0) == 0 then
			triggerButton(arg_17_0._tf:Find("Top/TopBar/Help"))
			PlayerPrefs.SetInt(string.format("first_enter_ryza_atelier_%s_%s", getProxy(PlayerProxy):getRawData().id, arg_17_0.activity.id), 1)
		end
	end

	return
end

function var_0_0.willExit(arg_18_0)
	arg_18_0.loader:Clear()
	arg_18_0:LoadingOff()
	arg_18_0:HideChat()
	arg_18_0:ClearSound()
	arg_18_0.atelierMaterialsPreview:HideMaterialsPreview()
	arg_18_0.atelierCompositeResultView:HideCompositeResult()
	arg_18_0.atelierCompositeConfirmView:HideCompositeConfirmWindow()
	arg_18_0.atelierMaterialSelectView:HideCandicatePanel()
	arg_18_0:HideFormulaDetail()
	arg_18_0:HideFormulaList()
	arg_18_0.atelierFormulaListView:willExit()

	arg_18_0.atelierFormulaListView = nil

	arg_18_0.atelierFormulaDetailView:willExit()

	arg_18_0.atelierFormulaDetailView = nil

	arg_18_0.atelierMaterialSelectView:willExit()

	arg_18_0.atelierMaterialSelectView = nil

	arg_18_0.atelierMaterialsPreview:willExit()

	arg_18_0.atelierMaterialsPreview = nil

	arg_18_0.atelierCompositeConfirmView:willExit()

	arg_18_0.atelierCompositeConfirmView = nil

	arg_18_0.atelierCompositeResultView:willExit()

	arg_18_0.atelierCompositeResultView = nil

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_18_0.top, arg_18_0._tf)

	if arg_18_0.nodePools then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.nodePools) do
			iter_18_1:ClearItems()
		end
	end

	return
end

function var_0_0.UpdateRyzaDrop(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
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

	arg_19_0.loader:GetSpriteQuiet(arg_19_0.commonBundleName, var_19_1, arg_19_1)

	if arg_19_2.type ~= DROP_TYPE_RYZA_DROP then
		onButton(arg_19_0, arg_19_1, function()
			arg_19_0:emit(var_0_0.ON_DROP, arg_19_2)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_19_1)
	end

	return
end

function var_0_0.UpdateRyzaItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = "icon_frame_" .. arg_21_2:GetRarity()

	if arg_21_3 then
		var_21_0 = var_21_0 .. "_small"
	end

	arg_21_0.loader:GetSpriteQuiet(arg_21_0.commonBundleName, var_21_0, arg_21_1)
	arg_21_0.loader:GetSpriteQuiet(arg_21_2:GetIconPath(), "", arg_21_1:Find("Icon"))

	if not IsNil(arg_21_1:Find("Lv")) then
		setText(arg_21_1:Find("Lv/Text"), arg_21_2:GetLevel())
	end

	local var_21_1 = arg_21_2:GetProps()

	for iter_21_0, iter_21_1 in ipairs((CustomIndexLayer.Clone2Full(arg_21_1:Find("List"), #var_21_1))) do
		arg_21_0.loader:GetSpriteQuiet(arg_21_0.commonBundleName, "element_" .. AtelierFormulaCircle.ELEMENT_NAME[var_21_1[iter_21_0]], iter_21_1)
	end

	if not IsNil(arg_21_1:Find("Text")) then
		setText(arg_21_1:Find("Text"), arg_21_2.count)
	end

	return
end

function var_0_0.OnClickFormula(arg_22_0, arg_22_1)
	arg_22_0:HideFormulaList()
	arg_22_0:ShowFormulaDetail(arg_22_1)
	arg_22_0:DispalyChat(arg_22_0.chatText.clickFormula)
	arg_22_0:PlaySoundEffect(arg_22_0.soundStr.clickFormula)

	return
end

function var_0_0.OnClickFormulaBack(arg_23_0)
	arg_23_0:HideFormulaDetail()

	arg_23_0.contextData.formulaId = nil

	arg_23_0:ShowFormulaList()

	return
end

function var_0_0.ShowMaterialSelectWindow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0:DispalyChat(arg_24_0.chatText.showMaterialSelectWindow)
	arg_24_0:PlaySoundEffect(arg_24_0.soundStr.showMaterialSelectWindow)
	arg_24_0.atelierMaterialSelectView:ShowCandicatePanel(arg_24_1, arg_24_2, arg_24_3)

	return
end

function var_0_0.ShowCompositeConfirmWindow(arg_25_0, arg_25_1)
	arg_25_0.atelierCompositeConfirmView:ShowCompositeConfirmWindow(arg_25_1)

	return
end

function var_0_0.OnSelectMaterial(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:DispalyChat(arg_26_0.chatText.selectMaterial)
	arg_26_0:PlaySoundEffect(arg_26_0.soundStr.selectMaterial)
	arg_26_0.atelierFormulaDetailView:FillNode(arg_26_1, arg_26_2)

	return
end

function var_0_0.RefreshEmptyPanel(arg_27_0)
	setActive(arg_27_0.layerEmpty, not arg_27_0.unlockSystem)
	setActive(arg_27_0.painting, arg_27_0.unlockSystem)

	return
end

function var_0_0.ShowFormulaList(arg_28_0)
	arg_28_0:AddIdleTimer()
	arg_28_0.atelierFormulaListView:ShowFormulaList()

	return
end

function var_0_0.HideFormulaList(arg_29_0)
	if not arg_29_0.layerFormulaPanel then
		return
	end

	arg_29_0:RemoveIdleTimer()
	setParent(arg_29_0.layerFormulaPanel, arg_29_0._tf)
	setActive(arg_29_0.layerFormulaPanel, false)

	return true
end

function var_0_0.ShowFormulaDetail(arg_30_0, arg_30_1)
	arg_30_0.contextData.formulaId = arg_30_1:GetConfigID()

	arg_30_0.atelierFormulaDetailView:Show(arg_30_1)
	setParent(arg_30_0.layerFormulaOverlayPanel, arg_30_0.top)
	arg_30_0.layerFormulaOverlayPanel:SetSiblingIndex(0)
	setParent(arg_30_0.painting, arg_30_0.layerFormulaOverlayPanel)
	setActive(arg_30_0.materialSelectPanel, false)

	return
end

function var_0_0.HideFormulaDetail(arg_31_0)
	if not isActive(arg_31_0.layerFormulaDetailPanel) then
		return
	end

	arg_31_0.atelierMaterialSelectView:HideCandicatePanel()
	setParent(arg_31_0.painting, arg_31_0._tf)
	arg_31_0.painting:SetSiblingIndex(1)
	setParent(arg_31_0.layerFormulaOverlayPanel, arg_31_0.layerFormulaDetailPanel)
	setActive(arg_31_0.layerFormulaDetailPanel, false)

	return true
end

function var_0_0.ShowMaterialsPreview(arg_32_0)
	arg_32_0.atelierMaterialsPreview:ShowMaterialsPreview(arg_32_0.atelierFormulaDetailView.nodeList)

	return
end

function var_0_0.DispalyChat(arg_33_0, arg_33_1)
	arg_33_0:HideChat()
	setActive(arg_33_0.chat, true)

	arg_33_0.chatTween = LeanTween.delayedCall(go(arg_33_0.chat), 4, System.Action(function()
		arg_33_0:HideChat()

		return
	end)).uniqueId

	local var_33_0 = arg_33_1[math.random(#arg_33_1)]
	local var_33_1 = _.detect(pg.gametip[arg_33_0.tipStr].tip, function(arg_35_0)
		return arg_35_0[1] == var_33_0
	end)

	setText(arg_33_0.chat:Find("Text"), var_33_1 and var_33_1[2])
	arg_33_0:PlaySound(arg_33_0:GetSoundPath() .. arg_33_1[math.random(#arg_33_1)])

	return
end

function var_0_0.GetSoundPath(arg_36_0)
	return "event:/cv/" .. 1090001 .. "/"
end

function var_0_0.PlaySoundEffect(arg_37_0, arg_37_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_37_1)

	return
end

function var_0_0.ShowItemDetail(arg_38_0, arg_38_1)
	arg_38_0:emit(AtelierMaterialDetailMediator.SHOW_DETAIL, arg_38_1)

	return
end

function var_0_0.LoadingOn(arg_39_0)
	if arg_39_0.animating then
		return
	end

	arg_39_0.animating = true

	pg.UIMgr.GetInstance():LoadingOn(false)

	return
end

function var_0_0.LoadingOff(arg_40_0)
	if not arg_40_0.animating then
		return
	end

	pg.UIMgr.GetInstance():LoadingOff()

	arg_40_0.animating = false

	return
end

function var_0_0.PlaySound(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0.playbackInfo or arg_41_1 ~= arg_41_0.prevCvPath or arg_41_0.playbackInfo.channelPlayer == nil then
		arg_41_0:StopSound()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_41_1, function(arg_42_0)
			if arg_42_0 then
				arg_41_0.playbackInfo = arg_42_0

				arg_41_0.playbackInfo:SetIgnoreAutoUnload(true)

				if arg_41_2 then
					arg_41_2(arg_41_0.playbackInfo.cueInfo)
				end
			elseif arg_41_2 then
				arg_41_2()
			end

			return
		end)

		arg_41_0.prevCvPath = arg_41_1

		if arg_41_0.playbackInfo == nil then
			return nil
		end

		return arg_41_0.playbackInfo.cueInfo
	elseif arg_41_0.playbackInfo then
		arg_41_0.playbackInfo:PlaybackStop()
		arg_41_0.playbackInfo:SetStartTimeAndPlay()

		if arg_41_2 then
			arg_41_2(arg_41_0.playbackInfo.cueInfo)
		end

		return arg_41_0.playbackInfo.cueInfo
	elseif arg_41_2 then
		arg_41_2()
	end

	return nil
end

function var_0_0.StopSound(arg_43_0)
	if arg_43_0.playbackInfo then
		pg.CriMgr.GetInstance():StopPlaybackInfoForce(arg_43_0.playbackInfo)
		arg_43_0.playbackInfo:SetIgnoreAutoUnload(false)
	end

	return
end

function var_0_0.ClearSound(arg_44_0)
	arg_44_0:StopSound()

	if arg_44_0.playbackInfo then
		arg_44_0.playbackInfo:Dispose()

		arg_44_0.playbackInfo = nil
	end

	return
end

function var_0_0.HideChat(arg_45_0)
	if arg_45_0.chatTween then
		LeanTween.cancel(arg_45_0.chatTween)

		arg_45_0.chatTween = nil
	end

	setActive(arg_45_0.chat, false)

	return
end

function var_0_0.AddIdleTimer(arg_46_0)
	arg_46_0:RemoveIdleTimer()

	arg_46_0.idleTimer = Timer.New(function()
		arg_46_0:DispalyChat(arg_46_0.chatText.idle)
		arg_46_0:AddIdleTimer()

		return
	end, 8 + math.random() * 4)

	arg_46_0.idleTimer:Start()

	return
end

function var_0_0.RemoveIdleTimer(arg_48_0)
	if not arg_48_0.idleTimer then
		return
	end

	arg_48_0.idleTimer:Stop()

	arg_48_0.idleTimer = nil

	return
end

function var_0_0.GetAtelierCompositEffect(arg_49_0)
	return "laisha_lianjin"
end

function var_0_0.GetAtelierCompositEffectPos(arg_50_0)
	return Vector2.zero
end

function var_0_0.OnCompositeResult(arg_51_0, arg_51_1)
	arg_51_0:LoadingOn()
	arg_51_0:DispalyChat(arg_51_0.chatText.compositeResult)

	local var_51_0 = 1.5
	local var_51_1 = 0.5

	arg_51_0.loader:GetPrefab("ui/" .. arg_51_0:GetAtelierCompositEffect(), "", function(arg_52_0)
		pg.UIMgr.GetInstance():OverlayPanel(tf(arg_52_0))
		setAnchoredPosition(arg_52_0, arg_51_0:GetAtelierCompositEffectPos())
		arg_51_0:managedTween(LeanTween.alphaCanvas, nil, GetComponent(arg_51_0._tf, typeof(CanvasGroup)), 0, var_51_0):setFrom(1)
		arg_51_0:managedTween(LeanTween.alphaCanvas, nil, GetComponent(arg_51_0.top, typeof(CanvasGroup)), 0, var_51_0):setFrom(1)
		arg_51_0:managedTween(LeanTween.alphaCanvas, nil, GetComponent(arg_51_0.compositeConfirmPanel, typeof(CanvasGroup)), 0, var_51_0):setFrom(1)
		arg_51_0:managedTween(LeanTween.delayedCall, function()
			arg_51_0.atelierCompositeConfirmView:HideCompositeConfirmWindow()
			setCanvasGroupAlpha(arg_51_0.compositeConfirmPanel, 1)
			arg_51_0:CleanNodeInstance()
			arg_51_0.atelierCompositeResultView:ShowCompositeResult(arg_51_1)
			arg_51_0:DispalyChat(arg_51_0.chatText.compositeResult2)
			arg_51_0:managedTween(LeanTween.alphaCanvas, nil, GetComponent(arg_51_0._tf, typeof(CanvasGroup)), 1, var_51_1):setFrom(0)
			arg_51_0:managedTween(LeanTween.alphaCanvas, nil, GetComponent(arg_51_0.top, typeof(CanvasGroup)), 1, var_51_1):setFrom(0)
			arg_51_0:managedTween(LeanTween.alphaCanvas, nil, GetOrAddComponent(arg_51_0.compositeResultPanel, typeof(CanvasGroup)), 1, var_51_1):setFrom(0)
			arg_51_0:managedTween(LeanTween.delayedCall, function()
				arg_51_0:LoadingOff()
				pg.UIMgr.GetInstance():UnOverlayPanel(tf(arg_52_0), arg_51_0._tf)
				arg_51_0.loader:ClearRequest("CompositeResult")

				return
			end, go(arg_51_0.compositeResultPanel), var_51_1, nil)

			return
		end, go(arg_51_0.compositeResultPanel), var_51_0, nil)

		return
	end, "CompositeResult")

	return
end

function var_0_0.OnReceiveFormualRequest(arg_55_0, arg_55_1)
	arg_55_0.atelierMaterialSelectView:HideCandicatePanel()
	arg_55_0.atelierCompositeConfirmView:HideCompositeConfirmWindow()
	arg_55_0.atelierCompositeResultView:HideCompositeResult()
	arg_55_0.atelierMaterialsPreview:HideMaterialsPreview()
	arg_55_0:HideFormulaList()
	arg_55_0:ShowFormulaDetail(arg_55_0.activity:GetFormulas()[arg_55_1])

	return
end

function var_0_0.CleanNodeInstance(arg_56_0)
	local var_56_0 = arg_56_0.activity:GetFormulas()[arg_56_0.contextData.formulaId]

	if not var_56_0:IsAvaliable() then
		arg_56_0:HideFormulaDetail()

		arg_56_0.contextData.formulaId = nil

		arg_56_0:ShowFormulaList()

		return
	end

	_.each(arg_56_0.atelierFormulaDetailView.nodeList, function(arg_57_0)
		arg_57_0.Instance = nil
		arg_57_0.Change = true

		return
	end)
	arg_56_0:ShowFormulaDetail(var_56_0)

	return
end

function var_0_0.onBackPressed(arg_58_0)
	if arg_58_0.animating then
		return true
	end

	if arg_58_0.atelierMaterialsPreview:HideMaterialsPreview() then
		return true
	end

	if arg_58_0.atelierCompositeResultView:HideCompositeResult() then
		return true
	end

	if arg_58_0.atelierCompositeConfirmView:HideCompositeConfirmWindow() then
		return true
	end

	if arg_58_0.atelierMaterialSelectView:HideCandicatePanel() then
		return true
	end

	if arg_58_0:HideFormulaDetail() then
		arg_58_0.contextData.formulaId = nil

		arg_58_0:ShowFormulaList()

		return true
	end

	arg_58_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

return var_0_0
