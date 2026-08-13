class = var_0_10000

local var_0_0 = "EducateScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.PerformMgr.GetInstance()

	var_2.CheckLoad(var_2_0, function()
		arg_2_1()

		return
	end)

	return
end

function var_0_1.init(arg_4_0)
	arg_4_0:initData()
	arg_4_0:findUI()
	arg_4_0:addListener()

	return
end

function var_0_1.PlayBGM(arg_5_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)
	local var_5_1 = var_1.GetCharData(var_5_0)

	if var_1.GetBgm(var_5_1) then
		pg = var_1_10002

		local var_5_2 = var_1_10002.BgmMgr.GetInstance()

		var_2.Push(var_5_2, arg_5_0.__cname, var_1)
	end

	return
end

function var_0_1.initData(arg_6_0)
	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf
	local var_7_1 = var_1.Find(var_7_0, "anim_root")
	local var_7_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_7_0.mainAnim = var_7_2(var_7_1, var_4(var_1_10006))

	local var_7_3 = arg_7_0._tf

	arg_7_0.bgTF = var_1.Find(var_7_3, "anim_root/bg")

	local var_7_4 = arg_7_0._tf

	arg_7_0.blurPanel = var_1.Find(var_7_4, "anim_root/blur_panel")

	local var_7_5 = arg_7_0.blurPanel
	local var_7_6 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_7_0.blurPanelAnim = var_7_6(var_7_5, var_4(var_1_10006))

	local var_7_7 = arg_7_0.blurPanel

	arg_7_0.topTF = var_1.Find(var_7_7, "top")

	local var_7_8 = arg_7_0.topTF

	arg_7_0.favorBtn = var_1.Find(var_7_8, "favor")

	local var_7_9 = arg_7_0.favorBtn

	arg_7_0.favorLvTF = var_1.Find(var_7_9, "anim_root/Text")

	local var_7_10 = arg_7_0.favorBtn

	arg_7_0.favorMaxTF = var_1.Find(var_7_10, "anim_root/max")

	local var_7_11 = arg_7_0.favorBtn
	local var_7_12 = var_1.Find(var_7_11, "anim_root")
	local var_7_13 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_7_0.favorBtnAnim = var_7_13(var_7_12, var_4(var_1_10006))

	local var_7_14 = arg_7_0.favorBtn
	local var_7_15 = var_1.Find(var_7_14, "anim_root")
	local var_7_16 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_7_0.favorBtnAnimEvent = var_7_16(var_7_15, var_4(var_1_10006))

	local var_7_17 = arg_7_0.favorBtnAnimEvent

	var_1.SetTriggerEvent(var_7_17, function()
		local var_8_0 = arg_7_0

		var_0.updateFavorBtn(var_8_0)

		return
	end)

	local var_7_18 = arg_7_0._tf

	arg_7_0.mainTF = var_1.Find(var_7_18, "anim_root/main")

	local var_7_19 = arg_7_0.mainTF

	arg_7_0.paintTF = var_1.Find(var_7_19, "painting")

	local var_7_20 = arg_7_0.blurPanel

	arg_7_0.dialogueTF = var_1.Find(var_7_20, "dialogue")

	local var_7_21 = arg_7_0.dialogueTF

	arg_7_0.dialogueContent = var_1.Find(var_7_21, "content")
	setActive = var_1

	var_1(arg_7_0.dialogueTF, false)

	local var_7_22 = arg_7_0._tf

	arg_7_0.bubbleTF = var_1.Find(var_7_22, "anim_root/blur_panel/bubble")
	setActive = var_1

	var_1(arg_7_0.bubbleTF, false)

	local var_7_23 = arg_7_0.bubbleTF

	arg_7_0.bubbleBtn = var_1.Find(var_7_23, "bubble")

	local var_7_24 = arg_7_0.mainTF

	arg_7_0.optionsTF = var_1.Find(var_7_24, "options")

	local var_7_25 = arg_7_0.optionsTF

	arg_7_0.chatBtn = var_1.Find(var_7_25, "options/chat")

	local var_7_26 = arg_7_0.optionsTF

	arg_7_0.giftBtn = var_1.Find(var_7_26, "options/gift")
	setActive = var_1

	var_1(arg_7_0.optionsTF, false)

	local var_7_27 = arg_7_0.blurPanel

	arg_7_0.bottomTF = var_1.Find(var_7_27, "bottom")

	local var_7_28 = arg_7_0.bottomTF

	arg_7_0.bookBtn = var_1.Find(var_7_28, "left/btns/book")
	setText = var_1

	local var_7_29 = arg_7_0.bookBtn
	local var_7_30 = var_3.Find(var_7_29, "unlock/Text")

	i18n = var_4

	var_1(var_7_30, var_4("child_btn_collect"))

	local var_7_31 = arg_7_0.bottomTF

	arg_7_0.mindBtn = var_1.Find(var_7_31, "left/btns/mind")
	setText = var_1

	local var_7_32 = arg_7_0.mindBtn
	local var_7_33 = var_3.Find(var_7_32, "unlock/Text")

	i18n = var_4

	var_1(var_7_33, var_4("child_btn_mind"))

	local var_7_34 = arg_7_0.bottomTF

	arg_7_0.bagBtn = var_1.Find(var_7_34, "left/btns/bag")
	setText = var_1

	local var_7_35 = arg_7_0.bagBtn
	local var_7_36 = var_3.Find(var_7_35, "unlock/Text")

	i18n = var_4

	var_1(var_7_36, var_4("child_btn_bag"))

	EducateDatePanel = var_1

	local var_7_37 = var_1.New
	local var_7_38 = arg_7_0.topTF

	arg_7_0.datePanel = var_7_37(var_3.Find(var_7_38, "date"), arg_7_0.event, {
		isMain = true
	})

	local var_7_39 = arg_7_0.datePanel

	var_1.RegisterView(var_7_39, arg_7_0)

	EducateFavorPanel = var_1

	local var_7_40 = var_1.New
	local var_7_41 = arg_7_0.topTF

	arg_7_0.favorPanel = var_7_40(var_3.Find(var_7_41, "favor_panel"), arg_7_0.event)

	local var_7_42 = arg_7_0.favorPanel

	var_1.RegisterView(var_7_42, arg_7_0)

	EducateResPanel = var_1

	local var_7_43 = var_1.New
	local var_7_44 = arg_7_0.topTF

	arg_7_0.resPanel = var_7_43(var_3.Find(var_7_44, "res"), arg_7_0.event)

	local var_7_45 = arg_7_0.resPanel

	var_1.RegisterView(var_7_45, arg_7_0)

	EducateTopPanel = var_1

	local var_7_46 = var_1.New
	local var_7_47 = arg_7_0.topTF

	arg_7_0.topPanel = var_7_46(var_3.Find(var_7_47, "top_right"), arg_7_0.event)

	local var_7_48 = arg_7_0.topPanel

	var_1.RegisterView(var_7_48, arg_7_0)

	EducateTargetPanel = var_1

	local var_7_49 = var_1.New
	local var_7_50 = arg_7_0.topTF

	arg_7_0.targetPanel = var_7_49(var_3.Find(var_7_50, "target"), arg_7_0.event)

	local var_7_51 = arg_7_0.targetPanel

	var_1.RegisterView(var_7_51, arg_7_0)

	EducateBottomPanel = var_1

	local var_7_52 = var_1.New
	local var_7_53 = arg_7_0.bottomTF

	arg_7_0.bottomPanel = var_7_52(var_3.Find(var_7_53, "right"), arg_7_0.event, {
		isMainEnter = arg_7_0.contextData.isMainEnter
	})

	local var_7_54 = arg_7_0.bottomPanel

	var_1.RegisterView(var_7_54, arg_7_0)

	EducateArchivePanel = var_1

	local var_7_55 = var_1.New
	local var_7_56 = arg_7_0.mainTF

	arg_7_0.archivePanel = var_7_55(var_3.Find(var_7_56, "archive_panel"), arg_7_0.event, {
		isShow = true,
		isMainEnter = arg_7_0.contextData.isMainEnter
	})

	local var_7_57 = arg_7_0.archivePanel

	var_1.RegisterView(var_7_57, arg_7_0)

	return
end

function var_0_1._loadSubViews(arg_9_0)
	local var_9_0 = arg_9_0.datePanel

	var_1.Load(var_9_0)

	local var_9_1 = arg_9_0.favorPanel

	var_1.Load(var_9_1)

	local var_9_2 = arg_9_0.resPanel

	var_1.Load(var_9_2)

	local var_9_3 = arg_9_0.topPanel

	var_1.Load(var_9_3)

	local var_9_4 = arg_9_0.targetPanel

	var_1.Load(var_9_4)

	local var_9_5 = arg_9_0.bottomPanel

	var_1.Load(var_9_5)

	local var_9_6 = arg_9_0.archivePanel

	var_1.Load(var_9_6)

	local var_9_7 = arg_9_0
	local var_9_8 = arg_9_0.OverlayPanel
	local var_9_9 = arg_9_0.blurPanel
	local var_9_10 = {}
	local var_9_11 = {}
	local var_9_12 = arg_9_0.blurPanel

	var_9_11[1] = var_7.Find(var_9_12, "bottom/left")
	var_9_10.pbList = var_9_11

	var_9_8(var_9_7, var_9_9, var_9_10)

	local var_9_13 = arg_9_0.contextData.isMainEnter and "anim_educate_educateUI_bg_in" or "anim_educate_educateUI_bg_show"
	local var_9_14 = arg_9_0.mainAnim

	var_2.Play(var_9_14, var_9_13)

	local var_9_15 = arg_9_0.contextData.isMainEnter and "anim_educate_educateUI_in" or "anim_educate_educateUI_show"
	local var_9_16 = arg_9_0.blurPanelAnim

	var_3.Play(var_9_16, var_9_15)

	return
end

function var_0_1.addListener(arg_10_0)
	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.chatBtn

	local function var_10_2()
		pg = var_2_10000

		local var_11_0 = var_2_10000.TipsMgr.GetInstance()

		var_0.ShowTips(var_11_0, "触发对话[待开发]...")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10006)

	onButton = var_1_10001

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.giftBtn

	local function var_10_5()
		pg = var_2_10000

		local var_12_0 = var_2_10000.TipsMgr.GetInstance()

		var_0.ShowTips(var_12_0, "送礼(?)...")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_3, var_10_4, var_10_5, var_1_10006)

	onButton = var_1_10001

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.favorBtn

	local function var_10_8()
		local var_13_0 = arg_10_0.favorPanel

		var_0.Show(var_13_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_6, var_10_7, var_10_8, var_1_10006)

	onButton = var_1_10001

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_0.bookBtn

	local function var_10_11()
		local var_14_0 = arg_10_0
		local var_14_1 = var_0.emit
		local var_14_2 = var_0_1.EDUCATE_GO_SUBLAYER

		Context = var_2_10004

		local var_14_3 = var_2_10004.New
		local var_14_4 = {}

		EducateCollectEntranceMediator = var_2_10007
		var_14_4.mediator = var_2_10007
		EducateCollectEntranceLayer = var_2_10007
		var_14_4.viewComponent = var_2_10007

		var_14_1(var_14_0, var_14_2, var_14_3(var_14_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_9, var_10_10, var_10_11, var_1_10006)

	onButton = var_1_10001

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.mindBtn

	local function var_10_14()
		isActive = var_2_10000

		local var_15_0 = arg_10_0.mindBtn

		if var_2_10000(var_2.Find(var_15_0, "lock")) then
			return
		end

		local var_15_1 = arg_10_0
		local var_15_2 = var_0.emit
		local var_15_3 = var_0_1.EDUCATE_GO_SUBLAYER

		Context = var_15_0

		local var_15_4 = var_15_0.New
		local var_15_5 = {}

		EducateMindMediator = var_2_10007
		var_15_5.mediator = var_2_10007
		EducateMindLayer = var_2_10007
		var_15_5.viewComponent = var_2_10007
		var_15_5.data = {
			onExit = function()
				local var_16_0 = arg_10_0

				var_0.checkBubbleShow(var_16_0)

				return
			end
		}

		var_15_2(var_15_1, var_15_3, var_15_4(var_15_5))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_12, var_10_13, var_10_14, var_1_10006)

	onButton = var_1_10001

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_0.bagBtn

	local function var_10_17()
		isActive = var_2_10000

		local var_17_0 = arg_10_0.bagBtn

		if var_2_10000(var_2.Find(var_17_0, "lock")) then
			return
		end

		local var_17_1 = arg_10_0
		local var_17_2 = var_0.emit
		local var_17_3 = var_0_1.EDUCATE_GO_SUBLAYER

		Context = var_17_0

		local var_17_4 = var_17_0.New
		local var_17_5 = {}

		EducateBagMediator = var_2_10007
		var_17_5.mediator = var_2_10007
		EducateBagLayer = var_2_10007
		var_17_5.viewComponent = var_2_10007

		var_17_2(var_17_1, var_17_3, var_17_4(var_17_5))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_10_15, var_10_16, var_10_17, var_1_10006)

	onButton = var_1_10001

	local var_10_18 = arg_10_0
	local var_10_19 = arg_10_0.paintTF
	local var_10_20 = var_4.Find(var_10_19, "fitter")

	local function var_10_21()
		local var_18_0 = arg_10_0

		var_0.ShowDialogue(var_18_0)

		return
	end

	SFX_PANEL = var_10_19

	var_1_10001(var_10_18, var_10_20, var_10_21, var_10_19)

	return
end

function var_0_1.didEnter(arg_19_0)
	if arg_19_0.contextData.onEnter then
		arg_19_0.contextData.onEnter()

		arg_19_0.contextData.onEnter = nil
	end

	arg_19_0:updatePaintingUI()
	arg_19_0:updateUnlockBtns()
	arg_19_0:updateNewTips()
	arg_19_0:updateMindTip()
	arg_19_0:updateFavorBtn()
	arg_19_0:SeriesCheck()

	return
end

function var_0_1.SeriesCheck(arg_20_0)
	local var_20_0 = {}

	table = var_1_10002

	var_1_10002.insert(var_20_0, function(arg_21_0)
		local var_21_0 = arg_20_0

		var_1.CheckNewChar(var_21_0, arg_21_0)

		return
	end)

	table = var_2

	var_2.insert(var_20_0, function(arg_22_0)
		getProxy = var_2_10001
		EducateProxy = var_2_10003

		local var_22_0 = var_2_10001(var_2_10003)
		local var_22_1 = var_1.GetPlanProxy(var_22_0)

		if var_1.CheckExcute(var_22_1) then
			local var_22_2 = arg_20_0
			local var_22_3 = var_1.emit

			EducateMediator = var_2_10004

			var_22_3(var_22_2, var_2_10004.ON_EXECTUE_PLANS)
		else
			arg_22_0()
		end

		return
	end)

	table = var_2

	var_2.insert(var_20_0, function(arg_23_0)
		local var_23_0 = arg_20_0

		var_1.CheckTips(var_23_0, arg_23_0)

		return
	end)

	table = var_2

	var_2.insert(var_20_0, function(arg_24_0)
		getProxy = var_2_10001
		EducateProxy = var_2_10003

		local var_24_0 = var_2_10001(var_2_10003)
		local var_24_1 = var_1.GetEventProxy(var_24_0)

		if var_1.NeedGetHomeEventData(var_24_1) then
			local var_24_2 = arg_20_0
			local var_24_3 = var_1.emit

			EducateMediator = var_2_10004

			var_24_3(var_24_2, var_2_10004.ON_GET_EVENT, arg_24_0)
		else
			arg_24_0()
		end

		return
	end)
	arg_20_0:checkBubbleShow()

	table = var_2

	var_2.insert(var_20_0, function(arg_25_0)
		if not arg_20_0.contextData.ingoreGuideCheck then
			EducateGuideSequence = var_1

			var_1.CheckGuide(arg_20_0.__cname, arg_25_0)
		else
			arg_20_0.contextData.ingoreGuideCheck = nil

			arg_25_0()
		end

		return
	end)

	seriesAsync = var_2

	var_2(var_20_0, function()
		return
	end)

	return
end

function var_0_1.OnCheckGuide(arg_27_0, arg_27_1)
	EducateGuideSequence = var_1_10002

	var_1_10002.CheckGuide(arg_27_0.__cname, function()
		existCall = var_2_10000

		var_2_10000(arg_27_1)

		return
	end)

	return
end

function var_0_1.CheckTips(arg_29_0, arg_29_1)
	local var_29_0 = {}

	ipairs = var_1_10003
	EducateTipHelper = var_1_10005

	for iter_29_0, iter_29_1 in var_1_10003(var_1_10005.GetSystemUnlockTips()) do
		table = var_1_10008

		var_1_10008.insert(var_29_0, function(arg_30_0)
			local var_30_0 = arg_29_0
			local var_30_1 = var_1.emit
			local var_30_2 = var_0_1.EDUCATE_ON_UNLOCK_TIP
			local var_30_3 = {}

			EducateUnlockTipLayer = var_2_10006
			var_30_3.type = var_2_10006.UNLOCK_TYPE_SYSTEM
			var_30_3.single = iter_29_1
			var_30_3.onExit = arg_30_0

			var_30_1(var_30_0, var_30_2, var_30_3)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_29_0, function()
		arg_29_1()

		return
	end)

	return
end

function var_0_1.CheckNewChar(arg_32_0, arg_32_1)
	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_32_0 = var_1_10002(var_1_10004)
	local var_32_1 = var_2.GetCharData(var_32_0)

	if var_2.GetCallName(var_32_1) == "" then
		setActive = var_2

		var_2(arg_32_0._tf, false)

		local var_32_2 = {}

		table = var_1_10003

		var_1_10003.insert(var_32_2, function(arg_33_0)
			pg = var_2_10001

			local var_33_0 = var_2_10001.PerformMgr.GetInstance()
			local var_33_1 = var_1.PlayGroup

			EducateConst = var_2_10004

			var_33_1(var_33_0, var_2_10004.FIRST_ENTER_PERFORM_IDS, arg_33_0)

			return
		end)

		table = var_3

		var_3.insert(var_32_2, function(arg_34_0)
			local var_34_0 = arg_32_0
			local var_34_1 = var_1.emit
			local var_34_2 = var_0_1.EDUCATE_GO_SUBLAYER

			Context = var_2_10005

			local var_34_3 = var_2_10005.New
			local var_34_4 = {}

			EducateNewCharMediator = var_2_10008
			var_34_4.mediator = var_2_10008
			EducateNewCharLayer = var_2_10008
			var_34_4.viewComponent = var_2_10008
			var_34_4.data = {
				callback = arg_34_0
			}

			var_34_1(var_34_0, var_34_2, var_34_3(var_34_4))

			return
		end)

		table = var_3

		var_3.insert(var_32_2, function(arg_35_0)
			pg = var_2_10001

			local var_35_0 = var_2_10001.PerformMgr.GetInstance()
			local var_35_1 = var_1.PlayOne

			EducateConst = var_2_10004

			var_35_1(var_35_0, var_2_10004.AFTER_SET_CALLNAME_PERFORM_ID, arg_35_0)

			return
		end)

		seriesAsync = var_3

		var_3(var_32_2, function()
			setActive = var_2_10000

			var_2_10000(arg_32_0._tf, true)

			local var_36_0 = arg_32_0

			var_0._loadSubViews(var_36_0)
			arg_32_1()

			return
		end)
	else
		arg_32_0:_loadSubViews()
		arg_32_1()
	end

	return
end

function var_0_1.showBubble(arg_37_0, arg_37_1)
	setActive = var_1_10002

	var_1_10002(arg_37_0.bubbleTF, true)

	onButton = var_1_10002

	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.bubbleBtn

	local function var_37_2()
		arg_37_1()

		setActive = var_0

		var_0(arg_37_0.bubbleTF, false)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_37_0, var_37_1, var_37_2, var_1_10007)

	return
end

function var_0_1.PlayPerformWithDrops(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	EducateHelper = var_1_10004

	local var_39_0 = var_1_10004.GetDialogueShowDrops(arg_39_2)

	EducateHelper = var_1_10005

	local var_39_1 = var_1_10005.GetCommonShowDrops(arg_39_2)

	local function var_39_2()
		if #var_39_1 > 0 then
			local var_40_0 = arg_39_0

			var_0.emit(var_40_0, var_0_1.EDUCATE_ON_AWARD, {
				items = var_39_1,
				removeFunc = function()
					if arg_39_3 then
						arg_39_3()
					end

					return
				end
			})
		elseif arg_39_3 then
			arg_39_3()
		end

		return
	end

	if #arg_39_1 > 0 then
		pg = var_7

		local var_39_3 = var_7.PerformMgr.GetInstance()

		var_7.PlayGroup(var_39_3, arg_39_1, var_39_2, var_39_0)
	elseif var_39_2 then
		var_39_2()
	end

	return
end

function var_0_1.ShowFavorUpgrade(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	arg_42_0:PlayPerformWithDrops(arg_42_2, arg_42_1, function()
		if #arg_42_1 > 0 then
			local var_43_0 = arg_42_0

			var_0.emit(var_43_0, var_0_1.EDUCATE_ON_AWARD, {
				items = arg_42_1,
				removeFunc = function()
					local var_44_0 = arg_42_0.favorBtnAnim

					var_0.Play(var_44_0, "anim_educate_favor_levelup")

					if arg_42_3 then
						arg_42_3()
					end

					return
				end
			})
		else
			local var_43_1 = arg_42_0.favorBtnAnim

			var_0.Play(var_43_1, "anim_educate_favor_levelup")

			if arg_42_3 then
				arg_42_3()
			end
		end

		return
	end)

	return
end

function var_0_1.ShowSpecialEvent(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	pg = var_1_10004

	local var_45_0 = var_1_10004.child_event_special[arg_45_1].performance

	arg_45_0:PlayPerformWithDrops(var_45_0, arg_45_2, function()
		if #arg_45_2 > 0 then
			local var_46_0 = arg_45_0

			var_0.emit(var_46_0, var_0_1.EDUCATE_ON_AWARD, {
				items = arg_45_2,
				removeFunc = function()
					if arg_45_3 then
						arg_45_3()
					end

					return
				end
			})
		elseif arg_45_3 then
			arg_45_3()
		end

		return
	end)

	return
end

function var_0_1.checkBubbleShow(arg_48_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_48_0 = var_1_10001(var_1_10003)
	local var_48_1 = var_1.GetEventProxy(var_48_0)
	local var_48_2 = var_1.GetHomeSpecEvents(var_48_1)

	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_48_3 = var_1_10002(var_1_10004)
	local var_48_4 = var_2.GetCharData(var_48_3)

	if #var_48_2 > 0 then
		setActive = var_3

		local var_48_5 = arg_48_0.bubbleBtn

		var_3(var_5.Find(var_48_5, "Text"), true)

		setActive = var_3

		local var_48_6 = arg_48_0.bubbleBtn

		var_3(var_5.Find(var_48_6, "Image"), false)
		arg_48_0:showBubble(function()
			local var_49_0 = arg_48_0
			local var_49_1 = var_0.emit

			EducateMediator = var_2_10003

			var_49_1(var_49_0, var_2_10003.ON_SPECIAL_EVENT_TRIGGER, {
				id = var_48_2[1].id,
				callback = function()
					local var_50_0 = arg_48_0

					var_0.checkBubbleShow(var_50_0)

					EducateGuideSequence = var_0

					var_0.CheckGuide(arg_48_0.__cname, function()
						return
					end)

					return
				end
			})

			return
		end)
	elseif var_48_4:CheckFavor() then
		setActive = var_3

		local var_48_7 = arg_48_0.bubbleBtn

		var_3(var_5.Find(var_48_7, "Text"), false)

		setActive = var_3

		local var_48_8 = arg_48_0.bubbleBtn

		var_3(var_5.Find(var_48_8, "Image"), true)
		arg_48_0:showBubble(function()
			local var_52_0 = arg_48_0
			local var_52_1 = var_0.emit

			EducateMediator = var_2_10003

			var_52_1(var_52_0, var_2_10003.ON_UPGRADE_FAVOR, function()
				local var_53_0 = arg_48_0

				var_0.checkBubbleShow(var_53_0)

				EducateGuideSequence = var_0

				var_0.CheckGuide(arg_48_0.__cname, function()
					return
				end)

				return
			end)

			return
		end)
	else
		setActive = var_3

		var_3(arg_48_0.bubbleTF, false)

		removeOnButton = var_3

		var_3(arg_48_0.bubbleTF)
	end

	return
end

function var_0_1.updateResPanel(arg_55_0)
	local var_55_0 = arg_55_0.resPanel

	var_1.Flush(var_55_0)

	return
end

function var_0_1.updateArchivePanel(arg_56_0)
	local var_56_0 = arg_56_0.archivePanel

	var_1.Flush(var_56_0)

	return
end

function var_0_1.showArchivePanel(arg_57_0)
	local var_57_0 = arg_57_0.archivePanel

	var_1.showPanel(var_57_0)

	return
end

function var_0_1.updateDatePanel(arg_58_0)
	local var_58_0 = arg_58_0.datePanel

	var_1.Flush(var_58_0)
	arg_58_0:updateUnlockBtns()

	return
end

function var_0_1.updateUnlockBtns(arg_59_0)
	EducateHelper = var_1_10001

	local var_59_0 = var_1_10001.IsSystemUnlock

	EducateConst = var_1_10003

	local var_59_1 = var_59_0(var_1_10003.SYSTEM_MEMORY)

	setActive = var_1_10002

	local var_59_2 = arg_59_0.bookBtn

	var_1_10002(var_4.Find(var_59_2, "lock"), not var_59_1)

	setActive = var_1_10002

	local var_59_3 = arg_59_0.bookBtn

	var_1_10002(var_4.Find(var_59_3, "unlock"), var_59_1)

	EducateHelper = var_1_10002

	local var_59_4 = var_1_10002.IsSystemUnlock

	EducateConst = var_4

	local var_59_5 = var_59_4(var_4.SYSTEM_BAG)

	setActive = var_3

	local var_59_6 = arg_59_0.bagBtn

	var_3(var_5.Find(var_59_6, "lock"), not var_59_5)

	setActive = var_3

	local var_59_7 = arg_59_0.bagBtn

	var_3(var_5.Find(var_59_7, "unlock"), var_59_5)

	EducateHelper = var_3

	local var_59_8 = var_3.IsSystemUnlock

	EducateConst = var_5

	local var_59_9 = var_59_8(var_5.SYSTEM_FAVOR_AND_MIND)

	setActive = var_4

	local var_59_10 = arg_59_0.mindBtn

	var_4(var_6.Find(var_59_10, "lock"), not var_59_9)

	setActive = var_4

	local var_59_11 = arg_59_0.mindBtn

	var_4(var_6.Find(var_59_11, "unlock"), var_59_9)

	setActive = var_4

	var_4(arg_59_0.favorBtn, var_59_9)

	return
end

function var_0_1.updateMindTip(arg_60_0)
	setActive = var_1_10001

	local var_60_0 = arg_60_0.mindBtn
	local var_60_1 = var_3.Find(var_60_0, "unlock/tip")

	getProxy = var_1_10004
	EducateProxy = var_6

	local var_60_2 = var_1_10004(var_6)
	local var_60_3 = var_4.GetTaskProxy(var_60_2)

	var_1_10001(var_60_1, var_4.IsShowMindTasksTip(var_60_3))

	return
end

function var_0_1.updateWeekDay(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0.datePanel

	var_2.UpdateWeekDay(var_61_0, arg_61_1)

	return
end

function var_0_1.updateFavorBtn(arg_62_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_62_0 = var_1_10001(var_1_10003)
	local var_62_1 = var_1.GetCharData(var_62_0)
	local var_62_2 = var_1.GetFavor(var_62_1)

	setText = var_62_0

	var_62_0(arg_62_0.favorLvTF, var_62_2.lv)

	local var_62_3 = var_1:GetFavorMaxLv()

	setActive = var_62_1

	var_62_1(arg_62_0.favorMaxTF, var_62_2.lv == var_62_3)

	return
end

function var_0_1.updateTargetPanel(arg_63_0)
	local var_63_0 = arg_63_0.targetPanel

	var_1.Flush(var_63_0)

	return
end

function var_0_1.updateBottomPanel(arg_64_0)
	local var_64_0 = arg_64_0.bottomPanel

	var_1.Flush(var_64_0)

	return
end

function var_0_1.updatePaintingUI(arg_65_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_65_0 = var_1_10001(var_1_10003)
	local var_65_1 = var_1.GetCharData(var_65_0)

	arg_65_0.bgName = var_1.GetBGName(var_65_1)
	arg_65_0.paintingName = var_1:GetPaintingName()

	local var_65_2, var_65_3 = var_1:GetMainDialogueInfo()

	arg_65_0.faceList = var_65_3
	arg_65_0.wordList = var_65_2
	LoadSprite = var_65_2

	local var_65_4 = var_65_2("bg/" .. arg_65_0.bgName)

	setImageSprite = var_65_3

	var_65_3(arg_65_0.bgTF, var_65_4, false)

	setPaintingPrefab = var_65_3

	var_65_3(arg_65_0.paintTF, arg_65_0.paintingName, "yangcheng")

	return
end

function var_0_1.ShowDialogue(arg_66_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_66_0.dialogueTF) then
		return
	end

	math = var_1

	local var_66_0 = var_1.random(#arg_66_0.wordList)

	pg = var_1_10002

	local var_66_1 = var_1_10002.child_word[arg_66_0.wordList[var_66_0]].word

	if not arg_66_0.callName then
		getProxy = var_3
		EducateProxy = var_1_10005

		local var_66_2 = var_3(var_1_10005)
		local var_66_3 = var_3.GetCharData(var_66_2)

		arg_66_0.callName = var_3.GetCallName(var_66_3)
	end

	string = var_3

	local var_66_4 = var_3.gsub(var_66_1, "$1", arg_66_0.callName)

	setText = var_3

	var_3(arg_66_0.dialogueContent, var_66_4)

	GetSpriteFromAtlas = var_3

	local var_66_5 = var_3("paintingface/" .. arg_66_0.paintingName, arg_66_0.faceList[var_66_0])
	local var_66_6 = arg_66_0.paintTF
	local var_66_7 = var_4.Find(var_66_6, "fitter")
	local var_66_8 = var_4.GetChild(var_66_7, 0)

	if var_4.Find(var_66_8, "face") and var_66_5 then
		setImageSprite = var_5

		var_5(var_4, var_66_5)

		setActive = var_5

		var_5(var_4, true)
	end

	local var_66_9 = arg_66_0.dialogueTF

	Vector3 = var_66_8
	var_66_9.localScale = var_66_8.zero
	setActive = var_66_9

	var_66_9(arg_66_0.dialogueTF, true)

	LeanTween = var_66_9

	local var_66_10 = var_66_9.scale
	local var_66_11 = arg_66_0.dialogueTF

	Vector3 = var_8

	local var_66_12 = var_66_10(var_66_11, var_8.one, 0.3)
	local var_66_13 = var_5.setEase

	LeanTweenType = var_8

	local var_66_14 = var_66_13(var_66_12, var_8.easeOutBack)
	local var_66_15 = var_5.setOnComplete

	System = var_8

	var_66_15(var_66_14, var_8.Action(function()
		LeanTween = var_2_10000

		local var_67_0 = var_2_10000.scale
		local var_67_1 = arg_66_0.dialogueTF

		Vector3 = var_2_10003

		local var_67_2 = var_67_0(var_67_1, var_2_10003.zero, 0.3)
		local var_67_3 = var_0.setEase

		LeanTweenType = var_3

		local var_67_4 = var_67_3(var_67_2, var_3.easeInBack)
		local var_67_5 = var_0.setDelay(var_67_4, 3)
		local var_67_6 = var_0.setOnComplete

		System = var_3

		var_67_6(var_67_5, var_3.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_66_0.dialogueTF, false)

			if var_0 then
				setActive = var_0

				var_0(var_0, false)
			end

			return
		end))

		return
	end))

	return
end

function var_0_1.updateNewTips(arg_69_0)
	arg_69_0:updateBookNewTip()
	arg_69_0:updateMindNewTip()

	return
end

function var_0_1.updateBookNewTip(arg_70_0)
	underscore = var_1_10001

	local var_70_0 = var_1_10001.any

	pg = var_1_10003

	local var_70_1 = var_70_0(var_1_10003.child_memory.all, function(arg_71_0)
		EducateTipHelper = var_2_10001

		local var_71_0 = var_2_10001.IsShowNewTip

		EducateTipHelper = var_2_10003

		return var_71_0(var_2_10003.NEW_MEMORY, arg_71_0)
	end)

	EducateTipHelper = var_1_10002

	local var_70_2 = var_1_10002.IsShowNewTip

	EducateTipHelper = var_4

	local var_70_3 = var_70_2(var_4.NEW_POLAROID)

	setActive = var_3

	local var_70_4 = arg_70_0.bookBtn

	var_3(var_5.Find(var_70_4, "unlock/new"), var_70_1 or var_70_3)

	return
end

function var_0_1.updateMindNewTip(arg_72_0)
	setActive = var_1_10001

	local var_72_0 = arg_72_0.mindBtn
	local var_72_1 = var_3.Find(var_72_0, "unlock/new")

	EducateTipHelper = var_1_10004

	local var_72_2 = var_1_10004.IsShowNewTip

	EducateTipHelper = var_6

	var_1_10001(var_72_1, var_72_2(var_6.NEW_MIND_TASK))

	return
end

function var_0_1.FlushView(arg_73_0)
	local var_73_0 = arg_73_0.datePanel

	var_1.Flush(var_73_0)

	local var_73_1 = arg_73_0.favorPanel

	var_1.Flush(var_73_1)

	local var_73_2 = arg_73_0.resPanel

	var_1.Flush(var_73_2)

	local var_73_3 = arg_73_0.targetPanel

	var_1.Flush(var_73_3)

	local var_73_4 = arg_73_0.bottomPanel

	var_1.Flush(var_73_4)

	local var_73_5 = arg_73_0.archivePanel

	var_1.Flush(var_73_5)
	arg_73_0:updatePaintingUI()
	arg_73_0:updateUnlockBtns()
	arg_73_0:updateNewTips()
	arg_73_0:updateMindTip()
	arg_73_0:updateFavorBtn()
	arg_73_0:SeriesCheck()

	return
end

function var_0_1.onBackPressed(arg_74_0)
	local var_74_0 = arg_74_0
	local var_74_1 = arg_74_0.emit
	local var_74_2 = var_0_1.EDUCATE_GO_SCENE

	SCENE = var_1_10005

	var_74_1(var_74_0, var_74_2, var_1_10005.NEW_EDUCATE_SELECT, {
		isTb1 = true
	})

	return
end

function var_0_1.willExit(arg_75_0)
	arg_75_0.contextData.isMainEnter = nil

	local var_75_0 = arg_75_0.datePanel

	var_1.Destroy(var_75_0)

	arg_75_0.datePanel = nil

	local var_75_1 = arg_75_0.favorPanel

	var_1.Destroy(var_75_1)

	arg_75_0.favorPanel = nil

	local var_75_2 = arg_75_0.resPanel

	var_1.Destroy(var_75_2)

	arg_75_0.resPanel = nil

	local var_75_3 = arg_75_0.topPanel

	var_1.Destroy(var_75_3)

	arg_75_0.topPanel = nil

	local var_75_4 = arg_75_0.targetPanel

	var_1.Destroy(var_75_4)

	arg_75_0.targetPanel = nil

	local var_75_5 = arg_75_0.bottomPanel

	var_1.Destroy(var_75_5)

	arg_75_0.bottomPanel = nil

	local var_75_6 = arg_75_0.archivePanel

	var_1.Destroy(var_75_6)

	arg_75_0.archivePanel = nil
	LeanTween = var_1

	if var_1.isTweening(arg_75_0.dialogueTF) then
		LeanTween = var_1

		var_1.cancel(arg_75_0.dialogueTF)
	end

	arg_75_0:UnOverlayPanel(arg_75_0.blurPanel, arg_75_0._tf)

	return
end

return var_0_1
