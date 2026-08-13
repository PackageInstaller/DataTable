class = var_0_10000

local var_0_0 = "MainBasePainting"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseEventLogic"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	pg = var_3

	var_3.DelegateInfo.New(arg_1_0)

	arg_1_0.container = arg_1_1
	arg_1_0.state = var_0_2
	pg = var_3
	var_0_6 = var_3.AssistantInfo
	arg_1_0.wordPosition = arg_1_1:Find("live2d")
	MainCVLoader = var_3
	arg_1_0.cvLoader = var_3.New()
	arg_1_0.longPressEvent = arg_1_1:GetComponent("UILongPressTrigger").onLongPressed
	arg_1_0.replaceWord = false
	arg_1_0._asmrFlag = false

	return
end

function var_0_1.IsUnload(arg_2_0)
	return arg_2_0.state == var_0_5
end

function var_0_1.GetCenterPos(arg_3_0)
	return arg_3_0.wordPosition.position
end

function var_0_1.IsLoading(arg_4_0)
	return arg_4_0.state == var_0_3
end

function var_0_1.IsLoaded(arg_5_0)
	return arg_5_0.state == var_0_4
end

function var_0_1.SetOnceLoadedCall(arg_6_0, arg_6_1)
	arg_6_0.loadedCallback = arg_6_1

	return
end

function var_0_1.Load(arg_7_0, arg_7_1)
	arg_7_0.isPuase = false
	arg_7_0.isExited = false
	arg_7_0.state = var_0_3
	arg_7_0.ship = arg_7_1
	arg_7_0.paintingName = arg_7_1:getPainting()

	arg_7_0:OnLoad(function()
		arg_7_0.state = var_0_4

		if arg_7_0.triggerWhenLoaded then
			local var_8_0 = arg_7_0

			var_0.TriggerEventAtFirstTime(var_8_0)
		else
			local var_8_1 = arg_7_0

			var_0.TriggerNextEventAuto(var_8_1)
		end

		local var_8_2 = arg_7_0

		var_0.InitClickEvent(var_8_2)

		return
	end)

	return
end

function var_0_1.Unload(arg_9_0)
	arg_9_0.state = var_0_5
	removeOnButton = var_1

	var_1(arg_9_0.container)

	local var_9_0 = arg_9_0.longPressEvent

	var_1.RemoveAllListeners(var_9_0)
	arg_9_0:StopChatAnimtion()

	local var_9_1 = arg_9_0.cvLoader

	var_1.Stop(var_9_1)
	arg_9_0:RemoveTimer()
	arg_9_0:OnUnload()

	arg_9_0.paintingName = nil
	LeanTween = var_1

	var_1.cancel(arg_9_0.container.gameObject)

	return
end

function var_0_1.UnloadOnlyPainting(arg_10_0)
	arg_10_0.state = var_0_5
	removeOnButton = var_1

	var_1(arg_10_0.container)

	local var_10_0 = arg_10_0.longPressEvent

	var_1.RemoveAllListeners(var_10_0)
	arg_10_0:RemoveTimer()
	arg_10_0:OnUnload()

	arg_10_0.paintingName = nil

	return
end

function var_0_1.InitClickEvent(arg_11_0)
	onButton = var_1_10001

	var_1_10001(arg_11_0, arg_11_0.container, function()
		local var_12_0 = arg_11_0

		var_0.OnClick(var_12_0)

		local var_12_1 = arg_11_0

		var_0.TriggerPersonalTask(var_12_1, arg_11_0.ship.groupId)

		return
	end)

	local var_11_0 = arg_11_0.longPressEvent

	var_1.RemoveAllListeners(var_11_0)

	local var_11_1 = arg_11_0.longPressEvent

	var_1.AddListener(var_11_1, function()
		if arg_11_0._asmrFlag then
			return
		end

		getProxy = var_0
		ContextProxy = var_2_10002

		local var_13_0 = var_0(var_2_10002)

		if var_0.getCurrentContext(var_13_0).viewComponent.__cname == "NewMainScene" then
			local var_13_1 = arg_11_0

			var_1.OnLongPress(var_13_1)
		end

		return
	end)

	return
end

function var_0_1.TriggerPersonalTask(arg_14_0, arg_14_1)
	if arg_14_0.isFoldState then
		return
	end

	local var_14_0 = arg_14_0

	arg_14_0.TriggerInterActionTask(var_14_0)

	getProxy = var_2
	TaskProxy = var_14_0

	local var_14_1 = var_2(var_14_0)

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10003(var_1_10005.task_data_trigger.all) do
		pg = var_1_10008

		if var_1_10008.task_data_trigger[iter_14_1].group_id == arg_14_1 then
			local var_14_2 = var_1_10008.task_id

			if not var_14_1:getFinishTaskById(var_14_2) then
				arg_14_0:CheckStoryDownload(var_14_2, function()
					pg = var_2_10000

					local var_15_0 = var_2_10000.m02
					local var_15_1 = var_0.sendNotification

					GAME = var_2_10003

					var_15_1(var_15_0, var_2_10003.TRIGGER_TASK, var_14_2)

					return
				end)

				break
			end
		end
	end

	return
end

function var_0_1.TriggerInterActionTask(arg_16_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_16_0 = var_1_10001(var_1_10003)

	if var_1.GetFlagShipInterActionTaskList(var_16_0) and #var_2 > 0 then
		ipairs = var_3

		for iter_16_0, iter_16_1 in var_3(var_2) do
			pg = var_1_10008

			local var_16_1 = var_1_10008.m02

			var_1_10008 = var_1_10008.sendNotification
			GAME = var_1_10011

			var_1_10008(var_16_1, var_1_10011.UPDATE_TASK_PROGRESS, {
				taskId = iter_16_1.id
			})
		end
	end

	return
end

function var_0_1.CheckStoryDownload(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = arg_17_1

	while true do
		pg = var_1_10005

		if var_1_10005.task_data_template[var_17_1].story_id ~= "" then
			table = var_1_10006

			var_1_10006.insert(var_17_0, var_1_10005.story_id)
		end

		if var_1_10005.next_task == "" or var_1_10005.next_task == "0" then
			break
		end

		var_17_1 = var_17_1 + 1
	end

	pg = var_1_10005

	local var_17_2 = var_1_10005.NewStoryMgr.GetInstance()
	local var_17_3 = var_5.GetStoryPaintingsByNameList(var_17_2, var_17_0)

	_ = var_1_10006

	local var_17_4 = var_1_10006.map(var_17_3, function(arg_18_0)
		return "painting/" .. arg_18_0
	end)

	PaintingGroupConst = var_17_2

	var_17_2.PaintingDownload({
		isShowBox = true,
		paintingNameList = var_17_4,
		finishFunc = arg_17_2
	})

	return
end

function var_0_1.TriggerEventAtFirstTime(arg_19_0)
	if not arg_19_0:IsLoaded() then
		arg_19_0.triggerWhenLoaded = true

		return
	end

	arg_19_0.triggerWhenLoaded = false

	arg_19_0:OnFirstTimeTriggerEvent()

	return
end

function var_0_1.OnFirstTimeTriggerEvent(arg_20_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)

	arg_20_0._loginAction = var_1.getFlag(var_20_0, "login")
	getProxy = var_1
	PlayerProxy = var_20_0

	local var_20_1 = var_1(var_20_0)

	arg_20_0._battleAction = var_1.getFlag(var_20_1, "battle")
	getProxy = var_1
	PlayerProxy = var_20_1

	local var_20_2 = var_1(var_20_1)

	var_1.setFlag(var_20_2, "login", false)

	getProxy = var_1
	PlayerProxy = var_20_2

	local var_20_3 = var_1(var_20_2)

	var_1.setFlag(var_20_3, "battle", false)

	local function var_20_4(arg_21_0)
		local var_21_0 = arg_20_0

		var_1.PrepareTriggerAction(var_21_0, arg_21_0)

		return
	end

	if arg_20_0._loginAction then
		arg_20_0._loginAction = false

		var_20_4("event_login")
	elseif arg_20_0._battleAction then
		arg_20_0._battleAction = false

		var_20_4("home")
	else
		arg_20_0:TriggerNextEventAuto()
	end

	return
end

function var_0_1.PrepareTriggerAction(arg_22_0, arg_22_1)
	arg_22_0:TryToTriggerEvent(arg_22_1)

	return
end

function var_0_1.TryToTriggerEvent(arg_23_0, arg_23_1)
	arg_23_0:_TriggerEvent(arg_23_1)

	return
end

function var_0_1._TriggerEvent(arg_24_0, arg_24_1)
	pg = var_1_10002

	if var_1_10002.AssistantInfo.GetAssistantEvents(arg_24_1).dialog ~= "" then
		arg_24_0:DisplayWord(var_2.dialog)
	else
		arg_24_0:TriggerNextEventAuto()
	end

	return
end

function var_0_1.SetShift(arg_25_0, arg_25_1)
	arg_25_0._shift = arg_25_1

	return
end

function var_0_1.TriggerEvent(arg_26_0, arg_26_1)
	if arg_26_0.isDragAndZoomState then
		return
	end

	if arg_26_0.chatting then
		return
	end

	arg_26_0:RemoveTimer()
	arg_26_0:PrepareTriggerAction(arg_26_1)
	arg_26_0:OnTriggerEvent()

	return
end

function var_0_1.TriggerNextEventAuto(arg_27_0)
	if arg_27_0.isPuase or arg_27_0.isExited and arg_27_0._asmrFlag then
		return
	end

	arg_27_0:OnEndChatting()
	arg_27_0:RemoveTimer()

	Timer = var_1
	arg_27_0.timer = var_1.New(function()
		local var_28_0 = arg_27_0

		var_0.OnTimerTriggerEvent(var_28_0)

		return
	end, 30, 1, true)

	local var_27_0 = arg_27_0.timer

	var_1.Start(var_27_0)

	return
end

function var_0_1.OnTimerTriggerEvent(arg_29_0)
	if arg_29_0:OnEnableTimerEvent() then
		local var_29_0 = arg_29_0:CollectIdleEvents(arg_29_0.lastChatEvent)

		math = var_1_10002

		local var_29_1 = var_1_10002.ceil

		math = var_4
		arg_29_0.lastChatEvent = var_29_0[var_29_1(var_4.random(#var_29_0))]

		arg_29_0:PrepareTriggerAction(arg_29_0.lastChatEvent)
		arg_29_0:OnTriggerEventAuto()
		arg_29_0:RemoveTimer()
	end

	return
end

function var_0_1.OnEnableTimerEvent(arg_30_0)
	return true
end

function var_0_1.OnStartChatting(arg_31_0)
	arg_31_0.chatting = true

	return
end

function var_0_1.OnEndChatting(arg_32_0)
	arg_32_0.chatting = false

	return
end

function var_0_1.GetWordAndCv(arg_33_0, arg_33_1, arg_33_2)
	ShipWordHelper = var_1_10003

	local var_33_0, var_33_1, var_33_2, var_33_3, var_33_4, var_33_5 = var_1_10003.GetCvDataForShip(arg_33_0.ship, arg_33_2)

	return var_33_0, var_33_1, var_33_2, var_33_3, var_33_4, var_33_5
end

function var_0_1.DisplayWord(arg_34_0, arg_34_1)
	arg_34_0:OnStartChatting()

	local var_34_0, var_34_1, var_34_2, var_34_3, var_34_4, var_34_5 = arg_34_0:GetWordAndCv(arg_34_0.ship, arg_34_1)

	if not var_34_2 or var_34_2 == nil or var_34_2 == "" or var_34_2 == "nil" then
		arg_34_0:OnEndChatting()
		arg_34_0:OnDisplayWordEnd()

		return
	end

	arg_34_0:OnDisplayWorld(arg_34_1)

	if arg_34_0._asmrFlag then
		local var_34_6 = arg_34_0
		local var_34_7 = arg_34_0.emit

		MainAsmrChatView = var_11

		var_34_7(var_34_6, var_11.SET_CONTENT, arg_34_1, var_34_2)
	else
		local var_34_8 = arg_34_0
		local var_34_9 = arg_34_0.emit

		MainWordView = var_11

		var_34_9(var_34_8, var_11.SET_CONTENT, arg_34_1, var_34_2)
	end

	arg_34_0:PlayCvAndAnimation(var_34_4, var_34_3, var_34_1)

	return
end

function var_0_1.PlayCvAndAnimation(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	getProxy = var_1_10004
	ContextProxy = var_1_10006

	local var_35_0 = var_1_10004(var_1_10006)
	local var_35_1 = var_4.getContextByMediator

	NewShipMediator = var_1_10007

	if var_35_1(var_35_0, var_1_10007) then
		arg_35_0:OnEndChatting()

		return
	end

	local var_35_2 = -1

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_36_0)
			if arg_35_3 then
				pg = var_1

				local var_36_0 = var_1.NewStoryMgr.GetInstance()

				if not not var_1.IsRunning(var_36_0) then
					arg_36_0()

					return
				end

				local var_36_1 = arg_35_0

				var_1.PlayCV(var_36_1, arg_35_1, arg_35_2, arg_35_3, function(arg_37_0)
					var_35_2 = arg_37_0

					arg_36_0()

					return
				end)

				return
			end
		end,
		function(arg_38_0)
			local var_38_0 = arg_35_0

			var_1.StartChatAnimtion(var_38_0, var_35_2, arg_38_0)

			return
		end
	}, function()
		local var_39_0 = arg_35_0

		var_0.OnDisplayWordEnd(var_39_0)

		return
	end)

	return
end

function var_0_1.OnDisplayWordEnd(arg_40_0)
	arg_40_0:TriggerNextEventAuto()

	return
end

function var_0_1.PlayCV(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	ShipWordHelper = var_1_10005

	local var_41_0 = var_1_10005.RawGetCVKey
	local var_41_1 = arg_41_0.ship
	local var_41_2 = var_41_0(var_7.getSkinId(var_41_1))

	pg = var_1_10006

	local var_41_3 = var_1_10006.CriMgr.GetCVBankName(var_41_2)
	local var_41_4 = arg_41_0.cvLoader

	var_7.Load(var_41_4, var_41_3, arg_41_3, 0, arg_41_4)

	return
end

function var_0_1.preloadCv(arg_42_0, arg_42_1)
	ShipWordHelper = var_1_10002

	local var_42_0 = var_1_10002.RawGetCVKey
	local var_42_1 = arg_42_0.ship
	local var_42_2 = var_42_0(var_4.getSkinId(var_42_1))

	pg = var_1_10003

	local var_42_3 = var_1_10003.CriMgr.GetCVBankName(var_42_2)
	local var_42_4 = arg_42_0.cvLoader

	var_4.preloadCv(var_42_4, var_42_3, arg_42_1)

	return
end

function var_0_1.OnAsmrTurnning(arg_43_0, arg_43_1)
	arg_43_0._asmrFlag = arg_43_1

	return
end

function var_0_1.setReplaceWord(arg_44_0, arg_44_1)
	arg_44_0.replaceWord = arg_44_1

	return
end

function var_0_1.getReplaceWord(arg_45_0)
	return arg_45_0.replaceWord
end

function var_0_1.StartChatAnimtion(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = 0.3
	local var_46_1 = arg_46_1 > 0 and arg_46_1 or 3

	if arg_46_0._asmrFlag then
		local var_46_2 = arg_46_0
		local var_46_3 = arg_46_0.emit

		MainAsmrChatView = var_1_10008

		var_46_3(var_46_2, var_1_10008.START_CHAT, var_46_0, var_46_1)
	else
		local var_46_4 = arg_46_0
		local var_46_5 = arg_46_0.emit

		MainWordView = var_1_10008

		var_46_5(var_46_4, var_1_10008.START_ANIMATION, var_46_0, var_46_1)
	end

	arg_46_0:AddCharTimer(function()
		local var_47_0 = arg_46_0

		if var_0.IsUnload(var_47_0) then
			return
		end

		arg_46_2()

		return
	end, var_46_0 * 3 + var_46_1)

	return
end

function var_0_1.AddCharTimer(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0:RemoveChatTimer()

	Timer = var_3
	arg_48_0.chatTimer = var_3.New(arg_48_1, arg_48_2, 1)

	local var_48_0 = arg_48_0.chatTimer

	var_3.Start(var_48_0)

	return
end

function var_0_1.RemoveChatTimer(arg_49_0)
	if arg_49_0.chatTimer then
		local var_49_0 = arg_49_0.chatTimer

		var_1.Stop(var_49_0)

		arg_49_0.chatTimer = nil
	end

	return
end

function var_0_1.StopChatAnimtion(arg_50_0)
	if not arg_50_0._asmrFlag then
		local var_50_0 = arg_50_0
		local var_50_1 = arg_50_0.emit

		MainWordView = var_1_10004

		var_50_1(var_50_0, var_1_10004.STOP_ANIMATION)
	end

	arg_50_0:OnEndChatting()

	return
end

function var_0_1.OnStopVoice(arg_51_0)
	local var_51_0 = arg_51_0.cvLoader

	var_1.Stop(var_51_0)

	return
end

function var_0_1.CollectIdleEvents(arg_52_0, arg_52_1)
	local var_52_0 = {}

	getProxy = var_1_10003
	EventProxy = var_1_10005

	local var_52_1 = var_1_10003(var_1_10005)

	if var_3.hasFinishState(var_52_1) and arg_52_1 ~= "event_complete" then
		table = var_3

		var_3.insert(var_52_0, "event_complete")
	else
		getProxy = var_3
		TaskProxy = var_52_1

		local var_52_2 = var_3(var_52_1)

		if var_3.getCanReceiveCount(var_52_2) > 0 and arg_52_1 ~= "mission_complete" then
			table = var_3

			var_3.insert(var_52_0, "mission_complete")
		end

		getProxy = var_3
		MailProxy = var_52_2

		local var_52_3 = var_3(var_52_2)

		if var_3.GetUnreadCount(var_52_3) > 0 and arg_52_1 ~= "mail" then
			table = var_3

			var_3.insert(var_52_0, "mail")
		end

		if #var_52_0 == 0 then
			local var_52_4 = var_0_6.GetShipMainEvents
			local var_52_5 = arg_52_0.ship
			local var_52_6 = var_5.getSkinId(var_52_5)
			local var_52_7 = arg_52_0.ship

			var_52_0 = var_52_4(var_52_6, var_6.getCVIntimacy(var_52_7))
			getProxy = var_3
			TaskProxy = var_52_6

			local var_52_8 = var_3(var_52_6)

			if var_3.getNotFinishCount(var_52_8) then
				getProxy = var_3
				TaskProxy = var_52_8

				local var_52_9 = var_3(var_52_8)

				if var_3.getNotFinishCount(var_52_9) > 0 and arg_52_1 ~= "mission" then
					table = var_3

					var_3.insert(var_52_0, "mission")
				end
			end
		end
	end

	return var_52_0
end

function var_0_1.CollectTouchEvents(arg_53_0)
	local var_53_0 = arg_53_0.ship
	local var_53_1 = var_1.getCVIntimacy(var_53_0)
	local var_53_2 = var_0_6.filterAssistantEvents
	local var_53_3 = var_0_6.GetShipTouchEvents
	local var_53_4 = arg_53_0.ship
	local var_53_5 = var_53_3(var_6.getSkinId(var_53_4), var_53_1)
	local var_53_6 = arg_53_0.ship

	return (var_53_2(var_53_5, var_5.getSkinId(var_53_6), var_53_1))
end

function var_0_1.GetTouchEvent(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0.ship
	local var_54_1 = var_2.getCVIntimacy(var_54_0)
	local var_54_2 = var_0_6.filterAssistantEvents
	local var_54_3 = var_0_6.getAssistantTouchEvents
	local var_54_4 = arg_54_1
	local var_54_5 = arg_54_0.ship
	local var_54_6 = var_54_3(var_54_4, var_8.getSkinId(var_54_5))
	local var_54_7 = arg_54_0.ship

	return (var_54_2(var_54_6, var_6.getSkinId(var_54_7), 0))
end

function var_0_1.GetIdleEvents(arg_55_0)
	local var_55_0 = arg_55_0.ship
	local var_55_1 = var_1.getCVIntimacy(var_55_0)
	local var_55_2 = var_0_6.filterAssistantEvents
	local var_55_3 = var_0_6.GetShipMainEvents
	local var_55_4 = arg_55_0.ship
	local var_55_5 = var_55_3(var_6.getSkinId(var_55_4), 0)
	local var_55_6 = arg_55_0.ship

	return (var_55_2(var_55_5, var_5.getSkinId(var_55_6), 0))
end

function var_0_1.GetEventConfig(arg_56_0, arg_56_1)
	pg = var_1_10002

	return var_1_10002.AssistantInfo.GetAssistantEvents(arg_56_1)
end

function var_0_1.GetSpecialTouchEvent(arg_57_0, arg_57_1)
	return var_0_6.getPaintingTouchEvents(arg_57_1)
end

function var_0_1.RemoveTimer(arg_58_0)
	if arg_58_0.timer then
		local var_58_0 = arg_58_0.timer

		var_1.Stop(var_58_0)

		arg_58_0.timer = nil
	end

	return
end

function var_0_1.IsExited(arg_59_0)
	return arg_59_0.isExited
end

function var_0_1.Fold(arg_60_0, arg_60_1, arg_60_2)
	arg_60_0.isFoldState = arg_60_1

	arg_60_0:RemoveMoveTimer()
	arg_60_0:OnFold(arg_60_1)

	return
end

function var_0_1.RemoveMoveTimer(arg_61_0)
	if arg_61_0.moveTimer then
		local var_61_0 = arg_61_0.moveTimer

		var_1.Stop(var_61_0)

		arg_61_0.moveTimer = nil
	end

	return
end

function var_0_1.EnableOrDisableMove(arg_62_0, arg_62_1)
	arg_62_0.isDragAndZoomState = arg_62_1

	arg_62_0:RemoveMoveTimer()

	if arg_62_1 then
		arg_62_0:StopChatAnimtion()
		arg_62_0:RemoveTimer()

		local var_62_0 = arg_62_0.cvLoader

		var_2.Stop(var_62_0)
	else
		arg_62_0:TriggerNextEventAuto()
	end

	arg_62_0:OnEnableOrDisableDragAndZoom(arg_62_1)

	return
end

function var_0_1.GetOffset(arg_63_0)
	return 0
end

function var_0_1.UpdateBound(arg_64_0)
	return
end

function var_0_1.IslimitYPos(arg_65_0)
	return false
end

function var_0_1.PlayChangeSkinActionIn(arg_66_0, arg_66_1)
	return
end

function var_0_1.PlayChangeSkinActionOut(arg_67_0, arg_67_1)
	return
end

function var_0_1.PauseForSilent(arg_68_0)
	SettingsMainScenePanel = var_1_10001

	if var_1_10001.IsEnableFlagShipInteraction() then
		return
	end

	if arg_68_0:IsLoaded() then
		arg_68_0:_Pause()
	end

	return
end

function var_0_1._Pause(arg_69_0)
	arg_69_0.isPuase = true

	arg_69_0:RemoveMoveTimer()
	arg_69_0:StopChatAnimtion()
	arg_69_0:RemoveChatTimer()
	arg_69_0:RemoveTimer()

	local var_69_0 = arg_69_0.cvLoader

	var_1.Stop(var_69_0)

	return
end

function var_0_1.Pause(arg_70_0)
	arg_70_0:_Pause()
	arg_70_0:OnPause()

	return
end

function var_0_1.ResumeForSilent(arg_71_0)
	SettingsMainScenePanel = var_1_10001

	if var_1_10001.IsEnableFlagShipInteraction() then
		return
	end

	if arg_71_0:IsLoaded() then
		arg_71_0:_Resume()
	end

	return
end

function var_0_1._Resume(arg_72_0)
	arg_72_0.isPuase = false

	arg_72_0:TriggerNextEventAuto()

	return
end

function var_0_1.Resume(arg_73_0)
	arg_73_0:_Resume()
	arg_73_0:OnResume()

	return
end

function var_0_1.updateShip(arg_74_0, arg_74_1)
	if arg_74_1 and arg_74_0.ship.id == arg_74_1.id then
		arg_74_0.ship = arg_74_1
	end

	arg_74_0:OnUpdateShip(arg_74_1)

	return
end

function var_0_1.OnUpdateShip(arg_75_0, arg_75_1)
	return
end

function var_0_1.InitScalePart(arg_76_0)
	if arg_76_0:GetPartScaleData() then
		local var_76_0 = #var_1

		if 0 < var_76_0 then
			arg_76_0.partScaleList = {}
			arg_76_0.partScaleSelectList = {}

			if arg_76_0:GetPaintingTransform() then
				ipairs = var_3

				for iter_76_0, iter_76_1 in var_3(var_1) do
					findTF = var_1_10008

					if var_1_10008(var_2, iter_76_1) then
						GetOrAddComponent = var_1_10009

						local var_76_1 = var_1_10008

						typeof = var_1_10012
						PinchZoom = var_1_10014
						var_1_10009 = var_1_10009(var_76_1, var_1_10012(var_1_10014))
						var_1_10009.enabled = false
						PoolMgr = var_10
						var_1_10012 = var_10.GetInstance()

						var_10.GetUI(var_1_10012, "mainuiscalepart", false, function(arg_77_0)
							SetParent = var_2_10001

							var_2_10001(arg_77_0, var_1_10008)

							setActive = var_2_10001

							var_2_10001(arg_77_0, false)

							table = var_2_10001

							local var_77_0 = var_2_10001.insert
							local var_77_1 = arg_76_0.partScaleSelectList
							local var_77_2 = {}

							tf = var_2_10005
							var_77_2.tf = var_2_10005(arg_77_0)
							var_77_2.name = iter_76_1

							var_77_0(var_77_1, var_77_2)

							return
						end)

						onButton = var_10

						var_10(arg_76_0._event, var_1_10008, function()
							if arg_76_0.partScaleFlag then
								arg_76_0.selectPartName = iter_76_1

								local var_78_0 = arg_76_0

								var_0.updateSelectPartScale(var_78_0)
							end

							return
						end)

						var_1_10012 = arg_76_0

						arg_76_0.ResetPartScale(var_1_10012, true)

						table = var_10

						var_10.insert(arg_76_0.partScaleList, {
							name = iter_76_1,
							tf = var_1_10008,
							com = var_1_10009
						})
					end
				end
			end
		end
	end

	return
end

function var_0_1.updatePartCotent(arg_79_0, arg_79_1)
	for iter_79_0 = 1, #arg_79_0.partScaleSelectList do
		if arg_79_1 then
			local var_79_0 = arg_79_0

			var_1_10006 = arg_79_0.emit
			NewMainScene = var_1_10009

			var_1_10006(var_79_0, var_1_10009.SET_SCALE_PART_CONTENT, arg_79_0.partScaleSelectList[iter_79_0].tf)
		else
			setParent = var_1_10006

			var_1_10006(arg_79_0.partScaleSelectList[iter_79_0].tf, arg_79_0:GetPaintingTransform(), true)
		end
	end

	return
end

function var_0_1.updateSelectPartScale(arg_80_0)
	for iter_80_0 = 1, #arg_80_0.partScaleList do
		local var_80_0 = arg_80_0.partScaleList[iter_80_0]
		local var_80_1

		if arg_80_0.partScaleFlag then
			var_80_1 = var_80_0.name == arg_80_0.selectPartName
		end

		local var_80_2 = var_80_0.com

		var_80_2.enabled = var_80_1
		setActive = var_80_2

		local var_80_3 = arg_80_0.partScaleSelectList[iter_80_0].tf
		local var_80_4

		if arg_80_0.partScaleFlag then
			var_80_4 = arg_80_0.partScaleSelectList[iter_80_0].name == arg_80_0.selectPartName
		end

		var_80_2(var_80_3, var_80_4)
	end

	return
end

function var_0_1.ClearScalePart(arg_81_0)
	if arg_81_0.partScaleList and #arg_81_0.partScaleList > 0 then
		for iter_81_0 = 1, #arg_81_0.partScaleList do
			if arg_81_0.partScaleList[iter_81_0].tf then
				removeOnButton = var_5

				var_5(arg_81_0.partScaleList[iter_81_0].tf)
			end
		end

		arg_81_0.partScaleList = nil
	end

	if arg_81_0.partScaleSelectList and #arg_81_0.partScaleSelectList > 0 then
		for iter_81_1 = 1, #arg_81_0.partScaleSelectList do
			if arg_81_0.partScaleSelectList[iter_81_1].tf then
				PoolMgr = var_5

				local var_81_0 = var_5.GetInstance()
				local var_81_1 = var_5.ReturnUI
				local var_81_2 = "mainuiscalepart"

				go = var_1_10009

				var_81_1(var_81_0, var_81_2, var_1_10009(arg_81_0.partScaleSelectList[iter_81_1].tf))
			end
		end

		arg_81_0.partScaleSelectList = nil
	end

	return
end

function var_0_1.OnEnablePartScale(arg_82_0, arg_82_1)
	if arg_82_0.partScaleList then
		arg_82_0.partScaleFlag = arg_82_1
		arg_82_0.selectPartName = nil

		for iter_82_0 = 1, #arg_82_0.partScaleList do
			local var_82_0

			var_82_0, GetOrAddComponent = arg_82_0.partScaleList[iter_82_0].tf, var_1_10007
			typeof = var_1_10010
			CanvasGroup = var_1_10012
			var_1_10007 = var_1_10007(var_82_0, var_1_10010(var_1_10012))
			var_1_10007.blocksRaycasts = arg_82_1
		end

		arg_82_0:updateSelectPartScale()
		arg_82_0:updatePartCotent(arg_82_1)

		if not arg_82_1 then
			arg_82_0:ResetPartScale(true)
		end
	end

	return
end

function var_0_1.ResetPartScale(arg_83_0, arg_83_1)
	if arg_83_0.partScaleList and #arg_83_0.partScaleList > 0 then
		for iter_83_0 = 1, #arg_83_0.partScaleList do
			local var_83_0 = arg_83_0.partScaleList[iter_83_0].tf
			local var_83_1 = arg_83_0.partScaleList[iter_83_0].name

			if arg_83_1 then
				getProxy = var_1_10008
				SettingsProxy = var_1_10010
				var_1_10010 = var_1_10008(var_1_10010)

				if not var_1_10008.getSkinScaleSetting(var_1_10010, arg_83_0.ship, arg_83_0:GetPartStateType(), var_83_1) then
					var_1_10008 = 1
				end

				Vector3 = var_1_10009
				var_83_0.localScale = var_1_10009(var_1_10008, var_1_10008, var_1_10008)
			end
		end
	end

	return
end

function var_0_1.SavePartScaleData(arg_84_0)
	if not arg_84_0.partScaleList or #arg_84_0.partScaleList == 0 then
		return
	end

	if not arg_84_0.ship then
		return
	end

	for iter_84_0 = 1, #arg_84_0.partScaleList do
		local var_84_0 = arg_84_0.partScaleList[iter_84_0]
		local var_84_1 = arg_84_0:GetPartStateType()
		local var_84_2 = var_84_0.name
		local var_84_3 = var_84_0.tf.localScale.x

		getProxy = var_1_10009
		SettingsProxy = var_1_10011
		var_1_10011 = var_1_10009(var_1_10011)

		var_1_10009.setSkinScaleSetting(var_1_10011, arg_84_0.ship, var_84_1, var_84_2, var_84_3)
	end

	return
end

function var_0_1.GetPaintingTransform(arg_85_0)
	return nil
end

function var_0_1.GetPartScaleData(arg_86_0)
	return nil
end

function var_0_1.GetPartStateType(arg_87_0)
	return
end

function var_0_1.Dispose(arg_88_0)
	arg_88_0:disposeEvent()

	arg_88_0.isExited = true
	pg = var_1

	var_1.DelegateInfo.Dispose(arg_88_0)

	if arg_88_0.state == var_0_4 then
		arg_88_0:UnLoad()
	end

	local var_88_0 = arg_88_0.cvLoader

	var_1.Dispose(var_88_0)

	arg_88_0.cvLoader = nil
	arg_88_0.triggerWhenLoaded = false

	arg_88_0:RemoveTimer()
	arg_88_0:RemoveMoveTimer()
	arg_88_0:RemoveChatTimer()
	arg_88_0:ClearScalePart()

	return
end

function var_0_1.OnLoad(arg_89_0, arg_89_1)
	arg_89_1()

	return
end

function var_0_1.OnUnload(arg_90_0)
	return
end

function var_0_1.OnClick(arg_91_0)
	return
end

function var_0_1.OnLongPress(arg_92_0)
	return
end

function var_0_1.OnTriggerEvent(arg_93_0)
	return
end

function var_0_1.OnTriggerEventAuto(arg_94_0)
	return
end

function var_0_1.OnDisplayWorld(arg_95_0, arg_95_1)
	return
end

function var_0_1.OnFold(arg_96_0, arg_96_1)
	return
end

function var_0_1.OnEnableOrDisableDragAndZoom(arg_97_0, arg_97_1)
	return
end

function var_0_1.OnPause(arg_98_0)
	return
end

function var_0_1.OnResume(arg_99_0)
	return
end

return var_0_1
