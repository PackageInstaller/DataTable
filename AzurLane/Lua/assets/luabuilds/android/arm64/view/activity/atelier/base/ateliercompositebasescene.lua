class = var_0_10000

local var_0_0 = "AtelierCompositeBaseScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AtelierCompositeUI"
end

function var_0_1.InitStr(arg_2_0)
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

function var_0_1.InitView(arg_3_0)
	AtelierFormulaListView = var_1_10001
	arg_3_0.atelierFormulaListView = var_1_10001.New(arg_3_0.layerFormulaPanel, arg_3_0)
	AtelierFormulaDetailView = var_1
	arg_3_0.atelierFormulaDetailView = var_1.New(arg_3_0.layerFormulaDetailPanel, arg_3_0)
	AtelierMaterialSelectView = var_1
	arg_3_0.atelierMaterialSelectView = var_1.New(arg_3_0.materialSelectPanel, arg_3_0)
	AtelierFormulaMaterialsPreview = var_1
	arg_3_0.atelierMaterialsPreview = var_1.New(arg_3_0.materialsPreviewPanel, arg_3_0)
	AtelierCompositeConfirmView = var_1
	arg_3_0.atelierCompositeConfirmView = var_1.New(arg_3_0.compositeConfirmPanel, arg_3_0)
	AtelierCompositeResultView = var_1
	arg_3_0.atelierCompositeResultView = var_1.New(arg_3_0.compositeResultPanel, arg_3_0)

	return
end

function var_0_1.OnClickStore(arg_4_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getCurrentContext(var_4_0)
	local var_4_2 = var_1.getContextByMediator

	AtelierCompositeMediator = var_1_10005

	local var_4_3 = var_4_2(var_4_1, var_1_10005)

	addSubLayer = var_4_0
	Context = var_1_10005

	local var_4_4 = var_1_10005.New
	local var_4_5 = {}

	AtelierStoreBaseMediator = var_1_10008
	var_4_5.mediator = var_1_10008
	AtelierStoreBaseScene = var_1_10008
	var_4_5.viewComponent = var_1_10008
	var_4_5.data = {
		activity = arg_4_0.activity
	}

	var_4_0(var_4_4(var_4_5), var_4_3)

	return
end

function var_0_1.preload(arg_5_0, arg_5_1)
	arg_5_0:InitStr()

	AutoLoader = var_2
	arg_5_0.loader = var_2.New()
	table = var_2

	var_2.ParallelIpairsAsync({
		arg_5_0.bundleName,
		arg_5_0.commonBundleName
	}, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_5_0.loader

		var_3.LoadBundle(var_6_0, arg_6_1, arg_6_2)

		return
	end, arg_5_1)

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.top = var_1.Find(var_7_0, "Top")

	local var_7_1 = arg_7_0._tf

	arg_7_0.layerFormulaPanel = var_1.Find(var_7_1, "FormulaList")

	local var_7_2 = arg_7_0._tf

	arg_7_0.layerFormulaOverlayPanel = var_1.Find(var_7_2, "FormulaDetail/Overlay")

	local var_7_3 = arg_7_0._tf

	arg_7_0.layerFormulaDetailPanel = var_1.Find(var_7_3, "FormulaDetail")

	local var_7_4 = arg_7_0._tf

	arg_7_0.scrollView = var_1.Find(var_7_4, "FormulaDetail/ScrollView")

	local var_7_5 = arg_7_0._tf

	arg_7_0.materialSelectPanel = var_1.Find(var_7_5, "FormulaDetail/Overlay/AvaliableMaterials")

	local var_7_6 = arg_7_0._tf

	arg_7_0.materialsPreviewPanel = var_1.Find(var_7_6, "FormulaMaterialsPreview")

	local var_7_7 = arg_7_0._tf

	arg_7_0.compositeConfirmPanel = var_1.Find(var_7_7, "CompositeConfirmWindow")

	local var_7_8 = arg_7_0._tf

	arg_7_0.compositeResultPanel = var_1.Find(var_7_8, "CompositeResultWindow")

	arg_7_0:InitCustom()

	setActive = var_1

	var_1(arg_7_0.layerEmpty, false)

	return
end

function var_0_1.InitCustom(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.layerEmpty = var_1.Find(var_8_0, "Empty")
	setText = var_1

	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_3.Find(var_8_1, "Empty/Bar/Text")

	i18n = var_4

	var_1(var_8_2, var_4(arg_8_0.unlockText))

	local var_8_3 = arg_8_0._tf

	arg_8_0.painting = var_1.Find(var_8_3, "Painting")

	local var_8_4 = arg_8_0.painting

	arg_8_0.chat = var_1.Find(var_8_4, "Chat")
	setActive = var_1

	var_1(arg_8_0.chat, false)

	pg = var_1

	local var_8_5 = var_1.ViewUtils.SetSortingOrder
	local var_8_6 = arg_8_0._tf
	local var_8_7 = var_3.Find(var_8_6, "Mask/BG")

	var_8_5(var_3.GetChild(var_8_7, 0), -1)

	return
end

function var_0_1.SetContextData(arg_9_0, arg_9_1)
	arg_9_0.contextData = arg_9_1

	local var_9_0 = arg_9_0.atelierFormulaListView

	var_2.SetContextData(var_9_0, arg_9_1)

	local var_9_1 = arg_9_0.atelierFormulaDetailView

	var_2.SetContextData(var_9_1, arg_9_1)

	local var_9_2 = arg_9_0.atelierMaterialSelectView

	var_2.SetContextData(var_9_2, arg_9_1)

	local var_9_3 = arg_9_0.atelierMaterialsPreview

	var_2.SetContentData(var_9_3, arg_9_1)

	local var_9_4 = arg_9_0.atelierCompositeConfirmView

	var_2.SetContentData(var_9_4, arg_9_1)

	local var_9_5 = arg_9_0.atelierCompositeResultView

	var_2.SetContentData(var_9_5, arg_9_1)

	return
end

function var_0_1.SetActivity(arg_10_0, arg_10_1)
	arg_10_0.activity = arg_10_1

	local var_10_0 = arg_10_0.atelierFormulaListView

	var_2.SetActivity(var_10_0, arg_10_1)

	local var_10_1 = arg_10_0.atelierFormulaDetailView

	var_2.SetActivity(var_10_1, arg_10_1)

	local var_10_2 = arg_10_0.atelierMaterialSelectView

	var_2.SetActivity(var_10_2, arg_10_1)

	local var_10_3 = arg_10_0.atelierMaterialsPreview

	var_2.SetActivity(var_10_3, arg_10_1)

	local var_10_4 = arg_10_0.atelierCompositeConfirmView

	var_2.SetActivity(var_10_4, arg_10_1)

	local var_10_5 = arg_10_0.atelierCompositeResultView

	var_2.SetActivity(var_10_5, arg_10_1)

	return
end

function var_0_1.SetEnabled(arg_11_0, arg_11_1)
	arg_11_0.unlockSystem = arg_11_1

	return
end

function var_0_1.didEnter(arg_12_0)
	arg_12_0:RefreshEmptyPanel()

	local var_12_0 = arg_12_0.atelierFormulaListView

	var_1.didEnter(var_12_0)

	local var_12_1 = arg_12_0.atelierFormulaDetailView

	var_1.didEnter(var_12_1)

	local var_12_2 = arg_12_0.atelierMaterialSelectView

	var_1.didEnter(var_12_2)

	local var_12_3 = arg_12_0.atelierMaterialsPreview

	var_1.didEnter(var_12_3)

	local var_12_4 = arg_12_0.atelierCompositeConfirmView

	var_1.didEnter(var_12_4)

	local var_12_5 = arg_12_0.atelierCompositeResultView

	var_1.didEnter(var_12_5)

	onButton = var_1

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0._tf
	local var_12_8 = var_4.Find(var_12_7, "Top/TopBar/Back")

	local function var_12_9()
		local var_13_0 = arg_12_0

		var_0.onBackPressed(var_13_0)

		return
	end

	SFX_CANCEL = var_12_7

	var_1(var_12_6, var_12_8, var_12_9, var_12_7)

	onButton = var_1

	local var_12_10 = arg_12_0
	local var_12_11 = arg_12_0._tf
	local var_12_12 = var_4.Find(var_12_11, "Top/TopBar/Home")

	local function var_12_13()
		local var_14_0 = arg_12_0

		var_0.quickExitFunc(var_14_0)

		return
	end

	SFX_CANCEL = var_12_11

	var_1(var_12_10, var_12_12, var_12_13, var_12_11)

	onButton = var_1

	local var_12_14 = arg_12_0
	local var_12_15 = arg_12_0._tf
	local var_12_16 = var_4.Find(var_12_15, "Top/TopBar/Help")

	local function var_12_17()
		pg = var_2_10000

		local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_15_2.type = var_2_10004
		i18n = var_2_10004
		var_15_2.helps = var_2_10004(arg_12_0.helpStr)

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_PANEL = var_12_15

	var_1(var_12_14, var_12_16, var_12_17, var_12_15)

	onButton = var_1

	local var_12_18 = arg_12_0
	local var_12_19 = arg_12_0._tf
	local var_12_20 = var_4.Find(var_12_19, "Top/TopBar/StoreHouse")

	local function var_12_21()
		local var_16_0 = arg_12_0

		var_0.OnClickStore(var_16_0)

		return
	end

	SFX_PANEL = var_12_19

	var_1(var_12_18, var_12_20, var_12_21, var_12_19)

	pg = var_1

	local var_12_22 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_12_22, arg_12_0.top)

	if arg_12_0.unlockSystem then
		if arg_12_0.contextData.formulaId then
			local var_12_23 = arg_12_0.activity
			local var_12_24 = var_1.GetFormulas(var_12_23)[arg_12_0.contextData.formulaId]

			arg_12_0:ShowFormulaDetail(var_12_24)
		else
			arg_12_0:DispalyChat(arg_12_0.chatText.idle)
			arg_12_0:ShowFormulaList()
		end
	end

	arg_12_0:PlayGuide()

	return
end

function var_0_1.PlayGuide(arg_17_0)
	if arg_17_0.unlockSystem then
		PlayerPrefs = var_1

		local var_17_0 = var_1.GetInt

		string = var_1_10003

		local var_17_1 = var_1_10003.format
		local var_17_2 = "first_enter_ryza_atelier_%s_%s"

		getProxy = var_1_10006
		PlayerProxy = var_1_10008

		local var_17_3 = var_1_10006(var_1_10008)

		if var_17_0(var_17_1(var_17_2, var_6.getRawData(var_17_3).id, arg_17_0.activity.id), 0) == 0 then
			triggerButton = var_1

			local var_17_4 = arg_17_0._tf

			var_1(var_3.Find(var_17_4, "Top/TopBar/Help"))

			PlayerPrefs = var_1

			local var_17_5 = var_1.SetInt

			string = var_3

			local var_17_6 = var_3.format
			local var_17_7 = "first_enter_ryza_atelier_%s_%s"

			getProxy = var_6
			PlayerProxy = var_17_3

			local var_17_8 = var_6(var_17_3)

			var_17_5(var_17_6(var_17_7, var_6.getRawData(var_17_8).id, arg_17_0.activity.id), 1)
		end
	end

	return
end

function var_0_1.willExit(arg_18_0)
	local var_18_0 = arg_18_0.loader

	var_1.Clear(var_18_0)
	arg_18_0:LoadingOff()
	arg_18_0:HideChat()
	arg_18_0:ClearSound()

	local var_18_1 = arg_18_0.atelierMaterialsPreview

	var_1.HideMaterialsPreview(var_18_1)

	local var_18_2 = arg_18_0.atelierCompositeResultView

	var_1.HideCompositeResult(var_18_2)

	local var_18_3 = arg_18_0.atelierCompositeConfirmView

	var_1.HideCompositeConfirmWindow(var_18_3)

	local var_18_4 = arg_18_0.atelierMaterialSelectView

	var_1.HideCandicatePanel(var_18_4)
	arg_18_0:HideFormulaDetail()
	arg_18_0:HideFormulaList()

	local var_18_5 = arg_18_0.atelierFormulaListView

	var_1.willExit(var_18_5)

	arg_18_0.atelierFormulaListView = nil

	local var_18_6 = arg_18_0.atelierFormulaDetailView

	var_1.willExit(var_18_6)

	arg_18_0.atelierFormulaDetailView = nil

	local var_18_7 = arg_18_0.atelierMaterialSelectView

	var_1.willExit(var_18_7)

	arg_18_0.atelierMaterialSelectView = nil

	local var_18_8 = arg_18_0.atelierMaterialsPreview

	var_1.willExit(var_18_8)

	arg_18_0.atelierMaterialsPreview = nil

	local var_18_9 = arg_18_0.atelierCompositeConfirmView

	var_1.willExit(var_18_9)

	arg_18_0.atelierCompositeConfirmView = nil

	local var_18_10 = arg_18_0.atelierCompositeResultView

	var_1.willExit(var_18_10)

	arg_18_0.atelierCompositeResultView = nil
	pg = var_1

	local var_18_11 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_18_11, arg_18_0.top, arg_18_0._tf)

	if arg_18_0.nodePools then
		pairs = var_1

		for iter_18_0, iter_18_1 in var_1(arg_18_0.nodePools) do
			iter_18_1:ClearItems()
		end
	end

	return
end

function var_0_1.UpdateRyzaDrop(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	updateDrop = var_1_10004

	var_1_10004(arg_19_1, arg_19_2)

	SetCompomentEnabled = var_1_10004

	local var_19_0 = arg_19_1:Find("icon_bg")

	typeof = var_7
	Image = var_9

	var_1_10004(var_19_0, var_7(var_9), false)

	setActive = var_1_10004

	var_1_10004(arg_19_1:Find("bg"), false)

	setActive = var_1_10004

	var_1_10004(arg_19_1:Find("icon_bg/frame"), false)

	setActive = var_1_10004

	var_1_10004(arg_19_1:Find("icon_bg/stars"), false)

	local var_19_1 = arg_19_2
	local var_19_2 = arg_19_2.getConfig(var_19_1, "rarity")
	local var_19_3 = arg_19_2.type

	DROP_TYPE_EQUIP = var_19_1

	if var_19_3 ~= var_19_1 then
		local var_19_4 = arg_19_2.type

		DROP_TYPE_EQUIPMENT_SKIN = var_19_1

		if var_19_4 == var_19_1 then
			var_19_2 = var_19_2 - 1
		end

		local var_19_5 = "icon_frame_" .. var_19_2

		if arg_19_3 then
			var_19_5 = var_19_5 .. "_small"
		end

		local var_19_6 = arg_19_0.loader

		var_6.GetSpriteQuiet(var_19_6, arg_19_0.commonBundleName, var_19_5, arg_19_1)

		local var_19_7 = arg_19_2.type

		DROP_TYPE_RYZA_DROP = var_7

		if var_19_7 ~= var_7 then
			onButton = var_19_7

			local var_19_8 = arg_19_0
			local var_19_9 = arg_19_1

			local function var_19_10()
				local var_20_0 = arg_19_0

				var_0.emit(var_20_0, var_0_1.ON_DROP, arg_19_2)

				return
			end

			SFX_PANEL = var_11

			var_19_7(var_19_8, var_19_9, var_19_10, var_11)
		else
			removeOnButton = var_19_7

			var_19_7(arg_19_1)
		end

		return
	end
end

function var_0_1.UpdateRyzaItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = "icon_frame_" .. arg_21_2:GetRarity()

	if arg_21_3 then
		var_21_0 = var_21_0 .. "_small"
	end

	local var_21_1 = arg_21_0.loader

	var_5.GetSpriteQuiet(var_21_1, arg_21_0.commonBundleName, var_21_0, arg_21_1)

	local var_21_2 = arg_21_0.loader

	var_5.GetSpriteQuiet(var_21_2, arg_21_2:GetIconPath(), "", arg_21_1:Find("Icon"))

	IsNil = var_5

	if not var_5(arg_21_1:Find("Lv")) then
		setText = var_5

		var_5(arg_21_1:Find("Lv/Text"), arg_21_2:GetLevel())
	end

	local var_21_3 = arg_21_2
	local var_21_4 = arg_21_2.GetProps(var_21_3)

	CustomIndexLayer = var_1_10006

	local var_21_5 = var_1_10006.Clone2Full(arg_21_1:Find("List"), #var_21_4)

	ipairs = var_21_3

	for iter_21_0, iter_21_1 in var_21_3(var_21_5) do
		local var_21_6 = arg_21_0.loader
		local var_21_7 = var_12.GetSpriteQuiet
		local var_21_8 = arg_21_0.commonBundleName
		local var_21_9 = "element_"

		AtelierFormulaCircle = var_1_10017

		var_21_7(var_21_6, var_21_8, var_21_9 .. var_1_10017.ELEMENT_NAME[var_21_4[iter_21_0]], iter_21_1)
	end

	IsNil = var_7

	if not var_7(arg_21_1:Find("Text")) then
		setText = var_7

		var_7(arg_21_1:Find("Text"), arg_21_2.count)
	end

	return
end

function var_0_1.OnClickFormula(arg_22_0, arg_22_1)
	arg_22_0:HideFormulaList()
	arg_22_0:ShowFormulaDetail(arg_22_1)
	arg_22_0:DispalyChat(arg_22_0.chatText.clickFormula)
	arg_22_0:PlaySoundEffect(arg_22_0.soundStr.clickFormula)

	return
end

function var_0_1.OnClickFormulaBack(arg_23_0)
	arg_23_0:HideFormulaDetail()

	arg_23_0.contextData.formulaId = nil

	arg_23_0:ShowFormulaList()

	return
end

function var_0_1.ShowMaterialSelectWindow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0:DispalyChat(arg_24_0.chatText.showMaterialSelectWindow)
	arg_24_0:PlaySoundEffect(arg_24_0.soundStr.showMaterialSelectWindow)

	local var_24_0 = arg_24_0.atelierMaterialSelectView

	var_4.ShowCandicatePanel(var_24_0, arg_24_1, arg_24_2, arg_24_3)

	return
end

function var_0_1.ShowCompositeConfirmWindow(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.atelierCompositeConfirmView

	var_2.ShowCompositeConfirmWindow(var_25_0, arg_25_1)

	return
end

function var_0_1.OnSelectMaterial(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:DispalyChat(arg_26_0.chatText.selectMaterial)
	arg_26_0:PlaySoundEffect(arg_26_0.soundStr.selectMaterial)

	local var_26_0 = arg_26_0.atelierFormulaDetailView

	var_3.FillNode(var_26_0, arg_26_1, arg_26_2)

	return
end

function var_0_1.RefreshEmptyPanel(arg_27_0)
	setActive = var_1_10001

	var_1_10001(arg_27_0.layerEmpty, not arg_27_0.unlockSystem)

	setActive = var_1_10001

	var_1_10001(arg_27_0.painting, arg_27_0.unlockSystem)

	return
end

function var_0_1.ShowFormulaList(arg_28_0)
	arg_28_0:AddIdleTimer()

	local var_28_0 = arg_28_0.atelierFormulaListView

	var_1.ShowFormulaList(var_28_0)

	return
end

function var_0_1.HideFormulaList(arg_29_0)
	if not arg_29_0.layerFormulaPanel then
		return
	end

	arg_29_0:RemoveIdleTimer()

	setParent = var_1

	var_1(arg_29_0.layerFormulaPanel, arg_29_0._tf)

	setActive = var_1

	var_1(arg_29_0.layerFormulaPanel, false)

	return true
end

function var_0_1.ShowFormulaDetail(arg_30_0, arg_30_1)
	arg_30_0.contextData.formulaId = arg_30_1:GetConfigID()

	local var_30_0 = arg_30_0.atelierFormulaDetailView

	var_2.Show(var_30_0, arg_30_1)

	setParent = var_2

	var_2(arg_30_0.layerFormulaOverlayPanel, arg_30_0.top)

	local var_30_1 = arg_30_0.layerFormulaOverlayPanel

	var_2.SetSiblingIndex(var_30_1, 0)

	setParent = var_2

	var_2(arg_30_0.painting, arg_30_0.layerFormulaOverlayPanel)

	setActive = var_2

	var_2(arg_30_0.materialSelectPanel, false)

	return
end

function var_0_1.HideFormulaDetail(arg_31_0)
	isActive = var_1_10001

	if not var_1_10001(arg_31_0.layerFormulaDetailPanel) then
		return
	end

	local var_31_0 = arg_31_0.atelierMaterialSelectView

	var_1.HideCandicatePanel(var_31_0)

	setParent = var_1

	var_1(arg_31_0.painting, arg_31_0._tf)

	local var_31_1 = arg_31_0.painting

	var_1.SetSiblingIndex(var_31_1, 1)

	setParent = var_1

	var_1(arg_31_0.layerFormulaOverlayPanel, arg_31_0.layerFormulaDetailPanel)

	setActive = var_1

	var_1(arg_31_0.layerFormulaDetailPanel, false)

	return true
end

function var_0_1.ShowMaterialsPreview(arg_32_0)
	local var_32_0 = arg_32_0.atelierMaterialsPreview

	var_1.ShowMaterialsPreview(var_32_0, arg_32_0.atelierFormulaDetailView.nodeList)

	return
end

function var_0_1.DispalyChat(arg_33_0, arg_33_1)
	arg_33_0:HideChat()

	setActive = var_2

	var_2(arg_33_0.chat, true)

	LeanTween = var_2

	local var_33_0 = var_2.delayedCall

	go = var_4

	local var_33_1 = var_4(arg_33_0.chat)
	local var_33_2 = 4

	System = var_6
	arg_33_0.chatTween = var_33_0(var_33_1, var_33_2, var_6.Action(function()
		local var_34_0 = arg_33_0

		var_0.HideChat(var_34_0)

		return
	end)).uniqueId
	math = var_3

	local var_33_3 = arg_33_1[var_3.random(#arg_33_1)]

	pg = var_33_1

	local var_33_4 = var_33_1.gametip[arg_33_0.tipStr].tip

	_ = var_5

	local var_33_5 = var_5.detect(var_33_4, function(arg_35_0)
		return arg_35_0[1] == var_33_3
	end) and var_5[2]

	setText = var_7

	local var_33_6 = arg_33_0.chat

	var_7(var_9.Find(var_33_6, "Text"), var_33_5)

	local var_33_7 = arg_33_0:GetSoundPath() .. var_33_3

	arg_33_0:PlaySound(var_33_7)

	return
end

function var_0_1.GetSoundPath(arg_36_0)
	local var_36_0 = 1090001

	return "event:/cv/" .. var_36_0 .. "/"
end

function var_0_1.PlaySoundEffect(arg_37_0, arg_37_1)
	pg = var_1_10002

	local var_37_0 = var_1_10002.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_37_0, arg_37_1)

	return
end

function var_0_1.ShowItemDetail(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0
	local var_38_1 = arg_38_0.emit

	AtelierMaterialDetailMediator = var_1_10005

	var_38_1(var_38_0, var_1_10005.SHOW_DETAIL, arg_38_1)

	return
end

function var_0_1.LoadingOn(arg_39_0)
	if arg_39_0.animating then
		return
	end

	arg_39_0.animating = true
	pg = var_1

	local var_39_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_39_0, false)

	return
end

function var_0_1.LoadingOff(arg_40_0)
	if not arg_40_0.animating then
		return
	end

	pg = var_1

	local var_40_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOff(var_40_0)

	arg_40_0.animating = false

	return
end

function var_0_1.PlaySound(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0.playbackInfo or arg_41_1 ~= arg_41_0.prevCvPath or arg_41_0.playbackInfo.channelPlayer == nil then
		arg_41_0:StopSound()

		pg = var_3

		local var_41_0 = var_3.CriMgr.GetInstance()

		var_3.PlaySoundEffect_V3(var_41_0, arg_41_1, function(arg_42_0)
			if arg_42_0 then
				arg_41_0.playbackInfo = arg_42_0

				local var_42_0 = arg_41_0.playbackInfo

				var_1.SetIgnoreAutoUnload(var_42_0, true)

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
		local var_41_1 = arg_41_0.playbackInfo

		var_3.PlaybackStop(var_41_1)

		local var_41_2 = arg_41_0.playbackInfo

		var_3.SetStartTimeAndPlay(var_41_2)

		if arg_41_2 then
			arg_41_2(arg_41_0.playbackInfo.cueInfo)
		end

		return arg_41_0.playbackInfo.cueInfo
	elseif arg_41_2 then
		arg_41_2()
	end

	return nil
end

function var_0_1.StopSound(arg_43_0)
	if arg_43_0.playbackInfo then
		pg = var_1

		local var_43_0 = var_1.CriMgr.GetInstance()

		var_1.StopPlaybackInfoForce(var_43_0, arg_43_0.playbackInfo)

		local var_43_1 = arg_43_0.playbackInfo

		var_1.SetIgnoreAutoUnload(var_43_1, false)
	end

	return
end

function var_0_1.ClearSound(arg_44_0)
	arg_44_0:StopSound()

	if arg_44_0.playbackInfo then
		local var_44_0 = arg_44_0.playbackInfo

		var_1.Dispose(var_44_0)

		arg_44_0.playbackInfo = nil
	end

	return
end

function var_0_1.HideChat(arg_45_0)
	if arg_45_0.chatTween then
		LeanTween = var_1

		var_1.cancel(arg_45_0.chatTween)

		arg_45_0.chatTween = nil
	end

	setActive = var_1

	var_1(arg_45_0.chat, false)

	return
end

function var_0_1.AddIdleTimer(arg_46_0)
	arg_46_0:RemoveIdleTimer()

	Timer = var_1

	local var_46_0 = var_1.New

	local function var_46_1()
		local var_47_0 = arg_46_0

		var_0.DispalyChat(var_47_0, arg_46_0.chatText.idle)

		local var_47_1 = arg_46_0

		var_0.AddIdleTimer(var_47_1)

		return
	end

	math = var_1_10004
	arg_46_0.idleTimer = var_46_0(var_46_1, 8 + var_1_10004.random() * 4)

	local var_46_2 = arg_46_0.idleTimer

	var_1.Start(var_46_2)

	return
end

function var_0_1.RemoveIdleTimer(arg_48_0)
	if not arg_48_0.idleTimer then
		return
	end

	local var_48_0 = arg_48_0.idleTimer

	var_1.Stop(var_48_0)

	arg_48_0.idleTimer = nil

	return
end

function var_0_1.GetAtelierCompositEffect(arg_49_0)
	return "laisha_lianjin"
end

function var_0_1.GetAtelierCompositEffectPos(arg_50_0)
	Vector2 = var_1_10001

	return var_1_10001.zero
end

function var_0_1.OnCompositeResult(arg_51_0, arg_51_1)
	arg_51_0:LoadingOn()
	arg_51_0:DispalyChat(arg_51_0.chatText.compositeResult)

	local var_51_0 = 1.5
	local var_51_1 = 0.5
	local var_51_2 = arg_51_0.loader

	var_4.GetPrefab(var_51_2, "ui/" .. arg_51_0:GetAtelierCompositEffect(), "", function(arg_52_0)
		pg = var_2_10001

		local var_52_0 = var_2_10001.UIMgr.GetInstance()
		local var_52_1 = var_1.OverlayPanel

		tf = var_2_10004

		var_52_1(var_52_0, var_2_10004(arg_52_0))

		setAnchoredPosition = var_52_1

		local var_52_2 = arg_52_0
		local var_52_3 = arg_51_0

		var_52_1(var_52_2, var_4.GetAtelierCompositEffectPos(var_52_3))

		local var_52_4 = arg_51_0
		local var_52_5 = var_1.managedTween

		LeanTween = var_4

		local var_52_6 = var_4.alphaCanvas
		local var_52_7

		GetComponent = var_52_3

		local var_52_8 = arg_51_0._tf

		typeof = var_2_10009
		CanvasGroup = var_2_10011

		local var_52_9 = var_52_5(var_52_4, var_52_6, var_52_7, var_52_3(var_52_8, var_2_10009(var_2_10011)), 0, var_51_0)

		var_1.setFrom(var_52_9, 1)

		local var_52_10 = arg_51_0
		local var_52_11 = var_1.managedTween

		LeanTween = var_4

		local var_52_12 = var_4.alphaCanvas
		local var_52_13

		GetComponent = var_6

		local var_52_14 = arg_51_0.top

		typeof = var_9
		CanvasGroup = var_2_10011

		local var_52_15 = var_52_11(var_52_10, var_52_12, var_52_13, var_6(var_52_14, var_9(var_2_10011)), 0, var_51_0)

		var_1.setFrom(var_52_15, 1)

		local var_52_16 = arg_51_0
		local var_52_17 = var_1.managedTween

		LeanTween = var_4

		local var_52_18 = var_4.alphaCanvas
		local var_52_19

		GetComponent = var_6

		local var_52_20 = arg_51_0.compositeConfirmPanel

		typeof = var_9
		CanvasGroup = var_2_10011

		local var_52_21 = var_52_17(var_52_16, var_52_18, var_52_19, var_6(var_52_20, var_9(var_2_10011)), 0, var_51_0)

		var_1.setFrom(var_52_21, 1)

		local var_52_22 = arg_51_0
		local var_52_23 = var_1.managedTween

		LeanTween = var_4

		local var_52_24 = var_4.delayedCall

		local function var_52_25()
			local var_53_0 = arg_51_0.atelierCompositeConfirmView

			var_0.HideCompositeConfirmWindow(var_53_0)

			setCanvasGroupAlpha = var_0

			var_0(arg_51_0.compositeConfirmPanel, 1)

			local var_53_1 = arg_51_0

			var_0.CleanNodeInstance(var_53_1)

			local var_53_2 = arg_51_0.atelierCompositeResultView

			var_0.ShowCompositeResult(var_53_2, arg_51_1)

			local var_53_3 = arg_51_0

			var_0.DispalyChat(var_53_3, arg_51_0.chatText.compositeResult2)

			local var_53_4 = arg_51_0
			local var_53_5 = var_0.managedTween

			LeanTween = var_3

			local var_53_6 = var_3.alphaCanvas
			local var_53_7

			GetComponent = var_3_10005

			local var_53_8 = arg_51_0._tf

			typeof = var_3_10008
			CanvasGroup = var_3_10010

			local var_53_9 = var_53_5(var_53_4, var_53_6, var_53_7, var_3_10005(var_53_8, var_3_10008(var_3_10010)), 1, var_51_1)

			var_0.setFrom(var_53_9, 0)

			local var_53_10 = arg_51_0
			local var_53_11 = var_0.managedTween

			LeanTween = var_3

			local var_53_12 = var_3.alphaCanvas
			local var_53_13

			GetComponent = var_5

			local var_53_14 = arg_51_0.top

			typeof = var_8
			CanvasGroup = var_3_10010

			local var_53_15 = var_53_11(var_53_10, var_53_12, var_53_13, var_5(var_53_14, var_8(var_3_10010)), 1, var_51_1)

			var_0.setFrom(var_53_15, 0)

			local var_53_16 = arg_51_0
			local var_53_17 = var_0.managedTween

			LeanTween = var_3

			local var_53_18 = var_3.alphaCanvas
			local var_53_19

			GetOrAddComponent = var_5

			local var_53_20 = arg_51_0.compositeResultPanel

			typeof = var_8
			CanvasGroup = var_3_10010

			local var_53_21 = var_53_17(var_53_16, var_53_18, var_53_19, var_5(var_53_20, var_8(var_3_10010)), 1, var_51_1)

			var_0.setFrom(var_53_21, 0)

			local var_53_22 = arg_51_0
			local var_53_23 = var_0.managedTween

			LeanTween = var_3

			local var_53_24 = var_3.delayedCall

			local function var_53_25()
				local var_54_0 = arg_51_0

				var_0.LoadingOff(var_54_0)

				pg = var_0

				local var_54_1 = var_0.UIMgr.GetInstance()
				local var_54_2 = var_0.UnOverlayPanel

				tf = var_4_10003

				var_54_2(var_54_1, var_4_10003(arg_52_0), arg_51_0._tf)

				local var_54_3 = arg_51_0.loader

				var_0.ClearRequest(var_54_3, "CompositeResult")

				return
			end

			go = var_5

			var_53_23(var_53_22, var_53_24, var_53_25, var_5(arg_51_0.compositeResultPanel), var_51_1, nil)

			return
		end

		go = var_6

		var_52_23(var_52_22, var_52_24, var_52_25, var_6(arg_51_0.compositeResultPanel), var_51_0, nil)

		return
	end, "CompositeResult")

	return
end

function var_0_1.OnReceiveFormualRequest(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0.atelierMaterialSelectView

	var_2.HideCandicatePanel(var_55_0)

	local var_55_1 = arg_55_0.atelierCompositeConfirmView

	var_2.HideCompositeConfirmWindow(var_55_1)

	local var_55_2 = arg_55_0.atelierCompositeResultView

	var_2.HideCompositeResult(var_55_2)

	local var_55_3 = arg_55_0.atelierMaterialsPreview

	var_2.HideMaterialsPreview(var_55_3)
	arg_55_0:HideFormulaList()

	local var_55_4 = arg_55_0.activity
	local var_55_5 = var_2.GetFormulas(var_55_4)[arg_55_1]

	arg_55_0:ShowFormulaDetail(var_55_5)

	return
end

function var_0_1.CleanNodeInstance(arg_56_0)
	local var_56_0 = arg_56_0.activity
	local var_56_1 = var_1.GetFormulas(var_56_0)[arg_56_0.contextData.formulaId]

	if not var_1.IsAvaliable(var_56_1) then
		arg_56_0:HideFormulaDetail()

		var_56_0 = arg_56_0.contextData
		var_56_0.formulaId = nil

		arg_56_0:ShowFormulaList()

		return
	end

	_ = var_56_0

	var_56_0.each(arg_56_0.atelierFormulaDetailView.nodeList, function(arg_57_0)
		arg_57_0.Instance = nil
		arg_57_0.Change = true

		return
	end)
	arg_56_0:ShowFormulaDetail(var_1)

	return
end

function var_0_1.onBackPressed(arg_58_0)
	if arg_58_0.animating then
		return true
	end

	local var_58_0 = arg_58_0.atelierMaterialsPreview

	if var_1.HideMaterialsPreview(var_58_0) then
		return true
	end

	local var_58_1 = arg_58_0.atelierCompositeResultView

	if var_1.HideCompositeResult(var_58_1) then
		return true
	end

	local var_58_2 = arg_58_0.atelierCompositeConfirmView

	if var_1.HideCompositeConfirmWindow(var_58_2) then
		return true
	end

	local var_58_3 = arg_58_0.atelierMaterialSelectView

	if var_1.HideCandicatePanel(var_58_3) then
		return true
	end

	if arg_58_0:HideFormulaDetail() then
		arg_58_0.contextData.formulaId = nil

		arg_58_0:ShowFormulaList()

		return true
	end

	arg_58_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

return var_0_1
