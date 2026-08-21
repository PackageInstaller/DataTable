pg = pg or {}
pg.NewGuideMgr = singletonClass("NewGuideMgr")

local var_0_0 = pg.NewGuideMgr

pg.NewGuideMgr.ENABLE_GUIDE = true

require("Mgr/Guide/Include")

local var_0_1 = true
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4
local var_0_7 = 5

local function var_0_8(...)
	if not var_0_1 then
		return
	end

	print(...)

	return
end

local function var_0_9(arg_2_0, arg_2_1)
	arg_2_0.players = {
		[GuideStep.TYPE_DOFUNC] = GuideDoFunctionPlayer.New(arg_2_1),
		[GuideStep.TYPE_DONOTHING] = GuideDoNothingPlayer.New(arg_2_1),
		[GuideStep.TYPE_FINDUI] = GuideFindUIPlayer.New(arg_2_1),
		[GuideStep.TYPE_HIDEUI] = GuideHideUIPlayer.New(arg_2_1),
		[GuideStep.TYPE_SENDNOTIFIES] = GuideSendNotifiesPlayer.New(arg_2_1),
		[GuideStep.TYPE_SHOWSIGN] = GuideShowSignPlayer.New(arg_2_1),
		[GuideStep.TYPE_STORY] = GuideStoryPlayer.New(arg_2_1)
	}

	return
end

local function var_0_10(arg_3_0)
	return Guide.New((require("GameCfg.guide.newguide.segments." .. arg_3_0)))
end

function pg.NewGuideMgr.Init(arg_4_0, arg_4_1)
	arg_4_0.sceneRecords = {}
	arg_4_0.state = var_0_2

	LoadAndInstantiateAsync("ui", "NewGuideUI", function(arg_5_0)
		arg_4_0._go = arg_5_0
		arg_4_0._tf = arg_4_0._go.transform

		arg_4_0._go:SetActive(false)
		arg_4_0._go.transform:SetParent(pg.UIMgr.GetInstance().OverlayToast, false)

		arg_4_0.uiFinder = GuideUIFinder.New(arg_4_0._tf)
		arg_4_0.uiDuplicator = GuideUIDuplicator.New(arg_4_0._tf:Find("target"))
		arg_4_0.uiLoader = GuideUILoader.New(arg_4_0._tf:Find("target"))
		arg_4_0.uiFloatCollctor = GuideUIFloatCollector.New(arg_4_0._tf:Find("target"))
		arg_4_0.dialogueWindows = {
			[GuideStep.DIALOGUE_BLUE] = arg_4_0._tf:Find("windows/window_1")
		}
		arg_4_0.counsellors = {}
		arg_4_0.state = var_0_3
		arg_4_0.uiLongPress = GetOrAddComponent(arg_4_0._tf:Find("BG/close_btn"), typeof(UILongPressTrigger))
		arg_4_0.uiLongPress.longPressThreshold = 10

		var_0_9(arg_4_0, arg_4_0._tf)
		arg_4_1()

		return
	end, true, true)

	return
end

function pg.NewGuideMgr.PlayNothing(arg_6_0)
	SetActive(arg_6_0._go, true)

	return
end

function pg.NewGuideMgr.StopNothing(arg_7_0)
	SetActive(arg_7_0._go, false)

	return
end

function pg.NewGuideMgr.Play(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if not arg_8_0:CanPlay() then
		var_0_8("can not play guide " .. arg_8_1)
		arg_8_3()

		return
	end

	var_0_8("play guide : " .. arg_8_1)

	arg_8_0.currentGuideName = arg_8_1

	arg_8_0:PlayScript(var_0_10(arg_8_1), arg_8_2, arg_8_3, arg_8_4, arg_8_5)

	return
end

function pg.NewGuideMgr.PlayScript(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if not arg_9_1 then
		var_0_8("should exist guide file ")
		arg_9_3()

		return
	end

	arg_9_0.OnFailed = arg_9_4

	arg_9_0:OnStart()

	for iter_9_0, iter_9_1 in ipairs(arg_9_1:GetStepsWithCode(arg_9_2)) do
		local var_9_0 = iter_9_0

		table.insert({}, function(arg_10_0)
			if arg_9_0:IsStop() then
				return
			end

			local var_10_0 = arg_9_0.players[iter_9_1:GetType()]
			local var_10_1 = pg.TimeMgr.GetInstance():GetServerTime()

			var_10_0:Execute(iter_9_1, function()
				if arg_9_5 then
					arg_9_5(var_9_0, var_10_1)
				end

				arg_10_0()

				return
			end)

			arg_9_0.player = var_10_0

			return
		end)
	end

	seriesAsync({}, function()
		arg_9_0:OnEnd(arg_9_3)

		return
	end)

	return
end

function pg.NewGuideMgr.CanPlay(arg_13_0)
	if not pg.MsgboxMgr.GetInstance()._go.activeSelf then
		if pg.NewStoryMgr.GetInstance():IsRunning() or not var_0_0.ENABLE_GUIDE or not arg_13_0:IsLoaded() or arg_13_0:IsPause() or arg_13_0:IsBusy() then
			return false
		end

		return true
	end
end

function pg.NewGuideMgr.OnStart(arg_14_0)
	pg.DelegateInfo.New(arg_14_0)

	arg_14_0.state = var_0_4

	pg.m02:sendNotification(GAME.START_GUIDE)
	arg_14_0._go.transform:SetAsLastSibling()
	arg_14_0._go:SetActive(true)
	arg_14_0.uiLongPress.onLongPressed:AddListener(function()
		arg_14_0:Stop()

		return
	end)

	return
end

function pg.NewGuideMgr.OnEnd(arg_16_0, arg_16_1)
	arg_16_0.currentGuideName = nil

	arg_16_0.uiLongPress.onLongPressed:RemoveAllListeners()
	pg.DelegateInfo.Dispose(arg_16_0)

	arg_16_0.state = var_0_3

	arg_16_0:Clear()

	if arg_16_1 then
		arg_16_1()
	end

	return
end

function pg.NewGuideMgr.Pause(arg_17_0)
	if arg_17_0:IsBusy() then
		arg_17_0.state = var_0_6

		SetActive(arg_17_0._go, false)
	end

	return
end

function pg.NewGuideMgr.Resume(arg_18_0)
	if arg_18_0:IsPause() then
		arg_18_0.state = var_0_4

		SetActive(arg_18_0._go, true)
	end

	return
end

function pg.NewGuideMgr.Stop(arg_19_0)
	if arg_19_0.state ~= var_0_5 then
		if arg_19_0.OnFailed then
			arg_19_0.OnFailed()
		end

		arg_19_0.state = var_0_5

		arg_19_0.uiFinder:Clear()
		arg_19_0.uiDuplicator:Clear()
		arg_19_0.uiLoader:Clear()
		arg_19_0.uiFloatCollctor:Clear()
		arg_19_0:Clear()
	end

	return
end

function pg.NewGuideMgr.NextStep(arg_20_0)
	if arg_20_0.state == var_0_4 and arg_20_0.player then
		arg_20_0.player:NextOne()
	end

	return
end

function pg.NewGuideMgr.Clear(arg_21_0)
	arg_21_0.OnFailed = nil
	arg_21_0.sceneRecords = {}

	arg_21_0._go:SetActive(false)

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.players) do
		iter_21_1:Clear()
	end

	if arg_21_0.player then
		arg_21_0.player = nil
	end

	pg.m02:sendNotification(GAME.END_GUIDE)

	return
end

function pg.NewGuideMgr.IsPause(arg_22_0)
	return arg_22_0.state and arg_22_0.state == var_0_6
end

function pg.NewGuideMgr.IsBusy(arg_23_0)
	return arg_23_0.state and arg_23_0.state == var_0_4
end

function pg.NewGuideMgr.IsLoaded(arg_24_0)
	return arg_24_0.state and arg_24_0.state > var_0_2
end

function pg.NewGuideMgr.IsStop(arg_25_0)
	return arg_25_0.state and arg_25_0.state == var_0_5
end

function pg.NewGuideMgr.OnSceneEnter(arg_26_0, arg_26_1)
	if not arg_26_0:IsLoaded() then
		return
	end

	if not table.contains(arg_26_0.sceneRecords, arg_26_1.view) then
		table.insert(arg_26_0.sceneRecords, arg_26_1.view)
	end

	if arg_26_0.player then
		arg_26_0.player:OnSceneEnter()
	end

	return
end

function pg.NewGuideMgr.OnSceneExit(arg_27_0, arg_27_1)
	if not arg_27_0:IsLoaded() then
		return
	end

	if table.contains(arg_27_0.sceneRecords, arg_27_1.view) then
		table.removebyvalue(arg_27_0.sceneRecords, arg_27_1.view)
	end

	return
end

function pg.NewGuideMgr.ExistScene(arg_28_0, arg_28_1)
	return table.contains(arg_28_0.sceneRecords, arg_28_1)
end

function pg.NewGuideMgr.GetCurrentGuideName(arg_29_0)
	return arg_29_0.currentGuideName
end

function pg.NewGuideMgr.Exit(arg_30_0)
	arg_30_0:Clear()
	arg_30_0.uiFinder:Clear()
	arg_30_0.uiDuplicator:Clear()
	arg_30_0.uiLoader:Clear()
	arg_30_0.uiFloatCollctor:Clear()

	arg_30_0.state = var_0_7

	return
end

return
