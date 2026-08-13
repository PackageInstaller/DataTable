class = var_0_10000

local var_0_0 = "CommanderCatScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.MODE_VIEW = 1
var_0_1.MODE_SELECT = 2
var_0_1.SELECT_MODE_SINGLE = 1
var_0_1.SELECT_MODE_MULTI = 2
var_0_1.PAGE_PLAY = 1
var_0_1.PAGE_TALENT = 2
var_0_1.PAGE_DOCK = 3
var_0_1.FLEET_TYPE_COMMON = 1
var_0_1.FLEET_TYPE_ACTBOSS = 2
var_0_1.FLEET_TYPE_HARD_CHAPTER = 3
var_0_1.FLEET_TYPE_CHALLENGE = 4
var_0_1.FLEET_TYPE_GUILDBOSS = 5
var_0_1.FLEET_TYPE_WORLD = 6
var_0_1.FLEET_TYPE_BOSSRUSH = 7
var_0_1.FLEET_TYPE_LIMIT_CHALLENGE = 8
var_0_1.FLEET_TYPE_BOSSSINGLE = 9
var_0_1.FLEET_TYPE_BOSSSINGLE_VARIABLE = 10
var_0_1.EVENT_SELECTED = "CommanderCatScene:EVENT_SELECTED"
var_0_1.EVENT_BACK = "CommanderCatScene:EVENT_BACK"
var_0_1.EVENT_FOLD = "CommanderCatScene:EVENT_FOLD"
var_0_1.EVENT_PREV_ONE = "CommanderCatScene:EVENT_PREV_ONE"
var_0_1.EVENT_NEXT_ONE = "CommanderCatScene:EVENT_NEXT_ONE"
var_0_1.EVENT_CLOSE_DESC = "CommanderCatScene:EVENT_CLOSE_DESC"
var_0_1.EVENT_OPEN_DESC = "CommanderCatScene:EVENT_OPEN_DESC"
var_0_1.EVENT_UPGRADE = "CommanderCatScene:EVENT_UPGRADE"
var_0_1.EVENT_QUICKLY_TOOL = "CommanderCatScene:EVENT_QUICKLY_TOOL"
var_0_1.EVENT_SWITCH_PAGE = "CommanderCatScene:EVENT_SWITCH_PAGE"
var_0_1.EVENT_PREVIEW_PLAY = "CommanderCatScene:EVENT_PREVIEW_PLAY"
var_0_1.EVENT_PREVIEW = "CommanderCatScene:EVENT_PREVIEW"
var_0_1.EVENT_PREVIEW_REVERSE = "CommanderCatScene:EVENT_PREVIEW_REVERSE"
var_0_1.EVENT_PREVIEW_ADDITION = "CommanderCatScene:EVENT_PREVIEW_ADDITION"
var_0_1.MSG_RESERVE_BOX = "CommanderCatScene:MSG_RESERVE_BOX"
var_0_1.MSG_QUICKLY_FINISH_TOOL_ERROR = "CommanderCatScene:MSG_QUICKLY_FINISH_TOOL_ERROR"
var_0_1.MSG_UPGRADE = "CommanderCatScene:MSG_UPGRADE"
var_0_1.MSG_LOCK = "CommanderCatScene:MSG_LOCK"
var_0_1.MSG_RENAME = "CommanderCatScene:MSG_RENAME"
var_0_1.MSG_FETCH_TALENT_LIST = "CommanderCatScene:MSG_FETCH_TALENT_LIST"
var_0_1.MSG_LEARN_TALENT = "CommanderCatScene:MSG_LEARN_TALENT"
var_0_1.MSG_UPDATE = "CommanderCatScene:MSG_UPDATE"
var_0_1.MSG_HOME_TIP = "CommanderCatScene:MSG_HOME_TIP"
var_0_1.MSG_BUILD = "CommanderCatScene:MSG_BUILD"
var_0_1.MSG_OPEN_BOX = "CommanderCatScene:MSG_OPEN_BOX"
var_0_1.MSG_BATCH_BUILD = "CommanderCatScene:MSG_BATCH_BUILD"
var_0_1.MSG_RES_UPDATE = "CommanderCatScene:MSG_RES_UPDATE"

function var_0_1.getUIName(arg_1_0)
	return "CommanderCatUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bgTF = var_1.Find(var_2_0, "background")

	local var_2_1 = arg_2_0.bgTF
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.bgImg = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.paintingTF = var_1.Find(var_2_3, "painting/frame")

	local var_2_4 = arg_2_0._tf

	arg_2_0.blurPanel = var_1.Find(var_2_4, "blur_panel")
	findTF = var_1
	arg_2_0.backBtn = var_1(arg_2_0.blurPanel, "top/back_btn")
	findTF = var_1
	arg_2_0.topPanel = var_1(arg_2_0.blurPanel, "top")
	findTF = var_1
	arg_2_0.pageContainer = var_1(arg_2_0.blurPanel, "pages")
	findTF = var_1
	arg_2_0.leftPanel = var_1(arg_2_0.blurPanel, "left_panel")
	findTF = var_1
	arg_2_0.eyeBtn = var_1(arg_2_0.leftPanel, "eye")
	findTF = var_1
	arg_2_0.helpBtn = var_1(arg_2_0.leftPanel, "help_btn")

	local var_2_5 = {}
	local var_2_6 = var_0_1.PAGE_PLAY

	findTF = var_3
	var_2_5[var_2_6] = var_3(arg_2_0._tf, "blur_panel/top/title/play")

	local var_2_7 = var_0_1.PAGE_TALENT

	findTF = var_3
	var_2_5[var_2_7] = var_3(arg_2_0._tf, "blur_panel/top/title/talent")

	local var_2_8 = var_0_1.PAGE_DOCK

	findTF = var_3
	var_2_5[var_2_8] = var_3(arg_2_0._tf, "blur_panel/top/title/Text")
	arg_2_0.titles = var_2_5

	local var_2_9 = {}
	local var_2_10 = var_0_1.PAGE_PLAY

	findTF = var_3
	var_2_9[var_2_10] = var_3(arg_2_0.leftPanel, "toggles/play")

	local var_2_11 = var_0_1.PAGE_TALENT

	findTF = var_3
	var_2_9[var_2_11] = var_3(arg_2_0.leftPanel, "toggles/talent")

	local var_2_12 = var_0_1.PAGE_DOCK

	findTF = var_3
	var_2_9[var_2_12] = var_3(arg_2_0.leftPanel, "toggles/detail")
	arg_2_0.toggles = var_2_9

	local var_2_13 = {}
	local var_2_14 = var_0_1.PAGE_PLAY

	CommanderCatPlayPage = var_3
	var_2_13[var_2_14] = var_3.New(arg_2_0.pageContainer, arg_2_0.event, arg_2_0.contextData)

	local var_2_15 = var_0_1.PAGE_TALENT

	CommanderCatTalentPage = var_3
	var_2_13[var_2_15] = var_3.New(arg_2_0.pageContainer, arg_2_0.event, arg_2_0.contextData)

	local var_2_16 = var_0_1.PAGE_DOCK

	CommanderCatDockPage = var_3
	var_2_13[var_2_16] = var_3.New(arg_2_0.pageContainer, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.pages = var_2_13
	CommanderDetailPage = var_2_13
	arg_2_0.detailPage = var_2_13.New(arg_2_0.pageContainer, arg_2_0.event, arg_2_0.contextData)

	local var_2_17 = arg_2_0.contextData

	CommanderMsgBoxPage = var_2

	local var_2_18 = var_2.New

	pg = var_3
	var_2_17.msgBox = var_2_18(var_3.UIMgr.GetInstance().OverlayMain, arg_2_0.event)

	local var_2_19 = arg_2_0.contextData

	CommanderTreePage = var_2

	local var_2_20 = var_2.New

	pg = var_3
	var_2_19.treePanel = var_2_20(var_3.UIMgr.GetInstance().OverlayMain, arg_2_0.event)
	CommanderPaintingUtil = var_2_19
	arg_2_0.commanderPaintingUtil = var_2_19.New(arg_2_0.paintingTF)

	local var_2_21 = {}

	findTF = var_2

	local var_2_22 = var_2(arg_2_0.blurPanel, "top/res/1/Text")
	local var_2_23 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	var_2_21[1] = var_2_23(var_2_22, var_4(var_5))
	findTF = var_2

	local var_2_24 = var_2(arg_2_0.blurPanel, "top/res/2/Text")
	local var_2_25 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	var_2_21[2] = var_2_25(var_2_24, var_4(var_5))
	findTF = var_2

	local var_2_26 = var_2(arg_2_0.blurPanel, "top/res/3/Text")
	local var_2_27 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	var_2_21[3] = var_2_27(var_2_26, var_4(var_5))
	arg_2_0.resources = var_2_21
	findTF = var_2_21

	local var_2_28 = var_2_21(arg_2_0.blurPanel, "top/res/gold/Text")
	local var_2_29 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.goldTxt = var_2_29(var_2_28, var_3(var_4))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		if arg_3_0.pageType == var_0_1.PAGE_PLAY or arg_3_0.pageType == var_0_1.PAGE_TALENT then
			triggerButton = var_0

			var_0(arg_3_0.toggles[var_0_1.PAGE_DOCK])
		else
			local var_4_0 = arg_3_0

			var_0.emit(var_4_0, var_0_1.ON_BACK)
		end

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.helpBtn

	local function var_3_5()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_5_2.type = var_2_10003
		pg = var_2_10003
		var_5_2.helps = var_2_10003.gametip.help_commander_info.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.eyeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Fold(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	addSlip = var_1_10001
	SLIP_TYPE_HRZ = var_3_6

	var_1_10001(var_3_6, arg_3_0.bgTF, function()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		CommanderCatScene = var_2_10002

		var_7_1(var_7_0, var_2_10002.EVENT_PREV_ONE, arg_3_0.selectedCommander.id)

		return
	end, function()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		CommanderCatScene = var_2_10002

		var_8_1(var_8_0, var_2_10002.EVENT_NEXT_ONE, arg_3_0.selectedCommander.id)

		return
	end)

	local var_3_9 = arg_3_0.contextData
	local var_3_10

	if not arg_3_0.contextData.mode then
		var_3_10 = var_0_1.MODE_VIEW
	end

	var_3_9.mode = var_3_10

	arg_3_0:RegisterEvent()
	arg_3_0:UpdateStyle()
	arg_3_0:UpdateResources()
	arg_3_0:UpdateGold()
	arg_3_0:UpdateToggles()

	triggerButton = var_1

	var_1(arg_3_0.toggles[var_0_1.PAGE_DOCK])

	setActive = var_1

	var_1(arg_3_0.toggles[var_0_1.PAGE_DOCK], false)

	return
end

function var_0_1.RegisterEvent(arg_9_0)
	arg_9_0:bind(var_0_1.EVENT_SELECTED, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_9_0

		var_3.UpdateMainView(var_10_0, arg_10_1, arg_10_2)

		return
	end)
	arg_9_0:bind(var_0_1.EVENT_BACK, function(arg_11_0)
		local var_11_0 = arg_9_0

		var_1.emit(var_11_0, var_0_1.ON_BACK)

		return
	end)
	arg_9_0:bind(var_0_1.MSG_RESERVE_BOX, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_9_0

		var_2.UpdateResources(var_12_0)

		local var_12_1 = arg_9_0

		var_2.UpdateGold(var_12_1)

		return
	end)
	arg_9_0:bind(var_0_1.MSG_RES_UPDATE, function(arg_13_0)
		local var_13_0 = arg_9_0

		var_1.UpdateGold(var_13_0)

		return
	end)
	arg_9_0:bind(var_0_1.MSG_BUILD, function(arg_14_0)
		local var_14_0 = arg_9_0

		var_1.UpdateResources(var_14_0)

		return
	end)

	return
end

function var_0_1.UpdateStyle(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.helpBtn, var_0_1.MODE_VIEW == arg_15_0.contextData.mode)

	if arg_15_0.contextData.mode == var_0_1.MODE_SELECT then
		if arg_15_0.contextData.maxCount > 1 then
			setActive = var_1

			var_1(arg_15_0.topPanel, false)

			onButton = var_1

			local var_15_0 = arg_15_0

			go = var_3

			local var_15_1 = var_3(arg_15_0.bgTF)

			local function var_15_2()
				local var_16_0 = arg_15_0

				var_0.emit(var_16_0, var_0_1.ON_BACK)

				return
			end

			SOUND_BACK = var_1_10005

			var_1(var_15_0, var_15_1, var_15_2, var_1_10005)
		end

		setActive = var_1

		var_1(arg_15_0.leftPanel, false)
	end

	return
end

function var_0_1.UpdateResources(arg_17_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = var_1.getPools(var_17_0)

	pairs = var_17_0

	for iter_17_0, iter_17_1 in var_17_0(var_17_1) do
		if arg_17_0.resources[iter_17_1.id] then
			var_7.text = iter_17_1:getItemCount()
		end
	end

	return
end

function var_0_1.UpdateGold(arg_18_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)
	local var_18_1 = var_1.getRawData(var_18_0)

	arg_18_0.goldTxt.text = var_18_1.gold

	return
end

function var_0_1.UpdateToggles(arg_19_0)
	pairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.toggles) do
		onButton = var_1_10006

		local var_19_0 = arg_19_0
		local var_19_1 = iter_19_1

		local function var_19_2()
			if arg_19_0.pageType then
				setActive = var_0

				local var_20_0 = arg_19_0.toggles[arg_19_0.pageType]

				var_0(var_1.Find(var_20_0, "Image"), false)
			end

			local var_20_1 = arg_19_0

			var_0.SwitchPage(var_20_1, iter_19_0)

			setActive = var_0

			local var_20_2 = iter_19_1

			var_0(var_1.Find(var_20_2, "Image"), true)

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_19_0, var_19_1, var_19_2, var_1_10010)
	end

	return
end

function var_0_1.SwitchPage(arg_21_0, arg_21_1)
	if (arg_21_1 == var_0_1.PAGE_PLAY or arg_21_1 == var_0_1.PAGE_TALENT) and not arg_21_0.selectedCommander then
		return
	end

	if arg_21_1 == var_0_1.PAGE_PLAY and arg_21_0.selectedCommander.inBattle then
		pg = var_2

		local var_21_0 = var_2.TipsMgr.GetInstance()
		local var_21_1 = var_2.ShowTips

		i18n = var_1_10004

		var_21_1(var_21_0, var_1_10004("commander_is_in_battle"))

		return
	end

	if arg_21_0.pageType then
		local var_21_2 = arg_21_0.pages[arg_21_0.pageType]

		if var_2.GetLoaded(var_21_2) then
			var_2:Hide()
		end

		setActive = var_3

		var_3(arg_21_0.titles[arg_21_0.pageType], false)
	end

	local var_21_3 = arg_21_0.pages[arg_21_1]

	if arg_21_1 == var_0_1.PAGE_DOCK then
		var_21_3:ExecuteAction("Show")
	else
		var_21_3:ExecuteAction("Show", arg_21_0.selectedCommander)
	end

	setActive = var_3

	var_3(arg_21_0.titles[arg_21_1], true)
	arg_21_0:CheckFirstHelp(arg_21_1)

	arg_21_0.pageType = arg_21_1

	arg_21_0:emit(var_0_1.EVENT_SWITCH_PAGE, arg_21_1)

	return
end

function var_0_1.CheckFirstHelp(arg_22_0, arg_22_1)
	if arg_22_1 == var_0_1.PAGE_PLAY then
		checkFirstHelpShow = var_2

		var_2("help_commander_play")
	elseif arg_22_1 == var_0_1.PAGE_TALENT then
		checkFirstHelpShow = var_2

		var_2("help_commander_ability")
	end

	return
end

function var_0_1.UpdateMainView(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_2 and arg_23_0.selectedCommander and arg_23_1.id == arg_23_0.selectedCommander.id then
		return
	end

	local var_23_0 = arg_23_1:getPainting()

	if not arg_23_0.paintingName or var_23_0 ~= arg_23_0.paintingName then
		arg_23_0.paintingName = var_23_0

		arg_23_0:ReturnCommanderPainting()

		setCommanderPaintingPrefab = var_4

		var_4(arg_23_0.paintingTF, var_23_0, "info")

		local var_23_1 = arg_23_0.paintingTF
		local var_23_2 = var_4.Find(var_23_1, "fitter")

		if var_4.GetChild(var_23_2, 0) then
			local var_23_3 = var_4
			local var_23_4 = var_4.GetComponent

			typeof = var_7
			Image = var_1_10008
			var_23_4(var_23_3, var_7(var_1_10008)).raycastTarget = false
		end
	end

	local var_23_5 = arg_23_1:getConfig("bg")

	if arg_23_0.bgName ~= var_23_5 then
		LoadSpriteAsync = var_5

		var_5("bg/commander_bg_" .. var_23_5, function(arg_24_0)
			if arg_23_0.exited then
				return
			end

			arg_23_0.bgImg.sprite = arg_24_0

			return
		end)

		arg_23_0.bgName = var_23_5
	end

	local var_23_6 = arg_23_0.detailPage

	var_5.ExecuteAction(var_23_6, "Update", arg_23_1, arg_23_0.contextData.mode == var_0_1.MODE_SELECT)

	local var_23_7 = arg_23_1:getTalentPoint()

	if 0 < var_23_7 then
		setText = var_6

		local var_23_8 = arg_23_0.toggles[var_0_1.PAGE_TALENT]

		var_6(var_7.Find(var_23_8, "tip/Text"), var_23_7)
	end

	setActive = var_6

	local var_23_9 = arg_23_0.toggles[var_0_1.PAGE_TALENT]

	var_6(var_7.Find(var_23_9, "tip"), var_23_7 > 0)

	arg_23_0.selectedCommander = arg_23_1

	return
end

function var_0_1.ReturnCommanderPainting(arg_25_0)
	if arg_25_0.selectedCommander then
		retCommanderPaintingPrefab = var_1

		local var_25_0 = arg_25_0.paintingTF
		local var_25_1 = arg_25_0.selectedCommander

		var_1(var_25_0, var_3.getPainting(var_25_1))

		arg_25_0.selectedCommander = nil
	end

	return
end

function var_0_1.Fold(arg_26_0)
	if arg_26_0.doAnimation then
		return
	end

	arg_26_0.doAnimation = true

	local var_26_0 = arg_26_0.commanderPaintingUtil

	var_1.Fold(var_26_0)

	LeanTween = var_1

	local var_26_1 = var_1.moveX

	rtf = var_26_0

	var_26_1(var_26_0(arg_26_0.leftPanel), -300, 0.5)

	LeanTween = var_26_1

	local var_26_2 = var_26_1.moveY

	rtf = var_2

	local var_26_3 = var_26_2(var_2(arg_26_0.topPanel), 300, 0.5)
	local var_26_4 = var_1.setOnComplete

	System = var_3

	var_26_4(var_26_3, var_3.Action(function()
		arg_26_0.doAnimation = false

		return
	end))

	onButton = var_26_4

	local var_26_5 = arg_26_0
	local var_26_6 = arg_26_0.bgTF

	local function var_26_7()
		local var_28_0 = arg_26_0

		var_0.UnFold(var_28_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_26_4(var_26_5, var_26_6, var_26_7, var_1_10005)
	arg_26_0:emit(var_0_1.EVENT_FOLD, true)

	return
end

function var_0_1.UnFold(arg_29_0)
	if arg_29_0.doAnimation then
		return
	end

	arg_29_0.doAnimation = true
	removeOnButton = var_1

	var_1(arg_29_0.bgTF)

	local var_29_0 = arg_29_0.commanderPaintingUtil

	var_1.UnFold(var_29_0)

	LeanTween = var_1

	local var_29_1 = var_1.moveX

	rtf = var_29_0

	var_29_1(var_29_0(arg_29_0.leftPanel), 0, 0.5)

	LeanTween = var_29_1

	local var_29_2 = var_29_1.moveY

	rtf = var_2

	local var_29_3 = var_29_2(var_2(arg_29_0.topPanel), 0, 0.5)
	local var_29_4 = var_1.setOnComplete

	System = var_3

	var_29_4(var_29_3, var_3.Action(function()
		arg_29_0.doAnimation = false

		return
	end))
	arg_29_0:emit(var_0_1.EVENT_FOLD, false)

	return
end

function var_0_1.onBackPressed(arg_31_0)
	if arg_31_0.pageType and (arg_31_0.pageType == var_0_1.PAGE_PLAY or arg_31_0.pageType == var_0_1.PAGE_TALENT) then
		triggerButton = var_1

		var_1(arg_31_0.toggles[var_0_1.PAGE_DOCK])

		return
	end

	if arg_31_0.contextData.msgBox then
		local var_31_0 = arg_31_0.contextData.msgBox

		if var_1.GetLoaded(var_31_0) then
			local var_31_1 = arg_31_0.contextData.msgBox

			if var_1.isShowing(var_31_1) then
				local var_31_2 = arg_31_0.contextData.msgBox

				var_1.Hide(var_31_2)

				return
			end
		end
	end

	if arg_31_0.contextData.treePanel then
		local var_31_3 = arg_31_0.contextData.treePanel

		if var_1.GetLoaded(var_31_3) then
			local var_31_4 = arg_31_0.contextData.treePanel

			if var_1.isShowing(var_31_4) then
				local var_31_5 = arg_31_0.contextData.treePanel

				var_1.Hide(var_31_5)

				return
			end
		end
	end

	if arg_31_0.pageType and arg_31_0.pages[arg_31_0.pageType] and arg_31_0.pages[arg_31_0.pageType].CanBack and not var_1:CanBack() then
		return
	end

	if arg_31_0.detailPage then
		local var_31_6 = arg_31_0.detailPage

		if var_1.GetLoaded(var_31_6) and arg_31_0.detailPage.CanBack then
			local var_31_7 = arg_31_0.detailPage

			if not var_1.CanBack(var_31_7) then
				return false
			end
		end
	end

	var_0_1.super.onBackPressed(arg_31_0)

	return
end

function var_0_1.willExit(arg_32_0)
	arg_32_0:ReturnCommanderPainting()

	pairs = var_1

	for iter_32_0, iter_32_1 in var_1(arg_32_0.pages) do
		iter_32_1:Destroy()
	end

	arg_32_0.pages = {}

	if arg_32_0.detailPage then
		local var_32_0 = arg_32_0.detailPage

		var_1.Destroy(var_32_0)

		arg_32_0.detailPage = nil
	end

	if arg_32_0.contextData.msgBox then
		local var_32_1 = arg_32_0.contextData.msgBox

		var_1.Destroy(var_32_1)

		arg_32_0.contextData.msgBox = nil
	end

	if arg_32_0.contextData.treePanel then
		local var_32_2 = arg_32_0.contextData.treePanel

		var_1.Destroy(var_32_2)

		arg_32_0.contextData.treePanel = nil
	end

	return
end

return var_0_1
