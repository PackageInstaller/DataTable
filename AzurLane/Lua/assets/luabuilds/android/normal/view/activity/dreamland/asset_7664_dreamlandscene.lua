class = var_0_10000

local var_0_0 = "DreamlandScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.EVENT_SWITCH_TIME = "DreamlandScene:EVENT_SWITCH_TIME"
var_0_1.ON_DATA_UPDATE = "DreamlandScene:ON_DATA_UPDATE"
var_0_1.ON_SPRING_DATA_UPDATE = "DreamlandScene:ON_SPRING_DATA_UPDATE"
var_0_1.ON_SPRING_OP = "DreamlandScene:ON_SPRING_OP"

local var_0_2 = {
	DAY = 1,
	NIGHT = 3,
	DUSK = 2
}

function var_0_1.getThemeName(arg_1_0, arg_1_1)
	if arg_1_1 == var_0_2.DAY then
		return "DreamlandDay", "story-fantasyland-summer"
	elseif arg_1_1 == var_0_2.DUSK then
		return "DreamlandDusk", "story-island-soft"
	elseif arg_1_1 == var_0_2.NIGHT then
		return "DreamlandNight", "story-fantasyland-light"
	end

	return ""
end

function var_0_1.getUIName(arg_2_0)
	return "DreamlandUI"
end

function var_0_1.PlayBGM(arg_3_0)
	return
end

function var_0_1._PlayBGM(arg_4_0)
	if arg_4_0._bgm then
		arg_4_0:StopBgm()

		arg_4_0._bgm = nil
	end

	local var_4_0, var_4_1 = arg_4_0:getThemeName(arg_4_0.period)

	pg = var_3

	local var_4_2 = var_3.BgmMgr.GetInstance()

	var_3.Push(var_4_2, arg_4_0.__cname, var_4_1)

	arg_4_0._bgm = var_4_1

	return
end

function var_0_1.init(arg_5_0)
	GetOrAddComponent = var_1_10001

	local var_5_0 = arg_5_0._tf

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	arg_5_0.cg = var_1_10001(var_5_0, var_1_10003(var_1_10004))

	local var_5_1 = arg_5_0._tf

	arg_5_0.themeContainer = var_1.Find(var_5_1, "scrollrect/content")

	local var_5_2 = arg_5_0._tf

	arg_5_0.storyTpl = var_1.Find(var_5_2, "scrollrect/content/story")

	local var_5_3 = arg_5_0._tf

	arg_5_0.storyTplSub = var_1.Find(var_5_3, "scrollrect/content/story/tpl")

	local var_5_4 = arg_5_0.storyTpl
	local var_5_5 = var_1.Find(var_5_4, "tpl/Text")
	local var_5_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_5_0.storyTxt = var_5_6(var_5_5, var_3(var_1_10004))

	local var_5_7 = arg_5_0._tf

	arg_5_0.scrollContent = var_1.Find(var_5_7, "scrollrect/content")

	local var_5_8 = arg_5_0._tf

	arg_5_0.scrollrectTr = var_1.Find(var_5_8, "scrollrect")

	local var_5_9 = arg_5_0.scrollrectTr
	local var_5_10 = var_1.GetComponent

	typeof = var_3
	ScrollRect = var_1_10004
	arg_5_0.scrollrect = var_5_10(var_5_9, var_3(var_1_10004))

	local var_5_11 = arg_5_0._tf

	arg_5_0.timeBtn = var_1.Find(var_5_11, "adapt/time")

	local var_5_12 = arg_5_0._tf

	arg_5_0.maskTr = var_1.Find(var_5_12, "mask")
	DreamlandChatPage = var_1
	arg_5_0.chatPage = var_1.New(arg_5_0._tf, arg_5_0.event)
	DreamlandSwitcherPage = var_1
	arg_5_0.switcherPage = var_1.New(arg_5_0._tf, arg_5_0.event)
	DreamlandHandbookPage = var_1
	arg_5_0.handBookPage = var_1.New(arg_5_0._tf, arg_5_0.event)
	DreamlandHotSpringPage = var_1
	arg_5_0.hotSpringPage = var_1.New(arg_5_0._tf, arg_5_0.event)
	DreamlandSpinePlayer = var_1
	arg_5_0.spinePlayer = var_1.New()
	arg_5_0.pages = {
		arg_5_0.chatPage,
		arg_5_0.switcherPage,
		arg_5_0.handBookPage,
		arg_5_0.hotSpringPage
	}

	local var_5_13 = arg_5_0._tf

	arg_5_0.shipTpl = var_1.Find(var_5_13, "root/ship")

	local var_5_14 = arg_5_0._tf

	arg_5_0.handbookTip = var_1.Find(var_5_14, "adapt/handbook/tip")

	local var_5_15 = arg_5_0._tf

	arg_5_0.hotSpringTip = var_1.Find(var_5_15, "adapt/hotspring/tip")

	return
end

function var_0_1.InitData(arg_6_0)
	local var_6_0 = arg_6_0

	arg_6_0.period = arg_6_0.GetDefaultTheme(var_6_0)
	getProxy = var_1
	ActivityProxy = var_6_0

	local var_6_1 = var_1(var_6_0)
	local var_6_2 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_6_3 = var_6_2(var_6_1, var_1_10003.ACTIVITY_TYPE_DREAMLAND)

	getProxy = var_6_1
	ActivityProxy = var_3

	local var_6_4 = var_6_1(var_3)
	local var_6_5 = var_2.getActivityByType

	ActivityConst = var_1_10004

	local var_6_6 = var_6_5(var_6_4, var_1_10004.ACTIVITY_TYPE_HOTSPRING_2)

	assert = var_6_4

	var_6_4(var_6_3 and var_6_6)

	DreamlandData = var_6_4
	arg_6_0.gameData = var_6_4.New(var_6_3, var_6_6)
	arg_6_0.shipAgentList = {}

	return
end

function var_0_1.UpdateActivity(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.gameData then
		return
	end

	local var_7_0 = arg_7_0.gameData

	var_3.UpdateActivityData(var_7_0, arg_7_1)
	arg_7_0:emit(var_0_1.ON_DATA_UPDATE, {
		data = arg_7_0.gameData,
		cmd = arg_7_2
	})

	DreamlandData = var_3

	if arg_7_2 == var_3.OP_RECORD_EXPLORE then
		arg_7_0:InitExploreObjs()
	end

	arg_7_0:UpdateTip()

	return
end

function var_0_1.UpdateSpringActivity(arg_8_0, arg_8_1)
	if not arg_8_0.gameData then
		return
	end

	local var_8_0 = arg_8_0.gameData

	var_2.UpdateSpringActivityData(var_8_0, arg_8_1)
	arg_8_0:InitHotSpringCharacters()
	arg_8_0:UpdateTimeBtn()
	arg_8_0:UpdateTip()
	arg_8_0:emit(var_0_1.ON_SPRING_DATA_UPDATE, {
		data = arg_8_0.gameData
	})

	return
end

function var_0_1.didEnter(arg_9_0)
	arg_9_0:InitData()
	arg_9_0:SetUp(true)
	arg_9_0:EnableUpdate()
	arg_9_0:UpdateTip()
	arg_9_0:UpdateTimeBtn()

	return
end

function var_0_1.UpdateTip(arg_10_0)
	setActive = var_1_10001

	local var_10_0 = arg_10_0.handbookTip
	local var_10_1 = arg_10_0.gameData

	var_1_10001(var_10_0, var_3.ExistAnyMapOrExploreAward(var_10_1))

	setActive = var_1_10001

	var_1_10001(arg_10_0.hotSpringTip, false)

	return
end

function var_0_1.EnableUpdate(arg_11_0)
	if not arg_11_0.handle then
		UpdateBeat = var_1
		arg_11_0.handle = var_1:CreateListener(arg_11_0.Update, arg_11_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_11_0.handle)

	return
end

function var_0_1.DisableUpdate(arg_12_0)
	if arg_12_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_12_0.handle)
	end

	return
end

function var_0_1.SetUp(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.cg

	var_13_0.blocksRaycasts = false
	seriesAsync = var_13_0

	var_13_0({
		function(arg_14_0)
			local var_14_0 = arg_13_0

			var_1.SwitchTheme(var_14_0, arg_13_0.period, arg_13_1, arg_14_0)

			return
		end,
		function(arg_15_0)
			if not arg_13_1 then
				arg_15_0()

				return
			end

			local var_15_0 = arg_13_0

			var_1.GenPlayableStoryPoint(var_15_0, arg_15_0)

			return
		end,
		function(arg_16_0)
			local var_16_0 = arg_13_0

			var_1.InitThemeMask(var_16_0)

			local var_16_1 = arg_13_0

			var_1.InitExploreObjs(var_16_1)

			onNextTick = var_1

			var_1(arg_16_0)

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_13_0

			var_1.FocusStory(var_17_0, arg_17_0)

			return
		end,
		function(arg_18_0)
			local var_18_0 = arg_13_0

			var_1.InitHotSpringCharacters(var_18_0, arg_18_0)

			return
		end
	}, function()
		arg_13_0.isSetUp = true

		if arg_13_1 then
			local var_19_0 = arg_13_0

			var_0.RegisterEvent(var_19_0)
		end

		arg_13_0.cg.blocksRaycasts = true

		return
	end)

	return
end

function var_0_1.RegisterEvent(arg_20_0)
	arg_20_0:BindEvent()

	onButton = var_1

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0._tf
	local var_20_2 = var_3.Find(var_20_1, "adapt/back")

	local function var_20_3()
		local var_21_0 = arg_20_0
		local var_21_1 = var_0.emit

		BaseUI = var_2_10002

		var_21_1(var_21_0, var_2_10002.ON_BACK)

		return
	end

	SFX_PANEL = var_5

	var_1(var_20_0, var_20_2, var_20_3, var_5)

	onButton = var_1

	local var_20_4 = arg_20_0
	local var_20_5 = arg_20_0._tf
	local var_20_6 = var_3.Find(var_20_5, "adapt/home")

	local function var_20_7()
		local var_22_0 = arg_20_0
		local var_22_1 = var_0.emit

		BaseUI = var_2_10002

		var_22_1(var_22_0, var_2_10002.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_1(var_20_4, var_20_6, var_20_7, var_5)

	onButton = var_1

	local var_20_8 = arg_20_0
	local var_20_9 = arg_20_0._tf
	local var_20_10 = var_3.Find(var_20_9, "adapt/help")

	local function var_20_11()
		pg = var_2_10000

		local var_23_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_23_1 = var_0.ShowMsgBox
		local var_23_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_23_2.type = var_2_10003
		pg = var_2_10003
		var_23_2.helps = var_2_10003.gametip.dream_land_tip.tip

		var_23_1(var_23_0, var_23_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_20_8, var_20_10, var_20_11, var_5)

	onButton = var_1

	local var_20_12 = arg_20_0
	local var_20_13 = arg_20_0._tf
	local var_20_14 = var_3.Find(var_20_13, "adapt/handbook")

	local function var_20_15()
		local var_24_0 = arg_20_0.handBookPage

		var_0.ExecuteAction(var_24_0, "Show", arg_20_0.gameData)

		return
	end

	SFX_PANEL = var_5

	var_1(var_20_12, var_20_14, var_20_15, var_5)

	onButton = var_1

	local var_20_16 = arg_20_0
	local var_20_17 = arg_20_0._tf
	local var_20_18 = var_3.Find(var_20_17, "adapt/hotspring")

	local function var_20_19()
		local var_25_0 = arg_20_0.hotSpringPage

		var_0.ExecuteAction(var_25_0, "Show", arg_20_0.gameData)

		return
	end

	SFX_PANEL = var_5

	var_1(var_20_16, var_20_18, var_20_19, var_5)

	onButton = var_1

	local var_20_20 = arg_20_0
	local var_20_21 = arg_20_0.timeBtn

	local function var_20_22()
		local var_26_0 = arg_20_0.switcherPage

		var_0.ExecuteAction(var_26_0, "Show", arg_20_0.period)

		return
	end

	SFX_PANEL = var_5

	var_1(var_20_20, var_20_21, var_20_22, var_5)

	local var_20_23 = arg_20_0.gameData

	if not var_1.IsFirstEvent(var_20_23) then
		local var_20_24 = arg_20_0.gameData

		if var_1.IsLastEvent(var_20_24) then
			triggerButton = var_1

			var_1(arg_20_0.storyTpl)
		end

		return
	end
end

function var_0_1.UpdateTimeBtn(arg_27_0)
	local var_27_0 = arg_27_0.gameData
	local var_27_1 = var_1.IsFinishAllEvent(var_27_0)

	setActive = var_27_0

	var_27_0(arg_27_0.timeBtn, var_27_1)

	return
end

function var_0_1.BindEvent(arg_28_0)
	arg_28_0:bind(var_0_1.EVENT_SWITCH_TIME, function(arg_29_0, arg_29_1)
		if arg_28_0.period == arg_29_1 then
			return
		end

		arg_28_0.period = arg_29_1

		local var_29_0 = arg_28_0

		var_2.SetUp(var_29_0, false)

		return
	end)
	arg_28_0:bind(var_0_1.ON_SPRING_OP, function(arg_30_0)
		if arg_28_0.spinePlayer then
			local var_30_0 = arg_28_0.spinePlayer

			var_1.ClearEffects(var_30_0)
		end

		return
	end)

	return
end

function var_0_1.InitThemeMask(arg_31_0)
	if not arg_31_0.themeMask then
		return
	end

	local var_31_0 = arg_31_0.gameData
	local var_31_1 = var_1.FindUnlockMaps(var_31_0)

	DreamlandUtil = var_31_0

	local var_31_2 = var_31_0.List2Map(var_31_1, "id")
	local var_31_3 = arg_31_0.themeMask.transform

	var_3.SetAsLastSibling(var_31_3)

	eachChild = var_3

	var_3(arg_31_0.themeMask, function(arg_32_0)
		setActive = var_2_10001

		local var_32_0 = arg_32_0
		local var_32_1 = var_31_2

		tonumber = var_2_10004

		var_2_10001(var_32_0, var_32_1[var_2_10004(arg_32_0.name)] == nil)

		return
	end)

	return
end

function var_0_1.InitExploreObjs(arg_33_0)
	local var_33_0 = arg_33_0.gameData
	local var_33_1 = var_1.FindCanInteractionExploreObj(var_33_0)

	DreamlandUtil = var_33_0

	local var_33_2 = var_33_0.List2Map(var_33_1, "pic")

	eachChild = var_3

	var_3(arg_33_0.theme, function(arg_34_0)
		if arg_34_0.name ~= "bgs" then
			string = var_1

			local var_34_0 = var_1.split(arg_34_0.name, "#")
			local var_34_1 = var_33_2[var_34_0[1]] ~= nil
			local var_34_2 = arg_33_0

			var_4.EnableOrDisableInteraction(var_34_2, arg_34_0, var_2, var_34_1)
		end

		return
	end)

	return
end

function var_0_1.EnableOrDisableInteraction(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	removeOnButton = var_1_10004

	var_1_10004(arg_35_1)

	local var_35_0 = arg_35_0.spineAnimUIList[arg_35_1.name]
	local var_35_1 = arg_35_1
	local var_35_2 = arg_35_1.Find(var_35_1, "effect")

	if not arg_35_3 or not var_35_0 then
		if var_35_2 then
			setActive = var_35_1

			var_35_1(var_35_2, false)
		end

		return
	end

	onButton = var_35_1

	local var_35_3 = arg_35_0
	local var_35_4 = arg_35_1

	local function var_35_5()
		local var_36_0 = arg_35_0.spinePlayer

		var_0.Play(var_36_0, arg_35_0.theme, arg_35_1, arg_35_0.spineAnimUIList, arg_35_2)

		local var_36_1 = arg_35_0.gameData

		if var_0.ShouldShowChatTip(var_36_1, arg_35_2.id) then
			local var_36_2 = arg_35_0.chatPage

			var_0.ExecuteAction(var_36_2, "Show", arg_35_2)

			local var_36_3 = arg_35_0.gameData
			local var_36_4 = var_0.FindMapIdByExploreId(var_36_3, arg_35_2.id)

			assert = var_36_3

			var_36_3(var_36_4)

			local var_36_5 = arg_35_0
			local var_36_6 = var_1.emit

			DreamlandMediator = var_3

			local var_36_7 = var_3.RECORD_EXPLORE
			local var_36_8 = arg_35_0.gameData

			var_36_6(var_36_5, var_36_7, var_4.GetActivityId(var_36_8), var_36_4, arg_35_2.id)
		end

		return
	end

	SFX_PANEL = var_1_10010

	var_35_1(var_35_3, var_35_4, var_35_5, var_1_10010)

	if var_35_2 then
		setActive = var_35_1

		local var_35_6 = var_35_2
		local var_35_7 = arg_35_0.gameData

		var_35_1(var_35_6, var_8.ShouldShowChatTip(var_35_7, arg_35_2.id))
	end

	return
end

function var_0_1.GenPlayableStoryPoint(arg_37_0, arg_37_1)
	arg_37_0:ClearStoryPoint()

	local var_37_0 = arg_37_0.gameData

	if not var_2.FindPlayableStory(var_37_0) then
		arg_37_1()

		return
	end

	setActive = var_37_0

	var_37_0(arg_37_0.storyTplSub, false)

	setActive = var_37_0

	var_37_0(arg_37_0.storyTpl, true)

	local var_37_1 = arg_37_0.storyTpl

	Vector3 = var_4
	var_37_1.localPosition = var_4(var_2.pos.x, var_2.pos.y, 0)

	local var_37_2 = arg_37_0.storyTxt

	var_37_2.text = var_2.name
	onButton = var_37_2

	local var_37_3 = arg_37_0
	local var_37_4 = arg_37_0.storyTpl

	local function var_37_5()
		local var_38_0 = arg_37_0

		var_0.PlayStory(var_38_0, var_0)

		return
	end

	SFX_PANEL = var_7

	var_37_2(var_37_3, var_37_4, var_37_5, var_7)

	if arg_37_1 then
		arg_37_1()
	end

	return
end

function var_0_1.FocusStory(arg_39_0, arg_39_1)
	isActive = var_1_10002

	if not var_1_10002(arg_39_0.storyTpl) then
		arg_39_1()

		return
	end

	local var_39_0 = arg_39_0.storyTpl

	var_2.SetAsLastSibling(var_39_0)

	local var_39_1 = arg_39_0.scrollrect

	var_39_1.enabled = false
	DreamlandUtil = var_39_1

	local var_39_2 = var_39_1.CalcFocusPosition(arg_39_0.scrollContent, arg_39_0.scrollrectTr, arg_39_0.storyTpl.localPosition)

	LeanTween = var_3

	local var_39_3 = var_3.moveLocal(arg_39_0.scrollContent.gameObject, var_39_2, 0.5)
	local var_39_4 = var_3.setEase

	LeanTweenType = var_5

	local var_39_5 = var_39_4(var_39_3, var_5.easeOutExpo)
	local var_39_6 = var_3.setOnComplete

	System = var_5

	var_39_6(var_39_5, var_5.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_39_0.storyTplSub, true)

		arg_39_0.scrollrect.enabled = true

		arg_39_1()

		return
	end))

	return
end

function var_0_1.PlayStory(arg_41_0, arg_41_1)
	local var_41_0 = {}

	table = var_1_10003

	var_1_10003.insert(var_41_0, function(arg_42_0)
		pg = var_2_10001

		local var_42_0 = var_2_10001.NewStoryMgr.GetInstance()

		var_1.Play(var_42_0, arg_41_1.story, arg_42_0)

		return
	end)

	if arg_41_1.bg ~= arg_41_0.period then
		table = var_3

		var_3.insert(var_41_0, function(arg_43_0)
			local var_43_0 = arg_41_0

			var_1.GenPlayableStoryPoint(var_43_0, arg_43_0)

			return
		end)

		table = var_3

		var_3.insert(var_41_0, function(arg_44_0)
			arg_41_0.period = arg_41_1.bg

			local var_44_0 = arg_41_0

			var_1.SetUp(var_44_0, false)
			arg_44_0()

			return
		end)
	else
		table = var_3

		var_3.insert(var_41_0, function(arg_45_0)
			arg_41_0.cg.blocksRaycasts = false

			arg_45_0()

			return
		end)

		table = var_3

		var_3.insert(var_41_0, function(arg_46_0)
			local var_46_0 = arg_41_0

			var_1.PlayUnlockAnimation(var_46_0, arg_46_0)

			return
		end)

		table = var_3

		var_3.insert(var_41_0, function(arg_47_0)
			local var_47_0 = arg_41_0

			var_1.InitThemeMask(var_47_0)

			local var_47_1 = arg_41_0

			var_1.InitExploreObjs(var_47_1)

			local var_47_2 = arg_41_0

			var_1.GenPlayableStoryPoint(var_47_2, arg_47_0)

			return
		end)

		table = var_3

		var_3.insert(var_41_0, function(arg_48_0)
			local var_48_0 = arg_41_0

			var_1.FocusStory(var_48_0, arg_48_0)

			return
		end)

		table = var_3

		var_3.insert(var_41_0, function(arg_49_0)
			arg_41_0.cg.blocksRaycasts = true

			arg_49_0()

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_41_0, function()
		local var_50_0 = arg_41_0.gameData

		if var_0.IsLastEvent(var_50_0) then
			triggerButton = var_0

			var_0(arg_41_0.storyTpl)
		end

		return
	end)

	return
end

function var_0_1.PlayUnlockAnimation(arg_51_0, arg_51_1)
	arg_51_1()

	return
end

function var_0_1.ClearStoryPoint(arg_52_0)
	setActive = var_1_10001

	var_1_10001(arg_52_0.storyTpl, false)

	return
end

function var_0_1.SetUpSpine(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1
	local var_53_1 = arg_53_1.GetComponentsInChildren

	typeof = var_1_10004
	Spine = var_1_10005

	local var_53_2 = var_53_1(var_53_0, var_1_10004(var_1_10005.Unity.SkeletonGraphic))
	local var_53_3 = var_2.ToTable(var_53_2)
	local var_53_4 = {}

	ipairs = var_4

	for iter_53_0, iter_53_1 in var_4(var_53_3) do
		local var_53_5 = iter_53_1.gameObject

		GetOrAddComponent = var_1_10010

		local var_53_6 = var_53_5

		typeof = var_1_10012
		SpineAnimUI = var_1_10013
		var_1_10010 = var_1_10010(var_53_6, var_1_10012(var_1_10013))
		string = var_53_6

		local var_53_7 = var_53_6.split(var_53_5.gameObject.transform.parent.name, "#")

		var_1_10013 = arg_53_0.gameData
		var_1_10012 = var_1_10012.GetExploreSubType(var_1_10013, var_53_7[1])
		DreamlandUtil = var_1_10013
		var_1_10013 = var_1_10013.GetSpineNormalAction(var_1_10012)

		var_1_10010:SetAction(var_1_10013, 0)

		var_53_4[var_53_5.transform.parent.name] = var_1_10010
	end

	return var_53_4
end

function var_0_1.SwitchTheme(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = false

	if arg_54_0.cg.blocksRaycasts then
		arg_54_0.cg.blocksRaycasts = false
		var_54_0 = true
	end

	if arg_54_0:getThemeName(arg_54_1) == "" or arg_54_0.theme and arg_54_0.theme.name == var_5 then
		arg_54_3()

		return
	end

	arg_54_0:RecordTheme(arg_54_1)

	setActive = var_6

	var_6(arg_54_0.maskTr, true)

	seriesAsync = var_6

	var_6({
		function(arg_55_0)
			if arg_54_2 then
				arg_55_0()

				return
			end

			local var_55_0 = arg_54_0

			var_1.SwitchAnim(var_55_0, 0, 1, arg_55_0)

			return
		end,
		function(arg_56_0)
			local var_56_0 = arg_54_0

			var_1.LoadThemeMask(var_56_0, arg_56_0)

			return
		end,
		function(arg_57_0)
			local var_57_0 = arg_54_0

			var_1.UnloadTheme(var_57_0)

			local var_57_1 = arg_54_0

			var_1._PlayBGM(var_57_1, arg_54_0.period)

			local var_57_2 = arg_54_0

			var_1.LoadTheme(var_57_2, var_0, arg_57_0)

			return
		end,
		function(arg_58_0)
			if arg_54_2 then
				arg_58_0()

				return
			end

			local var_58_0 = arg_54_0

			var_1.SwitchAnim(var_58_0, 1, 0, arg_58_0)

			return
		end
	}, function()
		setActive = var_2_10000

		var_2_10000(arg_54_0.maskTr, false)

		if var_54_0 then
			arg_54_0.cg.blocksRaycasts = true
		end

		arg_54_3()

		return
	end)

	return
end

function var_0_1.SwitchAnim(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	LeanTween = var_1_10004

	local var_60_0 = var_1_10004.value(arg_60_0.maskTr.gameObject, arg_60_1, arg_60_2, 0.5)
	local var_60_1 = var_4.setOnUpdate

	System = var_6

	local var_60_2 = var_60_1(var_60_0, var_6.Action_float(function(arg_61_0)
		GetOrAddComponent = var_2_10001

		local var_61_0 = arg_60_0.maskTr

		typeof = var_2_10003
		CanvasGroup = var_2_10004
		var_2_10001(var_61_0, var_2_10003(var_2_10004)).alpha = arg_61_0

		return
	end))
	local var_60_3 = var_4.setOnComplete

	System = var_6

	var_60_3(var_60_2, var_6.Action(arg_60_3))

	return
end

function var_0_1.RecordTheme(arg_62_0, arg_62_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_62_0 = var_1_10002(var_1_10003)
	local var_62_1 = var_2.getRawData(var_62_0).id

	PlayerPrefs = var_62_0

	var_62_0.SetInt("dreamland_theme_id" .. var_62_1, arg_62_1)

	PlayerPrefs = var_3

	var_3.Save()

	return
end

function var_0_1.GetDefaultTheme(arg_63_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_63_0 = var_1_10001(var_1_10002)
	local var_63_1 = var_1.getRawData(var_63_0).id

	PlayerPrefs = var_63_0

	return (var_63_0.GetInt("dreamland_theme_id" .. var_63_1, 1))
end

function var_0_1.LoadThemeMask(arg_64_0, arg_64_1)
	if arg_64_0.themeMask then
		arg_64_1()

		return
	end

	local var_64_0 = arg_64_0.gameData

	if var_2.IsUnlockAll(var_64_0) then
		arg_64_1()

		return
	end

	PoolMgr = var_2

	local var_64_1 = var_2.GetInstance()

	var_2.GetUI(var_64_1, "DreamlandMask", true, function(arg_65_0)
		local var_65_0 = arg_64_0

		var_65_0.themeMask = arg_65_0
		setParent = var_65_0

		var_65_0(arg_65_0, arg_64_0.themeContainer)
		arg_64_1()

		return
	end)

	return
end

function var_0_1.UnLoadThemeMask(arg_66_0)
	if arg_66_0.themeMask then
		PoolMgr = var_1

		local var_66_0 = var_1.GetInstance()

		var_1.ReturnUI(var_66_0, "DreamlandMask", arg_66_0.themeMask)

		arg_66_0.themeMask = nil
	end

	return
end

function var_0_1.GetNodeInfoFromTheme(arg_67_0, arg_67_1)
	local var_67_0 = {}

	eachChild = var_1_10003
	tf = var_1_10004

	var_1_10003(var_1_10004(arg_67_1), function(arg_68_0)
		if arg_68_0.name ~= "bgs" then
			local var_68_0 = arg_68_0:GetSiblingIndex()
			local var_68_1 = arg_68_0.localPosition

			table = var_2_10003

			var_2_10003.insert(var_67_0, {
				tf = arg_68_0,
				position = var_68_1
			})
		end

		return
	end)

	table = var_1_10003

	var_1_10003.sort(var_67_0, function(arg_69_0, arg_69_1)
		return arg_69_0.position.y < arg_69_1.position.y
	end)

	return var_67_0
end

function var_0_1.LoadTheme(arg_70_0, arg_70_1, arg_70_2)
	PoolMgr = var_1_10003

	local var_70_0 = var_1_10003.GetInstance()

	var_3.GetUI(var_70_0, arg_70_1, true, function(arg_71_0)
		arg_70_0.theme = arg_71_0
		arg_70_0.theme.name = arg_70_1

		local var_71_0 = arg_70_0.spinePlayer

		var_1.Clear(var_71_0)

		local var_71_1 = arg_70_0
		local var_71_2 = arg_70_0

		var_71_1.spineAnimUIList = var_2.SetUpSpine(var_71_2, arg_71_0)

		local var_71_3 = arg_70_0
		local var_71_4 = arg_70_0

		var_71_3.themeNodeInfoList = var_2.GetNodeInfoFromTheme(var_71_4, arg_71_0)
		setParent = var_71_3

		var_71_3(arg_71_0, arg_70_0.themeContainer)

		pairs = var_71_3

		for iter_71_0, iter_71_1 in var_71_3(arg_70_0.shipAgentList) do
			setParent = var_2_10006

			var_2_10006(iter_71_1._tf, arg_71_0)
		end

		arg_70_2()

		return
	end)

	return
end

function var_0_1.UnloadTheme(arg_72_0)
	arg_72_0.isSetUp = false
	pairs = var_1

	for iter_72_0, iter_72_1 in var_1(arg_72_0.shipAgentList) do
		setParent = var_1_10006

		var_1_10006(iter_72_1._tf, arg_72_0._tf)

		local var_72_0 = iter_72_1._tf

		var_1_10006.SetAsFirstSibling(var_72_0)
	end

	if arg_72_0.theme then
		ipairs = var_1

		for iter_72_2, iter_72_3 in var_1(arg_72_0.spineAnimUIList) do
			iter_72_3:SetActionCallBack(nil)
		end

		PoolMgr = var_1

		local var_72_1 = var_1.GetInstance()

		var_1.ReturnUI(var_72_1, arg_72_0.theme.name, arg_72_0.theme)

		arg_72_0.theme = nil
	end

	arg_72_0.spineAnimUIList = {}
	arg_72_0.themeNodeInfoList = {}

	local var_72_2 = arg_72_0.spinePlayer

	var_1.Clear(var_72_2)

	return
end

function var_0_1.InitHotSpringCharacters(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0.gameData
	local var_73_1 = var_2.GetAllSpringShip(var_73_0)
	local var_73_2 = {}
	local var_73_3 = {}

	pairs = var_1_10005

	for iter_73_0, iter_73_1 in var_1_10005(var_73_1) do
		ipairs = var_1_10010

		for iter_73_2, iter_73_3 in var_1_10010(iter_73_1) do
			var_73_3[iter_73_3.id] = true
			table = var_15

			var_15.insert(var_73_2, function(arg_74_0)
				local var_74_0 = arg_73_0.gameData

				if var_1.MapId2MapGraph(var_74_0, iter_73_0) then
					local var_74_1 = arg_73_0

					var_74_0.InitHotSpringCharacter(var_74_1, iter_73_3, var_1, arg_74_0)
				else
					print = var_74_0

					var_74_0("不存在路径", iter_73_0)
					arg_74_0()
				end

				return
			end)
		end
	end

	arg_73_0:RemoveInvalidShips(var_73_3)

	seriesAsync = var_5

	var_5(var_73_2, arg_73_1)

	return
end

function var_0_1.RemoveInvalidShips(arg_75_0, arg_75_1)
	pairs = var_1_10002

	local var_75_0

	if not arg_75_0.shipAgentList then
		var_75_0 = {}
	end

	for iter_75_0, iter_75_1 in var_1_10002(var_75_0) do
		if not arg_75_1[iter_75_0] then
			iter_75_1:detach()

			Destroy = var_7

			var_7(iter_75_1._go)

			arg_75_0.shipAgentList[iter_75_0] = nil
		end
	end

	return
end

function var_0_1.InitHotSpringCharacter(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	if arg_76_0.shipAgentList[arg_76_1.id] then
		arg_76_3()

		return
	end

	cloneTplTo = var_4

	local var_76_0 = var_4(arg_76_0.shipTpl, arg_76_0.theme)

	NavalAcademyStudent = var_5

	local var_76_1 = var_5.New(var_76_0.gameObject)

	var_5.attach(var_76_1)

	local var_76_2 = var_5
	local var_76_3 = var_5.setPathFinder

	GraphPath = var_1_10008

	var_76_3(var_76_2, var_1_10008.New(arg_76_2))
	var_5:setCallBack(function(arg_77_0)
		return
	end, function()
		return
	end)
	var_5:updateStudent(arg_76_1, {})

	local var_76_4 = arg_76_0.shipAgentList

	var_76_4[arg_76_1.id] = var_5
	onNextTick = var_76_4

	var_76_4(arg_76_3)

	return
end

local function var_0_3(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0
	local var_79_1 = {}

	ipairs = var_1_10004

	for iter_79_0, iter_79_1 in var_1_10004(var_79_0) do
		if iter_79_1.position.y > arg_79_1.y then
			local var_79_2 = iter_79_1.tf
			local var_79_3 = var_9.GetSiblingIndex(var_79_2)

			table = var_79_2

			var_79_2.insert(var_79_1, var_79_3 + 1)
		end
	end

	table = var_4

	var_4.sort(var_79_1, function(arg_80_0, arg_80_1)
		return arg_80_1 < arg_80_0
	end)

	local var_79_4

	if not var_79_1[1] then
		var_79_4 = #arg_79_0
	end

	return var_79_4
end

function var_0_1.UpdateShipLayer(arg_81_0)
	local var_81_0

	if not arg_81_0.themeNodeInfoList then
		var_81_0 = {}
	end

	local var_81_1

	if not arg_81_0.shipAgentList then
		var_81_1 = {}
	end

	local var_81_2 = {}

	pairs = var_1_10004

	for iter_81_0, iter_81_1 in var_1_10004(var_81_1) do
		local var_81_3 = iter_81_1._tf.localPosition
		local var_81_4 = var_0_3(var_81_0, var_81_3)

		table = var_11

		var_11.insert(var_81_2, {
			pos = var_81_3,
			agent = iter_81_1,
			siblingIndex = var_81_4
		})

		local var_81_5 = iter_81_1._tf

		var_11.SetAsLastSibling(var_81_5)
	end

	table = var_4

	var_4.sort(var_81_2, function(arg_82_0, arg_82_1)
		if arg_82_0.siblingIndex == arg_82_1.siblingIndex then
			return arg_82_0.pos.y < arg_82_1.pos.y
		else
			return arg_82_0.siblingIndex > arg_82_1.siblingIndex
		end

		return
	end)

	ipairs = var_4

	for iter_81_2, iter_81_3 in var_4(var_81_2) do
		local var_81_6 = iter_81_3.agent._tf

		var_9.SetSiblingIndex(var_81_6, iter_81_3.siblingIndex)
	end

	return
end

local var_0_4 = 0

function var_0_1.Update(arg_83_0)
	if not arg_83_0.isSetUp then
		return
	end

	local var_83_0 = var_0_4

	Time = var_1_10002
	var_0_4 = var_83_0 + var_1_10002.deltaTime

	if var_0_4 > 0.3 then
		var_0_4 = 0

		arg_83_0:UpdateShipLayer()
	end

	return
end

function var_0_1.onBackPressed(arg_84_0)
	ipairs = var_1_10001

	for iter_84_0, iter_84_1 in var_1_10001(arg_84_0.pages) do
		if iter_84_1:isShowing() then
			iter_84_1:Hide()

			return
		end
	end

	var_0_1.super.onBackPressed(arg_84_0)

	return
end

function var_0_1.willExit(arg_85_0)
	arg_85_0.isSetUp = false

	arg_85_0:DisableUpdate()

	if arg_85_0.gameData then
		arg_85_0.gameData = nil
	end

	arg_85_0:UnLoadThemeMask()
	arg_85_0:UnloadTheme()
	arg_85_0:ClearStoryPoint()

	pairs = var_1

	local var_85_0

	if not arg_85_0.shipAgentList then
		var_85_0 = {}
	end

	for iter_85_0, iter_85_1 in var_1(var_85_0) do
		iter_85_1:detach()

		Destroy = var_6

		var_6(iter_85_1._go)
	end

	arg_85_0.shipAgentList = nil

	if arg_85_0.spinePlayer then
		local var_85_1 = arg_85_0.spinePlayer

		var_1.Dispose(var_85_1)

		arg_85_0.spinePlayer = nil
	end

	ipairs = var_1

	for iter_85_2, iter_85_3 in var_1(arg_85_0.pages) do
		iter_85_3:Destroy()
	end

	arg_85_0.pages = nil

	return
end

return var_0_1
