local LinerScene = class("LinerScene", import("view.base.BaseUI"))

LinerScene.AUTO_DELAY_TIME = 0.5
LinerScene.SCALE_ANIM_TIME = 0.5
LinerScene.FINISH_TARGET_ROOM_ID = 4
LinerScene.FINISH_CHAR_CNT = 10
LinerScene.GUIDE_ROOM_ID = 22
LinerScene.MODE_NORMAL = 1
LinerScene.MODE_FULLVIEW = 2

function LinerScene:getUIName()
	return "LinerMainUI"
end

function LinerScene:PlayBGM()
	local var_2_0 = self.activity

	if not self.activity then
		var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

		assert(var_2_0 and not var_2_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)
	end

	pg.BgmMgr.GetInstance():Push(self.__cname, (var_2_0:GetBgmName()))

	return
end

function LinerScene:init()
	self.mapTF = self._tf:Find("map")
	self.bgTF = self.mapTF:Find("bg")
	self.roomsTF = self.mapTF:Find("content")
	self.topUI = self._tf:Find("top")
	self.nameBgTF = self.topUI:Find("name_bg")
	self.nameInput = self.topUI:Find("name/input")
	self.logBtn = self.topUI:Find("logbook")
	self.timeBgTF = self.topUI:Find("time/bg")
	self.timeTF = self.topUI:Find("time/Text")
	self.targetTagTF = self.topUI:Find("time/target/tag")
	self.targetLayoutCom = self.topUI:Find("time/target"):GetComponent(typeof(HorizontalLayoutGroup))
	self.targetTF = self.topUI:Find("time/target/Text")
	self.focusTF = self.topUI:Find("focus")

	setActive(self.focusTF:Find("tpl"), false)

	self.bgDiffList = {
		self.bgTF,
		self.nameBgTF,
		self.timeBgTF,
		self.roomsTF:Find("1/icon"),
		self.roomsTF:Find("3/icon"),
		self.roomsTF:Find("4/icon")
	}

	local var_3_0 = self._tf:Find("pages")

	self.timePage = LinerPassTimePage.New(var_3_0, self)
	self.roomPage = LinerRoomInfoPage.New(var_3_0, self)

	local var_3_1, var_3_2, var_3_3 = getSizeRate()

	self.delta = Vector2(var_3_2 - 100, var_3_3 - 100) / 2
	self.extendLimit = Vector2(self.mapTF.rect.width - self._tf.rect.width, self.mapTF.rect.height - self._tf.rect.height) / 2
	self.fullFactor = math.max(self._tf.rect.width / self.mapTF.rect.width, self._tf.rect.height / self.mapTF.rect.height)

	return
end

function LinerScene:addListeners()
	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.LINER_NAMED_ID)

	assert(var_4_0 and not var_4_0:isEnd(), "not exist named act, id: " .. ActivityConst.LINER_NAMED_ID)

	self.linerName = var_4_0:getStrData1()

	setInputText(self.nameInput, self.linerName)

	self.defaultName = getProxy(PlayerProxy):getRawData():GetName()

	onInputEndEdit(self, self.nameInput, function(arg_5_0)
		if arg_5_0 ~= self.defaultName and not nameValidityCheck(arg_5_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			setInputText(self.nameInput, self.linerName)

			return
		else
			local var_5_0 = getInputText(self.nameInput)

			self:emit(LinerMediator.SET_NAME, {
				actId = var_4_0.id,
				strValue = var_5_0,
				callback = function()
					self.linerName = var_5_0

					setInputText(self.nameInput, self.linerName)
					pg.TipsMgr.GetInstance():ShowTips(i18n("liner_name_modify"))

					return
				end
			})
		end

		return
	end)

	local var_4_1 = PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED

	self.nameInput:GetComponent(typeof(InputField)).interactable = not (PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED)

	setActive(self.topUI:Find("name/edit"), not var_4_1)
	onButton(self, self.topUI:Find("back"), function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.topUI:Find("home"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self.topUI:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.liner_help.tip
		})

		return
	end, SFX_CANCEL)
	onButton(self, self.logBtn, function()
		self:emit(LinerMediator.GO_SUBLAYER, Context.New({
			mediator = LinerLogBookMediator,
			viewComponent = LinerLogBookLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.topUI:Find("fullview"), function()
		if self.mode == LinerScene.MODE_NORMAL then
			self:SwitchMode(LinerScene.MODE_FULLVIEW)
		else
			self:SwitchMode(LinerScene.MODE_NORMAL)
		end

		return
	end, SFX_PANEL)
	onScroll(self, self.mapTF, function(arg_12_0)
		self:onDragFunction()

		return
	end)

	return
end

function LinerScene:didEnter()
	self:addListeners()

	self.mode = LinerScene.MODE_NORMAL
	self.isFirstUpdate = true

	self:UpdateData()
	self:InitRooms()

	local var_13_0 = {}

	table.insert(var_13_0, function(arg_14_0)
		if self.activity:GetCurIdx() == 1 then
			self:managedTween(LeanTween.delayedCall, function()
				triggerButton(self._tf:Find(tostring(self.targetIds[1]), self.roomsTF))

				return
			end, LinerScene.AUTO_DELAY_TIME, nil)
		else
			arg_14_0()
		end

		return
	end)
	self:UpdateView(function()
		seriesAsync(var_13_0, function()
			return
		end)

		return
	end)

	return
end

function LinerScene:InitRooms()
	self.rooms = {}
	self.roomChars = {}
	self.roomIds = self.activity:GetAllExploreRoomIds()

	eachChild(self.roomsTF, function(arg_19_0)
		local var_19_0 = tonumber(arg_19_0.name)

		if not var_19_0 then
			return
		end

		if table.contains(self.roomIds, var_19_0) then
			self.rooms[var_19_0] = LinerRoom.New(var_19_0)
			self.roomChars[var_19_0] = {}
		end

		return
	end)

	self.floatItemList = UIItemList.New(self.focusTF, self.focusTF:Find("tpl"))

	self.floatItemList:make(function(arg_20_0, arg_20_1, arg_20_2)
		arg_20_1 = arg_20_1 + 1

		if arg_20_0 == UIItemList.EventUpdate then
			local var_20_0 = self.targetIds[arg_20_1]

			arg_20_2.name = self.targetIds[arg_20_1]

			local var_20_1 = self.curTime:GetType()

			eachChild(arg_20_2:Find("tag"), function(arg_21_0)
				setActive(arg_21_0, arg_21_0.name == "type" .. var_20_1)

				return
			end)
			eachChild(arg_20_2:Find("arrow"), function(arg_22_0)
				setActive(arg_22_0, arg_22_0.name == "type" .. var_20_1)

				return
			end)
			onButton(self, arg_20_2, function()
				self:FocusNode(var_20_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function LinerScene:UpdateRooms()
	eachChild(self.roomsTF, function(arg_25_0)
		local var_25_0 = tonumber(arg_25_0.name)

		if not var_25_0 then
			return
		end

		self:OnUpdateRoom(var_25_0, arg_25_0)

		return
	end)

	if self.isReallyTime then
		self:InitRandomChars()
	else
		self:FillRandomChars()
	end

	self.isFirstUpdate = false

	return
end

function LinerScene:OnUpdateRoom(arg_26_1, arg_26_2)
	if not table.contains(self.roomIds, arg_26_1) then
		setActive(arg_26_2:Find("tag"), false)
		setActive(arg_26_2:Find("mask"), false)
		setActive(arg_26_2:Find("explore"), false)
		onButton(self, arg_26_2, function()
			if self.mode == LinerScene.MODE_FULLVIEW then
				self:SwitchMode(LinerScene.MODE_NORMAL)
				self:FocusNode(arg_26_1)
			end

			return
		end, SFX_CONFIRM)

		return
	end

	local var_26_0 = self.curTime:GetType()
	local var_26_1 = table.contains(self.targetIds, arg_26_1) or var_26_0 == LinerTime.TYPE.EXPLORE
	local var_26_2 = arg_26_2:Find("tag")

	setActive(var_26_2, var_26_1)
	eachChild(var_26_2, function(arg_28_0)
		setActive(arg_28_0, arg_28_0.name == "type" .. var_26_0)

		return
	end)

	local var_26_3 = var_26_0 == LinerTime.TYPE.EXPLORE and table.contains(self.exploredRoomIds, arg_26_1)
	local var_26_4 = var_26_0 == LinerTime.TYPE.EXPLORE and not table.contains(self.exploredRoomIds, arg_26_1)

	setActive(arg_26_2:Find("mask"), var_26_3)
	setActive(arg_26_2:Find("explore"), var_26_4)
	onButton(self, arg_26_2, function()
		if self.mode == LinerScene.MODE_FULLVIEW then
			self:SwitchMode(LinerScene.MODE_NORMAL)
			self:FocusNode(arg_26_1)

			return
		end

		if not var_26_1 or var_26_3 then
			return
		end

		if self.isFinishAll and not self.isReallyTime then
			pg.NewStoryMgr.GetInstance():Play(self.endingStory, function()
				self:PlayAnim(function()
					self:UpdateData()
					self:CheckTime()

					return
				end)

				return
			end)

			return
		end

		switch(var_26_0, {
			[LinerTime.TYPE.TARGET] = function()
				pg.NewStoryMgr.GetInstance():Play(self.curTime:GetStory(), function()
					self:emit(LinerMediator.CLICK_ROOM, self.activity.id, arg_26_1)

					self.needAutoCheck = true

					return
				end, true)

				return
			end,
			[LinerTime.TYPE.EXPLORE] = function()
				self.roomPage:ExecuteAction("ShowInfo", self.activity, arg_26_1, function()
					self:CheckTime()

					return
				end)

				return
			end,
			[LinerTime.TYPE.EVENT] = function()
				local var_36_0 = self.curTime:GetEventSubType(arg_26_1)

				if var_36_0 == LinerTime.EVENT_SUB_TYPE.CLUE then
					self.roomPage:ExecuteAction("ShowInfo", self.activity, arg_26_1, function()
						self:CheckTime()

						return
					end)
				elseif var_36_0 == LinerTime.EVENT_SUB_TYPE.STORY then
					pg.NewStoryMgr.GetInstance():Play(self.curTime:GetStory(arg_26_1), function()
						self:emit(LinerMediator.CLICK_ROOM, self.activity.id, arg_26_1)

						self.needAutoCheck = true

						return
					end, true)
				end

				return
			end,
			[LinerTime.TYPE.STORY] = function()
				seriesAsync({
					function(arg_40_0)
						if self.activity:GetCurIdx() == 1 then
							arg_40_0()
						else
							self:PlayAnim(function()
								self:UpdateBg("day")

								return
							end, arg_40_0)
						end

						return
					end,
					function(arg_42_0)
						pg.NewStoryMgr.GetInstance():Play(self.curTime:GetStory(), arg_42_0, true)

						return
					end
				}, function()
					self:emit(LinerMediator.CLICK_ROOM, self.activity.id, arg_26_1)

					self.needAutoCheck = true

					return
				end)

				return
			end
		})

		return
	end, SFX_CONFIRM)

	if not self.isFinishAll or self.isFinishAll and not self.isReallyTime then
		self:UpdateRoomChar(arg_26_1, arg_26_2)
	end

	return
end

function LinerScene:UpdateRoomChar(arg_44_1, arg_44_2)
	local var_44_0

	if self.oldTime.id == self.curTime.id and not self.isFirstUpdate then
		do return end

		var_44_0 = self.rooms[arg_44_1]:GetSpineCharInfo(self.oldTime.id)
	end

	local var_44_1 = self.rooms[arg_44_1]:GetSpineCharInfo(self.curTime.id)

	if var_44_0 then
		local var_44_3

		if var_44_1 then
			var_44_3 = var_44_1[1] or ""

			if (var_44_0[1] or "") == var_44_3 and not self.isFirstUpdate then
				return
			end
		end
	end

	local var_44_4 = arg_44_2:Find("char")

	if self.roomChars[arg_44_1][1] and self.roomChars[arg_44_1][2] then
		if LeanTween.isTweening(self.roomChars[arg_44_1][2]) then
			LeanTween.cancel(self.roomChars[arg_44_1][2])
		end

		PoolMgr.GetInstance():ReturnSpineChar(self.roomChars[arg_44_1][1], self.roomChars[arg_44_1][2])

		self.roomChars[arg_44_1][1] = nil
		self.roomChars[arg_44_1][2] = nil
	end

	if var_44_3 ~= "" then
		PoolMgr.GetInstance():GetSpineChar(var_44_3, true, function(arg_45_0)
			self.roomChars[arg_44_1][1] = var_44_3
			self.roomChars[arg_44_1][2] = arg_45_0

			setLocalScale(tf(arg_45_0), {
				x = LinerRoomCharPoint.SCALE,
				y = LinerRoomCharPoint.SCALE
			})
			setParent(arg_45_0, var_44_4)
			self:InitCharBehavior(arg_44_1, tf(arg_45_0), var_44_1[2])

			return
		end)
	end

	return
end

function LinerScene:InitCharBehavior(arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = LinerRoomCharPoint.SCALE

	if LinerRoomCharPoint[arg_46_1].type == 2 then
		setLocalPosition(arg_46_2, LinerRoomCharPoint[arg_46_1].idlePoint)
		arg_46_2:GetComponent("SpineAnimUI"):SetAction(arg_46_3 or LinerRoomCharPoint.IDLE_ACTION, 0)
	elseif LinerRoomCharPoint[arg_46_1].type == 1 then
		local var_46_1 = LinerRoomCharPoint[arg_46_1].startPoint.x
		local var_46_2 = LinerRoomCharPoint[arg_46_1].endPoint.x

		setLocalPosition(arg_46_2, LinerRoomCharPoint[arg_46_1].startPoint)
		arg_46_2:GetComponent("SpineAnimUI"):SetAction(arg_46_3 or LinerRoomCharPoint.MOVE_ACTION, 0)
		self:managedTween(LeanTween.value, nil, go(arg_46_2), LinerRoomCharPoint[arg_46_1].startPoint.x, LinerRoomCharPoint[arg_46_1].endPoint.x, (LinerRoomCharPoint[arg_46_1].endPoint.x - LinerRoomCharPoint[arg_46_1].startPoint.x) / LinerRoomCharPoint.SPEED):setOnUpdate(System.Action_float(function(arg_47_0)
			setLocalPosition(arg_46_2, {
				x = arg_47_0
			})

			if arg_47_0 == var_46_1 then
				setLocalScale(arg_46_2, {
					x = var_46_0,
					y = var_46_0
				})
			end

			if arg_47_0 == var_46_2 then
				setLocalScale(arg_46_2, {
					x = -var_46_0,
					y = var_46_0
				})
			end

			return
		end)):setLoopPingPong()
	end

	return
end

function LinerScene:GetRandomItems(arg_48_1, arg_48_2)
	assert(arg_48_2 <= #arg_48_1, "不合法的随机数量")

	local var_48_0 = {}

	for iter_48_0 = 1, #arg_48_1 do
		table.insert(var_48_0, iter_48_0)
	end

	shuffle(var_48_0)

	local var_48_1 = {}

	for iter_48_1 = 1, arg_48_2 do
		table.insert(var_48_1, arg_48_1[var_48_0[iter_48_1]])
	end

	return var_48_1
end

function LinerScene:InitRandomChars()
	for iter_49_0, iter_49_1 in pairs(self.roomChars) do
		if iter_49_1[1] and iter_49_1[2] then
			if LeanTween.isTweening(iter_49_1[2]) then
				LeanTween.cancel(iter_49_1[2])
			end

			PoolMgr.GetInstance():ReturnSpineChar(iter_49_1[1], iter_49_1[2])

			self.roomChars[iter_49_0][1] = nil
			self.roomChars[iter_49_0][2] = nil
		end
	end

	local var_49_0 = self:GetRandomItems(self.sdConfig, LinerScene.FINISH_CHAR_CNT)

	for iter_49_2, iter_49_3 in ipairs((self:GetRandomItems(underscore.filter(self.roomIds, function(arg_50_0)
		return arg_50_0 ~= 4 and arg_50_0 ~= 31
	end), LinerScene.FINISH_CHAR_CNT))) do
		local var_49_1 = var_49_0[iter_49_2]

		PoolMgr.GetInstance():GetSpineChar(var_49_0[iter_49_2], true, function(arg_51_0)
			self.roomChars[iter_49_3][1] = var_49_1
			self.roomChars[iter_49_3][2] = arg_51_0

			setLocalScale(tf(arg_51_0), {
				x = LinerRoomCharPoint.SCALE,
				y = LinerRoomCharPoint.SCALE
			})
			setParent(arg_51_0, (self.roomsTF:Find(iter_49_3 .. "/char")))
			self:InitCharBehavior(iter_49_3, tf(arg_51_0))

			return
		end)
	end

	return
end

function LinerScene:FillRandomChars()
	if self.oldTime.id == self.curTime.id and not self.isFirstUpdate then
		return
	end

	local var_52_0 = Clone(self.roomIds)
	local var_52_1 = Clone(self.sdConfig)
	local var_52_2 = 0

	for iter_52_0, iter_52_1 in ipairs(self.roomIds) do
		local var_52_3 = self.rooms[iter_52_1]:GetSpineCharInfo(self.curTime.id)

		if var_52_3 and var_52_3[1] and var_52_3[2] then
			table.removebyvalue(var_52_0, iter_52_1)

			if table.contains(var_52_1, var_52_3[1]) then
				table.removebyvalue(var_52_1, var_52_3[1])
			end

			var_52_2 = var_52_2 + 1
		end
	end

	if self.randomIds and #self.randomIds > 0 then
		for iter_52_2, iter_52_3 in pairs(self.roomChars) do
			if iter_52_3[1] and iter_52_3[2] and table.contains(self.randomIds, iter_52_2) then
				if LeanTween.isTweening(iter_52_3[2]) then
					LeanTween.cancel(iter_52_3[2])
				end

				PoolMgr.GetInstance():ReturnSpineChar(iter_52_3[1], iter_52_3[2])

				self.roomChars[iter_52_2][1] = nil
				self.roomChars[iter_52_2][2] = nil
			end
		end
	end

	self.randomIds = {}
	self.randomIds = self:GetRandomItems(underscore.filter(var_52_0, function(arg_53_0)
		return arg_53_0 ~= 4 and arg_53_0 ~= 31
	end), LinerScene.FINISH_CHAR_CNT - var_52_2)

	local var_52_4 = self:GetRandomItems(var_52_1, LinerScene.FINISH_CHAR_CNT - var_52_2)

	for iter_52_4, iter_52_5 in ipairs(self.randomIds) do
		local var_52_5 = var_52_4[iter_52_4]

		PoolMgr.GetInstance():GetSpineChar(var_52_4[iter_52_4], true, function(arg_54_0)
			self.roomChars[iter_52_5][1] = var_52_5
			self.roomChars[iter_52_5][2] = arg_54_0

			setLocalScale(tf(arg_54_0), {
				x = LinerRoomCharPoint.SCALE,
				y = LinerRoomCharPoint.SCALE
			})
			setParent(arg_54_0, (self.roomsTF:Find(iter_52_5 .. "/char")))
			self:InitCharBehavior(iter_52_5, tf(arg_54_0))

			return
		end)
	end

	return
end

function LinerScene:UpdateBg(arg_55_1)
	local var_55_0 = arg_55_1 or self.curTime:GetBgType()

	for iter_55_0, iter_55_1 in ipairs(self.bgDiffList) do
		eachChild(iter_55_1, function(arg_56_0)
			setActive(arg_56_0, arg_56_0.name == var_55_0)

			return
		end)
	end

	return
end

function LinerScene:UpdateFinishTime()
	local var_57_0 = os.date("*t", os.time())
	local var_57_1 = var_57_0.hour
	local var_57_2 = var_57_0.min
	local var_57_3 = var_57_0.hour < 12 and " AM" or " PM"

	self:UpdateBg(self.activity:GetReallyTimeType(var_57_0.hour))

	if var_57_1 > 12 then
		var_57_1 = var_57_1 - 12
	end

	setText(self.timeTF, string.format("%d:%02d ", var_57_1, var_57_2) .. var_57_3)

	return
end

function LinerScene:UpdateTimeUI()
	if self.isReallyTime then
		eachChild(self.targetTagTF, function(arg_59_0)
			setActive(arg_59_0, false)

			return
		end)

		self.targetLayoutCom.spacing = -60

		setText(self.targetTF, i18n("liner_target_type5"))

		self.finishTimer = Timer.New(function()
			self:UpdateFinishTime()

			return
		end, 60, -1)

		self.finishTimer:Start()
		self:UpdateFinishTime()

		return
	end

	setText(self.timeTF, self.curTime:GetStartTimeDesc())

	local var_58_0 = self.curTime:GetType()

	eachChild(self.targetTagTF, function(arg_61_0)
		setActive(arg_61_0, not self.isFinishAll and arg_61_0.name == "type" .. var_58_0)

		return
	end)

	local var_58_1 = ""

	switch(var_58_0, {
		[LinerTime.TYPE.TARGET] = function()
			var_58_1 = i18n("liner_target_type1", self.rooms[self.targetIds[1]]:GetName())

			return
		end,
		[LinerTime.TYPE.EXPLORE] = function()
			local var_63_0 = self.curTime:GetExploreCnt()

			var_58_1 = i18n("liner_target_type2") .. string.format("(%d/%d)", var_63_0 - self.activity:GetRemainExploreCnt(), var_63_0)

			return
		end,
		[LinerTime.TYPE.EVENT] = function()
			local var_64_0 = #self.curTime:GetTargetRoomIds()
			local var_64_1 = self.activity:GetRoomIdx() - 1

			var_58_1 = i18n("liner_target_type3") .. string.format("(%d/%d)", (self.isFinishAll or nil) and var_64_0, var_64_0)

			return
		end,
		[LinerTime.TYPE.STORY] = function()
			var_58_1 = i18n("liner_target_type4", self.rooms[self.targetIds[1]]:GetName())

			return
		end
	})

	self.targetLayoutCom.spacing = (var_58_0 == LinerTime.TYPE.EXPLORE or self.isFinishAll) and -60 or -10

	if self.isFinishAll then
		var_58_1 = i18n("liner_target_type4")
	end

	setText(self.targetTF, var_58_1)

	return
end

function LinerScene:CheckTime()
	local var_66_0 = self.activity:GetCurIdx()

	if self.oldTime.id ~= self.curTime.id then
		self.timePage:ExecuteAction("ShowAnim", self.activity, math.max(var_66_0 - 1, 1), var_66_0, function()
			self:UpdateView()

			return
		end)
	else
		self:UpdateView()
	end

	return
end

function LinerScene:UpdateView(arg_68_1)
	self:UpdateBg()
	self:UpdateTimeUI()
	self:UpdateRooms()
	self:UpdateTips()
	self.floatItemList:align(#self.targetIds)

	if self.curTime:GetType() ~= LinerTime.TYPE.EXPLORE and self.targetIds[1] then
		self:FocusNode(self.targetIds[1], arg_68_1)
	else
		self:onDragFunction()
	end

	if self.curTime:GetType() == LinerTime.TYPE.EXPLORE then
		if not pg.NewStoryMgr.GetInstance():IsPlayed("Liner_1") then
			self:FocusNode(LinerScene.GUIDE_ROOM_ID, function()
				pg.NewGuideMgr.GetInstance():Play("Liner_1")
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = "Liner_1"
				})

				return
			end)
		end
	end

	if self.oldTime.id ~= self.curTime.id then
		self:PlayBGM()
	end

	return
end

function LinerScene:UpdateData()
	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	assert(self.activity and not self.activity:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	self.endingStory = self.activity:getConfig("config_client").endingstory[1]
	self.timeConfig = self.activity:getConfig("config_client").endingtime
	self.sdConfig = self.activity:getConfig("config_client").sd
	self.isFinishAll = self.activity:IsFinishAllTime()
	self.isReallyTime = self.isFinishAll and pg.NewStoryMgr.GetInstance():IsPlayed(self.endingStory)
	self.exploredRoomIds = self.activity:GetExploredRoomIds()
	self.curEventInfos = self.activity:GetCurEventInfo()
	self.oldTime = self.curTime and Clone(self.curTime) or nil
	self.curTime = self.activity:GetCurTime()
	self.oldTime = self.oldTime or Clone(self.curTime)
	self.targetIds = self.isFinishAll and (not self.isReallyTime and {
		LinerScene.FINISH_TARGET_ROOM_ID
	} or {}) or self.curTime:GetType() == LinerTime.TYPE.EVENT and {
		self:_getCurEventRoomId()
	} or self.curTime:GetTargetRoomIds()

	if self.needAutoCheck then
		self.needAutoCheck = false

		self:CheckTime()
	end

	return
end

function LinerScene:_getCurEventRoomId()
	return self.curTime:GetParamInfo()[self.activity:GetRoomIdx()][1]
end

function LinerScene:UpdateTips()
	setActive(self.logBtn:Find("tip"), LinerLogBookLayer.IsTip())

	return
end

function LinerScene:onDragFunction()
	LinerScene.screenPoints = LinerScene.screenPoints or {
		Vector2(-self.delta.x, self.delta.y),
		Vector2(self.delta.x, self.delta.y),
		Vector2(self.delta.x, -self.delta.y),
		Vector2(-self.delta.x, -self.delta.y)
	}

	for iter_73_0, iter_73_1 in ipairs(self.targetIds) do
		local var_73_0 = self.roomsTF:Find(tostring(iter_73_1))

		if var_73_0 then
			local var_73_1 = self._tf:InverseTransformPoint(var_73_0.position)
			local var_73_2

			for iter_73_2, iter_73_3 in ipairs(LinerScene.screenPoints) do
				local var_73_3 = Vector2(var_73_1.x, var_73_1.y)
				local var_73_4, var_73_5, var_73_6 = LineLine(Vector2.zero, var_73_3, iter_73_3, LinerScene.screenPoints[iter_73_2 % 4 + 1])

				if var_73_4 then
					var_73_2 = var_73_3 * var_73_5

					break
				end
			end

			local var_73_7 = self.floatItemList.container:Find(tostring(iter_73_1))
			local var_73_8 = var_73_7:GetComponent(typeof(CanvasGroup))
			local var_73_9 = tobool(var_73_2)

			var_73_8.interactable = var_73_9
			var_73_8.blocksRaycasts = var_73_9
			var_73_8.alpha = var_73_9 and 1 or 0

			setActive(self.roomsTF:Find(iter_73_1 .. "/tag"), not var_73_9)

			if var_73_2 then
				setAnchoredPosition(var_73_7, var_73_2 * (1 - 50 / var_73_2:Magnitude()))
				setLocalEulerAngles(var_73_7:Find("arrow"), {
					z = math.rad2Deg * math.atan2(var_73_2.y, var_73_2.x)
				})
			end
		end
	end

	return
end

function LinerScene:FocusNode(arg_74_1, arg_74_2)
	local var_74_0 = self.roomsTF:Find(tostring(arg_74_1)).anchoredPosition * -1

	var_74_0.x = math.clamp(var_74_0.x, -self.extendLimit.x, self.extendLimit.x)
	var_74_0.y = math.clamp(var_74_0.y, -self.extendLimit.y, self.extendLimit.y)

	if self.twFocusId then
		LeanTween.cancel(self.twFocusId)

		self.twFocusId = nil
	end

	local var_74_1 = {}

	table.insert(var_74_1, function(arg_75_0)
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), false)

		self.twFocusId = LeanTween.move(self.mapTF, Vector3(var_74_0.x, var_74_0.y, 0), (self.mapTF.anchoredPosition - var_74_0).magnitude > 0 and (self.mapTF.anchoredPosition - var_74_0).magnitude / (40 * math.sqrt((self.mapTF.anchoredPosition - var_74_0).magnitude)) or 0):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_76_0)
			self:onDragFunction()

			return
		end)):setOnComplete(System.Action(arg_75_0)).uniqueId

		return
	end)
	seriesAsync(var_74_1, function()
		SetCompomentEnabled(self.mapTF, typeof(ScrollRect), true)

		if arg_74_2 then
			arg_74_2()
		end

		return
	end)

	return
end

function LinerScene:SwitchMode(arg_78_1, arg_78_2)
	self.mode = arg_78_1

	local var_78_0 = self.mode == LinerScene.MODE_NORMAL

	setActive(self.focusTF, self.mode == LinerScene.MODE_NORMAL)
	self:managedTween(LeanTween.value, nil, go(self.mapTF), self.mapTF.localScale.x, var_78_0 and 1 or self.fullFactor, LinerScene.SCALE_ANIM_TIME):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_79_0)
		setLocalScale(self.mapTF, {
			x = arg_79_0,
			y = arg_79_0,
			z = arg_79_0
		})

		return
	end))

	if not var_78_0 then
		self:managedTween(LeanTween.move, nil, go(self.mapTF), Vector3(0, 0, 0), LinerScene.SCALE_ANIM_TIME):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
			if arg_78_2 then
				arg_78_2()
			end

			return
		end))
	elseif arg_78_2 then
		arg_78_2()
	end

	return
end

function LinerScene:PlayAnim(arg_81_1, arg_81_2)
	seriesAsync({
		function(arg_82_0)
			if not self.swithAnimTF then
				PoolMgr.GetInstance():GetUI("OtherworldCoverUI", true, function(arg_83_0)
					self.swithAnimTF = arg_83_0.transform

					setParent(self.swithAnimTF, self._tf, false)
					setActive(self.swithAnimTF, false)
					arg_82_0()

					return
				end)
			else
				arg_82_0()
			end

			return
		end,
		function(arg_84_0)
			setActive(self.swithAnimTF, true)

			local var_84_0 = self.swithAnimTF:Find("yuncaizhuanchang"):GetComponent(typeof(SpineAnimUI))

			var_84_0:SetActionCallBack(function(arg_85_0)
				if arg_85_0 == "finish" then
					if arg_81_2 then
						arg_81_2()
					end

					setActive(self.swithAnimTF, false)
				elseif arg_85_0 == "action" and arg_81_1 then
					arg_81_1()
				end

				return
			end)
			var_84_0:SetAction("action", 0)

			return
		end
	}, function()
		return
	end)

	return
end

function LinerScene:onBackPressed()
	if self.timePage and self.timePage:GetLoaded() and self.timePage:isShowing() then
		return
	end

	LinerScene.super.onBackPressed(self)

	return
end

function LinerScene:willExit()
	self.timePage:Destroy()

	self.timePage = nil

	self.roomPage:Destroy()

	self.roomPage = nil

	for iter_88_0, iter_88_1 in pairs(self.roomChars) do
		if iter_88_1[1] and iter_88_1[2] then
			PoolMgr.GetInstance():ReturnSpineChar(iter_88_1[1], iter_88_1[2])
		end
	end

	self.roomChars = nil

	if self.finishTimer ~= nil then
		self.finishTimer:Stop()

		self.finishTimer = nil
	end

	return
end

return LinerScene
