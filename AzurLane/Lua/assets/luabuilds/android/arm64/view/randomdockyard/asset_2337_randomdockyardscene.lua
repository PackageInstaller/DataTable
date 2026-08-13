class = var_0_10000

local var_0_0 = "RandomDockYardScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.MODE_VIEW = 1
var_0_1.MODE_ADD = 2
var_0_1.MODE_REMOVE = 3

function var_0_1.getUIName(arg_1_0)
	return "RandomDockYardUI"
end

function var_0_1.OnChangeRandomShips(arg_2_0)
	arg_2_0.randomFlagShips = nil
	arg_2_0.dockyardShips = nil

	arg_2_0:Switch(var_0_1.MODE_VIEW)

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "blur_panel/adapt/top/title")
	local var_3_2 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_3_0.titleImg = var_3_2(var_3_1, var_4(var_1_10006))

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_1.Find(var_3_3, "blur_panel/adapt/top/title/title_en")
	local var_3_5 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_3_0.titleEnImg = var_3_5(var_3_4, var_4(var_1_10006))

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_1.Find(var_3_6, "main/ship_container/ships")

	arg_3_0.scrollrect = var_1.GetComponent(var_3_7, "LScrollRect")

	local var_3_8 = arg_3_0._tf

	arg_3_0.emptyTr = var_1.Find(var_3_8, "empty")

	local var_3_9 = arg_3_0._tf

	arg_3_0.backBtn = var_1.Find(var_3_9, "blur_panel/adapt/top/back")

	local var_3_10 = arg_3_0._tf

	arg_3_0.addBtn = var_1.Find(var_3_10, "blur_panel/select_panel/add_button")

	local var_3_11 = arg_3_0._tf

	arg_3_0.removeBtn = var_1.Find(var_3_11, "blur_panel/select_panel/remove_button")

	local var_3_12 = arg_3_0._tf

	arg_3_0.cancelBtn = var_1.Find(var_3_12, "blur_panel/select_panel/cancel_button")

	local var_3_13 = arg_3_0._tf

	arg_3_0.confirmBtn = var_1.Find(var_3_13, "blur_panel/select_panel/confirm_button")

	local var_3_14 = arg_3_0.confirmBtn

	arg_3_0.confirmBtnMask = var_1.Find(var_3_14, "mask")

	local var_3_15 = arg_3_0._tf

	arg_3_0.allBtn = var_1.Find(var_3_15, "blur_panel/select_panel/all_button")

	local var_3_16 = arg_3_0._tf
	local var_3_17 = var_1.Find(var_3_16, "blur_panel/select_panel/tip")
	local var_3_18 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.tipTxt = var_3_18(var_3_17, var_4(var_1_10006))

	local var_3_19 = arg_3_0._tf
	local var_3_20 = var_1.Find(var_3_19, "blur_panel/select_panel/bottom_info/bg_input/selected")
	local var_3_21 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.selectedTxt = var_3_21(var_3_20, var_4(var_1_10006))

	local var_3_22 = arg_3_0._tf

	arg_3_0.frequentlyUseToggle = var_1.Find(var_3_22, "blur_panel/adapt/top/preference_toggle")

	local var_3_23 = arg_3_0._tf

	arg_3_0.lockToggle = var_1.Find(var_3_23, "blur_panel/adapt/top/lock_toggle")

	local var_3_24 = arg_3_0._tf

	arg_3_0.sortBtn = var_1.Find(var_3_24, "blur_panel/adapt/top/sort_button")

	local var_3_25 = arg_3_0.sortBtn
	local var_3_26 = var_1.Find(var_3_25, "Image")
	local var_3_27 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.sortTxt = var_3_27(var_3_26, var_4(var_1_10006))

	local var_3_28 = arg_3_0.sortBtn

	arg_3_0.sortUp = var_1.Find(var_3_28, "asc")

	local var_3_29 = arg_3_0.sortBtn

	arg_3_0.sortDown = var_1.Find(var_3_29, "desc")

	local var_3_30 = arg_3_0._tf

	arg_3_0.indexBtn = var_1.Find(var_3_30, "blur_panel/adapt/top/index_button")

	local var_3_31 = arg_3_0.indexBtn

	arg_3_0.indexBtnSel = var_1.Find(var_3_31, "Image")

	local var_3_32 = arg_3_0._tf
	local var_3_33 = var_1.Find(var_3_32, "blur_panel/select_panel/bottom_info/bg_input/count")
	local var_3_34 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.selectedCntTxt = var_3_34(var_3_33, var_4(var_1_10006))

	local var_3_35 = arg_3_0._tf

	arg_3_0.phantomToggle = var_1.Find(var_3_35, "toggle_phantom")

	local var_3_36 = arg_3_0._tf

	arg_3_0.selectPanelFrame = var_1.Find(var_3_36, "blur_panel/select_panel/bottom_info/bg_input")
	setActive = var_1

	var_1(arg_3_0.sortUp, false)

	setActive = var_1

	var_1(arg_3_0.sortDown, true)

	setText = var_1

	local var_3_37 = arg_3_0.emptyTr
	local var_3_38 = var_3.Find(var_3_37, "Text")

	i18n = var_4

	var_1(var_3_38, var_4("random_ship_custom_mode_main_empty"))

	setText = var_1

	local var_3_39 = arg_3_0.addBtn
	local var_3_40 = var_3.Find(var_3_39, "Text")

	i18n = var_4

	var_1(var_3_40, var_4("random_ship_custom_mode_main_button_add"))

	setText = var_1

	local var_3_41 = arg_3_0.removeBtn
	local var_3_42 = var_3.Find(var_3_41, "Text")

	i18n = var_4

	var_1(var_3_42, var_4("random_ship_custom_mode_main_button_remove"))

	setText = var_1

	local var_3_43 = arg_3_0.cancelBtn
	local var_3_44 = var_3.Find(var_3_43, "Text")

	i18n = var_4

	var_1(var_3_44, var_4("text_cancel"))

	setText = var_1

	local var_3_45 = arg_3_0.confirmBtn
	local var_3_46 = var_3.Find(var_3_45, "Text")

	i18n = var_4

	var_1(var_3_46, var_4("text_confirm"))

	setText = var_1

	local var_3_47 = arg_3_0.allBtn
	local var_3_48 = var_3.Find(var_3_47, "Text")

	i18n = var_4

	var_1(var_3_48, var_4("random_ship_custom_mode_select_all"))

	RandomDockYardMsgBoxPgae = var_1
	arg_3_0.msgbox = var_1.New(arg_3_0._tf, arg_3_0.event)

	arg_3_0:InitDefault()

	return
end

function var_0_1.InitDefault(arg_4_0)
	arg_4_0.selected = {}

	local var_4_0 = {}
	local var_4_1 = var_0_1.MODE_VIEW

	GetSpriteFromAtlas = var_1_10003
	var_4_0[var_4_1] = var_1_10003("ui/dockyardui_atlas", "title_random_ship")

	local var_4_2 = var_0_1.MODE_ADD

	GetSpriteFromAtlas = var_3
	var_4_0[var_4_2] = var_3("ui/dockyardui_atlas", "title_add_random_ship")

	local var_4_3 = var_0_1.MODE_REMOVE

	GetSpriteFromAtlas = var_3
	var_4_0[var_4_3] = var_3("ui/dockyardui_atlas", "title_remove_random_ship")
	arg_4_0.titles = var_4_0

	local var_4_4 = {}
	local var_4_5 = var_0_1.MODE_VIEW

	GetSpriteFromAtlas = var_3
	var_4_4[var_4_5] = var_3("ui/dockyardui_atlas", "title_rd_en")

	local var_4_6 = var_0_1.MODE_ADD

	GetSpriteFromAtlas = var_3
	var_4_4[var_4_6] = var_3("ui/dockyardui_atlas", "title_add_en")

	local var_4_7 = var_0_1.MODE_REMOVE

	GetSpriteFromAtlas = var_3
	var_4_4[var_4_7] = var_3("ui/dockyardui_atlas", "title_remove_en")
	arg_4_0.titleEns = var_4_4

	local var_4_8 = {
		[var_0_1.MODE_VIEW] = {
			en = "",
			cn = ""
		}
	}
	local var_4_9 = var_0_1.MODE_ADD
	local var_4_10 = {
		en = "ADD"
	}

	i18n = var_1_10004
	var_4_10.cn = var_1_10004("random_ship_custom_mode_add_title")
	var_4_8[var_4_9] = var_4_10

	local var_4_11 = var_0_1.MODE_REMOVE
	local var_4_12 = {
		en = "REMOVE"
	}

	i18n = var_4
	var_4_12.cn = var_4("random_ship_custom_mode_remove_title")
	var_4_8[var_4_11] = var_4_12
	arg_4_0.msgBoxTitle = var_4_8

	local var_4_13 = {
		[var_0_1.MODE_VIEW] = ""
	}
	local var_4_14 = var_0_1.MODE_ADD

	i18n = var_3
	var_4_13[var_4_14] = var_3("random_ship_custom_mode_add_tip2")

	local var_4_15 = var_0_1.MODE_REMOVE

	i18n = var_3
	var_4_13[var_4_15] = var_3("random_ship_custom_mode_remove_tip2")
	arg_4_0.msgBoxSubTitle = var_4_13

	local var_4_16 = {}
	local var_4_17 = var_0_1.MODE_VIEW

	i18n = var_3
	var_4_16[var_4_17] = var_3("random_ship_custom_mode_main_tip1")

	local var_4_18 = var_0_1.MODE_ADD

	i18n = var_3
	var_4_16[var_4_18] = var_3("random_ship_custom_mode_add_tip1")

	local var_4_19 = var_0_1.MODE_REMOVE

	i18n = var_3
	var_4_16[var_4_19] = var_3("random_ship_custom_mode_remove_tip1")
	arg_4_0.tips = var_4_16

	local var_4_20 = {}
	local var_4_21 = var_0_1.MODE_VIEW

	i18n = var_3
	var_4_20[var_4_21] = var_3("random_ship_custom_mode_main_tip2")

	local var_4_22 = var_0_1.MODE_ADD

	i18n = var_3
	var_4_20[var_4_22] = var_3("random_ship_custom_mode_select_number")

	local var_4_23 = var_0_1.MODE_REMOVE

	i18n = var_3
	var_4_20[var_4_23] = var_3("random_ship_custom_mode_select_number")
	arg_4_0.selectedTxts = var_4_20
	arg_4_0.frequentlyUseFlags = {
		[var_0_1.MODE_VIEW] = false,
		[var_0_1.MODE_ADD] = false,
		[var_0_1.MODE_REMOVE] = false
	}
	arg_4_0.lockFlags = {
		[var_0_1.MODE_VIEW] = false,
		[var_0_1.MODE_ADD] = false,
		[var_0_1.MODE_REMOVE] = false
	}
	arg_4_0.sortFlags = {
		[var_0_1.MODE_VIEW] = false,
		[var_0_1.MODE_ADD] = false,
		[var_0_1.MODE_REMOVE] = false
	}

	local var_4_24 = {}
	local var_4_25 = var_0_1.MODE_VIEW
	local var_4_26 = {}

	ShipIndexConst = var_4
	var_4_26.sortIndex = var_4.SortLevel
	ShipIndexConst = var_4
	var_4_26.typeIndex = var_4.TypeAll
	ShipIndexConst = var_4
	var_4_26.campIndex = var_4.CampAll
	ShipIndexConst = var_4
	var_4_26.rarityIndex = var_4.RarityAll
	ShipIndexConst = var_4
	var_4_26.extraIndex = var_4.ExtraALL
	var_4_24[var_4_25] = var_4_26

	local var_4_27 = var_0_1.MODE_ADD
	local var_4_28 = {}

	ShipIndexConst = var_4
	var_4_28.sortIndex = var_4.SortLevel
	ShipIndexConst = var_4
	var_4_28.typeIndex = var_4.TypeAll
	ShipIndexConst = var_4
	var_4_28.campIndex = var_4.CampAll
	ShipIndexConst = var_4
	var_4_28.rarityIndex = var_4.RarityAll
	ShipIndexConst = var_4
	var_4_28.extraIndex = var_4.ExtraALL
	var_4_24[var_4_27] = var_4_28

	local var_4_29 = var_0_1.MODE_REMOVE
	local var_4_30 = {}

	ShipIndexConst = var_4
	var_4_30.sortIndex = var_4.SortLevel
	ShipIndexConst = var_4
	var_4_30.typeIndex = var_4.TypeAll
	ShipIndexConst = var_4
	var_4_30.campIndex = var_4.CampAll
	ShipIndexConst = var_4
	var_4_30.rarityIndex = var_4.RarityAll
	ShipIndexConst = var_4
	var_4_30.extraIndex = var_4.ExtraALL
	var_4_24[var_4_29] = var_4_30
	arg_4_0.indexDatas = var_4_24

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0.cards = {}

	function arg_5_0.scrollrect.onInitItem(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.OnItemUpdate(var_6_0, arg_6_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.OnUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	local var_5_0 = arg_5_0.scrollrect

	function var_5_0.onReturnItem(arg_8_0, arg_8_1)
		local var_8_0 = arg_5_0

		var_2.onReturnItem(var_8_0, arg_8_0, arg_8_1)

		return
	end

	onButton = var_5_0

	local var_5_1 = arg_5_0
	local var_5_2 = arg_5_0.backBtn

	local function var_5_3()
		if arg_5_0.mode ~= var_0_1.MODE_VIEW then
			local var_9_0 = arg_5_0

			var_0.Switch(var_9_0, var_0_1.MODE_VIEW)

			return
		end

		local var_9_1 = arg_5_0
		local var_9_2 = var_0.emit
		local var_9_3 = var_0_1.ON_RETURN
		local var_9_4 = {}

		NewSettingsScene = var_2_10005
		var_9_4.page = var_2_10005.PAGE_OPTION
		SettingsRandomFlagShipAndSkinPanel = var_5
		var_9_4.scroll = var_5

		var_9_2(var_9_1, var_9_3, var_9_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_1, var_5_2, var_5_3, var_1_10006)

	onButton = var_5_0

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.addBtn

	local function var_5_6()
		local var_10_0 = arg_5_0

		var_0.Switch(var_10_0, var_0_1.MODE_ADD)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_4, var_5_5, var_5_6, var_1_10006)

	onButton = var_5_0

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.removeBtn

	local function var_5_9()
		local var_11_0 = arg_5_0

		var_0.Switch(var_11_0, var_0_1.MODE_REMOVE)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_7, var_5_8, var_5_9, var_1_10006)

	onButton = var_5_0

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.cancelBtn

	local function var_5_12()
		if arg_5_0.mode == var_0_1.MODE_VIEW then
			return
		end

		local var_12_0 = arg_5_0

		var_0.Switch(var_12_0, var_0_1.MODE_VIEW)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_10, var_5_11, var_5_12, var_1_10006)

	onButton = var_5_0

	local var_5_13 = arg_5_0
	local var_5_14 = arg_5_0.confirmBtn

	local function var_5_15()
		if arg_5_0.mode == var_0_1.MODE_VIEW then
			return
		end

		local var_13_0 = arg_5_0

		var_0.OnConfirm(var_13_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_13, var_5_14, var_5_15, var_1_10006)

	onButton = var_5_0

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.allBtn

	local function var_5_18()
		if arg_5_0.mode == var_0_1.MODE_VIEW then
			return
		end

		local var_14_0 = arg_5_0

		var_0.OnAll(var_14_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_16, var_5_17, var_5_18, var_1_10006)

	onToggle = var_5_0

	local var_5_19 = arg_5_0
	local var_5_20 = arg_5_0.frequentlyUseToggle

	local function var_5_21(arg_15_0)
		arg_5_0.frequentlyUseFlags[arg_5_0.mode] = arg_15_0

		local var_15_0 = arg_5_0
		local var_15_1 = var_1.GetShipList(var_15_0, arg_5_0.mode)
		local var_15_2 = arg_5_0

		var_2.FlushShipList(var_15_2, var_15_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_19, var_5_20, var_5_21, var_1_10006)

	onToggle = var_5_0

	local var_5_22 = arg_5_0
	local var_5_23 = arg_5_0.lockToggle

	local function var_5_24(arg_16_0)
		arg_5_0.lockFlags[arg_5_0.mode] = arg_16_0

		local var_16_0 = arg_5_0
		local var_16_1 = var_1.GetShipList(var_16_0, arg_5_0.mode)
		local var_16_2 = arg_5_0

		var_2.FlushShipList(var_16_2, var_16_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_22, var_5_23, var_5_24, var_1_10006)

	onButton = var_5_0

	local var_5_25 = arg_5_0
	local var_5_26 = arg_5_0.sortBtn

	local function var_5_27()
		local var_17_0 = arg_5_0.sortFlags

		var_17_0[arg_5_0.mode] = not arg_5_0.sortFlags[arg_5_0.mode]
		setActive = var_17_0

		var_17_0(arg_5_0.sortUp, arg_5_0.sortFlags[arg_5_0.mode])

		setActive = var_17_0

		var_17_0(arg_5_0.sortDown, not arg_5_0.sortFlags[arg_5_0.mode])

		local var_17_1 = arg_5_0
		local var_17_2 = var_0.GetShipList(var_17_1, arg_5_0.mode)
		local var_17_3 = arg_5_0

		var_1.FlushShipList(var_17_3, var_17_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_25, var_5_26, var_5_27, var_1_10006)

	onButton = var_5_0

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0.indexBtn

	local function var_5_30()
		local var_18_0 = arg_5_0
		local var_18_1 = var_0.emit

		RandomDockYardMediator = var_2_10003

		var_18_1(var_18_0, var_2_10003.OPEN_INDEX, {
			OnFilter = function(arg_19_0)
				local var_19_0 = arg_5_0

				var_1.OnFilter(var_19_0, arg_19_0)

				return
			end,
			defaultIndex = arg_5_0.indexDatas[arg_5_0.mode]
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_5_0(var_5_28, var_5_29, var_5_30, var_1_10006)

	setToggleEnabled = var_5_0

	var_5_0(arg_5_0.phantomToggle, false)

	onButton = var_5_0

	local var_5_31 = arg_5_0
	local var_5_32 = arg_5_0.phantomToggle
	local var_5_33 = var_4.Find(var_5_32, "off")

	local function var_5_34()
		local var_20_0 = arg_5_0
		local var_20_1 = var_0.emit

		RandomDockYardMediator = var_2_10003

		var_20_1(var_20_0, var_2_10003.OPEN_PHANTOM_LAYER)

		return
	end

	SFX_PANEL = var_5_32

	var_5_0(var_5_31, var_5_33, var_5_34, var_5_32)
	arg_5_0:Switch(var_0_1.MODE_VIEW)

	return
end

function var_0_1.GetRandomFlagShips(arg_21_0)
	if not arg_21_0.randomFlagShips then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_21_0 = var_1(var_1_10003)
		local var_21_1 = var_1.getRawData(var_21_0)

		arg_21_0.randomFlagShips = {}
		arg_21_0.phantomCount = 0
		getProxy = var_2
		BayProxy = var_1_10004

		local var_21_2 = var_2(var_1_10004)

		ipairs = var_21_0

		for iter_21_0, iter_21_1 in var_21_0(var_21_2:getRandomFlagShipPhantomMarks()) do
			if var_21_2:GetShipPhantom(iter_21_1) then
				if var_8.phantomId == 0 then
					table = var_9

					var_9.insert(arg_21_0.randomFlagShips, var_8)
				else
					arg_21_0.phantomCount = arg_21_0.phantomCount + 1
				end
			end
		end
	end

	return arg_21_0.randomFlagShips
end

function var_0_1.GetDockYardShipAndNotInRandom(arg_22_0)
	if not arg_22_0.dockyardShips then
		local var_22_0 = arg_22_0
		local var_22_1 = arg_22_0.GetRandomFlagShips(var_22_0)
		local var_22_2 = {}

		ipairs = var_22_0

		for iter_22_0, iter_22_1 in var_22_0(var_22_1) do
			var_22_2[iter_22_1.id] = true
		end

		arg_22_0.dockyardShips = {}
		getProxy = var_3
		BayProxy = var_5

		local var_22_3 = var_3(var_5)
		local var_22_4 = var_3.getRawData(var_22_3)

		pairs = var_4

		for iter_22_2, iter_22_3 in var_4(var_22_4) do
			if not var_22_2[iter_22_3.id] and not iter_22_3:isActivityNpc() then
				table = var_9

				var_9.insert(arg_22_0.dockyardShips, iter_22_3)
			end
		end
	end

	return arg_22_0.dockyardShips
end

function var_0_1.GetShipList(arg_23_0, arg_23_1)
	local var_23_0 = {}

	if arg_23_1 == var_0_1.MODE_VIEW then
		var_23_0 = arg_23_0:GetRandomFlagShips()
	elseif arg_23_1 == var_0_1.MODE_ADD then
		var_23_0 = arg_23_0:GetDockYardShipAndNotInRandom()
	elseif arg_23_1 == var_0_1.MODE_REMOVE then
		var_23_0 = arg_23_0:GetRandomFlagShips()
	end

	return var_23_0
end

function var_0_1.Switch(arg_24_0, arg_24_1)
	arg_24_0:Clear()

	arg_24_0.selected = {}

	local var_24_0 = arg_24_0:GetShipList(arg_24_1)

	arg_24_0:UpdateModeStyle(arg_24_1, #var_24_0)

	arg_24_0.mode = arg_24_1

	arg_24_0:FlushShipList(var_24_0)

	local var_24_2

	if arg_24_0.mode == var_0_1.MODE_VIEW then
		arg_24_0:UpdateSelectedCnt(#var_24_0 + arg_24_0.phantomCount)
	else
		local var_24_1 = arg_24_0

		var_24_2 = arg_24_0.UpdateSelectedCnt
		table = var_6

		var_24_2(var_24_1, var_6.getCount(arg_24_0.selected))
	end

	setActive = var_24_2

	var_24_2(arg_24_0.phantomToggle, arg_24_0.mode == var_0_1.MODE_VIEW)

	return
end

function var_0_1.UpdateModeStyle(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.titleImg.sprite = arg_25_0.titles[arg_25_1]

	local var_25_0 = arg_25_0.titleImg

	var_3.SetNativeSize(var_25_0)

	arg_25_0.titleEnImg.sprite = arg_25_0.titleEns[arg_25_1]

	local var_25_1 = arg_25_0.titleEnImg

	var_3.SetNativeSize(var_25_1)

	setActive = var_3

	var_3(arg_25_0.addBtn, arg_25_1 == var_0_1.MODE_VIEW)

	setActive = var_3

	var_3(arg_25_0.removeBtn, arg_25_1 == var_0_1.MODE_VIEW)

	setActive = var_3

	var_3(arg_25_0.cancelBtn, arg_25_1 == var_0_1.MODE_ADD or arg_25_1 == var_0_1.MODE_REMOVE)

	setActive = var_3

	var_3(arg_25_0.confirmBtn, arg_25_1 == var_0_1.MODE_ADD or arg_25_1 == var_0_1.MODE_REMOVE)

	setActive = var_3

	var_3(arg_25_0.allBtn, arg_25_1 == var_0_1.MODE_ADD or arg_25_1 == var_0_1.MODE_REMOVE)

	arg_25_0.tipTxt.text = arg_25_0.tips[arg_25_1]

	local var_25_2 = arg_25_0.selectedTxt

	var_25_2.text = arg_25_0.selectedTxts[arg_25_1]
	setButtonEnabled = var_25_2

	var_25_2(arg_25_0.removeBtn, arg_25_1 == var_0_1.MODE_VIEW and arg_25_2 > 0)

	setAnchoredPosition = var_25_2

	var_25_2(arg_25_0.selectPanelFrame, {
		x = arg_25_1 == var_0_1.MODE_VIEW and 0 or 180
	})

	return
end

function var_0_1.OnConfirm(arg_26_0)
	local var_26_0 = {}

	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.selected) do
		table = var_1_10007

		var_1_10007.insert(var_26_0, iter_26_0)
	end

	local function var_26_1()
		if arg_26_0.mode == var_0_1.MODE_ADD then
			local var_27_0 = arg_26_0
			local var_27_1 = var_0.emit

			RandomDockYardMediator = var_2_10003

			var_27_1(var_27_0, var_2_10003.ON_ADD_SHIPS, var_26_0)
		elseif arg_26_0.mode == var_0_1.MODE_REMOVE then
			local var_27_2 = arg_26_0
			local var_27_3 = var_0.emit

			RandomDockYardMediator = var_2_10003

			var_27_3(var_27_2, var_2_10003.ON_REMOVE_SHIPS, var_26_0)
		end

		return
	end

	local var_26_2 = arg_26_0.msgBoxTitle[arg_26_0.mode]
	local var_26_3 = arg_26_0.msgBoxSubTitle[arg_26_0.mode]
	local var_26_4 = arg_26_0.msgbox

	var_5.ExecuteAction(var_26_4, "Flush", var_26_2, var_26_3, var_26_0, var_26_1)

	return
end

function var_0_1.OnAll(arg_28_0)
	ipairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(arg_28_0.displays) do
		arg_28_0.selected[iter_28_1.id] = true
	end

	local var_28_0 = arg_28_0.scrollrect

	var_1.SetTotalCount(var_28_0, #arg_28_0.displays)

	local var_28_1 = arg_28_0
	local var_28_2 = arg_28_0.UpdateSelectedCnt

	table = var_4

	var_28_2(var_28_1, var_4.getCount(arg_28_0.selected))

	return
end

function var_0_1.UpdateSelectedCnt(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.selectedCntTxt

	var_29_0.text = arg_29_1
	setButtonEnabled = var_29_0

	var_29_0(arg_29_0.confirmBtn, arg_29_1 > 0)

	setActive = var_29_0

	var_29_0(arg_29_0.confirmBtnMask, arg_29_1 <= 0)

	return
end

local function var_0_2(arg_30_0)
	local var_30_0 = arg_30_0.sortIndex

	ShipIndexConst = var_1_10002

	local var_30_5

	if var_30_0 == var_1_10002.SortLevel then
		local var_30_1 = arg_30_0.typeIndex

		ShipIndexConst = var_2

		if var_30_1 == var_2.TypeAll then
			local var_30_2 = arg_30_0.campIndex

			ShipIndexConst = var_2

			if var_30_2 == var_2.CampAll then
				local var_30_3 = arg_30_0.rarityIndex

				ShipIndexConst = var_2

				if var_30_3 == var_2.RarityAll then
					local var_30_4 = arg_30_0.extraIndex

					ShipIndexConst = var_2

					if var_30_4 == var_2.ExtraALL then
						var_30_5 = false

						goto label_30_0
					end
				end
			end
		end
	end

	var_30_5 = true

	::label_30_0::

	return var_30_5
end

function var_0_1.OnFilter(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.indexDatas[arg_31_0.mode]

	var_31_0.sortIndex = arg_31_1.sortIndex
	var_31_0.typeIndex = arg_31_1.typeIndex
	var_31_0.campIndex = arg_31_1.campIndex
	var_31_0.rarityIndex = arg_31_1.rarityIndex
	var_31_0.extraIndex = arg_31_1.extraIndex
	setActive = var_3

	var_3(arg_31_0.indexBtnSel, var_0_2(var_31_0))

	local var_31_1 = arg_31_0:GetShipList(arg_31_0.mode)

	arg_31_0:FlushShipList(var_31_1)

	return
end

function var_0_1.OnItemUpdate(arg_32_0, arg_32_1)
	RandomDockYardCard = var_1_10002

	local var_32_0 = var_1_10002.New(arg_32_1)

	onButton = var_1_10003

	local var_32_1 = arg_32_0
	local var_32_2 = var_32_0._go

	local function var_32_3()
		if arg_32_0.mode == var_0_1.MODE_VIEW then
			return
		end

		if arg_32_0.selected[var_32_0.ship.id] then
			arg_32_0.selected[var_32_0.ship.id] = nil
		else
			arg_32_0.selected[var_32_0.ship.id] = true
		end

		local var_33_0 = arg_32_0
		local var_33_1 = var_0.UpdateSelectedCnt

		table = var_2_10003

		var_33_1(var_33_0, var_2_10003.getCount(arg_32_0.selected))

		local var_33_2 = var_32_0

		var_0.UpdateSelected(var_33_2, arg_32_0.selected[var_32_0.ship.id])

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_32_1, var_32_2, var_32_3, var_1_10008)

	arg_32_0.cards[arg_32_1] = var_32_0

	return
end

function var_0_1.OnUpdateItem(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0

	if not arg_34_0.cards[arg_34_2] then
		arg_34_0:OnItemUpdate(arg_34_2)

		var_34_0 = arg_34_0.cards[arg_34_2]
	end

	local var_34_1 = arg_34_0.displays[arg_34_1 + 1]
	local var_34_2 = arg_34_0.selected[var_34_1.id]

	var_34_0:Update(var_34_1, var_34_2)

	return
end

function var_0_1.onReturnItem(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_0.exited then
		return
	end

	if arg_35_0.cards[arg_35_2] then
		var_3:Dispose()
	end

	return
end

function var_0_1.FlushShipList(arg_36_0, arg_36_1)
	arg_36_0.displays = {}

	arg_36_0:FilterShips(arg_36_1, arg_36_0.displays)
	arg_36_0:SortShips(arg_36_0.displays)

	local var_36_0 = #arg_36_0.displays
	local var_36_1 = arg_36_0.scrollrect

	var_3.SetTotalCount(var_36_1, var_36_0)

	setActive = var_3

	var_3(arg_36_0.emptyTr, var_36_0 <= 0)

	return
end

function var_0_1.FilterShips(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.lockFlags[arg_37_0.mode]
	local var_37_1 = arg_37_0.frequentlyUseFlags[arg_37_0.mode]
	local var_37_2 = arg_37_0.indexDatas[arg_37_0.mode]

	local function var_37_3(arg_38_0)
		local var_38_0

		if var_37_0 then
			var_2_10003 = arg_38_0
			var_38_0 = not not arg_38_0.IsLocked(var_2_10003)

			if false then
				var_38_0 = false
			end
		else
			var_38_0 = true
		end

		local var_38_1

		if var_37_1 then
			var_2_10004 = arg_38_0
			var_38_1 = not not arg_38_0.IsPreferenceTag(var_2_10004)

			if false then
				var_38_1 = false
			end
		else
			var_38_1 = true
		end

		ShipIndexConst = var_2_10003

		local var_38_2 = var_2_10003.filterByType(arg_38_0, var_37_2.typeIndex)

		ShipIndexConst = var_2_10004

		local var_38_3 = var_2_10004.filterByCamp(arg_38_0, var_37_2.campIndex)

		ShipIndexConst = var_5

		local var_38_4 = var_5.filterByRarity(arg_38_0, var_37_2.rarityIndex)

		ShipIndexConst = var_6

		local var_38_5 = var_6.filterByExtra(arg_38_0, var_37_2.extraIndex)

		return var_38_0 and var_38_1 and var_38_2 and var_38_3 and var_38_4 and var_38_5
	end

	ipairs = var_1_10007

	for iter_37_0, iter_37_1 in var_1_10007(arg_37_1) do
		if var_37_3(iter_37_1) then
			table = var_12

			var_12.insert(arg_37_2, iter_37_1)
		end
	end

	return
end

function var_0_1.SortShips(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.indexDatas[arg_39_0.mode]
	local var_39_1 = arg_39_0.sortFlags[arg_39_0.mode]
	local var_39_2 = var_39_0.sortIndex

	ShipIndexConst = var_1_10005

	local var_39_3, var_39_4 = var_1_10005.getSortFuncAndName(var_39_2, var_39_1)

	table = var_7

	var_7.insert(var_39_3, 1, function(arg_40_0)
		return -arg_40_0.activityNpc
	end)

	table = var_7

	local var_39_5 = var_7.sort
	local var_39_6 = arg_39_1

	CompareFuncs = var_10

	var_39_5(var_39_6, var_10(var_39_3))

	local var_39_7 = arg_39_0.sortTxt

	i18n = var_8
	var_39_7.text = var_8(var_39_4)

	return
end

function var_0_1.onBackPressed(arg_41_0)
	var_0_1.super.onBackPressed(arg_41_0)

	return
end

function var_0_1.Clear(arg_42_0)
	pairs = var_1_10001

	for iter_42_0, iter_42_1 in var_1_10001(arg_42_0.cards) do
		iter_42_1:Dispose()
	end

	arg_42_0.cards = {}

	return
end

function var_0_1.willExit(arg_43_0)
	arg_43_0.titles = nil

	if arg_43_0.msgbox then
		local var_43_0 = arg_43_0.msgbox

		var_1.Destroy(var_43_0)
	end

	arg_43_0.msgbox = nil

	return
end

return var_0_1
