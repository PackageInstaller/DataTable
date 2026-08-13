class = var_0_10000

local var_0_0 = "NewEducateChooseLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.newEducate.base.NewEducateBaseUI"))

var_0_1.TYPE = {
	ENTYR = 2,
	TAROT = 1
}

function var_0_1.getUIName(arg_1_0)
	return "NewEducateChooseUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_3_0)
			getProxy = var_2_10001
			NewEducateProxy = var_2_10002

			local var_3_0 = var_2_10001(var_2_10002)
			local var_3_1 = var_1.GetCurChar(var_3_0)
			local var_3_2 = var_1.GetFSM(var_3_1)
			local var_3_3 = var_2.GetPriorityState(var_3_2)

			if #var_2.GetChoices(var_3_3) > 0 then
				arg_3_0()
			else
				pg = var_3

				local var_3_4 = var_3.m02
				local var_3_5 = var_3.sendNotification

				GAME = var_2_10005

				var_3_5(var_3_4, var_2_10005.NEW_EDUCATE_REQUEST_CHOICES, {
					id = var_1.id,
					callback = arg_3_0
				})
			end

			return
		end
	}, arg_2_1)

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.blockTF = var_1.Find(var_4_0, "block")
	setActive = var_1

	var_1(arg_4_0.blockTF, true)

	local var_4_1 = arg_4_0._tf

	arg_4_0.showPanel = var_1.Find(var_4_1, "show_panel")
	setText = var_1

	local var_4_2 = arg_4_0.showPanel
	local var_4_3 = var_2.Find(var_4_2, "title")

	i18n = var_4_2

	var_1(var_4_3, var_4_2("child2_choose_title"))

	local var_4_4 = arg_4_0.showPanel

	arg_4_0.tipBtn = var_1.Find(var_4_4, "tip")
	setText = var_1

	local var_4_5 = arg_4_0.showPanel
	local var_4_6 = var_2.Find(var_4_5, "refresh/Text")

	i18n = var_4_5

	var_1(var_4_6, var_4_5("child2_refresh_title"))

	local var_4_7 = arg_4_0.showPanel
	local var_4_8 = var_1.Find(var_4_7, "refresh/value")
	local var_4_9 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_4_0.refreshCntText = var_4_9(var_4_8, var_3(var_4))

	local var_4_10 = arg_4_0.showPanel

	arg_4_0.toggleTF = var_1.Find(var_4_10, "toggle")
	setText = var_1

	local var_4_11 = arg_4_0.toggleTF
	local var_4_12 = var_2.Find(var_4_11, "Text")

	i18n = var_4_11

	var_1(var_4_12, var_4_11("child2_show_detail_desc"))

	local var_4_13 = arg_4_0.showPanel

	arg_4_0.tarotTF = var_1.Find(var_4_13, "current/tarot")
	NewEducateTarotCard = var_1
	arg_4_0.tarotCard = var_1.New(arg_4_0.tarotTF)

	local var_4_14 = arg_4_0.showPanel

	arg_4_0.emptyTarotTF = var_1.Find(var_4_14, "current/empty")
	setText = var_1

	local var_4_15 = arg_4_0.emptyTarotTF
	local var_4_16 = var_2.Find(var_4_15, "Text")

	i18n = var_4_15

	var_1(var_4_16, var_4_15("child2_tarot_empty"))

	UIItemList = var_1

	local var_4_17 = var_1.New
	local var_4_18 = arg_4_0.showPanel
	local var_4_19 = var_2.Find(var_4_18, "tarot_list")
	local var_4_20 = arg_4_0.showPanel

	arg_4_0.tarotUIList = var_4_17(var_4_19, var_3.Find(var_4_20, "tarot_list/tpl"))

	local var_4_21 = arg_4_0.tarotUIList

	var_1.make(var_4_21, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		local var_5_0

		if arg_5_0 == var_2_10003.EventInit then
			arg_5_2.name = arg_5_1 + 1
			var_5_0 = arg_4_0.cards

			local var_5_1 = arg_5_1 + 1

			NewEducateTarotCard = var_2_10005
			var_5_0[var_5_1] = var_2_10005.New(arg_5_2)
		else
			UIItemList = var_5_0

			if arg_5_0 == var_5_0.EventUpdate then
				local var_5_2 = arg_4_0

				var_3.UpdateTarotChoice(var_5_2, arg_5_1, arg_5_2)
			end
		end

		return
	end)

	UIItemList = var_1

	local var_4_22 = var_1.New
	local var_4_23 = arg_4_0.showPanel
	local var_4_24 = var_2.Find(var_4_23, "entry_list")
	local var_4_25 = arg_4_0.showPanel

	arg_4_0.entryUIList = var_4_22(var_4_24, var_3.Find(var_4_25, "entry_list/tpl"))

	local var_4_26 = arg_4_0.entryUIList

	var_1.make(var_4_26, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		local var_6_0

		if arg_6_0 == var_2_10003.EventInit then
			arg_6_2.name = arg_6_1 + 1
			var_6_0 = arg_4_0.cards

			local var_6_1 = arg_6_1 + 1

			NewEducateEntryCard = var_2_10005
			var_6_0[var_6_1] = var_2_10005.New(arg_6_2)
		else
			UIItemList = var_6_0

			if arg_6_0 == var_6_0.EventUpdate then
				local var_6_2 = arg_4_0

				var_3.UpdateEntryChoice(var_6_2, arg_6_1, arg_6_2)
			end
		end

		return
	end)

	local var_4_27 = arg_4_0.showPanel

	arg_4_0.giveupBtn = var_1.Find(var_4_27, "btns/giveup")
	setText = var_1

	local var_4_28 = arg_4_0.giveupBtn
	local var_4_29 = var_2.Find(var_4_28, "Text")

	i18n = var_4_28

	var_1(var_4_29, var_4_28("child2_choose_giveup"))

	local var_4_30 = arg_4_0.showPanel

	arg_4_0.hideBtn = var_1.Find(var_4_30, "btns/hide")
	setText = var_1

	local var_4_31 = arg_4_0.hideBtn
	local var_4_32 = var_2.Find(var_4_31, "Text")

	i18n = var_4_31

	var_1(var_4_32, var_4_31("child2_choose_hide"))

	local var_4_33 = arg_4_0._tf

	arg_4_0.hidePanel = var_1.Find(var_4_33, "hide_panel")

	local var_4_34 = arg_4_0.hidePanel

	arg_4_0.showBtn = var_1.Find(var_4_34, "show")
	setActive = var_1

	var_1(arg_4_0.showPanel, true)

	setActive = var_1

	var_1(arg_4_0.hidePanel, false)

	pg = var_1
	arg_4_0.emptyIds = var_1.gameset.child2_pool_exhausted_token.description

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.tipBtn

	local function var_7_2()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		pg = var_2_10003
		var_8_2.helps = var_2_10003.gametip.child2_choose_help.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onToggle = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.toggleTF

	local function var_7_5(arg_9_0)
		NewEducateHelper = var_2_10001

		var_2_10001.SetTarotDeatilDescData(arg_9_0)

		local var_9_0 = arg_7_0

		var_1.SwitchDescMode(var_9_0, arg_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.giveupBtn

	local function var_7_8()
		local var_10_0 = arg_7_0
		local var_10_1 = var_0.emit

		NewEducateChooseMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.ON_GIVE_UP_CHOICE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10005)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.hideBtn

	local function var_7_11()
		local var_11_0 = arg_7_0

		var_0.UnOverlayPanel(var_11_0, arg_7_0._tf)

		setActive = var_0

		var_0(arg_7_0.showPanel, false)

		setActive = var_0

		var_0(arg_7_0.hidePanel, true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10005)

	onButton = var_1_10001

	local var_7_12 = arg_7_0
	local var_7_13 = arg_7_0.showBtn

	local function var_7_14()
		setActive = var_2_10000

		var_2_10000(arg_7_0.showPanel, true)

		setActive = var_2_10000

		var_2_10000(arg_7_0.hidePanel, false)

		local var_12_0 = arg_7_0

		var_0.BlurPanel(var_12_0, arg_7_0._tf, {
			groupDelta = 3
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_12, var_7_13, var_7_14, var_1_10005)

	pg = var_1_10001
	arg_7_0.config = var_1_10001.child2_benefit_list
	pg = var_1
	arg_7_0.tarotRefreshCnt = var_1.gameset.child2_tarot_refresh_limit.key_value
	pg = var_1
	arg_7_0.entryRefreshCnt = var_1.gameset.child2_effect_refresh_limit.key_value
	arg_7_0.cards = {}

	arg_7_0:UpdateView()

	triggerButton = var_1

	var_1(arg_7_0.showBtn)

	triggerToggle = var_1

	local var_7_15 = arg_7_0.toggleTF

	NewEducateHelper = var_7_13

	var_1(var_7_15, var_7_13.IsShowTarotDeatilDesc())

	NewEducateGuideSequence = var_1

	var_1.CheckGuide(arg_7_0.__cname)

	arg_7_0.isMaked = false
	onDelayTick = var_1

	local function var_7_16()
		setActive = var_2_10000

		var_2_10000(arg_7_0.blockTF, false)

		return
	end

	tonumber = var_3
	pg = var_7_14

	var_1(var_7_16, var_3(var_7_14.gameset.child2_select_sleep_time.description))

	return
end

function var_0_1.IsPoolEmpty(arg_14_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_14_0.emptyIds, function(arg_15_0)
		table = var_2_10001

		return var_2_10001.contains(arg_14_0.choices, arg_15_0)
	end)
end

function var_0_1.UpdateView(arg_16_0)
	local var_16_0 = arg_16_0.contextData.char

	arg_16_0.tarotId = var_1.GetTarotId(var_16_0)

	local var_16_1 = arg_16_0.contextData.char
	local var_16_2 = var_1.GetFSM(var_16_1)

	arg_16_0.state = var_1.GetPriorityState(var_16_2)

	local var_16_3 = arg_16_0.state

	arg_16_0.choices = var_1.GetChoices(var_16_3)

	local var_16_4 = arg_16_0.state

	arg_16_0.usedCnts = var_1.GetUsedCnts(var_16_4)

	arg_16_0:UpdateRefreshCnt()

	local var_16_5 = arg_16_0.config[arg_16_0.choices[1]].type

	NewEducateBuff = var_2

	local var_16_6

	if var_16_5 ~= var_2.TYPE.TAROT or not var_0_1.TYPE.TAROT then
		var_16_6 = var_0_1.TYPE.ENTYR
	end

	arg_16_0.type = var_16_6

	arg_16_0:UpdateTarotPanel()
	arg_16_0:UpdateGiveUpBtn()
	arg_16_0:UpdateChoices()

	setActive = var_1

	var_1(arg_16_0.hideBtn, arg_16_0.tarotId)

	return
end

function var_0_1.UpdateRefreshCnt(arg_17_0)
	local var_17_0 = arg_17_0.contextData.char
	local var_17_1 = var_1.GetResByType

	NewEducateChar = var_1_10003
	arg_17_0.refreshCnt = var_17_1(var_17_0, var_1_10003.RES_TYPE.REFRESH_CHOICE)
	arg_17_0.refreshCntText.text = arg_17_0.refreshCnt

	return
end

function var_0_1.UpdateTarotPanel(arg_18_0)
	setActive = var_1_10001

	var_1_10001(arg_18_0.emptyTarotTF, not arg_18_0.tarotId)

	setActive = var_1_10001

	var_1_10001(arg_18_0.tarotTF, arg_18_0.tarotId)

	if arg_18_0.tarotId then
		local var_18_0 = arg_18_0.tarotCard
		local var_18_1 = var_1.Update
		local var_18_2 = arg_18_0.tarotId

		NewEducateTarotCard = var_1_10004

		var_18_1(var_18_0, var_18_2, var_1_10004.TYPE.CURRENT)
	end

	return
end

function var_0_1.UpdateGiveUpBtn(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0.giveupBtn, arg_19_0.tarotId)

	if arg_19_0.tarotId then
		local var_19_0 = arg_19_0.state
		local var_19_1 = var_1.IsFromShop(var_19_0) and "shop_disclaim_refund" or "event_disclaim_refund"
		local var_19_2 = arg_19_0.contextData.char
		local var_19_3 = var_2.getConfig(var_19_2, var_19_1)
		local var_19_4

		if arg_19_0.type ~= var_0_1.TYPE.TAROT or not var_19_3[2] then
			var_19_4 = var_19_3[2]
		end

		setText = var_4

		local var_19_5 = arg_19_0.giveupBtn

		var_4(var_5.Find(var_19_5, "res/Text"), "+" .. var_19_4[3])
	end

	return
end

function var_0_1.UpdateChoices(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0.tarotUIList.container, arg_20_0.type == var_0_1.TYPE.TAROT)

	setActive = var_1_10001

	var_1_10001(arg_20_0.entryUIList.container, arg_20_0.type == var_0_1.TYPE.ENTYR)

	local var_20_0

	if arg_20_0.type ~= var_0_1.TYPE.TAROT or not arg_20_0.tarotUIList then
		var_20_0 = arg_20_0.entryUIList
	end

	var_20_0:align(#arg_20_0.choices)

	return
end

function var_0_1.UpdateTarotChoice(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_1 + 1
	local var_21_1 = arg_21_0.choices[var_21_0]
	local var_21_2 = arg_21_0.cards[var_21_0]

	var_5.Update(var_21_2, var_21_1)

	onButton = var_5

	local var_21_3 = arg_21_0
	local var_21_4 = arg_21_2

	local function var_21_5()
		seriesAsync = var_2_10000

		var_2_10000({
			function(arg_23_0)
				if arg_21_0.tarotId then
					local var_23_0 = arg_21_0
					local var_23_1 = var_1.emit
					local var_23_2 = var_0_1.ON_BOX
					local var_23_3 = {}

					i18n = var_3_10005
					var_23_3.content = var_3_10005("child2_replace_sure_tip")
					var_23_3.onYes = arg_23_0

					var_23_1(var_23_0, var_23_2, var_23_3)
				else
					arg_23_0()
				end

				return
			end
		}, function()
			local var_24_0 = arg_21_0
			local var_24_1 = var_0.emit

			NewEducateChooseMediator = var_3_10002

			var_24_1(var_24_0, var_3_10002.ON_MAKE_CHOICE, var_21_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_21_3, var_21_4, var_21_5, var_1_10009)
	arg_21_0:UpdateRefreshBtn(var_21_0, arg_21_2:Find("refresh_blue"), arg_21_2:Find("refresh_grey"))

	return
end

function var_0_1.UpdateEntryChoice(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1 + 1
	local var_25_1 = arg_25_0.choices[var_25_0]
	local var_25_2 = arg_25_0.cards[var_25_0]

	var_5.Update(var_25_2, var_25_1)

	onButton = var_5

	local var_25_3 = arg_25_0
	local var_25_4 = arg_25_2

	local function var_25_5()
		if arg_25_0.isMaked then
			return
		end

		local var_26_0 = arg_25_0
		local var_26_1 = var_0.emit

		NewEducateChooseMediator = var_2_10002

		var_26_1(var_26_0, var_2_10002.ON_MAKE_CHOICE, var_25_0)

		arg_25_0.isMaked = true

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_25_3, var_25_4, var_25_5, var_1_10009)
	arg_25_0:UpdateRefreshBtn(var_25_0, arg_25_2:Find("refresh_blue"), arg_25_2:Find("refresh_grey"))

	return
end

function var_0_1.UpdateRefreshBtn(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0.usedCnts[arg_27_1]
	local var_27_1

	if arg_27_0.type ~= var_0_1.TYPE.TAROT or not arg_27_0.tarotRefreshCnt then
		var_27_1 = arg_27_0.entryRefreshCnt
	end

	local var_27_2 = var_27_1 - var_27_0
	local var_27_3 = arg_27_0.refreshCnt > 0 and var_27_2 > 0
	local var_27_4 = arg_27_0
	local var_27_5 = arg_27_0.IsPoolEmpty(var_27_4)

	setText = var_27_4

	local var_27_6 = arg_27_2
	local var_27_7 = arg_27_2.Find(var_27_6, "Text")

	math = var_27_6

	var_27_4(var_27_7, var_27_6.min(var_27_2, arg_27_0.refreshCnt))

	setText = var_27_4

	local var_27_8 = arg_27_3
	local var_27_9 = arg_27_3.Find(var_27_8, "Text")

	math = var_27_8

	var_27_4(var_27_9, var_27_8.min(var_27_2, arg_27_0.refreshCnt))

	setActive = var_27_4

	var_27_4(arg_27_2, var_27_3 and not var_27_5)

	setActive = var_27_4

	var_27_4(arg_27_3, not var_27_3 or var_27_5)

	onButton = var_27_4

	local var_27_10 = arg_27_0
	local var_27_11 = arg_27_2

	local function var_27_12()
		if not var_27_3 then
			return
		end

		local var_28_0 = arg_27_0
		local var_28_1 = var_0.emit

		NewEducateChooseMediator = var_2_10002

		var_28_1(var_28_0, var_2_10002.ON_REFRESH_CHOICE, arg_27_1)

		return
	end

	SFX_PANEL = var_13

	var_27_4(var_27_10, var_27_11, var_27_12, var_13)

	onButton = var_27_4

	local var_27_13 = arg_27_0
	local var_27_14 = arg_27_3

	local function var_27_15()
		if not var_27_5 then
			return
		end

		pg = var_0

		local var_29_0 = var_0.TipsMgr.GetInstance()
		local var_29_1 = var_0.ShowTips

		i18n = var_2_10002

		var_29_1(var_29_0, var_2_10002("child2_pool_exhausted"))

		return
	end

	SFX_PANEL = var_13

	var_27_4(var_27_13, var_27_14, var_27_15, var_13)

	return
end

function var_0_1.GetUIList(arg_30_0)
	local var_30_0

	if arg_30_0.type ~= var_0_1.TYPE.TAROT or not arg_30_0.tarotUIList then
		var_30_0 = arg_30_0.entryUIList
	end

	return var_30_0
end

function var_0_1.SwitchDescMode(arg_31_0, arg_31_1)
	if arg_31_0.tarotId then
		local var_31_0 = arg_31_0.tarotCard

		var_2.UpdateDescMode(var_31_0, arg_31_1)
	end

	local var_31_1 = arg_31_0:GetUIList()

	var_2.eachActive(var_31_1, function(arg_32_0, arg_32_1)
		local var_32_0 = arg_31_0.cards[arg_32_0 + 1]

		var_2.UpdateDescMode(var_32_0, arg_31_1)

		return
	end)

	return
end

function var_0_1.UpdateDataAfterRefresh(arg_33_0)
	local var_33_0 = arg_33_0.contextData.char
	local var_33_1 = var_1.GetFSM(var_33_0)

	arg_33_0.state = var_1.GetPriorityState(var_33_1)

	local var_33_2 = arg_33_0.state

	arg_33_0.choices = var_1.GetChoices(var_33_2)

	local var_33_3 = arg_33_0.state

	arg_33_0.usedCnts = var_1.GetUsedCnts(var_33_3)

	arg_33_0:UpdateRefreshCnt()

	local var_33_4 = arg_33_0:GetUIList()

	var_1.eachActive(var_33_4, function(arg_34_0, arg_34_1)
		local var_34_0 = arg_33_0

		var_2.UpdateRefreshBtn(var_34_0, arg_34_0 + 1, arg_34_1:Find("refresh_blue"), arg_34_1:Find("refresh_grey"))

		return
	end)

	return
end

function var_0_1.OnRefreshDone(arg_35_0, arg_35_1)
	arg_35_0:UpdateDataAfterRefresh()

	eachChild = var_2

	var_2(arg_35_0:GetUIList().container, function(arg_36_0)
		tonumber = var_2_10001

		if var_2_10001(arg_36_0.name) == arg_35_1.idx then
			local var_36_0 = arg_36_0
			local var_36_1 = arg_36_0.GetComponent

			typeof = var_2_10003
			DftAniEvent = var_2_10004

			local var_36_2 = var_36_1(var_36_0, var_2_10003(var_2_10004))

			var_1.SetTriggerEvent(var_36_2, function()
				local var_37_0 = var_0

				var_0.SetTriggerEvent(var_37_0, nil)

				local var_37_1 = arg_35_0.cards[arg_35_1.idx]

				var_0.Update(var_37_1, arg_35_1.newId)

				local var_37_2 = arg_35_0.cards[arg_35_1.idx]
				local var_37_3 = var_0.UpdateDescMode
				local var_37_4 = arg_35_0.toggleTF
				local var_37_5 = var_2.GetComponent

				typeof = var_3_10004
				Toggle = var_3_10005

				var_37_3(var_37_2, var_37_5(var_37_4, var_3_10004(var_3_10005)).isOn)

				return
			end)

			local var_36_3 = arg_35_0.type == var_0_1.TYPE.TAROT and "Anim_Neweducate_talent_tpl_change" or "Anim_Neweducate_tentry_tpl_change1"
			local var_36_4 = arg_36_0
			local var_36_5 = arg_36_0.GetComponent

			typeof = var_2_10005
			Animation = var_2_10006

			local var_36_6 = var_36_5(var_36_4, var_2_10005(var_2_10006))

			var_3.Play(var_36_6, var_36_3)
		end

		return
	end)

	return
end

function var_0_1.OnMakeChoiceDone(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.type == var_0_1.TYPE.TAROT and "Anim_Neweducate_talent_tpl_out" or "Anim_Neweducate_entry_tpl_out1"

	eachChild = var_3

	var_3(arg_38_0:GetUIList().container, function(arg_39_0)
		tonumber = var_2_10001

		if var_2_10001(arg_39_0.name) ~= arg_38_1.idx then
			local var_39_0 = arg_39_0
			local var_39_1 = arg_39_0.GetComponent

			typeof = var_2_10003
			Animation = var_2_10004

			local var_39_2 = var_39_1(var_39_0, var_2_10003(var_2_10004))

			var_1.Play(var_39_2, var_38_0)
		end

		return
	end)

	seriesAsync = var_3

	var_3({
		function(arg_40_0)
			onDelayTick = var_2_10001

			var_2_10001(arg_40_0, 0.15)

			return
		end,
		function(arg_41_0)
			if #arg_38_1.drops > 0 then
				local var_41_0 = arg_38_0

				var_1.emit(var_41_0, var_0_1.ON_DROP, {
					items = arg_38_1.drops,
					removeFunc = function()
						arg_41_0()

						return
					end
				})
			else
				arg_41_0()
			end

			return
		end
	}, function()
		local var_43_0 = arg_38_0

		var_0.closeView(var_43_0)

		return
	end)

	return
end

function var_0_1.OnGiveUpDone(arg_44_0, arg_44_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_45_0)
			if #arg_44_1.drops > 0 then
				local var_45_0 = arg_44_0

				var_1.emit(var_45_0, var_0_1.ON_DROP, {
					items = arg_44_1.drops,
					removeFunc = function()
						arg_45_0()

						return
					end
				})
			else
				arg_45_0()
			end

			return
		end
	}, function()
		local var_47_0 = arg_44_0

		var_0.closeView(var_47_0)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_48_0)
	return
end

function var_0_1.willExit(arg_49_0)
	ipairs = var_1_10001

	for iter_49_0, iter_49_1 in var_1_10001(arg_49_0.cards) do
		iter_49_1:Dispose()
	end

	arg_49_0.cards = {}

	local var_49_0 = arg_49_0.tarotCard

	var_1.Dispose(var_49_0)
	arg_49_0:UnOverlayPanel(arg_49_0._tf)

	existCall = var_1

	var_1(arg_49_0.contextData.onExit)

	return
end

return var_0_1
