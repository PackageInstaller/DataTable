class = var_0_10000

local var_0_0 = "AtelierCompositeYumiaScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.Atelier.base.AtelierCompositeBaseScene"))

function var_0_1.getUIName(arg_1_0)
	return "AtelierCompositeYumiaUI"
end

function var_0_1.InitCustom(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.layerEmpty = var_1.Find(var_2_0, "bg/Empty")
	setText = var_1

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_2.Find(var_2_1, "bg/Empty/bg/Text")

	i18n = var_2_1

	var_1(var_2_2, var_2_1(arg_2_0.unlockText))

	local var_2_3 = arg_2_0._tf

	arg_2_0.painting = var_1.Find(var_2_3, "bg/painting")

	local var_2_4 = arg_2_0._tf

	arg_2_0.topBar = var_1.Find(var_2_4, "Top/TopBar")

	local var_2_5 = arg_2_0._tf

	arg_2_0.chat = var_1.Find(var_2_5, "bg/Chat")
	setActive = var_1

	var_1(arg_2_0.chat, false)

	return
end

function var_0_1.InitStr(arg_3_0)
	arg_3_0.bundleName = "ui/AtelierCompositeYumiaUI_atlas"
	arg_3_0.commonBundleName = "ui/AtelierCommonYumiaUI_atlas"
	arg_3_0.chatText = {
		idle = {
			"atelier_yumia_1"
		},
		clickFormula = {
			"atelier_yumia_2",
			"atelier_yumia_3",
			"atelier_yumia_4"
		},
		showMaterialSelectWindow = {
			"atelier_yumia_2",
			"atelier_yumia_3",
			"atelier_yumia_4"
		},
		selectMaterial = {
			"atelier_yumia_5",
			"atelier_atellier6",
			"atelier_atellier7"
		},
		compositeResult = {
			"atelier_atellier8",
			"atelier_atellier9"
		},
		compositeResult2 = {
			"atelier_atellier10",
			"atelier_atellier11"
		}
	}
	arg_3_0.soundStr = {
		formulaDetailUnlock = "event:/ui/ryza_atellier_ui_3",
		showMaterialSelectWindow = "event:/ui/ryza_atellier_ui_1",
		compositeConfirm = "event:/ui/ryza_atellier_ui_6",
		selectMaterial = "event:/ui/ryza_atellier_ui_2",
		formulaDetail = "event:/ui/ryza_atellier_ui_5",
		clickFormula = "event:/ui/ryza_atellier_ui_1",
		formulaDetailFill = "event:/ui/ryza_atellier_ui_4"
	}
	arg_3_0.helpStr = "ryza_composite_help_tip"
	arg_3_0.tipStr = "yumia_atelier_tip22"
	arg_3_0.unlockText = "yumia_atelier_tip1"

	return
end

function var_0_1.InitView(arg_4_0)
	AtelierFormulaListYumiaView = var_1_10001
	arg_4_0.atelierFormulaListView = var_1_10001.New(arg_4_0.layerFormulaPanel, arg_4_0)
	AtelierFormulaDetailYumiaView = var_1
	arg_4_0.atelierFormulaDetailView = var_1.New(arg_4_0.layerFormulaDetailPanel, arg_4_0)
	AtelierMaterialSelectYumiaView = var_1
	arg_4_0.atelierMaterialSelectView = var_1.New(arg_4_0.materialSelectPanel, arg_4_0)
	AtelierFormulaMaterialsPreviewYumia = var_1
	arg_4_0.atelierMaterialsPreview = var_1.New(arg_4_0.materialsPreviewPanel, arg_4_0)
	AtelierCompositeConfirmYumiaView = var_1
	arg_4_0.atelierCompositeConfirmView = var_1.New(arg_4_0.compositeConfirmPanel, arg_4_0)
	AtelierCompositeResultYumiaView = var_1
	arg_4_0.atelierCompositeResultView = var_1.New(arg_4_0.compositeResultPanel, arg_4_0)

	return
end

function var_0_1.RefreshEmptyPanel(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.layerEmpty, not arg_5_0.unlockSystem)

	return
end

function var_0_1.didEnter(arg_6_0)
	arg_6_0:UpdateAdapt()
	var_0_1.super.didEnter(arg_6_0)

	return
end

function var_0_1.UpdateAdapt(arg_7_0)
	local var_7_0 = 1.3333333333333333
	local var_7_1 = 2.1666666666666665

	pg = var_1_10003

	local var_7_2 = var_1_10003.CameraFixMgr.GetInstance().currentWidth / var_3.currentHeight

	math = var_5

	local var_7_3 = var_5.clamp(var_7_2, var_7_0, var_7_1)
	local var_7_4 = arg_7_0._tf
	local var_7_5 = var_5.GetComponent

	typeof = var_7
	AspectRatioFitter = var_8
	var_7_5(var_7_4, var_7(var_8)).aspectRatio = var_7_3

	local var_7_6 = arg_7_0.top
	local var_7_7 = var_5.GetComponent

	typeof = var_7
	AspectRatioFitter = var_8
	var_7_7(var_7_6, var_7(var_8)).aspectRatio = var_7_3

	return
end

function var_0_1.OnClickStore(arg_8_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.getCurrentContext(var_8_0)
	local var_8_2 = var_1.getContextByMediator

	AtelierCompositeMediator = var_1_10004

	local var_8_3 = var_8_2(var_8_1, var_1_10004)

	addSubLayer = var_8_1
	Context = var_1_10004

	local var_8_4 = var_1_10004.New
	local var_8_5 = {}

	AtelierStoreBaseMediator = var_1_10006
	var_8_5.mediator = var_1_10006
	AtelierStoreYumiaScene = var_1_10006
	var_8_5.viewComponent = var_1_10006
	var_8_5.data = {
		activity = arg_8_0.activity
	}

	var_8_1(var_8_4(var_8_5), var_8_3)

	return
end

function var_0_1.ShowFormulaList(arg_9_0)
	arg_9_0:AddIdleTimer()

	local var_9_0 = arg_9_0.atelierFormulaListView

	var_1.ShowFormulaList(var_9_0)

	return
end

function var_0_1.ShowFormulaDetail(arg_10_0, arg_10_1)
	arg_10_0.contextData.formulaId = arg_10_1:GetConfigID()

	local var_10_0 = arg_10_0.atelierFormulaDetailView

	var_2.Show(var_10_0, arg_10_1)

	setActive = var_2

	var_2(arg_10_0.materialSelectPanel, false)

	return
end

function var_0_1.HideFormulaDetail(arg_11_0)
	arg_11_0:ShowTopBar(true)

	isActive = var_1

	if not var_1(arg_11_0.layerFormulaDetailPanel) then
		return
	end

	local var_11_0 = arg_11_0.atelierMaterialSelectView

	var_1.HideCandicatePanel(var_11_0)

	local var_11_1 = arg_11_0.atelierFormulaDetailView

	var_1.HideDescriptionView(var_11_1)

	setActive = var_1

	var_1(arg_11_0.layerFormulaDetailPanel, false)

	return true
end

function var_0_1.ShowMaterialSelectWindow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0.atelierFormulaDetailView

	var_4.HideDescriptionView(var_12_0)

	local var_12_1 = arg_12_0.atelierFormulaDetailView

	var_4.HideCompositePanel(var_12_1)
	var_0_1.super.ShowMaterialSelectWindow(arg_12_0, arg_12_1, arg_12_2, arg_12_3)

	return
end

function var_0_1.RefreshScrollViewPosition(arg_13_0)
	local var_13_0 = arg_13_0.atelierFormulaDetailView

	var_1.RefreshScrollViewPosition(var_13_0)

	return
end

function var_0_1.ShowTopBar(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.topBar, arg_14_1)

	return
end

function var_0_1.UpdateRyzaDrop(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	updateDrop = var_1_10004

	var_1_10004(arg_15_1, arg_15_2)

	SetCompomentEnabled = var_1_10004

	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_1.Find(var_15_0, "icon_bg")

	typeof = var_15_0
	Image = var_7

	var_1_10004(var_15_1, var_15_0(var_7), false)

	setActive = var_1_10004

	var_1_10004(arg_15_1:Find("bg"), false)

	setActive = var_1_10004

	var_1_10004(arg_15_1:Find("icon_bg/frame"), false)

	setActive = var_1_10004

	var_1_10004(arg_15_1:Find("icon_bg/stars"), false)

	local var_15_2 = arg_15_2:getConfig("rarity")
	local var_15_3 = arg_15_2.type

	DROP_TYPE_EQUIP = var_6

	if var_15_3 ~= var_6 then
		var_15_3 = arg_15_2.type
		DROP_TYPE_EQUIPMENT_SKIN = var_6

		if var_15_3 == var_6 then
			var_15_2 = var_15_2 - 1
		end

		ItemRarity = var_15_3

		local var_15_4 = var_15_3.Rarity2Print(var_15_2)

		GetImageSpriteFromAtlasAsync = var_6

		local var_15_5 = "weaponframes"
		local var_15_6 = "bg" .. var_15_4
		local var_15_7 = arg_15_1

		var_6(var_15_5, var_15_6, arg_15_1.Find(var_15_7, "icon_bg"))

		local var_15_8 = arg_15_2.type

		DROP_TYPE_RYZA_DROP = var_15_5

		if var_15_8 ~= var_15_5 then
			onButton = var_15_8

			local var_15_9 = arg_15_0
			local var_15_10 = arg_15_1

			local function var_15_11()
				local var_16_0 = arg_15_0

				var_0.emit(var_16_0, var_0_1.ON_DROP, arg_15_2)

				return
			end

			SFX_PANEL = var_15_7

			var_15_8(var_15_9, var_15_10, var_15_11, var_15_7)
		else
			removeOnButton = var_15_8

			var_15_8(arg_15_1)
		end

		return
	end
end

function var_0_1.UpdateRyzaItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	AtelierTools = var_1_10004

	var_1_10004.UpdateYumiaItem(arg_17_1, arg_17_2)

	return
end

function var_0_1.GetAtelierCompositEffect(arg_18_0)
	return "youmiya_lianjinhecheng"
end

function var_0_1.GetAtelierCompositEffectPos(arg_19_0)
	Vector2 = var_1_10001

	return var_1_10001(0, 100)
end

function var_0_1.AddIdleTimer(arg_20_0)
	GetComponent = var_1_10001

	local var_20_0 = arg_20_0._tf

	typeof = var_1_10003
	Animation = var_1_10004

	local var_20_1 = var_1_10001(var_20_0, var_1_10003(var_1_10004))

	if var_1.IsPlaying(var_20_1, "anim_composite_in") then
		arg_20_0:RemoveIdleTimer()

		FrameTimer = var_2
		arg_20_0.idleTimer = var_2.New(function()
			local var_21_0 = var_0

			if not var_0.IsPlaying(var_21_0, "anim_composite_in") then
				local var_21_1 = arg_20_0

				var_0.DispalyChat(var_21_1, arg_20_0.chatText.idle)

				local var_21_2 = arg_20_0

				var_0.AddChatTimer(var_21_2)

				return
			end

			return
		end, 1, -1)

		local var_20_2 = arg_20_0.idleTimer

		var_2.Start(var_20_2)
	else
		arg_20_0:AddChatTimer()
	end

	return
end

function var_0_1.AddChatTimer(arg_22_0)
	arg_22_0:RemoveIdleTimer()

	Timer = var_1

	local var_22_0 = var_1.New

	local function var_22_1()
		local var_23_0 = arg_22_0

		var_0.DispalyChat(var_23_0, arg_22_0.chatText.idle)

		local var_23_1 = arg_22_0

		var_0.AddIdleTimer(var_23_1)

		return
	end

	math = var_1_10003
	arg_22_0.idleTimer = var_22_0(var_22_1, 8 + var_1_10003.random() * 4)

	local var_22_2 = arg_22_0.idleTimer

	var_1.Start(var_22_2)

	return
end

function var_0_1.DispalyChat(arg_24_0, arg_24_1)
	GetComponent = var_1_10002

	local var_24_0 = arg_24_0._tf

	typeof = var_1_10004
	Animation = var_1_10005

	local var_24_1 = var_1_10002(var_24_0, var_1_10004(var_1_10005))

	if var_2.IsPlaying(var_24_1, "anim_composite_in") then
		return
	end

	var_0_1.super.DispalyChat(arg_24_0, arg_24_1)

	local var_24_2 = arg_24_0.painting
	local var_24_3 = var_3.Find(var_24_2, "root")
	local var_24_4 = var_3.GetComponent(var_24_3, "Animation")

	var_3.Play(var_24_4, "anim_composite_formulalist_talk")

	return
end

function var_0_1.GetSoundPath(arg_25_0)
	local var_25_0 = 17

	return "event:/cv/" .. var_25_0 .. "/"
end

function var_0_1.PlaySoundEffect(arg_26_0, arg_26_1)
	return
end

function var_0_1.ClearSound(arg_27_0)
	return
end

function var_0_1.PlayGuide(arg_28_0)
	return
end

return var_0_1
