class = var_0_10000

local var_0_0 = "CommanderHomeLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.DESC_PAGE_OPEN = "CommanderHomeLayer:DESC_PAGE_OPEN"
var_0_1.DESC_PAGE_CLOSE = "CommanderHomeLayer:DESC_PAGE_CLOSE"

function var_0_1.getUIName(arg_1_0)
	return "CommanderHomeUI"
end

function var_0_1.SetHome(arg_2_0, arg_2_1)
	arg_2_0.home = arg_2_1

	return
end

function var_0_1.OnCatteryUpdate(arg_3_0, arg_3_1)
	local var_3_0

	pairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.cards) do
		if iter_3_1.cattery.id == arg_3_1 then
			var_3_0 = iter_3_1.cattery

			iter_3_1:Update(var_3_0)
		end
	end

	if var_3_0 then
		local var_3_1 = arg_3_0.catteryDescPage

		if var_3.GetLoaded(var_3_1) then
			local var_3_2 = arg_3_0.catteryDescPage

			if var_3.isShowing(var_3_2) then
				local var_3_3 = arg_3_0.catteryDescPage

				var_3.OnCatteryUpdate(var_3_3, var_3_0)
			end
		end
	end

	arg_3_0:UpdateMain()

	return
end

function var_0_1.OnCatteryStyleUpdate(arg_4_0, arg_4_1)
	local var_4_0

	pairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_0.cards) do
		if iter_4_1.cattery.id == arg_4_1 then
			var_4_0 = iter_4_1.cattery

			iter_4_1:UpdateStyle(var_4_0)
		end
	end

	if var_4_0 then
		local var_4_1 = arg_4_0.catteryDescPage

		if var_3.GetLoaded(var_4_1) then
			local var_4_2 = arg_4_0.catteryDescPage

			if var_3.isShowing(var_4_2) then
				local var_4_3 = arg_4_0.catteryDescPage

				var_3.OnCatteryStyleUpdate(var_4_3, var_4_0)
			end
		end
	end

	return
end

function var_0_1.OnCommanderExpChange(arg_5_0, arg_5_1)
	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.cards) do
		local var_5_0 = iter_5_1.cattery

		if var_7.ExistCommander(var_5_0) then
			iter_5_1:Update(var_7)
		end
	end

	local var_5_1 = arg_5_0.catteryDescPage

	if var_2.GetLoaded(var_5_1) then
		local var_5_2 = arg_5_0.catteryDescPage

		if var_2.isShowing(var_5_2) then
			local var_5_3 = arg_5_0.catteryDescPage

			var_2.FlushCatteryInfo(var_5_3)
		end
	end

	local var_5_4 = arg_5_0.awardDisplayView

	var_2.ExecuteAction(var_5_4, "AddPlan", {
		homeExp = 0,
		commanderExps = arg_5_1,
		awards = {}
	})

	return
end

function var_0_1.OnCatteryOPDone(arg_6_0)
	arg_6_0:UpdateMain()

	return
end

function var_0_1.OnZeroHour(arg_7_0)
	arg_7_0:UpdateMain()

	return
end

function var_0_1.OnOpAnimtion(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	setActive = var_1_10004

	var_1_10004(arg_8_0.opAnim.gameObject, true)

	if not ({
		"clean",
		"feed",
		"play"
	})[arg_8_1] then
		arg_8_3()

		return
	end

	if arg_8_0.timer then
		local var_8_0 = arg_8_0.timer

		var_6.Stop(var_8_0)

		arg_8_0.timer = nil
	end

	Timer = var_6
	arg_8_0.timer = var_6.New(function()
		local var_9_0 = arg_8_0

		var_0.CancelOpAnim(var_9_0)

		return
	end, 0.8, 1)

	local var_8_1 = arg_8_0.timer

	var_6.Start(var_8_1)

	local var_8_2 = arg_8_0.opAnim

	var_6.SetTrigger(var_8_2, var_5)

	pairs = var_6

	for iter_8_0, iter_8_1 in var_6(arg_8_0.cards) do
		table = var_1_10011

		if var_1_10011.contains(arg_8_2, iter_8_1.cattery.id) then
			floatAni = var_1_10011

			var_1_10011(iter_8_1.char, 20, 0.1, 2)
		end
	end

	arg_8_0.callback = arg_8_3

	return
end

function var_0_1.CancelOpAnim(arg_10_0)
	if arg_10_0.callback then
		local var_10_0 = arg_10_0.timer

		var_1.Stop(var_10_0)

		arg_10_0.timer = nil

		local var_10_1 = arg_10_0.opAnim

		var_1.SetTrigger(var_10_1, "empty")
		arg_10_0.callback()

		arg_10_0.callback = nil
		setActive = var_1

		var_1(arg_10_0.opAnim.gameObject, false)
	end

	return
end

function var_0_1.OnDisplayAwardDone(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.awardDisplayView

	var_2.ExecuteAction(var_11_0, "AddPlan", arg_11_1)

	return
end

function var_0_1.init(arg_12_0)
	local var_12_0 = arg_12_0._tf

	arg_12_0.frame = var_1.Find(var_12_0, "bg")

	local var_12_1 = arg_12_0._tf

	arg_12_0.closeBtn = var_1.Find(var_12_1, "bg/frame/close_btn")

	local var_12_2 = arg_12_0._tf

	arg_12_0.levelInfoBtn = var_1.Find(var_12_2, "bg/frame/title/help")

	local var_12_3 = arg_12_0._tf
	local var_12_4 = var_1.Find(var_12_3, "bg/frame/title/Text")
	local var_12_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_12_0.levelTxt = var_12_5(var_12_4, var_3(var_1_10004))

	local var_12_6 = arg_12_0._tf
	local var_12_7 = var_1.Find(var_12_6, "bg/frame/scrollrect")

	arg_12_0.scrollRect = var_1.GetComponent(var_12_7, "ScrollRect")

	local var_12_8 = arg_12_0._tf

	arg_12_0.scrollRectContent = var_1.Find(var_12_8, "bg/frame/scrollrect/content")

	local var_12_9 = arg_12_0._tf

	arg_12_0.batchBtn = var_1.Find(var_12_9, "bg/frame/batch")

	local var_12_10 = arg_12_0._tf
	local var_12_11 = var_1.Find(var_12_10, "animation")
	local var_12_12 = var_1.GetComponent

	typeof = var_3
	Animator = var_1_10004
	arg_12_0.opAnim = var_12_12(var_12_11, var_3(var_1_10004))
	UIItemList = var_1

	local var_12_13 = var_1.New
	local var_12_14 = arg_12_0.scrollRectContent
	local var_12_15 = arg_12_0.scrollRectContent

	arg_12_0.UIlist = var_12_13(var_12_14, var_3.Find(var_12_15, "tpl"))

	local var_12_16 = arg_12_0._tf

	arg_12_0.helpBtn = var_1.Find(var_12_16, "bg/frame/help")

	local var_12_17 = arg_12_0._tf
	local var_12_18 = var_1.Find(var_12_17, "bg/frame/cnt/Text")
	local var_12_19 = var_1.GetComponent

	typeof = var_3
	Text = var_12_15
	arg_12_0.cntTxt = var_12_19(var_12_18, var_3(var_12_15))
	arg_12_0.cards = {}
	CatteryDescPage = var_1
	arg_12_0.catteryDescPage = var_1.New(arg_12_0._tf, arg_12_0.event, arg_12_0.contextData)
	CommanderHomeLevelInfoPage = var_1
	arg_12_0.levelInfoPage = var_1.New(arg_12_0._tf, arg_12_0.event, arg_12_0.contextData)
	CatteryOpAnimPage = var_1
	arg_12_0.awardDisplayView = var_1.New(arg_12_0._tf, arg_12_0.event)
	CommanderHomeBatchSelPage = var_1
	arg_12_0.batchSelPage = var_1.New(arg_12_0._tf, arg_12_0.event)
	CatteryFlowerView = var_1

	local var_12_20 = var_1.New
	local var_12_21 = arg_12_0._tf

	arg_12_0.flower = var_12_20(var_2.Find(var_12_21, "bg/frame/flower"))

	local var_12_22 = arg_12_0._tf

	arg_12_0.bubbleTF = var_1.Find(var_12_22, "bg/bubble")

	local var_12_23 = arg_12_0.bubbleTF

	arg_12_0.bubbleClean = var_1.Find(var_12_23, "clean")

	local var_12_24 = arg_12_0.bubbleTF

	arg_12_0.bubbleFeed = var_1.Find(var_12_24, "feed")

	local var_12_25 = arg_12_0.bubbleTF

	arg_12_0.bubblePlay = var_1.Find(var_12_25, "play")

	return
end

function var_0_1.RegisterEvent(arg_13_0)
	arg_13_0:bind(var_0_1.DESC_PAGE_CLOSE, function()
		setActive = var_2_10000

		var_2_10000(arg_13_0.frame, true)

		return
	end)
	arg_13_0:bind(var_0_1.DESC_PAGE_OPEN, function()
		setActive = var_2_10000

		var_2_10000(arg_13_0.frame, false)

		return
	end)

	return
end

function var_0_1.didEnter(arg_16_0)
	arg_16_0:RegisterEvent()

	onButton = var_1

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.closeBtn

	local function var_16_2()
		local var_17_0 = arg_16_0

		var_0.emit(var_17_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_16_0, var_16_1, var_16_2, var_1_10005)

	onButton = var_1

	local var_16_3 = arg_16_0
	local var_16_4 = arg_16_0._tf

	local function var_16_5()
		if arg_16_0.forbiddenClose then
			return
		end

		local var_18_0 = arg_16_0

		var_0.emit(var_18_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_16_3, var_16_4, var_16_5, var_1_10005)

	onButton = var_1

	local var_16_6 = arg_16_0
	local var_16_7 = arg_16_0.levelInfoBtn

	local function var_16_8()
		local var_19_0 = arg_16_0.levelInfoPage

		var_0.ExecuteAction(var_19_0, "Show", arg_16_0.home)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_16_6, var_16_7, var_16_8, var_1_10005)

	onButton = var_1

	local var_16_9 = arg_16_0
	local var_16_10 = arg_16_0.helpBtn

	local function var_16_11()
		pg = var_2_10000

		local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_20_1 = var_0.ShowMsgBox
		local var_20_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_20_2.type = var_2_10003
		pg = var_2_10003
		var_20_2.helps = var_2_10003.gametip.cat_home_help.tip

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_16_9, var_16_10, var_16_11, var_1_10005)

	onButton = var_1

	local var_16_12 = arg_16_0
	local var_16_13 = arg_16_0.bubbleClean

	local function var_16_14()
		local var_21_0 = arg_16_0

		var_0.CancelOpAnim(var_21_0)

		local var_21_1 = arg_16_0
		local var_21_2 = var_0.emit

		CommanderHomeMediator = var_2_10002

		var_21_2(var_21_1, var_2_10002.ON_CLEAN)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_16_12, var_16_13, var_16_14, var_1_10005)

	onButton = var_1

	local var_16_15 = arg_16_0
	local var_16_16 = arg_16_0.bubbleFeed

	local function var_16_17()
		local var_22_0 = arg_16_0

		var_0.CancelOpAnim(var_22_0)

		local var_22_1 = arg_16_0
		local var_22_2 = var_0.emit

		CommanderHomeMediator = var_2_10002

		var_22_2(var_22_1, var_2_10002.ON_FEED)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_16_15, var_16_16, var_16_17, var_1_10005)

	onButton = var_1

	local var_16_18 = arg_16_0
	local var_16_19 = arg_16_0.bubblePlay

	local function var_16_20()
		local var_23_0 = arg_16_0

		var_0.CancelOpAnim(var_23_0)

		local var_23_1 = arg_16_0
		local var_23_2 = var_0.emit

		CommanderHomeMediator = var_2_10002

		var_23_2(var_23_1, var_2_10002.ON_PLAY)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_16_18, var_16_19, var_16_20, var_1_10005)

	onButton = var_1

	local var_16_21 = arg_16_0
	local var_16_22 = arg_16_0.batchBtn

	local function var_16_23()
		local var_24_0 = arg_16_0.batchSelPage

		var_0.ExecuteAction(var_24_0, "Update", arg_16_0.home)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_16_21, var_16_22, var_16_23, var_1_10005)

	local var_16_24 = arg_16_0.UIlist

	var_1.make(var_16_24, function(arg_25_0, arg_25_1, arg_25_2)
		UIItemList = var_2_10003

		if arg_25_0 == var_2_10003.EventUpdate then
			local var_25_0 = arg_16_0

			var_3.OnUpdateItem(var_25_0, arg_25_2, arg_16_0.displays[arg_25_1 + 1])
		end

		return
	end)
	arg_16_0:UpdateMain()

	pg = var_1

	local var_16_25 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_16_25, arg_16_0._tf)

	return
end

function var_0_1.OnUpdateItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0

	if not arg_26_0.cards[arg_26_1] then
		CatteryCard = var_1_10004
		var_26_0 = var_1_10004.New(arg_26_1)
		var_1_10004 = arg_26_0.cards
		var_1_10004[arg_26_1] = var_26_0
	end

	onButton = var_1_10004

	local var_26_1 = arg_26_0
	local var_26_2 = var_26_0._tf

	local function var_26_3()
		local var_27_0 = var_26_0.cattery

		if not var_0.IsLocked(var_27_0) then
			local var_27_1 = arg_26_0.catteryDescPage

			var_0.ExecuteAction(var_27_1, "Update", arg_26_0.home, var_26_0.cattery)
		else
			pg = var_0

			local var_27_2 = var_0.TipsMgr.GetInstance()
			local var_27_3 = var_0.ShowTips

			i18n = var_2_10002

			var_27_3(var_27_2, var_2_10002("cat_home_unlock"))
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10004(var_26_1, var_26_2, var_26_3, var_1_10008)
	var_26_0:Update(arg_26_2)

	return
end

function var_0_1.UpdateMain(arg_28_0)
	local var_28_0 = arg_28_0.levelTxt
	local var_28_1 = "LV."
	local var_28_2 = arg_28_0.home

	var_28_0.text = var_28_1 .. var_3.GetLevel(var_28_2)

	arg_28_0:InitCatteries()

	local var_28_3 = arg_28_0.flower

	var_1.Update(var_28_3, arg_28_0.home)

	return
end

function var_0_1.InitCatteries(arg_29_0)
	local var_29_0 = arg_29_0.home

	arg_29_0.displays = {}

	local var_29_1 = var_29_0:GetCatteries()
	local var_29_2 = 0
	local var_29_3 = 0

	pairs = var_1_10005

	for iter_29_0, iter_29_1 in var_1_10005(var_29_1) do
		table = var_1_10010

		var_1_10010.insert(arg_29_0.displays, iter_29_1)

		if iter_29_1:ExistCommander() then
			var_29_3 = var_29_3 + 1
		end

		if not iter_29_1:IsLocked() then
			var_29_2 = var_29_2 + 1
		end
	end

	local var_29_4 = arg_29_0.UIlist

	var_5.align(var_29_4, #arg_29_0.displays)
	arg_29_0:UpdateBubble()

	arg_29_0.cntTxt.text = var_29_3 .. "/" .. var_29_2

	return
end

function var_0_1.UpdateBubble(arg_30_0)
	local var_30_0 = arg_30_0.home
	local var_30_1 = var_1.GetCatteries(var_30_0)
	local var_30_2 = false
	local var_30_3 = false
	local var_30_4 = false

	pairs = var_1_10005

	for iter_30_0, iter_30_1 in var_1_10005(var_30_1) do
		if iter_30_1:ExistCleanOP() and iter_30_1:CommanderCanClean() then
			var_30_2 = true
		end

		if iter_30_1:ExiseFeedOP() and iter_30_1:CommanderCanFeed() then
			var_30_3 = true
		end

		if iter_30_1:ExistPlayOP() and iter_30_1:CommanderCanPlay() then
			var_30_4 = true
		end
	end

	local var_30_5 = var_30_2 or var_30_3 or var_30_4

	setActive = var_6

	var_6(arg_30_0.bubbleTF, var_30_5)

	LeanTween = var_6

	if var_6.isTweening(arg_30_0.bubbleTF.gameObject) then
		LeanTween = var_6

		var_6.cancel(arg_30_0.bubbleTF.gameObject)
	end

	if var_30_5 then
		floatAni = var_6

		var_6(arg_30_0.bubbleTF, 20, 0.5, -1)

		setActive = var_6

		var_6(arg_30_0.bubbleClean, var_30_2)

		setActive = var_6

		var_6(arg_30_0.bubbleFeed, var_30_3 and not var_30_2)

		setActive = var_6

		var_6(arg_30_0.bubblePlay, var_30_4 and not var_30_3)
	end

	return
end

function var_0_1.willExit(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.UIMgr.GetInstance()
	local var_31_1 = var_1.UnOverlayPanel
	local var_31_2 = arg_31_0._tf

	pg = var_1_10004

	var_31_1(var_31_0, var_31_2, var_1_10004.UIMgr.GetInstance()._normalUIMain)

	LeanTween = var_31_1

	if var_31_1.isTweening(arg_31_0.bubbleTF.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_31_0.bubbleTF.gameObject)
	end

	pairs = var_1

	for iter_31_0, iter_31_1 in var_1(arg_31_0.cards) do
		iter_31_1:Dispose()
	end

	if arg_31_0.timer then
		local var_31_3 = arg_31_0.timer

		var_1.Stop(var_31_3)

		arg_31_0.timer = nil
	end

	arg_31_0.cards = nil

	local var_31_4 = arg_31_0.flower

	var_1.Dispose(var_31_4)

	arg_31_0.flower = nil

	local var_31_5 = arg_31_0.catteryDescPage

	var_1.Destroy(var_31_5)

	arg_31_0.catteryDescPage = nil

	local var_31_6 = arg_31_0.levelInfoPage

	var_1.Destroy(var_31_6)

	arg_31_0.levelInfoPage = nil

	local var_31_7 = arg_31_0.awardDisplayView

	var_1.Destroy(var_31_7)

	return
end

function var_0_1.onBackPressed(arg_32_0)
	local var_32_0 = arg_32_0.catteryDescPage

	if var_1.GetLoaded(var_32_0) then
		local var_32_1 = arg_32_0.catteryDescPage

		if var_1.isShowing(var_32_1) then
			local var_32_2 = arg_32_0.catteryDescPage

			var_1.Hide(var_32_2)

			return
		end
	end

	local var_32_3 = arg_32_0.levelInfoPage

	if var_1.GetLoaded(var_32_3) then
		local var_32_4 = arg_32_0.levelInfoPage

		if var_1.isShowing(var_32_4) then
			local var_32_5 = arg_32_0.levelInfoPage

			var_1.Hide(var_32_5)

			return
		end
	end

	local var_32_6 = arg_32_0.batchSelPage

	if var_1.GetLoaded(var_32_6) then
		local var_32_7 = arg_32_0.batchSelPage

		if var_1.isShowing(var_32_7) then
			local var_32_8 = arg_32_0.batchSelPage

			var_1.Hide(var_32_8)
		end
	end

	var_0_1.super.onBackPressed(arg_32_0)

	return
end

return var_0_1
