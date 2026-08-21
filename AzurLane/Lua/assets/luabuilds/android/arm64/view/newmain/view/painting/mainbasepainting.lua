local var_0_0 = class("MainBasePainting", import("view.base.BaseEventLogic"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.container = arg_1_1
	arg_1_0.state = var_0_1
	var_0_5 = pg.AssistantInfo
	arg_1_0.wordPosition = arg_1_1:Find("live2d")
	arg_1_0.cvLoader = MainCVLoader.New()
	arg_1_0.longPressEvent = arg_1_1:GetComponent("UILongPressTrigger").onLongPressed
	arg_1_0.replaceWord = false
	arg_1_0._asmrFlag = false

	return
end

function var_0_0.IsUnload(arg_2_0)
	return arg_2_0.state == var_0_4
end

function var_0_0.GetCenterPos(arg_3_0)
	return arg_3_0.wordPosition.position
end

function var_0_0.IsLoading(arg_4_0)
	return arg_4_0.state == var_0_2
end

function var_0_0.IsLoaded(arg_5_0)
	return arg_5_0.state == var_0_3
end

function var_0_0.SetOnceLoadedCall(arg_6_0, arg_6_1)
	arg_6_0.loadedCallback = arg_6_1

	return
end

function var_0_0.Load(arg_7_0, arg_7_1)
	arg_7_0.isPuase = false
	arg_7_0.isExited = false
	arg_7_0.state = var_0_2
	arg_7_0.ship = arg_7_1
	arg_7_0.paintingName = arg_7_1:getPainting()

	arg_7_0:OnLoad(function()
		arg_7_0.state = var_0_3

		if arg_7_0.triggerWhenLoaded then
			arg_7_0:TriggerEventAtFirstTime()
		else
			arg_7_0:TriggerNextEventAuto()
		end

		arg_7_0:InitClickEvent()

		return
	end)

	return
end

function var_0_0.Unload(arg_9_0)
	arg_9_0.state = var_0_4

	removeOnButton(arg_9_0.container)
	arg_9_0.longPressEvent:RemoveAllListeners()
	arg_9_0:StopChatAnimtion()
	arg_9_0.cvLoader:Stop()
	arg_9_0:RemoveTimer()
	arg_9_0:OnUnload()

	arg_9_0.paintingName = nil

	LeanTween.cancel(arg_9_0.container.gameObject)

	return
end

function var_0_0.UnloadOnlyPainting(arg_10_0)
	arg_10_0.state = var_0_4

	removeOnButton(arg_10_0.container)
	arg_10_0.longPressEvent:RemoveAllListeners()
	arg_10_0:RemoveTimer()
	arg_10_0:OnUnload()

	arg_10_0.paintingName = nil

	return
end

function var_0_0.InitClickEvent(arg_11_0)
	onButton(arg_11_0, arg_11_0.container, function()
		arg_11_0:OnClick()
		arg_11_0:TriggerPersonalTask(arg_11_0.ship.groupId)

		return
	end)
	arg_11_0.longPressEvent:RemoveAllListeners()
	arg_11_0.longPressEvent:AddListener(function()
		if arg_11_0._asmrFlag then
			return
		end

		local var_13_0 = getProxy(ContextProxy)

		if var_13_0:getCurrentContext().viewComponent.__cname == "NewMainScene" then
			arg_11_0:OnLongPress()
		end

		return
	end)

	return
end

function var_0_0.TriggerPersonalTask(arg_14_0, arg_14_1)
	if arg_14_0.isFoldState then
		return
	end

	arg_14_0:TriggerInterActionTask()

	local var_14_0 = getProxy(TaskProxy)

	for iter_14_0, iter_14_1 in ipairs(pg.task_data_trigger.all) do
		if pg.task_data_trigger[iter_14_1].group_id == arg_14_1 then
			local var_14_1 = pg.task_data_trigger[iter_14_1].task_id

			if not var_14_0:getFinishTaskById(pg.task_data_trigger[iter_14_1].task_id) then
				arg_14_0:CheckStoryDownload(pg.task_data_trigger[iter_14_1].task_id, function()
					pg.m02:sendNotification(GAME.TRIGGER_TASK, var_14_1)

					return
				end)

				break
			end
		end
	end

	return
end

function var_0_0.TriggerInterActionTask(arg_16_0)
	local var_16_0 = getProxy(TaskProxy):GetFlagShipInterActionTaskList()

	if var_16_0 and #var_16_0 > 0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			pg.m02:sendNotification(GAME.UPDATE_TASK_PROGRESS, {
				taskId = iter_16_1.id
			})
		end
	end

	return
end

function var_0_0.CheckStoryDownload(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1

	while true do
		if pg.task_data_template[arg_17_1].story_id ~= "" then
			table.insert({}, pg.task_data_template[arg_17_1].story_id)
		end

		if pg.task_data_template[arg_17_1].next_task == "" or pg.task_data_template[arg_17_1].next_task == "0" then
			break
		end

		var_17_0 = arg_17_1 + 1
	end

	local var_17_1 = pg.NewStoryMgr.GetInstance()

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = _.map(var_17_1:GetStoryPaintingsByNameList({}), function(arg_18_0)
			return "painting/" .. arg_18_0
		end),
		finishFunc = arg_17_2
	})

	return
end

function var_0_0.TriggerEventAtFirstTime(arg_19_0)
	if not arg_19_0:IsLoaded() then
		arg_19_0.triggerWhenLoaded = true

		return
	end

	arg_19_0.triggerWhenLoaded = false

	arg_19_0:OnFirstTimeTriggerEvent()

	return
end

function var_0_0.OnFirstTimeTriggerEvent(arg_20_0)
	arg_20_0._loginAction = getProxy(PlayerProxy):getFlag("login")
	arg_20_0._battleAction = getProxy(PlayerProxy):getFlag("battle")

	getProxy(PlayerProxy):setFlag("login", false)
	getProxy(PlayerProxy):setFlag("battle", false)

	if arg_20_0._loginAction then
		arg_20_0._loginAction = false

		;(function(arg_21_0)
			arg_20_0:PrepareTriggerAction(arg_21_0)

			return
		end)("event_login")
	elseif arg_20_0._battleAction then
		arg_20_0._battleAction = false

		;(function(arg_21_0)
			arg_20_0:PrepareTriggerAction(arg_21_0)

			return
		end)("home")
	else
		arg_20_0:TriggerNextEventAuto()
	end

	return
end

function var_0_0.PrepareTriggerAction(arg_22_0, arg_22_1)
	arg_22_0:TryToTriggerEvent(arg_22_1)

	return
end

function var_0_0.TryToTriggerEvent(arg_23_0, arg_23_1)
	arg_23_0:_TriggerEvent(arg_23_1)

	return
end

function var_0_0._TriggerEvent(arg_24_0, arg_24_1)
	local var_24_0 = pg.AssistantInfo.GetAssistantEvents(arg_24_1)

	if var_24_0.dialog ~= "" then
		arg_24_0:DisplayWord(var_24_0.dialog)
	else
		arg_24_0:TriggerNextEventAuto()
	end

	return
end

function var_0_0.SetShift(arg_25_0, arg_25_1)
	arg_25_0._shift = arg_25_1

	return
end

function var_0_0.TriggerEvent(arg_26_0, arg_26_1)
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

function var_0_0.TriggerNextEventAuto(arg_27_0)
	if arg_27_0.isPuase or arg_27_0.isExited and arg_27_0._asmrFlag then
		return
	end

	arg_27_0:OnEndChatting()
	arg_27_0:RemoveTimer()

	arg_27_0.timer = Timer.New(function()
		arg_27_0:OnTimerTriggerEvent()

		return
	end, 30, 1, true)

	arg_27_0.timer:Start()

	return
end

function var_0_0.OnTimerTriggerEvent(arg_29_0)
	if arg_29_0:OnEnableTimerEvent() then
		local var_29_0 = arg_29_0:CollectIdleEvents(arg_29_0.lastChatEvent)

		arg_29_0.lastChatEvent = var_29_0[math.ceil(math.random(#var_29_0))]

		arg_29_0:PrepareTriggerAction(arg_29_0.lastChatEvent)
		arg_29_0:OnTriggerEventAuto()
		arg_29_0:RemoveTimer()
	end

	return
end

function var_0_0.OnEnableTimerEvent(arg_30_0)
	return true
end

function var_0_0.OnStartChatting(arg_31_0)
	arg_31_0.chatting = true

	return
end

function var_0_0.OnEndChatting(arg_32_0)
	arg_32_0.chatting = false

	return
end

function var_0_0.GetWordAndCv(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0, var_33_1, var_33_2, var_33_3, var_33_4, var_33_5 = ShipWordHelper.GetCvDataForShip(arg_33_0.ship, arg_33_2)

	return var_33_0, var_33_1, var_33_2, var_33_3, var_33_4, var_33_5
end

function var_0_0.DisplayWord(arg_34_0, arg_34_1)
	arg_34_0:OnStartChatting()

	local var_34_0, var_34_1, var_34_2, var_34_3, var_34_4, var_34_5 = arg_34_0:GetWordAndCv(arg_34_0.ship, arg_34_1)

	if not var_34_2 or var_34_2 == nil or var_34_2 == "" or var_34_2 == "nil" then
		arg_34_0:OnEndChatting()
		arg_34_0:OnDisplayWordEnd()

		return
	end

	arg_34_0:OnDisplayWorld(arg_34_1)

	if arg_34_0._asmrFlag then
		arg_34_0:emit(MainAsmrChatView.SET_CONTENT, arg_34_1, var_34_2)
	else
		arg_34_0:emit(MainWordView.SET_CONTENT, arg_34_1, var_34_2)
	end

	arg_34_0:PlayCvAndAnimation(var_34_4, var_34_3, var_34_1)

	return
end

function var_0_0.PlayCvAndAnimation(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if getProxy(ContextProxy):getContextByMediator(NewShipMediator) then
		arg_35_0:OnEndChatting()

		return
	end

	local var_35_0 = -1

	seriesAsync({
		function(arg_36_0)
			if arg_35_3 then
				if not not pg.NewStoryMgr.GetInstance():IsRunning() then
					arg_36_0()

					return
				end

				arg_35_0:PlayCV(arg_35_1, arg_35_2, arg_35_3, function(arg_37_0)
					var_35_0 = arg_37_0

					arg_36_0()

					return
				end)

				return
			end
		end,
		function(arg_38_0)
			arg_35_0:StartChatAnimtion(var_35_0, arg_38_0)

			return
		end
	}, function()
		arg_35_0:OnDisplayWordEnd()

		return
	end)

	return
end

function var_0_0.OnDisplayWordEnd(arg_40_0)
	arg_40_0:TriggerNextEventAuto()

	return
end

function var_0_0.PlayCV(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	arg_41_0.cvLoader:Load(pg.CriMgr.GetCVBankName((ShipWordHelper.RawGetCVKey(arg_41_0.ship:getSkinId()))), arg_41_3, 0, arg_41_4)

	return
end

function var_0_0.preloadCv(arg_42_0, arg_42_1)
	arg_42_0.cvLoader:preloadCv(pg.CriMgr.GetCVBankName((ShipWordHelper.RawGetCVKey(arg_42_0.ship:getSkinId()))), arg_42_1)

	return
end

function var_0_0.OnAsmrTurnning(arg_43_0, arg_43_1)
	arg_43_0._asmrFlag = arg_43_1

	return
end

function var_0_0.setReplaceWord(arg_44_0, arg_44_1)
	arg_44_0.replaceWord = arg_44_1

	return
end

function var_0_0.getReplaceWord(arg_45_0)
	return arg_45_0.replaceWord
end

function var_0_0.StartChatAnimtion(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_1 > 0 and arg_46_1 or 3

	if arg_46_0._asmrFlag then
		arg_46_0:emit(MainAsmrChatView.START_CHAT, 0.3, var_46_0)
	else
		arg_46_0:emit(MainWordView.START_ANIMATION, 0.3, var_46_0)
	end

	arg_46_0:AddCharTimer(function()
		if arg_46_0:IsUnload() then
			return
		end

		arg_46_2()

		return
	end, 0.3 * 3 + var_46_0)

	return
end

function var_0_0.AddCharTimer(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0:RemoveChatTimer()

	arg_48_0.chatTimer = Timer.New(arg_48_1, arg_48_2, 1)

	arg_48_0.chatTimer:Start()

	return
end

function var_0_0.RemoveChatTimer(arg_49_0)
	if arg_49_0.chatTimer then
		arg_49_0.chatTimer:Stop()

		arg_49_0.chatTimer = nil
	end

	return
end

function var_0_0.StopChatAnimtion(arg_50_0)
	if not arg_50_0._asmrFlag then
		arg_50_0:emit(MainWordView.STOP_ANIMATION)
	end

	arg_50_0:OnEndChatting()

	return
end

function var_0_0.OnStopVoice(arg_51_0)
	arg_51_0.cvLoader:Stop()

	return
end

function var_0_0.CollectIdleEvents(arg_52_0, arg_52_1)
	local var_52_0 = {}

	if getProxy(EventProxy):hasFinishState() and arg_52_1 ~= "event_complete" then
		table.insert(var_52_0, "event_complete")
	else
		local var_52_1 = getProxy(TaskProxy)

		if var_52_1:getCanReceiveCount() > 0 and arg_52_1 ~= "mission_complete" then
			table.insert(var_52_0, "mission_complete")
		end

		local var_52_2 = getProxy(MailProxy)

		if var_52_2:GetUnreadCount() > 0 and arg_52_1 ~= "mail" then
			table.insert(var_52_0, "mail")
		end

		if #var_52_0 == 0 then
			var_52_0 = var_0_5.GetShipMainEvents(arg_52_0.ship:getSkinId(), arg_52_0.ship:getCVIntimacy())

			if getProxy(TaskProxy):getNotFinishCount() then
				if getProxy(TaskProxy):getNotFinishCount() > 0 and arg_52_1 ~= "mission" then
					table.insert(var_52_0, "mission")
				end
			end
		end
	end

	return var_52_0
end

function var_0_0.CollectTouchEvents(arg_53_0)
	local var_53_0 = arg_53_0.ship:getCVIntimacy()

	return (var_0_5.filterAssistantEvents(var_0_5.GetShipTouchEvents(arg_53_0.ship:getSkinId(), var_53_0), arg_53_0.ship:getSkinId(), var_53_0))
end

function var_0_0.GetTouchEvent(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0.ship:getCVIntimacy()

	return (var_0_5.filterAssistantEvents(var_0_5.getAssistantTouchEvents(arg_54_1, arg_54_0.ship:getSkinId()), arg_54_0.ship:getSkinId(), 0))
end

function var_0_0.GetIdleEvents(arg_55_0)
	local var_55_0 = arg_55_0.ship:getCVIntimacy()

	return (var_0_5.filterAssistantEvents(var_0_5.GetShipMainEvents(arg_55_0.ship:getSkinId(), 0), arg_55_0.ship:getSkinId(), 0))
end

function var_0_0.GetEventConfig(arg_56_0, arg_56_1)
	return pg.AssistantInfo.GetAssistantEvents(arg_56_1)
end

function var_0_0.GetSpecialTouchEvent(arg_57_0, arg_57_1)
	return var_0_5.getPaintingTouchEvents(arg_57_1)
end

function var_0_0.RemoveTimer(arg_58_0)
	if arg_58_0.timer then
		arg_58_0.timer:Stop()

		arg_58_0.timer = nil
	end

	return
end

function var_0_0.IsExited(arg_59_0)
	return arg_59_0.isExited
end

function var_0_0.Fold(arg_60_0, arg_60_1, arg_60_2)
	arg_60_0.isFoldState = arg_60_1

	arg_60_0:RemoveMoveTimer()
	arg_60_0:OnFold(arg_60_1)

	return
end

function var_0_0.RemoveMoveTimer(arg_61_0)
	if arg_61_0.moveTimer then
		arg_61_0.moveTimer:Stop()

		arg_61_0.moveTimer = nil
	end

	return
end

function var_0_0.EnableOrDisableMove(arg_62_0, arg_62_1)
	arg_62_0.isDragAndZoomState = arg_62_1

	arg_62_0:RemoveMoveTimer()

	if arg_62_1 then
		arg_62_0:StopChatAnimtion()
		arg_62_0:RemoveTimer()
		arg_62_0.cvLoader:Stop()
	else
		arg_62_0:TriggerNextEventAuto()
	end

	arg_62_0:OnEnableOrDisableDragAndZoom(arg_62_1)

	return
end

function var_0_0.GetOffset(arg_63_0)
	return 0
end

function var_0_0.UpdateBound(arg_64_0)
	return
end

function var_0_0.IslimitYPos(arg_65_0)
	return false
end

function var_0_0.PlayChangeSkinActionIn(arg_66_0, arg_66_1)
	return
end

function var_0_0.PlayChangeSkinActionOut(arg_67_0, arg_67_1)
	return
end

function var_0_0.PauseForSilent(arg_68_0)
	if SettingsMainScenePanel.IsEnableFlagShipInteraction() then
		return
	end

	if arg_68_0:IsLoaded() then
		arg_68_0:_Pause()
	end

	return
end

function var_0_0._Pause(arg_69_0)
	arg_69_0.isPuase = true

	arg_69_0:RemoveMoveTimer()
	arg_69_0:StopChatAnimtion()
	arg_69_0:RemoveChatTimer()
	arg_69_0:RemoveTimer()
	arg_69_0.cvLoader:Stop()

	return
end

function var_0_0.Pause(arg_70_0)
	arg_70_0:_Pause()
	arg_70_0:OnPause()

	return
end

function var_0_0.ResumeForSilent(arg_71_0)
	if SettingsMainScenePanel.IsEnableFlagShipInteraction() then
		return
	end

	if arg_71_0:IsLoaded() then
		arg_71_0:_Resume()
	end

	return
end

function var_0_0._Resume(arg_72_0)
	arg_72_0.isPuase = false

	arg_72_0:TriggerNextEventAuto()

	return
end

function var_0_0.Resume(arg_73_0)
	arg_73_0:_Resume()
	arg_73_0:OnResume()

	return
end

function var_0_0.updateShip(arg_74_0, arg_74_1)
	if arg_74_1 and arg_74_0.ship.id == arg_74_1.id then
		arg_74_0.ship = arg_74_1
	end

	arg_74_0:OnUpdateShip(arg_74_1)

	return
end

function var_0_0.OnUpdateShip(arg_75_0, arg_75_1)
	return
end

function var_0_0.InitScalePart(arg_76_0)
	local var_76_0 = arg_76_0:GetPartScaleData()

	if var_76_0 and #var_76_0 > 0 then
		arg_76_0.partScaleList = {}
		arg_76_0.partScaleSelectList = {}

		local var_76_1 = arg_76_0:GetPaintingTransform()

		if var_76_1 then
			for iter_76_0, iter_76_1 in ipairs(var_76_0) do
				local var_76_2 = findTF(var_76_1, iter_76_1)

				if var_76_2 then
					local var_76_3 = GetOrAddComponent(var_76_2, typeof(PinchZoom))

					var_76_3.enabled = false

					PoolMgr.GetInstance():GetUI("mainuiscalepart", false, function(arg_77_0)
						SetParent(arg_77_0, var_76_2)
						setActive(arg_77_0, false)
						table.insert(arg_76_0.partScaleSelectList, {
							tf = tf(arg_77_0),
							name = iter_76_1
						})

						return
					end)
					onButton(arg_76_0._event, var_76_2, function()
						if arg_76_0.partScaleFlag then
							arg_76_0.selectPartName = iter_76_1

							arg_76_0:updateSelectPartScale()
						end

						return
					end)
					arg_76_0:ResetPartScale(true)
					table.insert(arg_76_0.partScaleList, {
						name = iter_76_1,
						tf = var_76_2,
						com = var_76_3
					})
				end
			end
		end
	end

	return
end

function var_0_0.updatePartCotent(arg_79_0, arg_79_1)
	for iter_79_0 = 1, #arg_79_0.partScaleSelectList do
		if arg_79_1 then
			arg_79_0:emit(NewMainScene.SET_SCALE_PART_CONTENT, arg_79_0.partScaleSelectList[iter_79_0].tf)
		else
			setParent(arg_79_0.partScaleSelectList[iter_79_0].tf, arg_79_0:GetPaintingTransform(), true)
		end
	end

	return
end

function var_0_0.updateSelectPartScale(arg_80_0)
	for iter_80_0 = 1, #arg_80_0.partScaleList do
		arg_80_0.partScaleList[iter_80_0].com.enabled = arg_80_0.partScaleFlag and arg_80_0.partScaleList[iter_80_0].name == arg_80_0.selectPartName

		local var_80_1 = arg_80_0.partScaleFlag and arg_80_0.partScaleSelectList[iter_80_0].name == arg_80_0.selectPartName

		setActive(arg_80_0.partScaleSelectList[iter_80_0].tf, var_80_1)
	end

	return
end

function var_0_0.ClearScalePart(arg_81_0)
	if arg_81_0.partScaleList and #arg_81_0.partScaleList > 0 then
		for iter_81_0 = 1, #arg_81_0.partScaleList do
			if arg_81_0.partScaleList[iter_81_0].tf then
				removeOnButton(arg_81_0.partScaleList[iter_81_0].tf)
			end
		end

		arg_81_0.partScaleList = nil
	end

	if arg_81_0.partScaleSelectList and #arg_81_0.partScaleSelectList > 0 then
		for iter_81_1 = 1, #arg_81_0.partScaleSelectList do
			if arg_81_0.partScaleSelectList[iter_81_1].tf then
				PoolMgr.GetInstance():ReturnUI("mainuiscalepart", go(arg_81_0.partScaleSelectList[iter_81_1].tf))
			end
		end

		arg_81_0.partScaleSelectList = nil
	end

	return
end

function var_0_0.OnEnablePartScale(arg_82_0, arg_82_1)
	if arg_82_0.partScaleList then
		arg_82_0.partScaleFlag = arg_82_1
		arg_82_0.selectPartName = nil

		for iter_82_0 = 1, #arg_82_0.partScaleList do
			GetOrAddComponent(arg_82_0.partScaleList[iter_82_0].tf, typeof(CanvasGroup)).blocksRaycasts = arg_82_1
		end

		arg_82_0:updateSelectPartScale()
		arg_82_0:updatePartCotent(arg_82_1)

		if not arg_82_1 then
			arg_82_0:ResetPartScale(true)
		end
	end

	return
end

function var_0_0.ResetPartScale(arg_83_0, arg_83_1)
	if arg_83_0.partScaleList and #arg_83_0.partScaleList > 0 then
		for iter_83_0 = 1, #arg_83_0.partScaleList do
			local var_83_0 = arg_83_0.partScaleList[iter_83_0].tf

			if arg_83_1 then
				local var_83_1 = getProxy(SettingsProxy):getSkinScaleSetting(arg_83_0.ship, arg_83_0:GetPartStateType(), arg_83_0.partScaleList[iter_83_0].name) or 1

				var_83_0.localScale = Vector3(var_83_1, var_83_1, var_83_1)
			end
		end
	end

	return
end

function var_0_0.SavePartScaleData(arg_84_0)
	if not arg_84_0.partScaleList or #arg_84_0.partScaleList == 0 then
		return
	end

	if not arg_84_0.ship then
		return
	end

	for iter_84_0 = 1, #arg_84_0.partScaleList do
		getProxy(SettingsProxy):setSkinScaleSetting(arg_84_0.ship, arg_84_0:GetPartStateType(), arg_84_0.partScaleList[iter_84_0].name, arg_84_0.partScaleList[iter_84_0].tf.localScale.x)
	end

	return
end

function var_0_0.GetPaintingTransform(arg_85_0)
	return nil
end

function var_0_0.GetPartScaleData(arg_86_0)
	return nil
end

function var_0_0.GetPartStateType(arg_87_0)
	return
end

function var_0_0.Dispose(arg_88_0)
	arg_88_0:disposeEvent()

	arg_88_0.isExited = true

	pg.DelegateInfo.Dispose(arg_88_0)

	if arg_88_0.state == var_0_3 then
		arg_88_0:UnLoad()
	end

	arg_88_0.cvLoader:Dispose()

	arg_88_0.cvLoader = nil
	arg_88_0.triggerWhenLoaded = false

	arg_88_0:RemoveTimer()
	arg_88_0:RemoveMoveTimer()
	arg_88_0:RemoveChatTimer()
	arg_88_0:ClearScalePart()

	return
end

function var_0_0.OnLoad(arg_89_0, arg_89_1)
	arg_89_1()

	return
end

function var_0_0.OnUnload(arg_90_0)
	return
end

function var_0_0.OnClick(arg_91_0)
	return
end

function var_0_0.OnLongPress(arg_92_0)
	return
end

function var_0_0.OnTriggerEvent(arg_93_0)
	return
end

function var_0_0.OnTriggerEventAuto(arg_94_0)
	return
end

function var_0_0.OnDisplayWorld(arg_95_0, arg_95_1)
	return
end

function var_0_0.OnFold(arg_96_0, arg_96_1)
	return
end

function var_0_0.OnEnableOrDisableDragAndZoom(arg_97_0, arg_97_1)
	return
end

function var_0_0.OnPause(arg_98_0)
	return
end

function var_0_0.OnResume(arg_99_0)
	return
end

return var_0_0
