local MainBasePainting = class("MainBasePainting", import("view.base.BaseEventLogic"))
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5

function MainBasePainting:Ctor(arg_1_1, arg_1_2)
	MainBasePainting.super.Ctor(self, arg_1_2)
	pg.DelegateInfo.New(self)

	self.container = arg_1_1
	self.state = var_0_1
	var_0_5 = pg.AssistantInfo
	self.wordPosition = arg_1_1:Find("live2d")
	self.cvLoader = MainCVLoader.New()
	self.longPressEvent = arg_1_1:GetComponent("UILongPressTrigger").onLongPressed
	self.replaceWord = false
	self._asmrFlag = false

	return
end

function MainBasePainting:IsUnload()
	return self.state == var_0_4
end

function MainBasePainting:GetCenterPos()
	return self.wordPosition.position
end

function MainBasePainting:IsLoading()
	return self.state == var_0_2
end

function MainBasePainting:IsLoaded()
	return self.state == var_0_3
end

function MainBasePainting:SetOnceLoadedCall(arg_6_1)
	self.loadedCallback = arg_6_1

	return
end

function MainBasePainting:Load(arg_7_1)
	self.isPuase = false
	self.isExited = false
	self.state = var_0_2
	self.ship = arg_7_1
	self.paintingName = arg_7_1:getPainting()

	self:OnLoad(function()
		self.state = var_0_3

		if self.triggerWhenLoaded then
			self:TriggerEventAtFirstTime()
		else
			self:TriggerNextEventAuto()
		end

		self:InitClickEvent()

		return
	end)

	return
end

function MainBasePainting:Unload()
	self.state = var_0_4

	removeOnButton(self.container)
	self.longPressEvent:RemoveAllListeners()
	self:StopChatAnimtion()
	self.cvLoader:Stop()
	self:RemoveTimer()
	self:OnUnload()

	self.paintingName = nil

	LeanTween.cancel(self.container.gameObject)

	return
end

function MainBasePainting:UnloadOnlyPainting()
	self.state = var_0_4

	removeOnButton(self.container)
	self.longPressEvent:RemoveAllListeners()
	self:RemoveTimer()
	self:OnUnload()

	self.paintingName = nil

	return
end

function MainBasePainting:InitClickEvent()
	onButton(self, self.container, function()
		self:OnClick()
		self:TriggerPersonalTask(self.ship.groupId)

		return
	end)
	self.longPressEvent:RemoveAllListeners()
	self.longPressEvent:AddListener(function()
		if self._asmrFlag then
			return
		end

		if getProxy(ContextProxy):getCurrentContext().viewComponent.__cname == "NewMainScene" then
			self:OnLongPress()
		end

		return
	end)

	return
end

function MainBasePainting:TriggerPersonalTask(arg_14_1)
	if self.isFoldState then
		return
	end

	self:TriggerInterActionTask()

	local var_14_0 = getProxy(TaskProxy)

	for iter_14_0, iter_14_1 in ipairs(pg.task_data_trigger.all) do
		if pg.task_data_trigger[iter_14_1].group_id == arg_14_1 then
			local var_14_1 = pg.task_data_trigger[iter_14_1].task_id

			if not var_14_0:getFinishTaskById(pg.task_data_trigger[iter_14_1].task_id) then
				self:CheckStoryDownload(pg.task_data_trigger[iter_14_1].task_id, function()
					pg.m02:sendNotification(GAME.TRIGGER_TASK, var_14_1)

					return
				end)

				break
			end
		end
	end

	return
end

function MainBasePainting:TriggerInterActionTask()
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

function MainBasePainting:CheckStoryDownload(arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = arg_17_1

	while true do
		if pg.task_data_template[arg_17_1].story_id ~= "" then
			table.insert(var_17_0, pg.task_data_template[arg_17_1].story_id)
		end

		if pg.task_data_template[arg_17_1].next_task == "" or pg.task_data_template[arg_17_1].next_task == "0" then
			break
		end

		var_17_1 = arg_17_1 + 1
	end

	local var_17_2 = pg.NewStoryMgr.GetInstance()

	PaintingGroupConst.PaintingDownload({
		isShowBox = true,
		paintingNameList = _.map(var_17_2:GetStoryPaintingsByNameList(var_17_0), function(arg_18_0)
			return "painting/" .. arg_18_0
		end),
		finishFunc = arg_17_2
	})

	return
end

function MainBasePainting:TriggerEventAtFirstTime()
	if not self:IsLoaded() then
		self.triggerWhenLoaded = true

		return
	end

	self.triggerWhenLoaded = false

	self:OnFirstTimeTriggerEvent()

	return
end

function MainBasePainting:OnFirstTimeTriggerEvent()
	self._loginAction = getProxy(PlayerProxy):getFlag("login")
	self._battleAction = getProxy(PlayerProxy):getFlag("battle")

	getProxy(PlayerProxy):setFlag("login", false)
	getProxy(PlayerProxy):setFlag("battle", false)

	local function var_20_0(arg_21_0)
		self:PrepareTriggerAction(arg_21_0)

		return
	end

	if self._loginAction then
		self._loginAction = false

		var_20_0("event_login")
	elseif self._battleAction then
		self._battleAction = false

		var_20_0("home")
	else
		self:TriggerNextEventAuto()
	end

	return
end

function MainBasePainting:PrepareTriggerAction(arg_22_1)
	self:TryToTriggerEvent(arg_22_1)

	return
end

function MainBasePainting:TryToTriggerEvent(arg_23_1)
	self:_TriggerEvent(arg_23_1)

	return
end

function MainBasePainting:_TriggerEvent(arg_24_1)
	local var_24_0 = pg.AssistantInfo.GetAssistantEvents(arg_24_1)

	if var_24_0.dialog ~= "" then
		self:DisplayWord(var_24_0.dialog)
	else
		self:TriggerNextEventAuto()
	end

	return
end

function MainBasePainting:SetShift(arg_25_1)
	self._shift = arg_25_1

	return
end

function MainBasePainting:TriggerEvent(arg_26_1)
	if self.isDragAndZoomState then
		return
	end

	if self.chatting then
		return
	end

	self:RemoveTimer()
	self:PrepareTriggerAction(arg_26_1)
	self:OnTriggerEvent()

	return
end

function MainBasePainting:TriggerNextEventAuto()
	if self.isPuase or self.isExited and self._asmrFlag then
		return
	end

	self:OnEndChatting()
	self:RemoveTimer()

	self.timer = Timer.New(function()
		self:OnTimerTriggerEvent()

		return
	end, 30, 1, true)

	self.timer:Start()

	return
end

function MainBasePainting:OnTimerTriggerEvent()
	if self:OnEnableTimerEvent() then
		local var_29_0 = self:CollectIdleEvents(self.lastChatEvent)

		self.lastChatEvent = var_29_0[math.ceil(math.random(#var_29_0))]

		self:PrepareTriggerAction(self.lastChatEvent)
		self:OnTriggerEventAuto()
		self:RemoveTimer()
	end

	return
end

function MainBasePainting:OnEnableTimerEvent()
	return true
end

function MainBasePainting:OnStartChatting()
	self.chatting = true

	return
end

function MainBasePainting:OnEndChatting()
	self.chatting = false

	return
end

function MainBasePainting:GetWordAndCv(arg_33_1, arg_33_2)
	local var_33_0, var_33_1, var_33_2, var_33_3, var_33_4, var_33_5 = ShipWordHelper.GetCvDataForShip(self.ship, arg_33_2)

	return var_33_0, var_33_1, var_33_2, var_33_3, var_33_4, var_33_5
end

function MainBasePainting:DisplayWord(arg_34_1)
	self:OnStartChatting()

	local var_34_0, var_34_1, var_34_2, var_34_3, var_34_4, var_34_5 = self:GetWordAndCv(self.ship, arg_34_1)

	if not var_34_2 or var_34_2 == nil or var_34_2 == "" or var_34_2 == "nil" then
		self:OnEndChatting()
		self:OnDisplayWordEnd()

		return
	end

	self:OnDisplayWorld(arg_34_1)

	if self._asmrFlag then
		self:emit(MainAsmrChatView.SET_CONTENT, arg_34_1, var_34_2)
	else
		self:emit(MainWordView.SET_CONTENT, arg_34_1, var_34_2)
	end

	self:PlayCvAndAnimation(var_34_4, var_34_3, var_34_1)

	return
end

function MainBasePainting:PlayCvAndAnimation(arg_35_1, arg_35_2, arg_35_3)
	if getProxy(ContextProxy):getContextByMediator(NewShipMediator) then
		self:OnEndChatting()

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
			end

			self:PlayCV(arg_35_1, arg_35_2, arg_35_3, function(arg_37_0)
				var_35_0 = arg_37_0

				arg_36_0()

				return
			end)

			return
		end,
		function(arg_38_0)
			self:StartChatAnimtion(var_35_0, arg_38_0)

			return
		end
	}, function()
		self:OnDisplayWordEnd()

		return
	end)

	return
end

function MainBasePainting:OnDisplayWordEnd()
	self:TriggerNextEventAuto()

	return
end

function MainBasePainting:PlayCV(arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	self.cvLoader:Load(pg.CriMgr.GetCVBankName((ShipWordHelper.RawGetCVKey(self.ship:getSkinId()))), arg_41_3, 0, arg_41_4)

	return
end

function MainBasePainting:preloadCv(arg_42_1)
	self.cvLoader:preloadCv(pg.CriMgr.GetCVBankName((ShipWordHelper.RawGetCVKey(self.ship:getSkinId()))), arg_42_1)

	return
end

function MainBasePainting:OnAsmrTurnning(arg_43_1)
	self._asmrFlag = arg_43_1

	return
end

function MainBasePainting:setReplaceWord(arg_44_1)
	self.replaceWord = arg_44_1

	return
end

function MainBasePainting:getReplaceWord()
	return self.replaceWord
end

function MainBasePainting:StartChatAnimtion(arg_46_1, arg_46_2)
	local var_46_0 = arg_46_1 > 0 and arg_46_1 or 3

	if self._asmrFlag then
		self:emit(MainAsmrChatView.START_CHAT, 0.3, var_46_0)
	else
		self:emit(MainWordView.START_ANIMATION, 0.3, var_46_0)
	end

	self:AddCharTimer(function()
		if self:IsUnload() then
			return
		end

		arg_46_2()

		return
	end, 0.3 * 3 + var_46_0)

	return
end

function MainBasePainting:AddCharTimer(arg_48_1, arg_48_2)
	self:RemoveChatTimer()

	self.chatTimer = Timer.New(arg_48_1, arg_48_2, 1)

	self.chatTimer:Start()

	return
end

function MainBasePainting:RemoveChatTimer()
	if self.chatTimer then
		self.chatTimer:Stop()

		self.chatTimer = nil
	end

	return
end

function MainBasePainting:StopChatAnimtion()
	if not self._asmrFlag then
		self:emit(MainWordView.STOP_ANIMATION)
	end

	self:OnEndChatting()

	return
end

function MainBasePainting:OnStopVoice()
	self.cvLoader:Stop()

	return
end

function MainBasePainting:CollectIdleEvents(arg_52_1)
	local var_52_0 = {}

	if getProxy(EventProxy):hasFinishState() and arg_52_1 ~= "event_complete" then
		table.insert(var_52_0, "event_complete")
	else
		if getProxy(TaskProxy):getCanReceiveCount() > 0 and arg_52_1 ~= "mission_complete" then
			table.insert(var_52_0, "mission_complete")
		end

		if getProxy(MailProxy):GetUnreadCount() > 0 and arg_52_1 ~= "mail" then
			table.insert(var_52_0, "mail")
		end

		if #var_52_0 == 0 then
			var_52_0 = var_0_5.GetShipMainEvents(self.ship:getSkinId(), self.ship:getCVIntimacy())

			if getProxy(TaskProxy):getNotFinishCount() then
				if getProxy(TaskProxy):getNotFinishCount() > 0 and arg_52_1 ~= "mission" then
					table.insert(var_52_0, "mission")
				end
			end
		end
	end

	return var_52_0
end

function MainBasePainting:CollectTouchEvents()
	local var_53_0 = self.ship:getCVIntimacy()

	return (var_0_5.filterAssistantEvents(var_0_5.GetShipTouchEvents(self.ship:getSkinId(), var_53_0), self.ship:getSkinId(), var_53_0))
end

function MainBasePainting:GetTouchEvent(arg_54_1)
	local var_54_0 = self.ship:getCVIntimacy()

	return (var_0_5.filterAssistantEvents(var_0_5.getAssistantTouchEvents(arg_54_1, self.ship:getSkinId()), self.ship:getSkinId(), 0))
end

function MainBasePainting:GetIdleEvents()
	local var_55_0 = self.ship:getCVIntimacy()

	return (var_0_5.filterAssistantEvents(var_0_5.GetShipMainEvents(self.ship:getSkinId(), 0), self.ship:getSkinId(), 0))
end

function MainBasePainting:GetEventConfig(arg_56_1)
	return pg.AssistantInfo.GetAssistantEvents(arg_56_1)
end

function MainBasePainting:GetSpecialTouchEvent(arg_57_1)
	return var_0_5.getPaintingTouchEvents(arg_57_1)
end

function MainBasePainting:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MainBasePainting:IsExited()
	return self.isExited
end

function MainBasePainting:Fold(arg_60_1, arg_60_2)
	self.isFoldState = arg_60_1

	self:RemoveMoveTimer()
	self:OnFold(arg_60_1)

	return
end

function MainBasePainting:RemoveMoveTimer()
	if self.moveTimer then
		self.moveTimer:Stop()

		self.moveTimer = nil
	end

	return
end

function MainBasePainting:EnableOrDisableMove(arg_62_1)
	self.isDragAndZoomState = arg_62_1

	self:RemoveMoveTimer()

	if arg_62_1 then
		self:StopChatAnimtion()
		self:RemoveTimer()
		self.cvLoader:Stop()
	else
		self:TriggerNextEventAuto()
	end

	self:OnEnableOrDisableDragAndZoom(arg_62_1)

	return
end

function MainBasePainting:GetOffset()
	return 0
end

function MainBasePainting:UpdateBound()
	return
end

function MainBasePainting:IslimitYPos()
	return false
end

function MainBasePainting:PlayChangeSkinActionIn(arg_66_1)
	return
end

function MainBasePainting:PlayChangeSkinActionOut(arg_67_1)
	return
end

function MainBasePainting:PauseForSilent()
	if SettingsMainScenePanel.IsEnableFlagShipInteraction() then
		return
	end

	if self:IsLoaded() then
		self:_Pause()
	end

	return
end

function MainBasePainting:_Pause()
	self.isPuase = true

	self:RemoveMoveTimer()
	self:StopChatAnimtion()
	self:RemoveChatTimer()
	self:RemoveTimer()
	self.cvLoader:Stop()

	return
end

function MainBasePainting:Pause()
	self:_Pause()
	self:OnPause()

	return
end

function MainBasePainting:ResumeForSilent()
	if SettingsMainScenePanel.IsEnableFlagShipInteraction() then
		return
	end

	if self:IsLoaded() then
		self:_Resume()
	end

	return
end

function MainBasePainting:_Resume()
	self.isPuase = false

	self:TriggerNextEventAuto()

	return
end

function MainBasePainting:Resume()
	self:_Resume()
	self:OnResume()

	return
end

function MainBasePainting:updateShip(arg_74_1)
	if arg_74_1 and self.ship.id == arg_74_1.id then
		self.ship = arg_74_1
	end

	self:OnUpdateShip(arg_74_1)

	return
end

function MainBasePainting:OnUpdateShip(arg_75_1)
	return
end

function MainBasePainting:InitScalePart()
	local var_76_0 = self:GetPartScaleData()

	if var_76_0 and #var_76_0 > 0 then
		self.partScaleList = {}
		self.partScaleSelectList = {}

		local var_76_1 = self:GetPaintingTransform()

		if var_76_1 then
			for iter_76_0, iter_76_1 in ipairs(var_76_0) do
				local var_76_2 = findTF(var_76_1, iter_76_1)

				if var_76_2 then
					local var_76_3 = GetOrAddComponent(var_76_2, typeof(PinchZoom))

					var_76_3.enabled = false

					PoolMgr.GetInstance():GetUI("mainuiscalepart", false, function(arg_77_0)
						SetParent(arg_77_0, var_76_2)
						setActive(arg_77_0, false)
						table.insert(self.partScaleSelectList, {
							tf = tf(arg_77_0),
							name = iter_76_1
						})

						return
					end)
					onButton(self._event, var_76_2, function()
						if self.partScaleFlag then
							self.selectPartName = iter_76_1

							self:updateSelectPartScale()
						end

						return
					end)
					self:ResetPartScale(true)
					table.insert(self.partScaleList, {
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

function MainBasePainting:updatePartCotent(arg_79_1)
	for iter_79_0 = 1, #self.partScaleSelectList do
		if arg_79_1 then
			self:emit(NewMainScene.SET_SCALE_PART_CONTENT, self.partScaleSelectList[iter_79_0].tf)
		else
			setParent(self.partScaleSelectList[iter_79_0].tf, self:GetPaintingTransform(), true)
		end
	end

	return
end

function MainBasePainting:updateSelectPartScale()
	for iter_80_0 = 1, #self.partScaleList do
		self.partScaleList[iter_80_0].com.enabled = self.partScaleFlag and self.partScaleList[iter_80_0].name == self.selectPartName

		setActive(self.partScaleSelectList[iter_80_0].tf, self.partScaleFlag and self.partScaleSelectList[iter_80_0].name == self.selectPartName)
	end

	return
end

function MainBasePainting:ClearScalePart()
	if self.partScaleList and #self.partScaleList > 0 then
		for iter_81_0 = 1, #self.partScaleList do
			if self.partScaleList[iter_81_0].tf then
				removeOnButton(self.partScaleList[iter_81_0].tf)
			end
		end

		self.partScaleList = nil
	end

	if self.partScaleSelectList and #self.partScaleSelectList > 0 then
		for iter_81_1 = 1, #self.partScaleSelectList do
			if self.partScaleSelectList[iter_81_1].tf then
				PoolMgr.GetInstance():ReturnUI("mainuiscalepart", go(self.partScaleSelectList[iter_81_1].tf))
			end
		end

		self.partScaleSelectList = nil
	end

	return
end

function MainBasePainting:OnEnablePartScale(arg_82_1)
	if self.partScaleList then
		self.partScaleFlag = arg_82_1
		self.selectPartName = nil

		for iter_82_0 = 1, #self.partScaleList do
			GetOrAddComponent(self.partScaleList[iter_82_0].tf, typeof(CanvasGroup)).blocksRaycasts = arg_82_1
		end

		self:updateSelectPartScale()
		self:updatePartCotent(arg_82_1)

		if not arg_82_1 then
			self:ResetPartScale(true)
		end
	end

	return
end

function MainBasePainting:ResetPartScale(arg_83_1)
	if self.partScaleList and #self.partScaleList > 0 then
		for iter_83_0 = 1, #self.partScaleList do
			local var_83_0 = self.partScaleList[iter_83_0].tf
			local var_83_1

			if arg_83_1 then
				var_83_1 = getProxy(SettingsProxy):getSkinScaleSetting(self.ship, self:GetPartStateType(), self.partScaleList[iter_83_0].name) or 1
			end

			var_83_0.localScale = Vector3(var_83_1, var_83_1, var_83_1)
		end
	end

	return
end

function MainBasePainting:SavePartScaleData()
	if not self.partScaleList or #self.partScaleList == 0 then
		return
	end

	if not self.ship then
		return
	end

	for iter_84_0 = 1, #self.partScaleList do
		getProxy(SettingsProxy):setSkinScaleSetting(self.ship, self:GetPartStateType(), self.partScaleList[iter_84_0].name, self.partScaleList[iter_84_0].tf.localScale.x)
	end

	return
end

function MainBasePainting:GetPaintingTransform()
	return nil
end

function MainBasePainting:GetPartScaleData()
	return nil
end

function MainBasePainting:GetPartStateType()
	return
end

function MainBasePainting:Dispose()
	self:disposeEvent()

	self.isExited = true

	pg.DelegateInfo.Dispose(self)

	if self.state == var_0_3 then
		self:UnLoad()
	end

	self.cvLoader:Dispose()

	self.cvLoader = nil
	self.triggerWhenLoaded = false

	self:RemoveTimer()
	self:RemoveMoveTimer()
	self:RemoveChatTimer()
	self:ClearScalePart()

	return
end

function MainBasePainting:OnLoad(arg_89_1)
	arg_89_1()

	return
end

function MainBasePainting:OnUnload()
	return
end

function MainBasePainting:OnClick()
	return
end

function MainBasePainting:OnLongPress()
	return
end

function MainBasePainting:OnTriggerEvent()
	return
end

function MainBasePainting:OnTriggerEventAuto()
	return
end

function MainBasePainting:OnDisplayWorld(arg_95_1)
	return
end

function MainBasePainting:OnFold(arg_96_1)
	return
end

function MainBasePainting:OnEnableOrDisableDragAndZoom(arg_97_1)
	return
end

function MainBasePainting:OnPause()
	return
end

function MainBasePainting:OnResume()
	return
end

return MainBasePainting
