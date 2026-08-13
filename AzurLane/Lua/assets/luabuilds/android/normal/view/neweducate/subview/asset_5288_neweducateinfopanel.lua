class = var_0_10000

local var_0_0 = "NewEducateInfoPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateInfoPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.foldPanelTF = var_1.Find(var_2_0, "fold_panel")

	local var_2_1 = arg_2_0.foldPanelTF

	arg_2_0.showBtn = var_1.Find(var_2_1, "show_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.showPanelTF = var_1.Find(var_2_2, "show_panel")

	local var_2_3 = arg_2_0.showPanelTF
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.showAnim = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0.showPanelTF
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.showAnimEvent = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0.showAnimEvent

	var_1.SetEndEvent(var_2_7, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.showPanelTF, false)

		return
	end)

	local var_2_8 = arg_2_0.showPanelTF

	arg_2_0.blurBg = var_1.Find(var_2_8, "content")

	local var_2_9 = arg_2_0.showPanelTF

	arg_2_0.foldBtn = var_1.Find(var_2_9, "fold_btn")

	local var_2_10 = arg_2_0.showPanelTF

	arg_2_0.contnetTF = var_1.Find(var_2_10, "content")
	setText = var_1

	local var_2_11 = arg_2_0.contnetTF
	local var_2_12 = var_2.Find(var_2_11, "personality/personality_title/Text")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("child2_personality_title"))

	local var_2_13 = arg_2_0.contnetTF

	arg_2_0.personalityTF = var_1.Find(var_2_13, "personality/personality")

	local var_2_14 = arg_2_0.personalityTF

	arg_2_0.personalityValueTF = var_1.Find(var_2_14, "slider/handle/Image/bubble/Text")
	setText = var_1

	local var_2_15 = arg_2_0.contnetTF
	local var_2_16 = var_2.Find(var_2_15, "attrs/attr_title/Text")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("child2_attr_title"))

	local var_2_17 = arg_2_0.contnetTF
	local var_2_18 = var_1.Find(var_2_17, "attrs/attrs/content")
	local var_2_19 = arg_2_0.contnetTF

	arg_2_0.gradientBgTF = var_2.Find(var_2_19, "attrs/attrs/bg_gradient")
	UIItemList = var_2
	arg_2_0.attrUIList = var_2.New(var_2_18, var_2_18:Find("tpl"))
	setText = var_2

	local var_2_20 = arg_2_0.contnetTF
	local var_2_21 = var_3.Find(var_2_20, "talent/talent_title/Text")

	i18n = var_2_20

	var_2(var_2_21, var_2_20("child2_talent_title"))

	local var_2_22 = arg_2_0.contnetTF
	local var_2_23 = var_2.Find(var_2_22, "talent/talents/content")

	UIItemList = var_2_22
	arg_2_0.talentUIList = var_2_22.New(var_2_23, var_2_23:Find("tpl"))

	local var_2_24 = arg_2_0.contnetTF

	arg_2_0.statusTF = var_3.Find(var_2_24, "status")
	setText = var_3

	local var_2_25 = arg_2_0.statusTF
	local var_2_26 = var_4.Find(var_2_25, "status_title/Text")

	i18n = var_2_25

	var_3(var_2_26, var_2_25("child2_status_title"))

	local var_2_27 = arg_2_0.statusTF
	local var_2_28 = var_3.Find(var_2_27, "status/content/content")

	UIItemList = var_2_27
	arg_2_0.statusUIList = var_2_27.New(var_2_28, var_2_28:Find("tpl"))

	local var_2_29 = arg_2_0.contnetTF

	arg_2_0.tarotTF = var_4.Find(var_2_29, "tarot")
	setText = var_4

	local var_2_30 = arg_2_0.tarotTF
	local var_2_31 = var_5.Find(var_2_30, "title/Text")

	i18n = var_2_30

	var_4(var_2_31, var_2_30("child2_tarot_title"))

	local var_2_32 = arg_2_0.tarotTF

	arg_2_0.tarotIconTF = var_4.Find(var_2_32, "bg/icon")

	local var_2_33 = arg_2_0.tarotTF

	arg_2_0.tarotNameTF = var_4.Find(var_2_33, "bg/name")

	local var_2_34 = arg_2_0.tarotTF

	arg_2_0.tarotEntryTF = var_4.Find(var_2_34, "bg/entry")

	local var_2_35 = arg_2_0.contextData.char

	arg_2_0.attrIds = var_4.GetAttrIds(var_2_35)

	local var_2_36 = arg_2_0.contextData.char
	local var_2_37 = var_4.GetRoundData(var_2_36)

	arg_2_0.talentRoundIds = var_4.GetTalentRoundIds(var_2_37)

	return
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = "neweducateicon/"
	local var_4_1 = arg_4_0.contextData.char
	local var_4_2

	var_4_2, LoadImageSpriteAsync = var_4_0 .. var_2.getConfig(var_4_1, "child2_data_personality_icon")[1], var_2

	local var_4_3 = arg_4_0.personalityTF

	var_2(var_4_2, var_4.Find(var_4_3, "slider/handle/Image"), true)

	local var_4_4 = "neweducateicon/"
	local var_4_5 = arg_4_0.contextData.char
	local var_4_6 = var_4_4 .. var_3.getConfig(var_4_5, "personality_bar_icon")

	LoadImageSpriteAsync = var_3

	var_3(var_4_6, arg_4_0.personalityTF, true)

	onButton = var_3

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.showBtn

	local function var_4_9()
		local var_5_0 = arg_4_0

		var_0.ShowPanel(var_5_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_4_7, var_4_8, var_4_9, var_1_10007)

	onButton = var_3

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.foldBtn

	local function var_4_12()
		local var_6_0 = arg_4_0

		var_0.HidePanel(var_6_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_4_10, var_4_11, var_4_12, var_1_10007)

	onButton = var_3

	local var_4_13 = arg_4_0
	local var_4_14 = arg_4_0.tarotTF
	local var_4_15 = var_5.Find(var_4_14, "bg")

	local function var_4_16()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		NewEducateBaseUI = var_2_10002

		local var_7_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_7_3 = var_2_10003.New
		local var_7_4 = {}

		NewEducateTarotEntryMediator = var_2_10005
		var_7_4.mediator = var_2_10005
		NewEducateTarotEntryLayer = var_2_10005
		var_7_4.viewComponent = var_2_10005
		var_7_4.data = {
			inShop = arg_4_0.inShop
		}

		var_7_1(var_7_0, var_7_2, var_7_3(var_7_4))

		return
	end

	SFX_PANEL = var_7

	var_3(var_4_13, var_4_15, var_4_16, var_7)

	local var_4_17 = arg_4_0.attrUIList

	var_3.make(var_4_17, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		local var_8_0

		if arg_8_0 == var_2_10003.EventInit then
			var_8_0 = arg_4_0.attrIds[arg_8_1 + 1]
			pg = var_4

			local var_8_1 = var_4.child2_attr[var_8_0]

			LoadImageSpriteAsync = var_2_10005

			var_2_10005("neweducateicon/" .. var_8_1.icon, arg_8_2:Find("icon_bg/icon"))

			setScrollText = var_2_10005

			var_2_10005(arg_8_2:Find("name_mask/name"), var_8_1.name)
		else
			UIItemList = var_8_0

			if arg_8_0 == var_8_0.EventUpdate then
				local var_8_2 = arg_4_0

				var_3.OnUpdateAttrItem(var_8_2, arg_8_1, arg_8_2)
			end
		end

		return
	end)

	local var_4_18 = arg_4_0.talentUIList

	var_3.make(var_4_18, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_4_0

			var_3.OnUpdateTalentItem(var_9_0, arg_9_1, arg_9_2)
		end

		return
	end)

	local var_4_19 = arg_4_0.statusUIList

	var_3.make(var_4_19, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_4_0

			var_3.OnUpdateStatusItem(var_10_0, arg_10_1, arg_10_2)
		end

		return
	end)
	arg_4_0:OverlayPanel(arg_4_0._tf, {
		groupDelta = -1,
		pbList = {
			arg_4_0.blurBg
		}
	})

	setActive = var_3

	var_3(arg_4_0.foldPanelTF, true)

	setActive = var_3

	var_3(arg_4_0.showPanelTF, false)

	if arg_4_0.contextData.hide then
		arg_4_0:HidePanel()
	elseif arg_4_0.contextData.isMainEnter then
		onDelayTick = var_3

		var_3(function()
			local var_11_0 = arg_4_0

			var_0.ShowPanel(var_11_0)

			return
		end, 0.396)
	else
		arg_4_0:ShowPanel()
	end

	local var_4_20 = arg_4_0.contextData.char
	local var_4_21 = var_3.GetPermanentData(var_4_20)

	arg_4_0.isTarotChar = var_3.IsTarotType(var_4_21)
	setActive = var_3

	var_3(arg_4_0.tarotTF, arg_4_0.isTarotChar)

	setActive = var_3

	var_3(arg_4_0.statusTF, not arg_4_0.isTarotChar)
	arg_4_0:Flush()

	return
end

function var_0_1.IsShowPanel(arg_12_0)
	isActive = var_1_10001

	return var_1_10001(arg_12_0.showPanelTF)
end

function var_0_1.ShowPanel(arg_13_0)
	setActive = var_1_10001

	var_1_10001(arg_13_0.foldPanelTF, false)

	setActive = var_1_10001

	var_1_10001(arg_13_0.showPanelTF, true)

	return
end

function var_0_1.HidePanel(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.foldPanelTF, true)

	if not arg_14_1 then
		local var_14_0 = arg_14_0.showAnim

		var_1_10002.Play(var_14_0, "anim_educate_archive_show_out")
	else
		setActive = var_1_10002

		var_1_10002(arg_14_0.showPanelTF, false)
	end

	eachChild = var_1_10002

	var_1_10002(arg_14_0.talentUIList.container, function(arg_15_0)
		triggerToggle = var_2_10001

		var_2_10001(arg_15_0:Find("unlock"), false)

		return
	end)

	eachChild = var_1_10002

	var_1_10002(arg_14_0.statusUIList.container, function(arg_16_0)
		triggerToggle = var_2_10001

		var_2_10001(arg_16_0, false)

		return
	end)

	return
end

function var_0_1.OnUpdateAttrItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.attrIds[arg_17_1 + 1]

	pg = var_4

	local var_17_1 = var_4.child2_attr[var_17_0]
	local var_17_2 = arg_17_0.contextData.char
	local var_17_3 = var_5.GetAttr(var_17_2, var_17_0)
	local var_17_4, var_17_5 = var_0_1.GetArrtInfo(var_17_1.rank, var_17_3)

	setText = var_8

	var_8(arg_17_2:Find("rank/Text"), var_17_4)

	setText = var_8

	var_8(arg_17_2:Find("value"), var_17_5)

	EducateConst = var_8

	local var_17_6 = var_8.GRADE_2_COLOR[var_17_4][1]

	EducateConst = var_9

	local var_17_7 = var_9.GRADE_2_COLOR[var_17_4][2]
	local var_17_8 = arg_17_0.gradientBgTF
	local var_17_9

	var_17_9, setImageColor = var_10.GetChild(var_17_8, arg_17_1), var_17_8
	Color = var_1_10013

	var_17_8(var_17_9, var_1_10013.NewHex(var_17_6))

	setImageColor = var_17_8

	local var_17_10 = arg_17_2
	local var_17_11 = arg_17_2.Find(var_17_10, "rank")

	Color = var_17_10

	var_17_8(var_17_11, var_17_10.NewHex(var_17_7))

	setToggleEnabled = var_17_8

	var_17_8(arg_17_2, arg_17_0.isTarotChar)

	if arg_17_0.isTarotChar then
		setText = var_11

		var_11(arg_17_2:Find("info/content/name"), var_17_1.name)

		setText = var_11

		var_11(arg_17_2:Find("info/content/value"), var_17_5)

		local var_17_12 = arg_17_0.contextData.char
		local var_17_13 = var_11.GetBenefitData(var_17_12)
		local var_17_14 = var_11.GetDisplayPctByDrop
		local var_17_15 = {}

		NewEducateConst = var_1_10015
		var_17_15.type = var_1_10015.DROP_TYPE.ATTR
		var_17_15.id = var_17_0

		local var_17_16, var_17_17 = var_17_14(var_17_13, var_17_15)

		i18n = var_17_15

		local var_17_18 = var_17_15("child2_benefit_summary")
		local var_17_19 = var_17_16
		local var_17_20 = "%"
		local var_17_21 = "\n"

		i18n = var_1_10018

		local var_17_22 = var_17_18 .. var_17_19 .. var_17_20 .. var_17_21 .. var_1_10018("child2_benefit_summary2") .. var_17_17 .. "%"

		setText = var_17_19

		var_17_19(arg_17_2:Find("info/content/desc"), var_17_22)
	end

	return
end

function var_0_1.OnUpdateTalentItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.talents[arg_18_1 + 1]

	setActive = var_4

	var_4(arg_18_2:Find("unlock"), var_18_0)

	setActive = var_4

	var_4(arg_18_2:Find("lock"), not var_18_0)

	if var_18_0 then
		LoadImageSpriteAsync = var_4

		var_4("neweducateicon/" .. var_18_0:getConfig("item_icon_little"), arg_18_2:Find("unlock/icon"))

		setText = var_4

		local var_18_1 = arg_18_2
		local var_18_2 = arg_18_2.Find(var_18_1, "unlock/name")

		shortenString = var_18_1

		var_4(var_18_2, var_18_1(var_18_0:getConfig("name"), 5))

		setText = var_4

		var_4(arg_18_2:Find("unlock/info/content/name"), var_18_0:getConfig("name"))

		setText = var_4

		var_4(arg_18_2:Find("unlock/info/content/desc"), var_18_0:getConfig("desc"))
	end

	local var_18_3 = arg_18_0.talentRoundIds[arg_18_1 + 1]

	onButton = var_5

	local var_18_4 = arg_18_0
	local var_18_5 = arg_18_2:Find("lock")

	local function var_18_6()
		pg = var_2_10000

		local var_19_0 = var_2_10000.TipsMgr.GetInstance()
		local var_19_1 = var_0.ShowTips

		i18n = var_2_10002

		var_19_1(var_19_0, var_2_10002("child2_talent_unlock_tip", var_18_3))

		return
	end

	SFX_PANEL = var_9

	var_5(var_18_4, var_18_5, var_18_6, var_9)

	onScroll = var_5

	local var_18_7 = arg_18_0
	local var_18_8 = arg_18_0.statusTF

	var_5(var_18_7, var_7.Find(var_18_8, "status"), function(arg_20_0)
		eachChild = var_2_10001

		var_2_10001(arg_18_0.statusUIList.container, function(arg_21_0)
			triggerToggle = var_3_10001

			var_3_10001(arg_21_0, false)

			return
		end)

		return
	end)

	return
end

function var_0_1.OnUpdateStatusItem(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.status[arg_22_1 + 1]
	local var_22_1 = arg_22_2.name

	tostring = var_1_10005

	if var_22_1 ~= var_1_10005(var_22_0.id) then
		arg_22_2.name = var_22_0.id
		LoadImageSpriteAsync = var_4

		var_4("neweducateicon/" .. var_22_0:getConfig("item_icon"), arg_22_2:Find("icon"))
	end

	local var_22_2 = var_22_0:getConfig("during_time")
	local var_22_3 = var_22_0:GetEndRound()
	local var_22_4 = arg_22_0.contextData.char
	local var_22_5 = var_22_3 - var_6.GetRoundData(var_22_4).round

	if var_22_2 == -1 then
		i18n = var_22_6

		local var_22_6

		if not var_22_6("child2_status_time2") then
			i18n = var_22_6
			var_22_6 = var_22_6("child2_status_time1", var_22_5)
		end

		setText = var_22_4

		var_22_4(arg_22_2:Find("time/Text"), var_22_6)

		setText = var_22_4

		var_22_4(arg_22_2:Find("info/content/name"), var_22_0:getConfig("name"))

		setText = var_22_4

		var_22_4(arg_22_2:Find("info/content/desc"), var_22_0:getConfig("desc"))

		return
	end
end

function var_0_1.Flush(arg_23_0)
	arg_23_0:FlushAttrs()
	arg_23_0:FlushTalents()
	arg_23_0:FlushStatus()
	arg_23_0:FlushTarot()

	return
end

function var_0_1.FlushAttrs(arg_24_0)
	local var_24_0 = arg_24_0.contextData.char
	local var_24_1 = var_1.GetPersonalityMiddle(var_24_0)
	local var_24_2 = arg_24_0.contextData.char
	local var_24_3 = var_2.GetPersonalityTag(var_24_2)
	local var_24_4 = arg_24_0.contextData.char
	local var_24_5 = var_3.GetPersonality(var_24_4)

	setSlider = var_24_4

	local var_24_6 = arg_24_0.personalityTF

	var_24_4(var_5.Find(var_24_6, "slider"), -var_24_1, var_24_1, var_24_5 - var_24_1)

	setText = var_24_4

	local var_24_7 = arg_24_0.personalityValueTF

	math = var_6

	var_24_4(var_24_7, var_6.abs(var_24_5 - var_24_1))

	local var_24_8 = var_24_3 == "tag1" and "26b1f3" or "ff6767"

	setTextColor = var_24_7

	local var_24_9 = arg_24_0.personalityValueTF

	Color = var_7

	var_24_7(var_24_9, var_7.NewHex(var_24_8))

	local var_24_10 = arg_24_0.attrUIList

	var_5.align(var_24_10, #arg_24_0.attrIds)

	return
end

function var_0_1.FlushTalents(arg_25_0)
	local var_25_0 = arg_25_0.contextData.char

	arg_25_0.talents = var_1.GetTalentList(var_25_0)

	local var_25_1 = arg_25_0.talentUIList

	var_1.align(var_25_1, #arg_25_0.talentRoundIds)

	return
end

function var_0_1.FlushStatus(arg_26_0)
	local var_26_0 = arg_26_0.contextData.char

	arg_26_0.status = var_1.GetStatusList(var_26_0)

	local var_26_1 = arg_26_0.statusUIList

	var_1.align(var_26_1, #arg_26_0.status)

	return
end

function var_0_1.FlushTarot(arg_27_0)
	local var_27_0 = arg_27_0.contextData.char

	arg_27_0.tarotId = var_1.GetTarotId(var_27_0)
	setActive = var_1

	var_1(arg_27_0.tarotIconTF, arg_27_0.tarotId)

	if arg_27_0.tarotId then
		LoadImageSpriteAsync = var_1

		local var_27_1 = "neweducateicon/"

		pg = var_3

		var_1(var_27_1 .. var_3.child2_benefit_list[arg_27_0.tarotId].item_icon_little, arg_27_0.tarotIconTF)
	end

	setText = var_1

	local var_27_2 = arg_27_0.tarotNameTF

	if arg_27_0.tarotId then
		pg = var_3

		local var_27_3

		if not var_3.child2_benefit_list[arg_27_0.tarotId].name then
			var_27_3 = "EMPTY"
		end

		var_1(var_27_2, var_27_3)

		local var_27_4 = arg_27_0.contextData.char
		local var_27_5 = var_1.GetBenefitData(var_27_4)
		local var_27_6 = var_1.GetListByType

		NewEducateBuff = var_27_3
		arg_27_0.entries = var_27_6(var_27_5, var_27_3.TYPE.ENTRY)
		setText = var_1

		local var_27_7 = arg_27_0.tarotEntryTF

		i18n = var_3

		var_1(var_27_7, var_3("child2_entry_summary") .. #arg_27_0.entries)

		return
	end
end

function var_0_1.SetShopOpen(arg_28_0, arg_28_1)
	arg_28_0.inShop = arg_28_1

	return
end

function var_0_1.OnDestroy(arg_29_0)
	arg_29_0:UnOverlayPanel(arg_29_0._tf)

	return
end

function var_0_1.GetArrtInfo(arg_30_0, arg_30_1)
	ipairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(arg_30_0) do
		if arg_30_1 >= iter_30_1[1][1] and arg_30_1 < iter_30_1[1][2] then
			return iter_30_1[2], arg_30_1 .. "/" .. iter_30_1[1][2]
		end
	end

	return arg_30_0[#arg_30_0][2], arg_30_1 .. "/" .. arg_30_0[#arg_30_0][1][2]
end

return var_0_1
