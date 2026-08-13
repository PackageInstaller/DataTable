class = var_0_10000

local var_0_0 = "LevelFleetView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))
local var_0_2 = {
	vanguard = 1,
	submarine = 3,
	main = 2
}

var_0_1.TabIndex = {
	Adjustment = 4,
	Commander = 2,
	Formation = 1,
	Duty = 3
}

local var_0_3 = {
	EDIT = 2,
	SELECT = 1
}
local var_0_4 = {
	NORMAL = 1,
	ADDITION_SUPPORT = 2
}

function var_0_1.getUIName(arg_1_0)
	return "LevelFleetSelectView"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:InitUI()

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.bind

	LevelUIConst = var_1_10004

	var_2_1(var_2_0, var_1_10004.CONTINUOUS_OPERATION, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_1.battleTimes

		getProxy = var_2_10003
		ChapterProxy = var_2_10005

		local var_3_1 = var_2_10003(var_2_10005)
		local var_3_2 = var_3.InitContinuousTime

		SYSTEM_SCENARIO = var_2_10006

		var_3_2(var_3_1, var_2_10006, var_3_0)

		LoadContextCommand = var_3_2

		local var_3_3 = var_3_2.RemoveLayerByMediator

		LevelContinuousOperationWindowMediator = var_3_1

		var_3_3(var_3_1)

		local var_3_4 = "chapter_autofight_flag_" .. arg_2_0.chapter.id

		PlayerPrefs = var_4

		var_4.SetInt(var_3_4, 1)

		triggerButton = var_4

		var_4(arg_2_0.btnGo)

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.bind

	LevelMediator2 = var_4

	var_2_3(var_2_2, var_4.ON_SPITEM_CHANGED, function(arg_4_0, arg_4_1)
		setActive = var_2_10002

		var_2_10002(arg_2_0.spCheckMark, not arg_4_1)

		triggerButton = var_2_10002

		var_2_10002(arg_2_0.btnSp)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_5_0)
	if arg_5_0:isShowing() then
		arg_5_0:Hide()
	end

	return
end

function var_0_1.Show(arg_6_0)
	noEmptyStr = var_1_10001

	local var_6_0 = arg_6_0.chapter
	local var_6_1 = var_1_10001(var_3.getConfig(var_6_0, "special_operation_list"))
	local var_6_2 = arg_6_0.chapter
	local var_6_3 = var_2.GetDailyBonusQuota(var_6_2)

	arg_6_0:initSPOPView()

	if var_6_1 and #var_6_1 > 0 and not var_6_3 then
		setActive = var_3

		var_3(arg_6_0.btnSp, true)
	else
		setActive = var_3

		var_3(arg_6_0.btnSp, false)
	end

	setActive = var_3

	var_3(arg_6_0._tf, true)

	local var_6_4 = {
		arg_6_0.formationToggle,
		arg_6_0.commanderToggle,
		arg_6_0.dutyToggle,
		arg_6_0.adjustmentToggle
	}
	local var_6_5

	if not arg_6_0.contextData.tabIndex then
		var_6_5 = var_0_1.TabIndex.Formation
	end

	local var_6_6 = var_6_4[var_6_5]

	isActive = var_5

	if not var_5(var_6_6) then
		var_6_6 = var_6_4[var_0_1.TabIndex.Formation]
	end

	ipairs = var_5

	for iter_6_0, iter_6_1 in var_5(var_6_4) do
		isActive = var_1_10010

		if var_1_10010(iter_6_1) then
			triggerToggle = var_1_10010

			var_1_10010(iter_6_1, iter_6_1 == var_6_6)
		end
	end

	arg_6_0:BlurPanel(arg_6_0._tf)
	arg_6_0:TryPlaySupportGuide()
	arg_6_0:CheckGuideElement()

	return
end

function var_0_1.CheckGuideElement(arg_7_0)
	IsUnityEditor = var_1_10001

	if not var_1_10001 then
		return
	end

	local var_7_0 = {
		"panel/Fixed/start_button",
		"panel/ShipList/support/1/main"
	}

	_ = var_1_10002

	var_1_10002.each(var_7_0, function(arg_8_0)
		local var_8_0 = arg_7_0._tf
		local var_8_1 = var_1.Find(var_8_0, arg_8_0)

		assert = var_2_10002

		var_2_10002(var_8_1, "Missing Guide Need GameObject Path: " .. arg_8_0)

		return
	end)

	return
end

function var_0_1.TryPlaySupportGuide(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.getLimitNums

	FleetType = var_1_10004

	if var_9_1(var_9_0, var_1_10004.Support) == 0 then
		return
	end

	pg = var_1

	local var_9_2 = var_1.NewStoryMgr.GetInstance()

	if not var_1.IsPlayed(var_9_2, "NG0041") then
		pg = var_1

		local var_9_3 = var_1.SystemGuideMgr.GetInstance()

		var_1.PlayByGuideId(var_9_3, "NG0041")
	end

	return
end

function var_0_1.Hide(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.dropDown, false)

	setActive = var_1_10001

	var_1_10001(arg_10_0.btnSp, false)

	setActive = var_1_10001

	var_1_10001(arg_10_0._tf, false)

	arg_10_0.spItemID = nil

	arg_10_0:UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_1.setOpenCommanderTag(arg_11_0, arg_11_1)
	arg_11_0.openedCommanerSystem = arg_11_1

	return
end

function var_0_1.SetDutyTabEnabled(arg_12_0, arg_12_1)
	arg_12_0.dutyTabEnabled = arg_12_1

	return
end

function var_0_1.onConfirm(arg_13_0)
	local var_13_0 = arg_13_0.chapter
	local var_13_1 = arg_13_0:getSelectIds()
	local var_13_2 = #var_13_0:getNpcShipByType(2)

	if 0 < var_13_2 then
		local var_13_3 = {}

		TeamType = var_5

		local var_13_4 = var_5.Vanguard
		local var_13_5 = arg_13_0:getFleetById(var_13_1[1])
		local var_13_6 = var_6.getTeamByName

		TeamType = var_9
		var_13_3[var_13_4] = #var_13_6(var_13_5, var_9.Vanguard)
		TeamType = var_13_4

		local var_13_7 = var_13_4.Main
		local var_13_8 = arg_13_0:getFleetById(var_13_1[1])
		local var_13_9 = var_6.getTeamByName

		TeamType = var_9
		var_13_3[var_13_7] = #var_13_9(var_13_8, var_9.Main)

		local var_13_10 = {}

		TeamType = var_6
		var_13_10[var_6.Vanguard] = 0
		TeamType = var_6
		var_13_10[var_6.Main] = 0

		local var_13_11

		ipairs = var_1_10007

		for iter_13_0, iter_13_1 in var_1_10007(var_3) do
			var_13_11 = iter_13_1
			var_13_10[var_12] = var_13_10[iter_13_1:getTeamType()] + 1

			if var_13_3[var_12] + var_13_10[var_12] > 3 then
				break
			end
		end

		pairs = var_1_10007

		for iter_13_2, iter_13_3 in var_1_10007(var_13_3) do
			if iter_13_3 + var_13_10[iter_13_2] > 3 then
				local var_13_12 = arg_13_0
				local var_13_13 = arg_13_0.emit

				LevelUIConst = var_1_10015
				var_1_10015 = var_1_10015.HANDLE_SHOW_MSG_BOX

				local var_13_14 = {
					modal = true,
					hideNo = true
				}

				i18n = var_1_10017
				var_13_14.content = var_1_10017("chapter_tip_with_npc", var_13_11.name)

				var_13_13(var_13_12, var_1_10015, var_13_14)

				return
			end
		end
	end

	local var_13_15 = "chapter_autofight_flag_" .. var_13_0.id
	local var_13_16
	local var_13_17

	seriesAsync = var_1_10007

	var_1_10007({
		function(arg_14_0)
			PlayerPrefs = var_2_10001

			local var_14_0 = var_2_10001.GetInt("autoFight_firstUse_sp", 0) == 1

			PlayerPrefs = var_2_10002

			if var_2_10002.GetInt(var_13_15, 1) == 1 and not var_14_0 then
				local var_14_1 = arg_13_0

				if not var_3.getSPItem(var_14_1) then
					return arg_14_0()
				end

				PlayerPrefs = var_3

				var_3.SetInt("autoFight_firstUse_sp", 1)

				PlayerPrefs = var_3

				var_3.Save()

				local function var_14_2()
					local var_15_0 = arg_13_0

					var_0.clearSPBuff(var_15_0)

					return
				end

				local var_14_3 = arg_13_0
				local var_14_4 = var_4.emit

				LevelUIConst = var_2_10007

				local var_14_5 = var_2_10007.HANDLE_SHOW_MSG_BOX
				local var_14_6 = {
					hideNo = true
				}

				i18n = var_2_10009
				var_14_6.content = var_2_10009("autofight_special_operation_tip")
				var_14_6.onYes = var_14_2
				var_14_6.onNo = var_14_2

				var_14_4(var_14_3, var_14_5, var_14_6)

				return
			end
		end,
		function(arg_16_0)
			local var_16_0 = var_13_0

			var_13_17 = var_1.GetActiveSPItemID(var_16_0)

			local var_16_1 = var_13_0

			if var_1.isLoop(var_16_1) then
				local var_16_2 = arg_13_0
				local var_16_3

				if not var_1.GetOrderedDuties(var_16_2) then
					var_16_3 = nil
				end

				var_13_16 = var_16_3

				local var_16_4 = arg_13_0

				var_1.onCancel(var_16_4)
				arg_16_0()

				return
			end
		end,
		function(arg_17_0)
			getProxy = var_2_10001
			ChapterProxy = var_2_10003

			local var_17_0 = var_2_10001(var_2_10003)

			var_1.SetLastFleetIndex(var_17_0, var_13_1)

			PlayerPrefs = var_1

			local var_17_1 = var_1.GetInt(var_13_15, 1) == 1

			LevelMediator2 = var_2_10002

			local var_17_2 = var_2_10002.ON_TRACKING

			packEx = var_3

			local var_17_3 = var_3(var_13_0.id, var_13_0.loopFlag, var_13_17, var_13_16, var_17_1)

			pg = var_4

			local var_17_4 = var_4.m02
			local var_17_5 = var_4.retrieveMediator

			LevelMediator2 = var_7

			local var_17_6

			if var_17_5(var_17_4, var_7.__cname) then
				pg = var_5
				var_17_6 = var_5.m02

				var_5.sendNotification(var_17_6, var_17_2, var_17_3)

				return
			end

			getProxy = var_5
			ContextProxy = var_17_6

			local var_17_7 = var_5(var_17_6)
			local var_17_8 = var_5.getContextByMediator

			LevelMediator2 = var_8

			if var_17_8(var_17_7, var_8) then
				var_5:extendData({
					ToTrackingData = {
						var_17_2,
						var_17_3
					}
				})
			end

			return
		end
	})

	return
end

function var_0_1.onCancel(arg_18_0)
	arg_18_0:clear()

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.emit

	LevelUIConst = var_1_10004

	var_18_1(var_18_0, var_1_10004.HIDE_FLEET_SELECT)

	return
end

function var_0_1.InitUI(arg_19_0)
	local var_19_0 = arg_19_0._tf

	arg_19_0.tfShipTpl = var_1.Find(var_19_0, "panel/Fixed/shiptpl")

	local var_19_1 = arg_19_0._tf

	arg_19_0.tfEmptyTpl = var_1.Find(var_19_1, "panel/Fixed/emptytpl")

	local var_19_2 = {}

	FleetType = var_1_10002

	local var_19_3 = var_1_10002.Normal
	local var_19_4 = {}
	local var_19_5 = arg_19_0._tf

	var_19_4[1] = var_4.Find(var_19_5, "panel/ShipList/fleet/1")

	local var_19_6 = arg_19_0._tf

	var_19_4[2] = var_4.Find(var_19_6, "panel/ShipList/fleet/2")
	var_19_2[var_19_3] = var_19_4
	FleetType = var_19_3

	local var_19_7 = var_19_3.Submarine
	local var_19_8 = {}
	local var_19_9 = arg_19_0._tf

	var_19_8[1] = var_4.Find(var_19_9, "panel/ShipList/sub/1")
	var_19_2[var_19_7] = var_19_8
	FleetType = var_19_7

	local var_19_10 = var_19_7.Support
	local var_19_11 = {}
	local var_19_12 = arg_19_0._tf

	var_19_11[1] = var_4.Find(var_19_12, "panel/ShipList/support/1")
	var_19_2[var_19_10] = var_19_11
	arg_19_0.tfFleets = var_19_2

	local var_19_13 = arg_19_0._tf
	local var_19_14 = var_1.Find(var_19_13, "panel/Fixed/RightTabs")

	PLATFORM_CODE = var_19_10
	PLATFORM_US = var_19_13

	if var_19_10 == var_19_13 then
		local var_19_15 = arg_19_0._tf
		local var_19_17

		if not var_2.Find(var_19_15, "panel/Fixed/RightTabs/hTplBtn") then
			local var_19_16 = arg_19_0._tf

			var_19_17 = var_2.Find(var_19_16, "panel/Fixed/RightTabs/vTplBtn")
		end

		local var_19_18 = {
			"formation_btn",
			"commander_btn",
			"duty_btn",
			"adjustment_btn"
		}

		for iter_19_0 = 1, #var_19_18 do
			Instantiate = var_1_10008
			var_1_10008 = var_1_10008(var_19_17)
			var_1_10008.name = var_19_18[iter_19_0]
			SetParent = var_9
			tf = var_1_10011

			var_9(var_1_10011(var_1_10008), var_19_14)

			setActive = var_9

			var_9(var_1_10008, false)
		end

		local var_19_19 = arg_19_0._tf

		arg_19_0.tfLimit = var_4.Find(var_19_19, "panel/Fixed/limit_list/limit")

		local var_19_20 = arg_19_0._tf

		arg_19_0.tfLimitTips = var_4.Find(var_19_20, "panel/Fixed/limit_list/limit_tip")

		local var_19_21 = arg_19_0._tf

		arg_19_0.tfLimitElite = var_4.Find(var_19_21, "panel/Fixed/limit_list/limit_elite")

		local var_19_22 = arg_19_0._tf

		arg_19_0.tfLimitSubTip = var_4.Find(var_19_22, "panel/Fixed/limit_list/limit_sub_tip")

		local var_19_23 = arg_19_0._tf

		arg_19_0.tfLimitContainer = var_4.Find(var_19_23, "panel/Fixed/limit_list/limit_elite/limit_list")

		local var_19_24 = arg_19_0._tf

		arg_19_0.rtCostLimit = var_4.Find(var_19_24, "panel/Fixed/limit_list/cost_limit")

		local var_19_25 = arg_19_0._tf

		arg_19_0.btnBack = var_4.Find(var_19_25, "panel/Fixed/btnBack")

		local var_19_26 = arg_19_0._tf

		arg_19_0.btnGo = var_4.Find(var_19_26, "panel/Fixed/start_button")

		local var_19_27 = arg_19_0._tf

		arg_19_0.btnMultiple = var_4.Find(var_19_27, "panel/Fixed/multiple")

		local var_19_28 = arg_19_0._tf

		arg_19_0.formationToggle = var_4.Find(var_19_28, "panel/Fixed/RightTabs/formation_btn")

		local var_19_29 = arg_19_0._tf

		arg_19_0.commanderToggle = var_4.Find(var_19_29, "panel/Fixed/RightTabs/commander_btn")

		local var_19_30 = arg_19_0._tf

		arg_19_0.dutyToggle = var_4.Find(var_19_30, "panel/Fixed/RightTabs/duty_btn")

		local var_19_31 = arg_19_0._tf

		arg_19_0.adjustmentToggle = var_4.Find(var_19_31, "panel/Fixed/RightTabs/adjustment_btn")

		local var_19_32 = arg_19_0._tf

		arg_19_0.toggleMask = var_4.Find(var_19_32, "mask")

		local var_19_33 = arg_19_0._tf

		arg_19_0.toggleList = var_4.Find(var_19_33, "mask/list")
		arg_19_0.toggles = {}
		setText = var_4
		findTF = var_19_33

		local var_19_34 = var_19_33(arg_19_0.tfLimit, "text")

		i18n = var_7

		var_4(var_19_34, var_7("level_fleet_ship_desc"))

		setText = var_4
		findTF = var_19_34

		local var_19_35 = var_19_34(arg_19_0.tfLimit, "text_sub")

		i18n = var_7

		var_4(var_19_35, var_7("level_fleet_sub_desc"))

		for iter_19_1 = 0, arg_19_0.toggleList.childCount - 1 do
			table = var_19_36

			local var_19_36 = var_19_36.insert
			local var_19_37 = arg_19_0.toggles
			local var_19_38 = arg_19_0.toggleList

			var_19_36(var_19_37, var_1_10011.Find(var_19_38, "item" .. iter_19_1 + 1))
		end

		local var_19_39 = arg_19_0._tf

		arg_19_0.btnSp = var_4.Find(var_19_39, "panel/Fixed/sp")

		local var_19_40 = arg_19_0._tf

		arg_19_0.spMask = var_4.Find(var_19_40, "mask_sp")
		arg_19_0.dutyItems = {}

		for iter_19_2 = 1, 2 do
			local var_19_41 = arg_19_0._tf
			local var_19_42 = var_8.Find

			string = var_1_10011

			local var_19_43 = var_19_42(var_19_41, var_1_10011.format("panel/ShipList/fleet/%d/DutySelect", iter_19_2))

			arg_19_0.dutyItems[iter_19_2] = {}

			for iter_19_3 = 1, 4 do
				local var_19_44 = var_19_43:Find("Item" .. iter_19_3)

				var_1_10014 = arg_19_0.dutyItems[iter_19_2]
				var_1_10014[iter_19_3] = var_19_44
				setText = var_1_10014

				local var_19_45 = var_19_44:Find("Text")

				i18n = var_17

				var_1_10014(var_19_45, var_17("autofight_function" .. iter_19_3))
			end
		end

		local var_19_46 = arg_19_0._tf
		local var_19_47 = var_4.Find(var_19_46, "panel/ShipList/sub/1/DutySelect")

		arg_19_0.dutyItems[3] = {}

		for iter_19_4 = 1, 2 do
			local var_19_48 = var_19_47:Find("Item" .. iter_19_4)
			local var_19_49 = arg_19_0.dutyItems[3]

			var_19_49[iter_19_4] = var_19_48
			setText = var_19_49
			var_1_10014 = var_19_48

			local var_19_50 = var_19_48.Find(var_1_10014, "Text")

			i18n = var_13

			var_19_49(var_19_50, var_13("autofight_function" .. 6 - iter_19_4))
		end

		setActive = var_5

		var_5(arg_19_0.tfShipTpl, false)

		setActive = var_5

		var_5(arg_19_0.tfEmptyTpl, false)

		setActive = var_5

		var_5(arg_19_0.toggleMask, false)

		setActive = var_5

		var_5(arg_19_0.btnSp, false)

		setActive = var_5

		var_5(arg_19_0.spMask, false)

		setText = var_5

		local var_19_51 = arg_19_0._tf
		local var_19_52 = var_7.Find(var_19_51, "panel/Fixed/RightTabs/formation_btn/text")

		i18n = var_8

		var_5(var_19_52, var_8("autofight_formation"))

		setText = var_5

		local var_19_53 = arg_19_0._tf
		local var_19_54 = var_7.Find(var_19_53, "panel/Fixed/RightTabs/commander_btn/text")

		i18n = var_8

		var_5(var_19_54, var_8("autofight_cat"))

		setText = var_5

		local var_19_55 = arg_19_0._tf
		local var_19_56 = var_7.Find(var_19_55, "panel/Fixed/RightTabs/duty_btn/text")

		i18n = var_8

		var_5(var_19_56, var_8("autofight_function"))

		setText = var_5

		local var_19_57 = arg_19_0.adjustmentToggle
		local var_19_58 = var_7.Find(var_19_57, "text")

		i18n = var_8

		var_5(var_19_58, var_8("word_adjustFleet"))

		local var_19_59 = arg_19_0._tf

		arg_19_0.dropDown = var_5.Find(var_19_59, "panel/FixedTop/Dropdown")
		setActive = var_5

		var_5(arg_19_0.dropDown, false)

		local var_19_60 = arg_19_0._tf

		arg_19_0.dropDownSide = var_5.Find(var_19_60, "panel/Fixed/title/DropSide")
		onButton = var_5

		local var_19_61 = arg_19_0
		local var_19_62 = arg_19_0.dropDownSide
		local var_19_63 = var_8.Find(var_19_62, "Click")

		local function var_19_64()
			isActive = var_2_10000

			local var_20_0 = var_2_10000(arg_19_0.dropDown)

			setActive = var_2_10001

			var_2_10001(arg_19_0.dropDown, not var_20_0)

			return
		end

		SFX_UI_CLICK = var_19_62

		var_5(var_19_61, var_19_63, var_19_64, var_19_62)

		onButton = var_5

		local var_19_65 = arg_19_0
		local var_19_66 = arg_19_0.dropDown

		local function var_19_67()
			isActive = var_2_10000

			local var_21_0 = var_2_10000(arg_19_0.dropDown)

			setActive = var_2_10001

			var_2_10001(arg_19_0.dropDown, not var_21_0)

			return
		end

		SFX_UI_CLICK = var_19_62

		var_5(var_19_65, var_19_66, var_19_67, var_19_62)

		onButton = var_5

		local var_19_68 = arg_19_0
		local var_19_69 = arg_19_0.dropDownSide
		local var_19_70 = var_8.Find(var_19_69, "Layout/Item3")

		local function var_19_71()
			local var_22_0 = arg_19_0
			local var_22_1 = var_0.emit

			LevelUIConst = var_2_10003

			local var_22_2 = var_2_10003.HANDLE_SHOW_MSG_BOX
			local var_22_3 = {}

			MSGBOX_TYPE_HELP = var_2_10005
			var_22_3.type = var_2_10005
			pg = var_2_10005
			var_22_3.helps = var_2_10005.gametip.fleet_antisub_range_tip.tip

			var_22_1(var_22_0, var_22_2, var_22_3)

			return
		end

		SFX_PANEL = var_19_69

		var_5(var_19_68, var_19_70, var_19_71, var_19_69)

		assert = var_5
		OPEN_AIR_DOMINANCE = var_19_68

		var_5(var_19_68, "Not Prepare for BANNED OPEN_AIR_DOMINANCE")

		local var_19_72 = arg_19_0.dropDownSide

		arg_19_0.btnASHelp = var_5.Find(var_19_72, "help")
		setText = var_5

		local var_19_73 = arg_19_0.dropDownSide
		local var_19_74 = var_7.Find(var_19_73, "Layout/Item1/Text")

		i18n = var_8

		var_5(var_19_74, var_8("word_investigate"))

		setText = var_5

		local var_19_75 = arg_19_0.dropDownSide
		local var_19_76 = var_7.Find(var_19_75, "Layout/Item2/Text")

		i18n = var_8

		var_5(var_19_76, var_8("word_attr_ac"))

		setText = var_5

		local var_19_77 = arg_19_0.dropDownSide
		local var_19_78 = var_7.Find(var_19_77, "Layout/Item3/Text")

		i18n = var_8

		var_5(var_19_78, var_8("fleet_antisub_range"))

		setText = var_5

		local var_19_79 = arg_19_0.dropDown
		local var_19_80 = var_7.Find(var_19_79, "Investigation/Text")

		i18n = var_8

		var_5(var_19_80, var_8("level_scene_title_word_1"))

		setText = var_5

		local var_19_81 = arg_19_0.dropDown
		local var_19_82 = var_7.Find(var_19_81, "Airsupport/Text")

		i18n = var_8

		var_5(var_19_82, var_8("level_scene_title_word_3"))

		local var_19_83 = arg_19_0._tf

		arg_19_0.supportFleetHelp = var_5.Find(var_19_83, "panel/Fixed/title/Image/Help")
		onButton = var_5

		local var_19_84 = arg_19_0
		local var_19_85 = arg_19_0.supportFleetHelp

		local function var_19_86()
			local var_23_0 = arg_19_0.chapter
			local var_23_1

			if var_0.IsSupportSubmarineStage(var_23_0) then
				var_23_1 = "help_supportfleet_16_submarine"
			else
				local var_23_2 = arg_19_0.chapter

				var_23_1 = var_0.IsFogStage(var_23_2) and "help_supportfleet_16" or "help_supportfleet"
			end

			local var_23_3 = arg_19_0
			local var_23_4 = var_1.emit

			LevelUIConst = var_2_10004

			local var_23_5 = var_2_10004.HANDLE_SHOW_MSG_BOX
			local var_23_6 = {}

			MSGBOX_TYPE_HELP = var_2_10006
			var_23_6.type = var_2_10006
			i18n = var_2_10006
			var_23_6.helps = var_2_10006(var_23_1)

			var_23_4(var_23_3, var_23_5, var_23_6)

			return
		end

		SFX_PANEL = var_10

		var_5(var_19_84, var_19_85, var_19_86, var_10)

		for iter_19_5 = 1, 2 do
			for iter_19_6 = 1, 4 do
				local var_19_87 = arg_19_0.dutyItems[iter_19_5][iter_19_6]

				onButton = var_1_10014

				var_1_10014(arg_19_0, var_19_87, function()
					local var_24_0 = arg_19_0

					var_0.SetDuty(var_24_0, iter_19_5, iter_19_6)

					return
				end)
			end
		end

		for iter_19_7 = 1, 2 do
			local var_19_88 = arg_19_0.dutyItems[3][iter_19_7]

			onButton = var_10

			var_10(arg_19_0, var_19_88, function()
				local var_25_0 = arg_19_0

				var_0.SetAutoSub(var_25_0, iter_19_7 == 1)

				return
			end)
		end

		return
	end
end

function var_0_1.onCancelSupport(arg_26_0, arg_26_1)
	if arg_26_1 then
		local var_26_0 = arg_26_0
		local var_26_1 = arg_26_0.emit

		LevelMediator2 = var_1_10005

		var_26_1(var_26_0, var_1_10005.ON_UPDATE_CUSTOM_FLEET, arg_26_0.chapter)
	end

	return
end

function var_0_1.set(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_0.chapter = arg_27_1
	arg_27_0.mode = var_0_3.SELECT
	arg_27_0.selects = arg_27_3

	local var_27_0 = arg_27_0.chapter

	arg_27_0.chapterASValue = var_4.getConfig(var_27_0, "air_dominance")

	local var_27_1 = arg_27_0.chapter

	arg_27_0.suggestionValue = var_4.getConfig(var_27_1, "best_air_dominance")

	arg_27_0:SetDutyTabEnabled(arg_27_1:isLoop())

	local var_27_2 = arg_27_0.chapter

	arg_27_0.supportFleet = var_4.getSupportFleet(var_27_2)

	local var_27_3 = arg_27_0
	local var_27_4 = arg_27_0.getLimitNums

	FleetType = var_7

	local var_27_5 = var_27_4(var_27_3, var_7.Support)
	local var_27_6 = 0 < var_27_5

	setActive = var_5

	var_5(arg_27_0.supportFleetHelp, var_27_6)

	local var_27_7

	if not var_27_6 or not var_0_4.ADDITION_SUPPORT then
		var_27_7 = var_0_4.NORMAL
	end

	arg_27_0.displayMode = var_27_7

	arg_27_0:SwitchDisplayMode()

	underscore = var_5

	local var_27_8 = var_5(arg_27_2)
	local var_27_9 = var_5.chain(var_27_8)
	local var_27_10 = var_5.values(var_27_9)
	local var_27_11 = var_5.filter(var_27_10, function(arg_28_0)
		return arg_28_0:isRegularFleet()
	end)
	local var_27_12 = var_5.sort

	CompareFuncs = var_8

	local var_27_13 = var_27_12(var_27_11, var_8({
		function(arg_29_0)
			return arg_29_0.id
		end
	}))

	arg_27_0.fleets = var_5.value(var_27_13)

	local var_27_14 = {}

	FleetType = var_27_3
	var_27_14[var_27_3.Normal] = {}
	FleetType = var_6
	var_27_14[var_6.Submarine] = {}
	arg_27_0.selectIds = var_27_14
	ipairs = var_27_14

	for iter_27_0, iter_27_1 in var_27_14(arg_27_3 or {}) do
		if arg_27_0:getFleetById(iter_27_1) then
			var_1_10013 = var_10

			local var_27_15 = var_10.getFleetType(var_1_10013)

			if #arg_27_0.selectIds[var_27_15] < arg_27_0:getLimitNums(var_27_15) then
				table = var_1_10013

				var_1_10013.insert(var_12, iter_27_1)
			end
		end
	end

	arg_27_0.duties = {}
	PlayerPrefs = var_5

	local var_27_16 = var_5.GetInt
	local var_27_17 = "lastFleetDuty_"
	local var_27_18

	if not arg_27_0.chapter.id then
		var_27_18 = 0
	end

	local var_27_19 = var_27_16(var_27_17 .. var_27_18, 0)
	local var_27_20, var_27_22

	if 0 < var_27_19 then
		bit = var_27_20
		var_27_20 = var_27_20.band(var_27_19, 255)
		bit = var_27_22

		local var_27_21 = var_27_22.rshift(var_27_19, 8)

		bit = var_27_22
		var_27_22 = var_27_22.band(var_27_21, 255)

		if var_27_20 > 0 and var_27_22 > 0 then
			arg_27_0.duties[var_27_20] = var_27_22
		end
	end

	setActive = var_27_20

	var_27_20(arg_27_0.tfLimitElite, false)

	setActive = var_27_20

	var_27_20(arg_27_0.tfLimitSubTip, false)

	setActive = var_27_20

	var_27_20(arg_27_0.tfLimitTips, false)

	setActive = var_27_20

	var_27_20(arg_27_0.tfLimit, true)

	local var_27_23 = arg_27_0.chapter

	if var_6.isLoop(var_27_23) then
		local var_27_24 = arg_27_0.chapter
		local var_27_25

		if not var_6.getConfig(var_27_24, "use_oil_limit") then
			var_27_25 = {}
		end

		setActive = var_27_22

		var_27_22(arg_27_0.rtCostLimit, #var_27_25 > 0)

		setText = var_27_22

		local var_27_26 = arg_27_0.rtCostLimit
		local var_27_27 = var_9.Find(var_27_26, "text")

		i18n = var_10

		var_27_22(var_27_27, var_10("formationScene_use_oil_limit_tip"))

		local var_27_32

		if #var_27_25 > 0 then
			setActive = var_7

			local var_27_28 = arg_27_0.rtCostLimit

			var_7(var_9.Find(var_27_28, "cost_noraml"), var_27_25[1] > 0)

			setText = var_7

			local var_27_29 = arg_27_0.rtCostLimit
			local var_27_30 = var_9.Find(var_27_29, "cost_noraml/Text")

			string = var_10

			local var_27_31 = var_10.format

			var_27_32 = "%s(%d)"
			i18n = var_1_10013

			var_7(var_27_30, var_27_31(var_27_32, var_1_10013("formationScene_use_oil_limit_enemy"), var_27_25[1]))

			setActive = var_7

			local var_27_33 = arg_27_0.rtCostLimit

			var_7(var_9.Find(var_27_33, "cost_boss"), var_27_25[2] > 0)

			setText = var_7

			local var_27_34 = arg_27_0.rtCostLimit
			local var_27_35 = var_9.Find(var_27_34, "cost_boss/Text")

			string = var_10

			local var_27_36 = var_10.format

			var_27_32 = "%s(%d)"
			i18n = var_13

			var_7(var_27_35, var_27_36(var_27_32, var_13("formationScene_use_oil_limit_flagship"), var_27_25[2]))

			setActive = var_7

			local var_27_37 = arg_27_0.rtCostLimit

			var_7(var_9.Find(var_27_37, "cost_sub"), var_27_25[3] > 0)

			setText = var_7

			local var_27_38 = arg_27_0.rtCostLimit
			local var_27_39 = var_9.Find(var_27_38, "cost_sub/Text")

			string = var_10

			local var_27_40 = var_10.format

			var_27_32 = "%s(%d)"
			i18n = var_13

			var_7(var_27_39, var_27_40(var_27_32, var_13("formationScene_use_oil_limit_submarine"), var_27_25[3]))
		end

		onButton = var_7

		local var_27_41 = arg_27_0
		local var_27_42 = arg_27_0.btnGo

		local function var_27_43()
			local function var_30_0()
				local var_31_0 = arg_27_0

				var_0.onConfirm(var_31_0)

				return
			end

			local var_30_1 = arg_27_0

			if var_1.getSPItem(var_30_1) and var_1 ~= 0 then
				PlayerPrefs = var_2_10002

				if var_2_10002.GetInt("SPOPItemReminder") ~= 1 then
					Item = var_30_1

					local var_30_2 = var_30_1.getConfigData(var_1).name

					pg = var_4

					local var_30_3 = var_4.benefit_buff_template

					Chapter = var_5

					local var_30_4 = var_30_3[var_5.GetSPBuffByItem(var_1)].desc

					i18n = var_5

					local var_30_5 = var_5("levelScene_select_SP_OP_reminder", var_30_2, var_30_4)

					local function var_30_6()
						PlayerPrefs = var_3_10000

						var_3_10000.SetInt("SPOPItemReminder", 1)

						PlayerPrefs = var_0

						var_0.Save()
						var_30_0()

						return
					end

					pg = var_7

					local var_30_7 = var_7.MsgboxMgr.GetInstance()
					local var_30_8 = var_7.ShowMsgBox
					local var_30_9 = {}

					MSGBOX_TYPE_SINGLE_ITEM = var_2_10011
					var_30_9.type = var_2_10011

					local var_30_10 = {
						count = 1
					}

					DROP_TYPE_ITEM = var_2_10012
					var_30_10.type = var_2_10012
					var_30_10.id = var_1
					var_30_9.drop = var_30_10
					var_30_9.intro = var_30_5
					var_30_9.onYes = var_30_6

					var_30_8(var_30_7, var_30_9)
				else
					var_30_0()
				end
			else
				var_30_0()
			end

			return
		end

		SFX_UI_WEIGHANCHOR_GO = var_27_32

		var_7(var_27_41, var_27_42, var_27_43, var_27_32)

		setActive = var_7

		local var_27_44 = arg_27_0.btnMultiple

		AutoBotCommand = var_27_42

		local var_27_45

		if var_27_42.autoBotSatisfied() then
			var_27_32 = arg_27_0.chapter
			var_27_45 = var_10.isLoop(var_27_32)
		end

		var_7(var_27_44, var_27_45)

		onButton = var_7

		local var_27_46 = arg_27_0
		local var_27_47 = arg_27_0.btnMultiple

		local function var_27_48()
			local var_33_0 = arg_27_0
			local var_33_1 = var_0.getSelectIds(var_33_0)
			local var_33_2 = arg_27_0
			local var_33_3 = var_1.getSPItem(var_33_2)
			local var_33_4 = arg_27_0
			local var_33_5 = var_2.GetOrderedDuties(var_33_4)
			local var_33_6 = arg_27_0
			local var_33_7 = var_3.emit

			LevelUIConst = var_2_10006

			var_33_7(var_33_6, var_2_10006.OPEN_NORMAL_CONTINUOUS_WINDOW, arg_27_0.chapter, var_33_1, var_33_3, var_33_5)

			return
		end

		SFX_PANEL = var_27_32

		var_7(var_27_46, var_27_47, var_27_48, var_27_32)

		onButton = var_7

		local var_27_49 = arg_27_0
		local var_27_50 = arg_27_0.btnASHelp

		local function var_27_51()
			pg = var_2_10000

			local var_34_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_34_1 = var_0.ShowMsgBox
			local var_34_2 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_34_2.type = var_2_10004
			i18n = var_2_10004
			var_34_2.helps = var_2_10004("help_battle_ac")

			var_34_1(var_34_0, var_34_2)

			return
		end

		SFX_UI_CLICK = var_27_32

		var_7(var_27_49, var_27_50, var_27_51, var_27_32)

		onButton = var_7

		local var_27_52 = arg_27_0
		local var_27_53 = arg_27_0.btnBack

		local function var_27_54()
			local var_35_0 = arg_27_0

			var_0.onCancel(var_35_0)

			local var_35_1 = arg_27_0

			var_0.onCancelSupport(var_35_1, true)

			return
		end

		SFX_CANCEL = var_27_32

		var_7(var_27_52, var_27_53, var_27_54, var_27_32)

		onButton = var_7

		local var_27_55 = arg_27_0
		local var_27_56 = arg_27_0._tf
		local var_27_57 = var_10.Find(var_27_56, "bg")

		local function var_27_58()
			local var_36_0 = arg_27_0

			var_0.onCancel(var_36_0)

			local var_36_1 = arg_27_0

			var_0.onCancelSupport(var_36_1, true)

			return
		end

		SFX_CANCEL = var_27_56

		var_7(var_27_55, var_27_57, var_27_58, var_27_56)

		onButton = var_7

		local var_27_59 = arg_27_0
		local var_27_60 = arg_27_0.toggleMask

		local function var_27_61()
			local var_37_0 = arg_27_0

			var_0.hideToggleMask(var_37_0)

			return
		end

		SFX_CANCEL = var_27_56

		var_7(var_27_59, var_27_60, var_27_61, var_27_56)

		onToggle = var_7

		local var_27_62 = arg_27_0
		local var_27_63 = arg_27_0.formationToggle

		local function var_27_64(arg_38_0)
			if arg_38_0 then
				arg_27_0.contextData.tabIndex = var_0_1.TabIndex.Formation

				local var_38_0 = arg_27_0

				var_1.updateFleets(var_38_0)
			end

			return
		end

		SFX_PANEL = var_27_56

		var_7(var_27_62, var_27_63, var_27_64, var_27_56)

		onToggle = var_7

		local var_27_65 = arg_27_0
		local var_27_66 = arg_27_0.commanderToggle

		local function var_27_67(arg_39_0)
			if arg_39_0 then
				arg_27_0.contextData.tabIndex = var_0_1.TabIndex.Commander

				local var_39_0 = arg_27_0

				var_1.updateFleets(var_39_0)
			end

			return
		end

		SFX_PANEL = var_27_56

		var_7(var_27_65, var_27_66, var_27_67, var_27_56)

		onToggle = var_7

		local var_27_68 = arg_27_0
		local var_27_69 = arg_27_0.dutyToggle

		local function var_27_70(arg_40_0)
			if arg_40_0 then
				arg_27_0.contextData.tabIndex = var_0_1.TabIndex.Duty

				local var_40_0 = arg_27_0

				var_1.updateFleets(var_40_0)
			end

			return
		end

		SFX_PANEL = var_27_56

		var_7(var_27_68, var_27_69, var_27_70, var_27_56)

		setActive = var_7

		var_7(arg_27_0.formationToggle, true)

		setActive = var_7

		var_7(arg_27_0.commanderToggle, arg_27_0.openedCommanerSystem)

		setActive = var_7

		var_7(arg_27_0.dutyToggle, arg_27_0.dutyTabEnabled)

		setActive = var_7

		var_7(arg_27_0.adjustmentToggle, false)
		arg_27_0:clearFleets()
		arg_27_0:updateFleets()
		arg_27_0:updateLimit()
		arg_27_0:updateASValue()
		arg_27_0:UpdateSonarRange()
		arg_27_0:UpdateInvestigation()

		return
	end
end

function var_0_1.getFleetById(arg_41_0, arg_41_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_41_0.fleets, function(arg_42_0)
		return arg_42_0.id == arg_41_1
	end)
end

function var_0_1.getLimitNums(arg_43_0, arg_43_1)
	local var_43_0 = 0

	FleetType = var_1_10003

	if arg_43_1 == var_1_10003.Normal then
		local var_43_1 = arg_43_0.chapter

		var_43_0 = var_3.getConfig(var_43_1, "group_num")
	else
		FleetType = var_3

		if arg_43_1 == var_3.Submarine then
			local var_43_2 = arg_43_0.chapter

			var_43_0 = var_3.getConfig(var_43_2, "submarine_num")
		else
			FleetType = var_3

			if arg_43_1 == var_3.Support then
				local var_43_3 = arg_43_0.chapter

				var_43_0 = var_3.getConfig(var_43_3, "support_group_num")
			end
		end
	end

	return var_43_0
end

function var_0_1.getSelectIds(arg_44_0)
	local var_44_0 = {}

	ipairs = var_1_10002

	local var_44_1 = {}

	FleetType = var_1_10005
	var_44_1[1] = var_1_10005.Normal
	FleetType = var_5
	var_44_1[2] = var_5.Submarine

	for iter_44_0, iter_44_1 in var_1_10002(var_44_1) do
		local var_44_2 = arg_44_0.selectIds[iter_44_1]

		ipairs = var_1_10008

		for iter_44_2, iter_44_3 in var_1_10008(var_44_2) do
			if 0 < iter_44_3 then
				table = var_13

				var_13.insert(var_44_0, iter_44_3)
			end
		end
	end

	return var_44_0
end

function var_0_1.updateFleets(arg_45_0)
	pairs = var_1_10001

	for iter_45_0, iter_45_1 in var_1_10001(arg_45_0.tfFleets) do
		for iter_45_2 = 1, #iter_45_1 do
			FleetType = var_1_10010

			if iter_45_0 == var_1_10010.Support then
				arg_45_0:UpdateEliteFleet(iter_45_0, iter_45_2)
			else
				arg_45_0:updateFleet(iter_45_0, iter_45_2)
			end
		end
	end

	arg_45_0:RefreshDutyBar()

	return
end

function var_0_1.updateLimit(arg_46_0)
	_ = var_1_10001

	local var_46_0 = var_1_10001.filter
	local var_46_1 = arg_46_0.selectIds

	FleetType = var_1_10004

	local var_46_2 = #var_46_0(var_46_1[var_1_10004.Normal], function(arg_47_0)
		return arg_47_0 > 0
	end)

	_ = var_1_10002

	local var_46_3 = var_1_10002.filter
	local var_46_4 = arg_46_0.selectIds

	FleetType = var_1_10005

	local var_46_5 = #var_46_3(var_46_4[var_1_10005.Submarine], function(arg_48_0)
		return arg_48_0 > 0
	end)
	local var_46_6 = arg_46_0
	local var_46_7 = arg_46_0.getLimitNums

	FleetType = var_1_10006

	local var_46_8 = var_46_7(var_46_6, var_1_10006.Normal)

	setText = var_4

	local var_46_9 = arg_46_0.tfLimit
	local var_46_10 = var_6.Find(var_46_9, "number")

	string = var_1_10007

	var_4(var_46_10, var_1_10007.format("%d/%d", var_46_2, var_46_8))

	local var_46_11 = arg_46_0
	local var_46_12 = arg_46_0.getLimitNums

	FleetType = var_7

	local var_46_13 = var_46_12(var_46_11, var_7.Submarine)

	setText = var_46_6

	local var_46_14 = arg_46_0.tfLimit
	local var_46_15 = var_7.Find(var_46_14, "number_sub")

	string = var_46_9

	var_46_6(var_46_15, var_46_9.format("%d/%d", var_46_5, var_46_13))

	return
end

function var_0_1.selectFleet(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = arg_49_0.selectIds[arg_49_1]

	if 0 < arg_49_3 then
		table = var_5

		if var_5.contains(var_49_0, arg_49_3) then
			return
		end
	end

	FleetType = var_5

	if arg_49_1 == var_5.Normal and arg_49_0:getLimitNums(arg_49_1) > 0 and arg_49_3 == 0 then
		_ = var_5

		if #var_5.filter(var_49_0, function(arg_50_0)
			return arg_50_0 > 0
		end) == 1 then
			pg = var_5

			local var_49_1 = var_5.TipsMgr.GetInstance()
			local var_49_2 = var_5.ShowTips

			i18n = var_8

			var_49_2(var_49_1, var_8("level_fleet_lease_one_ship"))

			return
		end
	end

	if arg_49_0:getFleetById(arg_49_3) then
		if not var_5:isUnlock() then
			return
		end

		if var_5:isLegalToFight() ~= true then
			pg = var_6

			local var_49_3 = var_6.TipsMgr.GetInstance()
			local var_49_4 = var_6.ShowTips

			i18n = var_1_10009

			var_49_4(var_49_3, var_1_10009("level_fleet_not_enough"))

			return
		end
	end

	local var_49_5 = {
		not arg_49_0:IsListOfFleetEmpty(1) or nil,
		not arg_49_0:IsListOfFleetEmpty(2) or nil
	}
	local var_49_6 = var_49_0[arg_49_2]

	var_49_0[arg_49_2] = arg_49_3

	arg_49_0:updateFleet(arg_49_1, arg_49_2)
	arg_49_0:updateLimit()
	arg_49_0:updateASValue()
	arg_49_0:UpdateSonarRange()
	arg_49_0:RefreshDutyBar()

	local var_49_7 = {
		not arg_49_0:IsListOfFleetEmpty(1) or nil,
		not arg_49_0:IsListOfFleetEmpty(2) or nil
	}

	if arg_49_0.dutyTabEnabled then
		table = var_9

		if var_9.getCount(var_49_5) == 2 then
			table = var_9

			if var_9.getCount(var_49_7) == 1 then
				pg = var_9

				local var_49_8 = var_9.TipsMgr.GetInstance()
				local var_49_9 = var_9.ShowTips

				i18n = var_12

				var_49_9(var_49_8, var_12("autofight_change_tip"))
			end
		end
	end

	arg_49_0:UpdateInvestigation()

	return
end

function var_0_1.updateFleet(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_0.contextData.tabIndex == var_0_1.TabIndex.Formation
	local var_51_1 = arg_51_0.contextData.tabIndex == var_0_1.TabIndex.Commander
	local var_51_2 = arg_51_0.contextData.tabIndex == var_0_1.TabIndex.Duty
	local var_51_3 = arg_51_0.contextData.tabIndex == var_0_1.TabIndex.Adjustment
	local var_51_4 = arg_51_0.selectIds[arg_51_1][arg_51_2]
	local var_51_5 = arg_51_0:getFleetById(var_51_4)
	local var_51_6 = arg_51_0
	local var_51_7 = arg_51_2 <= arg_51_0.getLimitNums(var_51_6, arg_51_1)
	local var_51_8 = arg_51_0.tfFleets[arg_51_1][arg_51_2]

	findTF = var_51_6

	local var_51_9 = var_51_6(var_51_8, "bg/name")
	local var_51_10 = var_51_8:Find("btn_select")
	local var_51_11 = var_51_8:Find("btn_recom")
	local var_51_12 = var_51_8:Find("btn_clear")
	local var_51_13 = var_51_8:Find("blank")
	local var_51_14 = var_51_8:Find("selected")
	local var_51_15 = var_51_8
	local var_51_16 = var_51_8.Find(var_51_15, "commander")
	local var_51_17 = var_51_8:Find("adjustment_flag")

	setActive = var_51_15

	var_51_15(var_51_11, false)

	setActive = var_51_15

	var_51_15(var_51_14, false)

	setText = var_51_15

	var_51_15(var_51_9, "")

	local var_51_18 = var_51_8
	local var_51_19 = var_51_8.Find

	TeamType = var_23

	local var_51_20 = var_51_19(var_51_18, var_23.Main)
	local var_51_21 = var_51_8
	local var_51_22 = var_51_8.Find

	TeamType = var_1_10024

	local var_51_23 = var_51_22(var_51_21, var_1_10024.Vanguard)

	if not var_51_7 then
		setActive = var_51_18

		var_51_18(var_51_12, false)

		setActive = var_51_18

		var_51_18(var_51_10, false)

		setActive = var_51_18

		var_51_18(var_51_16, false)

		setActive = var_51_18

		var_51_18(var_51_17, false)

		setActive = var_51_18

		var_51_18(var_51_13, true)

		setActive = var_51_18

		var_51_18(var_51_20, false)

		FleetType = var_51_18

		if arg_51_1 == var_51_18.Normal then
			setActive = var_51_18

			var_51_18(var_51_23, false)
		end

		return
	end

	setActive = var_51_18

	var_51_18(var_51_12, var_51_0)

	setActive = var_51_18

	var_51_18(var_51_10, var_51_0)

	setActive = var_51_18

	var_51_18(var_51_16, var_51_1 and var_51_5)

	setActive = var_51_18

	var_51_18(var_51_17, var_51_3)

	setActive = var_51_18

	var_51_18(var_51_13, var_51_2 or var_51_3 or var_51_1 and not var_51_5)

	setText = var_51_18

	local var_51_24 = var_51_9

	if var_51_5 then
		var_1_10027 = var_51_5

		local var_51_25

		if not var_51_5.GetName(var_1_10027) then
			var_51_25 = ""
		end

		var_51_18(var_51_24, var_51_25)

		setActive = var_51_18

		var_51_18(var_51_20, var_51_5)

		FleetType = var_51_18

		if arg_51_1 == var_51_18.Normal then
			setActive = var_22

			var_22(var_51_23, var_51_5)
		end

		if var_51_5 then
			FleetType = var_22

			if arg_51_1 == var_22.Submarine then
				arg_51_0:updateShips(var_51_20, var_51_5.subShips)
			else
				arg_51_0:updateShips(var_51_20, var_51_5.mainShips)
				arg_51_0:updateShips(var_51_23, var_51_5.vanguardShips)
			end

			arg_51_0:updateCommanders(var_51_16, var_51_5)
		end

		onButton = var_22

		local var_51_26 = arg_51_0
		local var_51_27 = var_51_10

		local function var_51_28()
			arg_51_0.toggleList.position = (var_51_10.position + var_51_12.position) / 2

			local var_52_0 = arg_51_0.toggleList
			local var_52_1 = arg_51_0.toggleList.anchoredPosition

			Vector2 = var_2
			var_52_0.anchoredPosition = var_52_1 + var_2(-arg_51_0.toggleList.rect.width / 2, -var_51_10.rect.height / 2)

			local var_52_2 = arg_51_0

			var_0.showToggleMask(var_52_2, arg_51_1, function(arg_53_0)
				local var_53_0 = arg_51_0

				var_1.hideToggleMask(var_53_0)

				local var_53_1 = arg_51_0

				var_1.selectFleet(var_53_1, arg_51_1, arg_51_2, arg_53_0)

				return
			end)

			return
		end

		SFX_UI_CLICK = var_1_10027

		var_22(var_51_26, var_51_27, var_51_28, var_1_10027)

		onButton = var_22

		local var_51_29 = arg_51_0
		local var_51_30 = var_51_12

		local function var_51_31()
			local var_54_0 = arg_51_0

			var_0.selectFleet(var_54_0, arg_51_1, arg_51_2, 0)

			return
		end

		SFX_UI_CLICK = var_1_10027

		var_22(var_51_29, var_51_30, var_51_31, var_1_10027)

		return
	end
end

function var_0_1.updateCommanders(arg_55_0, arg_55_1, arg_55_2)
	for iter_55_0 = 1, 2 do
		local var_55_0 = arg_55_2:getCommanderByPos(iter_55_0)
		local var_55_1 = arg_55_1:Find("pos" .. iter_55_0)
		local var_55_2 = var_8.Find(var_55_1, "add")
		local var_55_3 = var_8
		local var_55_4 = var_8.Find(var_55_3, "info")

		setActive = var_55_1

		var_55_1(var_55_2, not var_55_0)

		setActive = var_55_1

		var_55_1(var_55_4, var_55_0)

		if var_55_0 then
			Commander = var_55_1
			var_55_1 = var_55_1.rarity2Frame

			local var_55_5 = var_55_0

			var_55_1 = var_55_1(var_55_0.getRarity(var_55_5))
			setImageSprite = var_55_3
			var_1_10016 = var_55_4

			local var_55_6 = var_55_4.Find(var_1_10016, "frame")

			GetSpriteFromAtlas = var_55_5

			var_55_3(var_55_6, var_55_5("weaponframes", "commander_" .. var_55_1))

			GetImageSpriteFromAtlasAsync = var_55_3

			var_55_3("CommanderHrz/" .. var_55_0:getPainting(), "", var_55_4:Find("mask/icon"))
		end

		onButton = var_55_1

		local var_55_7 = arg_55_0
		local var_55_8 = var_55_2

		local function var_55_9()
			local var_56_0 = arg_55_0
			local var_56_1 = var_0.emit

			LevelUIConst = var_2_10003

			var_56_1(var_56_0, var_2_10003.OPEN_COMMANDER_PANEL, arg_55_2, arg_55_0.chapter)

			return
		end

		SFX_PANEL = var_1_10016

		var_55_1(var_55_7, var_55_8, var_55_9, var_1_10016)

		onButton = var_55_1

		local var_55_10 = arg_55_0
		local var_55_11 = var_55_4

		local function var_55_12()
			local var_57_0 = arg_55_0
			local var_57_1 = var_0.emit

			LevelUIConst = var_2_10003

			var_57_1(var_57_0, var_2_10003.OPEN_COMMANDER_PANEL, arg_55_2, arg_55_0.chapter)

			return
		end

		SFX_PANEL = var_1_10016

		var_55_1(var_55_10, var_55_11, var_55_12, var_1_10016)
	end

	return
end

function var_0_1.updateShips(arg_58_0, arg_58_1, arg_58_2)
	UIItemList = var_1_10003

	local var_58_0 = var_1_10003.New(arg_58_1, arg_58_0.tfShipTpl)

	var_3.make(var_58_0, function(arg_59_0, arg_59_1, arg_59_2)
		UIItemList = var_2_10003

		if arg_59_0 == var_2_10003.EventUpdate then
			getProxy = var_3
			BayProxy = var_2_10005

			local var_59_0 = var_3(var_2_10005)
			local var_59_1 = var_3.getShipById(var_59_0, arg_58_2[arg_59_1 + 1])

			updateShip = var_2_10005

			var_2_10005(arg_59_2, var_59_1)

			setActive = var_2_10005
			findTF = var_7

			var_2_10005(var_7(arg_59_2, "ship_type"), false)

			local var_59_2 = arg_59_2
			local var_59_3 = arg_59_2.Find(var_59_2, "icon_bg/energy")

			if var_59_1:getEnergeConfig() and var_6.id <= 2 then
				setActive = var_59_2

				var_59_2(var_59_3, true)

				GetImageSpriteFromAtlasAsync = var_59_2

				var_59_2("energy", var_6.icon, var_59_3)
			else
				setActive = var_59_2

				var_59_2(var_59_3, false)
			end
		end

		return
	end)
	var_3:align(#arg_58_2)

	ipairs = var_4

	for iter_58_0, iter_58_1 in var_4(arg_58_2) do
		local var_58_1 = arg_58_1
		local var_58_2 = arg_58_1.GetChild(var_58_1, iter_58_0 - 1)

		GetOrAddComponent = var_1_10010
		var_1_10010 = var_1_10010(var_58_2, "UILongPressTrigger").onLongPressed
		pg = var_58_1

		var_58_1.DelegateInfo.Add(arg_58_0, var_1_10010)
		var_1_10010:RemoveAllListeners()
		var_1_10010:AddListener(function()
			local var_60_0 = arg_58_0
			local var_60_1 = var_0.emit

			LevelMediator2 = var_2_10003

			var_60_1(var_60_0, var_2_10003.ON_SHIP_DETAIL, {
				id = iter_58_1,
				chapter = arg_58_0.chapter
			})

			return
		end)
	end

	return
end

function var_0_1.showToggleMask(arg_61_0, arg_61_1, arg_61_2)
	setActive = var_1_10003

	var_1_10003(arg_61_0.toggleMask, true)

	_ = var_1_10003

	local var_61_0 = var_1_10003.filter(arg_61_0.fleets, function(arg_62_0)
		return arg_62_0:getFleetType() == arg_61_1
	end)

	ipairs = var_1_10004

	for iter_61_0, iter_61_1 in var_1_10004(arg_61_0.toggles) do
		local var_61_1 = var_61_0[iter_61_0]

		setActive = var_1_10010

		var_1_10010(iter_61_1, var_61_1)

		if var_61_1 then
			local var_61_2 = iter_61_1

			var_1_10010 = iter_61_1.GetComponent
			typeof = var_13
			Toggle = var_1_10015
			var_1_10010 = var_1_10010(var_61_2, var_13(var_1_10015))

			local var_61_3 = iter_61_1:Find("lock")
			local var_61_4 = var_61_1
			local var_61_5, var_61_6 = var_61_1.isUnlock(var_61_4)

			setToggleEnabled = var_61_4

			var_61_4(iter_61_1, var_61_5)

			setActive = var_61_4

			var_61_4(var_61_3, not var_61_5)

			table = var_61_4

			local var_61_7 = var_61_4.contains(arg_61_0.selectIds[arg_61_1], var_61_1.id)

			setActive = var_1_10015

			var_1_10015(iter_61_1:Find("on"), var_61_7)

			setActive = var_1_10015

			var_1_10015(iter_61_1:Find("off"), not var_61_7)

			if var_61_5 then
				var_1_10010.isOn = false
				onToggle = var_1_10015

				local var_61_8 = arg_61_0
				local var_61_9 = iter_61_1

				local function var_61_10(arg_63_0)
					if arg_63_0 then
						setActive = var_2_10001

						var_2_10001(arg_61_0.toggleMask, false)
						arg_61_2(var_61_1.id)
					end

					return
				end

				SFX_UI_TAG = var_20

				var_1_10015(var_61_8, var_61_9, var_61_10, var_20)
			else
				onButton = var_1_10015

				local var_61_11 = arg_61_0
				local var_61_12 = var_61_3

				local function var_61_13()
					pg = var_2_10000

					local var_64_0 = var_2_10000.TipsMgr.GetInstance()

					var_0.ShowTips(var_64_0, var_61_6)

					return
				end

				SFX_UI_CLICK = var_20

				var_1_10015(var_61_11, var_61_12, var_61_13, var_20)
			end
		end
	end

	return
end

function var_0_1.hideToggleMask(arg_65_0)
	setActive = var_1_10001

	var_1_10001(arg_65_0.toggleMask, false)

	return
end

function var_0_1.clearFleets(arg_66_0)
	pairs = var_1_10001

	for iter_66_0, iter_66_1 in var_1_10001(arg_66_0.tfFleets) do
		_ = var_1_10006

		var_1_10006.each(iter_66_1, function(arg_67_0)
			local var_67_0 = arg_66_0

			var_1.clearFleet(var_67_0, arg_67_0)

			return
		end)
	end

	return
end

function var_0_1.UpdateInvestigation(arg_68_0)
	local var_68_0 = arg_68_0.chapter

	if not var_1.existAmbush(var_68_0) then
		arg_68_0:UpdateLoopInvestigation()

		return
	end

	local var_68_1 = 0

	for iter_68_0 = 1, 2 do
		local var_68_2 = arg_68_0.selectIds

		FleetType = var_1_10007

		local var_68_3

		if not var_68_2[var_1_10007.Normal][iter_68_0] then
			var_68_3 = 0
		end

		local var_68_4 = arg_68_0

		if arg_68_0.getFleetById(var_68_4, var_68_3) then
			math = var_1_10008

			if not var_1_10008.floor(var_1_10007:getInvestSums(true)) then
				var_1_10008 = 0
			end

			math = var_68_4
			var_68_1 = var_68_4.max(var_68_1, var_1_10008)
		end
	end

	local var_68_5 = arg_68_0.chapter
	local var_68_6 = var_2.getConfig(var_68_5, "avoid_require")

	arg_68_0:UpdateInvestigationComparision(var_68_1, var_68_6)

	return
end

function var_0_1.UpdateEliteInvestigation(arg_69_0)
	local var_69_0 = arg_69_0.chapter

	if not var_1.existAmbush(var_69_0) then
		arg_69_0:UpdateLoopInvestigation()

		return
	end

	local var_69_1 = 0

	for iter_69_0 = 1, 2 do
		local var_69_2 = 0
		local var_69_3 = arg_69_0.chapter
		local var_69_4

		if iter_69_0 <= var_7.GetNomralFleetMaxCount(var_69_3) then
			var_69_4 = arg_69_0.eliteFleetList[iter_69_0]

			local var_69_5 = {}

			pairs = var_69_3

			for iter_69_1, iter_69_2 in var_69_3(arg_69_0.eliteCommanderList[iter_69_0]) do
				table = var_1_10014

				var_1_10014.insert(var_69_5, {
					pos = iter_69_1,
					id = iter_69_2
				})
			end

			TypedFleet = var_9

			local var_69_6 = var_9.New
			local var_69_7 = {
				ship_list = var_69_4,
				commanders = var_69_5
			}

			FleetType = iter_69_1
			var_69_7.fleetType = iter_69_1.Normal

			local var_69_8 = var_69_6(var_69_7)

			math = var_10

			local var_69_9 = var_10.floor

			var_1_10014 = var_69_8
			var_69_2 = var_69_9(var_69_8.getInvestSums(var_1_10014))
		end

		math = var_69_4
		var_69_1 = var_69_4.max(var_69_1, var_69_2)
	end

	local var_69_10 = arg_69_0.chapter
	local var_69_11 = var_2.getConfig(var_69_10, "avoid_require")

	arg_69_0:UpdateInvestigationComparision(var_69_1, var_69_11)

	return
end

function var_0_1.UpdateLoopInvestigation(arg_70_0)
	local var_70_0 = arg_70_0.dropDown
	local var_70_1 = var_1.Find(var_70_0, "Investigation")

	setText = var_1_10002

	var_1_10002(var_70_1:Find("Value1"), "-")

	setText = var_1_10002

	var_1_10002(var_70_1:Find("Value2"), "-")

	triggerToggle = var_1_10002

	local var_70_2 = arg_70_0.dropDownSide

	var_1_10002(var_4.Find(var_70_2, "Layout/Item1/Dot"), true)

	return
end

function var_0_1.UpdateInvestigationComparision(arg_71_0, arg_71_1, arg_71_2)
	math = var_1_10003
	arg_71_1 = var_1_10003.floor(arg_71_1)

	local var_71_0 = arg_71_0.dropDown
	local var_71_1 = var_3.Find(var_71_0, "Investigation")
	local var_71_2 = arg_71_2 <= arg_71_1

	setText = var_71_0

	local var_71_3 = var_71_1:Find("Value1")

	setColorStr = var_1_10008

	local var_71_4 = arg_71_1

	if var_71_2 then
		var_1_10011 = "#51FF55"
	else
		COLOR_WHITE = var_1_10011
	end

	var_71_0(var_71_3, var_1_10008(var_71_4, var_1_10011))

	setText = var_71_0

	var_71_0(var_71_1:Find("Value2"), arg_71_2)

	triggerToggle = var_71_0

	local var_71_5 = arg_71_0.dropDownSide

	var_71_0(var_7.Find(var_71_5, "Layout/Item1/Dot"), var_71_2)

	return
end

function var_0_1.updateASValue(arg_72_0)
	if arg_72_0.chapterASValue <= 0 then
		arg_72_0:UpdateBannedAS()

		return
	end

	local var_72_0 = 0

	for iter_72_0 = 1, 2 do
		local var_72_1 = arg_72_0.selectIds

		FleetType = var_1_10007

		local var_72_2

		if not var_72_1[var_1_10007.Normal][iter_72_0] then
			var_72_2 = 0
		end

		local var_72_3

		if not arg_72_0:getFleetById(var_72_2) or not var_1_10007:getFleetAirDominanceValue() then
			var_72_3 = 0
		end

		var_72_0 = var_72_0 + var_72_3
	end

	for iter_72_1 = 1, 1 do
		local var_72_4 = arg_72_0.selectIds

		FleetType = var_1_10007

		local var_72_5

		if not var_72_4[var_1_10007.Submarine][iter_72_1] then
			var_72_5 = 0
		end

		local var_72_6

		if not arg_72_0:getFleetById(var_72_5) or not var_1_10007:getFleetAirDominanceValue() then
			var_72_6 = 0
		end

		var_72_0 = var_72_0 + var_72_6
	end

	arg_72_0:UpdateASComparision(var_72_0, arg_72_0.suggestionValue)

	return
end

function var_0_1.updateEliteASValue(arg_73_0)
	if arg_73_0.chapterASValue <= 0 then
		var_1_10003 = arg_73_0

		arg_73_0.UpdateBannedAS(var_1_10003)

		return
	end

	getProxy = var_1
	BayProxy = var_1_10003

	local var_73_0 = var_1(var_1_10003)
	local var_73_1 = 0

	ipairs = var_1_10003

	for iter_73_0, iter_73_1 in var_1_10003(arg_73_0.eliteFleetList) do
		local var_73_2 = {}

		pairs = var_1_10009

		for iter_73_2, iter_73_3 in var_1_10009(arg_73_0.eliteCommanderList[iter_73_0]) do
			getProxy = var_1_10014
			CommanderProxy = var_1_10016
			var_1_10016 = var_1_10014(var_1_10016)
			var_73_2[iter_73_2] = var_1_10014.RawGetCommanderById(var_1_10016, iter_73_3)
		end

		ipairs = var_1_10009

		for iter_73_4, iter_73_5 in var_1_10009(iter_73_1) do
			calcAirDominanceValue = var_1_10014
			var_73_1 = var_73_1 + var_1_10014(var_73_0:RawGetShipById(iter_73_5), var_73_2)
		end
	end

	arg_73_0:UpdateASComparision(var_73_1, arg_73_0.suggestionValue)

	return
end

function var_0_1.UpdateBannedAS(arg_74_0)
	local var_74_0 = arg_74_0.dropDown
	local var_74_1 = var_1.Find(var_74_0, "Airsupport")

	setText = var_1_10002

	var_1_10002(var_74_1:Find("Value1"), "-")

	setText = var_1_10002

	var_1_10002(var_74_1:Find("Value2"), "-")

	triggerToggle = var_1_10002

	local var_74_2 = arg_74_0.dropDownSide

	var_1_10002(var_4.Find(var_74_2, "Layout/Item2/Dot"), true)

	return
end

function var_0_1.UpdateASComparision(arg_75_0, arg_75_1, arg_75_2)
	math = var_1_10003
	arg_75_1 = var_1_10003.floor(arg_75_1)

	local var_75_0 = arg_75_0.dropDown
	local var_75_1 = var_3.Find(var_75_0, "Airsupport")

	setText = var_1_10004

	local var_75_2 = var_75_1
	local var_75_3 = var_75_1.Find(var_75_2, "Text")

	i18n = var_1_10007

	var_1_10004(var_75_3, var_1_10007("level_scene_title_word_3"))

	local var_75_4 = arg_75_2 < arg_75_1

	setText = var_75_0

	local var_75_5 = var_75_1:Find("Value1")

	setColorStr = var_75_2

	local var_75_6 = arg_75_1

	if var_75_4 then
		var_1_10011 = "#51FF55"
	else
		COLOR_WHITE = var_1_10011
	end

	var_75_0(var_75_5, var_75_2(var_75_6, var_1_10011))

	setText = var_75_0

	var_75_0(var_75_1:Find("Value2"), arg_75_2)

	triggerToggle = var_75_0

	local var_75_7 = arg_75_0.dropDownSide

	var_75_0(var_7.Find(var_75_7, "Layout/Item2/Dot"), var_75_4)

	return
end

function var_0_1.UpdateSonarRange(arg_76_0)
	for iter_76_0 = 1, 2 do
		local var_76_0 = arg_76_0.selectIds

		FleetType = var_1_10006

		local var_76_1

		if not var_76_0[var_1_10006.Normal][iter_76_0] then
			var_76_1 = 0
		end

		if arg_76_0:getFleetById(var_76_1) then
			math = var_1_10007

			if not var_1_10007.floor(var_1_10006:GetFleetSonarRange()) then
				var_1_10007 = 0
			end

			arg_76_0:UpdateSonarRangeValues(iter_76_0, var_1_10007)
		end
	end

	return
end

function var_0_1.UpdateEliteSonarRange(arg_77_0)
	for iter_77_0 = 1, 2 do
		if not arg_77_0.eliteFleetList[iter_77_0] then
			var_1_10007 = arg_77_0

			arg_77_0.UpdateSonarRangeValues(var_1_10007, iter_77_0, 0)

			goto label_77_0
		end

		local var_77_0 = arg_77_0.eliteFleetList[iter_77_0]
		local var_77_1 = {}

		pairs = var_1_10007

		for iter_77_1, iter_77_2 in var_1_10007(arg_77_0.eliteCommanderList[iter_77_0]) do
			table = var_1_10012

			var_1_10012.insert(var_77_1, {
				pos = iter_77_1,
				id = iter_77_2
			})
		end

		TypedFleet = var_1_10007
		var_1_10007 = var_1_10007.New

		local var_77_2 = {
			ship_list = var_77_0,
			commanders = var_77_1
		}

		FleetType = iter_77_1
		var_77_2.fleetType = iter_77_1.Normal

		if var_1_10007(var_77_2) then
			math = var_8

			do
				local var_77_3 = var_8.floor

				var_1_10012 = var_1_10007

				local var_77_4

				if not var_77_3(var_1_10007.GetFleetSonarRange(var_1_10012)) then
					var_77_4 = 0
				end

				arg_77_0:UpdateSonarRangeValues(iter_77_0, var_77_4)
			end

			::label_77_0::
		end
	end

	return
end

function var_0_1.UpdateSonarRangeValues(arg_78_0, arg_78_1, arg_78_2)
	local var_78_0 = arg_78_0.dropDownSide
	local var_78_1 = var_3.Find(var_78_0, "Layout/Item3/Values")

	setText = var_1_10004

	var_1_10004(var_78_1:GetChild(arg_78_1 - 1), arg_78_2)

	return
end

function var_0_1.clearFleet(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_1
	local var_79_1 = arg_79_1.Find

	TeamType = var_1_10005

	local var_79_2 = var_79_1(var_79_0, var_1_10005.Main)
	local var_79_3 = arg_79_1
	local var_79_4 = arg_79_1.Find

	TeamType = var_1_10006

	local var_79_5 = var_79_4(var_79_3, var_1_10006.Vanguard)

	if var_79_2 then
		removeAllChildren = var_79_0

		var_79_0(var_79_2)
	end

	if var_79_5 then
		removeAllChildren = var_79_0

		var_79_0(var_79_5)
	end

	return
end

function var_0_1.clear(arg_80_0)
	arg_80_0.contextData.tabIndex = nil
	arg_80_0.duties = nil

	return
end

function var_0_1.onCancelHard(arg_81_0, arg_81_1)
	if arg_81_1 then
		local var_81_0 = arg_81_0
		local var_81_1 = arg_81_0.emit

		LevelMediator2 = var_1_10005

		var_81_1(var_81_0, var_1_10005.ON_UPDATE_CUSTOM_FLEET, arg_81_0.chapter)
	end

	local var_81_2 = arg_81_0
	local var_81_3 = arg_81_0.emit

	LevelUIConst = var_1_10005

	var_81_3(var_81_2, var_1_10005.HIDE_FLEET_EDIT)

	return
end

function var_0_1.setHardShipVOs(arg_82_0, arg_82_1)
	arg_82_0.shipVOs = arg_82_1

	return
end

function var_0_1.setOnHard(arg_83_0, arg_83_1)
	arg_83_0.chapter = arg_83_1
	arg_83_0.mode = var_0_3.EDIT

	local var_83_0 = arg_83_0.chapter

	arg_83_0.eliteFleetList = var_2.getEliteFleetList(var_83_0)

	local var_83_1 = arg_83_0.chapter

	arg_83_0.eliteCommanderList = var_2.getEliteFleetCommanders(var_83_1)

	local var_83_2 = arg_83_0.chapter

	arg_83_0.propetyLimitation = var_2.getConfig(var_83_2, "property_limitation")

	local var_83_3 = arg_83_0.chapter

	arg_83_0.chapterASValue = var_2.getConfig(var_83_3, "air_dominance")

	local var_83_4 = arg_83_0.chapter

	arg_83_0.suggestionValue = var_2.getConfig(var_83_4, "best_air_dominance")

	local var_83_5 = arg_83_0.chapter

	arg_83_0.typeLimitations = var_2.getConfig(var_83_5, "limitation")

	arg_83_0:SetDutyTabEnabled(arg_83_1:isLoop())

	local var_83_6 = arg_83_0
	local var_83_7 = arg_83_0.getLimitNums

	FleetType = var_5

	local var_83_8 = var_83_7(var_83_6, var_5.Support)
	local var_83_9 = 0 < var_83_8

	setActive = var_3

	var_3(arg_83_0.supportFleetHelp, var_83_9)

	local var_83_10

	if not var_83_9 or not var_0_4.ADDITION_SUPPORT then
		var_83_10 = var_0_4.NORMAL
	end

	arg_83_0.displayMode = var_83_10

	arg_83_0:SwitchDisplayMode()

	arg_83_0.duties = {}
	PlayerPrefs = var_3

	local var_83_11 = var_3.GetInt
	local var_83_12 = "lastFleetDuty_"
	local var_83_13

	if not arg_83_0.chapter.id then
		var_83_13 = 0
	end

	local var_83_14 = var_83_11(var_83_12 .. var_83_13, 0)
	local var_83_15

	if 0 < var_83_14 then
		bit = var_83_15
		var_83_15 = var_83_15.band(var_83_14, 255)
		bit = var_5

		local var_83_16 = var_5.rshift(var_83_14, 8)

		bit = var_5

		local var_83_17 = var_5.band(var_83_16, 255)

		if var_83_15 > 0 and var_83_17 > 0 then
			arg_83_0.duties[var_83_15] = var_83_17
		end
	end

	onButton = var_83_15

	local var_83_18 = arg_83_0
	local var_83_19 = arg_83_0.btnGo

	local function var_83_20()
		local var_84_0 = "chapter_autofight_flag_" .. arg_83_0.chapter.id
		local var_84_1 = arg_83_0.chapter
		local var_84_2
		local var_84_3

		seriesAsync = var_2_10004

		var_2_10004({
			function(arg_85_0)
				PlayerPrefs = var_3_10001

				local var_85_0 = var_3_10001.GetInt("autoFight_firstUse_sp", 0) == 1

				PlayerPrefs = var_3_10002

				if var_3_10002.GetInt(var_84_0, 1) == 1 then
					local var_85_1 = arg_83_0

					if not var_3.getSPItem(var_85_1) or var_85_0 then
						return arg_85_0()
					end

					PlayerPrefs = var_3

					var_3.SetInt("autoFight_firstUse_sp", 1)

					PlayerPrefs = var_3

					var_3.Save()

					local function var_85_2()
						local var_86_0 = arg_83_0

						var_0.clearSPBuff(var_86_0)

						return
					end

					local var_85_3 = arg_83_0
					local var_85_4 = var_4.emit

					LevelUIConst = var_3_10007

					local var_85_5 = var_3_10007.HANDLE_SHOW_MSG_BOX
					local var_85_6 = {
						hideNo = true
					}

					i18n = var_3_10009
					var_85_6.content = var_3_10009("autofight_special_operation_tip")
					var_85_6.onYes = var_85_2
					var_85_6.onNo = var_85_2

					var_85_4(var_85_3, var_85_5, var_85_6)

					return
				end
			end,
			function(arg_87_0)
				local var_87_0 = arg_83_0.chapter

				var_84_2 = var_1.GetActiveSPItemID(var_87_0)

				local var_87_1 = arg_83_0.chapter

				if var_1.isLoop(var_87_1) then
					local var_87_2 = arg_83_0
					local var_87_3

					if not var_1.GetOrderedDuties(var_87_2) then
						var_87_3 = nil
					end

					var_84_3 = var_87_3

					local var_87_4 = arg_83_0

					var_1.clear(var_87_4)

					local var_87_5 = arg_83_0

					var_1.onCancelHard(var_87_5)
					arg_87_0()

					return
				end
			end,
			function(arg_88_0)
				PlayerPrefs = var_3_10001

				local var_88_0 = var_3_10001.GetInt(var_84_0, 1) == 1

				LevelMediator2 = var_3_10002

				local var_88_1 = var_3_10002.ON_ELITE_TRACKING

				packEx = var_3

				local var_88_2 = var_3(var_84_1.id, var_84_1.loopFlag, var_84_2, var_84_3, var_88_0)

				pg = var_4

				local var_88_3 = var_4.m02
				local var_88_4 = var_4.retrieveMediator

				LevelMediator2 = var_7

				local var_88_5

				if var_88_4(var_88_3, var_7.__cname) then
					pg = var_5
					var_88_5 = var_5.m02

					var_5.sendNotification(var_88_5, var_88_1, var_88_2)

					return
				end

				getProxy = var_5
				ContextProxy = var_88_5

				local var_88_6 = var_5(var_88_5)
				local var_88_7 = var_5.getContextByMediator

				LevelMediator2 = var_8

				if var_88_7(var_88_6, var_8) then
					var_5:extendData({
						ToTrackingData = {
							var_88_1,
							var_88_2
						}
					})
				end

				return
			end
		})

		return
	end

	SFX_UI_WEIGHANCHOR_GO = var_1_10009

	var_83_15(var_83_18, var_83_19, var_83_20, var_1_10009)

	setActive = var_83_15

	local var_83_21 = arg_83_0.btnMultiple

	AutoBotCommand = var_83_19

	local var_83_22

	if var_83_19.autoBotSatisfied() then
		var_1_10009 = arg_83_0.chapter
		var_83_22 = var_7.isLoop(var_1_10009)
	end

	var_83_15(var_83_21, var_83_22)

	onButton = var_83_15

	local var_83_23 = arg_83_0
	local var_83_24 = arg_83_0.btnMultiple

	local function var_83_25()
		local var_89_0 = arg_83_0
		local var_89_1 = var_0.getSPItem(var_89_0)
		local var_89_2 = arg_83_0
		local var_89_3 = var_1.GetOrderedDuties(var_89_2)
		local var_89_4 = arg_83_0
		local var_89_5 = var_2.emit

		LevelUIConst = var_2_10005

		var_89_5(var_89_4, var_2_10005.OPEN_ELITE_CONTINUOUS_WINDOW, arg_83_0.chapter, var_89_1, var_89_3)

		return
	end

	SFX_PANEL = var_1_10009

	var_83_15(var_83_23, var_83_24, var_83_25, var_1_10009)

	onButton = var_83_15

	local var_83_26 = arg_83_0
	local var_83_27 = arg_83_0.btnASHelp

	local function var_83_28()
		pg = var_2_10000

		local var_90_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_90_1 = var_0.ShowMsgBox
		local var_90_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_90_2.type = var_2_10004
		i18n = var_2_10004
		var_90_2.helps = var_2_10004("help_battle_ac")

		var_90_1(var_90_0, var_90_2)

		return
	end

	SFX_UI_CLICK = var_1_10009

	var_83_15(var_83_26, var_83_27, var_83_28, var_1_10009)

	onButton = var_83_15

	local var_83_29 = arg_83_0
	local var_83_30 = arg_83_0.btnBack

	local function var_83_31()
		local var_91_0 = arg_83_0

		var_0.clear(var_91_0)

		local var_91_1 = arg_83_0

		var_0.onCancelHard(var_91_1, true)

		return
	end

	SFX_CANCEL = var_1_10009

	var_83_15(var_83_29, var_83_30, var_83_31, var_1_10009)

	onButton = var_83_15

	local var_83_32 = arg_83_0
	local var_83_33 = arg_83_0._tf
	local var_83_34 = var_7.Find(var_83_33, "bg")

	local function var_83_35()
		local var_92_0 = arg_83_0

		var_0.clear(var_92_0)

		local var_92_1 = arg_83_0

		var_0.onCancelHard(var_92_1, true)

		return
	end

	SFX_CANCEL = var_83_33

	var_83_15(var_83_32, var_83_34, var_83_35, var_83_33)

	onToggle = var_83_15

	local var_83_36 = arg_83_0
	local var_83_37 = arg_83_0.commanderToggle

	local function var_83_38(arg_93_0)
		if arg_93_0 then
			arg_83_0.contextData.tabIndex = var_0_1.TabIndex.Commander

			local var_93_0 = arg_83_0

			var_1.flush(var_93_0)
		end

		return
	end

	SFX_PANEL = var_83_33

	var_83_15(var_83_36, var_83_37, var_83_38, var_83_33)

	onToggle = var_83_15

	local var_83_39 = arg_83_0
	local var_83_40 = arg_83_0.formationToggle

	local function var_83_41(arg_94_0)
		if arg_94_0 then
			arg_83_0.contextData.tabIndex = var_0_1.TabIndex.Formation

			local var_94_0 = arg_83_0

			var_1.flush(var_94_0)
		end

		return
	end

	SFX_PANEL = var_83_33

	var_83_15(var_83_39, var_83_40, var_83_41, var_83_33)

	onToggle = var_83_15

	local var_83_42 = arg_83_0
	local var_83_43 = arg_83_0.dutyToggle

	local function var_83_44(arg_95_0)
		if arg_95_0 then
			arg_83_0.contextData.tabIndex = var_0_1.TabIndex.Duty

			local var_95_0 = arg_83_0

			var_1.flush(var_95_0)
		end

		return
	end

	SFX_UI_TAG = var_83_33

	var_83_15(var_83_42, var_83_43, var_83_44, var_83_33)

	onToggle = var_83_15

	local var_83_45 = arg_83_0
	local var_83_46 = arg_83_0.adjustmentToggle

	local function var_83_47(arg_96_0)
		if arg_96_0 then
			arg_83_0.contextData.tabIndex = var_0_1.TabIndex.Adjustment

			local var_96_0 = arg_83_0

			var_1.flush(var_96_0)
		end

		return
	end

	SFX_PANEL = var_83_33

	var_83_15(var_83_45, var_83_46, var_83_47, var_83_33)

	setActive = var_83_15

	var_83_15(arg_83_0.formationToggle, true)

	setActive = var_83_15

	var_83_15(arg_83_0.commanderToggle, arg_83_0.openedCommanerSystem)

	setActive = var_83_15

	var_83_15(arg_83_0.dutyToggle, arg_83_0.dutyTabEnabled)

	setActive = var_83_15

	var_83_15(arg_83_0.adjustmentToggle, true)
	arg_83_0:flush()

	return
end

function var_0_1.flush(arg_97_0)
	arg_97_0:updateEliteLimit()
	arg_97_0:updateEliteASValue()

	local var_97_0

	if not arg_97_0.lastFleetValidStatus then
		var_97_0 = {}
	end

	arg_97_0.lastFleetValidStatus = var_97_0

	local var_97_1 = {
		not arg_97_0:IsListOfFleetEmpty(1) or nil,
		not arg_97_0:IsListOfFleetEmpty(2) or nil
	}

	if arg_97_0.dutyTabEnabled then
		table = var_2

		if var_2.getCount(arg_97_0.lastFleetValidStatus) == 2 then
			table = var_2

			if var_2.getCount(var_97_1) == 1 then
				pg = var_2

				local var_97_2 = var_2.TipsMgr.GetInstance()
				local var_97_3 = var_2.ShowTips

				i18n = var_5

				var_97_3(var_97_2, var_5("autofight_change_tip"))
			end
		end
	end

	arg_97_0.lastFleetValidStatus = var_97_1

	arg_97_0:updateEliteFleets()
	arg_97_0:UpdateEliteSonarRange()
	arg_97_0:UpdateEliteInvestigation()

	return
end

function var_0_1.updateEliteLimit(arg_98_0)
	setActive = var_1_10001

	var_1_10001(arg_98_0.toggleMask, false)

	setActive = var_1_10001

	var_1_10001(arg_98_0.tfLimit, false)

	setActive = var_1_10001

	var_1_10001(arg_98_0.tfLimitTips, #arg_98_0.propetyLimitation == 0)

	setActive = var_1_10001

	var_1_10001(arg_98_0.tfLimitElite, #arg_98_0.propetyLimitation > 0)

	setActive = var_1_10001

	var_1_10001(arg_98_0.tfLimitSubTip, #arg_98_0.propetyLimitation > 0)

	local var_98_0 = #arg_98_0.propetyLimitation
	local var_98_3

	if 0 < var_98_0 then
		local var_98_1 = arg_98_0.chapter
		local var_98_2

		var_98_2, var_98_3 = var_1.IsPropertyLimitationSatisfy(var_98_1)
		UIItemList = var_98_1

		local var_98_4 = var_98_1.New
		local var_98_5 = arg_98_0.tfLimitContainer

		var_1_10008 = arg_98_0.tfLimitContainer

		local var_98_6 = var_98_4(var_98_5, var_6.GetChild(var_1_10008, 0))

		var_3.make(var_98_6, function(arg_99_0, arg_99_1, arg_99_2)
			arg_99_1 = arg_99_1 + 1
			UIItemList = var_2_10003

			if arg_99_0 == var_2_10003.EventUpdate then
				local var_99_0 = arg_98_0.propetyLimitation[arg_99_1]

				unpack = var_2_10004

				local var_99_1, var_99_2, var_99_3, var_99_4 = var_2_10004(var_99_0)
				local var_99_6

				if var_98_2[arg_99_1] == 1 then
					local var_99_5 = arg_99_2:Find("Text")

					var_99_6 = var_99_6.GetComponent
					typeof = var_11
					Text = var_2_10013
					var_99_6 = var_99_6(var_99_5, var_11(var_2_10013))
					Color = var_2_10009
					var_99_6.color = var_2_10009.New(1, 0.9607843137254902, 0.5019607843137255)
				else
					local var_99_7 = arg_99_2:Find("Text")

					var_99_6 = var_99_6.GetComponent
					typeof = var_11
					Text = var_2_10013
					var_99_6 = var_99_6(var_99_7, var_11(var_2_10013))
					Color = var_2_10009
					var_99_6.color = var_2_10009.New(0.9568627450980393, 0.30196078431372547, 0.30196078431372547)
				end

				setActive = var_99_6

				var_99_6(arg_99_2, true)

				AttributeType = var_99_6

				local var_99_8 = var_99_6.EliteCondition2Name(var_99_1, var_99_4)

				AttributeType = var_2_10009

				local var_99_9 = (var_99_8 .. var_2_10009.eliteConditionCompareTip(var_99_2) .. var_99_3) .. "（" .. var_98_3[var_99_1] .. "）"

				setText = var_9

				var_9(arg_99_2:Find("Text"), var_99_9)
			end

			return
		end)
		var_3:align(#arg_98_0.propetyLimitation)

		setActive = var_4

		local var_98_7 = arg_98_0.tfLimitSubTip
		local var_98_8 = arg_98_0.chapter
		local var_98_9 = var_7.getConfig(var_98_8, "submarine_num")

		var_4(var_98_7, 0 < var_98_9)
	end

	local var_98_10 = arg_98_0.chapter

	if var_1.isLoop(var_98_10) then
		local var_98_11 = arg_98_0.chapter
		local var_98_12

		if not var_1.getConfig(var_98_11, "use_oil_limit") then
			var_98_12 = {}
		end

		setActive = var_98_3

		var_98_3(arg_98_0.rtCostLimit, #var_98_12 > 0)

		setText = var_98_3

		local var_98_13 = arg_98_0.rtCostLimit
		local var_98_14 = var_4.Find(var_98_13, "text")

		i18n = var_5

		var_98_3(var_98_14, var_5("formationScene_use_oil_limit_tip"))

		if #var_98_12 > 0 then
			setActive = var_2

			local var_98_15 = arg_98_0.rtCostLimit

			var_2(var_4.Find(var_98_15, "cost_noraml"), var_98_12[1] > 0)

			setText = var_2

			local var_98_16 = arg_98_0.rtCostLimit
			local var_98_17 = var_4.Find(var_98_16, "cost_noraml/Text")

			string = var_5

			local var_98_18 = var_5.format
			local var_98_19 = "%s(%d)"

			i18n = var_1_10008

			var_2(var_98_17, var_98_18(var_98_19, var_1_10008("formationScene_use_oil_limit_enemy"), var_98_12[1]))

			setActive = var_2

			local var_98_20 = arg_98_0.rtCostLimit

			var_2(var_4.Find(var_98_20, "cost_boss"), var_98_12[2] > 0)

			setText = var_2

			local var_98_21 = arg_98_0.rtCostLimit
			local var_98_22 = var_4.Find(var_98_21, "cost_boss/Text")

			string = var_5

			local var_98_23 = var_5.format
			local var_98_24 = "%s(%d)"

			i18n = var_8

			var_2(var_98_22, var_98_23(var_98_24, var_8("formationScene_use_oil_limit_flagship"), var_98_12[2]))

			setActive = var_2

			local var_98_25 = arg_98_0.rtCostLimit

			var_2(var_4.Find(var_98_25, "cost_sub"), var_98_12[3] > 0)

			setText = var_2

			local var_98_26 = arg_98_0.rtCostLimit
			local var_98_27 = var_4.Find(var_98_26, "cost_sub/Text")

			string = var_5

			local var_98_28 = var_5.format
			local var_98_29 = "%s(%d)"

			i18n = var_8

			var_2(var_98_27, var_98_28(var_98_29, var_8("formationScene_use_oil_limit_submarine"), var_98_12[3]))
		end

		return
	end
end

function var_0_1.initAddButton(arg_100_0, arg_100_1, arg_100_2, arg_100_3, arg_100_4)
	local var_100_0 = arg_100_0.eliteFleetList[arg_100_4]
	local var_100_1 = {}
	local var_100_2 = {}

	ipairs = var_1_10008

	for iter_100_0, iter_100_1 in var_1_10008(var_100_0) do
		var_100_1[arg_100_0.shipVOs[iter_100_1]] = true

		if arg_100_2 then
			local var_100_3 = arg_100_0.shipVOs[iter_100_1]

			if arg_100_2 == var_13.getTeamType(var_100_3) then
				table = var_13

				var_13.insert(var_100_2, iter_100_1)
			end
		end
	end

	removeAllChildren = var_8

	var_8(arg_100_1)

	local var_100_4 = 0
	local var_100_5 = false
	local var_100_6 = 0

	arg_100_3 = var_0_1.sortTeamLimitation(arg_100_3)

	local var_100_7 = arg_100_1:GetComponent("ContentSizeFitter")
	local var_100_8 = arg_100_1:GetComponent("HorizontalLayoutGroup")

	var_100_7.enabled = true
	var_100_8.enabled = true
	arg_100_0.isDraging = false

	for iter_100_2 = 1, 3 do
		local var_100_9
		local var_100_10
		local var_100_11
		local var_100_12

		if not var_100_2[iter_100_2] or not arg_100_0.shipVOs[var_100_2[iter_100_2]] then
			var_100_12 = nil
		end

		if var_100_12 then
			ipairs = var_1_10021

			for iter_100_3, iter_100_4 in var_1_10021(arg_100_3) do
				ShipType = var_1_10026

				if var_1_10026.ContainInLimitBundle(iter_100_4, var_100_12:getShipType()) then
					var_100_10 = var_100_12
					var_100_11 = iter_100_4
					table = var_1_10026

					var_1_10026.remove(arg_100_3, iter_100_3)

					var_100_5 = var_100_5 or iter_100_4 ~= 0

					break
				end
			end
		else
			var_100_11 = arg_100_3[1]
			table = var_1_10021

			var_1_10021.remove(arg_100_3, 1)
		end

		if var_100_11 == 0 then
			var_100_6 = var_100_6 + 1
		end

		if var_100_10 then
			cloneTplTo = var_1_10021

			if not var_1_10021(arg_100_0.tfShipTpl, arg_100_1) then
				cloneTplTo = var_1_10021
				var_1_10021 = var_1_10021(arg_100_0.tfEmptyTpl, arg_100_1)
			end

			setActive = var_1_10022

			var_1_10022(var_1_10021, true)

			if var_100_10 then
				updateShip = var_1_10022

				var_1_10022(var_1_10021, var_100_10)

				setActive = var_1_10022
				var_1_10026 = var_1_10021

				var_1_10022(var_1_10021.Find(var_1_10026, "event_block"), var_100_10:getFlag("inEvent"))

				var_100_1[var_100_10] = true
			else
				var_100_4 = var_100_4 + 1
			end

			setActive = var_1_10022
			var_1_10026 = var_1_10021

			var_1_10022(var_1_10021.Find(var_1_10026, "ship_type"), var_100_11 and var_100_11 ~= 0)

			if var_100_11 and var_100_11 ~= 0 then
				type = var_1_10022

				if var_1_10022(var_100_11) == "number" then
					GetSpriteFromAtlas = var_1_10022

					local var_100_13 = "shiptype"

					ShipType = var_25
					var_1_10022 = var_1_10022(var_100_13, var_25.Type2CNLabel(var_100_11))
					setImageSprite = var_1_10023

					var_1_10023(var_1_10021:Find("ship_type"), var_1_10022, true)
				else
					type = var_1_10022

					if var_1_10022(var_100_11) == "string" then
						GetSpriteFromAtlas = var_1_10022

						local var_100_14 = "shiptype"

						ShipType = var_25
						var_1_10022 = var_1_10022(var_100_14, var_25.BundleType2CNLabel(var_100_11))
						setImageSprite = var_1_10023

						var_1_10023(var_1_10021:Find("ship_type"), var_1_10022, true)
					end
				end
			end

			_ = var_1_10022
			var_1_10022 = var_1_10022.map(var_100_0, function(arg_101_0)
				return arg_100_0.shipVOs[arg_101_0]
			end)
			table = var_1_10023

			var_1_10023.sort(var_1_10022, function(arg_102_0, arg_102_1)
				if not (var_0_2[arg_102_0:getTeamType()] < var_0_2[arg_102_1:getTeamType()]) then
					if var_0_2[arg_102_0:getTeamType()] == var_0_2[arg_102_1:getTeamType()] then
						table = var_2

						local var_102_0 = var_2.indexof(var_100_0, arg_102_0.id)

						table = var_3

						local var_102_1

						if not (var_102_0 < var_3.indexof(var_100_0, arg_102_1.id)) then
							var_102_1 = false

							goto label_102_0
						end

						var_102_1 = true

						::label_102_0::

						return var_102_1
					end
				end
			end)

			GetOrAddComponent = var_1_10023

			local var_100_15 = var_1_10021

			typeof = var_1_10026
			UILongPressTrigger = var_1_10028
			var_1_10026 = var_1_10023(var_100_15, var_1_10026(var_1_10028)).onLongPressed

			var_24.RemoveAllListeners(var_1_10026)

			if var_100_10 and arg_100_0.contextData.tabIndex ~= var_0_1.TabIndex.Adjustment then
				var_1_10026 = var_1_10023.onLongPressed

				var_24.AddListener(var_1_10026, function()
					local var_103_0 = arg_100_0

					var_0.onCancelHard(var_103_0, true)

					local var_103_1 = arg_100_0
					local var_103_2 = var_0.emit

					LevelMediator2 = var_3

					var_103_2(var_103_1, var_3.ON_FLEET_SHIPINFO, {
						shipId = var_100_10.id,
						shipVOs = var_1_10022,
						chapter = arg_100_0.chapter
					})

					return
				end)
			end

			GetOrAddComponent = var_24

			local var_100_16 = var_24(var_1_10021, "EventTriggerListener")

			var_24.RemovePointClickFunc(var_100_16)
			var_24:AddPointClickFunc(function(arg_104_0, arg_104_1)
				if arg_104_0 ~= var_1_10021.gameObject then
					return
				end

				if arg_100_0.isDraging then
					return
				end

				local var_104_0 = arg_100_0

				var_2.onCancelHard(var_104_0)

				local var_104_1 = arg_100_0
				local var_104_2 = var_2.emit

				LevelMediator2 = var_2_10005

				var_104_2(var_104_1, var_2_10005.ON_ELITE_OEPN_DECK, {
					shipType = var_100_11,
					fleet = var_100_1,
					chapter = arg_100_0.chapter,
					shipVO = var_100_10,
					fleetIndex = arg_100_4,
					teamType = arg_100_2
				})

				return
			end)
			var_24:RemoveBeginDragFunc()
			var_24:RemoveDragFunc()
			var_24:RemoveDragEndFunc()

			if var_100_10 and arg_100_0.contextData.tabIndex == var_0_1.TabIndex.Adjustment then
				local var_100_17 = var_1_10021.rect.width * 0.5

				var_1_10026 = {}

				local var_100_18 = {}

				var_24:AddBeginDragFunc(function(arg_105_0, arg_105_1)
					if arg_105_0 ~= var_1_10021.gameObject then
						return
					end

					if arg_100_0.isDraging then
						return
					end

					arg_100_0.isDraging = true
					var_100_7.enabled = false
					var_100_8.enabled = false

					for iter_105_0 = 1, 3 do
						local var_105_0 = arg_100_1
						local var_105_1 = var_6.GetChild(var_105_0, iter_105_0 - 1)

						if var_1_10021 == var_105_1 then
							arg_100_0.dragIndex = iter_105_0
						end

						var_1_10026[iter_105_0] = var_105_1.anchoredPosition
						var_100_18[iter_105_0] = var_105_1
					end

					return
				end)
				var_24:AddDragFunc(function(arg_106_0, arg_106_1)
					if arg_106_0 ~= var_1_10021.gameObject then
						return
					end

					if not arg_100_0.isDraging then
						return
					end

					local var_106_0 = var_1_10021.localPosition
					local var_106_1 = arg_100_0

					var_106_0.x = var_3.change2ScrPos(var_106_1, var_1_10021.parent, arg_106_1.position).x
					math = var_3
					var_106_0.x = var_3.clamp(var_106_0.x, var_1_10026[1].x, var_1_10026[3].x)
					var_1_10021.localPosition = var_106_0

					local var_106_2 = 1

					for iter_106_0 = 1, 3 do
						if var_1_10021 ~= var_100_18[iter_106_0] and var_1_10021.localPosition.x > var_100_18[iter_106_0].localPosition.x + (var_106_2 < arg_100_0.dragIndex and 1.1 or -1.1) * var_100_17 then
							var_106_2 = var_106_2 + 1
						end
					end

					if arg_100_0.dragIndex ~= var_106_2 then
						local var_106_3 = var_106_2 < arg_100_0.dragIndex and -1 or 1

						while arg_100_0.dragIndex ~= var_106_2 do
							local var_106_4 = arg_100_0.dragIndex
							local var_106_5 = arg_100_0.dragIndex + var_106_3

							var_100_2[var_106_4], var_100_2[var_106_5] = var_100_2[var_106_5], var_100_2[var_106_4]
							var_100_18[var_106_4], var_100_18[var_106_5] = var_100_18[var_106_5], var_100_18[var_106_4]
							arg_100_0.dragIndex = arg_100_0.dragIndex + var_106_3
						end

						for iter_106_1 = 1, 3 do
							if var_1_10021 ~= var_100_18[iter_106_1] then
								var_100_18[iter_106_1].anchoredPosition = var_1_10026[iter_106_1]
							end
						end
					end

					return
				end)
				var_24:AddDragEndFunc(function(arg_107_0, arg_107_1)
					if arg_107_0 ~= var_1_10021.gameObject then
						return
					end

					if not arg_100_0.isDraging then
						return
					end

					arg_100_0.isDraging = false

					for iter_107_0 = 1, 3 do
						if not var_100_2[iter_107_0] then
							for iter_107_1 = iter_107_0 + 1, 3 do
								if var_100_2[iter_107_1] then
									var_100_2[iter_107_0], var_100_2[iter_107_1] = var_100_2[iter_107_1], var_100_2[iter_107_0]
									var_100_18[iter_107_0], var_100_18[iter_107_1] = var_100_18[iter_107_1], var_100_18[iter_107_0]
								end
							end
						end

						if var_100_2[iter_107_0] then
							table = var_6

							var_6.removebyvalue(var_100_0, var_100_2[iter_107_0])

							table = var_6

							var_6.insert(var_100_0, var_100_2[iter_107_0])
						else
							break
						end
					end

					for iter_107_2 = 1, 3 do
						var_2_10008 = var_100_18[iter_107_2]

						var_6.SetSiblingIndex(var_2_10008, iter_107_2 - 1)
					end

					var_100_7.enabled = true
					var_100_8.enabled = true
					arg_100_0.dragIndex = nil

					local var_107_0 = arg_100_0.chapter
					local var_107_1 = var_2.setEliteFleetByIndex
					local var_107_2 = arg_100_4
					local var_107_3 = {}
					local var_107_4 = {}

					TeamType = var_2_10008
					var_107_4[1] = var_2_10008.FormShips
					underscore = var_8
					var_107_4[2] = var_8.to_array(var_100_0)
					var_107_3[1] = var_107_4

					var_107_1(var_107_0, var_107_2, var_107_3)

					local var_107_5 = arg_100_0
					local var_107_6 = var_2.emit

					LevelMediator2 = var_107_2

					var_107_6(var_107_5, var_107_2.ON_ELITE_ADJUSTMENT, arg_100_0.chapter)

					return
				end)
			end
		end
	end

	if (var_100_5 == true or var_100_6 == 3) and var_100_4 ~= 3 then
		return true
	else
		return false
	end

	return
end

function var_0_1.change2ScrPos(arg_108_0, arg_108_1, arg_108_2)
	pg = var_1_10003

	local var_108_0 = var_1_10003.UIMgr.GetInstance().overlayCameraComp

	LuaHelper = var_1_10004

	return (var_1_10004.ScreenToLocal(arg_108_1, arg_108_2, var_108_0))
end

function var_0_1.updateEliteFleets(arg_109_0)
	pairs = var_1_10001

	for iter_109_0, iter_109_1 in var_1_10001(arg_109_0.tfFleets) do
		for iter_109_2 = 1, #iter_109_1 do
			arg_109_0:UpdateEliteFleet(iter_109_0, iter_109_2)
		end
	end

	arg_109_0:RefreshDutyBar()

	return
end

function var_0_1.UpdateEliteFleet(arg_110_0, arg_110_1, arg_110_2)
	local var_110_0 = arg_110_0.contextData.tabIndex == var_0_1.TabIndex.Formation
	local var_110_1 = arg_110_0.contextData.tabIndex == var_0_1.TabIndex.Commander
	local var_110_2 = arg_110_0.contextData.tabIndex == var_0_1.TabIndex.Duty
	local var_110_3 = arg_110_0.contextData.tabIndex == var_0_1.TabIndex.Adjustment
	local var_110_4 = arg_110_0
	local var_110_5 = arg_110_2 <= arg_110_0.getLimitNums(var_110_4, arg_110_1)
	local var_110_6 = arg_110_0.tfFleets[arg_110_1][arg_110_2]

	findTF = var_110_4

	local var_110_7 = var_110_4(var_110_6, "bg/name")
	local var_110_8 = var_110_6:Find("btn_select")
	local var_110_9 = var_110_6:Find("btn_recom")
	local var_110_10 = var_110_6:Find("btn_clear")
	local var_110_11 = var_110_6:Find("blank")
	local var_110_12 = var_110_6:Find("selected")
	local var_110_13 = var_110_6
	local var_110_14 = var_110_6.Find(var_110_13, "commander")
	local var_110_15 = var_110_6:Find("adjustment_flag")

	setActive = var_110_13

	var_110_13(var_110_8, false)

	local var_110_16 = var_110_6
	local var_110_17 = var_110_6.Find

	TeamType = var_20

	local var_110_18 = var_110_17(var_110_16, var_20.Main)
	local var_110_19 = var_110_6
	local var_110_20 = var_110_6.Find

	TeamType = var_1_10021

	local var_110_21 = var_110_20(var_110_19, var_1_10021.Vanguard)

	if not var_110_5 then
		setActive = var_110_16

		var_110_16(var_110_10, false)

		setActive = var_110_16

		var_110_16(var_110_9, false)

		setActive = var_110_16

		var_110_16(var_110_14, false)

		setActive = var_110_16

		var_110_16(var_110_15, false)

		setActive = var_110_16

		var_110_16(var_110_11, true)

		setActive = var_110_16

		var_110_16(var_110_12, false)

		setText = var_110_16

		var_110_16(var_110_7, "")

		setActive = var_110_16

		var_110_16(var_110_18, false)

		FleetType = var_110_16

		if arg_110_1 == var_110_16.Normal then
			setActive = var_110_16

			var_110_16(var_110_21, false)
		end

		return
	end

	FleetType = var_110_16

	local var_110_22 = arg_110_1 == var_110_16.Support

	setActive = var_110_19

	var_110_19(var_110_10, var_110_0)

	setActive = var_110_19

	var_110_19(var_110_9, var_110_0)

	setActive = var_110_19

	var_110_19(var_110_14, var_110_1 and not var_110_22)

	setActive = var_110_19

	var_110_19(var_110_15, var_110_3)

	setActive = var_110_19

	var_110_19(var_110_11, var_110_2 or var_110_3 or var_110_1 and var_110_22)

	local var_110_23 = arg_110_2

	FleetType = var_21

	local var_110_24

	if arg_110_1 == var_21.Normal then
		setText = var_21
		var_110_24 = var_110_7
		Fleet = var_1_10024

		var_21(var_110_24, var_1_10024.DEFAULT_NAME[arg_110_2])

		setActive = var_21

		var_21(var_110_18, true)

		setActive = var_21

		var_21(var_110_21, true)
	else
		FleetType = var_21

		if arg_110_1 == var_21.Submarine then
			var_110_23 = 3
			setText = var_21
			var_110_24 = var_110_7
			Fleet = var_1_10024
			var_1_10024 = var_1_10024.DEFAULT_NAME
			Fleet = var_1_10025

			var_21(var_110_24, var_1_10024[var_1_10025.SUBMARINE_FLEET_ID + arg_110_2 - 1])

			setActive = var_21

			var_21(var_110_18, true)
		else
			FleetType = var_21

			if arg_110_1 == var_21.Support then
				var_110_23 = 4
				setText = var_21
				var_110_24 = var_110_7
				i18n = var_1_10024

				var_21(var_110_24, var_1_10024("ship_formationUI_fleetName13"))

				setActive = var_21

				var_21(var_110_18, true)
			end
		end
	end

	local var_110_25 = 6

	FleetType = var_22

	local var_110_33

	if arg_110_1 == var_22.Normal then
		var_110_24 = arg_110_0.typeLimitations[arg_110_2][1]

		local var_110_26 = var_110_33[2]
		local var_110_27 = arg_110_0
		local var_110_28 = arg_110_0.initAddButton
		local var_110_29 = var_110_6

		var_1_10028 = var_110_6.Find
		TeamType = var_1_10031
		var_1_10028 = var_1_10028(var_110_29, var_1_10031.Main)
		TeamType = var_1_10029

		local var_110_30 = var_110_28(var_110_27, var_1_10028, var_1_10029.Main, var_110_24, var_110_23)

		var_1_10028 = arg_110_0
		var_1_10026 = arg_110_0.initAddButton

		local var_110_31 = var_110_6

		var_1_10029 = var_110_6.Find
		TeamType = var_1_10032
		var_1_10029 = var_1_10029(var_110_31, var_1_10032.Vanguard)
		TeamType = var_30
		var_1_10026 = var_1_10026(var_1_10028, var_1_10029, var_30.Vanguard, var_110_26, var_110_23)
		setActive = var_110_27

		var_110_27(var_110_12, var_110_30 and var_1_10026)
	else
		FleetType = var_110_33

		if arg_110_1 == var_110_33.Submarine then
			var_110_25 = 3

			local var_110_32 = arg_110_0

			var_110_33 = arg_110_0.initAddButton

			local var_110_34 = var_110_6
			local var_110_35 = var_110_6.Find

			TeamType = var_1_10028

			local var_110_36 = var_110_35(var_110_34, var_1_10028.Main)

			TeamType = var_1_10026
			var_110_33 = var_110_33(var_110_32, var_110_36, var_1_10026.Submarine, {
				0,
				0,
				0
			}, var_110_23)
			setActive = var_110_24

			var_110_24(var_110_12, var_110_33)
		else
			FleetType = var_110_33

			if arg_110_1 == var_110_33.Support then
				var_110_25 = 3

				local var_110_37 = arg_110_0.chapter

				if not var_110_33.getConfigMiscArg(var_110_37, "submarine_support") or not {
					"qian",
					"qian",
					"qian"
				} then
					var_110_33 = {
						"hang",
						"hang",
						"hang"
					}
				end

				local var_110_38 = arg_110_0
				local var_110_39 = arg_110_0.initSupportAddButton
				local var_110_40 = var_110_6
				local var_110_41 = var_110_6.Find

				TeamType = var_1_10029

				local var_110_42 = var_110_39(var_110_38, var_110_41(var_110_40, var_1_10029.Main), nil, var_110_33, var_110_23)

				setActive = var_110_37

				var_110_37(var_110_12, arg_110_0.mode == var_0_3.EDIT and var_110_42)
			end
		end
	end

	if not var_110_22 then
		arg_110_0:initCommander(var_110_23, var_110_14, arg_110_0.chapter)
	end

	onButton = var_110_33

	var_110_33(arg_110_0, var_110_10, function()
		local var_111_0

		if var_110_22 or not arg_110_0.eliteFleetList[var_110_23] then
			var_111_0 = arg_110_0.supportFleet
		end

		if #var_111_0 == 0 then
			return
		end

		pg = var_1

		local var_111_1 = var_1.MsgboxMgr.GetInstance()
		local var_111_2 = var_1.ShowMsgBox
		local var_111_3 = {}

		i18n = var_2_10005
		var_111_3.content = var_2_10005("battle_preCombatLayer_clear_confirm")

		function var_111_3.onYes()
			local var_112_0 = arg_110_0
			local var_112_1 = var_0.emit

			LevelMediator2 = var_3_10003

			var_112_1(var_112_0, var_3_10003.ON_ELITE_CLEAR, {
				index = var_110_23,
				chapterVO = arg_110_0.chapter
			})

			return
		end

		var_111_2(var_111_1, var_111_3)

		return
	end)

	onButton = var_110_33

	var_110_33(arg_110_0, var_110_9, function()
		local var_113_0

		if var_110_22 or not arg_110_0.eliteFleetList[var_110_23] then
			var_113_0 = arg_110_0.supportFleet
		end

		if #var_113_0 == var_110_25 then
			return
		end

		seriesAsync = var_2

		var_2({
			function(arg_114_0)
				if var_0 == 0 then
					return arg_114_0()
				end

				pg = var_1

				local var_114_0 = var_1.MsgboxMgr.GetInstance()
				local var_114_1 = var_1.ShowMsgBox
				local var_114_2 = {}

				i18n = var_3_10005
				var_114_2.content = var_3_10005("battle_preCombatLayer_auto_confirm")
				var_114_2.onYes = arg_114_0

				var_114_1(var_114_0, var_114_2)

				return
			end,
			function()
				local var_115_0 = arg_110_0
				local var_115_1 = var_0.emit

				LevelMediator2 = var_3_10003

				var_115_1(var_115_0, var_3_10003.ON_ELITE_RECOMMEND, {
					index = var_110_23,
					chapterVO = arg_110_0.chapter
				})

				return
			end
		})

		return
	end)

	return
end

function var_0_1.initCommander(arg_116_0, arg_116_1, arg_116_2, arg_116_3)
	local var_116_0 = arg_116_3:getEliteFleetCommanders()[arg_116_1]

	for iter_116_0 = 1, 2 do
		if var_116_0[iter_116_0] then
			::label_116_0::

			getProxy = var_1_10011
			CommanderProxy = var_1_10013
			var_1_10013 = var_1_10011(var_1_10013)
			var_1_10011 = var_1_10011.getCommanderById(var_1_10013, var_10)
		end

		local var_116_1 = arg_116_2:Find("pos" .. iter_116_0)

		var_1_10013 = var_12.Find(var_116_1, "add")

		local var_116_2 = var_12
		local var_116_3 = var_12.Find(var_116_2, "info")

		setActive = var_116_1

		var_116_1(var_1_10013, not var_1_10011)

		setActive = var_116_1

		var_116_1(var_116_3, var_1_10011)

		if var_1_10011 then
			Commander = var_116_1

			local var_116_4 = var_116_1.rarity2Frame
			local var_116_5 = var_1_10011
			local var_116_6 = var_116_4(var_1_10011.getRarity(var_116_5))

			setImageSprite = var_116_2

			local var_116_7 = var_116_3:Find("frame")

			GetSpriteFromAtlas = var_116_5

			var_116_2(var_116_7, var_116_5("weaponframes", "commander_" .. var_116_6))

			GetImageSpriteFromAtlasAsync = var_116_2

			local var_116_8 = "CommanderHrz/"

			var_1_10021 = var_1_10011

			var_116_2(var_116_8 .. var_1_10011.getPainting(var_1_10021), "", var_116_3:Find("mask/icon"))
		end

		local var_116_9 = arg_116_3:wrapEliteFleet(arg_116_1)

		onButton = var_116_2

		local var_116_10 = arg_116_0
		local var_116_11 = var_1_10013

		local function var_116_12()
			local var_117_0 = arg_116_0
			local var_117_1 = var_0.emit

			LevelUIConst = var_2_10003

			var_117_1(var_117_0, var_2_10003.OPEN_COMMANDER_PANEL, var_116_9, arg_116_3, arg_116_1)

			return
		end

		SFX_PANEL = var_1_10021

		var_116_2(var_116_10, var_116_11, var_116_12, var_1_10021)

		onButton = var_116_2

		local var_116_13 = arg_116_0
		local var_116_14 = var_116_3

		local function var_116_15()
			local var_118_0 = arg_116_0
			local var_118_1 = var_0.emit

			LevelUIConst = var_2_10003

			var_118_1(var_118_0, var_2_10003.OPEN_COMMANDER_PANEL, var_116_9, arg_116_3, arg_116_1)

			return
		end

		SFX_PANEL = var_1_10021

		var_116_2(var_116_13, var_116_14, var_116_15, var_1_10021)
	end

	return
end

function var_0_1.initSupportAddButton(arg_119_0, arg_119_1, arg_119_2, arg_119_3, arg_119_4)
	local var_119_0 = {}
	local var_119_1 = {}

	ipairs = var_1_10007

	for iter_119_0, iter_119_1 in var_1_10007(arg_119_0.supportFleet) do
		var_119_0[arg_119_0.shipVOs[iter_119_1]] = true

		if arg_119_2 then
			local var_119_2 = arg_119_0.shipVOs[iter_119_1]

			if arg_119_2 == var_12.getTeamType(var_119_2) then
				table = var_12

				var_12.insert(var_119_1, iter_119_1)
			end
		end
	end

	removeAllChildren = var_7

	var_7(arg_119_1)

	local var_119_3 = 0
	local var_119_4 = false
	local var_119_5 = 0

	arg_119_3 = var_0_1.sortTeamLimitation(arg_119_3)

	for iter_119_2 = 1, 3 do
		local var_119_6
		local var_119_7
		local var_119_8

		if not var_119_1[iter_119_2] or not arg_119_0.shipVOs[var_119_1[iter_119_2]] then
			var_119_8 = nil
		end

		if var_119_8 then
			ipairs = var_1_10017

			for iter_119_3, iter_119_4 in var_1_10017(arg_119_3) do
				ShipType = var_1_10022

				if var_1_10022.ContainInLimitBundle(iter_119_4, var_119_8:getShipType()) then
					var_119_6 = var_119_8
					var_119_7 = iter_119_4
					table = var_1_10022

					var_1_10022.remove(arg_119_3, iter_119_3)

					var_119_4 = var_119_4 or iter_119_4 ~= 0

					break
				end
			end
		else
			var_119_7 = arg_119_3[1]
			table = var_1_10017

			var_1_10017.remove(arg_119_3, 1)
		end

		if var_119_7 == 0 then
			var_119_5 = var_119_5 + 1
		end

		if var_119_6 then
			cloneTplTo = var_1_10017

			if not var_1_10017(arg_119_0.tfShipTpl, arg_119_1) then
				cloneTplTo = var_1_10017
				var_1_10017 = var_1_10017(arg_119_0.tfEmptyTpl, arg_119_1)
			end

			setActive = var_1_10018

			var_1_10018(var_1_10017, true)

			if var_119_6 then
				updateShip = var_1_10018

				var_1_10018(var_1_10017, var_119_6)

				setActive = var_1_10018
				var_1_10022 = var_1_10017

				var_1_10018(var_1_10017.Find(var_1_10022, "event_block"), var_119_6:getFlag("inEvent"))

				var_119_0[var_119_6] = true
			else
				var_119_3 = var_119_3 + 1
			end

			setActive = var_1_10018
			var_1_10022 = var_1_10017

			var_1_10018(var_1_10017.Find(var_1_10022, "ship_type"), var_119_7 and var_119_7 ~= 0)

			if var_119_7 and var_119_7 ~= 0 then
				type = var_1_10018

				if var_1_10018(var_119_7) == "number" then
					GetSpriteFromAtlas = var_1_10018

					local var_119_9 = "shiptype"

					ShipType = var_21
					var_1_10018 = var_1_10018(var_119_9, var_21.Type2CNLabel(var_119_7))
					setImageSprite = var_1_10019

					var_1_10019(var_1_10017:Find("ship_type"), var_1_10018, true)
				else
					type = var_1_10018

					if var_1_10018(var_119_7) == "string" then
						GetSpriteFromAtlas = var_1_10018

						local var_119_10 = "shiptype"

						ShipType = var_21
						var_1_10018 = var_1_10018(var_119_10, var_21.BundleType2CNLabel(var_119_7))
						setImageSprite = var_1_10019

						var_1_10019(var_1_10017:Find("ship_type"), var_1_10018, true)
					end
				end
			end

			_ = var_1_10018
			var_1_10018 = var_1_10018.map(arg_119_0.supportFleet, function(arg_120_0)
				return arg_119_0.shipVOs[arg_120_0]
			end)
			GetOrAddComponent = var_1_10019

			local var_119_11 = var_1_10017

			typeof = var_1_10022
			UILongPressTrigger = var_1_10024
			var_1_10022 = var_1_10019(var_119_11, var_1_10022(var_1_10024)).onLongPressed

			var_20.RemoveAllListeners(var_1_10022)

			if var_119_6 and arg_119_0.contextData.tabIndex ~= var_0_1.TabIndex.Adjustment then
				var_1_10022 = var_1_10019.onLongPressed

				var_20.AddListener(var_1_10022, function()
					local var_121_0 = arg_119_0

					var_0.onCancelSupport(var_121_0, true)

					local var_121_1 = arg_119_0
					local var_121_2 = var_0.emit

					LevelMediator2 = var_3

					var_121_2(var_121_1, var_3.ON_SUPPORT_SHIPINFO, {
						shipId = var_119_6.id,
						shipVOs = var_1_10018,
						chapter = arg_119_0.chapter
					})

					return
				end)
			end

			GetOrAddComponent = var_20

			local var_119_12 = var_20(var_1_10017, "EventTriggerListener")

			var_20.RemovePointClickFunc(var_119_12)
			var_20:AddPointClickFunc(function(arg_122_0, arg_122_1)
				if arg_122_0 ~= var_1_10017.gameObject then
					return
				end

				if arg_119_0.isDraging then
					return
				end

				local var_122_0 = arg_119_0

				var_2.onCancelSupport(var_122_0)

				local var_122_1 = arg_119_0
				local var_122_2 = var_2.emit

				LevelMediator2 = var_2_10005

				var_122_2(var_122_1, var_2_10005.ON_SUPPORT_OPEN_DECK, {
					shipType = var_119_7,
					fleet = var_119_0,
					chapter = arg_119_0.chapter,
					shipVO = var_119_6
				})

				return
			end)
			var_20:RemoveBeginDragFunc()
			var_20:RemoveDragFunc()
			var_20:RemoveDragEndFunc()
		end
	end

	if (var_119_4 == true or var_119_5 == 3) and var_119_3 ~= 3 then
		return true
	else
		return false
	end

	return
end

function var_0_1.updateSpecialOperationTickets(arg_123_0, arg_123_1)
	arg_123_0.spOPTicketItems = arg_123_1 or {}

	return
end

function var_0_1.getLegalSPBuffList(arg_124_0)
	local var_124_0 = arg_124_0.chapter
	local var_124_1 = var_1.GetSpItems(var_124_0)

	_ = var_1_10002

	return var_1_10002.map(var_124_1, function(arg_125_0)
		Chapter = var_2_10001

		return var_2_10001.GetSPBuffByItem(arg_125_0:GetConfigID())
	end)
end

function var_0_1.initSPOPView(arg_126_0)
	local var_126_0 = arg_126_0.btnSp

	arg_126_0.spPanel = var_1.Find(var_126_0, "sp_panel")

	local var_126_1 = arg_126_0.btnSp

	arg_126_0.spItem = var_1.Find(var_126_1, "item")

	local var_126_2 = arg_126_0.btnSp

	arg_126_0.spDesc = var_1.Find(var_126_2, "desc")

	local var_126_3 = arg_126_0.btnSp

	arg_126_0.spCheckBox = var_1.Find(var_126_3, "checkbox")

	local var_126_4 = arg_126_0.spCheckBox

	arg_126_0.spCheckMark = var_1.Find(var_126_4, "mark")

	local var_126_5 = arg_126_0.spPanel

	arg_126_0.spTpl = var_1.Find(var_126_5, "sp_tpl")

	local var_126_6 = arg_126_0.spPanel

	arg_126_0.spContainer = var_1.Find(var_126_6, "sp_container")

	local var_126_7 = arg_126_0.btnSp

	arg_126_0.spItemEmptyBlock = var_1.Find(var_126_7, "empty_block")
	setText = var_1

	local var_126_8 = arg_126_0.spItemEmptyBlock

	i18n = var_4

	var_1(var_126_8, var_4("levelScene_select_noitem"))

	removeAllChildren = var_1

	var_1(arg_126_0.spContainer)

	local var_126_9 = arg_126_0:getLegalSPBuffList()
	local var_126_10 = arg_126_0.chapter
	local var_126_11 = var_2.GetActiveSPItemID(var_126_10)
	local var_126_12 = arg_126_0

	arg_126_0.setSPBtnFormByBuffCount(var_126_12)

	local var_126_13

	if #var_126_9 == 0 then
		var_126_12 = arg_126_0

		arg_126_0.clearSPBuff(var_126_12)
	else
		local var_126_16

		if #var_126_9 == 1 then
			var_126_13 = var_126_9[1]
			pg = var_126_10

			local var_126_14 = var_126_10.benefit_buff_template[var_126_13]

			ActivityBuff = var_126_12

			local var_126_15 = var_126_12.GetBenefitCondition(var_126_14.benefit_condition)

			assert = var_126_16

			var_126_16(var_126_15[1] == "item")

			var_126_16 = var_126_15[2]
			var_1_10009 = arg_126_0

			arg_126_0.setTicketInfo(var_1_10009, arg_126_0.btnSp, var_126_16)

			setText = var_7

			var_7(arg_126_0.spDesc, var_126_14.desc)

			onButton = var_7
			var_1_10009 = arg_126_0

			local var_126_17 = arg_126_0.btnSp

			var_7(var_1_10009, var_1_10010.Find(var_126_17, "item"), function()
				local var_127_0 = arg_126_0
				local var_127_1 = var_0.emit

				BaseUI = var_2_10003

				var_127_1(var_127_0, var_2_10003.ON_ITEM, var_126_16)

				return
			end)

			onButton = var_7

			var_7(arg_126_0, arg_126_0.btnSp, function()
				Chapter = var_2_10000

				local var_128_0 = var_2_10000.GetSPOperationItemCacheKey(arg_126_0.chapter.id)

				if arg_126_0.spCheckMark.gameObject.activeSelf then
					PlayerPrefs = var_1

					var_1.SetInt(var_128_0, 0)

					local var_128_1 = arg_126_0

					var_1.clearSPBuff(var_128_1)
				else
					local var_128_2 = arg_126_0

					var_128_2.spItemID = var_126_16
					PlayerPrefs = var_128_2

					var_128_2.SetInt(var_128_0, arg_126_0.spItemID)

					pg = var_1

					local var_128_3 = var_1.TipsMgr.GetInstance()
					local var_128_4 = var_1.ShowTips

					i18n = var_4

					var_128_4(var_128_3, var_4("levelScene_select_sp"))

					setActive = var_128_4

					var_128_4(arg_126_0.spCheckMark, true)
				end

				return
			end)

			setActive = var_7
			var_1_10009 = arg_126_0.spCheckMark
			var_1_10010 = var_126_11 == 0

			var_7(var_1_10009, var_1_10010)

			triggerButton = var_7

			var_7(arg_126_0.btnSp)
		elseif #var_126_9 > 1 then
			setText = var_126_13

			local var_126_18 = arg_126_0.spDesc

			i18n = var_126_16

			var_126_13(var_126_18, var_126_16("levelScene_select_SP_OP"))

			ipairs = var_126_13

			for iter_126_0, iter_126_1 in var_126_13(var_126_9) do
				ActivityBuff = var_126_19

				local var_126_19 = var_126_19.GetBenefitCondition(iter_126_1.benefit_condition)

				assert = var_1_10009

				var_1_10009(var_126_19[1] == "item")

				var_1_10009 = var_126_19[2]
				cloneTplTo = var_1_10010
				var_1_10010 = var_1_10010(arg_126_0.spTpl, arg_126_0.spContainer)
				setText = var_11

				var_11(var_1_10010:Find("desc"), iter_126_1.desc)
				arg_126_0:setTicketInfo(var_1_10010, var_1_10009)

				setActive = var_11

				var_11(var_1_10010:Find("block"), false)

				onButton = var_11

				var_11(arg_126_0, var_1_10010, function()
					local var_129_0 = arg_126_0

					var_0.setSPBuffSelected(var_129_0, iter_126_1.id)

					setActive = var_0

					var_0(arg_126_0.spPanel, false)

					return
				end)
			end

			onButton = var_126_13

			var_126_13(arg_126_0, arg_126_0.btnSp, function()
				local var_130_1

				if arg_126_0.spPanel.gameObject.activeSelf then
					local var_130_0 = arg_126_0

					var_130_1.clearSPBuff(var_130_0)

					Chapter = var_130_1
					var_130_1 = var_130_1.GetSPOperationItemCacheKey(arg_126_0.chapter.id)
					PlayerPrefs = var_2_10001

					var_2_10001.SetInt(var_130_1, 0)

					setActive = var_1

					var_1(arg_126_0.spPanel, false)
				else
					setActive = var_130_1

					var_130_1(arg_126_0.spPanel, true)

					setActive = var_130_1

					local var_130_2 = arg_126_0.btnSp

					var_130_1(var_2.Find(var_130_2, "item"), false)

					setText = var_130_1

					local var_130_3 = arg_126_0.spDesc

					i18n = var_3

					var_130_1(var_130_3, var_3("levelScene_unselect_SP_OP"))
				end

				return
			end)

			if var_126_11 ~= 0 then
				var_126_13 = nil
				ipairs = var_4

				for iter_126_2, iter_126_3 in var_4(var_126_9) do
					local var_126_20 = iter_126_3.id

					Chapter = var_1_10010

					if var_126_20 == var_1_10010.GetSPBuffByItem(var_126_11) then
						var_126_13 = true

						break
					end
				end

				if var_126_13 then
					Chapter = var_4

					local var_126_21 = var_4.GetSPBuffByItem(var_126_11)

					arg_126_0:setSPBuffSelected(var_126_21)
				else
					arg_126_0:clearSPBuff()
				end
			else
				arg_126_0:clearSPBuff()
			end
		end
	end

	setActive = var_126_13

	var_126_13(arg_126_0.spPanel, false)

	return
end

function var_0_1.setSPBuffSelected(arg_131_0, arg_131_1)
	pg = var_1_10002

	local var_131_0 = var_1_10002.benefit_buff_template[arg_131_1]

	ActivityBuff = var_1_10003

	local var_131_1 = var_1_10003.GetBenefitCondition(var_131_0.benefit_condition)

	assert = var_1_10004

	var_1_10004(var_131_1[1] == "item")

	arg_131_0.spItemID = var_131_1[2]

	arg_131_0:setTicketInfo(arg_131_0.btnSp, arg_131_0.spItemID)

	setText = var_5

	var_5(arg_131_0.spDesc, var_131_0.desc)

	Chapter = var_5

	local var_131_2 = var_5.GetSPOperationItemCacheKey(arg_131_0.chapter.id)

	PlayerPrefs = var_6

	var_6.SetInt(var_131_2, arg_131_0.spItemID)

	return
end

function var_0_1.clearSPBuff(arg_132_0)
	local var_132_0 = arg_132_0:getLegalSPBuffList()

	arg_132_0.spItemID = nil

	arg_132_0:setSPBtnFormByBuffCount()

	if #var_132_0 == 0 then
		setActive = var_2

		local var_132_1 = arg_132_0.btnSp

		var_2(var_4.Find(var_132_1, "item"), false)
	elseif #var_132_0 == 1 then
		setActive = var_2

		local var_132_2 = arg_132_0.btnSp

		var_2(var_4.Find(var_132_2, "item"), true)

		setActive = var_2

		var_2(arg_132_0.spCheckMark, false)
	elseif #var_132_0 > 1 then
		setActive = var_2

		local var_132_3 = arg_132_0.btnSp

		var_2(var_4.Find(var_132_3, "item"), false)

		setText = var_2

		local var_132_4 = arg_132_0.spDesc

		i18n = var_5

		var_2(var_132_4, var_5("levelScene_select_SP_OP"))
	end

	return
end

function var_0_1.setSPBtnFormByBuffCount(arg_133_0)
	if #arg_133_0:getLegalSPBuffList() == 0 then
		setActive = var_2

		var_2(arg_133_0.spItemEmptyBlock, true)

		setActive = var_2

		var_2(arg_133_0.spDesc, false)

		setActive = var_2

		var_2(arg_133_0.spCheckBox, false)

		setActive = var_2

		local var_133_0 = arg_133_0.btnSp

		var_2(var_4.Find(var_133_0, "add"), false)
	elseif #var_1 == 1 then
		setActive = var_2

		var_2(arg_133_0.spItemEmptyBlock, false)

		setActive = var_2

		var_2(arg_133_0.spDesc, true)

		setActive = var_2

		var_2(arg_133_0.spCheckBox, true)

		setActive = var_2

		local var_133_1 = arg_133_0.btnSp

		var_2(var_4.Find(var_133_1, "add"), false)
	elseif #var_1 > 1 then
		setActive = var_2

		var_2(arg_133_0.spItemEmptyBlock, false)

		setActive = var_2

		var_2(arg_133_0.spDesc, true)

		setActive = var_2

		var_2(arg_133_0.spCheckBox, false)

		setActive = var_2

		local var_133_2 = arg_133_0.btnSp

		var_2(var_4.Find(var_133_2, "add"), true)
	end

	return
end

function var_0_1.setTicketInfo(arg_134_0, arg_134_1, arg_134_2)
	local var_134_0

	tonumber = var_1_10004
	arg_134_2 = var_1_10004(arg_134_2)
	ipairs = var_4

	for iter_134_0, iter_134_1 in var_4(arg_134_0.spOPTicketItems) do
		if arg_134_2 == iter_134_1.configId then
			var_134_0 = iter_134_1

			break
		end
	end

	if var_134_0 then
		setText = var_4

		var_4(arg_134_1:Find("item/count"), var_134_0.count)

		GetImageSpriteFromAtlasAsync = var_4

		var_4(var_134_0:getConfig("icon"), "", arg_134_1:Find("item/icon"))
	else
		setText = var_4

		var_4(arg_134_1:Find("item/count"), 0)

		GetImageSpriteFromAtlasAsync = var_4
		Drop = var_6

		local var_134_1 = var_6.New
		local var_134_2 = {}

		DROP_TYPE_ITEM = var_9
		var_134_2.type = var_9
		var_134_2.id = arg_134_2

		local var_134_3 = var_134_1(var_134_2)

		var_4(var_6.getIcon(var_134_3), "", arg_134_1:Find("item/icon"))
	end

	setActive = var_4

	var_4(arg_134_1:Find("item"), true)

	return
end

function var_0_1.getSPItem(arg_135_0)
	return arg_135_0.spItemID
end

function var_0_1.SetDuty(arg_136_0, arg_136_1, arg_136_2)
	if not arg_136_2 or not arg_136_0.duties then
		return
	end

	if arg_136_0.duties[arg_136_1] == arg_136_2 then
		return
	end

	arg_136_0.duties[arg_136_1] = arg_136_2
	arg_136_0.duties[3 - arg_136_1] = nil

	arg_136_0:RefreshDutyBar()

	return
end

function var_0_1.UpdateDuties(arg_137_0)
	if not arg_137_0.dutyTabEnabled then
		return
	end

	local var_137_0 = 0
	local var_137_1 = 0

	for iter_137_0 = 1, 2 do
		if not arg_137_0:IsListOfFleetEmpty(iter_137_0) then
			var_137_0 = var_137_0 + 1
			var_137_1 = iter_137_0
		end
	end

	if var_137_0 == 0 then
		table = var_3

		var_3.clear(arg_137_0.duties)
	elseif var_137_0 == 1 then
		local var_137_2 = arg_137_0.duties

		ChapterFleet = var_137_3
		var_137_2[var_137_1] = var_137_3.DUTY_KILLALL
		arg_137_0.duties[3 - var_137_1] = nil
	elseif var_137_0 == 2 then
		local var_137_3

		if arg_137_0.duties[1] then
			if not (arg_137_0.duties[1] < 3) or not (3 - var_3) then
				var_137_3 = 7 - var_3
			end

			arg_137_0.duties[2] = var_137_3
		elseif arg_137_0.duties[2] then
			if not (arg_137_0.duties[2] < 3) or not (3 - var_3) then
				var_137_3 = 7 - var_3
			end

			arg_137_0.duties[1] = var_137_3
		else
			local var_137_4 = arg_137_0.duties

			ChapterFleet = var_137_3
			var_137_4[1] = var_137_3.DUTY_CLEANPATH

			local var_137_5 = arg_137_0.duties

			ChapterFleet = var_4
			var_137_5[2] = var_4.DUTY_KILLBOSS
		end
	end

	if var_137_1 ~= 0 then
		local var_137_6 = "lastFleetDuty_"
		local var_137_7

		if not arg_137_0.chapter.id then
			var_137_7 = 0
		end

		local var_137_8 = var_137_6 .. var_137_7
		local var_137_9 = 0
		local var_137_10 = 8

		ipairs = iter_137_0

		for iter_137_1, iter_137_2 in iter_137_0({
			var_137_1,
			arg_137_0.duties[var_137_1]
		}) do
			bit = var_1_10011
			var_137_9 = var_137_9 + var_1_10011.lshift(iter_137_2, var_137_10 * (iter_137_1 - 1))
		end

		PlayerPrefs = var_6

		var_6.SetInt(var_137_8, var_137_9)

		PlayerPrefs = var_6

		var_6.Save()
	end

	return
end

function var_0_1.RefreshDutyBar(arg_138_0)
	arg_138_0:UpdateDuties()
	arg_138_0:UpdateDutyBar()

	return
end

function var_0_1.UpdateDutyBar(arg_139_0)
	local var_139_0 = arg_139_0.contextData.tabIndex == var_0_1.TabIndex.Duty

	for iter_139_0 = 1, 2 do
		local var_139_1 = arg_139_0._tf
		local var_139_2 = var_6.Find

		string = var_1_10009

		local var_139_3 = var_139_2(var_139_1, var_1_10009.format("panel/ShipList/fleet/%d/DutySelect", iter_139_0))

		setActive = var_1_10007

		var_1_10007(var_139_3, var_139_0 and arg_139_0.duties[iter_139_0] ~= nil)
	end

	local var_139_4 = arg_139_0._tf
	local var_139_5 = var_2.Find(var_139_4, "panel/ShipList/sub/1/DutySelect")

	setActive = var_3

	var_3(var_139_5, var_139_0 and not arg_139_0:IsListOfFleetEmpty(3))

	if not var_139_0 then
		return
	end

	pairs = var_3

	for iter_139_1, iter_139_2 in var_3(arg_139_0.duties) do
		for iter_139_3 = 1, 4 do
			setActive = var_1_10012

			local var_139_6 = arg_139_0.dutyItems[iter_139_1][iter_139_3]

			var_1_10012(var_14.Find(var_139_6, "Checkmark"), iter_139_3 == iter_139_2)
		end
	end

	ys = var_3

	local var_139_7 = var_3.Battle.BattleState.IsAutoSubActive()

	for iter_139_4 = 1, 2 do
		local var_139_8 = arg_139_0.dutyItems[3][iter_139_4]

		setActive = var_1_10009

		var_1_10009(var_139_8:Find("Checkmark"), iter_139_4 == 1 == var_139_7)
	end

	return
end

function var_0_1.GetOrderedDuties(arg_140_0)
	if not arg_140_0.duties then
		return
	end

	arg_140_0:UpdateDuties()

	local var_140_0 = {}
	local var_140_1 = 1

	for iter_140_0 = 1, 2 do
		if arg_140_0.duties[iter_140_0] then
			var_140_0[var_140_1] = arg_140_0.duties[iter_140_0]
			var_140_1 = var_140_1 + 1
		end
	end

	return var_140_0
end

function var_0_1.SetAutoSub(arg_141_0, arg_141_1)
	tobool = var_1_10002
	arg_141_1 = var_1_10002(arg_141_1)
	ys = var_2

	if arg_141_1 == var_2.Battle.BattleState.IsAutoSubActive() then
		return
	end

	AutoBotCommand = var_2

	if not var_2.autoBotSatisfied() then
		return
	end

	pg = var_2

	local var_141_0 = var_2.m02
	local var_141_1 = var_2.sendNotification

	GAME = var_1_10005

	var_141_1(var_141_0, var_1_10005.AUTO_SUB, {
		isActiveSub = not arg_141_1
	})
	arg_141_0:UpdateDutyBar()

	return
end

function var_0_1.GetValidFleets(arg_142_0, arg_142_1)
	if arg_142_0.mode == var_0_3.SELECT then
		local var_142_0 = {}
		local var_142_1

		if not arg_142_1 or not {
			arg_142_1
		} then
			var_142_1 = {}
			FleetType = var_1_10004
			var_142_1[1] = var_1_10004.Normal
			FleetType = var_1_10004
			var_142_1[2] = var_1_10004.Submarine
		end

		ipairs = var_1_10004

		for iter_142_0, iter_142_1 in var_1_10004(var_142_1) do
			local var_142_2 = arg_142_0.selectIds[iter_142_1]

			ipairs = var_1_10010

			for iter_142_2, iter_142_3 in var_1_10010(var_142_2) do
				if 0 < iter_142_3 then
					table = var_15

					var_15.insert(var_142_0, arg_142_0.fleets[iter_142_3])
				end
			end
		end

		return var_142_0
	elseif arg_142_0.mode == var_0_3.EDIT then
		local var_142_3 = {}
		local var_142_4
		local var_142_5

		FleetType = var_1_10005

		if arg_142_1 == var_1_10005.Normal then
			var_142_4 = 1
			var_142_5 = 2
		else
			FleetType = var_5

			if arg_142_1 == var_5.Submarine then
				var_142_4 = 3
				var_142_5 = 3
			elseif not arg_142_1 then
				var_142_4 = 1
				var_142_5 = 3
			end
		end

		for iter_142_4 = var_142_4, var_142_5 do
			local var_142_6 = #arg_142_0.eliteFleetList[iter_142_4]

			if 0 < var_142_6 then
				local var_142_7 = {}

				pairs = var_11

				for iter_142_5, iter_142_6 in var_11(arg_142_0.eliteCommanderList[iter_142_4]) do
					table = var_1_10016

					var_1_10016.insert(var_142_7, {
						pos = iter_142_5,
						id = iter_142_6
					})
				end

				TypedFleet = var_11

				local var_142_8 = var_11.New
				local var_142_9 = {
					ship_list = var_9,
					commanders = var_142_7
				}

				FleetType = iter_142_5
				var_142_9.fleetType = iter_142_5.Normal

				local var_142_10 = var_142_8(var_142_9)

				table = var_12

				var_12.insert(var_142_3, var_142_10)
			end
		end

		return var_142_3
	end

	return
end

function var_0_1.IsListOfFleetEmpty(arg_143_0, arg_143_1)
	if arg_143_1 > 0 and arg_143_1 < 3 then
		var_1_10004 = arg_143_0

		local var_143_0 = arg_143_0.getLimitNums

		FleetType = var_1_10005

		if arg_143_1 > var_143_0(var_1_10004, var_1_10005.Normal) then
			do return true end

			goto label_143_0
		end
	end

	if arg_143_1 == 3 then
		local var_143_1 = arg_143_1 - 2
		local var_143_2 = arg_143_0
		local var_143_3 = arg_143_0.getLimitNums

		FleetType = var_1_10006

		if var_143_1 > var_143_3(var_143_2, var_1_10006.Submarine) then
			return true
		end
	end

	::label_143_0::

	if arg_143_0.mode == var_0_3.SELECT then
		local var_143_4

		if arg_143_1 > 0 and arg_143_1 < 3 then
			local var_143_5 = arg_143_0.selectIds

			FleetType = var_1_10004
			var_143_4 = var_143_5[var_1_10004.Normal][arg_143_1] or 0
		elseif arg_143_1 == 3 then
			local var_143_6 = arg_143_0.selectIds

			FleetType = var_1_10004
			var_143_4 = var_143_6[var_1_10004.Submarine][arg_143_1 - 2] or 0
		end

		return var_143_4 == 0
	elseif arg_143_0.mode == var_0_3.EDIT then
		return #arg_143_0.eliteFleetList[arg_143_1] == 0
	end

	return
end

function var_0_1.GetListFleets(arg_144_0)
	local var_144_0 = {}
	local var_144_1 = arg_144_0
	local var_144_2 = arg_144_0.getLimitNums

	FleetType = var_1_10005

	local var_144_3 = var_144_2(var_144_1, var_1_10005.Normal)
	local var_144_4 = arg_144_0
	local var_144_5 = arg_144_0.getLimitNums

	FleetType = var_1_10006

	local var_144_6 = var_144_5(var_144_4, var_1_10006.Submarine)

	if arg_144_0.mode == var_0_3.SELECT then
		local var_144_7 = arg_144_0.selectIds

		FleetType = var_5

		local var_144_8 = var_144_7[var_5.Normal]

		for iter_144_0 = 1, var_144_3 do
			if not var_144_8[iter_144_0] then
				var_1_10009 = 0
			end

			local var_144_9

			if not (var_1_10009 > 0) or not arg_144_0.fleets[var_1_10009] then
				var_144_9 = nil
			end

			var_144_0[iter_144_0] = var_144_9
		end

		local var_144_10 = arg_144_0.selectIds

		FleetType = var_6

		local var_144_11 = var_144_10[var_6.Submarine]

		for iter_144_1 = 1, var_144_6 do
			if not var_144_11[iter_144_1] then
				var_1_10009 = 0
			end

			local var_144_12 = iter_144_1 + var_144_3
			local var_144_13

			if not (var_1_10009 > 0) or not arg_144_0.fleets[var_1_10009] then
				var_144_13 = nil
			end

			var_144_0[var_144_12] = var_144_13
		end
	elseif arg_144_0.mode == var_0_3.EDIT then
		local var_144_14 = {}

		for iter_144_2 = 1, var_144_3 do
			table = var_1_10009

			var_1_10009.insert(var_144_14, iter_144_2)
		end

		for iter_144_3 = 1, var_144_6 do
			table = var_1_10009

			var_1_10009.insert(var_144_14, iter_144_3 + 2)
		end

		for iter_144_4 = 1, #var_144_14 do
			local var_144_15 = var_144_14[iter_144_4]
			local var_144_16

			if #arg_144_0.eliteFleetList[var_144_15] > 0 then
				if 2 < var_144_15 then
					FleetType = var_144_17

					local var_144_17

					if not var_144_17.Submarine then
						FleetType = var_144_17
						var_144_17 = var_144_17.Normal
					end

					local var_144_18 = {}

					pairs = var_1_10014

					for iter_144_5, iter_144_6 in var_1_10014(arg_144_0.eliteCommanderList[var_144_15]) do
						table = var_1_10019

						var_1_10019.insert(var_144_18, {
							pos = iter_144_5,
							id = iter_144_6
						})
					end

					TypedFleet = var_1_10014
					var_144_16 = var_1_10014.New({
						ship_list = var_11,
						commanders = var_144_18,
						fleetType = var_144_17
					})
					var_144_0[iter_144_4] = var_144_16
				end
			end
		end
	end

	return var_144_0
end

function var_0_1.IsSelectMode(arg_145_0)
	return arg_145_0.mode == var_0_3.SELECT
end

function var_0_1.SwitchDisplayMode(arg_146_0)
	local var_146_0 = arg_146_0.displayMode == var_0_4.ADDITION_SUPPORT

	setActive = var_2

	local var_146_1 = arg_146_0._tf

	var_2(var_4.Find(var_146_1, "panel/ShipList/Line"), not var_146_0)

	setActive = var_2

	local var_146_2 = arg_146_0._tf

	var_2(var_4.Find(var_146_2, "panel/ShipList/support"), var_146_0)

	local var_146_3 = arg_146_0._tf
	local var_146_4 = var_2.Find(var_146_3, "panel/ShipList")
	local var_146_5 = var_2.GetComponent

	typeof = var_5
	VerticalLayoutGroup = var_7

	local var_146_6 = var_146_5(var_146_4, var_5(var_7)).padding

	var_146_6.top = var_146_0 and 9 or 20
	var_146_6.bottom = var_146_0 and 14 or 25
	var_2.padding = var_146_6
	var_2.spacing = var_146_0 and 13 or 20

	return
end

function var_0_1.sortTeamLimitation(arg_147_0)
	Clone = var_1_10001
	arg_147_0 = var_1_10001(arg_147_0)
	table = var_1

	var_1.sort(arg_147_0, function(arg_148_0, arg_148_1)
		type = var_2_10002

		local var_148_0 = var_2_10002(arg_148_0)

		type = var_2_10003

		if var_148_0 == var_2_10003(arg_148_1) then
			return var_3 < var_148_0
		elseif arg_148_1 == 0 or var_3 == "string" and arg_148_0 ~= 0 then
			return true
		else
			return false
		end

		return
	end)

	return arg_147_0
end

return var_0_1
