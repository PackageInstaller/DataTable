class = var_0_10000

local var_0_0 = "IslandStoryMgr"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.START_STORY = "IslandStoryMgr:START_STORY"
var_0_1.END_STORY = "IslandStoryMgr:END_STORY"

local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2

Color = var_0_10004

local var_0_5 = var_0_10004.New(1, 0.8705, 0.4196, 1)

Color = var_5

local var_0_6 = var_5.New(1, 1, 1, 1)

function var_0_1.getUIName(arg_1_0)
	return "IslandStoryUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.skipBtn = var_1.Find(var_2_0, "front/btns/btns/skip_button")

	local var_2_1 = arg_2_0._tf

	arg_2_0.logBtn = var_1.Find(var_2_1, "front/btns/record")

	local var_2_2 = arg_2_0._tf

	arg_2_0.autoBtn = var_1.Find(var_2_2, "front/btns/btns/auto_button")
	findTF = var_1

	local var_2_3 = var_1(arg_2_0._tf, "front/btns/btns/auto_button/sel")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.autoBtnImg = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.animator = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.aniDft = var_2_8(var_2_7, var_3(var_1_10004))
	GetOrAddComponent = var_1

	local var_2_9 = arg_2_0._tf

	typeof = var_3
	CanvasGroup = var_1_10004
	arg_2_0.canvasGroup = var_1(var_2_9, var_3(var_1_10004))
	Dialogue3DPlayer = var_1
	arg_2_0.player = var_1.New(arg_2_0)
	IslandStoryRecordPanel = var_1
	arg_2_0.recordPanel = var_1.New(arg_2_0)
	IslandStoryRecorder = var_1
	arg_2_0.recorder = var_1.New()
	StorySetSpeedPanel = var_1
	arg_2_0.setSpeedPanel = var_1.New(arg_2_0._tf, function(arg_3_0)
		local var_3_0 = arg_2_0

		if var_1.IsRunning(var_3_0) and arg_2_0.script then
			local var_3_1 = arg_2_0.script

			var_1.SetPlaySpeed(var_3_1, arg_3_0)
		end

		return
	end)
	setActive = var_1

	var_1(arg_2_0._go, false)

	arg_2_0.state = var_0_2

	return
end

function var_0_1.Play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	_IslandCore = var_1_10004

	if not var_1_10004 then
		return
	end

	if arg_4_0:IsRunning() then
		arg_4_3()

		return
	end

	_IslandCore = var_4

	local var_4_0 = var_4:GetView()
	local var_4_1 = var_4.GetAllUnits(var_4_0)

	defaultValue = var_4_0
	arg_4_0.refreshNpc = var_4_0(arg_4_2, true)
	arg_4_0.state = var_0_3
	pg = var_5

	local var_4_2 = var_5.NewStoryMgr.GetInstance()
	local var_4_3 = var_5.GetScript(var_4_2, arg_4_1)

	IslandStory = var_4_2

	local var_4_4 = var_4_2.New
	local var_4_5 = var_4_3
	local var_4_6 = var_4_1

	IslandStory = var_1_10009
	arg_4_0.script = var_4_4(var_4_5, var_4_6, var_1_10009.MODE_DIALOGUE)

	local var_4_7 = arg_4_0

	arg_4_0.StartScript(var_4_7, var_6)

	local var_4_8 = {}

	table = var_4_7

	var_4_7.insert(var_4_8, function(arg_5_0)
		local var_5_0 = arg_4_0
		local var_5_1 = var_1.WaitForViewLoaded

		_IslandCore = var_2_10003

		var_5_1(var_5_0, var_2_10003:GetView(), arg_5_0)

		return
	end)

	table = var_8

	var_8.insert(var_4_8, function(arg_6_0)
		local var_6_0 = arg_4_0.player

		var_1.OnStartAction(var_6_0, var_0, arg_6_0)

		return
	end)

	ipairs = var_8

	for iter_4_0, iter_4_1 in var_8(var_6.steps) do
		table = var_1_10013

		var_1_10013.insert(var_4_8, function(arg_7_0)
			if arg_4_0.isStop then
				arg_7_0()

				return
			end

			local var_7_0 = arg_4_0.player

			var_1.Play(var_7_0, arg_4_0.recorder, iter_4_0, var_0, arg_7_0)

			return
		end)
	end

	table = var_8

	var_8.insert(var_4_8, function(arg_8_0)
		local var_8_0 = arg_4_0.player

		var_1.OnEndAction(var_8_0, var_0, arg_8_0)

		return
	end)

	table = var_8

	var_8.insert(var_4_8, function(arg_9_0)
		local var_9_0 = arg_4_0

		var_1.PlayExitAniamtion(var_9_0, var_0, arg_9_0)

		return
	end)

	seriesAsync = var_8

	var_8(var_4_8, function()
		local var_10_0 = arg_4_0

		var_0.EndScript(var_10_0, var_0)

		if arg_4_3 then
			arg_4_3()
		end

		local var_10_1 = arg_4_1

		IslandGuideChecker = var_10_0

		if var_10_1 == var_10_0.SIGNIN_STORY_NAME then
			IslandGuideChecker = var_10_1

			var_10_1.CheckGuide("ISLAND_GUIDE_26")
		end

		return
	end)

	return
end

function var_0_1.WaitForViewLoaded(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:RemoveTimer()

	if arg_11_1:IsLoaded() then
		arg_11_2()

		return
	end

	Timer = var_3
	arg_11_0.timer = var_3.New(function()
		local var_12_0 = arg_11_1

		if var_0.IsLoaded(var_12_0) then
			local var_12_1 = arg_11_0

			var_0.RemoveTimer(var_12_1)
			arg_11_2()
		end

		return
	end, 0.1, -1)

	local var_11_0 = arg_11_0.timer

	var_3.Start(var_11_0)

	return
end

function var_0_1.RemoveTimer(arg_13_0, ...)
	if arg_13_0.timer then
		local var_13_0 = arg_13_0.timer

		var_1.Stop(var_13_0)

		arg_13_0.timer = nil
	end

	return
end

function var_0_1.StartScript(arg_14_0, arg_14_1)
	arg_14_0.isStop = false
	arg_14_0.canvasGroup.blocksRaycasts = true

	local var_14_0 = arg_14_0.recorder

	var_2.Clear(var_14_0)

	setActive = var_2

	var_2(arg_14_0._go, true)
	arg_14_0:RegisterSkipBtn()
	arg_14_0:RegisterLogBtn()
	arg_14_0:RegisterAutoBtn()

	local var_14_1 = arg_14_0.player

	var_2.OnStart(var_14_1, arg_14_1)

	pg = var_2

	local var_14_2 = var_2.m02
	local var_14_3 = var_2.sendNotification

	GAME = var_4

	var_14_3(var_14_2, var_4.STORY_UPDATE, {
		storyId = arg_14_1.id,
		callback = function()
			IslandTaskHelper = var_2_10000

			local var_15_0 = var_2_10000.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_2_10001

			var_15_0(var_2_10001.STORY)

			return
		end
	})

	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.emit

	IslandBaseScene = var_4

	local var_14_6 = var_4.LINK_CORE_EVENT

	IslandProxy = var_5

	var_14_5(var_14_4, var_14_6, var_5.STORY_START)

	return
end

function var_0_1.RegisterAutoBtn(arg_16_0)
	onButton = var_1_10001

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.autoBtn

	local function var_16_2()
		if not arg_16_0.script then
			return
		end

		local var_17_0 = arg_16_0.script

		if var_0.GetAutoPlayFlag(var_17_0) then
			local var_17_1 = arg_16_0.script

			var_0.StopAutoPlay(var_17_1)

			local var_17_2 = arg_16_0.player

			var_0.CancelAuto(var_17_2)
		else
			local var_17_3 = arg_16_0.script

			var_0.SetAutoPlay(var_17_3)

			local var_17_4 = arg_16_0.player

			var_0.NextOne(var_17_4)
		end

		local var_17_5 = arg_16_0

		var_0.UpdateAutoBtn(var_17_5)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_16_0, var_16_1, var_16_2, var_1_10005)
	arg_16_0:UpdateAutoBtn()

	return
end

function var_0_1.UpdateAutoBtn(arg_18_0)
	local var_18_0 = arg_18_0.script
	local var_18_1 = var_1.GetAutoPlayFlag(var_18_0)

	arg_18_0:ClearAutoBtn(var_18_1)

	return
end

function var_0_1.ClearAutoBtn(arg_19_0, arg_19_1)
	if not arg_19_0.script then
		return
	end

	local var_19_0 = arg_19_0.autoBtnImg
	local var_19_1

	if not arg_19_1 or not var_0_5 then
		var_19_1 = var_0_6
	end

	var_19_0.color = var_19_1

	local var_19_2 = arg_19_1 and "Show" or "Hide"

	arg_19_0.setSpeedPanel[var_19_2](arg_19_0.setSpeedPanel, arg_19_0.script)

	return
end

function var_0_1.RegisterSkipBtn(arg_20_0)
	onButton = var_1_10001

	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.skipBtn

	local function var_20_2()
		local var_21_0 = arg_20_0.script

		var_0.MarkSkipAll(var_21_0)

		local var_21_1 = arg_20_0.player

		var_0.NextOne(var_21_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_20_0, var_20_1, var_20_2, var_1_10005)

	return
end

function var_0_1.RegisterLogBtn(arg_22_0)
	onButton = var_1_10001

	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.logBtn

	local function var_22_2()
		local var_23_0 = arg_22_0.recordPanel

		if not var_0.CanOpen(var_23_0) then
			return
		end

		local var_23_1 = arg_22_0.script

		if var_0.GetAutoPlayFlag(var_23_1) then
			local var_23_2 = arg_22_0.script

			var_0.StopAutoPlay(var_23_2)

			local var_23_3 = arg_22_0.player

			var_0.CancelAuto(var_23_3)

			local var_23_4 = arg_22_0

			var_0.UpdateAutoBtn(var_23_4)
		end

		local var_23_5 = arg_22_0.recordPanel

		var_0.Show(var_23_5, arg_22_0.recorder)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_22_0, var_22_1, var_22_2, var_1_10005)

	return
end

function var_0_1.PlayExitAniamtion(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1:LastStepIsTimeline() then
		if arg_24_2 then
			arg_24_2()
		end

		return
	end

	local var_24_0 = arg_24_0.aniDft

	var_3.SetEndEvent(var_24_0, function()
		if arg_24_2 then
			arg_24_2()
		end

		return
	end)

	arg_24_0.canvasGroup.blocksRaycasts = false

	local var_24_1 = arg_24_0.animator

	var_3.Play(var_24_1, "anim_IslandStoryUI_Dialogue_Out")

	return
end

function var_0_1.EndScript(arg_26_0, arg_26_1)
	arg_26_0.isStop = false
	arg_26_0.canvasGroup.blocksRaycasts = true

	local var_26_0 = arg_26_0.aniDft

	var_2.SetEndEvent(var_26_0, nil)

	setActive = var_2

	var_2(arg_26_0._go, false)

	removeOnButton = var_2

	var_2(arg_26_0.skipBtn)

	removeOnButton = var_2

	var_2(arg_26_0.logBtn)
	arg_26_0:ClearAutoBtn(false)

	local var_26_1 = arg_26_0.recorder

	var_2.Clear(var_26_1)

	local var_26_2 = arg_26_0.recordPanel

	var_2.Hide(var_26_2)

	local var_26_3 = arg_26_0.setSpeedPanel

	var_2.Clear(var_26_3)

	arg_26_0.state = var_0_4
	arg_26_0.script = nil

	arg_26_0:RemoveTimer()

	local var_26_4 = arg_26_0.player

	var_2.OnEnd(var_26_4, arg_26_1)

	local var_26_5 = arg_26_0.refreshNpc
	local var_26_6 = arg_26_0
	local var_26_7 = arg_26_0.emit

	IslandBaseScene = var_1_10005

	local var_26_8 = var_1_10005.LINK_CORE_EVENT

	IslandProxy = var_1_10006

	var_26_7(var_26_6, var_26_8, var_1_10006.STORY_END, var_26_5)

	arg_26_0.refreshNpc = nil

	return
end

function var_0_1.IsRunning(arg_27_0)
	return arg_27_0.state == var_0_3
end

function var_0_1.Stop(arg_28_0)
	if arg_28_0.isStop then
		return
	end

	if not arg_28_0:IsRunning() then
		return
	end

	arg_28_0.isStop = true

	local var_28_0 = arg_28_0.player

	var_1.NextOne(var_28_0)

	return
end

function var_0_1.onBackPressed(arg_29_0)
	if arg_29_0.recordPanel then
		local var_29_0 = arg_29_0.recordPanel

		if var_1.IsShowing(var_29_0) then
			local var_29_1 = arg_29_0.recordPanel

			var_1.Hide(var_29_1)

			return true
		end
	end

	if arg_29_0:IsRunning() then
		arg_29_0:Stop()

		return true
	end

	return false
end

function var_0_1.OnDestroy(arg_30_0)
	local var_30_0 = arg_30_0.recorder

	var_1.Dispose(var_30_0)

	local var_30_1 = arg_30_0.recordPanel

	var_1.Dispose(var_30_1)

	local var_30_2 = arg_30_0.setSpeedPanel

	var_1.Dispose(var_30_2)

	local var_30_3 = arg_30_0.player

	var_1.Dispose(var_30_3)

	return
end

return var_0_1
