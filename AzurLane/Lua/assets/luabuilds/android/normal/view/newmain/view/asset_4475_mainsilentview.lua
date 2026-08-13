class = var_0_10000

local var_0_0 = "MainSilentView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6
local var_0_8 = {
	[var_0_2] = "noti_1",
	[var_0_3] = "noti_2",
	[var_0_4] = "noti_1",
	[var_0_5] = "noti_1",
	[var_0_6] = "noti_1",
	[var_0_7] = "noti_1"
}
local var_0_9 = 1
local var_0_10 = 2

function var_0_1.getUIName(arg_1_0)
	return "MainSilentViewUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10003
	CanvasGroup = var_1_10004
	arg_2_0.cg = var_2_1(var_2_0, var_1_10003(var_1_10004))

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.animationPlayer = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.dftAniEvent = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "adapt/en/time")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.timeTxt = var_2_8(var_2_7, var_3(var_1_10004))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "adapt/en")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.timeEnTxt = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "adapt/battery/Text")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.batteryTxt = var_2_14(var_2_13, var_3(var_1_10004))

	local var_2_15 = {}
	local var_2_16 = arg_2_0._tf

	var_2_15[1] = var_2.Find(var_2_16, "adapt/battery/kwh/1")

	local var_2_17 = arg_2_0._tf

	var_2_15[2] = var_2.Find(var_2_17, "adapt/battery/kwh/2")

	local var_2_18 = arg_2_0._tf

	var_2_15[3] = var_2.Find(var_2_18, "adapt/battery/kwh/3")
	arg_2_0.electric = var_2_15

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "adapt/date")
	local var_2_21 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.dateTxt = var_2_21(var_2_20, var_3(var_4))

	local var_2_22 = arg_2_0._tf

	arg_2_0.changeBtn = var_1.Find(var_2_22, "change")
	UIItemList = var_1

	local var_2_23 = var_1.New
	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_2.Find(var_2_24, "tips")
	local var_2_26 = arg_2_0._tf

	arg_2_0.tips = var_2_23(var_2_25, var_3.Find(var_2_26, "tips/tpl"))

	local var_2_27 = arg_2_0._tf

	arg_2_0.chatTr = var_1.Find(var_2_27, "chat")

	local var_2_28 = arg_2_0.chatTr
	local var_2_29 = var_1.GetComponent

	typeof = var_3
	Text = var_2_26
	arg_2_0.chatTxt = var_2_29(var_2_28, var_3(var_2_26))
	MainChangeSkinBtn = var_1
	arg_2_0.changeSkinBtn = var_1.New(arg_2_0.changeBtn, arg_2_0.event)
	LocalSystemTimeUtil = var_1
	arg_2_0.systemTimeUtil = var_1.New()
	MainMusicPlayerView = var_1

	local var_2_30 = var_1.New
	local var_2_31 = arg_2_0._tf

	arg_2_0.musicPlayerView = var_2_30(var_2.Find(var_2_31, "adapt"), arg_2_0.event)

	local var_2_32 = arg_2_0.musicPlayerView
	local var_2_33 = var_1.Load
	local var_2_34 = arg_2_0._tf

	var_2_33(var_2_32, var_3.Find(var_2_34, "adapt/MusicPlayer").gameObject)

	local var_2_35 = arg_2_0.musicPlayerView

	var_1.ActionInvoke(var_2_35, "Hide")

	arg_2_0.playedList = {}

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.changeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.TrackingSwitchShip(var_4_0)

		arg_3_0.changeSkinCount = arg_3_0.changeSkinCount + 1

		local var_4_1 = arg_3_0.changeSkinBtn

		var_0.OnClick(var_4_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Tracking(var_5_0, var_0_9)

		local var_5_1 = arg_3_0

		var_0.Exit(var_5_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.bind

	GAME = var_3_4

	var_3_7(var_3_6, var_3_4.ZERO_HOUR_OP_DONE, function()
		local var_6_0 = arg_3_0

		var_0.FlushDate(var_6_0)

		return
	end)

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.bind

	GAME = var_3

	var_3_9(var_3_8, var_3.REMOVE_LAYERS, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_3_0

		var_2.OnRemoveLayer(var_7_0, arg_7_1.context)

		return
	end)

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.bind

	MainWordView = var_3

	var_3_11(var_3_10, var_3.SET_CONTENT, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_3_0

		var_3.SetChatTxt(var_8_0, arg_8_2)

		return
	end)

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.bind

	MainWordView = var_3

	var_3_13(var_3_12, var_3.START_ANIMATION, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_3_0

		var_3.RemoveChatTimer(var_9_0)

		local var_9_1 = arg_3_0

		var_3.AddChatTimer(var_9_1, arg_9_1 + arg_9_2)

		return
	end)

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.bind

	MainWordView = var_3

	var_3_15(var_3_14, var_3.STOP_ANIMATION, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_3_0

		var_3.RemoveChatTimer(var_10_0)

		local var_10_1 = arg_3_0

		var_3.SetChatTxt(var_10_1, "")

		return
	end)

	local var_3_16 = arg_3_0.changeSkinBtn

	var_1.Flush(var_3_16)

	return
end

function var_0_1.RemoveChatTimer(arg_11_0)
	if arg_11_0.chatTimer then
		local var_11_0 = arg_11_0.chatTimer

		var_1.Stop(var_11_0)

		arg_11_0.chatTimer = nil
	end

	return
end

function var_0_1.AddChatTimer(arg_12_0, arg_12_1)
	Timer = var_1_10002
	arg_12_0.chatTimer = var_1_10002.New(function()
		local var_13_0 = arg_12_0

		var_0.SetChatTxt(var_13_0, "")

		return
	end, arg_12_1, 1)

	local var_12_0 = arg_12_0.chatTimer

	var_2.Start(var_12_0)

	return
end

function var_0_1.SetChatTxt(arg_14_0, arg_14_1)
	setActive = var_1_10002

	var_1_10002(arg_14_0.chatTr, arg_14_1 and arg_14_1 ~= "")

	arg_14_0.chatTxt.text = arg_14_1 or ""

	return
end

function var_0_1.OnRemoveLayer(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.mediator

	CommissionInfoMediator = var_1_10003

	if var_15_0 ~= var_1_10003 then
		local var_15_1 = arg_15_1.mediator

		NotificationMediator = var_1_10003

		if var_15_1 == var_1_10003 then
			arg_15_0:Exit()
		end

		return
	end
end

function var_0_1.Exit(arg_16_0, arg_16_1)
	arg_16_0:RemoveChatTimer()
	arg_16_0:TrackingSwitchShip()

	local var_16_0 = arg_16_0.dftAniEvent

	var_2.SetEndEvent(var_16_0, nil)

	local var_16_1 = arg_16_0.dftAniEvent

	var_2.SetEndEvent(var_16_1, function()
		local var_17_0 = arg_16_0
		local var_17_1 = var_0.emit

		NewMainScene = var_2_10002

		var_17_1(var_17_0, var_2_10002.EXIT_SILENT_VIEW)

		if arg_16_1 then
			arg_16_1()
		end

		return
	end)

	local var_16_2 = arg_16_0.animationPlayer

	var_2.Play(var_16_2, "anim_silentview_out")

	return
end

function var_0_1.Tracking(arg_18_0, arg_18_1)
	pg = var_1_10002

	local var_18_0 = var_1_10002.TimeMgr.GetInstance()
	local var_18_1 = var_2.GetServerTime(var_18_0)
	local var_18_2 = arg_18_0.enterTime
	local var_18_3 = arg_18_0.changeSkinCount
	local var_18_4 = arg_18_1

	pg = var_1_10006

	local var_18_5 = var_1_10006.GameTrackerMgr.GetInstance()
	local var_18_6 = var_6.Record

	GameTrackerBuilder = var_1_10008

	var_18_6(var_18_5, var_1_10008.BuildExitSilentView(var_18_2, var_18_1, var_18_4))

	return
end

function var_0_1.TrackingSwitchShip(arg_19_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	if not var_1_10001(var_1_10002) then
		return
	end

	getProxy = var_1
	PlayerProxy = var_1_10002

	local var_19_0 = var_1(var_1_10002)

	if not var_1.getRawData(var_19_0) then
		return
	end

	local var_19_1 = var_1:GetFlagShip()
	local var_19_2 = var_2.getSkinId(var_19_1)

	isa = var_19_1

	local var_19_3 = var_2

	VirtualEducateCharShip = var_1_10006

	if var_19_1(var_19_3, var_1_10006) then
		var_19_2 = 0
	end

	pg = var_4

	local var_19_4 = var_4.TimeMgr.GetInstance()
	local var_19_5 = var_4.GetServerTime(var_19_4) - arg_19_0.paintingTime

	pg = var_1_10006

	local var_19_6 = var_1_10006.GameTrackerMgr.GetInstance()
	local var_19_7 = var_6.Record

	GameTrackerBuilder = var_1_10008

	var_19_7(var_19_6, var_1_10008.BuildSwitchPainting(var_19_2, var_19_5))

	arg_19_0.paintingTime = var_4

	return
end

function var_0_1.Show(arg_20_0)
	var_0_1.super.Show(arg_20_0)
	arg_20_0:FlushTips()
	arg_20_0:FlushBattery()
	arg_20_0:FlushTime()
	arg_20_0:FlushDate()
	arg_20_0:FlushMusicPlayer()
	arg_20_0:AddTimer()
	arg_20_0:SetChatTxt("")

	arg_20_0.changeSkinCount = 0
	pg = var_1

	local var_20_0 = var_1.TimeMgr.GetInstance()

	arg_20_0.enterTime = var_1.GetServerTime(var_20_0)
	arg_20_0.paintingTime = arg_20_0.enterTime

	return
end

function var_0_1.Reset(arg_21_0)
	var_0_1.super.Reset(arg_21_0)

	arg_21_0.exited = false

	return
end

function var_0_1.AddTimer(arg_22_0)
	arg_22_0:RemoveTimer()

	Timer = var_1
	arg_22_0.timer = var_1.New(function()
		local var_23_0 = arg_22_0

		var_0.FlushTips(var_23_0)

		local var_23_1 = arg_22_0

		var_0.FlushBattery(var_23_1)

		return
	end, 30, -1)

	local var_22_0 = arg_22_0.timer

	var_1.Start(var_22_0)

	return
end

function var_0_1.RemoveTimer(arg_24_0)
	if arg_24_0.timer then
		local var_24_0 = arg_24_0.timer

		var_1.Stop(var_24_0)

		arg_24_0.timer = nil
	end

	return
end

function var_0_1.FlushTips(arg_25_0)
	local var_25_0 = {}

	arg_25_0:CollectTips(var_25_0)

	local var_25_1 = {}
	local var_25_2 = arg_25_0.tips

	var_3.make(var_25_2, function(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		if var_2_10003.EventUpdate == arg_26_0 then
			local var_26_0 = var_25_0[arg_26_1 + 1]

			GetSpriteFromAtlas = var_4

			local var_26_1 = var_4("ui/MainUI_atlas", var_0_8[var_26_0.type])
			local var_26_2 = arg_26_2:Find("icon")
			local var_26_3 = var_5.GetComponent

			typeof = var_7
			Image = var_2_10008

			local var_26_4 = var_26_3(var_26_2, var_7(var_2_10008))

			var_26_4.sprite = var_26_1
			setText = var_26_4

			var_26_4(arg_26_2:Find("num"), var_26_0.count)

			setText = var_26_4

			local var_26_5 = arg_26_2
			local var_26_6 = arg_26_2.Find(var_26_5, "Text")

			i18n = var_26_5

			var_26_4(var_26_6, var_26_5("main_silent_tip_" .. var_26_0.type))

			onButton = var_26_4

			local var_26_7 = arg_25_0
			local var_26_8 = arg_26_2

			local function var_26_9()
				local var_27_0 = arg_25_0

				var_0.PlayTipOutAnimation(var_27_0, arg_26_2, function()
					local var_28_0 = arg_25_0

					var_0.Skip(var_28_0, var_26_0.type)

					return
				end)

				return
			end

			SFX_PANEL = var_9

			var_26_4(var_26_7, var_26_8, var_26_9, var_9)

			local var_26_10 = arg_25_0

			var_5.InsertAnimation(var_26_10, var_25_1, arg_26_2)
		end

		return
	end)

	local var_25_3 = arg_25_0.tips

	var_3.align(var_25_3, #var_25_0)

	seriesAsync = var_3

	var_3(var_25_1, function()
		return
	end)

	return
end

function var_0_1.PlayTipOutAnimation(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.cg.blocksRaycasts = false

	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_1.GetComponent

	typeof = var_1_10005
	Animation = var_1_10006

	local var_30_2 = var_30_1(var_30_0, var_1_10005(var_1_10006))
	local var_30_3 = arg_30_1
	local var_30_4 = arg_30_1.GetComponent

	typeof = var_1_10006
	DftAniEvent = var_1_10007

	local var_30_5 = var_30_4(var_30_3, var_1_10006(var_1_10007))

	var_4.SetEndEvent(var_30_5, nil)
	var_4:SetEndEvent(function()
		arg_30_0.cg.blocksRaycasts = true

		local var_31_0 = var_0

		var_0.SetEndEvent(var_31_0, nil)
		arg_30_2()

		return
	end)
	var_30_2:Play("anim_silentview_tip_out")

	return
end

function var_0_1.InsertAnimation(arg_32_0, arg_32_1, arg_32_2)
	table = var_1_10003

	if var_1_10003.contains(arg_32_0.playedList, arg_32_2) then
		return
	end

	GetOrAddComponent = var_3

	local var_32_0 = arg_32_2

	typeof = var_5
	CanvasGroup = var_1_10006

	local var_32_1 = var_3(var_32_0, var_5(var_1_10006))

	var_32_1.alpha = 0
	table = var_4

	var_4.insert(arg_32_1, function(arg_33_0)
		if arg_32_0.exited then
			return
		end

		var_32_1.alpha = 1

		local var_33_0 = arg_32_2
		local var_33_1 = var_1.GetComponent

		typeof = var_2_10003
		Animation = var_2_10004

		local var_33_2 = var_33_1(var_33_0, var_2_10003(var_2_10004))

		var_1.Play(var_33_2, "anim_silentview_tip_in")

		onDelayTick = var_2

		var_2(arg_33_0, 0.066)

		return
	end)

	table = var_4

	var_4.insert(arg_32_0.playedList, arg_32_2)

	return
end

function var_0_1.Skip(arg_34_0, arg_34_1)
	arg_34_0:Tracking(var_0_10)
	arg_34_0:Exit(function()
		if arg_34_1 == var_0_2 then
			pg = var_0

			local var_35_0 = var_0.m02
			local var_35_1 = var_0.sendNotification

			GAME = var_2_10002
			var_2_10002 = var_2_10002.GO_SCENE
			SCENE = var_2_10003

			var_35_1(var_35_0, var_2_10002, var_2_10003.EVENT)
		elseif arg_34_1 == var_0_3 then
			pg = var_0

			local var_35_2 = var_0.m02
			local var_35_3 = var_0.sendNotification

			GAME = var_2_10002
			var_2_10002 = var_2_10002.GO_SCENE
			SCENE = var_2_10003

			var_35_3(var_35_2, var_2_10002, var_2_10003.GETBOAT)
		elseif arg_34_1 == var_0_4 then
			pg = var_0

			local var_35_4 = var_0.m02
			local var_35_5 = var_0.sendNotification

			GAME = var_2_10002
			var_2_10002 = var_2_10002.GO_SCENE
			SCENE = var_2_10003

			var_35_5(var_35_4, var_2_10002, var_2_10003.TECHNOLOGY)
		elseif arg_34_1 == var_0_5 then
			pg = var_0

			local var_35_6 = var_0.m02
			local var_35_7 = var_0.sendNotification

			GAME = var_2_10002

			local var_35_8 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			local var_35_9 = var_2_10003.NAVALACADEMYSCENE
			local var_35_10 = {}

			NavalAcademyScene = var_2_10005
			var_35_10.warp = var_2_10005.WARP_TO_TACTIC

			var_35_7(var_35_6, var_35_8, var_35_9, var_35_10)
		end

		return
	end)

	return
end

function var_0_1.CollectTips(arg_36_0, arg_36_1)
	arg_36_0:CollectEventTips(arg_36_1)
	arg_36_0:CollectBuildTips(arg_36_1)
	arg_36_0:CollectTechTips(arg_36_1)
	arg_36_0:CollectStudentTips(arg_36_1)
	arg_36_0:CollectIslandTips(arg_36_1)

	return
end

function var_0_1.CollectEventTips(arg_37_0, arg_37_1)
	getProxy = var_1_10002
	EventProxy = var_1_10003

	local var_37_0 = var_1_10002(var_1_10003)
	local var_37_1 = var_2.countByState

	EventInfo = var_1_10004

	local var_37_2 = var_37_1(var_37_0, var_1_10004.StateFinish)

	if 0 < var_37_2 then
		table = var_3

		var_3.insert(arg_37_1, {
			count = var_37_2,
			type = var_0_2
		})
	end

	return
end

function var_0_1.CollectBuildTips(arg_38_0, arg_38_1)
	getProxy = var_1_10002
	BuildShipProxy = var_1_10003

	local var_38_0 = var_1_10002(var_1_10003)
	local var_38_1 = var_2.getFinishCount(var_38_0)

	if 0 < var_38_1 then
		table = var_3

		var_3.insert(arg_38_1, {
			count = var_38_1,
			type = var_0_3
		})
	end

	return
end

function var_0_1.CollectTechTips(arg_39_0, arg_39_1)
	getProxy = var_1_10002
	TechnologyProxy = var_1_10003

	local var_39_0 = var_1_10002(var_1_10003)
	local var_39_1 = var_2.getPlanningTechnologys(var_39_0)
	local var_39_2 = 0

	pairs = var_1_10004

	for iter_39_0, iter_39_1 in var_1_10004(var_39_1) do
		if iter_39_1:isCompleted() then
			var_39_2 = var_39_2 + 1
		end
	end

	if 0 < var_39_2 then
		table = var_4

		var_4.insert(arg_39_1, {
			count = var_39_2,
			type = var_0_4
		})
	end

	return
end

function var_0_1.CollectStudentTips(arg_40_0, arg_40_1)
	getProxy = var_1_10002
	NavalAcademyProxy = var_1_10003

	local var_40_0 = var_1_10002(var_1_10003)
	local var_40_1 = var_2.RawGetStudentList(var_40_0)
	local var_40_2 = 0

	pairs = var_1_10004

	for iter_40_0, iter_40_1 in var_1_10004(var_40_1) do
		if iter_40_1:IsFinish() then
			var_40_2 = var_40_2 + 1
		end
	end

	if 0 < var_40_2 then
		table = var_4

		var_4.insert(arg_40_1, {
			count = var_40_2,
			type = var_0_5
		})
	end

	return
end

function var_0_1.CollectIslandTips(arg_41_0, arg_41_1)
	LOCK_ISLAND_DISPLAY = var_1_10002

	if var_1_10002 then
		return
	end

	getProxy = var_1_10002
	SystemTipProxy = var_1_10003

	local var_41_0 = var_1_10002(var_1_10003)
	local var_41_1, var_41_2 = var_2.GetIslandTipInfos(var_41_0)

	if 0 < var_41_1 then
		table = var_4

		var_4.insert(arg_41_1, {
			count = var_41_1,
			type = var_0_6
		})
	end

	if 0 < var_41_2 then
		table = var_4

		var_4.insert(arg_41_1, {
			count = var_41_2,
			type = var_0_7
		})
	end

	return
end

function var_0_1.FlushBattery(arg_42_0)
	SystemInfo = var_1_10001

	local var_42_0

	if var_1_10001.batteryLevel < 0 then
		var_42_0 = 1
	end

	math = var_2

	local var_42_1 = var_2.floor(var_42_0 * 100)

	arg_42_0.batteryTxt.text = var_42_1 .. "%"

	local var_42_2 = 1 / #arg_42_0.electric

	ipairs = var_4

	for iter_42_0, iter_42_1 in var_4(arg_42_0.electric) do
		local var_42_3 = var_42_1 < (iter_42_0 - 1) * var_42_2

		setActive = var_1_10010

		var_1_10010(iter_42_1, not var_42_3)
	end

	return
end

function var_0_1.FlushTime(arg_43_0)
	local var_43_0 = arg_43_0.systemTimeUtil

	var_1.SetUp(var_43_0, function(arg_44_0, arg_44_1, arg_44_2)
		SettingsMainScenePanel = var_2_10003

		if var_2_10003.IsEnable24HourSystem() then
			local var_44_0 = arg_43_0.timeEnTxt

			Color = var_2_10004
			var_44_0.color = var_2_10004.New(1, 1, 1, 0)
		else
			local var_44_1 = arg_43_0.timeEnTxt

			Color = var_2_10004
			var_44_1.color = var_2_10004.New(1, 1, 1, 1)
			arg_44_0 = arg_44_0 > 12 and arg_44_0 - 12 or arg_44_0
		end

		if arg_44_0 < 10 then
			arg_44_0 = "0" .. arg_44_0
		end

		arg_43_0.timeTxt.text = arg_44_0 .. ":" .. arg_44_1
		arg_43_0.timeEnTxt.text = arg_44_2

		return
	end)

	return
end

local var_0_11 = {
	"MONDAY",
	"TUESDAY",
	"WEDNESDAY",
	"THURSDAY",
	"FRIDAY",
	"SATURDAY",
	"SUNDAY"
}
local var_0_12 = {
	"JAN",
	"FEB",
	"MAR",
	"APR",
	"MAY",
	"JUN",
	"JUL",
	"AUG",
	"SEP",
	"OCT",
	"NOV",
	"DEC"
}

function var_0_1.FlushDate(arg_45_0)
	os = var_1_10001

	local var_45_0 = var_1_10001.date("%Y/%m/%d")

	string = var_2

	local var_45_1 = var_2.split(var_45_0, "/")[1]

	tonumber = var_4

	local var_45_2 = var_4(var_2[2])
	local var_45_3 = var_2[3]

	pg = var_1_10006

	local var_45_4 = var_1_10006.TimeMgr.GetInstance()
	local var_45_5 = var_6.GetServerWeek(var_45_4)
	local var_45_6 = {
		var_0_11[var_45_5],
		var_0_12[var_45_2],
		var_45_3,
		var_45_1
	}
	local var_45_7 = arg_45_0.dateTxt

	table = var_1_10009
	var_45_7.text = var_1_10009.concat(var_45_6, " / ")

	return
end

function var_0_1.FlushMusicPlayer(arg_46_0)
	pg = var_1_10001

	local var_46_0 = var_1_10001.BgmMgr.GetInstance()
	local var_46_1 = var_1.GetNow(var_46_0) == "MainMusicPlayer"

	tobool = var_46_0

	local var_46_2 = arg_46_0.musicPlayerView

	if var_46_0(var_3.isShowing(var_46_2)) ~= var_46_1 then
		if var_46_1 then
			local var_46_3 = arg_46_0.musicPlayerView

			var_2.ExecuteAction(var_46_3, "Show", true)
		else
			local var_46_4 = arg_46_0.musicPlayerView

			var_2.ExecuteAction(var_46_4, "Hide")
		end
	end

	return
end

function var_0_1.OnDestroy(arg_47_0)
	arg_47_0:RemoveChatTimer()

	arg_47_0.exited = true

	local var_47_0 = arg_47_0.dftAniEvent

	var_1.SetEndEvent(var_47_0, nil)
	arg_47_0:RemoveTimer()

	local var_47_1 = arg_47_0.changeSkinBtn

	var_1.Dispose(var_47_1)

	arg_47_0.changeSkinBtn = nil

	local var_47_2 = arg_47_0.systemTimeUtil

	var_1.Dispose(var_47_2)

	arg_47_0.systemTimeUtil = nil

	local var_47_3 = arg_47_0.musicPlayerView

	var_1.Destroy(var_47_3)

	arg_47_0.musicPlayerView = nil

	return
end

return var_0_1
