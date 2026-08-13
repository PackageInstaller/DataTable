class = var_0_10000

local var_0_0 = "IslandShipSelectPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipSelectUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "top/back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.title = var_1.Find(var_2_1, "top/title/Text")
	setText = var_1

	local var_2_2 = arg_2_0.title

	i18n = var_4

	var_1(var_2_2, var_4("island_select_ship"))

	local var_2_3 = arg_2_0._tf

	arg_2_0.frameTF = var_1.Find(var_2_3, "frame")

	local var_2_4 = arg_2_0.frameTF
	local var_2_5 = var_1.Find(var_2_4, "ships")

	arg_2_0.shipRectCom = var_1.GetComponent(var_2_5, "LScrollRect")
	setText = var_1

	local var_2_6 = arg_2_0.frameTF
	local var_2_7 = var_3.Find(var_2_6, "selected/Text")

	i18n = var_4

	var_1(var_2_7, var_4("island_select_ship_label_1"))

	local var_2_8 = arg_2_0.frameTF
	local var_2_9 = var_1.Find(var_2_8, "selected/num")

	arg_2_0.selectedTextCom = var_1.GetComponent(var_2_9, "Text")

	local var_2_10 = arg_2_0._tf

	arg_2_0.benefitsTF = var_1.Find(var_2_10, "benefits")

	local var_2_11 = arg_2_0.benefitsTF

	arg_2_0.benefitTipBtn = var_1.Find(var_2_11, "tip/help")
	setText = var_1

	local var_2_12 = arg_2_0.benefitsTF
	local var_2_13 = var_3.Find(var_2_12, "tip/Text")

	i18n = var_4

	var_1(var_2_13, var_4("island_select_ship_overview"))

	local var_2_14 = arg_2_0.benefitsTF

	arg_2_0.mainAttrBar = var_1.Find(var_2_14, "main/slider/bar")
	setText = var_1

	local var_2_15 = arg_2_0.benefitsTF
	local var_2_16 = var_3.Find(var_2_15, "main/Text")

	IslandShipAttr = var_4

	local var_2_17 = var_4.ATTRS_CH

	IslandShipAttr = var_2_15

	var_1(var_2_16, var_2_17[var_2_15.MANAGE_KEY])

	UIItemList = var_1

	local var_2_18 = var_1.New
	local var_2_19 = arg_2_0.benefitsTF
	local var_2_20 = var_3.Find(var_2_19, "subs")
	local var_2_21 = arg_2_0.benefitsTF

	arg_2_0.subAttrUIList = var_2_18(var_2_20, var_4.Find(var_2_21, "subs/tpl"))

	local var_2_22 = arg_2_0._tf

	arg_2_0.infoEmptyTF = var_1.Find(var_2_22, "info/empty")
	setText = var_1

	local var_2_23 = arg_2_0.infoEmptyTF
	local var_2_24 = var_3.Find(var_2_23, "Image/Text")

	i18n = var_4

	var_1(var_2_24, var_4("island_select_ship"))

	local var_2_25 = arg_2_0.infoEmptyTF

	arg_2_0.infoEmptyTitleTF = var_1.Find(var_2_25, "name")

	local var_2_26 = arg_2_0._tf

	arg_2_0.infoPanel = var_1.Find(var_2_26, "info/content")

	local var_2_27 = arg_2_0.infoPanel

	arg_2_0.nameTF = var_1.Find(var_2_27, "name")

	local var_2_28 = arg_2_0.infoPanel

	arg_2_0.levelTF = var_1.Find(var_2_28, "name/level")
	UIItemList = var_1

	local var_2_29 = var_1.New
	local var_2_30 = arg_2_0.infoPanel
	local var_2_31 = var_3.Find(var_2_30, "attrs")
	local var_2_32 = arg_2_0.infoPanel

	arg_2_0.attrUIList = var_2_29(var_2_31, var_4.Find(var_2_32, "attrs/tpl"))

	local var_2_33 = arg_2_0.infoPanel

	arg_2_0.skillTF = var_1.Find(var_2_33, "skill")

	local var_2_34 = arg_2_0.infoPanel

	arg_2_0.energyTFInfo = var_1.Find(var_2_34, "selectShipEnergyInfo")

	local var_2_35 = arg_2_0.energyTFInfo

	arg_2_0.energyTF = var_1.Find(var_2_35, "energy")

	local var_2_36 = arg_2_0.energyTF

	arg_2_0.energyCostSilderTF = var_1.Find(var_2_36, "energy_bar_cost")

	local var_2_37 = arg_2_0.energyTFInfo

	arg_2_0.giftBtn = var_1.Find(var_2_37, "gift")

	local var_2_38 = arg_2_0.infoPanel

	arg_2_0.statusTF = var_1.Find(var_2_38, "status")

	local var_2_39 = arg_2_0._tf

	arg_2_0.sureBtn = var_1.Find(var_2_39, "sure")
	setText = var_1

	local var_2_40 = arg_2_0.sureBtn
	local var_2_41 = var_3.Find(var_2_40, "Text")

	i18n = var_4

	var_1(var_2_41, var_4("island_shipselect_confirm"))

	local var_2_42 = arg_2_0._tf

	arg_2_0.indexBtn = var_1.Find(var_2_42, "frame/filter_panel/IndexIco")

	local var_2_43 = arg_2_0._tf

	arg_2_0.orderBtn = var_1.Find(var_2_43, "frame/filter_panel/index")

	local var_2_44 = arg_2_0._tf

	arg_2_0.orderIco = var_1.Find(var_2_44, "frame/filter_panel/index/content/icon/icon")

	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_1.Find(var_2_45, "frame/filter_panel/index/content/Text")
	local var_2_47 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.orderTxt = var_2_47(var_2_46, var_4(var_6))

	local var_2_48 = arg_2_0.energyTFInfo

	arg_2_0.shipIconTF = var_1.Find(var_2_48, "icon_mask/icon")

	local var_2_49 = arg_2_0.energyTFInfo

	arg_2_0.energyTimeTextTf = var_1.Find(var_2_49, "time_Text")

	local var_2_50 = arg_2_0.infoPanel

	arg_2_0.recoveryTimeTips = var_1.Find(var_2_50, "selectShipEnergyInfo/recoveryTimeTips")

	local var_2_51 = arg_2_0.infoPanel

	arg_2_0.skill = var_1.Find(var_2_51, "skill")

	local var_2_52 = arg_2_0.infoPanel

	arg_2_0.skillEmp = var_1.Find(var_2_52, "skillEmp")

	local var_2_53 = arg_2_0.skillEmp

	arg_2_0.skillEmpDes = var_1.Find(var_2_53, "Text")

	local var_2_54 = arg_2_0.skill

	arg_2_0.skillInuse = var_1.Find(var_2_54, "skill_tab_bg/iconBright")

	local var_2_55 = arg_2_0.skill

	arg_2_0.skillUnuse = var_1.Find(var_2_55, "skill_tab_bg/iconDark")

	local var_2_56 = arg_2_0.skill
	local var_2_57 = var_1.Find(var_2_56, "name")
	local var_2_58 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.skillName = var_2_58(var_2_57, var_4(var_6))

	local var_2_59 = arg_2_0.skill
	local var_2_60 = var_1.Find(var_2_59, "desc/Text")
	local var_2_61 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.skillDes = var_2_61(var_2_60, var_4(var_6))

	local var_2_62 = arg_2_0.frameTF

	arg_2_0.shipContent = var_1.Find(var_2_62, "ships")

	local var_2_63 = arg_2_0.frameTF

	arg_2_0.shipEmpty = var_1.Find(var_2_63, "empShip")

	local var_2_64 = arg_2_0._tf

	arg_2_0.addStutasTF = var_1.Find(var_2_64, "addStutas")

	local var_2_65 = arg_2_0._tf

	arg_2_0.energyStutasTF = var_1.Find(var_2_65, "energyStutas")

	local var_2_66 = arg_2_0._tf

	arg_2_0.energyStutasTFNum = var_1.Find(var_2_66, "energyStutas/num")

	local var_2_67 = arg_2_0._tf

	arg_2_0.addStutasNum = var_1.Find(var_2_67, "addStutas/num")

	local var_2_68 = arg_2_0._tf

	arg_2_0.addStutasBtn = var_1.Find(var_2_68, "addStutas/num/tipbtn")

	local var_2_69 = arg_2_0._tf

	arg_2_0.addStutasInfoPanel = var_1.Find(var_2_69, "addinfo_panel")
	UIItemList = var_1

	local var_2_70 = var_1.New
	local var_2_71 = arg_2_0.addStutasInfoPanel
	local var_2_72 = var_3.Find(var_2_71, "effects")
	local var_2_73 = arg_2_0.addStutasInfoPanel

	arg_2_0.buffInfoUIList = var_2_70(var_2_72, var_4.Find(var_2_73, "effects/tpl"))
	setText = var_1

	local var_2_74 = arg_2_0.addStutasInfoPanel
	local var_2_75 = var_3.Find(var_2_74, "Text")

	i18n = var_4

	var_1(var_2_75, var_4("island_production_speed_tip2"))

	local var_2_76 = arg_2_0.addStutasInfoPanel

	arg_2_0.buffInfoEmptyTF = var_1.Find(var_2_76, "empty")
	setText = var_1

	local var_2_77 = arg_2_0.buffInfoEmptyTF
	local var_2_78 = var_3.Find(var_2_77, "Text")

	i18n = var_4

	var_1(var_2_78, var_4("island_manage_no_addition"))

	local var_2_79 = arg_2_0.buffInfoUIList

	var_1.make(var_2_79, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_2_0.buffInfos[arg_3_1 + 1]

			setText = var_4

			var_4(arg_3_2:Find("bg/name"), var_3_0.name)

			setText = var_4

			var_4(arg_3_2:Find("bg/effect"), var_3_0.effect)
		end

		return
	end)

	setText = var_1

	local var_2_80 = arg_2_0.shipEmpty
	local var_2_81 = var_3.Find(var_2_80, "Text")

	i18n = var_4

	var_1(var_2_81, var_4("island_production_selected_tip2"))

	setText = var_1

	local var_2_82 = arg_2_0.recoveryTimeTips

	i18n = var_4

	var_1(var_2_82, var_4("island_ship_energy_recoverytips"))

	return
end

function var_0_1.AddListeners(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.AddListener

	GAME = var_1_10004

	var_4_1(var_4_0, var_1_10004.ISLAND_FOLLOWER_OP_DONE, arg_4_0.OnFollowerOp)

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.AddListener

	GAME = var_4

	var_4_3(var_4_2, var_4.ISLAND_GIVE_GIFT_DONE, arg_4_0.OnUseItem)

	return
end

function var_0_1.RemoveListeners(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.RemoveListener

	GAME = var_1_10004

	var_5_1(var_5_0, var_1_10004.ISLAND_FOLLOWER_OP_DONE, arg_5_0.OnFollowerOp)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.RemoveListener

	GAME = var_4

	var_5_3(var_5_2, var_4.ISLAND_GIVE_GIFT_DONE, arg_5_0.OnUseItem)

	return
end

function var_0_1.OnUseItem(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.ClosePage

	IslandShipStatusBox = var_1_10004

	var_6_1(var_6_0, var_1_10004)
	arg_6_0:FlushInfo()

	return
end

function var_0_1.OnFollowerOp(arg_7_0, arg_7_1)
	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.cards) do
		if iter_7_1.id == arg_7_1 then
			iter_7_1:UpdateFollowMask()
		end
	end

	return
end

function var_0_1.OnInit(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.backBtn

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.Hide(var_9_0)

		existCall = var_0

		var_0(arg_8_0.cancelFunc)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.addStutasBtn

	local function var_8_5()
		isActive = var_2_10000

		if var_2_10000(arg_8_0.addStutasInfoPanel) then
			setActive = var_0

			var_0(arg_8_0.addStutasInfoPanel, false)
		else
			setActive = var_0

			var_0(arg_8_0.addStutasInfoPanel, true)

			local var_10_0 = arg_8_0.buffInfoUIList

			var_0.align(var_10_0, #arg_8_0.buffInfos)

			setActive = var_0

			var_0(arg_8_0.buffInfoEmptyTF, #arg_8_0.buffInfos == 0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.sureBtn

	local function var_8_8()
		getProxy = var_2_10000
		IslandProxy = var_2_10002

		local var_11_0 = var_2_10000(var_2_10002)
		local var_11_1 = var_0.GetIsland(var_11_0)
		local var_11_2 = var_0.GetFollowerAgency(var_11_1)
		local var_11_3 = {}

		ipairs = var_11_1

		for iter_11_0, iter_11_1 in var_11_1(arg_8_0.selectedIds) do
			if var_11_2:Following(iter_11_1) then
				table = var_8

				var_8.insert(var_11_3, iter_11_1)
			end
		end

		if #var_11_3 > 0 then
			local var_11_4 = arg_8_0
			local var_11_5 = var_3.ShowMsgBox
			local var_11_6 = {}

			IslandMsgBox = iter_11_1
			var_11_6.type = iter_11_1.TYPE_COMMON
			i18n = var_7
			var_11_6.content = var_7("island_cancel_follow_tip")

			function var_11_6.onYes()
				local var_12_0 = {}

				ipairs = var_3_10001

				for iter_12_0, iter_12_1 in var_3_10001(var_11_3) do
					table = var_3_10006

					var_3_10006.insert(var_12_0, function(arg_13_0)
						local var_13_0 = arg_8_0
						local var_13_1 = var_1.emit

						IslandMediator = var_4_10004

						var_13_1(var_13_0, var_4_10004.DEL_FOLLOWER, iter_12_1, arg_13_0)

						return
					end)
				end

				seriesAsync = var_1

				var_1(var_12_0, function()
					local var_14_0 = arg_8_0

					var_0.Hide(var_14_0)

					existCall = var_0

					var_0(arg_8_0.confirmFunc, arg_8_0.selectedIds)

					return
				end)

				return
			end

			var_11_5(var_11_4, var_11_6)

			return
		end

		local var_11_7 = arg_8_0

		var_3.Hide(var_11_7)

		existCall = var_3

		var_3(arg_8_0.confirmFunc, arg_8_0.selectedIds)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10006)

	onToggle = var_1_10001

	local var_8_9 = arg_8_0
	local var_8_10 = arg_8_0.indexBtn

	local function var_8_11(arg_15_0)
		if arg_15_0 then
			local var_15_0 = arg_8_0
			local var_15_1 = var_1.emit

			IslandMediator = var_2_10004

			var_15_1(var_15_0, var_2_10004.OPEN_SHIP_INDEX, {
				OnFilter = function(arg_16_0)
					local var_16_0 = arg_8_0

					var_1.OnFilter(var_16_0, arg_16_0)

					return
				end,
				defaultIndex = arg_8_0.sortData,
				needWorkSpeed = arg_8_0.needWorkSpeed
			})
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_9, var_8_10, var_8_11, var_1_10006)

	onButton = var_1_10001

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.orderBtn

	local function var_8_14()
		arg_8_0.selectAsc = not arg_8_0.selectAsc

		local var_17_0 = arg_8_0

		var_0.UpdateSortBtn(var_17_0)

		local var_17_1 = arg_8_0

		var_0.FlushShips(var_17_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_12, var_8_13, var_8_14, var_1_10006)

	onButton = var_1_10001

	local var_8_15 = arg_8_0
	local var_8_16 = arg_8_0.benefitTipBtn

	local function var_8_17()
		local var_18_0 = arg_8_0
		local var_18_1 = var_0.ShowMsgBox
		local var_18_2 = {
			hideNo = true
		}

		IslandMsgBox = var_2_10004
		var_18_2.type = var_2_10004.TYPE_COMMON
		i18n = var_4
		var_18_2.content = var_4("island_manage_help_tip")

		var_18_1(var_18_0, var_18_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_15, var_8_16, var_8_17, var_1_10006)

	onButton = var_1_10001

	local var_8_18 = arg_8_0
	local var_8_19 = arg_8_0._tf
	local var_8_20 = var_4.Find(var_8_19, "top/title/help")

	local function var_8_21()
		pg = var_2_10000

		local var_19_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_19_1 = var_0.ShowMsgBox
		local var_19_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_19_2.type = var_2_10004
		pg = var_2_10004
		var_19_2.helps = var_2_10004.gametip.island_help_commission.tip

		var_19_1(var_19_0, var_19_2)

		return
	end

	SFX_PANEL = var_8_19

	var_1_10001(var_8_18, var_8_20, var_8_21, var_8_19)

	onButton = var_1_10001

	local var_8_22 = arg_8_0
	local var_8_23 = arg_8_0.giftBtn

	local function var_8_24()
		if arg_8_0.showId then
			local var_20_0 = arg_8_0.showId

			IslandCharacterAgency = var_2_10001

			if var_20_0 == var_2_10001.NPC_CONFIG_ID then
				return
			end

			local var_20_1 = arg_8_0
			local var_20_2 = var_0.OpenPage

			IslandShipStatusBox = var_2_10003

			var_20_2(var_20_1, var_2_10003, arg_8_0.showId)

			return
		end
	end

	SFX_PANEL = var_8_19

	var_1_10001(var_8_22, var_8_23, var_8_24, var_8_19)

	local var_8_25 = arg_8_0.subAttrUIList

	var_1.make(var_8_25, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventInit then
			IslandShipAttr = var_3
			arg_21_2.name = var_3.ATTRS[arg_21_1 + 1]
			setText = var_4

			local var_21_0 = arg_21_2:Find("Text")

			IslandShipAttr = var_2_10007

			var_4(var_21_0, var_2_10007.ToChinese(var_3))
		else
			UIItemList = var_3

			if arg_21_0 == var_3.EventUpdate then
				setFillAmount = var_3

				local var_21_1 = arg_21_2:Find("slider/bar")
				local var_21_2 = arg_8_0
				local var_21_3 = var_6.GetShipsAttrProgress

				IslandShipAttr = var_2_10009

				var_3(var_21_1, var_21_3(var_21_2, var_2_10009.ATTRS[arg_21_1 + 1]))
			end
		end

		return
	end)

	function arg_8_0.shipRectCom.onInitItem(arg_22_0)
		local var_22_0 = arg_8_0

		var_1.OnInitShip(var_22_0, arg_22_0)

		return
	end

	function arg_8_0.shipRectCom.onUpdateItem(arg_23_0, arg_23_1)
		local var_23_0 = arg_8_0

		var_2.OnUpdateShip(var_23_0, arg_23_0, arg_23_1)

		return
	end

	arg_8_0.cards = {}
	arg_8_0.selectAsc = true

	local var_8_26 = {}

	IslandShipIndexLayer = var_2
	var_8_26.sortIndex = var_2.SortLevel
	ShipIndexConst = var_2
	var_8_26.campIndex = var_2.CampAll
	ShipIndexConst = var_2
	var_8_26.rarityIndex = var_2.RarityAll
	IslandShipIndexLayer = var_2
	var_8_26.extraIndex = var_2.ExtraALL
	arg_8_0.sortData = var_8_26

	arg_8_0:UpdateSortBtn()

	pg = var_1
	arg_8_0.timeMgr = var_1.TimeMgr.GetInstance()

	return
end

function var_0_1.OnFilter(arg_24_0, arg_24_1)
	arg_24_0.sortData = arg_24_1

	arg_24_0:UpdateSortBtn()
	arg_24_0:FlushShips()

	return
end

function var_0_1.UpdateSortBtn(arg_25_0)
	local var_25_0 = arg_25_0.orderIco

	if arg_25_0.selectAsc then
		Vector3 = var_25_1

		local var_25_1

		if not var_25_1(1, 1, 1) then
			Vector3 = var_25_1
			var_25_1 = var_25_1(1, -1, 1)
		end

		var_25_0.localScale = var_25_1
		IslandShipIndexLayer = var_25_0

		local var_25_2, var_25_3 = var_25_0.getSortFuncAndName(arg_25_0.sortData.sortIndex, arg_25_0.selectAsc)
		local var_25_4 = arg_25_0.orderTxt

		i18n = var_4
		var_25_4.text = var_4(var_25_3)

		return
	end
end

function var_0_1.UpdateAttrs(arg_26_0, arg_26_1)
	IslandShipAttr = var_1_10002

	local var_26_0 = var_1_10002.ATTRS
	local var_26_1 = arg_26_0.attrUIList

	var_3.make(var_26_1, function(arg_27_0, arg_27_1, arg_27_2)
		UIItemList = var_2_10003

		if arg_27_0 == var_2_10003.EventUpdate then
			local var_27_0 = arg_27_1 + 1
			local var_27_1 = arg_26_0

			var_4.UpdateAttr(var_27_1, arg_27_2, var_26_0, var_27_0, arg_26_1)
		end

		return
	end)

	local var_26_2 = arg_26_0.attrUIList

	var_3.align(var_26_2, #var_26_0)

	return
end

function var_0_1.UpdateAttr(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = arg_28_2[arg_28_3]
	local var_28_1 = arg_28_4:GetAttr(var_28_0)

	setText = var_1_10007

	local var_28_2 = arg_28_1:Find("name")

	IslandShipAttr = var_1_10010

	var_1_10007(var_28_2, var_1_10010.ToChinese(var_28_0))

	IslandProductTimeHelper = var_1_10007

	local var_28_3 = var_1_10007.GetAttributeAddPercentByAttribute(arg_28_4.id, arg_28_3)
	local var_28_4
	local var_28_5 = 0 < var_28_3 and "#00B91E" or var_28_3 < 0 and "#FF6767" or "#393A3C"

	setTextColor = var_9

	local var_28_6 = arg_28_1:Find("value")

	Color = var_12

	var_9(var_28_6, var_12.NewHex(var_28_5))

	if var_28_3 ~= 0 then
		math = var_9

		local var_28_7

		if not var_9.floor(var_28_1 * (1 + 0.01 * var_28_3)) then
			var_28_7 = var_28_1
		end

		setText = var_28_8

		var_28_8(arg_28_1:Find("value"), var_28_7)

		local var_28_8

		if var_28_3 ~= 0 then
			var_28_8 = arg_28_4:GetDisplayStatus()
			_ = var_28_6
			var_28_8 = var_28_6.select(var_28_8, function(arg_29_0)
				local var_29_0 = arg_29_0:GetBuffType()

				IslandBuffType = var_2_10002

				return var_29_0 == var_2_10002.SHIP_ATTR
			end)
			onButton = var_28_6

			local var_28_9 = arg_28_0
			local var_28_10 = arg_28_1

			local function var_28_11()
				local var_30_0 = arg_28_0
				local var_30_1 = var_0.ShowMsgBox
				local var_30_2 = {
					hideNo = true
				}

				IslandMsgBox = var_2_10004
				var_30_2.type = var_2_10004.TYPE_SHIP_OWN_STATUS
				i18n = var_4
				var_30_2.title = var_4("island_word_ship_buff_desc")
				var_30_2.statusList = var_28_8

				var_30_1(var_30_0, var_30_2)

				return
			end

			SFX_PANEL = var_1_10016

			var_28_6(var_28_9, var_28_10, var_28_11, var_1_10016)
		else
			removeOnButton = var_28_8

			var_28_8(arg_28_1)
		end

		local var_28_12 = arg_28_4:GetAttrGradeByValue(var_28_7)

		IslandShipAttr = var_28_6

		local var_28_13 = var_28_6.Grade2Img(var_28_12)
		local var_28_14 = arg_28_1:Find("grade")
		local var_28_15 = var_12.GetComponent

		typeof = var_15
		Image = var_1_10017

		local var_28_16 = var_28_15(var_28_14, var_15(var_1_10017))

		GetSpriteFromAtlas = var_13
		var_28_16.sprite = var_13("ui/IslandShipUI_atlas", var_28_13[1])

		local var_28_17 = arg_28_1:Find("grade_bg")
		local var_28_18 = var_12.GetComponent

		typeof = var_15
		Image = var_1_10017

		local var_28_19 = var_28_18(var_28_17, var_15(var_1_10017))

		GetSpriteFromAtlas = var_13
		var_28_19.sprite = var_13("ui/IslandShipUI_atlas", var_28_13[2])
		setActive = var_28_19

		var_28_19(arg_28_1:Find("vx_tpl"), arg_28_0.attrType == arg_28_3)

		return
	end
end

function var_0_1.OnShow(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0

	arg_31_0.BlurPanel(var_31_0)

	local var_31_1

	if not arg_31_1.showType then
		IslandSelectShipCard = var_31_1
		var_31_1 = var_31_1.SHOW_TYPE.PLACE
	end

	arg_31_0.showType = var_31_1

	local var_31_2

	if not arg_31_1.selectNum then
		var_31_2 = 1
	end

	arg_31_0.selectNum = var_31_2

	local var_31_3

	if not arg_31_1.selectedIds then
		var_31_3 = {}
	end

	arg_31_0.selectedIds = var_31_3
	arg_31_0.attrType = arg_31_1.attrType
	arg_31_0.confirmFunc = arg_31_1.confirmFunc
	arg_31_0.cancelFunc = arg_31_1.cancelFunc
	arg_31_0.placeId = arg_31_1.placeId
	arg_31_0.restId = arg_31_1.restId
	arg_31_0.showBenefits = arg_31_1.showBenefits

	local var_31_4

	if not arg_31_1.needWorkSpeed then
		var_31_4 = false
	end

	arg_31_0.needWorkSpeed = var_31_4
	arg_31_0.autoCollectionSelectShip = arg_31_1.autoCollectionSelectShip

	local var_31_5

	if not arg_31_1.emptyInfoTitle then
		var_31_5 = ""
	end

	setText = var_1_10003

	var_1_10003(arg_31_0.infoEmptyTitleTF, var_31_5)

	local var_31_6

	if not arg_31_1.energyCost then
		var_31_6 = 0
	end

	arg_31_0.energyCost = var_31_6
	getProxy = var_31_6
	IslandProxy = var_5

	local var_31_7 = var_31_6(var_5)
	local var_31_8 = var_3.GetIsland(var_31_7)

	arg_31_0.characterAgency = var_3.GetCharacterAgency(var_31_8)

	if arg_31_0.needWorkSpeed then
		local var_31_9 = arg_31_0.sortData

		IslandShipIndexLayer = var_31_0
		var_31_9.sortIndex = var_31_0.SortWorkSpeed
	else
		local var_31_10 = arg_31_0.sortData

		IslandShipIndexLayer = var_31_0
		var_31_10.sortIndex = var_31_0.SortLevel
	end

	arg_31_0:UpdateSortBtn()

	local var_31_11 = #arg_31_0.selectedIds == 0 and arg_31_0.selectNum == 1

	arg_31_0:FlushShips(var_31_11)

	return
end

function var_0_1.CheckHasSelected(arg_32_0, arg_32_1)
	if not arg_32_0.autoCollectionSelectShip then
		return false
	end

	local var_32_0 = false

	pairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_0.autoCollectionSelectShip) do
		if arg_32_1 == iter_32_1 then
			var_32_0 = true
		end
	end

	return var_32_0
end

function var_0_1.OnInitShip(arg_33_0, arg_33_1)
	IslandSelectShipCard = var_1_10002

	local var_33_0 = var_1_10002.New(arg_33_1)

	arg_33_0.cards[arg_33_1] = var_33_0

	return
end

function var_0_1.OnUpdateShip(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0

	if not arg_34_0.cards[arg_34_2] then
		var_1_10006 = arg_34_0

		arg_34_0.OnInitItem(var_1_10006, arg_34_2)

		var_34_0 = arg_34_0.cards[arg_34_2]
	end

	local var_34_1 = arg_34_0.showShips[arg_34_1 + 1]
	local var_34_2 = arg_34_0.characterAgency
	local var_34_3 = var_5.GetShipById(var_34_2, var_34_1)

	onButton = var_1_10006

	local var_34_4 = arg_34_0
	local var_34_5 = var_34_0.go

	local function var_34_6()
		local var_35_0 = arg_34_0

		if var_0.CheckHasSelected(var_35_0, var_34_1) then
			return
		end

		getProxy = var_0
		IslandProxy = var_35_0

		local var_35_1 = var_0(var_35_0)
		local var_35_2 = var_0.GetIsland(var_35_1)
		local var_35_3 = var_0.GetFollowerAgency(var_35_2)

		if var_0.Following(var_35_3, var_34_1) then
			local var_35_4 = arg_34_0
			local var_35_5 = var_0.ShowMsgBox
			local var_35_6 = {}

			i18n = var_2_10004
			var_35_6.content = var_2_10004("island_cancel_follow_tip")

			function var_35_6.onYes()
				local var_36_0 = arg_34_0
				local var_36_1 = var_0.emit

				IslandMediator = var_3_10003

				var_36_1(var_36_0, var_3_10003.DEL_FOLLOWER, var_34_1)

				return
			end

			var_35_5(var_35_4, var_35_6)

			return
		end

		local var_35_7 = var_34_3

		if not var_0.IsDelegable(var_35_7) then
			return
		end

		local var_35_8

		if arg_34_0.showId == var_34_0.id then
			var_35_8 = arg_34_0
			var_35_8.showId = nil
		else
			var_35_8 = arg_34_0
			var_35_8.showId = var_34_0.id
		end

		table = var_35_8

		local var_35_9

		if var_35_8.contains(arg_34_0.selectedIds, var_34_0.id) then
			table = var_35_9

			var_35_9.removebyvalue(arg_34_0.selectedIds, var_34_0.id)
		elseif arg_34_0.selectNum == 1 then
			var_35_9 = arg_34_0
			var_35_9.selectedIds = {
				var_34_0.id
			}
		else
			if #arg_34_0.selectedIds >= arg_34_0.selectNum then
				return
			end

			table = var_35_9

			var_35_9.insert(arg_34_0.selectedIds, var_34_0.id)
		end

		pairs = var_35_9

		for iter_35_0, iter_35_1 in var_35_9(arg_34_0.cards) do
			iter_35_1:UpdateSelected(arg_34_0.selectedIds)
		end

		local var_35_10 = arg_34_0

		var_0.FlushInfo(var_35_10)

		return
	end

	SFX_PANEL = var_1_10011

	var_1_10006(var_34_4, var_34_5, var_34_6, var_1_10011)

	local var_34_7 = arg_34_0.showType

	IslandSelectShipCard = var_34_2

	if var_34_7 == var_34_2.SHOW_TYPE.PLACE then
		var_34_0:Update(arg_34_0.showType, var_34_1, arg_34_0.attrType, arg_34_0.placeId, arg_34_0.selectedIds, arg_34_0.autoCollectionSelectShip)
	else
		local var_34_8 = arg_34_0.showType

		IslandSelectShipCard = var_7

		if var_34_8 == var_7.SHOW_TYPE.RESTAURANT then
			var_34_0:Update(arg_34_0.showType, var_34_1, arg_34_0.attrType, arg_34_0.restId, arg_34_0.selectedIds, arg_34_0.autoCollectionSelectShip)
		end
	end

	return
end

function var_0_1.FlushShips(arg_37_0, arg_37_1)
	arg_37_0.showShips = arg_37_0:GetShips()

	if #arg_37_0.showShips ~= 0 and arg_37_1 and arg_37_0:GetFristSelectableShipId() then
		arg_37_0.showId = var_2
		table = var_1_10003

		var_1_10003.insert(arg_37_0.selectedIds, var_2)
	end

	arg_37_0.showId = arg_37_0.selectedIds[1]
	setActive = var_2

	var_2(arg_37_0.shipContent, #arg_37_0.showShips ~= 0)

	setActive = var_2

	var_2(arg_37_0.shipEmpty, #arg_37_0.showShips == 0)

	local var_37_0 = arg_37_0.shipRectCom

	var_2.SetTotalCount(var_37_0, #arg_37_0.showShips)
	arg_37_0:FlushInfo()

	return
end

function var_0_1.GetFristSelectableShipId(arg_38_0)
	ipairs = var_1_10001

	for iter_38_0, iter_38_1 in var_1_10001(arg_38_0.showShips) do
		local var_38_0 = arg_38_0.characterAgency
		local var_38_1 = var_6.GetShipById(var_38_0, iter_38_1)
		local var_38_2 = var_6.GetState(var_38_1)

		IslandShip = var_38_0

		if var_38_2 == var_38_0.STATE_NORMAL and not arg_38_0:CheckHasSelected(iter_38_1) then
			return iter_38_1
		end
	end

	nilGetShipsAttrProgress = var_1

	return var_1
end

function var_0_1.UpdateTimer(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.timeMgr
	local var_39_1 = arg_39_1 - var_2.GetServerTime(var_39_0)

	setText = var_1_10003

	local var_39_2 = arg_39_0.energyTimeTextTf
	local var_39_3 = arg_39_0.timeMgr

	var_1_10003(var_39_2, var_6.DescCDTime(var_39_3, var_39_1))

	return
end

function var_0_1.StopTimer(arg_40_0)
	if arg_40_0.energyTimer ~= nil then
		local var_40_0 = arg_40_0.energyTimer

		var_1.Stop(var_40_0)

		arg_40_0.energyTimer = nil
	end

	return
end

function var_0_1.FlushInfo(arg_41_0)
	arg_41_0.selectedTextCom.text = #arg_41_0.selectedIds .. "/" .. arg_41_0.selectNum

	arg_41_0:FlushBenefits()

	setActive = var_1

	var_1(arg_41_0.sureBtn, arg_41_0.showId)

	setActive = var_1

	var_1(arg_41_0.infoPanel, arg_41_0.showId)

	setActive = var_1

	var_1(arg_41_0.infoEmptyTF, not arg_41_0.showId)
	arg_41_0:FlushAddPercent()
	arg_41_0:FlushEnergyPercent()

	if not arg_41_0.showId then
		return
	end

	setActive = var_1

	local var_41_0 = arg_41_0.giftBtn
	local var_41_1 = arg_41_0.showId

	IslandCharacterAgency = var_1_10005

	var_1(var_41_0, var_41_1 ~= var_1_10005.NPC_CONFIG_ID)

	getProxy = var_1
	IslandProxy = var_41_0

	local var_41_2 = var_1(var_41_0)
	local var_41_3 = var_1.GetIsland(var_41_2)
	local var_41_4 = var_1.GetCharacterAgency(var_41_3)
	local var_41_5 = var_1.GetShipById(var_41_4, arg_41_0.showId)

	setText = var_2

	var_2(arg_41_0.nameTF, var_41_5:GetName())

	setText = var_2

	local var_41_6 = arg_41_0.levelTF

	string = var_5

	var_2(var_41_6, var_5.format("-Lv.%d", var_41_5:GetLevel()))
	arg_41_0:UpdateAttrs(var_41_5)

	IslandShip = var_2

	local var_41_7 = var_2.StaticGetPrefab(var_41_5.id)

	GetImageSpriteFromAtlasAsync = var_41_4

	var_41_4("ShipYardIcon/" .. var_41_7, "", arg_41_0.shipIconTF)

	local var_41_8 = var_41_5
	local var_41_9 = var_41_5.GetCurrentEnergy(var_41_8)
	local var_41_10 = var_41_5:GetMaxEnergy()

	setText = var_41_8

	local var_41_11 = arg_41_0.energyTF

	var_41_8(var_7.Find(var_41_11, "text"), var_41_9 .. "/" .. var_41_10)

	setSlider = var_41_8

	local var_41_12 = arg_41_0.energyTF

	var_41_8(var_7.Find(var_41_12, "energy_bar"), 0, 1, var_41_9 / var_41_10)

	if var_41_9 ~= var_41_10 then
		setActive = var_41_8

		var_41_8(arg_41_0.recoveryTimeTips, true)

		setActive = var_41_8

		var_41_8(arg_41_0.energyTimeTextTf, true)

		local var_41_13 = var_41_5:GetEnergyMaxTime()

		arg_41_0:StopTimer()
		arg_41_0:UpdateTimer(var_41_13)

		Timer = var_6
		arg_41_0.energyTimer = var_6.New(function()
			local var_42_0 = arg_41_0

			var_0.UpdateTimer(var_42_0, var_41_13)

			return
		end, 1, -1)

		local var_41_14 = arg_41_0.energyTimer

		var_6.Start(var_41_14)
	else
		arg_41_0:StopTimer()

		setActive = var_5

		var_5(arg_41_0.recoveryTimeTips, false)

		setActive = var_5

		var_5(arg_41_0.energyTimeTextTf, false)
	end

	local var_41_15 = var_41_5
	local var_41_16 = var_41_5.GetSkill(var_41_15)
	local var_41_17 = var_5.IsUnlock(var_41_16)

	setActive = var_41_15

	var_41_15(arg_41_0.skill, var_41_17)

	setActive = var_41_15

	var_41_15(arg_41_0.skillEmp, not var_41_17)

	setText = var_41_15

	local var_41_18 = arg_41_0.skillEmpDes

	i18n = var_10

	var_41_15(var_41_18, var_10("island_need_star", var_41_5:GetSkillUnlockLevel()))

	local var_41_19 = arg_41_0.showType

	IslandSelectShipCard = var_41_16

	local var_41_20

	if var_41_19 ~= var_41_16.SHOW_TYPE.PLACE or not arg_41_0.placeId then
		var_41_20 = arg_41_0.restId
	end

	local var_41_21

	if var_41_17 then
		::label_41_0::

		IslandSelectShipCard = var_41_21
		var_41_21 = var_41_21.GetSkillEffective(var_41_5, arg_41_0.showType, var_41_20)
	end

	setActive = var_41_18

	var_41_18(arg_41_0.skillInuse, var_41_21)

	setActive = var_41_18

	var_41_18(arg_41_0.skillUnuse, not var_41_21)

	local var_41_22 = arg_41_0.skillName

	string = var_10
	var_41_22.text = var_10.format("%s - %s", var_5:GetName(), "[Lv." .. var_5:GetLevel() .. "]")
	arg_41_0.skillDes.text = var_5:GetEffectDesc()

	arg_41_0:FlushAddPercent()
	arg_41_0:FlushEnergyPercent()
	arg_41_0:FlushEnergyCostAnim(var_41_5)

	return
end

function var_0_1.FlushEnergyCostAnim(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0

	arg_43_0.StopCostTimer(var_43_0)

	if arg_43_0.energyCost ~= 0 then
		local var_43_1 = arg_43_0.showType

		IslandSelectShipCard = var_1_10003

		local var_43_2

		if var_43_1 ~= var_1_10003.SHOW_TYPE.PLACE then
			var_43_2 = false
		else
			var_43_2 = true
		end

		setActive = var_1_10003

		var_1_10003(arg_43_0.energyCostSilderTF, var_43_2)

		if not var_43_2 then
			return
		end

		local var_43_3 = arg_43_1.id

		IslandCharacterAgency = var_43_0

		local var_43_5, var_43_6

		if var_43_3 == var_43_0.NPC_CONFIG_ID then
			local var_43_4 = arg_43_1

			var_43_3 = arg_43_1.GetCurrentEnergy(var_43_4)
			var_43_5 = arg_43_1
			var_43_6 = arg_43_1.GetMaxEnergy(var_43_5)
			setActive = var_43_4

			var_43_4(arg_43_0.energyCostSilderTF, false)

			setSlider = var_43_4

			local var_43_7 = arg_43_0.energyTF

			var_43_4(var_7.Find(var_43_7, "energy_bar"), 0, 1, var_43_3 / var_43_6)

			setText = var_43_4

			local var_43_8 = arg_43_0.energyTF
			local var_43_9 = var_7.Find(var_43_8, "text")

			string = var_8

			var_43_4(var_43_9, var_8.format("%d-<color=#fadfb6>%d</color>/%d", var_43_3, 0, var_43_6))

			return
		end

		math = var_43_3

		local var_43_10 = var_43_3.floor
		local var_43_11 = arg_43_0.energyCost

		IslandProductCostHelper = var_43_5

		local var_43_12 = var_43_10(var_43_11 * (1 - var_43_5.GetReducePercentInPlace(arg_43_1.id, arg_43_0.placeId)))

		math = var_43_6

		local var_43_13 = var_43_6.max(var_43_12, 1)

		Timer = var_4
		arg_43_0.energyCostTimer = var_4.New(function()
			local var_44_0 = arg_43_1
			local var_44_1 = var_0.GetCurrentEnergy(var_44_0)
			local var_44_2 = arg_43_1
			local var_44_3 = var_1.GetMaxEnergy(var_44_2)

			setSlider = var_44_0

			local var_44_4 = arg_43_0.energyTF

			var_44_0(var_4.Find(var_44_4, "energy_bar"), 0, 1, (var_44_1 - var_43_13) / var_44_3)

			setSlider = var_44_0

			var_44_0(arg_43_0.energyCostSilderTF, 0, 1, var_44_1 / var_44_3)

			setText = var_44_0

			local var_44_5 = arg_43_0.energyTF
			local var_44_6 = var_4.Find(var_44_5, "text")

			string = var_5

			var_44_0(var_44_6, var_5.format("%d-<color=#fadfb6>%d</color>/%d", var_44_1, var_43_13, var_44_3))

			return
		end, 1, -1)

		local var_43_14 = arg_43_0.energyCostTimer

		var_4.Start(var_43_14)
		arg_43_0.energyCostTimer.func()

		return
	end
end

function var_0_1.FlushEnergyPercent(arg_45_0)
	if not arg_45_0.showId or not arg_45_0.autoCollectionSelectShip then
		setActive = var_1

		var_1(arg_45_0.energyStutasTF, false)

		return
	end

	setActive = var_1

	var_1(arg_45_0.energyStutasTF, true)

	IslandAutoCollectHelper = var_1

	local var_45_0 = var_1.GetAttributeReducePercent(arg_45_0.showId)

	string = var_1_10002

	local var_45_1 = var_1_10002.format("<color=#39bfff> -%d%%</color>", var_45_0)

	i18n = var_3

	local var_45_2 = var_3("island_chara_gather_skill_effect") .. var_45_1

	setText = var_4

	var_4(arg_45_0.energyStutasTFNum, var_45_2)

	return
end

function var_0_1.FlushAddPercent(arg_46_0)
	if not arg_46_0.showId or not arg_46_0.needWorkSpeed then
		setActive = var_1

		var_1(arg_46_0.addStutasTF, false)

		setActive = var_1

		var_1(arg_46_0.addStutasInfoPanel, false)

		return
	end

	IslandProductTimeHelper = var_1

	local var_46_0, var_46_1, var_46_2, var_46_3 = var_1.GetAllAddPercent(arg_46_0.showId, arg_46_0.placeId, arg_46_0.attrType)
	local var_46_4 = var_46_0 + var_46_1 + var_46_2 + var_46_3

	setActive = var_1_10006

	var_1_10006(arg_46_0.addStutasTF, true)

	setText = var_1_10006

	local var_46_5 = arg_46_0.addStutasNum

	i18n = var_9

	var_1_10006(var_46_5, var_9("island_production_speed_tip1", var_46_4))

	arg_46_0.buffInfos = {}
	IslandProductTimeHelper = var_6

	local var_46_6 = var_6.GetAttributeAddPercent(arg_46_0.showId, arg_46_0.attrType)
	local var_46_10

	if 0 < var_46_0 then
		IslandShipAttr = var_7

		local var_46_7 = var_7.GetAtrrName(arg_46_0.attrType)

		table = var_8

		local var_46_8 = var_8.insert
		local var_46_9 = arg_46_0.buffInfos

		var_46_10 = {}
		i18n = var_12

		local var_46_11 = "island_production_speed_addition1"

		IslandShipAttr = var_1_10015
		var_46_10.name = var_12(var_46_11, var_1_10015.ToChinese(var_46_7))
		var_46_10.effect = "+" .. var_46_0 .. "%"

		var_46_8(var_46_9, var_46_10)
	end

	local var_46_13

	if 0 < var_46_1 then
		table = var_7

		local var_46_12 = var_7.insert

		var_46_13 = arg_46_0.buffInfos

		local var_46_14 = {}

		i18n = var_46_10
		var_46_14.name = var_46_10("island_production_speed_addition2")
		var_46_14.effect = "+" .. var_46_1 .. "%"

		var_46_12(var_46_13, var_46_14)
	end

	if 0 < var_46_2 then
		getProxy = var_7
		IslandProxy = var_46_13

		local var_46_15 = var_7(var_46_13)
		local var_46_16 = var_7.GetIsland(var_46_15)
		local var_46_17 = var_7.GetCharacterAgency(var_46_16)
		local var_46_18 = var_7.GetShipById(var_46_17, arg_46_0.showId)
		local var_46_19 = var_7.GetSkill(var_46_18)
		local var_46_20 = var_8.GetName(var_46_19)

		table = var_46_17

		var_46_17.insert(arg_46_0.buffInfos, {
			name = var_46_20,
			effect = "+" .. var_46_2 .. "%"
		})
	end

	if 0 < var_46_3 then
		table = var_7

		local var_46_21 = var_7.insert
		local var_46_22 = arg_46_0.buffInfos
		local var_46_23 = {}

		i18n = var_46_10
		var_46_23.name = var_46_10("island_production_speed_addition3")
		var_46_23.effect = "+" .. var_46_3 .. "%"

		var_46_21(var_46_22, var_46_23)
	end

	local var_46_24 = arg_46_0.buffInfoUIList

	var_7.align(var_46_24, #arg_46_0.buffInfos)

	setActive = var_7

	var_7(arg_46_0.buffInfoEmptyTF, #arg_46_0.buffInfos == 0)

	return
end

function var_0_1.FlushBenefits(arg_47_0)
	setActive = var_1_10001

	var_1_10001(arg_47_0.benefitsTF, arg_47_0.showBenefits)

	if arg_47_0.showBenefits then
		setFillAmount = var_1

		local var_47_0 = arg_47_0.mainAttrBar
		local var_47_1 = arg_47_0
		local var_47_2 = arg_47_0.GetShipsAttrProgress

		IslandShipAttr = var_1_10007

		var_1(var_47_0, var_47_2(var_47_1, var_1_10007.ATTRS[1]))

		local var_47_3 = arg_47_0.subAttrUIList
		local var_47_4 = var_1.align

		IslandShipAttr = var_4

		var_47_4(var_47_3, #var_4.ATTRS)
	end

	return
end

function var_0_1.GetShipsAttrProgress(arg_48_0, arg_48_1)
	pg = var_1_10002

	local var_48_0 = var_1_10002.island_chara_att.all

	pg = var_1_10003

	local var_48_1 = var_48_0[#var_1_10003.island_chara_att.all] * arg_48_0.selectNum
	local var_48_2 = 0

	ipairs = var_1_10005

	for iter_48_0, iter_48_1 in var_1_10005(arg_48_0.selectedIds) do
		local var_48_3 = arg_48_0.characterAgency
		local var_48_4 = var_10.GetShipById(var_48_3, iter_48_1)

		var_48_2 = var_48_2 + (var_2 - var_10.GetAttrGrade(var_48_4, arg_48_1) + 1)
	end

	return var_48_2 / var_48_1
end

function var_0_1.ToVShip(arg_49_0, arg_49_1)
	if not arg_49_0.vship then
		arg_49_0.vship = {}

		function arg_49_0.vship.getNation()
			return arg_49_0.vship.config.nationality
		end

		function arg_49_0.vship.getShipType()
			return arg_49_0.vship.config.type
		end

		function arg_49_0.vship.getTeamType()
			ShipType = var_2_10000

			return var_2_10000.GetTeamFromShipType(arg_49_0.vship.config.type)
		end

		function arg_49_0.vship.getRarity()
			return arg_49_0.vship.config.rarity
		end
	end

	arg_49_0.vship.config = arg_49_1

	return arg_49_0.vship
end

local function var_0_2(arg_54_0, arg_54_1)
	if not arg_54_1 or arg_54_1 == "" then
		return true
	end

	string = var_1_10002

	local var_54_0 = var_1_10002.lower

	string = var_1_10004

	local var_54_1 = var_54_0(var_1_10004.gsub(arg_54_1, "%.", "%%."))

	IslandShip = var_1_10003

	local var_54_2 = var_1_10003.StaticGetName(arg_54_0)

	string = var_4

	local var_54_3 = var_4.find

	string = var_6

	return var_54_3(var_6.lower(var_54_2), var_54_1)
end

local function var_0_3(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_1

	ShipGroup = var_1_10004

	local var_55_1 = var_1_10004.getDefaultShipConfig(var_55_0)
	local var_55_2 = arg_55_0
	local var_55_3 = arg_55_0.ToVShip(var_55_2, var_55_1)
	local var_55_4 = arg_55_0.characterAgency
	local var_55_5 = var_6.GetShipById(var_55_4, arg_55_1)

	ShipIndexConst = var_55_2

	if var_55_2.filterByCamp(var_55_3, arg_55_2.campIndex) then
		ShipIndexConst = var_7

		if var_7.filterByRarity(var_55_3, arg_55_2.rarityIndex) then
			IslandShipIndexLayer = var_7

			if var_7.filterByExtra(var_55_5, arg_55_2.extraIndex) then
				return true
			end
		end
	end

	return false
end

function var_0_1.GetShips(arg_56_0)
	local var_56_0 = {}
	local var_56_1 = {}
	local var_56_2 = arg_56_0.characterAgency
	local var_56_3 = var_3.GetShipsContainNpc(var_56_2)

	ipairs = var_1_10004

	for iter_56_0, iter_56_1 in var_1_10004(var_56_3) do
		if var_0_2(iter_56_1.id, arg_56_0.searchKey) and var_0_3(arg_56_0, iter_56_1.id, arg_56_0.sortData) then
			if arg_56_0.needWorkSpeed then
				setmetatable = var_9

				local var_56_4 = var_9({
					GetWorkSpeed = function()
						IslandProductTimeHelper = var_2_10000

						local var_57_0, var_57_1, var_57_2, var_57_3 = var_2_10000.GetAllAddPercent(iter_56_1.id, arg_56_0.placeId, arg_56_0.attrType)

						return var_57_0 + var_57_1 + var_57_2 + var_57_3
					end
				}, {
					__index = iter_56_1
				})

				table = var_1_10010

				var_1_10010.insert(var_56_1, var_56_4)
			elseif arg_56_0.autoCollectionSelectShip then
				if iter_56_1.id ~= 1 then
					table = var_9

					var_9.insert(var_56_1, iter_56_1)
				end
			else
				table = var_9

				var_9.insert(var_56_1, iter_56_1)
			end
		end
	end

	IslandShipIndexLayer = var_4

	local var_56_5 = var_4.getSortFuncAndName(arg_56_0.sortData.sortIndex, arg_56_0.selectAsc)

	table = var_5

	local var_56_6 = var_5.sort
	local var_56_7 = var_56_1

	CompareFuncs = iter_56_1

	var_56_6(var_56_7, iter_56_1(var_56_5))

	ipairs = var_56_6

	for iter_56_2, iter_56_3 in var_56_6(var_56_1) do
		table = var_10

		var_10.insert(var_56_0, iter_56_3.id)
	end

	return var_56_0
end

function var_0_1.StopCostTimer(arg_58_0)
	if arg_58_0.energyCostTimer ~= nil then
		local var_58_0 = arg_58_0.energyCostTimer

		var_1.Stop(var_58_0)

		arg_58_0.energyCostTimer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_59_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_59_0.shipRectCom)
	arg_59_0:StopTimer()
	arg_59_0:StopCostTimer()
	arg_59_0:OnHide()

	return
end

function var_0_1.OnHide(arg_60_0)
	isActive = var_1_10001

	if var_1_10001(arg_60_0.addStutasInfoPanel) then
		setActive = var_1

		var_1(arg_60_0.addStutasInfoPanel, false)
	end

	arg_60_0:UnBlurPanel()

	return
end

function var_0_1.OnDisable(arg_61_0)
	arg_61_0:OnHide()

	return
end

return var_0_1
