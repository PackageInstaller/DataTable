class = var_0_10000

local var_0_0 = "DreamlandHandbookPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2

function var_0_1.getUIName(arg_1_0)
	return "DreamlandHandbookUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "bg/close")

	local var_2_1 = {}
	local var_2_2 = var_0_2
	local var_2_3 = arg_2_0._tf

	var_2_1[var_2_2] = var_3.Find(var_2_3, "bg/tags/area")

	local var_2_4 = var_0_3
	local var_2_5 = arg_2_0._tf

	var_2_1[var_2_4] = var_3.Find(var_2_5, "bg/tags/ex")
	arg_2_0.tags = var_2_1
	arg_2_0.tagTip = {}
	pairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.tags) do
		local var_2_6 = arg_2_0.tagTip

		var_2_6[iter_2_0] = iter_2_1:Find("tip")
	end

	local var_2_7 = arg_2_0._tf

	arg_2_0.mapContent = var_1.Find(var_2_7, "bg/area/content")

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "bg/area/content/name")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_2_6
	arg_2_0.mapNameTxt = var_2_10(var_2_9, var_4(var_2_6))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "bg/area/content/scrollrect/desc")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_2_6
	arg_2_0.mapDescTxt = var_2_13(var_2_12, var_4(var_2_6))

	local var_2_14 = arg_2_0._tf

	arg_2_0.mapGoBtn = var_1.Find(var_2_14, "bg/area/content/btn_go")

	local var_2_15 = arg_2_0._tf

	arg_2_0.mapGetBtn = var_1.Find(var_2_15, "bg/area/content/btn_get")

	local var_2_16 = arg_2_0._tf

	arg_2_0.mapGotBtn = var_1.Find(var_2_16, "bg/area/content/btn_got")
	UIItemList = var_1

	local var_2_17 = var_1.New
	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "bg/area/content/awards/list")
	local var_2_20 = arg_2_0._tf

	arg_2_0.mapAwardList = var_2_17(var_2_19, var_4.Find(var_2_20, "bg/area/content/awards/list/award"))
	UIItemList = var_1

	local var_2_21 = var_1.New
	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_3.Find(var_2_22, "bg/area/content/scrollrect/desc/lines")
	local var_2_24 = arg_2_0._tf

	arg_2_0.lineUIList = var_2_21(var_2_23, var_4.Find(var_2_24, "bg/area/content/scrollrect/desc/lines/tpl"))

	local var_2_25 = arg_2_0._tf

	arg_2_0.exGoBtn = var_1.Find(var_2_25, "bg/ex/content/btn_go")

	local var_2_26 = arg_2_0._tf

	arg_2_0.exGetBtn = var_1.Find(var_2_26, "bg/ex/content/btn_get")

	local var_2_27 = arg_2_0._tf

	arg_2_0.exGotBtn = var_1.Find(var_2_27, "bg/ex/content/btn_got")
	UIItemList = var_1

	local var_2_28 = var_1.New
	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_3.Find(var_2_29, "bg/ex/content/awards/list")
	local var_2_31 = arg_2_0._tf

	arg_2_0.exAwardList = var_2_28(var_2_30, var_4.Find(var_2_31, "bg/ex/content/awards/list/award"))
	UIItemList = var_1

	local var_2_32 = var_1.New
	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_3.Find(var_2_33, "bg/ex/content/scrollrect/content")
	local var_2_35 = arg_2_0._tf

	arg_2_0.exContentList = var_2_32(var_2_34, var_4.Find(var_2_35, "bg/ex/content/scrollrect/content/tpl"))

	local var_2_36 = arg_2_0._tf

	arg_2_0.exContent = var_1.Find(var_2_36, "bg/ex/content")
	UIItemList = var_1

	local var_2_37 = var_1.New
	local var_2_38 = arg_2_0._tf
	local var_2_39 = var_3.Find(var_2_38, "bg/area/list")
	local var_2_40 = arg_2_0._tf

	arg_2_0.areaList = var_2_37(var_2_39, var_4.Find(var_2_40, "bg/area/list/1"))
	UIItemList = var_1

	local var_2_41 = var_1.New
	local var_2_42 = arg_2_0._tf
	local var_2_43 = var_3.Find(var_2_42, "bg/ex/list")
	local var_2_44 = arg_2_0._tf

	arg_2_0.exploreList = var_2_41(var_2_43, var_4.Find(var_2_44, "bg/ex/list/tpl"))
	setText = var_1

	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_3.Find(var_2_45, "bg/tags/area/Text")

	i18n = var_4

	var_1(var_2_46, var_4("dreamland_label_area"))

	setText = var_1

	local var_2_47 = arg_2_0._tf
	local var_2_48 = var_3.Find(var_2_47, "bg/tags/ex/Text")

	i18n = var_4

	var_1(var_2_48, var_4("dreamland_label_explore"))

	setText = var_1

	local var_2_49 = arg_2_0._tf
	local var_2_50 = var_3.Find(var_2_49, "bg/ex/content/award_desc")

	i18n = var_4

	var_1(var_2_50, var_4("dreamland_label_explore_award_tip"))

	local var_2_51 = arg_2_0._tf

	arg_2_0.tipTr = var_1.Find(var_2_51, "tip")

	local var_2_52 = arg_2_0.tipTr
	local var_2_53 = var_1.Find(var_2_52, "Text")
	local var_2_54 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.tipTxt = var_2_54(var_2_53, var_4(var_6))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	Color = var_1_10001

	local var_3_6 = var_1_10001.New(0.5843138, 0.5843138, 0.5843138, 1)

	Color = var_1_10002

	local var_3_7 = var_1_10002.New(1, 1, 1, 1)

	local function var_3_8(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:Find("icon")
		local var_6_1 = var_2.GetComponent

		typeof = var_5
		Image = var_2_10007

		local var_6_2 = var_6_1(var_6_0, var_5(var_2_10007))
		local var_6_3 = arg_6_0:Find("Text")
		local var_6_4 = var_3.GetComponent

		typeof = var_6
		Text = var_2_10008

		local var_6_5 = var_6_4(var_6_3, var_6(var_2_10008))
		local var_6_6

		if not arg_6_1 or not var_3_7 then
			var_6_6 = var_3_6
		end

		var_6_2.color = var_6_6

		local var_6_7

		if not arg_6_1 or not var_3_7 then
			var_6_7 = var_3_6
		end

		var_6_5.color = var_6_7

		return
	end

	pairs = var_4

	for iter_3_0, iter_3_1 in var_4(arg_3_0.tags) do
		onToggle = var_1_10009

		local var_3_9 = arg_3_0
		local var_3_10 = iter_3_1

		local function var_3_11(arg_7_0)
			local var_7_0 = arg_3_0

			var_1.SwitchPage(var_7_0, iter_3_0)
			var_3_8(iter_3_1, arg_7_0)

			return
		end

		SFX_PANEL = var_1_10014

		var_1_10009(var_3_9, var_3_10, var_3_11, var_1_10014)
		var_3_8(iter_3_1, false)
	end

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.bind

	DreamlandScene = iter_3_0

	var_3_13(var_3_12, iter_3_0.ON_DATA_UPDATE, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_3_0

		var_2.OnDataUpdate(var_8_0, arg_8_1)

		return
	end)

	return
end

function var_0_1.OnDataUpdate(arg_9_0, arg_9_1)
	arg_9_0.gameData = arg_9_1.data

	if not arg_9_0:isShowing() then
		return
	end

	local var_9_0 = arg_9_1.cmd

	DreamlandData = var_1_10003

	if var_9_0 == var_1_10003.OP_GET_MAP_AWARD then
		arg_9_0:UpdateAreaPage()
	else
		local var_9_1 = arg_9_1.cmd

		DreamlandData = var_3

		if var_9_1 == var_3.OP_GET_EXPLORE_AWARD then
			arg_9_0:UpdateExplorePage()
		end
	end

	arg_9_0:UpdateTip()

	return
end

function var_0_1.Show(arg_10_0, arg_10_1)
	var_0_1.super.Show(arg_10_0)

	arg_10_0.gameData = arg_10_1
	arg_10_0.selectedMapId = 1
	arg_10_0.selectedExploreId = 1

	arg_10_0:UpdateTip()

	triggerToggle = var_2

	var_2(arg_10_0.tags[1], true)

	pg = var_2

	local var_10_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_10_0, arg_10_0._tf)

	return
end

function var_0_1.UpdateTip(arg_11_0)
	setActive = var_1_10001

	local var_11_0 = arg_11_0.tagTip[var_0_2]
	local var_11_1 = arg_11_0.gameData

	var_1_10001(var_11_0, var_4.ExistAnyMapAward(var_11_1))

	setActive = var_1_10001

	local var_11_2 = arg_11_0.tagTip[var_0_3]
	local var_11_3 = arg_11_0.gameData

	var_1_10001(var_11_2, var_4.ExistAnyExploreAward(var_11_3))

	return
end

function var_0_1.Hide(arg_12_0)
	var_0_1.super.Hide(arg_12_0)
	arg_12_0:RemoveHideTimer()

	pg = var_1

	local var_12_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf, arg_12_0._parentTf)

	return
end

function var_0_1.SwitchPage(arg_13_0, arg_13_1)
	if arg_13_1 == var_0_2 then
		arg_13_0:UpdateAreaPage()
	elseif arg_13_1 == var_0_3 then
		arg_13_0:HideTip()
		arg_13_0:UpdateExplorePage()

		local var_13_0 = arg_13_0.gameData

		if var_2.MarkExploreState(var_13_0) then
			arg_13_0:UpdateTip()
		end
	end

	return
end

function var_0_1.InitArea(arg_14_0, arg_14_1, arg_14_2)
	GetSpriteFromAtlas = var_1_10003

	local var_14_0 = var_1_10003("ui/DlHandBookUI_atlas", "area" .. arg_14_1)
	local var_14_1 = arg_14_2
	local var_14_2 = arg_14_2.GetComponent

	typeof = var_7
	Image = var_1_10009

	local var_14_3 = var_14_2(var_14_1, var_7(var_1_10009))

	var_14_3.sprite = var_14_0

	var_14_3:SetNativeSize()

	local var_14_4 = arg_14_2:Find("selected")

	onToggle = var_14_1

	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_2

	local function var_14_7(arg_15_0)
		if arg_15_0 then
			local var_15_0 = arg_14_0

			var_1.UpdateArea(var_15_0, arg_14_1)
		end

		local var_15_2

		if arg_15_0 then
			::label_15_0::

			local var_15_1 = arg_14_0.gameData

			var_15_2 = not var_1.IsUnlockMap(var_15_1, arg_14_1)
		end

		if var_15_2 and not arg_14_0.initFlag then
			local var_15_3 = arg_14_0

			var_2_10002 = var_2_10002.ShowTip
			i18n = var_2_10005

			var_2_10002(var_15_3, var_2_10005("dreamland_area_lock_tip"))
		end

		if var_15_2 then
			setActive = var_2_10002

			var_2_10002(var_14_4, false)
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_14_1(var_14_5, var_14_6, var_14_7, var_1_10011)

	return
end

function var_0_1.GetLineCunt(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.gameObject.transform.sizeDelta.y
	local var_16_1 = arg_16_0.lineUIList.container
	local var_16_2 = var_3.GetComponent

	typeof = var_1_10006
	VerticalLayoutGroup = var_1_10008

	local var_16_3 = var_16_2(var_16_1, var_1_10006(var_1_10008)).spacing

	math = var_16_1

	local var_16_4 = var_16_1.max

	math = var_1_10007

	return var_16_4(var_1_10007.ceil(var_16_0 / var_16_3), 4)
end

function var_0_1.UpdateArea(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.gameData

	if not var_2.IsUnlockMap(var_17_0, arg_17_1) then
		setActive = var_1_10003

		var_1_10003(arg_17_0.mapContent, false)

		return
	end

	setActive = var_1_10003

	var_1_10003(arg_17_0.mapContent, true)

	arg_17_0.selectedMapId = arg_17_1

	local var_17_1 = arg_17_0.gameData
	local var_17_2 = var_3.FindMap(var_17_1, arg_17_1)

	arg_17_0.mapNameTxt.text = var_17_2.name

	local var_17_3 = arg_17_0.mapDescTxt

	HXSet = var_5
	var_17_3.text = var_5.hxLan(var_17_2.desc)
	onNextTick = var_17_3

	var_17_3(function()
		local var_18_0 = arg_17_0
		local var_18_1 = var_0.GetLineCunt(var_18_0, arg_17_0.mapDescTxt)
		local var_18_2 = arg_17_0.lineUIList

		var_1.align(var_18_2, var_18_1)

		return
	end)

	local var_17_4 = arg_17_0.gameData
	local var_17_5 = var_4.IsReceiveMapAward(var_17_4, arg_17_1)

	setActive = var_5

	var_5(arg_17_0.mapGoBtn, not var_2)

	setActive = var_5

	var_5(arg_17_0.mapGetBtn, var_2 and not var_17_5)

	setActive = var_5

	var_5(arg_17_0.mapGotBtn, var_2 and var_17_5)

	local var_17_6 = var_17_2.unlock_drop_display
	local var_17_7 = arg_17_0.mapAwardList

	var_6.make(var_17_7, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = arg_17_0
			local var_19_1 = var_3.UpdateDrop
			local var_19_2 = arg_19_2
			local var_19_3 = var_17_6[arg_19_1 + 1]
			local var_19_4

			if var_0 then
				var_19_4 = var_17_5
			end

			var_19_1(var_19_0, var_19_2, var_19_3, var_19_4)
		end

		return
	end)

	local var_17_8 = arg_17_0.mapAwardList

	var_6.align(var_17_8, #var_17_6)

	onButton = var_6

	local var_17_9 = arg_17_0
	local var_17_10 = arg_17_0.mapGetBtn

	local function var_17_11()
		if var_0 and not var_17_5 then
			local var_20_0 = arg_17_0

			var_0.CheckAwardOverflow(var_20_0, var_17_6, function()
				local var_21_0 = arg_17_0
				local var_21_1 = var_0.emit

				DreamlandMediator = var_3_10003

				local var_21_2 = var_3_10003.GET_MAP_AWARD
				local var_21_3 = arg_17_0.gameData

				var_21_1(var_21_0, var_21_2, var_4.GetActivityId(var_21_3), arg_17_1)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10011

	var_6(var_17_9, var_17_10, var_17_11, var_1_10011)

	return
end

function var_0_1.InitAreaPage(arg_22_0)
	arg_22_0.areaTrs = {}

	local var_22_0 = arg_22_0.gameData
	local var_22_1 = var_1.GetAllMapId(var_22_0)
	local var_22_2 = arg_22_0.areaList

	var_2.make(var_22_2, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			local var_23_0 = arg_22_0

			var_3.InitArea(var_23_0, var_22_1[arg_23_1 + 1], arg_23_2)

			arg_22_0.areaTrs[var_22_1[arg_23_1 + 1]] = arg_23_2
		end

		return
	end)

	local var_22_3 = arg_22_0.areaList

	var_2.align(var_22_3, #var_22_1)

	return
end

function var_0_1.UpdateAreaPage(arg_24_0)
	if not arg_24_0.isInitAreaPage then
		arg_24_0:InitAreaPage()

		arg_24_0.isInitAreaPage = true
	end

	pairs = var_1

	for iter_24_0, iter_24_1 in var_1(arg_24_0.areaTrs) do
		local var_24_0 = arg_24_0.gameData
		local var_24_1 = var_6.IsUnlockMap(var_24_0, iter_24_0)

		setActive = var_1_10007

		local var_24_2 = iter_24_1:Find("tip")
		local var_24_4

		if var_24_1 then
			::label_24_0::

			local var_24_3 = arg_24_0.gameData

			var_24_4 = not var_10.IsReceiveMapAward(var_24_3, iter_24_0)
		end

		var_1_10007(var_24_2, var_24_4)

		setActive = var_1_10007

		var_1_10007(iter_24_1:Find("mask"), not var_24_1)
	end

	arg_24_0.initFlag = true
	triggerToggle = var_1

	var_1(arg_24_0.areaTrs[arg_24_0.selectedMapId], true)

	arg_24_0.initFlag = false

	return
end

function var_0_1.InitExplore(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.gameData
	local var_25_1 = var_3.FindMap(var_25_0, arg_25_2)

	GetSpriteFromAtlas = var_1_10004

	local var_25_2 = var_1_10004("ui/DlHandBookUI_atlas", "ex_print" .. arg_25_2)
	local var_25_3 = arg_25_1:Find("num")
	local var_25_4 = var_5.GetComponent

	typeof = var_8
	Image = var_1_10010

	local var_25_5 = var_25_4(var_25_3, var_8(var_1_10010))

	var_25_5.sprite = var_25_2

	var_25_5:SetNativeSize()

	local var_25_6 = arg_25_1:Find("Text")
	local var_25_7 = var_6.GetComponent

	typeof = var_9
	Text = var_1_10011

	local var_25_8 = var_25_7(var_25_6, var_9(var_1_10011))

	Color = var_25_3

	local var_25_9 = var_25_3.New(0.3058824, 0.3058824, 0.3607843)

	Color = var_25_6

	local var_25_10 = var_25_6.New(0.145098, 0.3215686, 0.9254902)

	onToggle = var_9

	local var_25_11 = arg_25_0
	local var_25_12 = arg_25_1

	local function var_25_13(arg_26_0)
		if arg_26_0 then
			local var_26_0 = arg_25_0

			var_1.UpdateExplore(var_26_0, arg_25_2)
		end

		if arg_26_0 then
			local var_26_1 = arg_25_0.gameData

			if not var_1.IsUnlockMap(var_26_1, arg_25_2) then
				setActive = var_1

				local var_26_2 = arg_25_1

				var_1(var_3.Find(var_26_2, "selected"), false)
			end
		end

		local var_26_3 = var_25_8
		local var_26_4

		if not arg_26_0 or not var_25_10 then
			var_26_4 = var_25_9
		end

		var_26_3.color = var_26_4

		return
	end

	SFX_PANEL = var_1_10014

	var_9(var_25_11, var_25_12, var_25_13, var_1_10014)

	onButton = var_9

	local var_25_14 = arg_25_0
	local var_25_15 = arg_25_1
	local var_25_16 = arg_25_1.Find(var_25_15, "lock")

	local function var_25_17(arg_27_0)
		local var_27_0 = arg_25_0
		local var_27_1 = var_1.ShowTip

		i18n = var_2_10004

		var_27_1(var_27_0, var_2_10004("dreamland_area_lock_tip"))

		return
	end

	SFX_PANEL = var_25_15

	var_9(var_25_14, var_25_16, var_25_17, var_25_15)

	return
end

function var_0_1.UpdateExplore(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.gameData

	if not var_2.IsUnlockMap(var_28_0, arg_28_1) then
		setActive = var_2

		var_2(arg_28_0.exContent, false)

		return
	end

	arg_28_0.selectedExploreId = arg_28_1
	setActive = var_2

	var_2(arg_28_0.exContent, true)

	local var_28_1 = arg_28_0.gameData
	local var_28_2 = var_2.FindMap(var_28_1, arg_28_1)
	local var_28_3 = arg_28_0.gameData
	local var_28_4 = var_3.IsFinishMapExplore(var_28_3, arg_28_1)
	local var_28_5 = arg_28_0.gameData
	local var_28_6 = var_4.IsReceiveExploreAward(var_28_5, arg_28_1)

	setActive = var_28_3

	var_28_3(arg_28_0.exGoBtn, not var_28_4)

	setActive = var_28_3

	var_28_3(arg_28_0.exGetBtn, var_28_4 and not var_28_6)

	setActive = var_28_3

	var_28_3(arg_28_0.exGotBtn, var_28_4 and var_28_6)

	local var_28_7 = var_28_2.explore_drop_display
	local var_28_8 = arg_28_0.exAwardList

	var_6.make(var_28_8, function(arg_29_0, arg_29_1, arg_29_2)
		UIItemList = var_2_10003

		if arg_29_0 == var_2_10003.EventUpdate then
			local var_29_0 = arg_28_0
			local var_29_1 = var_3.UpdateDrop
			local var_29_2 = arg_29_2
			local var_29_3 = var_28_7[arg_29_1 + 1]
			local var_29_4

			if var_28_4 then
				var_29_4 = var_28_6
			end

			var_29_1(var_29_0, var_29_2, var_29_3, var_29_4)
		end

		return
	end)

	local var_28_9 = arg_28_0.exAwardList

	var_6.align(var_28_9, #var_28_7)

	local var_28_10 = arg_28_0.gameData
	local var_28_11 = var_6.GetMainExploreInMap(var_28_10, var_28_2)
	local var_28_12 = arg_28_0.exContentList

	var_7.make(var_28_12, function(arg_30_0, arg_30_1, arg_30_2)
		UIItemList = var_2_10003

		if arg_30_0 == var_2_10003.EventUpdate then
			local var_30_0 = arg_28_0

			var_3.UpdateExploreObj(var_30_0, arg_30_2, arg_30_1 + 1, var_28_11[arg_30_1 + 1])
		end

		return
	end)

	local var_28_13 = arg_28_0.exContentList

	var_7.align(var_28_13, #var_28_11)

	onButton = var_7

	local var_28_14 = arg_28_0
	local var_28_15 = arg_28_0.exGetBtn

	local function var_28_16(arg_31_0)
		if var_28_4 and not var_28_6 then
			local var_31_0 = arg_28_0

			var_1.CheckAwardOverflow(var_31_0, var_28_7, function()
				local var_32_0 = arg_28_0
				local var_32_1 = var_0.emit

				DreamlandMediator = var_3_10003

				local var_32_2 = var_3_10003.GET_EXPLORE_AWARD
				local var_32_3 = arg_28_0.gameData

				var_32_1(var_32_0, var_32_2, var_4.GetActivityId(var_32_3), arg_28_1)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10012

	var_7(var_28_14, var_28_15, var_28_16, var_1_10012)

	return
end

function var_0_1.UpdateExploreObj(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0.gameData
	local var_33_1 = var_4.FindExploreObj(var_33_0, arg_33_3)
	local var_33_2 = arg_33_1:Find("1")
	local var_33_3 = arg_33_1
	local var_33_4 = arg_33_1.Find(var_33_3, "2")
	local var_33_5 = arg_33_2 % 2 == 0 and var_33_4 or var_33_2

	setActive = var_33_3

	var_33_3(var_33_2, var_33_5 == var_33_2)

	setActive = var_33_3

	var_33_3(var_33_4, var_33_5 == var_33_4)

	local var_33_6 = var_33_5:Find("icon")
	local var_33_7 = var_8.GetComponent

	typeof = var_11
	Image = var_1_10013

	local var_33_8 = var_33_7(var_33_6, var_11(var_1_10013))

	LoadSpriteAsync = var_9

	var_9("exploreObj/" .. var_33_1.pic, function(arg_34_0)
		var_33_8.sprite = arg_34_0

		return
	end)

	local var_33_9 = var_33_5:Find("tip")
	local var_33_10 = var_9.GetComponent

	typeof = var_12
	Text = var_1_10014

	local var_33_11 = var_33_10(var_33_9, var_12(var_1_10014))
	local var_33_12 = var_33_5:Find("scrollrect/desc")
	local var_33_13 = var_10.GetComponent

	typeof = var_13
	Text = var_1_10015

	local var_33_14 = var_33_13(var_33_12, var_13(var_1_10015))
	local var_33_15 = arg_33_0.gameData
	local var_33_16 = var_11.IsRecordExplore(var_33_15, arg_33_3)

	setActive = var_33_12

	var_33_12(var_33_5:Find("tipbg"), not var_33_16)

	HXSet = var_33_12

	local var_33_17 = var_33_12.hxLan
	local var_33_18

	if not var_33_16 or not var_33_1.dispaly_desc then
		var_33_18 = ""
	end

	var_33_14.text = var_33_17(var_33_18)
	HXSet = var_12
	var_33_11.text = var_12.hxLan(var_33_16 and "" or var_33_1.tip_desc)
	setActive = var_33_19

	var_33_19(var_33_5:Find("lock"), not var_33_16)

	if var_33_16 then
		Color = var_33_19

		local var_33_19

		if not var_33_19.New(1, 1, 1, 1) then
			Color = var_33_19
			var_33_19 = var_33_19.New(1, 1, 1, 0.25)
		end

		var_33_8.color = var_33_19

		return
	end
end

function var_0_1.InitExplorePage(arg_35_0)
	arg_35_0.exploreTrs = {}

	local var_35_0 = arg_35_0.gameData
	local var_35_1 = var_1.GetAllMapId(var_35_0)
	local var_35_2 = arg_35_0.exploreList

	var_2.make(var_35_2, function(arg_36_0, arg_36_1, arg_36_2)
		UIItemList = var_2_10003

		if arg_36_0 == var_2_10003.EventUpdate then
			local var_36_0 = arg_35_0

			var_3.InitExplore(var_36_0, arg_36_2, var_35_1[arg_36_1 + 1])

			arg_35_0.exploreTrs[var_35_1[arg_36_1 + 1]] = arg_36_2
		end

		return
	end)

	local var_35_3 = arg_35_0.exploreList

	var_2.align(var_35_3, #var_35_1)

	return
end

function var_0_1.UpdateExplorePage(arg_37_0)
	if not arg_37_0.isInitExplorePage then
		arg_37_0:InitExplorePage()

		arg_37_0.isInitExplorePage = true
	end

	pairs = var_1

	for iter_37_0, iter_37_1 in var_1(arg_37_0.exploreTrs) do
		local var_37_0 = arg_37_0.gameData
		local var_37_1 = var_6.IsUnlockMap(var_37_0, iter_37_0)

		setText = var_1_10007

		local var_37_2 = iter_37_1:Find("Text")

		if var_37_1 then
			local var_37_3 = arg_37_0.gameData
			local var_37_4

			if not var_10.FindMap(var_37_3, iter_37_0).name then
				var_37_4 = ""
			end

			var_1_10007(var_37_2, var_37_4)

			setActive = var_1_10007

			var_1_10007(iter_37_1:Find("lock"), not var_37_1)

			setToggleEnabled = var_1_10007

			var_1_10007(iter_37_1, var_37_1)

			local var_37_5 = iter_37_1:Find("Text")

			var_1_10007 = var_1_10007.GetComponent
			typeof = var_10
			Text = var_12
			var_1_10007 = var_1_10007(var_37_5, var_10(var_12))
			Color = var_37_0
			var_1_10007.color = var_37_0.New(0.3058824, 0.3058824, 0.3607843)
			setActive = var_8

			local var_37_6 = iter_37_1:Find("tip")
			local var_37_7 = arg_37_0.gameData
			local var_37_9

			if var_11.IsFinishMapExplore(var_37_7, iter_37_0) then
				local var_37_8 = arg_37_0.gameData

				var_37_9 = not var_11.IsReceiveExploreAward(var_37_8, iter_37_0)
			end

			var_8(var_37_6, var_37_9)
		end
	end

	triggerToggle = var_1

	var_1(arg_37_0.exploreTrs[arg_37_0.selectedExploreId], true)

	return
end

function var_0_1.CheckAwardOverflow(arg_38_0, arg_38_1, arg_38_2)
	Task = var_1_10003

	local var_38_0, var_38_1 = var_1_10003.StaticJudgeOverflow(false, false, false, true, true, arg_38_1)

	if var_38_0 then
		pg = var_5

		local var_38_2 = var_5.MsgboxMgr.GetInstance()
		local var_38_3 = var_5.ShowMsgBox
		local var_38_4 = {}

		MSGBOX_TYPE_ITEM_BOX = var_9
		var_38_4.type = var_9
		i18n = var_9
		var_38_4.content = var_9("award_max_warning")
		var_38_4.items = var_38_1
		var_38_4.onYes = arg_38_2

		var_38_3(var_38_2, var_38_4)
	else
		arg_38_2()
	end

	return
end

function var_0_1.UpdateDrop(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	Drop = var_1_10004

	local var_39_0 = var_1_10004.New({
		type = arg_39_2[1],
		id = arg_39_2[2],
		count = arg_39_2[3]
	})

	updateDrop = var_1_10005

	var_1_10005(arg_39_1:Find("mask_1"), var_39_0)

	onButton = var_1_10005

	local var_39_1 = arg_39_0
	local var_39_2 = arg_39_1

	local function var_39_3()
		local var_40_0 = arg_39_0
		local var_40_1 = var_0.emit

		BaseUI = var_2_10003

		var_40_1(var_40_0, var_2_10003.ON_DROP, var_39_0)

		return
	end

	SFX_PANEL = var_10

	var_1_10005(var_39_1, var_39_2, var_39_3, var_10)

	setActive = var_1_10005

	var_1_10005(arg_39_1:Find("mask"), arg_39_3)

	return
end

function var_0_1.ShowTip(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.tipTxt

	var_41_0.text = arg_41_1
	setActive = var_41_0

	var_41_0(arg_41_0.tipTr, true)
	arg_41_0:AddHideTimer()

	return
end

function var_0_1.HideTip(arg_42_0)
	arg_42_0:RemoveHideTimer()

	setActive = var_1

	var_1(arg_42_0.tipTr, false)

	return
end

function var_0_1.AddHideTimer(arg_43_0)
	arg_43_0:RemoveHideTimer()

	Timer = var_1
	arg_43_0.timer = var_1.New(function()
		local var_44_0 = arg_43_0

		var_0.RemoveHideTimer(var_44_0)

		setActive = var_0

		var_0(arg_43_0.tipTr, false)

		arg_43_0.tipTxt.text = ""

		return
	end, 3, 1)

	local var_43_0 = arg_43_0.timer

	var_1.Start(var_43_0)

	return
end

function var_0_1.RemoveHideTimer(arg_45_0)
	if arg_45_0.timer then
		local var_45_0 = arg_45_0.timer

		var_1.Stop(var_45_0)

		arg_45_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_46_0)
	if arg_46_0:isShowing() then
		arg_46_0:Hide()
	end

	return
end

return var_0_1
