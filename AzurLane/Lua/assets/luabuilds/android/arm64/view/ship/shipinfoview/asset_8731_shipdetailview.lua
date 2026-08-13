class = var_0_10000

local var_0_0 = "ShipDetailView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

require = var_0_10001

local var_0_2 = var_0_10001("view.equipment.EquipmentSortCfg")
local var_0_3 = {
	equipCampIndex = 2047,
	equipAmmoIndex2 = 3,
	typeIndex = 2047,
	extraIndex = 0,
	equipPropertyIndex = 4095,
	equipPropertyIndex2 = 4095,
	equipAmmoIndex1 = 15,
	rarityIndex = 31
}

function var_0_1.getUIName(arg_1_0)
	return "ShipDetailView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitDetail()
	arg_2_0:InitEvent()

	setParent = var_1

	var_1(arg_2_0.randomFlagToggle, arg_2_0._tf.parent)

	triggerToggle = var_1

	var_1(arg_2_0.showQuickBtn, false)

	triggerToggle = var_1

	var_1(arg_2_0.showRecordBtn, false)

	return
end

function var_0_1.InitDetail(arg_3_0)
	arg_3_0.mainPanel = arg_3_0._parentTf.parent
	arg_3_0.detailPanel = arg_3_0._tf

	local var_3_0 = arg_3_0.detailPanel

	arg_3_0.attrs = var_1.Find(var_3_0, "attrs")
	setActive = var_1

	var_1(arg_3_0.attrs, false)

	ShipDetailLogicPanel = var_1
	arg_3_0.shipDetailLogicPanel = var_1.New(arg_3_0.attrs)

	local var_3_1 = arg_3_0.shipDetailLogicPanel

	var_1.attach(var_3_1, arg_3_0)

	local var_3_2 = arg_3_0.detailPanel

	arg_3_0.equipments = var_1.Find(var_3_2, "equipments")

	local var_3_3 = arg_3_0.equipments

	arg_3_0.equipmentsGrid = var_1.Find(var_3_3, "equipments")

	local var_3_4 = arg_3_0.equipments

	arg_3_0.detailEquipmentTpl = var_1.Find(var_3_4, "equipment_tpl")

	local var_3_5 = arg_3_0.equipments

	arg_3_0.emptyGridTpl = var_1.Find(var_3_5, "empty_tpl")

	local var_3_6 = arg_3_0.equipments

	arg_3_0.showRecordBtn = var_1.Find(var_3_6, "unload_all")

	local var_3_7 = arg_3_0.equipments

	arg_3_0.showQuickBtn = var_1.Find(var_3_7, "quickButton")

	local var_3_8 = arg_3_0.equipments

	arg_3_0.showECodeShareBtn = var_1.Find(var_3_8, "shareButton")

	local var_3_9 = arg_3_0.equipments

	arg_3_0.equipCodeBtn = var_1.Find(var_3_9, "equip_code")

	local var_3_10 = arg_3_0.detailPanel

	arg_3_0.lockBtn = var_1.Find(var_3_10, "lock_btn")

	local var_3_11 = arg_3_0.detailPanel

	arg_3_0.unlockBtn = var_1.Find(var_3_11, "unlock_btn")

	local var_3_12 = arg_3_0.detailPanel

	arg_3_0.viewBtn = var_1.Find(var_3_12, "view_btn")

	local var_3_13 = arg_3_0.detailPanel

	arg_3_0.evaluationBtn = var_1.Find(var_3_13, "evaluation_btn")

	local var_3_14 = arg_3_0.detailPanel

	arg_3_0.profileBtn = var_1.Find(var_3_14, "profile_btn")

	local var_3_15 = arg_3_0.detailPanel

	arg_3_0.fashionToggle = var_1.Find(var_3_15, "fashion_toggle")

	local var_3_16 = arg_3_0.detailPanel

	arg_3_0.randomFlagToggle = var_1.Find(var_3_16, "random_flag_toggle")

	local var_3_17 = arg_3_0.fashionToggle

	arg_3_0.fashionTag = var_1.Find(var_3_17, "Tag")

	local var_3_18 = arg_3_0.detailPanel

	arg_3_0.commonTagToggle = var_1.Find(var_3_18, "common_toggle")

	local var_3_19 = arg_3_0.equipments

	arg_3_0.spWeaponSlot = var_1.Find(var_3_19, "SpSlot")

	local var_3_20 = arg_3_0.detailPanel

	arg_3_0.propertyIcons = var_1.Find(var_3_20, "attrs/attrs/property/icons")

	local var_3_21 = arg_3_0._tf

	arg_3_0.intimacyTF = var_1.Find(var_3_21, "intimacy")
	arg_3_0.updateItemTick = 0

	local var_3_22 = arg_3_0.detailPanel

	arg_3_0.quickPanel = var_1.Find(var_3_22, "quick_panel")

	local var_3_23 = arg_3_0.quickPanel

	arg_3_0.equiping = var_1.Find(var_3_23, "equiping")

	local var_3_24 = arg_3_0.quickPanel

	arg_3_0.fillter = var_1.Find(var_3_24, "fillter")

	local var_3_25 = arg_3_0.quickPanel

	arg_3_0.selectTitle = var_1.Find(var_3_25, "frame/selectTitle")

	local var_3_26 = arg_3_0.quickPanel

	arg_3_0.emptyTitle = var_1.Find(var_3_26, "frame/emptyTitle")

	local var_3_27 = arg_3_0.quickPanel
	local var_3_28 = var_1.Find(var_3_27, "frame/container/Content")

	arg_3_0.list = var_1.GetComponent(var_3_28, "LScrollRect")
	arg_3_0.indexData = {}

	arg_3_0:CloseQuickPanel()

	setText = var_1

	local var_3_29 = arg_3_0.quickPanel
	local var_3_30 = var_3.Find(var_3_29, "fillter/on/text2")

	i18n = var_4

	var_1(var_3_30, var_4("quick_equip_tip2"))

	setText = var_1

	local var_3_31 = arg_3_0.quickPanel
	local var_3_32 = var_3.Find(var_3_31, "fillter/off/text2")

	i18n = var_4

	var_1(var_3_32, var_4("quick_equip_tip2"))

	setText = var_1

	local var_3_33 = arg_3_0.quickPanel
	local var_3_34 = var_3.Find(var_3_33, "equiping/on/text2")

	i18n = var_4

	var_1(var_3_34, var_4("quick_equip_tip1"))

	setText = var_1

	local var_3_35 = arg_3_0.quickPanel
	local var_3_36 = var_3.Find(var_3_35, "equiping/off/text2")

	i18n = var_4

	var_1(var_3_36, var_4("quick_equip_tip1"))

	setText = var_1

	local var_3_37 = arg_3_0.quickPanel
	local var_3_38 = var_3.Find(var_3_37, "title/text")

	i18n = var_4

	var_1(var_3_38, var_4("quick_equip_tip3"))

	setText = var_1

	local var_3_39 = arg_3_0.quickPanel
	local var_3_40 = var_3.Find(var_3_39, "frame/emptyTitle/text")

	i18n = var_4

	var_1(var_3_40, var_4("quick_equip_tip4"))

	setText = var_1

	local var_3_41 = arg_3_0.quickPanel
	local var_3_42 = var_3.Find(var_3_41, "frame/selectTitle/text")

	i18n = var_4

	var_1(var_3_42, var_4("quick_equip_tip5"))

	setText = var_1

	local var_3_43 = arg_3_0.randomFlagToggle
	local var_3_44 = var_3.Find(var_3_43, "bg/Text")

	i18n = var_4

	var_1(var_3_44, var_4("ship_random_secretary_tag"))

	getProxy = var_1
	EquipmentProxy = var_3_44
	arg_3_0.equipmentProxy = var_1(var_3_44)

	local var_3_45 = arg_3_0.detailPanel

	arg_3_0.recordPanel = var_1.Find(var_3_45, "record_panel")

	local var_3_46 = arg_3_0.recordPanel

	arg_3_0.unloadAllBtn = var_1.Find(var_3_46, "frame/unload_all")
	_ = var_1
	arg_3_0.recordBars = var_1.map({
		1,
		2,
		3
	}, function(arg_4_0)
		local var_4_0 = arg_3_0.recordPanel
		local var_4_1 = var_1.Find(var_4_0, "frame/container")

		return var_1.GetChild(var_4_1, arg_4_0 - 1)
	end)

	local var_3_47 = {}
	local var_3_48 = arg_3_0.recordPanel

	var_3_47[1] = var_2.Find(var_3_48, "frame/container/record_1/record_btn")

	local var_3_49 = arg_3_0.recordPanel

	var_3_47[2] = var_2.Find(var_3_49, "frame/container/record_2/record_btn")

	local var_3_50 = arg_3_0.recordPanel

	var_3_47[3] = var_2.Find(var_3_50, "frame/container/record_3/record_btn")
	arg_3_0.recordBtns = var_3_47

	local var_3_51 = {}
	local var_3_52 = arg_3_0.recordPanel

	var_3_51[1] = var_2.Find(var_3_52, "frame/container/record_1/equipments")

	local var_3_53 = arg_3_0.recordPanel

	var_3_51[2] = var_2.Find(var_3_53, "frame/container/record_2/equipments")

	local var_3_54 = arg_3_0.recordPanel

	var_3_51[3] = var_2.Find(var_3_54, "frame/container/record_3/equipments")
	arg_3_0.recordEquipmentsTFs = var_3_51

	local var_3_55 = {}
	local var_3_56 = arg_3_0.recordPanel

	var_3_55[1] = var_2.Find(var_3_56, "frame/container/record_1/equip_btn")

	local var_3_57 = arg_3_0.recordPanel

	var_3_55[2] = var_2.Find(var_3_57, "frame/container/record_2/equip_btn")

	local var_3_58 = arg_3_0.recordPanel

	var_3_55[3] = var_2.Find(var_3_58, "frame/container/record_3/equip_btn")
	arg_3_0.equipRecordBtns = var_3_55
	RecordableSearchBar = var_3_55

	local var_3_59 = var_3_55.New

	RecordableSearchBar = var_3

	local var_3_60 = var_3.CreateData
	local var_3_61 = {
		uiName = "RecordableSearchBarUI4ShipDetailView"
	}

	i18n = var_6
	var_3_61.holder = var_6("search_equipment")

	function var_3_61.onInputChanged()
		local var_5_0 = arg_3_0

		var_0.updateQuickPanel(var_5_0, true)

		return
	end

	var_3_61.key = arg_3_0.__cname
	var_3_61.parent = arg_3_0.quickPanel
	Vector3 = var_6
	var_3_61.anchoredPosition = var_6(-623, -34, 0)
	arg_3_0.searchBar = var_3_59(var_3_60(var_3_61))
	setActive = var_1

	var_1(arg_3_0.detailPanel, true)

	setActive = var_1

	var_1(arg_3_0.attrs, true)

	setActive = var_1

	var_1(arg_3_0.recordPanel, false)

	setActive = var_1

	var_1(arg_3_0.detailEquipmentTpl, false)

	setActive = var_1

	var_1(arg_3_0.emptyGridTpl, false)

	setActive = var_1

	var_1(arg_3_0.detailPanel, true)

	arg_3_0.onSelected = false
	PLATFORM_CODE = var_1
	PLATFORM_CHT = var_2

	if var_1 == var_2 then
		LOCK_SP_WEAPON = var_1

		if var_1 then
			setActive = var_1

			var_1(arg_3_0.showRecordBtn, false)

			setActive = var_1

			var_1(arg_3_0.showQuickBtn, false)

			setActive = var_1

			var_1(arg_3_0.spWeaponSlot, false)

			local var_3_62 = arg_3_0.equipments

			arg_3_0.showRecordBtn = var_1.Find(var_3_62, "unload_all_2")

			local var_3_63 = arg_3_0.equipments

			arg_3_0.showQuickBtn = var_1.Find(var_3_63, "quickButton_2")
			setActive = var_1

			var_1(arg_3_0.showRecordBtn, true)

			setActive = var_1

			var_1(arg_3_0.showQuickBtn, true)
		end
	end

	return
end

function var_0_1.InitEvent(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.fashionToggle

	local function var_6_2()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		ShipViewConst = var_2_10003

		local var_7_2 = var_2_10003.SWITCH_TO_PAGE

		ShipViewConst = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.PAGE.FASHION)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_6_0, arg_6_0.propertyIcons, function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		pg = var_2_10004
		var_8_2.helps = var_2_10004.gametip.help_shipinfo_attr.tip

		function var_8_2.onClose()
			return
		end

		var_8_1(var_8_0, var_8_2)

		return
	end)

	onToggle = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.commonTagToggle

	local function var_6_5(arg_10_0)
		local var_10_0 = arg_6_0
		local var_10_1 = var_1.GetShipVO(var_10_0).preferenceTag

		Ship = var_2_10002

		if var_10_1 == var_2_10002.PREFERENCE_TAG_COMMON ~= arg_10_0 then
			Ship = var_10_0

			local var_10_2

			if var_10_1 == var_10_0.PREFERENCE_TAG_COMMON then
				Ship = var_3
				var_10_2 = var_3.PREFERENCE_TAG_NONE
			else
				Ship = var_3
				var_10_2 = var_3.PREFERENCE_TAG_COMMON
			end

			local var_10_3 = arg_6_0
			local var_10_4 = var_3.emit

			ShipMainMediator = var_2_10006

			local var_10_5 = var_2_10006.ON_TAG
			local var_10_6 = arg_6_0

			var_10_4(var_10_3, var_10_5, var_7.GetShipVO(var_10_6).id, var_10_2)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	onToggle = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.randomFlagToggle

	local function var_6_8(arg_11_0)
		local var_11_0 = arg_6_0
		local var_11_1 = var_1.GetShipVO(var_11_0)

		if var_1.getRandomFlag(var_11_1) ~= arg_11_0 then
			local var_11_2 = arg_6_0
			local var_11_3 = var_2.emit

			ShipMainMediator = var_2_10005

			local var_11_4 = var_2_10005.CHANGE_RANDOM_FLAG
			local var_11_5 = arg_6_0
			local var_11_6 = var_6.GetShipVO(var_11_5)

			var_11_3(var_11_2, var_11_4, var_6.GetShipPhantomMark(var_11_6), arg_11_0)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10006)

	onButton = var_1_10001

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.lockBtn

	local function var_6_11()
		local var_12_0 = arg_6_0
		local var_12_1 = var_0.emit

		ShipMainMediator = var_2_10003

		local var_12_2 = var_2_10003.ON_LOCK
		local var_12_3 = {}
		local var_12_4 = arg_6_0

		var_12_3[1] = var_5.GetShipVO(var_12_4).id

		local var_12_5 = arg_6_0

		var_12_1(var_12_0, var_12_2, var_12_3, var_5.GetShipVO(var_12_5).LOCK_STATE_LOCK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_9, var_6_10, var_6_11, var_1_10006)

	onButton = var_1_10001

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.unlockBtn

	local function var_6_14()
		local var_13_0 = arg_6_0
		local var_13_1 = var_0.emit

		ShipMainMediator = var_2_10003

		local var_13_2 = var_2_10003.ON_LOCK
		local var_13_3 = {}
		local var_13_4 = arg_6_0

		var_13_3[1] = var_5.GetShipVO(var_13_4).id

		local var_13_5 = arg_6_0

		var_13_1(var_13_0, var_13_2, var_13_3, var_5.GetShipVO(var_13_5).LOCK_STATE_UNLOCK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_12, var_6_13, var_6_14, var_1_10006)

	onButton = var_1_10001

	local var_6_15 = arg_6_0
	local var_6_16 = arg_6_0.viewBtn

	local function var_6_17()
		Input = var_2_10000
		var_2_10000.multiTouchEnabled = true

		local var_14_0 = arg_6_0
		local var_14_1 = var_0.emit

		ShipViewConst = var_2_10003

		var_14_1(var_14_0, var_2_10003.PAINT_VIEW, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_15, var_6_16, var_6_17, var_1_10006)

	onButton = var_1_10001

	local var_6_18 = arg_6_0
	local var_6_19 = arg_6_0.evaluationBtn

	local function var_6_20()
		local var_15_0 = arg_6_0
		local var_15_1 = var_0.emit

		ShipMainMediator = var_2_10003

		local var_15_2 = var_2_10003.OPEN_EVALUATION
		local var_15_3 = arg_6_0
		local var_15_4 = var_4.GetShipVO(var_15_3)
		local var_15_5 = var_4.getGroupId(var_15_4)
		local var_15_6 = arg_6_0
		local var_15_7 = var_5.GetShipVO(var_15_6)

		var_15_1(var_15_0, var_15_2, var_15_5, var_5.isActivityNpc(var_15_7))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_18, var_6_19, var_6_20, var_1_10006)

	onButton = var_1_10001

	local var_6_21 = arg_6_0
	local var_6_22 = arg_6_0.profileBtn

	local function var_6_23()
		local var_16_0 = arg_6_0
		local var_16_1 = var_0.emit

		ShipMainMediator = var_2_10003

		local var_16_2 = var_2_10003.OPEN_SHIPPROFILE
		local var_16_3 = arg_6_0
		local var_16_4 = var_4.GetShipVO(var_16_3)
		local var_16_5 = var_4.getGroupId(var_16_4)
		local var_16_6 = arg_6_0
		local var_16_7 = var_5.GetShipVO(var_16_6)

		var_16_1(var_16_0, var_16_2, var_16_5, var_5.isRemoulded(var_16_7))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_21, var_6_22, var_6_23, var_1_10006)

	onButton = var_1_10001

	var_1_10001(arg_6_0, arg_6_0.intimacyTF, function()
		local var_17_0 = arg_6_0
		local var_17_1 = var_0.GetShipVO(var_17_0)
		local var_17_3

		if var_0.isActivityNpc(var_17_1) then
			pg = var_17_3

			local var_17_2 = var_17_3.TipsMgr.GetInstance()

			var_17_3 = var_17_3.ShowTips
			i18n = var_2_10003

			var_17_3(var_17_2, var_2_10003("npc_propse_tip"))

			return
		end

		LOCK_PROPOSE = var_17_3

		if var_17_3 then
			return
		end

		local var_17_4 = arg_6_0
		local var_17_5 = var_0.emit

		ShipMainMediator = var_2_10003

		local var_17_6 = var_2_10003.PROPOSE
		local var_17_7 = arg_6_0

		var_17_5(var_17_4, var_17_6, var_4.GetShipVO(var_17_7).id, function()
			return
		end)

		return
	end)

	onToggle = var_1_10001

	local var_6_24 = arg_6_0
	local var_6_25 = arg_6_0.showRecordBtn

	local function var_6_26(arg_19_0)
		ShipStatus = var_2_10001

		local var_19_0 = var_2_10001.ShipStatusCheck
		local var_19_1 = "onModify"
		local var_19_2 = arg_6_0
		local var_19_3, var_19_4 = var_19_0(var_19_1, var_4.GetShipVO(var_19_2))

		if not var_19_3 then
			if arg_19_0 then
				pg = var_19_1

				local var_19_5 = var_19_1.TipsMgr.GetInstance()

				var_3.ShowTips(var_19_5, var_19_4)

				onNextTick = var_3

				var_3(function()
					triggerToggle = var_3_10000

					var_3_10000(arg_6_0.showRecordBtn, false)

					return
				end)
			end

			return
		end

		if arg_19_0 then
			local var_19_6 = arg_6_0

			var_3.displayRecordPanel(var_19_6)

			if arg_6_0.isShowQuick then
				triggerToggle = var_3

				var_3(arg_6_0.showQuickBtn, false)
			end
		else
			local var_19_7 = arg_6_0

			var_3.CloseRecordPanel(var_19_7, true)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_24, var_6_25, var_6_26, var_1_10006)

	onToggle = var_1_10001

	local var_6_27 = arg_6_0
	local var_6_28 = arg_6_0.showQuickBtn

	local function var_6_29(arg_21_0)
		ShipStatus = var_2_10001

		local var_21_0 = var_2_10001.ShipStatusCheck
		local var_21_1 = "onModify"
		local var_21_2 = arg_6_0
		local var_21_3, var_21_4 = var_21_0(var_21_1, var_4.GetShipVO(var_21_2))

		if not var_21_3 then
			if arg_21_0 then
				pg = var_21_1

				local var_21_5 = var_21_1.TipsMgr.GetInstance()

				var_3.ShowTips(var_21_5, var_21_4)

				onNextTick = var_3

				var_3(function()
					triggerToggle = var_3_10000

					var_3_10000(arg_6_0.showQuickBtn, false)

					return
				end)
			end

			local var_21_6 = arg_6_0

			var_3.CloseRecordPanel(var_21_6, true)

			local var_21_7 = arg_6_0

			var_3.CloseQuickPanel(var_21_7)

			return
		end

		if arg_21_0 then
			local var_21_8 = arg_6_0

			var_3.displayQuickPanel(var_21_8)

			if arg_6_0.selectedEquip then
				local var_21_9 = arg_6_0

				var_3.selectedEquipItem(var_21_9, arg_6_0.selectedEquip.index)
			else
				local var_21_10 = arg_6_0

				var_3.quickSelectEmpty(var_21_10)
			end

			if arg_6_0.isShowRecord then
				triggerToggle = var_3

				var_3(arg_6_0.showRecordBtn, false)
			end
		else
			local var_21_11 = arg_6_0

			var_3.CloseQuickPanel(var_21_11)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_27, var_6_28, var_6_29, var_1_10006)

	onButton = var_1_10001

	local var_6_30 = arg_6_0
	local var_6_31 = arg_6_0.equipCodeBtn

	local function var_6_32()
		local var_23_0 = arg_6_0
		local var_23_1 = var_0.emit

		ShipMainMediator = var_2_10003

		var_23_1(var_23_0, var_2_10003.OPEN_EQUIP_CODE, {})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_30, var_6_31, var_6_32, var_1_10006)

	onButton = var_1_10001

	local var_6_33 = arg_6_0
	local var_6_34 = arg_6_0.showECodeShareBtn

	local function var_6_35()
		local var_24_0 = arg_6_0
		local var_24_1 = var_0.GetShipVO(var_24_0)
		local var_24_2 = arg_6_0
		local var_24_3 = var_1.emit

		ShipMainMediator = var_2_10004

		var_24_3(var_24_2, var_2_10004.OPEN_EQUIP_CODE_SHARE, var_24_1.id, var_24_1:getGroupId())

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_33, var_6_34, var_6_35, var_1_10006)

	onButton = var_1_10001

	local var_6_36 = arg_6_0
	local var_6_37 = arg_6_0.unloadAllBtn

	local function var_6_38()
		ShipStatus = var_2_10000

		local var_25_0 = var_2_10000.ShipStatusCheck
		local var_25_1 = "onModify"
		local var_25_2 = arg_6_0
		local var_25_3, var_25_4 = var_25_0(var_25_1, var_3.GetShipVO(var_25_2))

		if not var_25_3 then
			pg = var_25_1

			local var_25_5 = var_25_1.TipsMgr.GetInstance()

			var_25_1.ShowTips(var_25_5, var_25_4)
		else
			pg = var_25_1

			local var_25_6 = var_25_1.MsgboxMgr.GetInstance()
			local var_25_7 = var_2.ShowMsgBox
			local var_25_8 = {}

			i18n = var_2_10006
			var_25_8.content = var_2_10006("ship_unequip_all_tip")

			function var_25_8.onYes()
				local var_26_0 = arg_6_0
				local var_26_1 = var_0.emit

				ShipMainMediator = var_3_10003

				local var_26_2 = var_3_10003.UNEQUIP_FROM_SHIP_ALL
				local var_26_3 = arg_6_0

				var_26_1(var_26_0, var_26_2, var_4.GetShipVO(var_26_3).id)

				return
			end

			var_25_7(var_25_6, var_25_8)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_36, var_6_37, var_6_38, var_1_10006)

	function arg_6_0.list.onInitItem(arg_27_0)
		ClearTweenItemAlphaAndWhite = var_2_10001

		var_2_10001(arg_27_0)

		return
	end

	function arg_6_0.list.onReturnItem(arg_28_0, arg_28_1)
		ClearTweenItemAlphaAndWhite = var_2_10002

		var_2_10002(arg_28_1)

		return
	end

	local var_6_39 = arg_6_0.list

	function var_6_39.onUpdateItem(arg_29_0, arg_29_1)
		setActive = var_2_10002
		findTF = var_2_10004
		tf = var_2_10006

		var_2_10002(var_2_10004(var_2_10006(arg_29_1), "IconTpl/icon_bg/icon"), false)

		TweenItemAlphaAndWhite = var_2_10002

		var_2_10002(arg_29_1)

		local var_29_0, var_29_2

		if arg_29_0 == 0 and not arg_6_0.selectedEquip.empty then
			setActive = var_2_10002
			findTF = var_29_0
			tf = var_29_2

			var_2_10002(var_29_0(var_29_2(arg_29_1), "unEquip"), true)

			setActive = var_2_10002
			findTF = var_29_0
			tf = var_29_2

			var_2_10002(var_29_0(var_29_2(arg_29_1), "bg"), false)

			setActive = var_2_10002
			findTF = var_29_0
			tf = var_29_2

			var_2_10002(var_29_0(var_29_2(arg_29_1), "IconTpl"), false)

			onButton = var_2_10002
			var_29_0 = arg_6_0
			tf = var_5

			local var_29_1 = var_5(arg_29_1)

			function var_29_2()
				local var_30_0 = arg_6_0.selectedEquip.index
				local var_30_1 = arg_6_0
				local var_30_2 = var_1.GetShipVO(var_30_1)
				local var_30_3 = var_1.getEquip(var_30_2, arg_6_0.selectedEquip.index)
				local var_30_4 = var_2.getConfig(var_30_3, "name")
				local var_30_5 = var_1:getName()
				local var_30_6 = arg_6_0
				local var_30_7 = var_5.emit

				ShipMainMediator = var_3_10008

				var_30_7(var_30_6, var_3_10008.UNEQUIP_FROM_SHIP, {
					shipId = var_1.id,
					pos = var_30_0
				})

				return
			end

			SFX_PANEL = var_7

			var_2_10002(var_29_0, var_29_1, var_29_2, var_7)
		else
			setActive = var_2_10002
			findTF = var_29_0
			tf = var_29_2

			var_2_10002(var_29_0(var_29_2(arg_29_1), "unEquip"), false)

			setActive = var_2_10002
			findTF = var_4
			tf = var_6

			var_2_10002(var_4(var_6(arg_29_1), "bg"), true)

			setActive = var_2_10002
			findTF = var_4
			tf = var_6

			var_2_10002(var_4(var_6(arg_29_1), "IconTpl"), true)

			local var_29_3

			if not arg_6_0.selectedEquip.empty or not (arg_29_0 + 1) then
				var_29_3 = arg_29_0
			end

			if not arg_6_0.fillterEquipments[var_29_3] then
				return
			end

			setActive = var_4
			findTF = var_6
			tf = var_8

			var_4(var_6(var_8(arg_29_1), "IconTpl/icon_bg/icon"), true)

			updateEquipment = var_4
			findTF = var_6
			tf = var_8

			var_4(var_6(var_8(arg_29_1), "IconTpl"), var_3)

			local var_29_4, var_29_5

			if var_3.shipId then
				getProxy = var_29_5
				BayProxy = var_29_4
				var_29_4 = var_29_5(var_29_4)
				var_29_5 = var_29_5.getShipById(var_29_4, var_3.shipId)
				setImageSprite = var_5
				findTF = var_7
				tf = var_9

				local var_29_6 = var_7(var_9(arg_29_1), "IconTpl/icon_bg/equip_flag/Image")

				LoadSprite = var_8

				var_5(var_29_6, var_8("qicon/" .. var_29_5:getPainting()))
			end

			setActive = var_29_5
			findTF = var_29_4
			tf = var_8

			local var_29_7 = var_29_4(var_8(arg_29_1), "IconTpl/icon_bg/equip_flag")
			local var_29_9

			if var_3.shipId then
				local var_29_8 = var_3.shipId

				var_29_9 = 0 < var_29_8
			end

			var_29_5(var_29_7, var_29_9)

			setActive = var_29_5
			findTF = var_29_7
			tf = var_8

			var_29_5(var_29_7(var_8(arg_29_1), "IconTpl/mask"), var_3.mask)

			onButton = var_29_5

			local var_29_10 = arg_6_0

			tf = var_7

			local var_29_11 = var_7(arg_29_1)

			local function var_29_12()
				if var_0.mask then
					return
				end

				local var_31_0 = arg_6_0

				var_0.changeEquip(var_31_0, var_0)

				return
			end

			SFX_PANEL = var_9

			var_29_5(var_29_10, var_29_11, var_29_12, var_9)
		end

		return
	end

	onToggle = var_6_39

	local var_6_40 = arg_6_0
	local var_6_41 = arg_6_0.equiping

	local function var_6_42(arg_32_0)
		arg_6_0.equipingFlag = arg_32_0

		if arg_6_0.selectedEquip then
			local var_32_0 = arg_6_0

			var_1.updateQuickPanel(var_32_0, true)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_6_39(var_6_40, var_6_41, var_6_42, var_1_10006)

	triggerToggle = var_6_39

	var_6_39(arg_6_0.equiping, true)

	onButton = var_6_39

	local var_6_43 = arg_6_0
	local var_6_44 = arg_6_0.fillter

	local function var_6_45()
		local var_33_0 = arg_6_0
		local var_33_1

		if not arg_6_0.indexData then
			var_33_1 = {}
		end

		var_33_0.indexData = var_33_1

		local var_33_2

		if not var_0_1.EQUIPMENT_INDEX then
			var_33_2 = var_0_1
			Clone = var_33_1
			StoreHouseConst = var_2_10003
			var_33_2.EQUIPMENT_INDEX = var_33_1(var_2_10003.EQUIPMENT_INDEX_COMMON)
			table = var_33_2
			var_33_2 = var_33_2.removebyvalue

			local var_33_3 = var_0_1.EQUIPMENT_INDEX.customPanels.extraIndex.options

			IndexConst = var_2_10003

			var_33_2(var_33_3, var_2_10003.EquipmentExtraEquiping)

			table = var_33_2

			var_33_2.removebyvalue(var_0_1.EQUIPMENT_INDEX.customPanels.extraIndex.names, "index_equip")
		end

		setmetatable = var_33_2

		local var_33_4 = {}

		Clone = var_2_10003
		var_33_4.indexDatas = var_2_10003(arg_6_0.indexData)

		function var_33_4.callback(arg_34_0)
			arg_6_0.indexData.typeIndex = arg_34_0.typeIndex
			arg_6_0.indexData.equipPropertyIndex = arg_34_0.equipPropertyIndex
			arg_6_0.indexData.equipPropertyIndex2 = arg_34_0.equipPropertyIndex2
			arg_6_0.indexData.equipAmmoIndex1 = arg_34_0.equipAmmoIndex1
			arg_6_0.indexData.equipAmmoIndex2 = arg_34_0.equipAmmoIndex2
			arg_6_0.indexData.equipCampIndex = arg_34_0.equipCampIndex
			arg_6_0.indexData.rarityIndex = arg_34_0.rarityIndex

			local var_34_0 = arg_6_0.indexData

			var_34_0.extraIndex = arg_34_0.extraIndex
			underscore = var_34_0

			local var_34_1 = var_34_0(arg_6_0.indexData)
			local var_34_2 = var_1.chain(var_34_1)
			local var_34_3 = var_1.keys(var_34_2)
			local var_34_4 = var_1.all(var_34_3, function(arg_35_0)
				return arg_6_0.indexData[arg_35_0] == var_0_1.EQUIPMENT_INDEX.customPanels[arg_35_0].options[1]
			end)
			local var_34_5 = var_1.value(var_34_4)

			setActive = var_2
			findTF = var_4

			var_2(var_4(arg_6_0.fillter, "on"), not var_34_5)

			setActive = var_2
			findTF = var_4

			var_2(var_4(arg_6_0.fillter, "off"), var_34_5)

			local var_34_6 = arg_6_0

			var_2.updateQuickPanel(var_34_6, true)

			return
		end

		local var_33_5 = var_33_2(var_33_4, {
			__index = var_0_1.EQUIPMENT_INDEX
		})
		local var_33_6 = arg_6_0
		local var_33_7 = var_1.emit

		ShipMainMediator = var_4

		var_33_7(var_33_6, var_4.OPEN_EQUIPMENT_INDEX, var_33_5)

		return
	end

	SFX_PANEL = var_1_10006

	var_6_39(var_6_43, var_6_44, var_6_45, var_1_10006)

	return
end

function var_0_1.changeEquip(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.selectedEquip.index
	local var_36_1 = arg_36_0
	local var_36_2 = arg_36_0.GetShipVO(var_36_1)
	local var_36_3 = {
		quickFlag = true
	}

	EquipmentInfoMediator = var_36_1
	var_36_3.type = var_36_1.TYPE_REPLACE
	var_36_3.equipmentId = arg_36_1.id
	var_36_3.shipId = var_36_2.id
	var_36_3.pos = var_36_0
	var_36_3.oldShipId = arg_36_1.shipId
	var_36_3.oldPos = arg_36_1.shipPos

	if var_36_3 then
		PlayerPrefs = var_5

		if var_5.GetInt("QUICK_CHANGE_EQUIP", 1) == 1 then
			local var_36_4 = arg_36_0
			local var_36_5 = arg_36_0.emit

			BaseUI = var_8

			var_36_5(var_36_4, var_8.ON_EQUIPMENT, var_36_3)
		else
			local var_36_6 = var_36_2
			local var_36_7, var_36_8 = var_36_2.canEquipAtPos(var_36_6, arg_36_1, var_36_0)
			local var_36_9

			if not var_36_7 then
				pg = var_36_6
				var_36_9 = var_36_6.TipsMgr.GetInstance()

				local var_36_10 = var_7.ShowTips

				i18n = var_1_10010

				var_36_10(var_36_9, var_1_10010("equipment_equipmentInfoLayer_error_canNotEquip", var_36_8))

				return
			end

			if arg_36_1.shipId then
				getProxy = var_7
				BayProxy = var_36_9
				var_1_10010 = var_7(var_36_9)

				local var_36_11 = var_7.getShipById(var_1_10010, arg_36_1.shipId)

				ShipStatus = var_36_9

				local var_36_12

				var_36_12, var_1_10010 = var_36_9.ShipStatusCheck("onModify", var_36_11)

				if not var_36_12 then
					pg = var_11

					local var_36_13 = var_11.TipsMgr.GetInstance()

					var_11.ShowTips(var_36_13, var_1_10010)
				else
					local var_36_14 = arg_36_0
					local var_36_15 = arg_36_0.emit

					ShipMainMediator = var_1_10014

					local var_36_16 = var_1_10014.EQUIP_CHANGE_NOTICE
					local var_36_17 = {}

					GAME = var_1_10016
					var_36_17.notice = var_1_10016.EQUIP_FROM_SHIP
					var_36_17.data = var_36_3

					var_36_15(var_36_14, var_36_16, var_36_17)
				end
			else
				local var_36_18 = arg_36_0
				local var_36_19 = arg_36_0.emit

				ShipMainMediator = var_1_10010

				local var_36_20 = var_1_10010.EQUIP_CHANGE_NOTICE
				local var_36_21 = {}

				GAME = var_1_10012
				var_36_21.notice = var_1_10012.EQUIP_TO_SHIP
				var_36_21.data = var_36_3

				var_36_19(var_36_18, var_36_20, var_36_21)
			end
		end
	end

	return
end

function var_0_1.SetShareData(arg_37_0, arg_37_1)
	arg_37_0.shareData = arg_37_1

	return
end

function var_0_1.GetShipVO(arg_38_0)
	if arg_38_0.shareData and arg_38_0.shareData.shipVO then
		return arg_38_0.shareData.shipVO
	end

	return nil
end

function var_0_1.OnSelected(arg_39_0, arg_39_1)
	if arg_39_1 then
		local var_39_0 = arg_39_0
		local var_39_1 = arg_39_0.OverlayPanel
		local var_39_2 = arg_39_0._parentTf
		local var_39_3 = {}
		local var_39_4 = {}
		local var_39_5 = arg_39_0.detailPanel

		var_39_4[1] = var_8.Find(var_39_5, "attrs")

		local var_39_6 = arg_39_0.detailPanel

		var_39_4[2] = var_8.Find(var_39_6, "equipments")

		local var_39_7 = arg_39_0.detailPanel

		var_39_4[3] = var_8.Find(var_39_7, "quick_panel")
		var_39_3.pbList = var_39_4
		LayerWeightConst = var_39_4
		var_39_3.overlayType = var_39_4.OVERLAY_UI_ADAPT

		var_39_1(var_39_0, var_39_2, var_39_3)
	else
		arg_39_0:UnOverlayPanel(arg_39_0._parentTf, arg_39_0.mainPanel)
	end

	arg_39_0.onSelected = arg_39_1

	if arg_39_0.onSelected and arg_39_0.selectedEquip then
		local var_39_8 = arg_39_0.selectedEquip.index

		arg_39_0:selectedEquipItem(nil)
		arg_39_0:selectedEquipItem(var_39_8)
	end

	return
end

function var_0_1.UpdateUI(arg_40_0)
	local var_40_0 = arg_40_0.searchBar

	var_1.ClearInputText(var_40_0)

	local var_40_1 = arg_40_0:GetShipVO()

	arg_40_0:UpdateIntimacy(var_40_1)
	arg_40_0:UpdateDetail(var_40_1)
	arg_40_0:UpdateEquipments(var_40_1)
	arg_40_0:UpdateLock()
	arg_40_0:UpdatePreferenceTag()

	arg_40_0.activeRandomFlag = not var_40_1:isActivityNpc()
	setActive = var_2

	var_2(arg_40_0.randomFlagToggle, arg_40_0.activeRandomFlag)

	triggerToggle = var_2

	var_2(arg_40_0.randomFlagToggle, var_40_1:getRandomFlag())

	return
end

function var_0_1.UpdateIntimacy(arg_41_0, arg_41_1)
	setActive = var_1_10002

	local var_41_0 = arg_41_0.intimacyTF

	LOCK_PROPOSE = var_1_10005

	var_1_10002(var_41_0, not var_1_10005)

	setIntimacyIcon = var_1_10002

	var_1_10002(arg_41_0.intimacyTF, arg_41_1:getIntimacyIcon())

	return
end

function var_0_1.UpdateDetail(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.shipDetailLogicPanel

	var_2.flush(var_42_0, arg_42_1)

	local var_42_1 = arg_42_0.shipDetailLogicPanel.attrs
	local var_42_2 = var_2.Find(var_42_1, "icons/hunting_range/bg")

	removeOnButton = var_1_10003

	var_1_10003(var_42_2)

	table = var_1_10003

	local var_42_3 = var_1_10003.contains

	ShipType = var_5

	local var_42_4 = var_5.SubShipType
	local var_42_5 = arg_42_1

	if var_42_3(var_42_4, arg_42_1.getShipType(var_42_5)) then
		onButton = var_3

		local var_42_6 = arg_42_0
		local var_42_7 = var_42_2

		local function var_42_8()
			local var_43_0 = arg_42_0
			local var_43_1 = var_0.emit

			ShipViewConst = var_2_10003

			var_43_1(var_43_0, var_2_10003.DISPLAY_HUNTING_RANGE, true)

			return
		end

		SFX_PANEL = var_42_5

		var_3(var_42_6, var_42_7, var_42_8, var_42_5)
	end

	HXSet = var_3

	if not var_3.isHxSkin() then
		setActive = var_3

		local var_42_9 = arg_42_0.fashionToggle
		local var_42_10 = arg_42_0.shareData

		var_3(var_42_9, var_6.HasFashion(var_42_10))
	else
		setActive = var_3

		var_3(arg_42_0.fashionToggle, false)
	end

	arg_42_0:UpdateFashionTag()

	setActive = var_3

	var_3(arg_42_0.profileBtn, not arg_42_1:isActivityNpc())

	return
end

function var_0_1.UpdateFashionTag(arg_44_0)
	local var_44_0 = arg_44_0:GetShipVO()

	setActive = var_1_10002

	local var_44_1 = arg_44_0.fashionTag

	PaintingGroupConst = var_1_10005

	var_1_10002(var_44_1, #var_1_10005.GetPaintingNameListByShipVO(var_44_0) > 0)

	return
end

function var_0_1.UpdateEquipments(arg_45_0, arg_45_1)
	arg_45_0:clearListener()

	removeAllChildren = var_2

	var_2(arg_45_0.equipmentsGrid)

	local var_45_0 = arg_45_1:getActiveEquipments()

	arg_45_0.equipItems = {}
	ipairs = var_3

	for iter_45_0, iter_45_1 in var_3(arg_45_1.equipments) do
		local var_45_1 = var_45_0[iter_45_0]
		local var_45_2
		local var_45_3 = iter_45_0
		local var_45_4

		if iter_45_1 then
			cloneTplTo = var_1_10012
			var_45_2 = var_1_10012(arg_45_0.detailEquipmentTpl, arg_45_0.equipmentsGrid)
			var_45_4 = {
				empty = false,
				tf = var_45_2,
				index = var_45_3
			}
			table = var_1_10012

			var_1_10012.insert(arg_45_0.equipItems, var_45_4)

			updateEquipment = var_1_10012

			var_1_10012(var_45_2:Find("IconTpl"), iter_45_1)

			onButton = var_1_10012

			local var_45_5 = arg_45_0

			var_1_10015 = var_45_2

			local function var_45_6()
				if arg_45_0.isShowQuick then
					local var_46_0 = arg_45_0

					var_0.selectedEquipItem(var_46_0, var_45_3)
				else
					local var_46_1 = arg_45_0
					local var_46_2 = var_0.emit

					BaseUI = var_2_10003

					local var_46_3 = var_2_10003.ON_EQUIPMENT
					local var_46_4 = {}

					EquipmentInfoMediator = var_2_10005
					var_46_4.type = var_2_10005.TYPE_SHIP

					local var_46_5 = arg_45_0

					var_46_4.shipId = var_5.GetShipVO(var_46_5).id
					var_46_4.pos = iter_45_0

					var_46_2(var_46_1, var_46_3, var_46_4)
				end

				return
			end

			SFX_UI_DOCKYARD_EQUIPADD = var_1_10017

			var_1_10012(var_45_5, var_1_10015, var_45_6, var_1_10017)
		else
			cloneTplTo = var_1_10012
			var_45_2 = var_1_10012(arg_45_0.emptyGridTpl, arg_45_0.equipmentsGrid)
			var_45_4 = {
				empty = true,
				tf = var_45_2,
				index = var_45_3
			}
			table = var_1_10012

			var_1_10012.insert(arg_45_0.equipItems, var_45_4)

			onButton = var_1_10012

			local var_45_7 = arg_45_0

			var_1_10015 = var_45_2

			local function var_45_8()
				if arg_45_0.isShowQuick then
					local var_47_0 = arg_45_0

					var_0.selectedEquipItem(var_47_0, var_45_3)
				else
					local var_47_1 = arg_45_0
					local var_47_2 = var_0.emit

					ShipViewConst = var_2_10003

					local var_47_3 = var_2_10003.SWITCH_TO_PAGE

					ShipViewConst = var_2_10004

					var_47_2(var_47_1, var_47_3, var_2_10004.PAGE.EQUIPMENT)
				end

				return
			end

			SFX_UI_DOCKYARD_EQUIPADD = var_1_10017

			var_1_10012(var_45_7, var_1_10015, var_45_8, var_1_10017)
		end

		GetOrAddComponent = var_1_10012

		local var_45_9 = var_45_2

		typeof = var_1_10015
		EventTriggerListener = var_1_10017
		var_1_10015 = var_1_10012(var_45_9, var_1_10015(var_1_10017))

		var_1_10012.AddPointDownFunc(var_1_10015, function()
			if var_45_2 and not arg_45_0.isShowQuick then
				LeanTween = var_0

				local var_48_0 = var_0.delayedCall

				go = var_2_10002

				local var_48_1 = var_2_10002(var_45_2)
				local var_48_2 = 1

				System = var_4

				var_48_0(var_48_1, var_48_2, var_4.Action(function()
					local var_49_0 = arg_45_0

					var_49_0.selectedEquip = var_45_4
					triggerToggle = var_49_0

					var_49_0(arg_45_0.showQuickBtn, true)

					return
				end))
			end

			return
		end)

		var_1_10015 = var_1_10012

		var_1_10012.AddPointUpFunc(var_1_10015, function()
			if var_45_2 then
				LeanTween = var_0

				local var_50_0 = var_0.isTweening

				go = var_2_10002

				if var_50_0(var_2_10002(var_45_2)) then
					LeanTween = var_0

					local var_50_1 = var_0.cancel

					go = var_2

					var_50_1(var_2(var_45_2))
				end
			end

			return
		end)
	end

	ShipStatus = var_3

	local var_45_10 = var_3.ShipStatusCheck
	local var_45_11 = "onModify"
	local var_45_12 = arg_45_0
	local var_45_13, var_45_14 = var_45_10(var_45_11, arg_45_0.GetShipVO(var_45_12))

	if not var_45_13 then
		triggerToggle = var_45_11

		var_45_11(arg_45_0.showQuickBtn, false)
	elseif arg_45_1.id ~= arg_45_0.lastShipVo and arg_45_0.isShowQuick then
		onNextTick = var_5

		var_5(function()
			triggerToggle = var_2_10000

			var_2_10000(arg_45_0.showQuickBtn, false)

			triggerToggle = var_2_10000

			var_2_10000(arg_45_0.showQuickBtn, true)

			return
		end)
	elseif arg_45_0.selectedEquip and arg_45_0.isShowQuick then
		local var_45_15 = arg_45_0.selectedEquip.index

		var_45_12 = arg_45_0

		arg_45_0.selectedEquipItem(var_45_12, nil)

		var_45_12 = arg_45_0

		arg_45_0.selectedEquipItem(var_45_12, var_45_15)
	end

	arg_45_0.lastShipVo = arg_45_1.id

	local var_45_16 = arg_45_1
	local var_45_17, var_45_18 = arg_45_1.IsSpweaponUnlock(var_45_16)

	setActive = var_45_16

	local var_45_19 = arg_45_0.spWeaponSlot

	var_45_16(var_9.Find(var_45_19, "Lock"), not var_45_17)

	local var_45_20 = arg_45_1:GetSpWeapon()

	setActive = var_45_12

	local var_45_21 = arg_45_0.spWeaponSlot

	var_45_12(var_10.Find(var_45_21, "Icon"), var_45_20)

	setActive = var_45_12

	local var_45_22 = arg_45_0.spWeaponSlot

	var_45_12(var_10.Find(var_45_22, "IconShadow"), var_45_20)

	if var_45_20 then
		UpdateSpWeaponSlot = var_45_12

		var_45_12(arg_45_0.spWeaponSlot, var_45_20)
	end

	onButton = var_45_12

	local var_45_23 = arg_45_0
	local var_45_24 = arg_45_0.spWeaponSlot

	local function var_45_25()
		if not var_45_17 then
			pg = var_0

			local var_52_0 = var_0.TipsMgr.GetInstance()
			local var_52_1 = var_0.ShowTips

			i18n = var_2_10003

			var_52_1(var_52_0, var_2_10003(var_45_18))

			return
		elseif var_45_20 then
			local var_52_2 = arg_45_0
			local var_52_3 = var_0.emit

			BaseUI = var_2_10003
			var_2_10003 = var_2_10003.ON_SPWEAPON
			var_2_10004 = {}
			EquipmentInfoMediator = var_2_10005
			var_2_10004.type = var_2_10005.TYPE_SHIP

			local var_52_4 = arg_45_0

			var_2_10004.shipId = var_5.GetShipVO(var_52_4).id

			var_52_3(var_52_2, var_2_10003, var_2_10004)
		else
			local var_52_5 = arg_45_0
			local var_52_6 = var_0.emit

			ShipViewConst = var_2_10003

			local var_52_7 = var_2_10003.SWITCH_TO_PAGE

			ShipViewConst = var_2_10004

			var_52_6(var_52_5, var_52_7, var_2_10004.PAGE.EQUIPMENT)
		end

		return
	end

	SFX_PANEL = var_13

	var_45_12(var_45_23, var_45_24, var_45_25, var_13)

	return
end

function var_0_1.selectedEquipItem(arg_53_0, arg_53_1)
	if not arg_53_1 then
		if arg_53_0.selectedEquip then
			arg_53_0.selectedEquip = nil
			arg_53_0.showEquipItem = nil
		end
	else
		arg_53_0.selectedEquip = arg_53_0.equipItems[arg_53_1]
	end

	if arg_53_0.isShowQuick then
		arg_53_0:updateQuickPanel()
	end

	return
end

function var_0_1.updateQuickPanel(arg_54_0, arg_54_1)
	setActive = var_1_10002

	var_1_10002(arg_54_0.selectTitle, not arg_54_0.selectedEquip)

	if arg_54_0.isShowQuick and arg_54_0.selectedEquip then
		if arg_54_0.selectedEquip ~= arg_54_0.showEquipItem or arg_54_1 then
			arg_54_0.showEquipItem = arg_54_0.selectedEquip

			arg_54_0:updateQuickEquipments()
		end
	else
		arg_54_0:setListCount(0, 0)

		setActive = var_2

		var_2(arg_54_0.emptyTitle, false)
	end

	if arg_54_0.equipItems then
		for iter_54_0 = 1, #arg_54_0.equipItems do
			if arg_54_0.selectedEquip and arg_54_0.selectedEquip.index == iter_54_0 then
				setActive = var_6
				findTF = var_1_10008

				var_6(var_1_10008(arg_54_0.equipItems[iter_54_0].tf, "selected"), true)
			else
				setActive = var_6
				findTF = var_1_10008

				var_6(var_1_10008(arg_54_0.equipItems[iter_54_0].tf, "selected"), false)
			end
		end
	end

	return
end

function var_0_1.updateQuickEquipments(arg_55_0)
	arg_55_0:setListCount(0, 0)

	arg_55_0.fillterEquipments = arg_55_0:getEquipments()
	setActive = var_1

	var_1(arg_55_0.emptyTitle, false)

	if arg_55_0.selectedEquip and arg_55_0.selectedEquip.empty then
		setActive = var_1

		var_1(arg_55_0.emptyTitle, #arg_55_0.fillterEquipments == 0)
	end

	local var_55_0 = arg_55_0.selectedEquip.empty and 0 or 1

	arg_55_0:setListCount(#arg_55_0.fillterEquipments + var_55_0, 0)

	return
end

function var_0_1.setListCount(arg_56_0, arg_56_1, arg_56_2)
	if arg_56_0.onSelected then
		isActive = var_3

		if var_3(arg_56_0._tf) then
			local var_56_0 = arg_56_0.list

			var_3.SetTotalCount(var_56_0, arg_56_1, arg_56_2)
		end
	end

	return
end

function var_0_1.getEquipments(arg_57_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_57_0 = var_1_10001(var_1_10003)
	local var_57_1 = arg_57_0
	local var_57_2 = arg_57_0.GetShipVO(var_57_1)

	getProxy = var_1_10003
	EquipmentProxy = var_1_10005

	local var_57_3 = var_1_10003(var_1_10005)

	pg = var_57_1

	local var_57_4 = var_57_1.ship_data_template[var_57_2.configId]["equip_" .. arg_57_0.selectedEquip.index]
	local var_57_5 = var_57_2:getShipType()
	local var_57_6 = var_57_3:getEquipmentsByFillter(var_57_5, var_57_4)
	local var_57_7 = arg_57_0.searchBar
	local var_57_8 = var_7.GetInputText(var_57_7)

	if arg_57_0.equipingFlag then
		ipairs = var_8

		for iter_57_0, iter_57_1 in var_8(var_57_0:getEquipsInShips(function(arg_58_0, arg_58_1)
			local var_58_1

			if var_57_2.id ~= arg_58_1 then
				local var_58_0 = var_57_2

				var_58_1 = not var_2.isForbiddenAtPos(var_58_0, arg_58_0, arg_57_0.selectedEquip.index)
			else
				var_58_1 = false
			end

			if false then
				var_58_1 = true
			end

			return var_58_1
		end)) do
			if var_57_8 == "" or iter_57_1:IsMatchKey(var_57_8) then
				table = var_13

				var_13.insert(var_57_6, iter_57_1)
			end
		end
	end

	local var_57_9 = {}
	local var_57_10 = {
		arg_57_0.indexData.equipPropertyIndex,
		arg_57_0.indexData.equipPropertyIndex2
	}

	pairs = var_10

	for iter_57_2, iter_57_3 in var_10(var_57_6) do
		if arg_57_0:checkFillter(iter_57_3, var_57_10) and (var_57_8 == "" or iter_57_3:IsMatchKey(var_57_8)) then
			table = var_15

			var_15.insert(var_57_9, iter_57_3)
		end
	end

	_ = var_10

	var_10.each(var_57_9, function(arg_59_0)
		local var_59_0 = var_57_2

		if not var_1.canEquipAtPos(var_59_0, arg_59_0, arg_57_0.selectedEquip.index) then
			arg_59_0.mask = true
		end

		return
	end)

	table = var_10

	local var_57_11 = var_10.sort
	local var_57_12 = var_57_9

	CompareFuncs = var_13

	var_57_11(var_57_12, var_13(var_0_2.sortFunc(var_0_2.sort[1], false)))

	return var_57_9
end

function var_0_1.checkFillter(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0

	if arg_60_1.count > 0 or arg_60_1.shipId and arg_60_0.equipingFlag then
		IndexConst = var_60_0

		if var_60_0.filterEquipByType(arg_60_1, arg_60_0.indexData.typeIndex) then
			IndexConst = var_60_0

			if var_60_0.filterEquipByProperty(arg_60_1, arg_60_2) then
				IndexConst = var_60_0

				if var_60_0.filterEquipAmmo1(arg_60_1, arg_60_0.indexData.equipAmmoIndex1) then
					IndexConst = var_60_0

					if var_60_0.filterEquipAmmo2(arg_60_1, arg_60_0.indexData.equipAmmoIndex2) then
						IndexConst = var_60_0

						if var_60_0.filterEquipByCamp(arg_60_1, arg_60_0.indexData.equipCampIndex) then
							IndexConst = var_60_0

							if var_60_0.filterEquipByRarity(arg_60_1, arg_60_0.indexData.rarityIndex) then
								IndexConst = var_60_0
								var_60_0 = var_60_0.filterEquipByExtra(arg_60_1, arg_60_0.indexData.extraIndex)
							end
						end
					end
				end
			end
		end
	end

	return var_60_0
end

function var_0_1.UpdateLock(arg_61_0)
	local var_61_0 = arg_61_0:GetShipVO()

	if var_1.GetLockState(var_61_0) == arg_61_0:GetShipVO().LOCK_STATE_UNLOCK then
		setActive = var_2

		var_2(arg_61_0.lockBtn, true)

		setActive = var_2

		var_2(arg_61_0.unlockBtn, false)
	elseif var_1 == arg_61_0:GetShipVO().LOCK_STATE_LOCK then
		setActive = var_2

		var_2(arg_61_0.lockBtn, false)

		setActive = var_2

		var_2(arg_61_0.unlockBtn, true)
	end

	return
end

function var_0_1.displayQuickPanel(arg_62_0)
	if not arg_62_0:GetShipVO() then
		return
	end

	arg_62_0.isShowQuick = true
	setActive = var_1

	var_1(arg_62_0.attrs, false)

	setActive = var_1

	var_1(arg_62_0.quickPanel, true)
	arg_62_0:updateQuickPanel()

	return
end

function var_0_1.quickSelectEmpty(arg_63_0)
	if not arg_63_0.selectedEquip and arg_63_0.equipItems then
		for iter_63_0 = 1, #arg_63_0.equipItems do
			if arg_63_0.equipItems[iter_63_0].empty then
				arg_63_0:selectedEquipItem(arg_63_0.equipItems[iter_63_0].index)

				return
			end
		end
	end

	return
end

function var_0_1.Show(arg_64_0)
	var_0_1.super.Show(arg_64_0)

	setActive = var_1

	var_1(arg_64_0.randomFlagToggle, arg_64_0.activeRandomFlag)

	return
end

function var_0_1.Hide(arg_65_0)
	var_0_1.super.Hide(arg_65_0)

	setActive = var_1

	var_1(arg_65_0.randomFlagToggle, false)

	return
end

local var_0_4 = 0.2

function var_0_1.displayRecordPanel(arg_66_0)
	if not arg_66_0:GetShipVO() then
		return
	end

	arg_66_0.isShowRecord = true
	setActive = var_1

	var_1(arg_66_0.recordPanel, true)

	setActive = var_1

	var_1(arg_66_0.attrs, false)

	ipairs = var_1

	for iter_66_0, iter_66_1 in var_1(arg_66_0.recordBtns) do
		onButton = var_1_10006

		local var_66_0 = arg_66_0
		local var_66_1 = iter_66_1

		local function var_66_2()
			local var_67_0 = arg_66_0
			local var_67_1 = var_0.emit

			ShipMainMediator = var_2_10003

			local var_67_2 = var_2_10003.ON_RECORD_EQUIPMENT
			local var_67_3 = arg_66_0

			var_67_1(var_67_0, var_67_2, var_4.GetShipVO(var_67_3).id, iter_66_0, 1)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_66_0, var_66_1, var_66_2, var_1_10011)
	end

	ipairs = var_1

	for iter_66_2, iter_66_3 in var_1(arg_66_0.equipRecordBtns) do
		onButton = var_1_10006

		local var_66_3 = arg_66_0
		local var_66_4 = iter_66_3

		local function var_66_5()
			local var_68_0 = arg_66_0
			local var_68_1 = var_0.emit

			ShipMainMediator = var_2_10003

			local var_68_2 = var_2_10003.ON_RECORD_EQUIPMENT
			local var_68_3 = arg_66_0

			var_68_1(var_68_0, var_68_2, var_4.GetShipVO(var_68_3).id, iter_66_2, 2)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_66_3, var_66_4, var_66_5, var_1_10011)
	end

	ipairs = var_1

	for iter_66_4, iter_66_5 in var_1(arg_66_0.recordEquipmentsTFs) do
		arg_66_0:UpdateRecordEquipments(iter_66_4)
	end

	arg_66_0:UpdateRecordSpWeapons()

	return
end

function var_0_1.CloseRecordPanel(arg_69_0, arg_69_1)
	if arg_69_1 then
		arg_69_0.isShowRecord = nil
		setActive = var_1_10002

		var_1_10002(arg_69_0.recordPanel, false)

		if not arg_69_0.isShowRecord and not arg_69_0.isShowQuick then
			setActive = var_1_10002

			var_1_10002(arg_69_0.attrs, true)
		end
	else
		triggerToggle = var_1_10002

		var_1_10002(arg_69_0.showRecordBtn, false)
	end

	return
end

function var_0_1.CloseQuickPanel(arg_70_0)
	arg_70_0.isShowQuick = nil

	arg_70_0:selectedEquipItem(nil)

	arg_70_0.showEquipItem = nil

	if arg_70_0.list then
		arg_70_0:setListCount(0, 0)
	end

	setActive = var_1

	var_1(arg_70_0.quickPanel, false)

	if not arg_70_0.isShowRecord and not arg_70_0.isShowQuick then
		setActive = var_1

		var_1(arg_70_0.attrs, true)
	end

	arg_70_0:updateQuickPanel()

	return
end

function var_0_1.UpdateRecordEquipments(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0.recordEquipmentsTFs[arg_71_1]
	local var_71_1 = arg_71_0:GetShipVO()
	local var_71_2

	if not var_3.getEquipmentRecord(var_71_1, arg_71_0.shareData.player.id)[arg_71_1] then
		var_71_2 = {}
	end

	for iter_71_0 = 1, 5 do
		tonumber = var_1_10009

		local var_71_3 = var_1_10009(var_71_2[iter_71_0]) and var_1_10009 ~= -1
		local var_71_4 = var_71_0:Find("equipment_" .. iter_71_0)
		local var_71_5 = var_11.Find(var_71_4, "empty")
		local var_71_6 = var_11:Find("info")

		setActive = var_71_4

		var_71_4(var_71_6, var_71_3)

		setActive = var_71_4

		var_71_4(var_71_5, not var_71_3)

		if var_71_3 then
			local var_71_7 = arg_71_0.equipmentProxy

			var_71_4 = var_71_4.getEquipmentById(var_71_7, var_1_10009)

			if not (arg_71_0:GetShipVO().equipments[iter_71_0] and var_15.id == var_1_10009 or false) then
				local var_71_9

				if var_71_4 then
					local var_71_8 = var_71_4.count

					if 0 < var_71_8 then
						var_71_9 = false

						goto label_71_0
					end
				end

				var_71_9 = true

				::label_71_0::

				setActive = var_1_10018

				var_1_10018(var_71_6:Find("tip"), var_71_9)

				updateEquipment = var_1_10018

				local var_71_10 = var_71_6:Find("IconTpl")

				Equipment = var_21

				var_1_10018(var_71_10, var_21.New({
					id = var_1_10009
				}))

				if var_71_9 then
					onButton = var_1_10018

					local var_71_11 = arg_71_0
					local var_71_12 = var_71_6

					local function var_71_13()
						pg = var_2_10000

						local var_72_0 = var_2_10000.TipsMgr.GetInstance()
						local var_72_1 = var_0.ShowTips

						i18n = var_2_10003

						var_72_1(var_72_0, var_2_10003("ship_quick_change_nofreeequip"))

						return
					end

					SFX_PANEL = var_23

					var_1_10018(var_71_11, var_71_12, var_71_13, var_23)
				end

				if false then
					removeOnButton = var_71_4

					var_71_4(var_71_6)
				end
			end
		end
	end

	return
end

function var_0_1.UpdateRecordSpWeapons(arg_73_0, arg_73_1)
	LOCK_SP_WEAPON = var_1_10002

	if var_1_10002 then
		return
	end

	local var_73_0 = arg_73_0:GetShipVO()
	local var_73_1 = var_2.GetSpWeaponRecord(var_73_0, arg_73_0.shareData.player.id)

	table = var_1_10003

	var_1_10003.Foreach(arg_73_0.recordBars, function(arg_74_0, arg_74_1)
		if arg_73_1 and arg_74_0 ~= arg_73_1 then
			return
		end

		local var_74_0 = var_73_1[arg_74_0]
		local var_74_1 = arg_74_1
		local var_74_2 = arg_74_1.Find(var_74_1, "SpSlot")
		local var_74_3 = arg_73_0
		local var_74_4 = var_4.GetShipVO(var_74_3)
		local var_74_5 = var_4.IsSpweaponUnlock(var_74_4)

		setActive = var_74_1

		var_74_1(var_74_2:Find("Lock"), not var_74_5)

		setActive = var_74_1

		var_74_1(var_74_2:Find("Icon"), var_74_0)

		setActive = var_74_1

		var_74_1(var_74_2:Find("IconShadow"), var_74_0)

		if var_74_0 then
			UpdateSpWeaponSlot = var_74_1

			var_74_1(var_74_2, var_74_0)

			local var_74_6 = arg_73_0
			local var_74_7 = var_74_1.GetShipVO(var_74_6)

			if var_74_1.GetSpWeapon(var_74_7) then
				local var_74_8 = var_74_1
				local var_74_9

				if not var_74_1.GetConfigID(var_74_8) then
					var_74_9 = 0
				end

				local var_74_11

				if var_74_0:GetConfigID() ~= var_74_9 then
					getProxy = var_74_8
					EquipmentProxy = var_10

					local var_74_10 = var_74_8(var_10)

					if var_74_8.GetSameTypeSpWeapon(var_74_10, var_74_0) and var_74_8:GetConfigID() == var_74_0:GetConfigID() then
						var_74_11 = false
					end
				end

				setActive = var_74_8

				var_74_8(var_74_2:Find("Icon/tip"), var_74_11)

				if var_74_11 then
					onButton = var_74_8

					local var_74_12 = arg_73_0
					local var_74_13 = var_74_2

					local function var_74_14()
						pg = var_3_10000

						local var_75_0 = var_3_10000.TipsMgr.GetInstance()
						local var_75_1 = var_0.ShowTips

						i18n = var_3_10003

						var_75_1(var_75_0, var_3_10003("ship_quick_change_nofreeequip"))

						return
					end

					SFX_PANEL = var_13

					var_74_8(var_74_12, var_74_13, var_74_14, var_13)
				else
					removeOnButton = var_74_8

					var_74_8(var_74_2)
				end

				if false then
					removeOnButton = var_74_1

					var_74_1(var_74_2)
				end

				return
			end
		end
	end)

	return
end

function var_0_1.UpdatePreferenceTag(arg_76_0)
	triggerToggle = var_1_10001

	local var_76_0 = arg_76_0.commonTagToggle
	local var_76_1 = arg_76_0:GetShipVO().preferenceTag

	Ship = var_1_10005

	var_1_10001(var_76_0, var_76_1 == var_1_10005.PREFERENCE_TAG_COMMON)

	return
end

function var_0_1.DoLeveUpAnim(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	local var_77_0 = arg_77_0.shipDetailLogicPanel

	var_4.doLeveUpAnim(var_77_0, arg_77_1, arg_77_2, arg_77_3)

	return
end

function var_0_1.clearListener(arg_78_0)
	if arg_78_0.equipItems then
		for iter_78_0 = 1, #arg_78_0.equipItems do
			if arg_78_0.equipItems[iter_78_0].tf then
				ClearEventTrigger = var_1_10006
				GetOrAddComponent = var_1_10008
				go = var_1_10010
				var_1_10010 = var_1_10010(var_5)
				typeof = var_1_10011
				EventTriggerListener = var_1_10013

				var_1_10006(var_1_10008(var_1_10010, var_1_10011(var_1_10013)))

				removeOnButton = var_1_10006
				go = var_1_10008

				var_1_10006(var_1_10008(var_5))
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_79_0)
	setParent = var_1_10001

	var_1_10001(arg_79_0.randomFlagToggle, arg_79_0._tf)
	arg_79_0:clearListener()

	removeAllChildren = var_1

	var_1(arg_79_0.equipmentsGrid)

	local var_79_0

	if arg_79_0.list then
		var_79_0 = arg_79_0.list

		var_1.SetTotalCount(var_79_0, 0)

		function arg_79_0.list.onUpdateItem()
			return
		end
	end

	arg_79_0.destroy = true

	if arg_79_0.recordPanel then
		LeanTween = var_1

		local var_79_1 = var_1.isTweening

		go = var_79_0

		if var_79_1(var_79_0(arg_79_0.recordPanel)) then
			LeanTween = var_1

			local var_79_2 = var_1.cancel

			go = var_3

			var_79_2(var_3(arg_79_0.recordPanel))
		end

		arg_79_0.recordPanel = nil
	end

	local var_79_3 = arg_79_0.shipDetailLogicPanel

	var_1.clear(var_79_3)

	local var_79_4 = arg_79_0.shipDetailLogicPanel

	var_1.detach(var_79_4)

	arg_79_0.shareData = nil

	if arg_79_0.searchBar then
		local var_79_5 = arg_79_0.searchBar

		var_1.Dispose(var_79_5)

		arg_79_0.searchBar = nil
	end

	return
end

return var_0_1
