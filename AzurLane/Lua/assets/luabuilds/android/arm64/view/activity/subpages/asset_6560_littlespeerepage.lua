class = var_0_10000

local var_0_0 = "LittleSpeeRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

var_0_1.FILL_ANI_TIME = 0.5
var_0_1.IMAGE_ANI_TIME = 0.5
Vector3 = var_1
var_0_1.IMAGE_MAX_SCALE = var_1(2, 2, 2)
var_0_1.TEXT_ANI_TIME = 0.3
Vector3 = var_1
var_0_1.TEXT_MAX_SCALE = var_1(3, 3, 3)

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.heartTpl = var_1.Find(var_1_0, "HeartTpl")

	local var_1_1 = arg_1_0.bg

	arg_1_0.heartContainer = var_1.Find(var_1_1, "HeartContainer")

	local var_1_2 = arg_1_0.bg

	arg_1_0.helpBtn = var_1.Find(var_1_2, "help_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.getFinalBtn = var_1.Find(var_1_3, "get_final_btn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.gotFinalBtn = var_1.Find(var_1_4, "got_final_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.performBtn = var_1.Find(var_1_5, "perform_btn")

	local var_1_6 = arg_1_0.performBtn

	arg_1_0.performImage = var_1.Find(var_1_6, "image")

	local var_1_7 = arg_1_0.performBtn

	arg_1_0.performText = var_1.Find(var_1_7, "text")

	local var_1_8 = arg_1_0.bg

	arg_1_0.performReBtn = var_1.Find(var_1_8, "perform_re_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	local var_2_0 = arg_2_0.activity

	arg_2_0.storyName = var_1.getConfig(var_2_0, "config_client").performStory

	local var_2_1 = arg_2_0.activity

	arg_2_0.activateStoryName = var_1.getConfig(var_2_1, "config_client").activateStory
	UIItemList = var_1
	arg_2_0.heartUIItemList = var_1.New(arg_2_0.heartContainer, arg_2_0.heartTpl)

	local var_2_2 = arg_2_0.heartUIItemList

	var_1.make(var_2_2, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			arg_3_2.name = arg_3_1 + 1

			local var_3_0 = arg_2_0.ptData
			local var_3_1 = var_4.GetLevel(var_3_0)
			local var_3_2 = arg_3_2:Find("Full")

			setFillAmount = var_3_0

			var_3_0(var_3_2, 1)

			setActive = var_3_0

			var_3_0(var_3_2, var_3 <= var_3_1)
		end

		return
	end)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.helpBtn

	local function var_2_5()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_4_2.type = var_2_10004
		pg = var_2_10004
		var_4_2.helps = var_2_10004.gametip.littleSpee_npc.tip

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.battleBtn

	local function var_2_8()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_5_1(var_5_0, var_5_2, var_2_10004.LEVEL)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_6, var_2_7, var_2_8, var_1_10006)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.getBtn

	local function var_2_11()
		local var_6_0 = arg_2_0

		var_0.OnGetBtnClick(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_9, var_2_10, var_2_11, var_1_10006)

	onButton = var_1

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.getFinalBtn

	local function var_2_14()
		local var_7_0 = arg_2_0

		var_0.OnGetBtnClick(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_12, var_2_13, var_2_14, var_1_10006)

	onButton = var_1

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.performBtn

	local function var_2_17()
		pg = var_2_10000

		local var_8_0 = var_2_10000.NewStoryMgr.GetInstance()
		local var_8_1 = var_0.StoryName2StoryId(var_8_0, arg_2_0.storyName)

		assert = var_2_10001

		local var_8_2 = var_8_1 and var_8_1 ~= 0
		local var_8_3 = "Missing Story Stage ID: "
		local var_8_4

		if not arg_2_0.storyName then
			var_8_4 = "NIL"
		end

		var_2_10001(var_8_2, var_8_3 .. var_8_4)

		local var_8_5 = arg_2_0
		local var_8_6 = var_1.emit

		ActivityMediator = var_4

		var_8_6(var_8_5, var_4.GO_PERFORM_COMBAT, {
			stageId = var_8_1
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_15, var_2_16, var_2_17, var_1_10006)

	onButton = var_1

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.performReBtn

	local function var_2_20()
		pg = var_2_10000

		local var_9_0 = var_2_10000.NewStoryMgr.GetInstance()
		local var_9_1 = var_0.StoryName2StoryId(var_9_0, arg_2_0.storyName)

		assert = var_2_10001

		local var_9_2 = var_9_1 and var_9_1 ~= 0
		local var_9_3 = "Missing Story Stage ID: "
		local var_9_4

		if not arg_2_0.storyName then
			var_9_4 = "NIL"
		end

		var_2_10001(var_9_2, var_9_3 .. var_9_4)

		local var_9_5 = arg_2_0
		local var_9_6 = var_1.emit

		ActivityMediator = var_4

		var_9_6(var_9_5, var_4.GO_PERFORM_COMBAT, {
			memory = true,
			stageId = var_9_1
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_18, var_2_19, var_2_20, var_1_10006)

	setActive = var_1

	var_1(arg_2_0.performReBtn, false)

	setActive = var_1

	var_1(arg_2_0.performBtn, false)

	setActive = var_1

	var_1(arg_2_0.getFinalBtn, false)

	arg_2_0.inGetProcess = false

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	var_0_1.super.OnUpdateFlush(arg_10_0)

	local var_10_0 = arg_10_0.ptData
	local var_10_1, var_10_2 = var_1.GetLevelProgress(var_10_0)
	local var_10_3 = arg_10_0.heartUIItemList

	var_3.align(var_10_3, var_10_2)

	if var_10_1 == var_10_2 then
		setActive = var_3

		var_3(arg_10_0.getBtn, false)

		setActive = var_3

		var_3(arg_10_0.gotBtn, false)

		local var_10_4 = arg_10_0.ptData
		local var_10_5 = var_3.CanGetAward(var_10_4)
		local var_10_6 = arg_10_0.ptData
		local var_10_7 = var_4.CanGetNextAward(var_10_6)

		pg = var_10_4

		local var_10_8 = var_10_4.NewStoryMgr.GetInstance()
		local var_10_9 = var_5.IsPlayed(var_10_8, arg_10_0.storyName)

		setActive = var_10_6

		var_10_6(arg_10_0.performBtn, not var_10_9 and var_10_5)

		setActive = var_10_6

		var_10_6(arg_10_0.performReBtn, var_10_9)

		setActive = var_10_6

		var_10_6(arg_10_0.getFinalBtn, var_10_9 and var_10_5)

		setActive = var_10_6

		var_10_6(arg_10_0.gotFinalBtn, var_10_9 and not var_10_7)

		if not var_10_9 and var_10_5 then
			pg = var_10_6

			local var_10_10 = var_10_6.NewStoryMgr.GetInstance()

			var_10_6.Play(var_10_10, arg_10_0.activateStoryName)

			setActive = var_10_6

			var_10_6(arg_10_0.performBtn, true)

			setLocalScale = var_10_6

			local var_10_11 = arg_10_0.performImage

			Vector3 = var_9

			var_10_6(var_10_11, var_9.one)

			local var_10_12 = arg_10_0

			var_10_6 = arg_10_0.managedTween
			LeanTween = var_9

			var_10_6(var_10_12, var_9.scale, nil, arg_10_0.performImage, var_0_1.IMAGE_MAX_SCALE, var_0_1.IMAGE_ANI_TIME)

			local var_10_13 = arg_10_0

			var_10_6 = arg_10_0.managedTween
			LeanTween = var_9

			local var_10_14 = var_9.alphaCanvas
			local var_10_15

			GetOrAddComponent = var_11

			local var_10_16 = arg_10_0.performImage

			typeof = var_1_10014
			CanvasGroup = var_1_10016

			local var_10_17 = var_10_6(var_10_13, var_10_14, var_10_15, var_11(var_10_16, var_1_10014(var_1_10016)), 1, var_0_1.IMAGE_ANI_TIME / 2)

			var_10_6.setFrom(var_10_17, 0)

			local var_10_18 = arg_10_0

			var_10_6 = arg_10_0.managedTween
			LeanTween = var_9

			var_10_6(var_10_18, var_9.delayedCall, function()
				local var_11_0 = arg_10_0
				local var_11_1 = var_0.managedTween

				LeanTween = var_2_10003

				local var_11_2 = var_2_10003.alphaCanvas
				local var_11_3

				GetOrAddComponent = var_2_10005

				local var_11_4 = arg_10_0.performImage

				typeof = var_2_10008
				CanvasGroup = var_2_10010

				var_11_1(var_11_0, var_11_2, var_11_3, var_2_10005(var_11_4, var_2_10008(var_2_10010)), 0, var_0_1.IMAGE_ANI_TIME / 2)

				return
			end, var_0_1.IMAGE_ANI_TIME / 2, nil)

			setLocalScale = var_10_6

			var_10_6(arg_10_0.performText, var_0_1.TEXT_MAX_SCALE)

			local var_10_19 = arg_10_0

			var_10_6 = arg_10_0.managedTween
			LeanTween = var_9

			local var_10_20 = var_9.scale
			local var_10_21
			local var_10_22 = arg_10_0.performText

			Vector3 = var_12

			var_10_6(var_10_19, var_10_20, var_10_21, var_10_22, var_12.one, var_0_1.TEXT_ANI_TIME)

			local var_10_23 = arg_10_0

			var_10_6 = arg_10_0.managedTween
			LeanTween = var_10_20

			local var_10_24 = var_10_20.alphaCanvas
			local var_10_25

			GetOrAddComponent = var_10_22

			local var_10_26 = arg_10_0.performText

			typeof = var_14
			CanvasGroup = var_1_10016

			local var_10_27 = var_10_6(var_10_23, var_10_24, var_10_25, var_10_22(var_10_26, var_14(var_1_10016)), 1, var_0_1.TEXT_ANI_TIME)

			var_10_6.setFrom(var_10_27, 0)
		else
			setActive = var_10_6

			var_10_6(arg_10_0.performBtn, false)
		end
	end

	return
end

function var_0_1.OnGetBtnClick(arg_12_0)
	if arg_12_0.inGetProcess then
		return
	end

	arg_12_0.inGetProcess = true

	local var_12_0 = {}
	local var_12_1 = arg_12_0.ptData
	local var_12_2 = var_2.GetAward(var_12_1)

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_12_3 = var_1_10003(var_1_10005)
	local var_12_4 = var_3.getRawData(var_12_3)

	pg = var_1_10005

	local var_12_5 = var_1_10005.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_12_3

	if var_12_3 then
		var_12_3 = 0
	else
		getProxy = var_12_3
		BagProxy = var_1_10008

		local var_12_6 = var_12_3(var_1_10008)

		var_12_3 = var_12_3.GetLimitCntById(var_12_6, var_12_5)
	end

	Task = var_1_10007

	local var_12_7, var_12_8 = var_1_10007.StaticJudgeOverflow(var_12_4.gold, var_12_4.oil, var_12_3, true, true, {
		{
			var_12_2.type,
			var_12_2.id,
			var_12_2.count
		}
	})

	if var_12_7 then
		table = var_9

		var_9.insert(var_12_0, function(arg_13_0)
			pg = var_2_10001

			local var_13_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_13_1 = var_1.ShowMsgBox
			local var_13_2 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10005
			var_13_2.type = var_2_10005
			i18n = var_2_10005
			var_13_2.content = var_2_10005("award_max_warning")
			var_13_2.items = var_12_8
			var_13_2.onYes = arg_13_0

			var_13_1(var_13_0, var_13_2)

			return
		end)

		arg_12_0.inGetProcess = false
	end

	table = var_9

	var_9.insert(var_12_0, function(arg_14_0)
		local var_14_0 = arg_12_0.ptData
		local var_14_1 = var_1.GetLevelProgress(var_14_0)
		local var_14_2 = arg_12_0.heartContainer
		local var_14_3 = var_2.Find(var_14_2, var_14_1 .. "/Full")

		setFillAmount = var_14_0

		var_14_0(var_14_3, 0)

		setActive = var_14_0

		var_14_0(var_14_3, true)

		local var_14_4 = arg_12_0
		local var_14_5 = var_3.managedTween

		LeanTween = var_6

		local var_14_6 = var_6.value
		local var_14_7

		go = var_2_10008

		local var_14_8 = var_14_5(var_14_4, var_14_6, var_14_7, var_2_10008(var_14_3), 0, 1, var_0_1.FILL_ANI_TIME)
		local var_14_9 = var_3.setOnUpdate

		System = var_14_6

		local var_14_10 = var_14_9(var_14_8, var_14_6.Action_float(function(arg_15_0)
			setFillAmount = var_3_10001

			var_3_10001(var_14_3, arg_15_0)

			return
		end))
		local var_14_11 = var_3.setOnComplete

		System = var_6

		var_14_11(var_14_10, var_6.Action(function()
			arg_14_0()

			return
		end))

		return
	end)

	seriesAsync = var_9

	var_9(var_12_0, function()
		local var_17_0 = arg_12_0.ptData
		local var_17_1, var_17_2 = var_0.GetResProgress(var_17_0)
		local var_17_3 = arg_12_0
		local var_17_4 = var_2.emit

		ActivityMediator = var_2_10005

		local var_17_5 = var_2_10005.EVENT_PT_OPERATION
		local var_17_6 = {
			cmd = 1
		}
		local var_17_7 = arg_12_0.ptData

		var_17_6.activity_id = var_7.GetId(var_17_7)
		var_17_6.arg1 = var_17_2

		var_17_4(var_17_3, var_17_5, var_17_6)

		arg_12_0.inGetProcess = false

		return
	end)

	return
end

return var_0_1
