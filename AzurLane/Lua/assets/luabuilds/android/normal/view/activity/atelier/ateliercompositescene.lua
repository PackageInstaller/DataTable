class = var_0_10000

local var_0_0 = "AtelierCompositeScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AtelierCompositeUI"
end

import = var_1

local var_0_2 = var_1("model.vo.AtelierFormula")

import = var_2

local var_0_3 = var_2("model.vo.AtelierFormulaCircle")

import = var_3

local var_0_4 = var_3("Mgr.Pool.PoolPlural")

bit = var_4
var_0_1.FilterAll = var_4.bor(1, 2, 4)

function var_0_1.Ctor(arg_2_0, ...)
	var_0_1.super.Ctor(arg_2_0, ...)

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.layerEmpty = var_1.Find(var_3_0, "Empty")

	local var_3_1 = arg_3_0._tf

	arg_3_0.layerFormula = var_1.Find(var_3_1, "FormulaList")

	local var_3_2 = arg_3_0._tf

	arg_3_0.painting = var_1.Find(var_3_2, "Painting")

	local var_3_3 = arg_3_0.painting

	arg_3_0.chat = var_1.Find(var_3_3, "Chat")

	local var_3_4 = arg_3_0._tf

	arg_3_0.layerFormulaDetail = var_1.Find(var_3_4, "FormulaDetail")

	local var_3_5 = arg_3_0.layerFormulaDetail

	arg_3_0.layerFormulaOverlay = var_1.Find(var_3_5, "Overlay")

	local var_3_6 = arg_3_0.layerFormulaOverlay

	arg_3_0.layerMaterialSelect = var_1.Find(var_3_6, "AvaliableMaterials")

	local var_3_7 = arg_3_0._tf

	arg_3_0.layerCompositeConfirm = var_1.Find(var_3_7, "CompositeConfirmWindow")

	local var_3_8 = arg_3_0._tf

	arg_3_0.layerCompositeResult = var_1.Find(var_3_8, "CompositeResultWindow")

	local var_3_9 = arg_3_0._tf

	arg_3_0.layerStoreHouse = var_1.Find(var_3_9, "StoreHouseWindow")

	local var_3_10 = arg_3_0._tf

	arg_3_0.layerMaterialsPreview = var_1.Find(var_3_10, "FormulaMaterialsPreview")

	local var_3_11 = arg_3_0._tf

	arg_3_0.top = var_1.Find(var_3_11, "Top")

	local var_3_12 = arg_3_0.layerFormula
	local var_3_13 = var_1.Find(var_3_12, "Frame/ScrollView")

	arg_3_0.formulaRect = var_1.GetComponent(var_3_13, "LScrollRect")

	local var_3_14 = arg_3_0.layerFormula
	local var_3_15 = var_1.Find(var_3_14, "Frame/Item")

	setActive = var_3_14

	var_3_14(var_3_15, false)

	local var_3_16 = arg_3_0.formulaRect

	function var_3_16.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0

		var_2.UpdateFormulaItem(var_4_0, arg_4_0 + 1, arg_4_1)

		return
	end

	_ = var_3_16
	arg_3_0.formulaFilterButtons = var_3_16.map({
		1,
		2,
		3
	}, function(arg_5_0)
		local var_5_0 = arg_3_0.layerFormula
		local var_5_1 = var_1.Find(var_5_0, "Frame/Tabs")

		return var_1.GetChild(var_5_1, arg_5_0 - 1)
	end)

	local var_3_17 = arg_3_0.layerMaterialSelect
	local var_3_18 = var_2.Find(var_3_17, "Frame/List")

	arg_3_0.candicatesRect = var_2.GetComponent(var_3_18, "LScrollRect")

	local var_3_19 = arg_3_0.layerMaterialSelect
	local var_3_20 = var_2.Find(var_3_19, "Frame/Item")

	setActive = var_3_19

	var_3_19(var_3_20, false)

	function arg_3_0.candicatesRect.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0

		var_2.UpdateCandicateItem(var_6_0, arg_6_0 + 1, arg_6_1)

		return
	end

	local var_3_21 = arg_3_0.layerStoreHouse
	local var_3_22 = var_3.Find(var_3_21, "Window/ScrollView")

	arg_3_0.storehouseRect = var_3.GetComponent(var_3_22, "LScrollRect")

	local var_3_23 = arg_3_0.layerStoreHouse
	local var_3_24 = var_3.Find(var_3_23, "Window/ScrollView/Item")

	setActive = var_3_23

	var_3_23(var_3_24, false)

	setActive = var_3_23

	var_3_23(arg_3_0.layerFormula, false)

	setActive = var_3_23

	var_3_23(arg_3_0.layerFormulaDetail, false)

	setActive = var_3_23

	var_3_23(arg_3_0.layerMaterialSelect, false)

	setActive = var_3_23

	var_3_23(arg_3_0.layerEmpty, false)

	setActive = var_3_23

	var_3_23(arg_3_0.layerStoreHouse, false)

	setActive = var_3_23

	var_3_23(arg_3_0.chat, false)

	pg = var_3_23

	local var_3_25 = var_3_23.ViewUtils.SetSortingOrder
	local var_3_26 = arg_3_0._tf
	local var_3_27 = var_5.Find(var_3_26, "Mask/BG")

	var_3_25(var_5.GetChild(var_3_27, 0), -1)

	setText = var_3_25

	local var_3_28 = arg_3_0._tf
	local var_3_29 = var_5.Find(var_3_28, "Empty/Bar/Text")

	i18n = var_3_28

	var_3_25(var_3_29, var_3_28("ryza_tip_composite_unlock"))

	setText = var_3_25

	local var_3_30 = arg_3_0.layerFormula
	local var_3_31 = var_5.Find(var_3_30, "Frame/Filter/Text")

	i18n = var_3_30

	var_3_25(var_3_31, var_3_30("ryza_toggle_only_composite"))

	setText = var_3_25

	local var_3_32 = arg_3_0.layerFormula
	local var_3_33 = var_5.Find(var_3_32, "Frame/Empty")

	i18n = var_3_32

	var_3_25(var_3_33, var_3_32("ryza_tip_no_recipe"))

	setText = var_3_25

	local var_3_34 = arg_3_0.layerFormula
	local var_3_35 = var_5.Find(var_3_34, "Frame/Item/Lock/Text")

	i18n = var_3_34

	var_3_25(var_3_35, var_3_34("ryza_tip_unlock_all_tools"))

	setText = var_3_25

	local var_3_36 = arg_3_0.layerFormula
	local var_3_37 = var_5.Find(var_3_36, "Bar/Text")

	i18n = var_3_36

	var_3_25(var_3_37, var_3_36("ryza_tip_select_recipe"))

	setText = var_3_25

	local var_3_38 = arg_3_0.layerStoreHouse
	local var_3_39 = var_5.Find(var_3_38, "Window/Empty")

	i18n = var_3_38

	var_3_25(var_3_39, var_3_38("ryza_tip_no_item"))

	setText = var_3_25

	local var_3_40 = arg_3_0.layerCompositeResult
	local var_3_41 = var_5.Find(var_3_40, "Window/CountBG/Tip")

	i18n = var_3_40

	var_3_25(var_3_41, var_3_40("ryza_composite_count"))

	setText = var_3_25

	local var_3_42 = arg_3_0.layerMaterialsPreview
	local var_3_43 = var_5.Find(var_3_42, "Frame/Text")

	i18n = var_3_42

	var_3_25(var_3_43, var_3_42("ryza_tip_item_access"))

	setText = var_3_25

	local var_3_44 = var_3_20
	local var_3_45 = var_3_20.Find(var_3_44, "IconBG/Lack/Text")

	i18n = var_3_44

	var_3_25(var_3_45, var_3_44("ryza_ui_show_acess"))

	return
end

function var_0_1.SetEnabled(arg_7_0, arg_7_1)
	arg_7_0.unlockSystem = arg_7_1

	return
end

function var_0_1.SetActivity(arg_8_0, arg_8_1)
	arg_8_0.activity = arg_8_1

	return
end

local var_0_5 = "ui/AtelierCompositeUI_atlas"
local var_0_6 = "ui/AtelierCommonUI_atlas"

function var_0_1.preload(arg_9_0, arg_9_1)
	table = var_1_10002

	var_1_10002.ParallelIpairsAsync({
		var_0_5,
		var_0_6
	}, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_9_0.loader

		var_3.LoadBundle(var_10_0, arg_10_1, arg_10_2)

		return
	end, arg_9_1)

	return
end

function var_0_1.didEnter(arg_11_0)
	local var_11_0 = arg_11_0.contextData

	var_11_0.filterType = var_0_1.FilterAll
	table = var_11_0

	var_11_0.Foreach(arg_11_0.formulaFilterButtons, function(arg_12_0, arg_12_1)
		onButton = var_2_10002

		local var_12_0 = arg_11_0
		local var_12_1 = arg_12_1

		local function var_12_2()
			if arg_11_0.contextData.filterType == var_0_1.FilterAll then
				local var_13_0 = arg_11_0.contextData

				bit = var_1
				var_13_0.filterType = var_1.lshift(1, arg_12_0 - 1)
			else
				local var_13_1 = arg_11_0.contextData

				bit = var_1

				local var_13_2 = var_1.bxor
				local var_13_3 = arg_11_0.contextData.filterType

				bit = var_3_10003
				var_13_1.filterType = var_13_2(var_13_3, var_3_10003.lshift(1, arg_12_0 - 1))

				if arg_11_0.contextData.filterType == 0 then
					arg_11_0.contextData.filterType = var_0_1.FilterAll
				end
			end

			local var_13_4 = arg_11_0

			var_0.UpdateFilterButtons(var_13_4)

			local var_13_5 = arg_11_0

			var_0.FilterFormulas(var_13_5)

			local var_13_6 = arg_11_0

			var_0.UpdateFormulaList(var_13_6)

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10002(var_12_0, var_12_1, var_12_2, var_2_10006)

		return
	end)

	onToggle = var_1

	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_0.layerFormula

	var_1(var_11_1, var_3.Find(var_11_2, "Frame/Filter/Toggle"), function(arg_14_0)
		arg_11_0.showOnlyComposite = arg_14_0

		local var_14_0 = arg_11_0

		var_1.FilterFormulas(var_14_0)

		local var_14_1 = arg_11_0

		var_1.UpdateFormulaList(var_14_1)

		return
	end)

	onButton = var_1

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.layerFormulaOverlay

	var_1(var_11_3, var_3.Find(var_11_4, "Description/List"), function()
		local var_15_0 = arg_11_0

		var_0.HideFormulaDetail(var_15_0)

		arg_11_0.contextData.formulaId = nil

		local var_15_1 = arg_11_0

		var_0.ShowFormulaList(var_15_1)

		return
	end)

	onButton = var_1

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0._tf
	local var_11_7 = var_3.Find(var_11_6, "Top/Back")

	local function var_11_8()
		local var_16_0 = arg_11_0

		var_0.onBackPressed(var_16_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_5, var_11_7, var_11_8, var_5)

	onButton = var_1

	local var_11_9 = arg_11_0
	local var_11_10 = arg_11_0._tf
	local var_11_11 = var_3.Find(var_11_10, "Top/Home")

	local function var_11_12()
		local var_17_0 = arg_11_0

		var_0.quickExitFunc(var_17_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_9, var_11_11, var_11_12, var_5)

	onButton = var_1

	local var_11_13 = arg_11_0
	local var_11_14 = arg_11_0._tf
	local var_11_15 = var_3.Find(var_11_14, "Top/Help")

	local function var_11_16()
		pg = var_2_10000

		local var_18_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_18_1 = var_0.ShowMsgBox
		local var_18_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_18_2.type = var_2_10003
		i18n = var_2_10003
		var_18_2.helps = var_2_10003("ryza_composite_help_tip")

		var_18_1(var_18_0, var_18_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_13, var_11_15, var_11_16, var_5)

	onButton = var_1

	local var_11_17 = arg_11_0
	local var_11_18 = arg_11_0.layerMaterialSelect
	local var_11_19 = var_3.Find(var_11_18, "BG")

	local function var_11_20()
		local var_19_0 = arg_11_0

		var_0.CloseCandicatePanel(var_19_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_17, var_11_19, var_11_20, var_5)

	onButton = var_1

	local var_11_21 = arg_11_0
	local var_11_22 = arg_11_0.layerCompositeConfirm
	local var_11_23 = var_3.Find(var_11_22, "BG")

	local function var_11_24()
		local var_20_0 = arg_11_0

		var_0.HideCompositeConfirmWindow(var_20_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_21, var_11_23, var_11_24, var_5)

	onButton = var_1

	local var_11_25 = arg_11_0
	local var_11_26 = arg_11_0.layerCompositeConfirm
	local var_11_27 = var_3.Find(var_11_26, "Window/Cancel")

	local function var_11_28()
		local var_21_0 = arg_11_0

		var_0.HideCompositeConfirmWindow(var_21_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_25, var_11_27, var_11_28, var_5)

	onButton = var_1

	local var_11_29 = arg_11_0
	local var_11_30 = arg_11_0.layerCompositeResult
	local var_11_31 = var_3.Find(var_11_30, "BG")

	local function var_11_32()
		local var_22_0 = arg_11_0

		var_0.HideCompositeResult(var_22_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_29, var_11_31, var_11_32, var_5)

	onButton = var_1

	local var_11_33 = arg_11_0
	local var_11_34 = arg_11_0._tf
	local var_11_35 = var_3.Find(var_11_34, "Top/StoreHouse")

	local function var_11_36()
		arg_11_0.contextData.showStoreHouse = true

		local var_23_0 = arg_11_0

		var_0.ShowStoreHouseWindow(var_23_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_11_33, var_11_35, var_11_36, var_5)

	onButton = var_1

	local var_11_37 = arg_11_0
	local var_11_38 = arg_11_0.layerStoreHouse
	local var_11_39 = var_3.Find(var_11_38, "Window/Close")

	local function var_11_40()
		local var_24_0 = arg_11_0

		var_0.CloseStoreHouseWindow(var_24_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_37, var_11_39, var_11_40, var_5)

	onButton = var_1

	local var_11_41 = arg_11_0
	local var_11_42 = arg_11_0.layerStoreHouse
	local var_11_43 = var_3.Find(var_11_42, "BG")

	local function var_11_44()
		local var_25_0 = arg_11_0

		var_0.CloseStoreHouseWindow(var_25_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_41, var_11_43, var_11_44, var_5)

	onButton = var_1

	local var_11_45 = arg_11_0
	local var_11_46 = arg_11_0.layerMaterialsPreview
	local var_11_47 = var_3.Find(var_11_46, "BG")

	local function var_11_48()
		local var_26_0 = arg_11_0

		var_0.HideMaterialsPreview(var_26_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_11_45, var_11_47, var_11_48, var_5)

	pg = var_1

	local var_11_49 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_11_49, arg_11_0.top)

	local var_11_52

	if not arg_11_0.unlockSystem then
		setActive = var_1

		var_1(arg_11_0.layerEmpty, true)

		setActive = var_1

		var_1(arg_11_0.painting, false)
	else
		if arg_11_0.contextData.formulaId then
			local var_11_50 = arg_11_0.activity
			local var_11_51 = var_1.GetFormulas(var_11_50)[arg_11_0.contextData.formulaId]

			var_11_52 = arg_11_0

			arg_11_0.ShowFormulaDetail(var_11_52, var_11_51)
		else
			arg_11_0:DispalyChat({
				"ryza_atellier1"
			})
			arg_11_0:ShowFormulaList()
		end

		if arg_11_0.contextData.showStoreHouse then
			arg_11_0:ShowStoreHouseWindow()
		end
	end

	if arg_11_0.unlockSystem then
		PlayerPrefs = var_1

		local var_11_53 = var_1.GetInt
		local var_11_54 = "first_enter_ryza_atelier_"

		getProxy = var_11_52
		PlayerProxy = var_11_48

		local var_11_55 = var_11_52(var_11_48)

		if var_11_53(var_11_54 .. var_3.getRawData(var_11_55).id, 0) == 0 then
			triggerButton = var_1

			local var_11_56 = arg_11_0._tf

			var_1(var_2.Find(var_11_56, "Top/Help"))

			PlayerPrefs = var_1

			local var_11_57 = var_1.SetInt
			local var_11_58 = "first_enter_ryza_atelier_"

			getProxy = var_11_56
			PlayerProxy = var_4

			local var_11_59 = var_11_56(var_4)

			var_11_57(var_11_58 .. var_3.getRawData(var_11_59).id, 1)
		end
	end

	return
end

function var_0_1.onBackPressed(arg_27_0)
	if arg_27_0.animating then
		return true
	end

	if arg_27_0:CloseStoreHouseWindow() then
		return true
	end

	if arg_27_0:HideMaterialsPreview() then
		return true
	end

	if arg_27_0:HideCompositeResult() then
		return true
	end

	if arg_27_0:HideCompositeConfirmWindow() then
		return true
	end

	if arg_27_0:HideCandicatePanel() then
		return true
	end

	if arg_27_0:HideFormulaDetail() then
		arg_27_0.contextData.formulaId = nil

		arg_27_0:ShowFormulaList()

		return true
	end

	arg_27_0:emit(var_0_1.ON_BACK_PRESSED)

	return
end

function var_0_1.UpdateFilterButtons(arg_28_0)
	table = var_1_10001

	var_1_10001.Foreach(arg_28_0.formulaFilterButtons, function(arg_29_0, arg_29_1)
		local var_29_0, var_29_2

		if arg_28_0.contextData.filterType ~= var_0_1.FilterAll then
			bit = var_29_0
			var_29_0 = var_29_0.band

			local var_29_1 = arg_28_0.contextData.filterType

			bit = var_2_10005
			var_29_2 = var_29_0(var_29_1, var_2_10005.lshift(1, arg_29_0 - 1)) > 0
		end

		setActive = var_29_0

		var_29_0(arg_29_1:Find("Selected"), var_29_2)

		return
	end)

	return
end

function var_0_1.AddIdleTimer(arg_30_0)
	arg_30_0:RemoveIdleTimer()

	Timer = var_1

	local var_30_0 = var_1.New

	local function var_30_1()
		local var_31_0 = arg_30_0

		var_0.DispalyChat(var_31_0, {
			"ryza_atellier1"
		})

		local var_31_1 = arg_30_0

		var_0.AddIdleTimer(var_31_1)

		return
	end

	math = var_1_10003
	arg_30_0.idleTimer = var_30_0(var_30_1, 8 + var_1_10003.random() * 4)

	local var_30_2 = arg_30_0.idleTimer

	var_1.Start(var_30_2)

	return
end

function var_0_1.RemoveIdleTimer(arg_32_0)
	if not arg_32_0.idleTimer then
		return
	end

	local var_32_0 = arg_32_0.idleTimer

	var_1.Stop(var_32_0)

	arg_32_0.idleTimer = nil

	return
end

function var_0_1.ShowFormulaList(arg_33_0)
	arg_33_0:AddIdleTimer()

	setActive = var_1

	var_1(arg_33_0.layerFormula, true)

	setParent = var_1

	var_1(arg_33_0.layerFormula, arg_33_0.top)

	local var_33_0 = arg_33_0.layerFormula

	var_1.SetSiblingIndex(var_33_0, 0)
	arg_33_0:UpdateFilterButtons()
	arg_33_0:FilterFormulas()
	arg_33_0:UpdateFormulaList()

	return
end

function var_0_1.HideFormulaList(arg_34_0)
	if not arg_34_0.layerFormula then
		return
	end

	arg_34_0:RemoveIdleTimer()

	setParent = var_1

	var_1(arg_34_0.layerFormula, arg_34_0._tf)

	setActive = var_1

	var_1(arg_34_0.layerFormula, false)

	return true
end

function var_0_1.FilterFormulas(arg_35_0)
	arg_35_0.filterFormulas = {}

	local var_35_0 = arg_35_0.contextData.filterType

	local function var_35_1(arg_36_0)
		if var_35_0 == var_0_1.FilterAll then
			return true
		end

		switch = var_1

		return var_1(arg_36_0:GetType(), {
			[var_0_2.TYPE.EQUIP] = function()
				bit = var_3_10000

				return var_3_10000.band(var_35_0, 1) > 0
			end,
			[var_0_2.TYPE.ITEM] = function()
				bit = var_3_10000

				return var_3_10000.band(var_35_0, 2) > 0
			end,
			[var_0_2.TYPE.TOOL] = function()
				bit = var_3_10000

				return var_3_10000.band(var_35_0, 4) > 0
			end,
			[var_0_2.TYPE.OTHER] = function()
				bit = var_3_10000

				return var_3_10000.band(var_35_0, 4) > 0
			end
		})
	end

	ipairs = var_1_10003
	_ = var_1_10004

	local var_35_2 = var_1_10004.values
	local var_35_3 = arg_35_0.activity

	for iter_35_0, iter_35_1 in var_1_10003(var_35_2(var_5.GetFormulas(var_35_3))) do
		if var_35_1(iter_35_1) and (not arg_35_0.showOnlyComposite or iter_35_1:IsAvaliable() and var_0_2.IsFormualCanComposite(iter_35_1, arg_35_0.activity)) then
			table = var_8

			var_8.insert(arg_35_0.filterFormulas, iter_35_1)
		end
	end

	local function var_35_4(arg_41_0, arg_41_1)
		local var_41_0 = {
			function(arg_42_0)
				return arg_42_0:IsAvaliable() and 0 or 1
			end,
			function(arg_43_0)
				if arg_43_0:GetType() ~= var_0_2.TYPE.TOOL then
					local var_43_0 = arg_35_0.activity

					if not var_1.IsCompleteAllTools(var_43_0) then
						do return 1 end

						goto label_43_0
					end
				end

				do return 0 end

				::label_43_0::

				return
			end,
			function(arg_44_0)
				return arg_44_0:GetConfigID()
			end
		}

		ipairs = var_3

		for iter_41_0, iter_41_1 in var_3(var_41_0) do
			if iter_41_1(arg_41_0) ~= iter_41_1(arg_41_1) then
				return var_8 < var_9
			end
		end

		return false
	end

	table = var_4

	var_4.sort(arg_35_0.filterFormulas, var_35_4)

	return
end

function var_0_1.UpdateFormulaList(arg_45_0)
	local var_45_0 = #arg_45_0.filterFormulas == 0

	setActive = var_1_10002

	local var_45_1 = arg_45_0.layerFormula

	var_1_10002(var_3.Find(var_45_1, "Frame/Empty"), var_45_0)

	setActive = var_1_10002

	local var_45_2 = arg_45_0.layerFormula

	var_1_10002(var_3.Find(var_45_2, "Frame/ScrollView"), not var_45_0)

	local var_45_3 = arg_45_0.formulaRect

	var_2.SetTotalCount(var_45_3, #arg_45_0.filterFormulas)

	return
end

local var_0_7 = {
	[var_0_2.TYPE.EQUIP] = "ryza_word_equip",
	[var_0_2.TYPE.ITEM] = "word_item",
	[var_0_2.TYPE.TOOL] = "word_tool",
	[var_0_2.TYPE.OTHER] = "word_other"
}

function var_0_1.UpdateFormulaItem(arg_46_0, arg_46_1, arg_46_2)
	tf = var_1_10003

	local var_46_0 = var_1_10003(arg_46_2)
	local var_46_1 = arg_46_0.filterFormulas[arg_46_1]
	local var_46_2 = var_4.GetProduction(var_46_1)

	arg_46_0:UpdateRyzaDrop(var_46_0:Find("BG/Icon"), {
		type = var_46_2[1],
		id = var_46_2[2]
	}, true)

	local var_46_3 = var_0_7[var_4:GetType()]
	local var_46_4, var_46_5

	if var_4:GetType() ~= var_0_2.TYPE.TOOL then
		var_46_4 = arg_46_0.activity
		var_46_5 = not var_7.IsCompleteAllTools(var_46_4)
	else
		var_46_5 = false
	end

	if false then
		var_46_5 = true
	end

	setActive = var_46_4

	var_46_4(var_46_0:Find("Lock"), var_46_5)

	setActive = var_46_4

	var_46_4(var_46_0:Find("BG"), not var_46_5)

	setText = var_46_4

	local var_46_6 = var_46_0
	local var_46_7 = var_46_0.Find(var_46_6, "BG/Type")

	i18n = var_46_6

	var_46_4(var_46_7, var_46_6(var_46_3))

	setScrollText = var_46_4

	var_46_4(var_46_0:Find("BG/Name/Text"), var_4:GetName())

	local var_46_8

	if var_4:GetMaxLimit() > 0 then
		var_46_8 = var_4:GetMaxLimit() - var_4:GetUsedCount() .. "/" .. var_4:GetMaxLimit()
	else
		var_46_8 = "∞"
	end

	local var_46_9 = var_4
	local var_46_10 = var_4.IsAvaliable(var_46_9)

	setActive = var_46_9

	var_46_9(var_46_0:Find("BG/Count"), var_46_10)

	setActive = var_46_9

	var_46_9(var_46_0:Find("Completed"), not var_46_10)

	if var_46_10 then
		var_46_9 = var_0_2.IsFormualCanComposite(var_4, arg_46_0.activity)
		SummerFeastScene = var_11

		local var_46_11 = var_11.TransformColor(var_46_9 and "4fb3a3" or "d55a54")

		setTextColor = var_12
		var_1_10014 = var_46_0

		var_12(var_46_0.Find(var_1_10014, "BG/Count"), var_46_11)
	end

	setText = var_46_9

	var_46_9(var_46_0:Find("BG/Count"), var_46_8)

	onButton = var_46_9

	local var_46_12 = arg_46_0
	local var_46_13 = var_46_0

	local function var_46_14()
		if not var_46_10 then
			pg = var_0

			local var_47_0 = var_0.TipsMgr.GetInstance()
			local var_47_1 = var_0.ShowTips

			i18n = var_2_10002

			var_47_1(var_47_0, var_2_10002("ryza_tip_composite_invalid"))

			return
		end

		if var_46_5 then
			pg = var_0

			local var_47_2 = var_0.TipsMgr.GetInstance()
			local var_47_3 = var_0.ShowTips

			i18n = var_2_10002

			var_47_3(var_47_2, var_2_10002("ryza_tip_unlock_all_tools"))

			return
		end

		local var_47_4 = arg_46_0

		var_0.HideFormulaList(var_47_4)

		local var_47_5 = arg_46_0

		var_0.ShowFormulaDetail(var_47_5, var_0)

		local var_47_6 = arg_46_0

		var_0.DispalyChat(var_47_6, {
			"ryza_atellier2",
			"ryza_atellier3",
			"ryza_atellier4"
		})

		pg = var_0

		local var_47_7 = var_0.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_47_7, "event:/ui/ryza_atellier_ui_1")

		return
	end

	SFX_PANEL = var_1_10014

	var_46_9(var_46_12, var_46_13, var_46_14, var_1_10014)

	return
end

function var_0_1.UpdateRyzaDrop(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	updateDrop = var_1_10004

	var_1_10004(arg_48_1, arg_48_2)

	SetCompomentEnabled = var_1_10004

	local var_48_0 = arg_48_1
	local var_48_1 = arg_48_1.Find(var_48_0, "icon_bg")

	typeof = var_48_0
	Image = var_7

	var_1_10004(var_48_1, var_48_0(var_7), false)

	setActive = var_1_10004

	var_1_10004(arg_48_1:Find("bg"), false)

	setActive = var_1_10004

	var_1_10004(arg_48_1:Find("icon_bg/frame"), false)

	setActive = var_1_10004

	var_1_10004(arg_48_1:Find("icon_bg/stars"), false)

	local var_48_2 = arg_48_2:getConfig("rarity")
	local var_48_3 = arg_48_2.type

	DROP_TYPE_EQUIP = var_6

	if var_48_3 ~= var_6 then
		local var_48_4 = arg_48_2.type

		DROP_TYPE_EQUIPMENT_SKIN = var_6

		if var_48_4 == var_6 then
			var_48_2 = var_48_2 - 1
		end

		local var_48_5 = "icon_frame_" .. var_48_2

		if arg_48_3 then
			var_48_5 = var_48_5 .. "_small"
		end

		local var_48_6 = arg_48_0.loader

		var_6.GetSpriteQuiet(var_48_6, var_0_6, var_48_5, arg_48_1)

		local var_48_7 = arg_48_2.type

		DROP_TYPE_EQUIP = var_48_6

		if var_48_7 ~= var_48_6 then
			var_48_7 = arg_48_2.type
			DROP_TYPE_SPWEAPON = var_48_6

			if var_48_7 == var_48_6 then
				onButton = var_48_7

				local var_48_8 = arg_48_0
				local var_48_9 = arg_48_1

				local function var_48_10()
					local var_49_0 = arg_48_0

					var_0.emit(var_49_0, var_0_1.ON_DROP, arg_48_2)

					return
				end

				SFX_PANEL = var_10

				var_48_7(var_48_8, var_48_9, var_48_10, var_10)
			else
				removeOnButton = var_48_7

				var_48_7(arg_48_1)
			end

			return
		end
	end
end

local var_0_8 = {
	[var_0_3.TYPE.BASE] = "circle",
	[var_0_3.TYPE.NORMAL] = "hexagon",
	[var_0_3.TYPE.SAIREN] = "doubleHexagon",
	[var_0_3.TYPE.ANY] = "anyHexagon"
}

function var_0_1.ShowFormulaDetail(arg_50_0, arg_50_1)
	setActive = var_1_10002

	var_1_10002(arg_50_0.layerFormulaDetail, true)

	setParent = var_1_10002

	var_1_10002(arg_50_0.layerFormulaOverlay, arg_50_0.top)

	local var_50_0 = arg_50_0.layerFormulaOverlay

	var_2.SetSiblingIndex(var_50_0, 0)

	setParent = var_2

	var_2(arg_50_0.painting, arg_50_0.layerFormulaOverlay)

	local var_50_1 = arg_50_0.painting

	var_2.SetSiblingIndex(var_50_1, 0)

	if not arg_50_0.nodePools then
		local var_50_2 = {}
		local var_50_3 = var_0_4.New
		local var_50_4 = arg_50_0.layerFormulaDetail

		var_50_2.circle = var_50_3(var_4.Find(var_50_4, "CircleNode").gameObject, 100)

		local var_50_5 = var_0_4.New
		local var_50_6 = arg_50_0.layerFormulaDetail

		var_50_2.hexagon = var_50_5(var_4.Find(var_50_6, "HexagonNode").gameObject, 100)

		local var_50_7 = var_0_4.New
		local var_50_8 = arg_50_0.layerFormulaDetail

		var_50_2.anyHexagon = var_50_7(var_4.Find(var_50_8, "AnyHexagonNode").gameObject, 100)

		local var_50_9 = var_0_4.New
		local var_50_10 = arg_50_0.layerFormulaDetail

		var_50_2.doubleHexagon = var_50_9(var_4.Find(var_50_10, "DoubleHexagonNode").gameObject, 100)
		arg_50_0.nodePools = var_50_2
		table = var_50_2

		var_50_2.Foreach(arg_50_0.nodePools, function(arg_51_0, arg_51_1)
			setActive = var_2_10002

			var_2_10002(arg_51_1.prefab, false)

			return
		end)
	end

	local var_50_11

	if not arg_50_0.pluralRoot then
		pg = var_50_11
		var_50_11 = var_50_11.PoolMgr.GetInstance().root
	end

	arg_50_0.pluralRoot = var_50_11

	local var_50_12

	if not arg_50_0.nodeList then
		var_50_12 = {}
	end

	arg_50_0.nodeList = var_50_12
	_ = var_50_12

	var_50_12.each(arg_50_0.nodeList, function(arg_52_0)
		local var_52_0 = arg_50_0.nodePools
		local var_52_1 = var_0_8
		local var_52_2 = arg_52_0.Data
		local var_52_3 = var_52_0[var_52_1[var_3.GetType(var_52_2)]]

		tf = var_2

		local var_52_4 = var_2(arg_52_0.GO)

		SetCompomentEnabled = var_3

		local var_52_5 = var_52_4
		local var_52_6 = var_52_4.Find(var_52_5, "Item")

		typeof = var_52_5
		Image = var_6

		var_3(var_52_6, var_52_5(var_6), false)

		local var_52_7 = arg_50_0.loader

		var_3.ClearRequest(var_52_7, var_52_4:Find("Ring"))

		table = var_3

		var_3.Foreach(arg_52_0.links, function(arg_53_0)
			local var_53_0 = var_52_4
			local var_53_1 = var_1.Find(var_53_0, "Links/" .. arg_53_0)
			local var_53_2 = arg_50_0.loader

			var_2.ClearRequest(var_53_2, var_53_1)

			return
		end)

		local var_52_8 = arg_50_0.loader

		var_3.ClearRequest(var_52_8, var_52_4)

		local var_52_9 = var_52_3
		local var_52_10 = var_52_3.Enqueue

		go = var_5

		if not var_52_10(var_52_9, var_5(arg_52_0.GO)) then
			setParent = var_52_9
			go = var_5

			var_52_9(var_5(arg_52_0.GO), arg_50_0.pluralRoot)

			setActive = var_52_9
			go = var_5

			var_52_9(var_5(arg_52_0.GO), false)
		end

		return
	end)

	table = var_2

	var_2.clean(arg_50_0.nodeList)
	arg_50_0:InitFormula(arg_50_1)

	return
end

function var_0_1.HideFormulaDetail(arg_54_0)
	isActive = var_1_10001

	if not var_1_10001(arg_54_0.layerFormulaDetail) then
		return
	end

	arg_54_0:HideCandicatePanel()

	setParent = var_1

	var_1(arg_54_0.painting, arg_54_0._tf)

	local var_54_0 = arg_54_0.painting

	var_1.SetSiblingIndex(var_54_0, 1)

	setParent = var_1

	var_1(arg_54_0.layerFormulaOverlay, arg_54_0.layerFormulaDetail)

	setActive = var_1

	var_1(arg_54_0.layerFormulaDetail, false)

	return true
end

local var_0_9 = {
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
local var_0_10 = {
	[var_0_2.TYPE.EQUIP] = "text_equip",
	[var_0_2.TYPE.ITEM] = "text_item",
	[var_0_2.TYPE.TOOL] = "text_other",
	[var_0_2.TYPE.OTHER] = "text_other"
}

function var_0_1.InitFormula(arg_55_0, arg_55_1)
	arg_55_0.contextData.formulaId = arg_55_1:GetConfigID()

	local var_55_0 = arg_55_0.layerFormulaOverlay
	local var_55_1 = var_2.Find(var_55_0, "Description")
	local var_55_2 = arg_55_0.loader

	var_3.GetSpriteQuiet(var_55_2, var_0_5, var_0_10[arg_55_1:GetType()], var_55_1:Find("Type"))

	local var_55_3 = {
		type = arg_55_1:GetProduction()[1],
		id = arg_55_1:GetProduction()[2]
	}

	arg_55_0:UpdateRyzaDrop(var_55_1:Find("Icon"), var_55_3)

	setText = var_4

	var_4(var_55_1:Find("Name"), arg_55_1:GetName())

	setText = var_4

	var_4(var_55_1:Find("Description/Text"), arg_55_1:GetDesc())

	tostring = var_4

	local var_55_4 = var_4(arg_55_1:GetMaxLimit() - arg_55_1:GetUsedCount())

	if arg_55_1:GetMaxLimit() < 0 then
		var_55_4 = "∞"
	end

	setText = var_5

	local var_55_5 = var_55_1
	local var_55_6 = var_55_1.Find(var_55_5, "RestCount/Text")

	i18n = var_55_5

	var_5(var_55_6, var_55_5("ryza_rest_produce_count", var_55_4))

	setActive = var_5

	var_5(arg_55_0.layerMaterialSelect, false)

	local var_55_7 = arg_55_0.layerFormulaDetail
	local var_55_8 = var_5.Find(var_55_7, "ScrollView/Content")

	setAnchoredPosition = var_55_7

	local var_55_9 = var_55_8

	Vector2 = var_8

	var_55_7(var_55_9, var_8.zero)

	_ = var_55_7

	var_55_7.each(arg_55_1:GetCircleList(), function(arg_56_0)
		local var_56_0 = var_0_3.New({
			configId = arg_56_0
		})
		local var_56_1 = arg_55_0.nodePools[var_0_8[var_56_0:GetType()]]
		local var_56_2 = var_2.Dequeue(var_56_1)

		var_56_2.name = arg_56_0
		setActive = var_56_1

		var_56_1(var_56_2, true)

		setParent = var_56_1
		tf = var_4

		var_56_1(var_4(var_56_2), var_55_8)

		local var_56_3 = {
			Change = true,
			Data = var_56_0,
			GO = var_56_2
		}

		table = var_4

		var_4.insert(arg_55_0.nodeList, var_56_3)

		return
	end)

	local var_55_10 = 280

	math = var_7

	local var_55_11 = var_7.deg2Rad * 30

	Vector2 = var_8

	local var_55_12 = var_8.New

	math = var_9

	local var_55_13 = var_9.cos(var_55_11)

	math = var_10

	local var_55_14 = var_55_10 * var_55_12(var_55_13, var_10.sin(var_55_11))

	Vector2 = var_55_13

	local var_55_15 = var_55_10 * var_55_13(0, 1)

	Vector2 = var_10

	local var_55_16 = var_10.zero

	local function var_55_17(arg_57_0, arg_57_1)
		setAnchoredPosition = var_2_10002

		var_2_10002(arg_57_0.GO, arg_57_1)

		local var_57_0 = arg_57_0.Data
		local var_57_1 = var_2.GetNeighbors(var_57_0)

		arg_57_0.links = {}
		_ = var_3

		var_3.each(var_57_1, function(arg_58_0)
			local var_58_0 = arg_58_0[1]
			local var_58_1 = arg_58_0[2]
			local var_58_2 = var_0_9[var_58_0][1] * var_55_14 + var_3[2] * var_55_15

			_ = var_5

			local var_58_3 = var_5.detect(arg_55_0.nodeList, function(arg_59_0)
				local var_59_0 = arg_59_0.Data

				return var_1.GetConfigID(var_59_0) == var_58_1
			end)

			var_58_3.prevLink = {
				(var_58_0 + 2) % 5 + 1,
				arg_57_0
			}
			arg_57_0.links[var_58_0] = var_58_3

			local var_58_4 = arg_57_1 + var_58_2

			var_0(var_58_3, var_58_4)

			Vector2 = var_7
			var_55_16 = var_7.Max(var_55_16, -var_58_4)
			Vector2 = var_7
			var_55_16 = var_7.Max(var_55_16, var_58_4)

			return
		end)

		return
	end

	local var_55_18 = arg_55_0.nodeList[1]

	Vector2 = var_1_10014

	var_55_17(var_55_18, var_1_10014.zero)

	setSizeDelta = var_55_17

	local var_55_19 = var_55_8

	Vector2 = var_14

	var_55_17(var_55_19, (var_55_16 + var_14.New(var_55_10, var_55_10)) * 2)

	onButton = var_55_17

	local var_55_20 = arg_55_0
	local var_55_21 = arg_55_0.layerFormulaDetail
	local var_55_22 = var_14.Find(var_55_21, "Composite")

	local function var_55_23()
		_ = var_2_10000

		if not var_2_10000.all(arg_55_0.nodeList, function(arg_61_0)
			return arg_61_0.Instance
		end) then
			local var_60_0 = arg_55_0

			var_1.ShowMaterialsPreview(var_60_0)

			return
		end

		local var_60_1 = arg_55_0.activity
		local var_60_2 = var_1.GetFormulas(var_60_1)[arg_55_0.contextData.formulaId]

		if not var_1.IsAvaliable(var_60_2) then
			pg = var_2

			local var_60_3 = var_2.TipsMgr.GetInstance()
			local var_60_4 = var_2.ShowTips

			i18n = var_2_10004

			var_60_4(var_60_3, var_2_10004("ryza_tip_composite_invalid"))

			return
		end

		local var_60_5 = arg_55_0

		var_2.ShowCompositeConfirmWindow(var_60_5)

		return
	end

	SFX_PANEL = var_16

	var_55_17(var_55_20, var_55_22, var_55_23, var_16)

	onButton = var_55_17

	local var_55_24 = arg_55_0
	local var_55_25 = arg_55_0.layerFormulaDetail
	local var_55_26 = var_14.Find(var_55_25, "AutoFill")

	local function var_55_27()
		local var_62_0 = {}
		local var_62_1 = arg_55_0.activity
		local var_62_2 = var_1.GetItems(var_62_1)

		local function var_62_3(arg_63_0)
			local var_63_0

			if not var_62_0[arg_63_0:GetConfigID()] then
				Clone = var_63_0
				var_63_0 = var_63_0(var_62_2[arg_63_0:GetConfigID()])
			end

			assert = var_2

			var_2(var_63_0, "Using Unexist material")

			var_63_0.count = var_63_0.count - 1
			var_62_0[arg_63_0:GetConfigID()] = var_63_0

			return
		end

		local var_62_4 = {}

		_ = var_2_10004

		var_2_10004.each(arg_55_0.nodeList, function(arg_64_0)
			if arg_64_0.Instance then
				var_62_3(arg_64_0.Instance)
			else
				table = var_1

				var_1.insert(var_62_4, arg_64_0)
			end

			return
		end)

		if #var_62_4 <= 0 then
			return
		end

		local var_62_5 = true

		local function var_62_6()
			if not var_62_5 then
				return
			end

			local var_65_0 = arg_55_0

			var_0.DispalyChat(var_65_0, {
				"ryza_atellier5",
				"ryza_atellier6",
				"ryza_atellier7"
			})

			var_62_5 = false

			return
		end

		local var_62_7 = false
		local var_62_8

		local function var_62_9()
			if var_62_8 then
				coroutine = var_0

				if var_0.status(var_62_8) == "suspended" then
					coroutine = var_0

					local var_66_0, var_66_1 = var_0.resume(var_62_8)

					assert = var_3_10002

					local var_66_2 = var_66_0

					debug = var_3_10004

					var_3_10002(var_66_2, var_3_10004.traceback(var_62_8, var_66_1))
				end
			end

			return
		end

		coroutine = var_2_10009
		var_62_8 = var_2_10009.create(function()
			_ = var_3_10000

			var_3_10000.each(var_62_4, function(arg_68_0)
				local var_68_0 = arg_68_0.Data

				if var_1.GetType(var_68_0) == var_0_3.TYPE.BASE or var_1:GetType() == var_0_3.TYPE.SAIREN then
					local var_68_1 = var_1:GetLimitItemID()
					local var_68_2

					if not var_62_0[var_68_1] then
						var_68_2 = var_62_2[var_68_1]
					end

					if var_68_2 and var_68_2.count > 0 then
						var_62_3(var_68_2)
						var_62_6()

						local var_68_3 = arg_55_0
						local var_68_4 = var_4.FillNodeAndPlayAnim
						local var_68_5 = arg_68_0

						AtelierMaterial = var_4_10007

						var_68_4(var_68_3, var_68_5, var_4_10007.New({
							count = 1,
							configId = var_68_1
						}), var_62_9, true)

						coroutine = var_68_4

						var_68_4.yield()
					else
						var_62_7 = true
					end
				end

				return
			end)

			local var_67_3

			if not var_62_7 then
				local var_67_0 = false
				local var_67_1 = false
				local var_67_2 = arg_55_0

				var_67_3.DisPlayUnlockEffect(var_67_2, function()
					var_67_0 = true

					if var_67_1 then
						var_62_9()
					end

					return
				end)

				if not var_67_0 then
					var_67_1 = true
					coroutine = var_67_3

					var_67_3.yield()
				end

				var_67_3 = true

				local function var_67_4()
					if not var_67_3 then
						return
					end

					pg = var_0

					local var_70_0 = var_0.CriMgr.GetInstance()

					var_0.PlaySoundEffect_V3(var_70_0, "event:/ui/ryza_atellier_ui_5")

					var_67_3 = false

					return
				end

				AtelierMaterial = var_4

				local var_67_5 = var_4.bindConfigTable()

				local function var_67_6(arg_71_0)
					local var_71_0 = arg_71_0.Data

					ipairs = var_4_10002

					for iter_71_0, iter_71_1 in var_4_10002(var_67_5.all) do
						local var_71_1

						if not var_62_0[iter_71_1] then
							var_71_1 = var_62_2[iter_71_1]
						end

						if var_71_1 and var_71_1.count > 0 and var_71_1:IsNormal() and var_71_0:CanUseMaterial(var_71_1, arg_55_1) then
							var_62_3(var_71_1)
							var_62_6()
							var_67_4()

							local var_71_2 = arg_55_0
							local var_71_3 = var_8.FillNodeAndPlayAnim
							local var_71_4 = arg_71_0

							AtelierMaterial = var_11

							var_71_3(var_71_2, var_71_4, var_11.New({
								count = 1,
								configId = var_71_1:GetConfigID()
							}), true)

							return
						end
					end

					var_62_7 = true

					return
				end

				_ = var_3_10006

				var_3_10006.each(var_62_4, function(arg_72_0)
					local var_72_0 = arg_72_0.Data

					if var_1.GetType(var_72_0) == var_0_3.TYPE.NORMAL then
						var_67_6(arg_72_0)
					end

					return
				end)

				_ = var_6

				var_6.each(var_62_4, function(arg_73_0)
					local var_73_0 = arg_73_0.Data

					if var_1.GetType(var_73_0) == var_0_3.TYPE.ANY then
						var_67_6(arg_73_0)
					end

					return
				end)
			end

			if var_62_7 then
				pg = var_0

				local var_67_7 = var_0.TipsMgr.GetInstance()
				local var_67_8 = var_0.ShowTips

				i18n = var_67_3

				var_67_8(var_67_7, var_67_3("ryza_material_not_enough"))
			end

			local var_67_9 = arg_55_0

			var_0.UpdateFormulaDetail(var_67_9)

			return
		end)

		var_62_9()

		return
	end

	SFX_PANEL = var_16

	var_55_17(var_55_24, var_55_26, var_55_27, var_16)
	arg_55_0:UpdateFormulaDetail()

	return
end

function var_0_1.CleanNodeInstance(arg_74_0)
	local var_74_0 = arg_74_0.activity
	local var_74_1 = var_1.GetFormulas(var_74_0)[arg_74_0.contextData.formulaId]

	if not var_1.IsAvaliable(var_74_1) then
		arg_74_0:HideFormulaDetail()

		var_74_1 = arg_74_0.contextData
		var_74_1.formulaId = nil

		arg_74_0:ShowFormulaList()

		return
	end

	_ = var_74_1

	var_74_1.each(arg_74_0.nodeList, function(arg_75_0)
		arg_75_0.Instance = nil
		arg_75_0.Change = true

		return
	end)
	arg_74_0:ShowFormulaDetail(var_1)

	return
end

function var_0_1.UpdateFormulaDetail(arg_76_0)
	local var_76_0 = 0
	local var_76_1 = 0

	tobool = var_1_10003

	local var_76_2 = var_1_10003(arg_76_0.unlockAllBase)

	arg_76_0.unlockAllBase = true
	_ = var_4

	var_4.each(arg_76_0.nodeList, function(arg_77_0)
		var_76_0 = var_76_0 + 1
		var_76_1 = var_76_1 + (arg_77_0.Instance and 1 or 0)

		local var_77_0 = arg_76_0

		if arg_76_0.unlockAllBase then
			local var_77_1 = arg_77_0.Data

			if var_2.GetType(var_77_1) ~= var_0_3.TYPE.BASE then
				local var_77_2 = arg_77_0.Data
				local var_77_3

				if var_2.GetType(var_77_2) == var_0_3.TYPE.SAIREN then
					var_77_3 = arg_77_0.Instance

					if false then
						var_77_3 = false
					end
				else
					var_77_3 = true
				end

				var_77_0.unlockAllBase = var_77_3

				return
			end
		end
	end)

	_ = var_4

	var_4.each(arg_76_0.nodeList, function(arg_78_0)
		if not arg_76_0.unlockAllBase then
			local var_78_0 = arg_78_0.Data

			if var_1.GetType(var_78_0) ~= var_0_3.TYPE.BASE then
				local var_78_1 = arg_78_0.Data
				local var_78_2

				if var_1.GetType(var_78_1) == var_0_3.TYPE.SAIREN then
					var_78_2 = false
				else
					var_78_2 = true
				end

				local var_78_3

				if not arg_78_0.ChangeLock then
					tobool = var_78_3

					if var_78_3(arg_78_0.Lock) then
						var_78_3 = not var_78_2
					end
				end

				arg_78_0.ChangeLock = var_78_3
				arg_78_0.Lock = var_78_2

				return
			end
		end
	end)

	local var_76_3 = arg_76_0.unlockAllBase ~= var_76_2

	_ = var_5

	var_5.each(arg_76_0.nodeList, function(arg_79_0)
		if var_76_3 then
			arg_79_0.Change = true
		end

		local var_79_0 = arg_76_0

		var_1.UpdateNodeView(var_79_0, arg_79_0)

		return
	end)

	setText = var_5

	local var_76_4 = arg_76_0.layerFormulaDetail
	local var_76_5 = var_6.Find(var_76_4, "Bar/Text")

	i18n = var_76_4

	var_5(var_76_5, var_76_4("ryza_tip_put_materials", var_76_1, var_76_0))

	setGray = var_5

	local var_76_6 = arg_76_0.layerFormulaDetail
	local var_76_7 = var_6.Find(var_76_6, "AutoFill")
	local var_76_8 = arg_76_0.activity
	local var_76_9 = var_7.GetFormulas(var_76_8)[arg_76_0.contextData.formulaId]

	var_5(var_76_7, not var_7.IsAvaliable(var_76_9))

	setActive = var_5

	local var_76_10 = arg_76_0.layerFormulaDetail

	var_5(var_6.Find(var_76_10, "Composite/Disabled"), var_76_1 < var_76_0)

	return
end

local var_0_11 = {
	[var_0_3.ELEMENT_TYPE.PYRO] = "laisha_ui_huo",
	[var_0_3.ELEMENT_TYPE.CRYO] = "laisha_ui_bing",
	[var_0_3.ELEMENT_TYPE.ELECTRO] = "laisha_ui_lei",
	[var_0_3.ELEMENT_TYPE.ANEMO] = "laisha_ui_feng",
	[var_0_3.ELEMENT_TYPE.SAIREN] = "laisha_ui_sairen"
}
local var_0_12 = "laisha_ui_wupinshanguang"
local var_0_13 = "laisha_ui_jiesuo"
local var_0_14 = {
	"laisha_ui_lianjie01",
	"laisha_ui_lianjie02",
	"laisha_ui_lianjie_qiehuan"
}

function var_0_1.UpdateNodeView(arg_80_0, arg_80_1)
	tf = var_1_10002

	local var_80_0 = var_1_10002(arg_80_1.GO)

	for iter_80_0 = 1, 6 do
		setActive = var_1_10007

		local var_80_1 = var_80_0:Find("Links")

		var_1_10007(var_8.GetChild(var_80_1, iter_80_0 - 1), false)
	end

	local var_80_2 = arg_80_1.Data

	_ = var_4

	var_4.each(var_80_2:GetNeighbors(), function(arg_81_0)
		setActive = var_2_10001

		local var_81_0 = var_80_0
		local var_81_1 = var_2.Find(var_81_0, "Links")

		var_2_10001(var_2.GetChild(var_81_1, arg_81_0[1] - 1), true)

		return
	end)

	local var_80_3 = var_80_2:GetElementName()
	local var_80_4 = arg_80_1.Lock

	setActive = var_6

	var_6(var_80_0:Find("Lock"), var_80_4)

	if var_80_4 then
		if var_80_2:GetType() ~= var_0_3.TYPE.ANY then
			local var_80_5 = arg_80_0.loader

			var_6.GetSpriteQuiet(var_80_5, var_0_6, "element_" .. var_80_3, var_80_0:Find("Lock/Require/Icon"))
		end

		setText = var_6

		var_6(var_80_0:Find("Lock/Require/Text"), "X" .. var_80_2:GetLevel())
	end

	for iter_80_1 = 3, var_80_2:GetLevel() + 1, -1 do
		local var_80_6 = var_80_0:Find("Slots")
		local var_80_7 = var_10.GetChild(var_80_6, iter_80_1 - 1)
		local var_80_8 = arg_80_0.loader

		var_11.GetSpriteQuiet(var_80_8, var_0_5, "slot_BLOCKED", var_80_7:Find("Image"))
	end

	if not arg_80_1.Instance then
		if var_80_2:GetType() == var_0_3.TYPE.ANY then
			setActive = var_7

			var_7(var_80_0:Find("All"), true)
		else
			setActive = var_7

			var_7(var_80_0:Find("Icon"), true)

			local var_80_9 = arg_80_0.loader

			var_7.GetSpriteQuiet(var_80_9, var_0_5, "icon_" .. var_80_3, var_80_0:Find("Icon"), true)
		end

		setActive = var_7

		var_7(var_80_0:Find("Item"), false)

		local var_80_10

		if var_80_2:GetType() == var_0_3.TYPE.BASE or var_80_2:GetType() == var_0_3.TYPE.SAIREN then
			AtelierMaterial = var_80_10
			var_80_10 = var_80_10.New({
				configId = var_80_2:GetLimitItemID()
			})
			setActive = var_8

			var_8(var_80_0:Find("Name"), true)

			setScrollText = var_8

			var_8(var_80_0:Find("Name/Rect/Text"), var_80_10:GetName())
		else
			setActive = var_80_10

			var_80_10(var_80_0:Find("Name"), false)
		end

		for iter_80_2 = 1, var_80_2:GetLevel() do
			local var_80_11 = var_80_0:Find("Slots")
			local var_80_12 = var_11.GetChild(var_80_11, iter_80_2 - 1)
			local var_80_13 = arg_80_0.loader

			var_12.GetSpriteQuiet(var_80_13, var_0_5, "slot_NULL", var_80_12:Find("Image"))
		end
	else
		local var_80_14 = var_80_2:GetRingElement(var_6)
		local var_80_15 = var_0_3.ELEMENT_NAME[var_80_14]

		if var_80_2:GetType() == var_0_3.TYPE.ANY then
			setActive = var_9

			var_9(var_80_0:Find("All"), false)
		else
			setActive = var_9

			var_9(var_80_0:Find("Icon"), false)
		end

		setActive = var_9

		var_9(var_80_0:Find("Item"), true)

		local var_80_16

		if var_80_2:GetType() == var_0_3.TYPE.BASE or var_80_2:GetType() == var_0_3.TYPE.SAIREN then
			var_80_16 = var_6:GetBaseCircleTransform()
		else
			var_80_16 = var_6:GetNormalCircleTransform()
		end

		setLocalScale = var_10

		local var_80_17 = var_80_0
		local var_80_18 = var_80_0.Find(var_80_17, "Item")

		Vector3 = var_80_17

		local var_80_19 = var_80_17.New

		unpack = var_13

		var_10(var_80_18, var_80_19(var_13(var_80_16, 1, 3)))

		setAnchoredPosition = var_10

		local var_80_20 = var_80_0
		local var_80_21 = var_80_0.Find(var_80_20, "Item")

		Vector2 = var_80_20

		local var_80_22 = var_80_20.New

		unpack = var_13

		var_10(var_80_21, var_80_22(var_13(var_80_16, 4, 5)))

		local var_80_23 = arg_80_0.loader

		var_10.GetSpriteQuiet(var_80_23, var_6:GetIconPath(), "", var_80_0:Find("Item"), true)

		setActive = var_10

		var_10(var_80_0:Find("Name"), true)

		setScrollText = var_10

		var_10(var_80_0:Find("Name/Rect/Text"), var_6:GetName())

		for iter_80_3 = 1, var_80_2:GetLevel() do
			local var_80_24 = var_80_0:Find("Slots")
			local var_80_25 = var_14.GetChild(var_80_24, iter_80_3 - 1)
			local var_80_26 = arg_80_0.loader

			var_15.GetSpriteQuiet(var_80_26, var_0_5, "slot_" .. var_80_15, var_80_25:Find("Image"))
		end
	end

	local var_80_27 = var_80_0
	local var_80_28 = var_80_0.Find(var_80_27, "Ring")

	setImageColor = var_80_27

	var_80_27(var_80_28, var_80_2:GetElementRingColor(var_6))

	if arg_80_1.Change then
		local var_80_29 = arg_80_1.Data
		local var_80_30 = var_8.GetRingElement(var_80_29, var_6)

		if var_80_4 then
			var_80_30 = nil
		end

		local var_80_32

		if var_0_11[var_80_30] then
			local var_80_31 = arg_80_1.Data

			var_80_32 = var_80_32.GetType(var_80_31) == var_0_3.TYPE.BASE and "_o" or "_6"

			local var_80_33 = arg_80_0.loader

			var_10.GetPrefab(var_80_33, "ui/" .. var_0_11[var_80_30] .. var_80_32, "", function(arg_82_0)
				setParent = var_2_10001

				var_2_10001(arg_82_0, var_80_28)

				setAnchoredPosition = var_2_10001

				local var_82_0 = arg_82_0

				Vector2 = var_3

				var_2_10001(var_82_0, var_3.zero)

				return
			end, var_80_28)
		else
			local var_80_34 = arg_80_0.loader

			var_80_32.ClearRequest(var_80_34, var_80_28)
		end

		table = var_80_32

		var_80_32.Foreach(arg_80_1.links, function(arg_83_0, arg_83_1)
			local var_83_0 = var_80_0
			local var_83_1 = var_2.Find(var_83_0, "Links/" .. arg_83_0)
			local var_83_2 = var_0_14[3]

			if arg_83_1.Lock and var_80_4 then
				var_83_2 = var_0_14[1]
			elseif not arg_83_1.Lock and not var_80_4 then
				var_83_2 = var_0_14[2]
			end

			local var_83_3 = arg_80_0.loader

			var_4.GetPrefab(var_83_3, "ui/" .. var_83_2, "", function(arg_84_0)
				setParent = var_3_10001

				local var_84_0 = arg_84_0
				local var_84_1 = var_83_1

				var_3_10001(var_84_0, var_3.Find(var_84_1, "Link"))

				setAnchoredPosition = var_3_10001

				local var_84_2 = arg_84_0

				Vector2 = var_3

				var_3_10001(var_84_2, var_3.New(0, -15))

				return
			end, var_83_1)

			return
		end)

		arg_80_1.Change = nil
	end

	local var_80_35

	if arg_80_1.ChangeInstance then
		var_80_35 = var_80_0:Find("Item")

		if var_6 then
			local var_80_36 = arg_80_0.loader

			var_9.GetPrefab(var_80_36, "ui/" .. var_0_12, "", function(arg_85_0)
				setParent = var_2_10001

				var_2_10001(arg_85_0, var_80_35)

				setAnchoredPosition = var_2_10001

				local var_85_0 = arg_85_0

				Vector2 = var_3

				var_2_10001(var_85_0, var_3.zero)

				return
			end, var_80_0)
		else
			local var_80_37 = arg_80_0.loader

			var_9.ClearRequest(var_80_37, var_80_0)
		end

		arg_80_1.ChangeInstance = nil
	end

	onButton = var_80_35

	local var_80_38 = arg_80_0
	local var_80_39 = var_80_0

	local function var_80_40()
		if var_80_4 then
			return
		end

		local var_86_0 = arg_80_0.layerMaterialSelect
		local var_86_1 = var_0.Find(var_86_0, "TargetBG")

		Quaternion = var_86_0
		var_86_1.localRotation = var_86_0.identity

		local var_86_2 = var_80_2
		local var_86_3 = var_1.GetType(var_86_2) == var_0_3.TYPE.BASE and 300 or 245

		setSizeDelta = var_2

		var_2(var_86_1, {
			x = var_86_3,
			y = var_86_3
		})

		local var_86_4 = arg_80_0.layerMaterialSelect
		local var_86_5 = var_2.Find(var_86_4, "Target")
		local var_86_6 = arg_80_0

		var_3.ShowCandicatePanel(var_86_6)

		tf = var_3
		Instantiate = var_86_6

		local var_86_7 = var_3(var_86_6(var_80_0))

		SetCompomentEnabled = var_4

		local var_86_8 = var_86_7

		typeof = var_2_10006
		Button = var_2_10007

		var_4(var_86_8, var_2_10006(var_2_10007), false)

		setParent = var_4

		var_4(var_86_7, var_86_5)

		setAnchoredPosition = var_4

		local var_86_9 = var_86_7

		Vector2 = var_6

		var_4(var_86_9, var_6.zero)

		for iter_86_0 = 1, 6 do
			setActive = var_2_10008
			var_2_10010 = var_86_7
			var_2_10010 = var_86_7.Find(var_2_10010, "Links")

			var_2_10008(var_9.GetChild(var_2_10010, iter_86_0 - 1), false)
		end

		local var_86_10 = var_86_5.anchoredPosition
		local var_86_11 = arg_80_0.layerFormulaDetail
		local var_86_12 = var_5.Find(var_86_11, "ScrollView/Content")
		local var_86_13 = var_80_0.anchoredPosition
		local var_86_14 = arg_80_0.layerFormulaDetail
		local var_86_15 = var_86_13 + var_7.Find(var_86_14, "ScrollView").anchoredPosition

		setAnchoredPosition = var_7

		var_7(var_86_12, var_86_10 - var_86_15)

		local var_86_16 = arg_80_0

		var_86_16.candicateTarget = arg_80_1
		GetComponent = var_86_16

		local var_86_17 = var_86_1

		typeof = var_9
		Animator = var_2_10010

		local var_86_18 = var_86_16(var_86_17, var_9(var_2_10010))

		var_7.SetBool(var_86_18, "Selecting", true)

		local var_86_19 = arg_80_0

		var_8.UpdateCandicatePanel(var_86_19)

		return
	end

	SFX_PANEL = var_12

	var_80_35(var_80_38, var_80_39, var_80_40, var_12)

	return
end

function var_0_1.FillNodeAndPlayAnim(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4)
	arg_87_0:LoadingOn()

	local var_87_0

	if not arg_87_1.ChangeInstance then
		tobool = var_87_0
		var_87_0 = var_87_0(arg_87_1.Instance)
		tobool = var_6
		var_87_0 = var_87_0 ~= var_6(arg_87_2)
	end

	arg_87_1.ChangeInstance = var_87_0
	arg_87_1.Instance = arg_87_2
	arg_87_1.Change = true

	local var_87_1 = {}
	local var_87_2 = {}

	seriesAsync = var_1_10007

	var_1_10007({
		function(arg_88_0)
			table = var_2_10001

			var_2_10001.ParallelIpairsAsync({
				"ui/laisha_ui_wupinzhiru",
				"ui/laisha_ui_baoshi"
			}, function(arg_89_0, arg_89_1, arg_89_2)
				local var_89_0 = var_87_1
				local var_89_1 = arg_87_0.loader

				var_89_0[arg_89_0] = var_4.GetPrefab(var_89_1, arg_89_1, "", function(arg_90_0)
					setParent = var_4_10001

					local var_90_0 = arg_90_0

					tf = var_4_10003

					var_4_10001(var_90_0, var_4_10003(arg_87_1.GO))

					setAnchoredPosition = var_4_10001

					local var_90_1 = arg_90_0

					Vector2 = var_3

					var_4_10001(var_90_1, var_3.zero)

					local var_90_2 = var_87_2

					var_90_2[arg_89_0] = arg_90_0
					setActive = var_90_2

					var_90_2(arg_90_0, false)
					arg_89_2()

					return
				end)

				return
			end, arg_88_0)

			return
		end,
		function(arg_91_0)
			setActive = var_2_10001

			var_2_10001(var_87_2[1], true)

			local var_91_0 = arg_87_0
			local var_91_1 = var_1.managedTween

			LeanTween = var_3

			var_91_1(var_91_0, var_3.delayedCall, function()
				if not arg_87_4 then
					local var_92_0 = arg_87_0

					var_0.UpdateFormulaDetail(var_92_0)
				else
					local var_92_1 = arg_87_0

					var_0.UpdateNodeView(var_92_1, arg_87_1)
				end

				pg = var_0

				local var_92_2 = var_0.CriMgr.GetInstance()

				var_0.PlaySoundEffect_V3(var_92_2, "event:/ui/ryza_atellier_ui_4")
				arg_91_0()

				return
			end, 0.2, nil)

			return
		end,
		function(arg_93_0)
			setActive = var_2_10001

			var_2_10001(var_87_2[2], true)

			local var_93_0 = arg_87_0
			local var_93_1 = var_1.managedTween

			LeanTween = var_3

			var_93_1(var_93_0, var_3.delayedCall, function()
				arg_93_0()

				return
			end, 0.5, nil)

			return
		end,
		function(arg_95_0)
			local var_95_0 = arg_87_0.loader

			var_1.ClearRequest(var_95_0, var_87_1[1])

			local var_95_1 = arg_87_0.loader

			var_1.ClearRequest(var_95_1, var_87_1[2])

			local var_95_2 = arg_87_0

			var_1.LoadingOff(var_95_2)

			existCall = var_1

			var_1(arg_87_3)

			return
		end
	})

	return
end

function var_0_1.DisPlayUnlockEffect(arg_96_0, arg_96_1)
	arg_96_0.unlockAllBase = true
	_ = var_2

	var_2.each(arg_96_0.nodeList, function(arg_97_0)
		local var_97_0 = arg_96_0

		if arg_96_0.unlockAllBase then
			local var_97_1 = arg_97_0.Data

			if var_2.GetType(var_97_1) ~= var_0_3.TYPE.BASE then
				local var_97_2 = arg_97_0.Data
				local var_97_3

				if var_2.GetType(var_97_2) == var_0_3.TYPE.SAIREN then
					var_97_3 = arg_97_0.Instance

					if false then
						var_97_3 = false
					end
				else
					var_97_3 = true
				end

				var_97_0.unlockAllBase = var_97_3

				return
			end
		end
	end)

	_ = var_2

	var_2.each(arg_96_0.nodeList, function(arg_98_0)
		if not arg_96_0.unlockAllBase then
			local var_98_0 = arg_98_0.Data

			if var_1.GetType(var_98_0) ~= var_0_3.TYPE.BASE then
				local var_98_1 = arg_98_0.Data
				local var_98_2

				if var_1.GetType(var_98_1) == var_0_3.TYPE.SAIREN then
					var_98_2 = false
				else
					var_98_2 = true
				end

				local var_98_3

				if not arg_98_0.ChangeLock then
					tobool = var_98_3

					if var_98_3(arg_98_0.Lock) then
						var_98_3 = not var_98_2
					end
				end

				arg_98_0.ChangeLock = var_98_3
				arg_98_0.Lock = var_98_2

				return
			end
		end
	end)

	_ = var_2

	if not var_2.any(arg_96_0.nodeList, function(arg_99_0)
		return arg_99_0.ChangeLock
	end) then
		existCall = var_2

		var_2(arg_96_1)

		return
	end

	local var_96_0 = arg_96_0

	arg_96_0.LoadingOn(var_96_0)

	local var_96_1 = {}

	_ = var_96_0

	var_96_0.each(arg_96_0.nodeList, function(arg_100_0)
		tf = var_2_10001

		local var_100_0 = var_2_10001(arg_100_0.GO)

		if arg_100_0.ChangeLock then
			if arg_100_0.prevLink then
				arg_100_0.prevLink[2].Change = true
			end

			local var_100_1 = arg_96_0.loader
			local var_100_2 = var_2.GetPrefab(var_100_1, "ui/" .. var_0_13, "", function(arg_101_0)
				setParent = var_3_10001

				var_3_10001(arg_101_0, var_100_0)

				setAnchoredPosition = var_3_10001

				local var_101_0 = arg_101_0

				Vector2 = var_3

				var_3_10001(var_101_0, var_3.zero)

				return
			end)

			table = var_100_1

			var_100_1.insert(var_96_1, var_100_2)

			arg_100_0.ChangeLock = nil
		end

		return
	end)

	local var_96_2 = arg_96_0
	local var_96_3 = arg_96_0.managedTween

	LeanTween = var_5

	var_96_3(var_96_2, var_5.delayedCall, function()
		pg = var_2_10000

		local var_102_0 = var_2_10000.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_102_0, "event:/ui/ryza_atellier_ui_3")

		return
	end, 0.7, nil)

	local var_96_4 = arg_96_0
	local var_96_5 = arg_96_0.managedTween

	LeanTween = var_5

	var_96_5(var_96_4, var_5.delayedCall, function()
		_ = var_2_10000

		var_2_10000.each(var_96_1, function(arg_104_0)
			local var_104_0 = arg_96_0.loader

			var_1.ClearRequest(var_104_0, arg_104_0)

			return
		end)

		local var_103_0 = arg_96_0

		var_0.LoadingOff(var_103_0)

		existCall = var_0

		var_0(arg_96_1)

		return
	end, 1.7, nil)

	return
end

function var_0_1.ShowCandicatePanel(arg_105_0)
	arg_105_0:DispalyChat({
		"ryza_atellier2",
		"ryza_atellier3",
		"ryza_atellier4"
	})

	pg = var_1

	local var_105_0 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_105_0, "event:/ui/ryza_atellier_ui_1")

	pg = var_1

	local var_105_1 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_105_1, arg_105_0.top)

	setActive = var_1

	var_1(arg_105_0.layerMaterialSelect, true)

	SetCompomentEnabled = var_1

	local var_105_2 = arg_105_0.layerFormulaDetail
	local var_105_3 = var_2.Find(var_105_2, "ScrollView")

	typeof = var_105_2
	ScrollRect = var_4

	var_1(var_105_3, var_105_2(var_4), false)

	removeAllChildren = var_1

	local var_105_4 = arg_105_0.layerMaterialSelect

	var_1(var_2.Find(var_105_4, "Target"))

	return
end

function var_0_1.CloseCandicatePanel(arg_106_0)
	arg_106_0:LoadingOn()

	GetComponent = var_1

	local var_106_0 = arg_106_0.layerMaterialSelect
	local var_106_1 = var_2.Find(var_106_0, "TargetBG")

	typeof = var_106_0
	DftAniEvent = var_4

	local var_106_2 = var_1(var_106_1, var_106_0(var_4))

	var_1.SetEndEvent(var_106_2, function()
		local var_107_0 = arg_106_0

		var_0.LoadingOff(var_107_0)

		local var_107_1 = arg_106_0

		var_0.HideCandicatePanel(var_107_1)

		local var_107_2 = var_0

		var_0.SetEndEvent(var_107_2, nil)

		return
	end)

	GetComponent = var_2

	local var_106_3 = arg_106_0.layerMaterialSelect
	local var_106_4 = var_3.Find(var_106_3, "TargetBG")

	typeof = var_106_3
	Animator = var_5

	local var_106_5 = var_2(var_106_4, var_106_3(var_5))

	var_2.SetBool(var_106_5, "Selecting", false)

	return
end

function var_0_1.HideCandicatePanel(arg_108_0)
	isActive = var_1_10001

	if not var_1_10001(arg_108_0.layerMaterialSelect) then
		return
	end

	pg = var_1

	local var_108_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_108_0, arg_108_0.top)

	local var_108_1 = arg_108_0.painting

	var_1.SetSiblingIndex(var_108_1, 1)

	setActive = var_1

	var_1(arg_108_0.layerMaterialSelect, false)

	removeAllChildren = var_1

	local var_108_2 = arg_108_0.layerMaterialSelect

	var_1(var_2.Find(var_108_2, "Target"))

	SetCompomentEnabled = var_1

	local var_108_3 = arg_108_0.layerFormulaDetail
	local var_108_4 = var_2.Find(var_108_3, "ScrollView")

	typeof = var_108_3
	ScrollRect = var_4

	var_1(var_108_4, var_108_3(var_4), true)

	arg_108_0.candicateTarget = nil

	return true
end

function var_0_1.UpdateCandicatePanel(arg_109_0)
	arg_109_0.candicates = {}

	local var_109_0 = arg_109_0.activity
	local var_109_1 = var_1.GetItems(var_109_0)
	local var_109_2 = arg_109_0.activity
	local var_109_3 = var_2.GetFormulas(var_109_2)[arg_109_0.contextData.formulaId]

	AtelierMaterial = var_3

	local var_109_4 = var_3.bindConfigTable()

	_ = var_1_10004

	local var_109_5 = var_1_10004.map(var_109_4.all, function(arg_110_0)
		local var_110_0

		if not var_109_1[arg_110_0] then
			AtelierMaterial = var_110_0
			var_110_0 = var_110_0.New({
				configId = arg_110_0
			})
		end

		local var_110_1 = arg_109_0.candicateTarget.Data

		if var_2.CanUseMaterial(var_110_1, var_110_0, var_109_3) then
			if var_109_1[arg_110_0] then
				AtelierMaterial = var_2
				var_110_0 = var_2.New({
					configId = arg_110_0,
					count = var_109_1[arg_110_0].count
				})
				_ = var_2
				var_110_0.count = var_2.reduce(arg_109_0.nodeList, var_110_0.count, function(arg_111_0, arg_111_1)
					if arg_111_1.Instance then
						local var_111_0 = arg_111_1.Instance

						if var_2.GetConfigID(var_111_0) == arg_110_0 then
							arg_111_0 = arg_111_0 - 1
						end
					end

					return arg_111_0
				end)
			end

			return var_110_0
		end

		return
	end)

	table = var_5

	var_5.sort(var_109_5, function(arg_112_0, arg_112_1)
		if arg_112_0.count * arg_112_1.count == 0 and arg_112_0.count - arg_112_1.count ~= 0 then
			return arg_112_0.count < arg_112_1.count
		else
			return arg_112_0:GetConfigID() < arg_112_1:GetConfigID()
		end

		return
	end)

	_ = var_5

	var_5.each(var_109_5, function(arg_113_0)
		local var_113_0 = 1

		math = var_2_10002

		for iter_113_0 = var_113_0, var_2_10002.max(arg_113_0.count, 1) do
			table = var_2_10005

			var_2_10005.insert(arg_109_0.candicates, arg_113_0)
		end

		return
	end)

	local var_109_6 = arg_109_0.candicatesRect

	var_5.SetTotalCount(var_109_6, #arg_109_0.candicates, 0)

	return
end

function var_0_1.UpdateCandicateItem(arg_114_0, arg_114_1, arg_114_2)
	tf = var_1_10003

	local var_114_0 = var_1_10003(arg_114_2)
	local var_114_1 = arg_114_0.candicates[arg_114_1]

	arg_114_0:UpdateRyzaItem(var_114_0:Find("IconBG"), var_114_1, true)

	local var_114_2 = var_114_1.count <= 0

	setActive = var_6

	var_6(var_114_0:Find("IconBG/Lack"), var_114_2)

	onButton = var_6

	local var_114_3 = arg_114_0
	local var_114_4 = var_114_0

	local function var_114_5()
		if var_114_2 then
			CreateShell = var_0
			var_114_1 = var_0(var_114_1)
			var_114_1.count = false

			local var_115_0 = arg_114_0

			var_0.ShowItemDetail(var_115_0, var_114_1)
		else
			local var_115_1 = arg_114_0

			var_0.DispalyChat(var_115_1, {
				"ryza_atellier5",
				"ryza_atellier6",
				"ryza_atellier7"
			})

			pg = var_0

			local var_115_2 = var_0.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_115_2, "event:/ui/ryza_atellier_ui_2")

			local var_115_3 = arg_114_0.candicateTarget
			local var_115_4 = arg_114_0

			var_1.HideCandicatePanel(var_115_4)

			seriesAsync = var_1

			var_1({
				function(arg_116_0)
					local var_116_0 = arg_114_0
					local var_116_1 = var_1.FillNodeAndPlayAnim
					local var_116_2 = var_115_3

					AtelierMaterial = var_3_10004

					local var_116_3 = var_3_10004.New
					local var_116_4 = {
						count = 1
					}
					local var_116_5 = var_114_1

					var_116_4.configId = var_6.GetConfigID(var_116_5)

					var_116_1(var_116_0, var_116_2, var_116_3(var_116_4), arg_116_0, true)

					return
				end,
				function(arg_117_0)
					local var_117_0 = arg_114_0

					var_1.DisPlayUnlockEffect(var_117_0, arg_117_0)

					return
				end,
				function(arg_118_0)
					local var_118_0 = arg_114_0

					var_1.UpdateFormulaDetail(var_118_0)

					return
				end
			})
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_6(var_114_3, var_114_4, var_114_5, var_1_10010)

	return
end

function var_0_1.UpdateRyzaItem(arg_119_0, arg_119_1, arg_119_2, arg_119_3)
	local var_119_0 = "icon_frame_" .. arg_119_2:GetRarity()

	if arg_119_3 then
		var_119_0 = var_119_0 .. "_small"
	end

	local var_119_1 = arg_119_0.loader

	var_5.GetSpriteQuiet(var_119_1, var_0_6, var_119_0, arg_119_1)

	local var_119_2 = arg_119_0.loader

	var_5.GetSpriteQuiet(var_119_2, arg_119_2:GetIconPath(), "", arg_119_1:Find("Icon"))

	IsNil = var_5

	if not var_5(arg_119_1:Find("Lv")) then
		setText = var_5

		var_5(arg_119_1:Find("Lv/Text"), arg_119_2:GetLevel())
	end

	local var_119_3 = arg_119_2
	local var_119_4 = arg_119_2.GetProps(var_119_3)

	CustomIndexLayer = var_119_3

	local var_119_5 = var_119_3.Clone2Full(arg_119_1:Find("List"), #var_119_4)

	ipairs = var_7

	for iter_119_0, iter_119_1 in var_7(var_119_5) do
		local var_119_6 = arg_119_0.loader

		var_12.GetSpriteQuiet(var_119_6, var_0_6, "element_" .. var_0_3.ELEMENT_NAME[var_119_4[iter_119_0]], iter_119_1)
	end

	IsNil = var_7

	if not var_7(arg_119_1:Find("Text")) then
		setText = var_7

		var_7(arg_119_1:Find("Text"), arg_119_2.count)
	end

	return
end

function var_0_1.ShowItemDetail(arg_120_0, arg_120_1)
	local var_120_0 = arg_120_0
	local var_120_1 = arg_120_0.emit

	AtelierMaterialDetailMediator = var_1_10004

	var_120_1(var_120_0, var_1_10004.SHOW_DETAIL, arg_120_1)

	return
end

local var_0_15 = 41
local var_0_16 = 5

function var_0_1.ShowCompositeConfirmWindow(arg_121_0)
	setActive = var_1_10001

	var_1_10001(arg_121_0.layerCompositeConfirm, true)

	pg = var_1_10001

	local var_121_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_121_0, arg_121_0.layerCompositeConfirm)

	local var_121_1 = 1
	local var_121_2 = {}
	local var_121_3 = {}

	_ = var_1_10004

	var_1_10004.each(arg_121_0.nodeList, function(arg_122_0)
		local var_122_0 = arg_122_0.Instance
		local var_122_1 = var_1.GetConfigID(var_122_0)

		table = var_122_0

		local var_122_2 = var_122_0.insert
		local var_122_3 = var_121_2
		local var_122_4 = {}
		local var_122_5 = arg_122_0.Data

		var_122_4.key = var_5.GetConfigID(var_122_5)
		var_122_4.value = var_122_1

		var_122_2(var_122_3, var_122_4)

		local var_122_6 = var_121_3
		local var_122_7

		if not var_121_3[var_122_1] then
			var_122_7 = 0
		end

		var_122_6[var_122_1] = var_122_7 + 1

		return
	end)

	onButton = var_4

	local var_121_4 = arg_121_0
	local var_121_5 = arg_121_0.layerCompositeConfirm
	local var_121_6 = var_6.Find(var_121_5, "Window/Confirm")

	local function var_121_7()
		local var_123_0 = arg_121_0
		local var_123_1 = var_0.emit

		GAME = var_2_10002

		var_123_1(var_123_0, var_2_10002.COMPOSITE_ATELIER_RECIPE, var_121_2, var_121_1)

		pg = var_123_1

		local var_123_2 = var_123_1.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_123_2, "event:/ui/ryza_atellier_ui_6")

		return
	end

	SFX_PANEL = var_8

	var_4(var_121_4, var_121_6, var_121_7, var_8)

	local var_121_8 = arg_121_0.activity
	local var_121_9 = var_4.GetFormulas(var_121_8)[arg_121_0.contextData.formulaId]
	local var_121_10 = var_4.GetMaxLimit(var_121_9) ~= 1
	local var_121_11

	if not (var_4:GetMaxLimit() > 0) or not (var_4:GetMaxLimit() - var_4:GetUsedCount()) then
		var_121_11 = 10000
	end

	local var_121_12 = arg_121_0.activity
	local var_121_13 = var_7.GetItems(var_121_12)

	pairs = var_121_12

	for iter_121_0, iter_121_1 in var_121_12(var_121_3) do
		local var_121_14

		if not var_121_13[iter_121_0] or not var_121_13[iter_121_0].count then
			var_121_14 = 0
		end

		math = var_1_10014
		var_1_10014 = var_1_10014.min

		local var_121_15 = var_121_11

		math = var_1_10016
		var_121_11 = var_1_10014(var_121_15, var_1_10016.floor(var_121_14 / iter_121_1))
	end

	local var_121_16 = var_121_11
	local var_121_17 = {
		1,
		var_121_10 and var_121_16 or 1
	}

	Drop = var_10

	local var_121_18 = var_10.New({
		type = var_4:GetProduction()[1],
		id = var_4:GetProduction()[2]
	})
	local var_121_19 = arg_121_0
	local var_121_20 = arg_121_0.UpdateRyzaDrop
	local var_121_21 = arg_121_0.layerCompositeConfirm

	var_121_20(var_121_19, var_13.Find(var_121_21, "Window/Icon"), var_121_18)

	local var_121_22 = arg_121_0.layerCompositeConfirm
	local var_121_23 = var_11.Find(var_121_22, "Window/Counters")
	local var_121_24 = var_121_18
	local var_121_25 = var_121_18.getConfig(var_121_24, "name")

	setActive = var_121_24

	var_121_24(var_121_23, var_121_10)

	if var_121_10 then
		setAnchoredPosition = var_121_24

		local var_121_26 = arg_121_0.layerCompositeConfirm

		var_121_24(var_14.Find(var_121_26, "Window/Icon"), {
			y = var_0_15
		})
		;(function()
			setText = var_2_10000

			local var_124_0 = var_121_23

			var_2_10000(var_1.Find(var_124_0, "Number"), var_121_1)

			setText = var_2_10000

			local var_124_1 = arg_121_0.layerCompositeConfirm
			local var_124_2 = var_1.Find(var_124_1, "Window/Text")

			i18n = var_124_1

			var_2_10000(var_124_2, var_124_1("ryza_composite_confirm", var_121_25, var_121_1))

			return
		end)()

		onButton = var_14

		var_14(arg_121_0, var_121_23:Find("Plus"), function()
			local var_125_0 = var_121_1

			var_121_1 = var_121_1 + 1
			math = var_1
			var_121_1 = var_1.clamp(var_121_1, var_121_17[1], var_121_17[2])

			if var_125_0 == var_121_1 then
				pg = var_1

				local var_125_1 = var_1.TipsMgr.GetInstance()
				local var_125_2 = var_1.ShowTips

				i18n = var_3

				var_125_2(var_125_1, var_3("ryza_tip_max_composite_count"))

				return
			end

			var_121_24()

			return
		end)

		onButton = var_14

		var_14(arg_121_0, var_121_23:Find("Minus"), function()
			var_121_1 = var_121_1 - 1
			math = var_0
			var_121_1 = var_0.clamp(var_121_1, var_121_17[1], var_121_17[2])

			var_121_24()

			return
		end)

		onButton = var_14

		var_14(arg_121_0, var_121_23:Find("Plus10"), function()
			local var_127_0 = var_121_1

			var_121_1 = var_121_1 + 10
			math = var_1
			var_121_1 = var_1.clamp(var_121_1, var_121_17[1], var_121_17[2])

			if var_127_0 == var_121_1 then
				pg = var_1

				local var_127_1 = var_1.TipsMgr.GetInstance()
				local var_127_2 = var_1.ShowTips

				i18n = var_3

				var_127_2(var_127_1, var_3("ryza_tip_max_composite_count"))

				return
			end

			var_121_24()

			return
		end)

		onButton = var_14

		var_14(arg_121_0, var_121_23:Find("Minus10"), function()
			var_121_1 = var_121_1 - 10
			math = var_0
			var_121_1 = var_0.clamp(var_121_1, var_121_17[1], var_121_17[2])

			var_121_24()

			return
		end)
	else
		setAnchoredPosition = var_121_24

		local var_121_27 = arg_121_0.layerCompositeConfirm

		var_121_24(var_14.Find(var_121_27, "Window/Icon"), {
			y = var_0_16
		})

		setText = var_121_24

		local var_121_28 = arg_121_0.layerCompositeConfirm
		local var_121_29 = var_14.Find(var_121_28, "Window/Text")

		i18n = var_121_28

		var_121_24(var_121_29, var_121_28("ryza_composite_confirm_single", var_121_25, var_121_1))
	end

	return
end

function var_0_1.HideCompositeConfirmWindow(arg_129_0)
	isActive = var_1_10001

	if not var_1_10001(arg_129_0.layerCompositeConfirm) then
		return
	end

	pg = var_1

	local var_129_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_129_0, arg_129_0.layerCompositeConfirm, arg_129_0._tf)

	setActive = var_1

	var_1(arg_129_0.layerCompositeConfirm, false)

	return true
end

local var_0_17 = "laisha_lianjin"

function var_0_1.OnCompositeResult(arg_130_0, arg_130_1)
	arg_130_0:LoadingOn()
	arg_130_0:DispalyChat({
		"ryza_atellier8",
		"ryza_atellier9"
	})

	local var_130_0 = 1.5
	local var_130_1 = 0.5
	local var_130_2 = arg_130_0.loader

	var_4.GetPrefab(var_130_2, "ui/" .. var_0_17, "", function(arg_131_0)
		pg = var_2_10001

		local var_131_0 = var_2_10001.UIMgr.GetInstance()
		local var_131_1 = var_1.OverlayPanel

		tf = var_2_10003

		var_131_1(var_131_0, var_2_10003(arg_131_0))

		setAnchoredPosition = var_131_1

		local var_131_2 = arg_131_0

		Vector2 = var_3

		var_131_1(var_131_2, var_3.zero)

		local var_131_3 = arg_130_0
		local var_131_4 = var_1.managedTween

		LeanTween = var_3

		local var_131_5 = var_3.alphaCanvas
		local var_131_6

		GetComponent = var_2_10005

		local var_131_7 = arg_130_0._tf

		typeof = var_2_10007
		CanvasGroup = var_2_10008

		local var_131_8 = var_131_4(var_131_3, var_131_5, var_131_6, var_2_10005(var_131_7, var_2_10007(var_2_10008)), 0, var_130_0)

		var_1.setFrom(var_131_8, 1)

		local var_131_9 = arg_130_0
		local var_131_10 = var_1.managedTween

		LeanTween = var_3

		local var_131_11 = var_3.alphaCanvas
		local var_131_12

		GetComponent = var_5

		local var_131_13 = arg_130_0.top

		typeof = var_7
		CanvasGroup = var_2_10008

		local var_131_14 = var_131_10(var_131_9, var_131_11, var_131_12, var_5(var_131_13, var_7(var_2_10008)), 0, var_130_0)

		var_1.setFrom(var_131_14, 1)

		local var_131_15 = arg_130_0
		local var_131_16 = var_1.managedTween

		LeanTween = var_3

		local var_131_17 = var_3.alphaCanvas
		local var_131_18

		GetComponent = var_5

		local var_131_19 = arg_130_0.layerCompositeConfirm

		typeof = var_7
		CanvasGroup = var_2_10008

		local var_131_20 = var_131_16(var_131_15, var_131_17, var_131_18, var_5(var_131_19, var_7(var_2_10008)), 0, var_130_0)

		var_1.setFrom(var_131_20, 1)

		local var_131_21 = arg_130_0
		local var_131_22 = var_1.managedTween

		LeanTween = var_3

		local var_131_23 = var_3.delayedCall

		local function var_131_24()
			local var_132_0 = arg_130_0

			var_0.HideCompositeConfirmWindow(var_132_0)

			setCanvasGroupAlpha = var_0

			var_0(arg_130_0.layerCompositeConfirm, 1)

			local var_132_1 = arg_130_0

			var_0.CleanNodeInstance(var_132_1)

			local var_132_2 = arg_130_0

			var_0.ShowCompositeResult(var_132_2, arg_130_1)

			local var_132_3 = arg_130_0

			var_0.DispalyChat(var_132_3, {
				"ryza_atellier10",
				"ryza_atellier11"
			})

			local var_132_4 = arg_130_0
			local var_132_5 = var_0.managedTween

			LeanTween = var_2

			local var_132_6 = var_2.alphaCanvas
			local var_132_7

			GetComponent = var_3_10004

			local var_132_8 = arg_130_0._tf

			typeof = var_3_10006
			CanvasGroup = var_3_10007

			local var_132_9 = var_132_5(var_132_4, var_132_6, var_132_7, var_3_10004(var_132_8, var_3_10006(var_3_10007)), 1, var_130_1)

			var_0.setFrom(var_132_9, 0)

			local var_132_10 = arg_130_0
			local var_132_11 = var_0.managedTween

			LeanTween = var_2

			local var_132_12 = var_2.alphaCanvas
			local var_132_13

			GetComponent = var_4

			local var_132_14 = arg_130_0.top

			typeof = var_6
			CanvasGroup = var_3_10007

			local var_132_15 = var_132_11(var_132_10, var_132_12, var_132_13, var_4(var_132_14, var_6(var_3_10007)), 1, var_130_1)

			var_0.setFrom(var_132_15, 0)

			local var_132_16 = arg_130_0
			local var_132_17 = var_0.managedTween

			LeanTween = var_2

			local var_132_18 = var_2.alphaCanvas
			local var_132_19

			GetOrAddComponent = var_4

			local var_132_20 = arg_130_0.layerCompositeResult

			typeof = var_6
			CanvasGroup = var_3_10007

			local var_132_21 = var_132_17(var_132_16, var_132_18, var_132_19, var_4(var_132_20, var_6(var_3_10007)), 1, var_130_1)

			var_0.setFrom(var_132_21, 0)

			local var_132_22 = arg_130_0
			local var_132_23 = var_0.managedTween

			LeanTween = var_2

			local var_132_24 = var_2.delayedCall

			local function var_132_25()
				local var_133_0 = arg_130_0

				var_0.LoadingOff(var_133_0)

				pg = var_0

				local var_133_1 = var_0.UIMgr.GetInstance()
				local var_133_2 = var_0.UnOverlayPanel

				tf = var_4_10002

				var_133_2(var_133_1, var_4_10002(arg_131_0), arg_130_0._tf)

				local var_133_3 = arg_130_0.loader

				var_0.ClearRequest(var_133_3, "CompositeResult")

				return
			end

			go = var_4

			var_132_23(var_132_22, var_132_24, var_132_25, var_4(arg_130_0.layerCompositeResult), var_130_1, nil)

			return
		end

		go = var_5

		var_131_22(var_131_21, var_131_23, var_131_24, var_5(arg_130_0.layerCompositeResult), var_130_0, nil)

		return
	end, "CompositeResult")

	return
end

function var_0_1.ShowCompositeResult(arg_134_0, arg_134_1)
	setActive = var_1_10002

	var_1_10002(arg_134_0.layerCompositeResult, true)

	pg = var_1_10002

	local var_134_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_134_0, arg_134_0.layerCompositeResult)

	if arg_134_1[1] == nil then
		return
	end

	local var_134_1 = arg_134_0
	local var_134_2 = arg_134_0.UpdateRyzaDrop
	local var_134_3 = arg_134_0.layerCompositeResult

	var_134_2(var_134_1, var_5.Find(var_134_3, "Window/Icon"), var_2)

	setScrollText = var_134_2

	local var_134_4 = arg_134_0.layerCompositeResult

	var_134_2(var_4.Find(var_134_4, "Window/NameBG/Rect/Name"), var_2:getName())

	setText = var_134_2

	local var_134_5 = arg_134_0.layerCompositeResult

	var_134_2(var_4.Find(var_134_5, "Window/CountBG/Text"), var_2.count)

	return
end

function var_0_1.HideCompositeResult(arg_135_0)
	isActive = var_1_10001

	if not var_1_10001(arg_135_0.layerCompositeResult) then
		return
	end

	pg = var_1

	local var_135_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_135_0, arg_135_0.layerCompositeResult, arg_135_0._tf)

	setActive = var_1

	var_1(arg_135_0.layerCompositeResult, false)

	pg = var_1

	local var_135_1 = var_1.NewStoryMgr.GetInstance()

	if var_1.IsPlayed(var_135_1, "NG0032") then
		pg = var_1

		local var_135_2 = var_1.SystemGuideMgr.GetInstance()

		var_1.PlayByGuideId(var_135_2, "NG0033", {
			2
		})
	end

	return true
end

function var_0_1.ShowStoreHouseWindow(arg_136_0)
	setActive = var_1_10001

	var_1_10001(arg_136_0.layerStoreHouse, true)

	pg = var_1_10001

	local var_136_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_136_0, arg_136_0.layerStoreHouse)

	_ = var_1

	local var_136_1 = var_1.filter

	_ = var_136_0

	local var_136_2 = var_136_0.values
	local var_136_3 = arg_136_0.activity
	local var_136_4 = var_136_1(var_136_2(var_3.GetItems(var_136_3)), function(arg_137_0)
		return arg_137_0.count > 0
	end)

	table = var_2

	var_2.sort(var_136_4, function(arg_138_0, arg_138_1)
		return arg_138_0:GetConfigID() < arg_138_1:GetConfigID()
	end)

	setActive = var_2

	local var_136_5 = arg_136_0.layerStoreHouse

	var_2(var_3.Find(var_136_5, "Window/Empty"), #var_136_4 == 0)

	setActive = var_2

	local var_136_6 = arg_136_0.layerStoreHouse

	var_2(var_3.Find(var_136_6, "Window/ScrollView"), #var_136_4 > 0)

	if #var_136_4 == 0 then
		return
	end

	function arg_136_0.storehouseRect.onUpdateItem(arg_139_0, arg_139_1)
		arg_139_0 = arg_139_0 + 1
		tf = var_2_10002

		local var_139_0 = var_2_10002(arg_139_1)
		local var_139_1 = var_136_4[arg_139_0]
		local var_139_2 = arg_136_0

		var_4.UpdateRyzaItem(var_139_2, var_139_0:Find("IconBG"), var_139_1)

		setScrollText = var_4

		var_4(var_139_0:Find("NameBG/Rect/Name"), var_139_1:GetName())

		onButton = var_4

		local var_139_3 = arg_136_0
		local var_139_4 = var_139_0

		local function var_139_5()
			local var_140_0 = arg_136_0

			var_0.ShowItemDetail(var_140_0, var_139_1)

			return
		end

		SFX_PANEL = var_8

		var_4(var_139_3, var_139_4, var_139_5, var_8)

		return
	end

	local var_136_7 = arg_136_0.storehouseRect

	var_2.SetTotalCount(var_136_7, #var_136_4)

	return
end

function var_0_1.CloseStoreHouseWindow(arg_141_0)
	arg_141_0.contextData.showStoreHouse = nil

	return arg_141_0:HideStoreHouseWindow()
end

function var_0_1.HideStoreHouseWindow(arg_142_0)
	isActive = var_1_10001

	if not var_1_10001(arg_142_0.layerStoreHouse) then
		return
	end

	pg = var_1

	local var_142_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_142_0, arg_142_0.layerStoreHouse, arg_142_0._tf)

	setActive = var_1

	var_1(arg_142_0.layerStoreHouse, false)

	return true
end

function var_0_1.ShowMaterialsPreview(arg_143_0)
	setActive = var_1_10001

	var_1_10001(arg_143_0.layerMaterialsPreview, true)

	pg = var_1_10001

	local var_143_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_143_0, arg_143_0.layerMaterialsPreview)

	local var_143_1 = arg_143_0.activity
	local var_143_2 = var_1.GetItems(var_143_1)
	local var_143_3 = arg_143_0.activity
	local var_143_4 = var_2.GetFormulas(var_143_3)[arg_143_0.contextData.formulaId]

	AtelierMaterial = var_3

	local var_143_5 = var_3.bindConfigTable()
	local var_143_6 = {}
	local var_143_7 = {}
	local var_143_8 = {}

	local function var_143_9(arg_144_0)
		local var_144_0

		if not var_143_8[arg_144_0:GetConfigID()] then
			Clone = var_144_0
			var_144_0 = var_144_0(var_143_2[arg_144_0:GetConfigID()])
		end

		assert = var_2

		var_2(var_144_0, "Using Unexist material")

		var_144_0.count = var_144_0.count - 1
		var_143_8[arg_144_0:GetConfigID()] = var_144_0

		return
	end

	_ = var_1_10008

	var_1_10008.each(arg_143_0.nodeList, function(arg_145_0)
		local var_145_0 = arg_145_0.Data

		if var_1.GetType(var_145_0) == var_0_3.TYPE.BASE or var_1:GetType() == var_0_3.TYPE.SAIREN then
			local var_145_1 = var_1:GetLimitItemID()
			local var_145_2

			if not var_143_8[var_145_1] then
				var_145_2 = var_143_2[var_145_1]
			end

			if var_145_2 and var_145_2.count > 0 then
				AtelierMaterial = var_2_10004
				var_2_10004 = var_2_10004.New({
					configId = var_145_1
				})
				var_2_10004.count = false
				table = var_5

				var_5.insert(var_143_6, var_2_10004)
				var_143_9(var_145_2)
			else
				AtelierMaterial = var_2_10004

				local var_145_3 = var_2_10004.New({
					configId = var_145_1
				})

				var_145_3.count = false
				table = var_5

				var_5.insert(var_143_7, var_145_3)
			end
		end

		return
	end)

	local function var_143_10(arg_146_0)
		if arg_146_0.Instance then
			AtelierMaterial = var_1

			local var_146_0 = var_1.New
			local var_146_1 = {}
			local var_146_2 = arg_146_0.Instance

			var_146_1.configId = var_2_10003.GetConfigID(var_146_2)

			local var_146_3 = var_146_0(var_146_1)

			var_146_3.count = false
			table = var_2

			var_2.insert(var_143_6, var_146_3)
			var_143_9(arg_146_0.Instance)

			return
		end

		local var_146_4 = arg_146_0.Data
		local var_146_5

		ipairs = var_2_10003

		for iter_146_0, iter_146_1 in var_2_10003(var_143_5.all) do
			local var_146_6

			if not var_143_8[iter_146_1] and not var_143_2[iter_146_1] then
				AtelierMaterial = var_146_6
				var_146_6 = var_146_6.New({
					configId = iter_146_1
				})
			end

			if var_146_6:IsNormal() and var_146_4:CanUseMaterial(var_146_6, var_143_4) then
				var_146_5 = var_146_5 or iter_146_1

				if var_146_6.count > 0 then
					AtelierMaterial = var_9

					local var_146_7 = var_9.New({
						configId = iter_146_1
					})

					var_146_7.count = false
					table = var_10

					var_10.insert(var_143_6, var_146_7)
					var_143_9(var_146_6)

					return
				end
			end
		end

		AtelierMaterial = var_3

		local var_146_8 = var_3.New({
			configId = var_146_5
		})

		var_146_8.count = false
		table = var_4

		var_4.insert(var_143_7, var_146_8)

		return
	end

	_ = var_9

	var_9.each(arg_143_0.nodeList, function(arg_147_0)
		local var_147_0 = arg_147_0.Data

		if var_1.GetType(var_147_0) == var_0_3.TYPE.NORMAL then
			var_143_10(arg_147_0)
		end

		return
	end)

	_ = var_9

	var_9.each(arg_143_0.nodeList, function(arg_148_0)
		local var_148_0 = arg_148_0.Data

		if var_1.GetType(var_148_0) == var_0_3.TYPE.ANY then
			var_143_10(arg_148_0)
		end

		return
	end)

	local function var_143_11(arg_149_0, arg_149_1)
		return arg_149_0:GetConfigID() < arg_149_1:GetConfigID()
	end

	table = var_10

	var_10.sort(var_143_6, var_143_11)

	table = var_10

	var_10.sort(var_143_7, var_143_11)

	local function var_143_12()
		local var_150_0 = arg_143_0.layerMaterialsPreview
		local var_150_1 = var_0.Find(var_150_0, "Frame/Scroll/Content/Owned/List")

		setActive = var_150_0

		var_150_0(var_150_1.parent, #var_143_6 > 0)

		if #var_143_6 == 0 then
			return
		end

		CustomIndexLayer = var_1

		local var_150_2 = var_1.Clone2Full(var_150_1, #var_143_6)

		table = var_2

		var_2.Foreach(var_150_2, function(arg_151_0, arg_151_1)
			local var_151_0 = var_143_6[arg_151_0]
			local var_151_1 = arg_143_0

			var_3.UpdateRyzaItem(var_151_1, arg_151_1:Find("IconBG"), var_151_0, true)

			onButton = var_3

			local var_151_2 = arg_143_0
			local var_151_3 = arg_151_1

			local function var_151_4()
				local var_152_0 = arg_143_0

				var_0.ShowItemDetail(var_152_0, var_151_0)

				return
			end

			SFX_PANEL = var_7

			var_3(var_151_2, var_151_3, var_151_4, var_7)

			return
		end)

		return
	end

	local function var_143_13()
		local var_153_0 = arg_143_0.layerMaterialsPreview
		local var_153_1 = var_0.Find(var_153_0, "Frame/Scroll/Content/Lack/List")

		setActive = var_153_0

		var_153_0(var_153_1.parent, #var_143_7 > 0)

		if #var_143_7 == 0 then
			return
		end

		CustomIndexLayer = var_1

		local var_153_2 = var_1.Clone2Full(var_153_1, #var_143_7)

		table = var_2

		var_2.Foreach(var_153_2, function(arg_154_0, arg_154_1)
			local var_154_0 = var_143_7[arg_154_0]
			local var_154_1 = arg_143_0

			var_3.UpdateRyzaItem(var_154_1, arg_154_1:Find("IconBG"), var_154_0, true)

			onButton = var_3

			local var_154_2 = arg_143_0
			local var_154_3 = arg_154_1

			local function var_154_4()
				local var_155_0 = arg_143_0

				var_0.ShowItemDetail(var_155_0, var_154_0)

				return
			end

			SFX_PANEL = var_7

			var_3(var_154_2, var_154_3, var_154_4, var_7)

			return
		end)

		return
	end

	var_143_12()
	var_143_13()

	return
end

function var_0_1.HideMaterialsPreview(arg_156_0)
	isActive = var_1_10001

	if not var_1_10001(arg_156_0.layerMaterialsPreview) then
		return
	end

	pg = var_1

	local var_156_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_156_0, arg_156_0.layerMaterialsPreview, arg_156_0._tf)

	setActive = var_1

	var_1(arg_156_0.layerMaterialsPreview, false)

	return true
end

function var_0_1.OnReceiveFormualRequest(arg_157_0, arg_157_1)
	arg_157_0:HideCandicatePanel()
	arg_157_0:HideCompositeConfirmWindow()
	arg_157_0:HideCompositeResult()
	arg_157_0:HideMaterialsPreview()
	arg_157_0:CloseStoreHouseWindow()
	arg_157_0:HideFormulaList()

	local var_157_0 = arg_157_0.activity
	local var_157_1 = var_2.GetFormulas(var_157_0)[arg_157_1]

	arg_157_0:ShowFormulaDetail(var_157_1)

	return
end

function var_0_1.DispalyChat(arg_158_0, arg_158_1)
	arg_158_0:HideChat()

	setActive = var_2

	var_2(arg_158_0.chat, true)

	LeanTween = var_2

	local var_158_0 = var_2.delayedCall

	go = var_3

	local var_158_1 = var_3(arg_158_0.chat)
	local var_158_2 = 4

	System = var_1_10005
	arg_158_0.chatTween = var_158_0(var_158_1, var_158_2, var_1_10005.Action(function()
		local var_159_0 = arg_158_0

		var_0.HideChat(var_159_0)

		return
	end)).uniqueId
	math = var_3

	local var_158_3 = arg_158_1[var_3.random(#arg_158_1)]

	pg = var_4

	local var_158_4 = var_4.gametip.ryza_composite_words.tip

	_ = var_5

	local var_158_5 = var_5.detect(var_158_4, function(arg_160_0)
		return arg_160_0[1] == var_158_3
	end) and var_5[2]

	setText = var_7

	local var_158_6 = arg_158_0.chat

	var_7(var_8.Find(var_158_6, "Text"), var_158_5)

	local var_158_7 = 1090001
	local var_158_8 = "event:/cv/" .. var_158_7 .. "/" .. var_158_3

	arg_158_0:PlaySound(var_158_8)

	return
end

function var_0_1.HideChat(arg_161_0)
	if arg_161_0.chatTween then
		LeanTween = var_1

		var_1.cancel(arg_161_0.chatTween)

		arg_161_0.chatTween = nil
	end

	setActive = var_1

	var_1(arg_161_0.chat, false)

	return
end

function var_0_1.PlaySound(arg_162_0, arg_162_1, arg_162_2)
	if not arg_162_0.playbackInfo or arg_162_1 ~= arg_162_0.prevCvPath or arg_162_0.playbackInfo.channelPlayer == nil then
		arg_162_0:StopSound()

		pg = var_3

		local var_162_0 = var_3.CriMgr.GetInstance()

		var_3.PlaySoundEffect_V3(var_162_0, arg_162_1, function(arg_163_0)
			if arg_163_0 then
				arg_162_0.playbackInfo = arg_163_0

				local var_163_0 = arg_162_0.playbackInfo

				var_1.SetIgnoreAutoUnload(var_163_0, true)

				if arg_162_2 then
					arg_162_2(arg_162_0.playbackInfo.cueInfo)
				end
			elseif arg_162_2 then
				arg_162_2()
			end

			return
		end)

		arg_162_0.prevCvPath = arg_162_1

		if arg_162_0.playbackInfo == nil then
			return nil
		end

		return arg_162_0.playbackInfo.cueInfo
	elseif arg_162_0.playbackInfo then
		local var_162_1 = arg_162_0.playbackInfo

		var_3.PlaybackStop(var_162_1)

		local var_162_2 = arg_162_0.playbackInfo

		var_3.SetStartTimeAndPlay(var_162_2)

		if arg_162_2 then
			arg_162_2(arg_162_0.playbackInfo.cueInfo)
		end

		return arg_162_0.playbackInfo.cueInfo
	elseif arg_162_2 then
		arg_162_2()
	end

	return nil
end

function var_0_1.StopSound(arg_164_0)
	if arg_164_0.playbackInfo then
		pg = var_1

		local var_164_0 = var_1.CriMgr.GetInstance()

		var_1.StopPlaybackInfoForce(var_164_0, arg_164_0.playbackInfo)

		local var_164_1 = arg_164_0.playbackInfo

		var_1.SetIgnoreAutoUnload(var_164_1, false)
	end

	return
end

function var_0_1.ClearSound(arg_165_0)
	arg_165_0:StopSound()

	if arg_165_0.playbackInfo then
		local var_165_0 = arg_165_0.playbackInfo

		var_1.Dispose(var_165_0)

		arg_165_0.playbackInfo = nil
	end

	return
end

function var_0_1.LoadingOn(arg_166_0)
	if arg_166_0.animating then
		return
	end

	arg_166_0.animating = true
	pg = var_1

	local var_166_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_166_0, false)

	return
end

function var_0_1.LoadingOff(arg_167_0)
	if not arg_167_0.animating then
		return
	end

	pg = var_1

	local var_167_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOff(var_167_0)

	arg_167_0.animating = false

	return
end

function var_0_1.willExit(arg_168_0)
	local var_168_0 = arg_168_0.loader

	var_1.Clear(var_168_0)
	arg_168_0:LoadingOff()
	arg_168_0:HideChat()
	arg_168_0:ClearSound()
	arg_168_0:HideStoreHouseWindow()
	arg_168_0:HideMaterialsPreview()
	arg_168_0:HideCompositeResult()
	arg_168_0:HideCompositeConfirmWindow()
	arg_168_0:HideCandicatePanel()
	arg_168_0:HideFormulaDetail()
	arg_168_0:HideFormulaList()

	pg = var_1

	local var_168_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_168_1, arg_168_0.top, arg_168_0._tf)

	if arg_168_0.nodePools then
		pairs = var_1

		for iter_168_0, iter_168_1 in var_1(arg_168_0.nodePools) do
			iter_168_1:ClearItems()
		end
	end

	return
end

return var_0_1
