pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.NewGuideMgr = var_0_10001("NewGuideMgr")
pg = var_0

local var_0_1 = var_0.NewGuideMgr

var_0_1.ENABLE_GUIDE = true
require = var_1

var_1("Mgr/Guide/Include")

local var_0_2 = true
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7 = 4
local var_0_8 = 5

local function var_0_9(...)
	if not var_0_2 then
		return
	end

	print = var_0

	var_0(...)

	return
end

local function var_0_10(arg_2_0, arg_2_1)
	local var_2_0 = {}

	GuideStep = var_1_10003

	local var_2_1 = var_1_10003.TYPE_DOFUNC

	GuideDoFunctionPlayer = var_1_10004
	var_2_0[var_2_1] = var_1_10004.New(arg_2_1)
	GuideStep = var_2_1

	local var_2_2 = var_2_1.TYPE_DONOTHING

	GuideDoNothingPlayer = var_4
	var_2_0[var_2_2] = var_4.New(arg_2_1)
	GuideStep = var_2_2

	local var_2_3 = var_2_2.TYPE_FINDUI

	GuideFindUIPlayer = var_4
	var_2_0[var_2_3] = var_4.New(arg_2_1)
	GuideStep = var_2_3

	local var_2_4 = var_2_3.TYPE_HIDEUI

	GuideHideUIPlayer = var_4
	var_2_0[var_2_4] = var_4.New(arg_2_1)
	GuideStep = var_2_4

	local var_2_5 = var_2_4.TYPE_SENDNOTIFIES

	GuideSendNotifiesPlayer = var_4
	var_2_0[var_2_5] = var_4.New(arg_2_1)
	GuideStep = var_2_5

	local var_2_6 = var_2_5.TYPE_SHOWSIGN

	GuideShowSignPlayer = var_4
	var_2_0[var_2_6] = var_4.New(arg_2_1)
	GuideStep = var_2_6

	local var_2_7 = var_2_6.TYPE_STORY

	GuideStoryPlayer = var_4
	var_2_0[var_2_7] = var_4.New(arg_2_1)
	arg_2_0.players = var_2_0

	return
end

local function var_0_11(arg_3_0)
	require = var_1_10001

	local var_3_0 = var_1_10001("GameCfg.guide.newguide.segments." .. arg_3_0)

	Guide = var_2

	return var_2.New(var_3_0)
end

function var_0_1.Init(arg_4_0, arg_4_1)
	arg_4_0.sceneRecords = {}
	arg_4_0.state = var_0_3
	LoadAndInstantiateAsync = var_2

	var_2("ui", "NewGuideUI", function(arg_5_0)
		arg_4_0._go = arg_5_0
		arg_4_0._tf = arg_4_0._go.transform

		local var_5_0 = arg_4_0._go

		var_1.SetActive(var_5_0, false)

		local var_5_1 = arg_4_0._go.transform
		local var_5_2 = var_1.SetParent

		pg = var_3

		var_5_2(var_5_1, var_3.UIMgr.GetInstance().OverlayToast, false)

		local var_5_3 = arg_4_0

		GuideUIFinder = var_5_1
		var_5_3.uiFinder = var_5_1.New(arg_4_0._tf)

		local var_5_4 = arg_4_0

		GuideUIDuplicator = var_2

		local var_5_5 = var_2.New
		local var_5_6 = arg_4_0._tf

		var_5_4.uiDuplicator = var_5_5(var_3.Find(var_5_6, "target"))

		local var_5_7 = arg_4_0

		GuideUILoader = var_2

		local var_5_8 = var_2.New
		local var_5_9 = arg_4_0._tf

		var_5_7.uiLoader = var_5_8(var_3.Find(var_5_9, "target"))

		local var_5_10 = arg_4_0

		GuideUIFloatCollector = var_2

		local var_5_11 = var_2.New
		local var_5_12 = arg_4_0._tf

		var_5_10.uiFloatCollctor = var_5_11(var_3.Find(var_5_12, "target"))

		local var_5_13 = arg_4_0
		local var_5_14 = {}

		GuideStep = var_3

		local var_5_15 = var_3.DIALOGUE_BLUE
		local var_5_16 = arg_4_0._tf

		var_5_14[var_5_15] = var_4.Find(var_5_16, "windows/window_1")
		var_5_13.dialogueWindows = var_5_14
		arg_4_0.counsellors = {}
		arg_4_0.state = var_0_4

		local var_5_17 = arg_4_0

		GetOrAddComponent = var_2

		local var_5_18 = arg_4_0._tf
		local var_5_19 = var_3.Find(var_5_18, "BG/close_btn")

		typeof = var_5_18
		UILongPressTrigger = var_5
		var_5_17.uiLongPress = var_2(var_5_19, var_5_18(var_5))
		arg_4_0.uiLongPress.longPressThreshold = 10

		var_0_10(arg_4_0, arg_4_0._tf)
		arg_4_1()

		return
	end, true, true)

	return
end

function var_0_1.PlayNothing(arg_6_0)
	SetActive = var_1_10001

	var_1_10001(arg_6_0._go, true)

	return
end

function var_0_1.StopNothing(arg_7_0)
	SetActive = var_1_10001

	var_1_10001(arg_7_0._go, false)

	return
end

function var_0_1.Play(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if not arg_8_0:CanPlay() then
		var_0_9("can not play guide " .. arg_8_1)
		arg_8_3()

		return
	end

	var_0_9("play guide : " .. arg_8_1)

	arg_8_0.currentGuideName = arg_8_1

	local var_8_0 = var_0_11(arg_8_1)

	arg_8_0:PlayScript(var_8_0, arg_8_2, arg_8_3, arg_8_4, arg_8_5)

	return
end

function var_0_1.PlayScript(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if not arg_9_1 then
		var_0_9("should exist guide file ")
		arg_9_3()

		return
	end

	arg_9_0.OnFailed = arg_9_4

	local var_9_0 = arg_9_0

	arg_9_0.OnStart(var_9_0)

	local var_9_1 = {}

	ipairs = var_9_0

	for iter_9_0, iter_9_1 in var_9_0(arg_9_1:GetStepsWithCode(arg_9_2)) do
		local var_9_2 = iter_9_0

		table = var_1_10013

		var_1_10013.insert(var_9_1, function(arg_10_0)
			local var_10_0 = arg_9_0

			if var_1.IsStop(var_10_0) then
				return
			end

			local var_10_1 = arg_9_0.players
			local var_10_2 = iter_9_1
			local var_10_3 = var_10_1[var_2.GetType(var_10_2)]

			pg = var_2

			local var_10_4 = var_2.TimeMgr.GetInstance()
			local var_10_5 = var_2.GetServerTime(var_10_4)

			var_10_3:Execute(iter_9_1, function()
				if arg_9_5 then
					arg_9_5(var_9_2, var_10_5)
				end

				arg_10_0()

				return
			end)

			arg_9_0.player = var_10_3

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_9_1, function()
		local var_12_0 = arg_9_0

		var_0.OnEnd(var_12_0, arg_9_3)

		return
	end)

	return
end

function var_0_1.CanPlay(arg_13_0)
	pg = var_1_10001

	if not var_1_10001.MsgboxMgr.GetInstance()._go.activeSelf then
		pg = var_1

		local var_13_0 = var_1.NewStoryMgr.GetInstance()

		if var_1.IsRunning(var_13_0) or not var_0_1.ENABLE_GUIDE or not arg_13_0:IsLoaded() or arg_13_0:IsPause() or arg_13_0:IsBusy() then
			return false
		end

		return true
	end
end

function var_0_1.OnStart(arg_14_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_14_0)

	arg_14_0.state = var_0_5
	pg = var_1

	local var_14_0 = var_1.m02
	local var_14_1 = var_1.sendNotification

	GAME = var_1_10003

	var_14_1(var_14_0, var_1_10003.START_GUIDE)

	local var_14_2 = arg_14_0._go.transform

	var_1.SetAsLastSibling(var_14_2)

	local var_14_3 = arg_14_0._go

	var_1.SetActive(var_14_3, true)

	local var_14_4 = arg_14_0.uiLongPress.onLongPressed

	var_1.AddListener(var_14_4, function()
		local var_15_0 = arg_14_0

		var_0.Stop(var_15_0)

		return
	end)

	return
end

function var_0_1.OnEnd(arg_16_0, arg_16_1)
	arg_16_0.currentGuideName = nil

	local var_16_0 = arg_16_0.uiLongPress.onLongPressed

	var_2.RemoveAllListeners(var_16_0)

	pg = var_2

	var_2.DelegateInfo.Dispose(arg_16_0)

	arg_16_0.state = var_0_4

	arg_16_0:Clear()

	if arg_16_1 then
		arg_16_1()
	end

	return
end

function var_0_1.Pause(arg_17_0)
	if arg_17_0:IsBusy() then
		arg_17_0.state = var_0_7
		SetActive = var_1

		var_1(arg_17_0._go, false)
	end

	return
end

function var_0_1.Resume(arg_18_0)
	if arg_18_0:IsPause() then
		arg_18_0.state = var_0_5
		SetActive = var_1

		var_1(arg_18_0._go, true)
	end

	return
end

function var_0_1.Stop(arg_19_0)
	if arg_19_0.state ~= var_0_6 then
		if arg_19_0.OnFailed then
			arg_19_0.OnFailed()
		end

		arg_19_0.state = var_0_6

		local var_19_0 = arg_19_0.uiFinder

		var_1.Clear(var_19_0)

		local var_19_1 = arg_19_0.uiDuplicator

		var_1.Clear(var_19_1)

		local var_19_2 = arg_19_0.uiLoader

		var_1.Clear(var_19_2)

		local var_19_3 = arg_19_0.uiFloatCollctor

		var_1.Clear(var_19_3)
		arg_19_0:Clear()
	end

	return
end

function var_0_1.NextStep(arg_20_0)
	if arg_20_0.state == var_0_5 and arg_20_0.player then
		local var_20_0 = arg_20_0.player

		var_1.NextOne(var_20_0)
	end

	return
end

function var_0_1.Clear(arg_21_0)
	arg_21_0.OnFailed = nil
	arg_21_0.sceneRecords = {}

	local var_21_0 = arg_21_0._go

	var_1.SetActive(var_21_0, false)

	ipairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0.players) do
		iter_21_1:Clear()
	end

	if arg_21_0.player then
		arg_21_0.player = nil
	end

	pg = var_1

	local var_21_1 = var_1.m02
	local var_21_2 = var_1.sendNotification

	GAME = var_3

	var_21_2(var_21_1, var_3.END_GUIDE)

	return
end

function var_0_1.IsPause(arg_22_0)
	local var_22_0

	if arg_22_0.state then
		var_22_0 = arg_22_0.state == var_0_7
	end

	return var_22_0
end

function var_0_1.IsBusy(arg_23_0)
	local var_23_0

	if arg_23_0.state then
		var_23_0 = arg_23_0.state == var_0_5
	end

	return var_23_0
end

function var_0_1.IsLoaded(arg_24_0)
	local var_24_0

	if arg_24_0.state then
		var_24_0 = arg_24_0.state > var_0_3
	end

	return var_24_0
end

function var_0_1.IsStop(arg_25_0)
	local var_25_0

	if arg_25_0.state then
		var_25_0 = arg_25_0.state == var_0_6
	end

	return var_25_0
end

function var_0_1.OnSceneEnter(arg_26_0, arg_26_1)
	if not arg_26_0:IsLoaded() then
		return
	end

	table = var_2

	if not var_2.contains(arg_26_0.sceneRecords, arg_26_1.view) then
		table = var_2

		var_2.insert(arg_26_0.sceneRecords, arg_26_1.view)
	end

	if arg_26_0.player then
		local var_26_0 = arg_26_0.player

		var_2.OnSceneEnter(var_26_0)
	end

	return
end

function var_0_1.OnSceneExit(arg_27_0, arg_27_1)
	if not arg_27_0:IsLoaded() then
		return
	end

	table = var_2

	if var_2.contains(arg_27_0.sceneRecords, arg_27_1.view) then
		table = var_2

		var_2.removebyvalue(arg_27_0.sceneRecords, arg_27_1.view)
	end

	return
end

function var_0_1.ExistScene(arg_28_0, arg_28_1)
	table = var_1_10002

	return var_1_10002.contains(arg_28_0.sceneRecords, arg_28_1)
end

function var_0_1.GetCurrentGuideName(arg_29_0)
	return arg_29_0.currentGuideName
end

function var_0_1.Exit(arg_30_0)
	arg_30_0:Clear()

	local var_30_0 = arg_30_0.uiFinder

	var_1.Clear(var_30_0)

	local var_30_1 = arg_30_0.uiDuplicator

	var_1.Clear(var_30_1)

	local var_30_2 = arg_30_0.uiLoader

	var_1.Clear(var_30_2)

	local var_30_3 = arg_30_0.uiFloatCollctor

	var_1.Clear(var_30_3)

	arg_30_0.state = var_0_8

	return
end

return
