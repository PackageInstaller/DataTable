class = var_0_10000

local var_0_0 = "WorldCollectionLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "WorldCollectionUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0.top

	arg_2_0.backBtn = var_1.Find(var_2_1, "back_btn")

	local var_2_2 = arg_2_0.top

	arg_2_0.topToggles = var_1.Find(var_2_2, "toggles")

	local var_2_3 = arg_2_0._tf

	arg_2_0.rtMain = var_1.Find(var_2_3, "main")

	local var_2_4 = arg_2_0.rtMain

	arg_2_0.entranceContainer = var_1.Find(var_2_4, "list_bg/map_list/content")

	local var_2_5 = arg_2_0.rtMain

	arg_2_0.btnGetAll = var_1.Find(var_2_5, "list_bg/btn_get_all")
	GetComponent = var_1
	arg_2_0.scrollEntrance = var_1(arg_2_0.entranceContainer, "LScrollRect")

	function arg_2_0.scrollEntrance.onUpdateItem(arg_3_0, arg_3_1)
		arg_3_0 = arg_3_0 + 1
		tf = var_2_10002

		local var_3_0 = var_2_10002(arg_3_1)
		local var_3_1 = arg_2_0.achEntranceList[arg_3_0]
		local var_3_2 = arg_2_0.entranceOjbecDic

		var_3_2[arg_3_0] = var_3_0
		setText = var_3_2

		var_3_2(var_3_0:Find("icon/deco_id"), var_3_1.config.serial_number)

		setText = var_3_2

		local var_3_3 = var_3_0:Find("icon/name")
		local var_3_4 = var_3_1:GetBaseMap()

		var_3_2(var_3_3, var_6.GetName(var_3_4))

		setActive = var_3_2

		local var_3_5 = var_3_0
		local var_3_6 = var_3_0.Find(var_3_5, "icon/tip")

		nowWorld = var_3_5

		local var_3_7 = var_3_5()

		var_3_2(var_3_6, var_6.AnyUnachievedAchievement(var_3_7, var_3_1))

		onButton = var_3_2

		local var_3_8 = arg_2_0
		local var_3_9 = var_3_0

		local function var_3_10()
			local var_4_0 = arg_2_0

			var_0.UpdateAchievement(var_4_0, arg_3_0)

			return
		end

		SFX_PANEL = var_8

		var_3_2(var_3_8, var_3_9, var_3_10, var_8)

		local var_3_11 = var_3_0
		local var_3_12 = var_3_0.Find(var_3_11, "icon")

		setAnchoredPosition = var_3_11

		local var_3_13 = var_3_12
		local var_3_14 = {}
		local var_3_15 = 1 - arg_3_0 % 2 * 2

		math = var_2_10009
		var_3_14.y = var_3_15 * var_2_10009.abs(var_3_12.anchoredPosition.y)

		var_3_11(var_3_13, var_3_14)

		setActive = var_3_11

		var_3_11(var_3_12:Find("select"), arg_2_0.selectedIndex == arg_3_0)

		setText = var_3_11

		local var_3_16 = var_3_12
		local var_3_17 = var_3_12.Find(var_3_16, "select/gomap/Text")

		i18n = var_3_16

		var_3_11(var_3_17, var_3_16("world_target_goto"))

		onButton = var_3_11

		local var_3_18 = arg_2_0
		local var_3_19 = var_3_12:Find("select/gomap")

		local function var_3_20()
			local var_5_0 = arg_2_0
			local var_5_1 = var_0.emit

			WorldCollectionMediator = var_3_10002

			var_5_1(var_5_0, var_3_10002.ON_MAP, var_3_1)

			local var_5_2 = arg_2_0

			var_0.closeView(var_5_2)

			return
		end

		SFX_PANEL = var_9

		var_3_11(var_3_18, var_3_19, var_3_20, var_9)

		return
	end

	function arg_2_0.scrollEntrance.onReturnItem(arg_6_0, arg_6_1)
		if arg_2_0.exited then
			return
		end

		local var_6_0 = arg_2_0.entranceOjbecDic

		var_6_0[arg_6_0 + 1] = nil
		removeOnButton = var_6_0

		var_6_0(arg_6_1)

		return
	end

	local var_2_6 = arg_2_0.scrollEntrance.onValueChanged

	var_1.AddListener(var_2_6, function(arg_7_0)
		local var_7_0 = arg_2_0

		var_1.UpdateJumpBtn(var_7_0)

		return
	end)

	local var_2_7 = arg_2_0.rtMain

	arg_2_0.entrancePanel = var_1.Find(var_2_7, "map")

	local var_2_8 = arg_2_0.entrancePanel

	arg_2_0.entranceTitle = var_1.Find(var_2_8, "target_rect/title")

	local var_2_9 = arg_2_0.entrancePanel

	arg_2_0.targetContainer = var_1.Find(var_2_9, "target_rect/target_list/content")
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0.targetContainer
	local var_2_12 = arg_2_0.targetContainer

	arg_2_0.targetItemList = var_2_10(var_2_11, var_3.Find(var_2_12, "item"))

	local var_2_13 = arg_2_0.targetItemList

	var_1.make(var_2_13, function(arg_8_0, arg_8_1, arg_8_2)
		arg_8_1 = arg_8_1 + 1
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_8_1 > #arg_2_0.achEntranceList[arg_2_0.selectedIndex].config.normal_target
			local var_8_1 = arg_8_2
			local var_8_2 = arg_8_2.Find(var_8_1, "bg")

			setActive = var_8_1

			var_8_1(var_8_2:Find("normal"), not var_8_0)

			setActive = var_8_1

			var_8_1(var_8_2:Find("hidden"), var_8_0)

			local var_8_3 = arg_2_0.targetList[arg_8_1]
			local var_8_4 = var_6.IsAchieved(var_8_3)
			local var_8_5 = not var_8_0 or var_8_4 or arg_2_0.showHiddenDesc

			setText = var_9

			local var_8_6 = var_8_2:Find("desc")
			local var_8_7

			if not var_8_5 or not var_6.config.target_desc then
				var_8_7 = "???"
			end

			var_9(var_8_6, var_8_7)

			setText = var_9

			local var_8_8 = var_8_2:Find("progress")
			local var_8_9

			if not var_8_5 or not (var_6:GetProgress() .. "/" .. var_6:GetMaxProgress()) then
				var_8_9 = ""
			end

			var_9(var_8_8, var_8_9)

			setActive = var_9

			var_9(var_8_2:Find("finish_mark/Image"), var_8_4)

			local var_8_10 = arg_8_2:Find("pop")
			local var_8_11 = var_6:GetTriggers()
			local var_8_13

			if var_8_5 then
				::label_8_0::

				local var_8_12 = #var_8_11

				var_8_13 = 1 < var_8_12
			end

			local var_8_14

			if var_8_13 then
				var_8_14 = var_8_10

				local var_8_15 = var_8_10:Find("Text")
				local var_8_16 = var_8_14.childCount

				local function var_8_17(arg_9_0, arg_9_1)
					local var_9_0 = var_8_11[arg_9_0]

					setText = var_3_10003

					var_3_10003(arg_9_1, var_9_0:GetDesc())

					setTextColor = var_3_10003

					local var_9_1 = arg_9_1

					if var_9_0:IsAchieved() then
						Color = var_9_2

						local var_9_2

						if not var_9_2.New(0.3686274509803922, 0.6078431372549019, 1) then
							Color = var_9_2
							var_9_2 = var_9_2.New(0.4745098039215686, 0.4745098039215686, 0.4745098039215686)
						end

						var_3_10003(var_9_1, var_9_2)

						setActive = var_3_10003

						var_3_10003(arg_9_1, true)

						return
					end
				end

				for iter_8_0 = #var_8_11, var_8_16 - 1 do
					setActive = var_2_10020

					var_2_10020(var_8_14:GetChild(iter_8_0), false)
				end

				for iter_8_1 = var_8_16, #var_8_11 - 1 do
					cloneTplTo = var_2_10020

					var_2_10020(var_8_15, var_8_14)
				end

				for iter_8_2 = 0, #var_8_11 - 1 do
					var_8_17(iter_8_2 + 1, var_8_14:GetChild(iter_8_2))
				end
			end

			triggerToggle = var_8_14

			var_8_14(arg_8_2, false)

			setToggleEnabled = var_8_14

			var_8_14(arg_8_2, var_8_13)

			setActive = var_8_14

			var_8_14(var_8_2:Find("arrow"), var_8_13)
		end

		return
	end)

	local var_2_14 = arg_2_0.entrancePanel

	arg_2_0.achAwardRect = var_1.Find(var_2_14, "award_rect")

	local var_2_15 = arg_2_0.achAwardRect

	arg_2_0.achAchieveBtn = var_1.Find(var_2_15, "btn_achieve")

	local var_2_16 = arg_2_0.entrancePanel

	arg_2_0.overviewBtn = var_1.Find(var_2_16, "btn_overview")
	WorldAchAwardSubview = var_1
	arg_2_0.subviewAchAward = var_1.New(arg_2_0._tf, arg_2_0.event)

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.bind

	WorldAchAwardSubview = var_3

	var_2_18(var_2_17, var_3.ShowDrop, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_2_0

		var_2.emit(var_10_0, var_0_1.ON_DROP, arg_10_1)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_11_0)
	local var_11_0 = arg_11_0.subviewAchAward

	if var_1.isShowing(var_11_0) then
		local var_11_1 = arg_11_0.subviewAchAward

		var_1.ActionInvoke(var_11_1, "Hide")
	else
		var_0_1.super.onBackPressed(arg_11_0)
	end

	return
end

function var_0_1.didEnter(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_12_0, arg_12_0._tf)

	onButton = var_1

	local var_12_1 = arg_12_0
	local var_12_2 = arg_12_0.backBtn

	local function var_12_3()
		local var_13_0 = arg_12_0

		var_0.closeView(var_13_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_12_1, var_12_2, var_12_3, var_1_10005)

	onToggle = var_1

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_0.topToggles
	local var_12_6 = var_3.Find(var_12_5, "all")

	local function var_12_7(arg_14_0)
		if arg_14_0 then
			local var_14_0 = arg_12_0

			var_1.UpdateEntranceFilter(var_14_0, false)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_12_4, var_12_6, var_12_7, var_5)

	setText = var_1

	local var_12_8 = arg_12_0.topToggles
	local var_12_9 = var_2.Find(var_12_8, "all/Text")

	i18n = var_12_8

	var_1(var_12_9, var_12_8("world_target_filter_tip1"))

	setText = var_1

	local var_12_10 = arg_12_0.topToggles
	local var_12_11 = var_2.Find(var_12_10, "all/Image/Text")

	i18n = var_12_10

	var_1(var_12_11, var_12_10("world_target_filter_tip1"))

	onToggle = var_1

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.topToggles
	local var_12_14 = var_3.Find(var_12_13, "unfinish")

	local function var_12_15(arg_15_0)
		if arg_15_0 then
			local var_15_0 = arg_12_0

			var_1.UpdateEntranceFilter(var_15_0, true)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_12_12, var_12_14, var_12_15, var_5)

	setText = var_1

	local var_12_16 = arg_12_0.topToggles
	local var_12_17 = var_2.Find(var_12_16, "unfinish/Text")

	i18n = var_12_16

	var_1(var_12_17, var_12_16("world_target_filter_tip2"))

	setText = var_1

	local var_12_18 = arg_12_0.topToggles
	local var_12_19 = var_2.Find(var_12_18, "unfinish/Image/Text")

	i18n = var_12_18

	var_1(var_12_19, var_12_18("world_target_filter_tip2"))

	onButton = var_1

	local var_12_20 = arg_12_0
	local var_12_21 = arg_12_0.rtMain
	local var_12_22 = var_3.Find(var_12_21, "list_bg/jump_icon_left")

	local function var_12_23()
		local var_16_0 = arg_12_0
		local var_16_1 = var_0.ScrollAndSelectEntrance
		local var_16_2 = arg_12_0

		var_16_1(var_16_0, var_2.GetAwardIndex(var_16_2, false))

		return
	end

	SFX_PANEL = var_5

	var_1(var_12_20, var_12_22, var_12_23, var_5)

	onButton = var_1

	local var_12_24 = arg_12_0
	local var_12_25 = arg_12_0.rtMain
	local var_12_26 = var_3.Find(var_12_25, "list_bg/jump_icon_right")

	local function var_12_27()
		local var_17_0 = arg_12_0
		local var_17_1 = var_0.ScrollAndSelectEntrance
		local var_17_2 = arg_12_0

		var_17_1(var_17_0, var_2.GetAwardIndex(var_17_2, true))

		return
	end

	SFX_PANEL = var_5

	var_1(var_12_24, var_12_26, var_12_27, var_5)

	onButton = var_1

	local var_12_28 = arg_12_0
	local var_12_29 = arg_12_0.btnGetAll

	local function var_12_30()
		nowWorld = var_2_10000

		local var_18_0 = var_2_10000()
		local var_18_1, var_18_2 = var_0.GetFinishAchievements(var_18_0, arg_12_0.achEntranceList)
		local var_18_4

		if #var_18_1 > 0 then
			pg = var_18_4

			local var_18_3 = var_18_4.MsgboxMgr.GetInstance()

			var_18_4 = var_18_4.ShowMsgBox

			local var_18_5 = {}

			i18n = var_2_10005
			var_18_5.content = var_2_10005("world_target_get_all")

			function var_18_5.onYes()
				local var_19_0 = arg_12_0
				local var_19_1 = var_0.emit

				WorldCollectionMediator = var_3_10002

				var_19_1(var_19_0, var_3_10002.ON_ACHIEVE_STAR, var_18_1)

				return
			end

			var_18_4(var_18_3, var_18_5)
		else
			pg = var_18_4

			local var_18_6 = var_18_4.TipsMgr.GetInstance()

			var_2.ShowTips(var_18_6, "without any award")
		end

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_12_28, var_12_29, var_12_30, var_5)

	onButton = var_1

	local var_12_31 = arg_12_0
	local var_12_32 = arg_12_0.achAchieveBtn

	local function var_12_33()
		nowWorld = var_2_10000

		local var_20_0 = var_2_10000()
		local var_20_1, var_20_2 = var_0.AnyUnachievedAchievement(var_20_0, arg_12_0.entrance)

		if var_20_1 then
			local var_20_3 = arg_12_0
			local var_20_4 = var_2.emit

			WorldCollectionMediator = var_2_10004

			var_20_4(var_20_3, var_2_10004.ON_ACHIEVE_STAR, {
				{
					id = arg_12_0.entrance.id,
					star_list = {
						var_20_2.star
					}
				}
			})
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_12_31, var_12_32, var_12_33, var_5)

	onButton = var_1

	local var_12_34 = arg_12_0
	local var_12_35 = arg_12_0.entrancePanel
	local var_12_36 = var_3.Find(var_12_35, "page_left")

	local function var_12_37()
		local var_21_0 = arg_12_0

		var_0.ScrollAndSelectEntrance(var_21_0, arg_12_0.selectedIndex - 1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_12_34, var_12_36, var_12_37, var_5)

	onButton = var_1

	local var_12_38 = arg_12_0
	local var_12_39 = arg_12_0.entrancePanel
	local var_12_40 = var_3.Find(var_12_39, "page_right")

	local function var_12_41()
		local var_22_0 = arg_12_0

		var_0.ScrollAndSelectEntrance(var_22_0, arg_12_0.selectedIndex + 1)

		return
	end

	SFX_PANEL = var_5

	var_1(var_12_38, var_12_40, var_12_41, var_5)

	onButton = var_1

	local var_12_42 = arg_12_0
	local var_12_43 = arg_12_0.overviewBtn

	local function var_12_44()
		local var_23_0 = arg_12_0
		local var_23_1 = var_0.emit

		WorldCollectionMediator = var_2_10002

		var_23_1(var_23_0, var_2_10002.ON_ACHIEVE_OVERVIEW)

		return
	end

	SFX_PANEL = var_5

	var_1(var_12_42, var_12_43, var_12_44, var_5)

	triggerToggle = var_1

	local var_12_45 = arg_12_0.topToggles

	var_1(var_2.Find(var_12_45, "all"), true)

	return
end

function var_0_1.willExit(arg_24_0)
	local var_24_0 = arg_24_0.subviewAchAward

	var_1.Destroy(var_24_0)

	pg = var_1

	local var_24_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_24_1, arg_24_0._tf)

	return
end

function var_0_1.SetAchievementList(arg_25_0, arg_25_1)
	arg_25_0.baseEntranceList = arg_25_1

	return
end

function var_0_1.BuildEntranceScrollPos(arg_26_0)
	arg_26_0.entrancePos = {}
	arg_26_0.entranceIndexDic = {}
	ipairs = var_1

	for iter_26_0, iter_26_1 in var_1(arg_26_0.achEntranceList) do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_26_0 = arg_26_0.entrancePos
		local var_26_1 = arg_26_0.scrollEntrance

		var_1_10006(var_26_0, var_8.HeadIndexToValue(var_26_1, iter_26_0 - 1))

		var_1_10006 = arg_26_0.entranceIndexDic
		var_1_10006[iter_26_1.id] = iter_26_0
		nowWorld = var_1_10006

		local var_26_2 = var_1_10006()

		if var_1_10006.AnyUnachievedAchievement(var_26_2, iter_26_1) then
			table = var_1_10006

			var_1_10006.insert(arg_26_0.achAwardIndexList, iter_26_0)
		end
	end

	return
end

function var_0_1.UpdateEntranceFilter(arg_27_0, arg_27_1)
	if arg_27_1 then
		underscore = var_1_10002
		arg_27_0.achEntranceList = var_1_10002.filter(arg_27_0.baseEntranceList, function(arg_28_0)
			nowWorld = var_2_10001

			local var_28_0 = var_2_10001()
			local var_28_1, var_28_2, var_28_3 = var_1.CountAchievements(var_28_0, arg_28_0)

			return var_28_3 > var_28_1 + var_28_2
		end)
	else
		underscore = var_1_10002
		arg_27_0.achEntranceList = var_1_10002.rest(arg_27_0.baseEntranceList, 1)
	end

	arg_27_0:UpdateGetAllAwardBtn()

	arg_27_0.achAwardIndexList = {}
	arg_27_0.entranceOjbecDic = {}

	local var_27_0 = arg_27_0.scrollEntrance

	var_2.SetTotalCount(var_27_0, #arg_27_0.achEntranceList)

	local var_27_1 = arg_27_0

	arg_27_0.BuildEntranceScrollPos(var_27_1)

	local var_27_2 = arg_27_0.contextData

	defaultValue = var_27_1
	var_27_2.entranceId = var_27_1(arg_27_0.contextData.entranceId, 0)
	defaultValue = var_27_2

	local var_27_3 = var_27_2(arg_27_0.entranceIndexDic[arg_27_0.contextData.entranceId], 1)

	if arg_27_0.achEntranceList[var_27_3] then
		arg_27_0:ScrollAndSelectEntrance(var_27_3)
	else
		setActive = var_3

		local var_27_4 = arg_27_0.entrancePanel

		var_3(var_4.Find(var_27_4, "page_left"), false)

		setActive = var_3

		local var_27_5 = arg_27_0.entrancePanel

		var_3(var_4.Find(var_27_5, "page_right"), false)
	end

	return
end

function var_0_1.UpdateGetAllAwardBtn(arg_29_0)
	nowWorld = var_1_10001

	local var_29_0 = var_1_10001()
	local var_29_1, var_29_2 = var_1.GetFinishAchievements(var_29_0, arg_29_0.achEntranceList)

	pg = var_3

	local var_29_3 = var_3.gameset.world_target_obtain.key_value

	setActive = var_1_10004

	var_1_10004(arg_29_0.btnGetAll, var_29_3 <= #var_29_1)

	return
end

function var_0_1.FlushEntranceItem(arg_30_0, arg_30_1)
	ipairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(arg_30_1) do
		local var_30_0 = arg_30_0.entranceIndexDic[iter_30_1.id]

		nowWorld = var_8

		local var_30_1 = var_8()

		if not var_8.AnyUnachievedAchievement(var_30_1, arg_30_0.achEntranceList[var_30_0]) then
			if arg_30_0.entranceOjbecDic[var_30_0] then
				setActive = var_8

				local var_30_2 = arg_30_0.entranceOjbecDic[var_30_0]

				var_8(var_9.Find(var_30_2, "icon/tip"), false)
			end

			table = var_8

			var_8.removebyvalue(arg_30_0.achAwardIndexList, var_30_0)
		end
	end

	arg_30_0:UpdateGetAllAwardBtn()

	return
end

function var_0_1.UpdateAchievement(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_2 or arg_31_0.selectedIndex ~= arg_31_1 then
		local var_31_0 = arg_31_0.selectedIndex

		arg_31_0.selectedIndex = arg_31_1
		arg_31_1 = var_31_0
		ipairs = var_31_0

		for iter_31_0, iter_31_1 in var_31_0({
			arg_31_1,
			arg_31_0.selectedIndex
		}) do
			if arg_31_0.entranceOjbecDic[iter_31_1] then
				setActive = var_1_10009

				var_1_10009(var_8:Find("icon/select"), arg_31_0.selectedIndex == iter_31_1)
			end
		end

		arg_31_0.entrance = arg_31_0.achEntranceList[arg_31_0.selectedIndex]

		arg_31_0:FlushAchievement()
	end

	return
end

function var_0_1.GetAwardIndex(arg_32_0, arg_32_1)
	if #arg_32_0.achEntranceList == 0 then
		return nil
	end

	local var_32_0 = arg_32_0.entrancePos[#arg_32_0.achEntranceList] - 1

	if arg_32_1 then
		local var_32_1 = arg_32_0.scrollEntrance.value + var_32_0

		for iter_32_0 = 1, #arg_32_0.achAwardIndexList do
			if var_32_1 < arg_32_0.entrancePos[arg_32_0.achAwardIndexList[iter_32_0]] then
				return arg_32_0.achAwardIndexList[iter_32_0]
			end
		end

		return nil
	else
		local var_32_2 = arg_32_0.scrollEntrance.value

		for iter_32_1 = #arg_32_0.achAwardIndexList, 1, -1 do
			if var_32_2 > arg_32_0.entrancePos[arg_32_0.achAwardIndexList[iter_32_1]] then
				return arg_32_0.achAwardIndexList[iter_32_1]
			end
		end

		return nil
	end

	return
end

function var_0_1.ScrollAndSelectEntrance(arg_33_0, arg_33_1)
	arg_33_0:UpdateAchievement(arg_33_1, true)

	local var_33_0 = arg_33_0.entrancePos[#arg_33_0.achEntranceList] - 1
	local var_33_1 = arg_33_0.scrollEntrance
	local var_33_2 = var_3.ScrollTo

	math = var_5

	var_33_2(var_33_1, var_5.clamp(arg_33_0.entrancePos[arg_33_1] - var_33_0 / 2, 0, 1))

	return
end

function var_0_1.UpdateJumpBtn(arg_34_0)
	setActive = var_1_10001

	local var_34_0 = arg_34_0.rtMain

	var_1_10001(var_2.Find(var_34_0, "list_bg/jump_icon_left"), arg_34_0:GetAwardIndex(false))

	setActive = var_1_10001

	local var_34_1 = arg_34_0.rtMain

	var_1_10001(var_2.Find(var_34_1, "list_bg/jump_icon_right"), arg_34_0:GetAwardIndex(true))

	return
end

function var_0_1.FlushAchievement(arg_35_0)
	arg_35_0:UpdateJumpBtn()

	nowWorld = var_1

	local var_35_0 = var_1()

	arg_35_0.showHiddenDesc = var_1.IsNormalAchievementAchieved(var_35_0, arg_35_0.entrance)
	arg_35_0.targetList = var_1:GetAchievements(arg_35_0.entrance)

	local var_35_1 = arg_35_0.targetItemList

	var_2.align(var_35_1, #arg_35_0.targetList)

	local var_35_2 = arg_35_0.entrance
	local var_35_3 = var_2.GetBaseMap(var_35_2)

	GetImageSpriteFromAtlasAsync = var_35_2

	var_35_2("world/targeticon/" .. var_35_3.config.entrance_mapicon, "", arg_35_0.entranceTitle)

	setText = var_35_2

	local var_35_4 = arg_35_0.entranceTitle

	var_35_2(var_4.Find(var_35_4, "name"), var_35_3:GetName(arg_35_0.entrance))

	setText = var_35_2

	local var_35_5 = arg_35_0.entranceTitle

	var_35_2(var_4.Find(var_35_5, "deco_id"), arg_35_0.entrance.config.serial_number)

	local var_35_6, var_35_7, var_35_8 = var_1:CountAchievements(arg_35_0.entrance)

	setText = var_6

	local var_35_9 = arg_35_0.entranceTitle

	var_6(var_7.Find(var_35_9, "progress_text"), var_35_6 + var_35_7 .. "/" .. var_35_8)

	local var_35_10, var_35_11 = var_1:AnyUnachievedAchievement(arg_35_0.entrance)
	local var_35_12 = arg_35_0.achAwardRect
	local var_35_13 = var_8.Find(var_35_12, "award")

	if var_35_11 then
		setActive = var_35_12

		local var_35_14 = arg_35_0.achAwardRect

		var_35_12(var_10.Find(var_35_14, "get_mask"), var_35_10)

		setActive = var_35_12

		local var_35_15 = arg_35_0.achAwardRect

		var_35_12(var_10.Find(var_35_15, "got_mask"), false)
	else
		local var_35_16 = arg_35_0.entrance

		var_35_11 = var_35_12[#var_35_12.GetAchievementAwards(var_35_16)]
		setActive = var_10

		local var_35_17 = arg_35_0.achAwardRect

		var_10(var_11.Find(var_35_17, "get_mask"), false)

		setActive = var_10

		local var_35_18 = arg_35_0.achAwardRect

		var_10(var_11.Find(var_35_18, "got_mask"), true)
	end

	updateDrop = var_35_12

	var_35_12(var_35_13, var_35_11.drop)

	onButton = var_35_12

	local var_35_19 = arg_35_0
	local var_35_20 = var_35_13

	local function var_35_21()
		local var_36_0 = arg_35_0

		var_0.showAchAwardPanel(var_36_0, arg_35_0.entrance)

		return
	end

	SFX_PANEL = var_1_10013

	var_35_12(var_35_19, var_35_20, var_35_21, var_1_10013)

	setText = var_35_12

	local var_35_22 = arg_35_0.achAwardRect

	var_35_12(var_10.Find(var_35_22, "star_count/Text"), var_35_6 + var_35_7 .. "/" .. var_35_11.star)

	setActive = var_35_12

	var_35_12(arg_35_0.achAchieveBtn, var_35_10)

	setActive = var_35_12

	local var_35_23 = arg_35_0.entrancePanel

	var_35_12(var_10.Find(var_35_23, "page_left"), arg_35_0.selectedIndex > 1)

	setActive = var_35_12

	local var_35_24 = arg_35_0.entrancePanel

	var_35_12(var_10.Find(var_35_24, "page_right"), arg_35_0.selectedIndex < #arg_35_0.achEntranceList)

	return
end

function var_0_1.flushAchieveUpdate(arg_37_0, arg_37_1)
	arg_37_0:FlushEntranceItem(arg_37_1)
	arg_37_0:FlushAchievement()

	return
end

function var_0_1.showAchAwardPanel(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.subviewAchAward

	var_2.Load(var_38_0)

	local var_38_1 = arg_38_0.subviewAchAward

	var_2.ActionInvoke(var_38_1, "Setup", arg_38_1)

	local var_38_2 = arg_38_0.subviewAchAward

	var_2.ActionInvoke(var_38_2, "Show")

	return
end

return var_0_1
