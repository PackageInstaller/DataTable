local var_0_0 = class("LinerScene", import("view.base.BaseUI"))

var_0_0.AUTO_DELAY_TIME = 0.5
var_0_0.SCALE_ANIM_TIME = 0.5
var_0_0.FINISH_TARGET_ROOM_ID = 4
var_0_0.FINISH_CHAR_CNT = 10
var_0_0.GUIDE_ROOM_ID = 22
var_0_0.MODE_NORMAL = 1
var_0_0.MODE_FULLVIEW = 2

function var_0_0.getUIName(arg_1_0)
	return "LinerMainUI"
end

function var_0_0.PlayBGM(arg_2_0)
	local var_2_0 = arg_2_0.activity

	if not arg_2_0.activity then
		var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

		assert(var_2_0 and not var_2_0:isEnd(), "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)
	end

	pg.BgmMgr.GetInstance():Push(arg_2_0.__cname, (var_2_0:GetBgmName()))

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.mapTF = arg_3_0._tf:Find("map")
	arg_3_0.bgTF = arg_3_0.mapTF:Find("bg")
	arg_3_0.roomsTF = arg_3_0.mapTF:Find("content")
	arg_3_0.topUI = arg_3_0._tf:Find("top")
	arg_3_0.nameBgTF = arg_3_0.topUI:Find("name_bg")
	arg_3_0.nameInput = arg_3_0.topUI:Find("name/input")
	arg_3_0.logBtn = arg_3_0.topUI:Find("logbook")
	arg_3_0.timeBgTF = arg_3_0.topUI:Find("time/bg")
	arg_3_0.timeTF = arg_3_0.topUI:Find("time/Text")
	arg_3_0.targetTagTF = arg_3_0.topUI:Find("time/target/tag")
	arg_3_0.targetLayoutCom = arg_3_0.topUI:Find("time/target"):GetComponent(typeof(HorizontalLayoutGroup))
	arg_3_0.targetTF = arg_3_0.topUI:Find("time/target/Text")
	arg_3_0.focusTF = arg_3_0.topUI:Find("focus")

	setActive(arg_3_0.focusTF:Find("tpl"), false)

	arg_3_0.bgDiffList = {
		arg_3_0.bgTF,
		arg_3_0.nameBgTF,
		arg_3_0.timeBgTF,
		arg_3_0.roomsTF:Find("1/icon"),
		arg_3_0.roomsTF:Find("3/icon"),
		arg_3_0.roomsTF:Find("4/icon")
	}

	local var_3_0 = arg_3_0._tf:Find("pages")

	arg_3_0.timePage = LinerPassTimePage.New(var_3_0, arg_3_0)
	arg_3_0.roomPage = LinerRoomInfoPage.New(var_3_0, arg_3_0)

	local var_3_1, var_3_2, var_3_3 = getSizeRate()

	arg_3_0.delta = Vector2(var_3_2 - 100, var_3_3 - 100) / 2
	arg_3_0.extendLimit = Vector2(arg_3_0.mapTF.rect.width - arg_3_0._tf.rect.width, arg_3_0.mapTF.rect.height - arg_3_0._tf.rect.height) / 2
	arg_3_0.fullFactor = math.max(arg_3_0._tf.rect.width / arg_3_0.mapTF.rect.width, arg_3_0._tf.rect.height / arg_3_0.mapTF.rect.height)

	return
end

function var_0_0.addListeners(arg_4_0)
	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.LINER_NAMED_ID)

	assert(var_4_0 and not var_4_0:isEnd(), "not exist named act, id: " .. ActivityConst.LINER_NAMED_ID)

	arg_4_0.linerName = var_4_0:getStrData1()

	setInputText(arg_4_0.nameInput, arg_4_0.linerName)

	arg_4_0.defaultName = getProxy(PlayerProxy):getRawData():GetName()

	onInputEndEdit(arg_4_0, arg_4_0.nameInput, function(arg_5_0)
		if arg_5_0 ~= arg_4_0.defaultName and not nameValidityCheck(arg_5_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			setInputText(arg_4_0.nameInput, arg_4_0.linerName)

			return
		else
			({
				actId = var_4_0.id
			}).strValue = getInputText(arg_4_0.nameInput)
			;({
				actId = var_4_0.id
			}).callback = function()
				arg_4_0.linerName = var_0

				setInputText(arg_4_0.nameInput, arg_4_0.linerName)
				pg.TipsMgr.GetInstance():ShowTips(i18n("liner_name_modify"))

				return
			end

			arg_4_0:emit(LinerMediator.SET_NAME, {
				actId = var_4_0.id
			})
		end

		return
	end)

	local var_4_1 = PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED

	arg_4_0.nameInput:GetComponent(typeof(InputField)).interactable = not (PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED)

	setActive(arg_4_0.topUI:Find("name/edit"), not var_4_1)
	onButton(arg_4_0, arg_4_0.topUI:Find("back"), function()
		arg_4_0:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.topUI:Find("home"), function()
		arg_4_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.topUI:Find("help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.liner_help.tip
		})

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.logBtn, function()
		arg_4_0:emit(LinerMediator.GO_SUBLAYER, Context.New({
			mediator = LinerLogBookMediator,
			viewComponent = LinerLogBookLayer
		}))

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.topUI:Find("fullview"), function()
		if arg_4_0.mode == var_0_0.MODE_NORMAL then
			arg_4_0:SwitchMode(var_0_0.MODE_FULLVIEW)
		else
			arg_4_0:SwitchMode(var_0_0.MODE_NORMAL)
		end

		return
	end, SFX_PANEL)
	onScroll(arg_4_0, arg_4_0.mapTF, function(arg_12_0)
		arg_4_0:onDragFunction()

		return
	end)

	return
end

function var_0_0.didEnter(arg_13_0)
	arg_13_0:addListeners()

	arg_13_0.mode = var_0_0.MODE_NORMAL
	arg_13_0.isFirstUpdate = true

	arg_13_0:UpdateData()
	arg_13_0:InitRooms()
	table.insert({}, function(arg_14_0)
		if arg_13_0.activity:GetCurIdx() == 1 then
			arg_13_0:managedTween(LeanTween.delayedCall, function()
				triggerButton(arg_13_0._tf:Find(tostring(arg_13_0.targetIds[1]), arg_13_0.roomsTF))

				return
			end, var_0_0.AUTO_DELAY_TIME, nil)
		else
			arg_14_0()
		end

		return
	end)
	arg_13_0:UpdateView(function()
		seriesAsync(var_0, function()
			return
		end)

		return
	end)

	return
end

function var_0_0.InitRooms(arg_18_0)
	arg_18_0.rooms = {}
	arg_18_0.roomChars = {}
	arg_18_0.roomIds = arg_18_0.activity:GetAllExploreRoomIds()

	eachChild(arg_18_0.roomsTF, function(arg_19_0)
		local var_19_0 = tonumber(arg_19_0.name)

		if not var_19_0 then
			return
		end

		if table.contains(arg_18_0.roomIds, var_19_0) then
			arg_18_0.rooms[var_19_0] = LinerRoom.New(var_19_0)
			arg_18_0.roomChars[var_19_0] = {}
		end

		return
	end)

	arg_18_0.floatItemList = UIItemList.New(arg_18_0.focusTF, arg_18_0.focusTF:Find("tpl"))

	arg_18_0.floatItemList:make(function(arg_20_0, arg_20_1, arg_20_2)
		arg_20_1 = arg_20_1 + 1

		if arg_20_0 == UIItemList.EventUpdate then
			arg_20_2.name = arg_18_0.targetIds[arg_20_1]

			local var_20_0 = arg_18_0.curTime:GetType()

			eachChild(arg_20_2:Find("tag"), function(arg_21_0)
				setActive(arg_21_0, arg_21_0.name == "type" .. var_20_0)

				return
			end)
			eachChild(arg_20_2:Find("arrow"), function(arg_22_0)
				setActive(arg_22_0, arg_22_0.name == "type" .. var_20_0)

				return
			end)
			onButton(arg_18_0, arg_20_2, function()
				arg_18_0:FocusNode(var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.UpdateRooms(arg_24_0)
	eachChild(arg_24_0.roomsTF, function(arg_25_0)
		local var_25_0 = tonumber(arg_25_0.name)

		if not var_25_0 then
			return
		end

		arg_24_0:OnUpdateRoom(var_25_0, arg_25_0)

		return
	end)

	if arg_24_0.isReallyTime then
		arg_24_0:InitRandomChars()
	else
		arg_24_0:FillRandomChars()
	end

	arg_24_0.isFirstUpdate = false

	return
end

function var_0_0.OnUpdateRoom(arg_26_0, arg_26_1, arg_26_2)
	if not table.contains(arg_26_0.roomIds, arg_26_1) then
		setActive(arg_26_2:Find("tag"), false)
		setActive(arg_26_2:Find("mask"), false)
		setActive(arg_26_2:Find("explore"), false)
		onButton(arg_26_0, arg_26_2, function()
			if arg_26_0.mode == var_0_0.MODE_FULLVIEW then
				arg_26_0:SwitchMode(var_0_0.MODE_NORMAL)
				arg_26_0:FocusNode(arg_26_1)
			end

			return
		end, SFX_CONFIRM)

		return
	end

	local var_26_0 = arg_26_0.curTime:GetType()
	local var_26_1 = table.contains(arg_26_0.targetIds, arg_26_1) or var_26_0 == LinerTime.TYPE.EXPLORE
	local var_26_2 = arg_26_2:Find("tag")

	setActive(var_26_2, var_26_1)
	eachChild(var_26_2, function(arg_28_0)
		setActive(arg_28_0, arg_28_0.name == "type" .. var_26_0)

		return
	end)

	local var_26_3 = var_26_0 == LinerTime.TYPE.EXPLORE and not table.contains(arg_26_0.exploredRoomIds, arg_26_1)

	setActive(arg_26_2:Find("mask"), var_26_0 == LinerTime.TYPE.EXPLORE and table.contains(arg_26_0.exploredRoomIds, arg_26_1))
	setActive(arg_26_2:Find("explore"), var_26_3)
	onButton(arg_26_0, arg_26_2, function()
		if arg_26_0.mode == var_0_0.MODE_FULLVIEW then
			arg_26_0:SwitchMode(var_0_0.MODE_NORMAL)
			arg_26_0:FocusNode(arg_26_1)

			return
		end

		if not var_26_1 or var_0 then
			return
		end

		if arg_26_0.isFinishAll and not arg_26_0.isReallyTime then
			pg.NewStoryMgr.GetInstance():Play(arg_26_0.endingStory, function()
				arg_26_0:PlayAnim(function()
					arg_26_0:UpdateData()
					arg_26_0:CheckTime()

					return
				end)

				return
			end)

			return
		end

		switch(var_26_0, {
			[LinerTime.TYPE.TARGET] = function()
				pg.NewStoryMgr.GetInstance():Play(arg_26_0.curTime:GetStory(), function()
					arg_26_0:emit(LinerMediator.CLICK_ROOM, arg_26_0.activity.id, arg_26_1)

					arg_26_0.needAutoCheck = true

					return
				end, true)

				return
			end,
			[LinerTime.TYPE.EXPLORE] = function()
				arg_26_0.roomPage:ExecuteAction("ShowInfo", arg_26_0.activity, arg_26_1, function()
					arg_26_0:CheckTime()

					return
				end)

				return
			end,
			[LinerTime.TYPE.EVENT] = function()
				local var_36_0 = arg_26_0.curTime:GetEventSubType(arg_26_1)

				if var_36_0 == LinerTime.EVENT_SUB_TYPE.CLUE then
					arg_26_0.roomPage:ExecuteAction("ShowInfo", arg_26_0.activity, arg_26_1, function()
						arg_26_0:CheckTime()

						return
					end)
				elseif var_36_0 == LinerTime.EVENT_SUB_TYPE.STORY then
					pg.NewStoryMgr.GetInstance():Play(arg_26_0.curTime:GetStory(arg_26_1), function()
						arg_26_0:emit(LinerMediator.CLICK_ROOM, arg_26_0.activity.id, arg_26_1)

						arg_26_0.needAutoCheck = true

						return
					end, true)
				end

				return
			end,
			[LinerTime.TYPE.STORY] = function()
				seriesAsync({
					function(arg_40_0)
						if arg_26_0.activity:GetCurIdx() == 1 then
							arg_40_0()
						else
							arg_26_0:PlayAnim(function()
								arg_26_0:UpdateBg("day")

								return
							end, arg_40_0)
						end

						return
					end,
					function(arg_42_0)
						pg.NewStoryMgr.GetInstance():Play(arg_26_0.curTime:GetStory(), arg_42_0, true)

						return
					end
				}, function()
					arg_26_0:emit(LinerMediator.CLICK_ROOM, arg_26_0.activity.id, arg_26_1)

					arg_26_0.needAutoCheck = true

					return
				end)

				return
			end
		})

		return
	end, SFX_CONFIRM)

	if not arg_26_0.isFinishAll or arg_26_0.isFinishAll and not arg_26_0.isReallyTime then
		arg_26_0:UpdateRoomChar(arg_26_1, arg_26_2)
	end

	return
end

function var_0_0.UpdateRoomChar(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0

	if arg_44_0.oldTime.id == arg_44_0.curTime.id and not arg_44_0.isFirstUpdate then
		do return end

		var_44_0 = arg_44_0.rooms[arg_44_1]:GetSpineCharInfo(arg_44_0.oldTime.id)
	end

	local var_44_1 = arg_44_0.rooms[arg_44_1]:GetSpineCharInfo(arg_44_0.curTime.id)

	if var_44_0 then
		local var_44_2 = var_44_0[1] or ""

		if var_44_1 then
			local var_44_3 = var_44_1[1] or ""

			if var_44_2 == var_44_3 and not arg_44_0.isFirstUpdate then
				return
			end

			local var_44_4 = arg_44_2:Find("char")

			if arg_44_0.roomChars[arg_44_1][1] and arg_44_0.roomChars[arg_44_1][2] then
				if LeanTween.isTweening(arg_44_0.roomChars[arg_44_1][2]) then
					LeanTween.cancel(arg_44_0.roomChars[arg_44_1][2])
				end

				PoolMgr.GetInstance():ReturnSpineChar(arg_44_0.roomChars[arg_44_1][1], arg_44_0.roomChars[arg_44_1][2])

				arg_44_0.roomChars[arg_44_1][1] = nil
				arg_44_0.roomChars[arg_44_1][2] = nil
			end

			if var_44_3 ~= "" then
				PoolMgr.GetInstance():GetSpineChar(var_44_3, true, function(arg_45_0)
					arg_44_0.roomChars[arg_44_1][1] = var_44_3
					arg_44_0.roomChars[arg_44_1][2] = arg_45_0

					setLocalScale(tf(arg_45_0), {
						x = LinerRoomCharPoint.SCALE,
						y = LinerRoomCharPoint.SCALE
					})
					setParent(arg_45_0, var_44_4)
					arg_44_0:InitCharBehavior(arg_44_1, tf(arg_45_0), var_44_1[2])

					return
				end)
			end

			return
		end
	end
end

function var_0_0.InitCharBehavior(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = LinerRoomCharPoint.SCALE

	if LinerRoomCharPoint[arg_46_1].type == 2 then
		setLocalPosition(arg_46_2, LinerRoomCharPoint[arg_46_1].idlePoint)
		arg_46_2:GetComponent("SpineAnimUI"):SetAction(arg_46_3 or LinerRoomCharPoint.IDLE_ACTION, 0)
	elseif LinerRoomCharPoint[arg_46_1].type == 1 then
		local var_46_1 = LinerRoomCharPoint[arg_46_1].startPoint.x
		local var_46_2 = LinerRoomCharPoint[arg_46_1].endPoint.x

		setLocalPosition(arg_46_2, LinerRoomCharPoint[arg_46_1].startPoint)
		arg_46_2:GetComponent("SpineAnimUI"):SetAction(arg_46_3 or LinerRoomCharPoint.MOVE_ACTION, 0)
		arg_46_0:managedTween(LeanTween.value, nil, go(arg_46_2), LinerRoomCharPoint[arg_46_1].startPoint.x, LinerRoomCharPoint[arg_46_1].endPoint.x, (LinerRoomCharPoint[arg_46_1].endPoint.x - LinerRoomCharPoint[arg_46_1].startPoint.x) / LinerRoomCharPoint.SPEED):setOnUpdate(System.Action_float(function(arg_47_0)
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

function var_0_0.GetRandomItems(arg_48_0, arg_48_1, arg_48_2)
	assert(arg_48_2 <= #arg_48_1, "不合法的随机数量")

	for iter_48_0 = 1, #arg_48_1 do
		table.insert({}, iter_48_0)
	end

	shuffle({})

	for iter_48_1 = 1, arg_48_2 do
		table.insert({}, arg_48_1[({})[iter_48_1]])
	end

	return {}
end

function var_0_0.InitRandomChars(arg_49_0)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.roomChars) do
		if iter_49_1[1] and iter_49_1[2] then
			if LeanTween.isTweening(iter_49_1[2]) then
				LeanTween.cancel(iter_49_1[2])
			end

			PoolMgr.GetInstance():ReturnSpineChar(iter_49_1[1], iter_49_1[2])

			arg_49_0.roomChars[iter_49_0][1] = nil
			arg_49_0.roomChars[iter_49_0][2] = nil
		end
	end

	local var_49_0 = arg_49_0:GetRandomItems(arg_49_0.sdConfig, var_0_0.FINISH_CHAR_CNT)

	for iter_49_2, iter_49_3 in ipairs((arg_49_0:GetRandomItems(underscore.filter(arg_49_0.roomIds, function(arg_50_0)
		return arg_50_0 ~= 4 and arg_50_0 ~= 31
	end), var_0_0.FINISH_CHAR_CNT))) do
		PoolMgr.GetInstance():GetSpineChar(var_49_0[iter_49_2], true, function(arg_51_0)
			arg_49_0.roomChars[iter_49_3][1] = var_0
			arg_49_0.roomChars[iter_49_3][2] = arg_51_0

			setLocalScale(tf(arg_51_0), {
				x = LinerRoomCharPoint.SCALE,
				y = LinerRoomCharPoint.SCALE
			})
			setParent(arg_51_0, (arg_49_0.roomsTF:Find(iter_49_3 .. "/char")))
			arg_49_0:InitCharBehavior(iter_49_3, tf(arg_51_0))

			return
		end)
	end

	return
end

function var_0_0.FillRandomChars(arg_52_0)
	if arg_52_0.oldTime.id == arg_52_0.curTime.id and not arg_52_0.isFirstUpdate then
		return
	end

	local var_52_0 = Clone(arg_52_0.roomIds)
	local var_52_1 = Clone(arg_52_0.sdConfig)
	local var_52_2 = 0

	for iter_52_0, iter_52_1 in ipairs(arg_52_0.roomIds) do
		local var_52_3 = arg_52_0.rooms[iter_52_1]:GetSpineCharInfo(arg_52_0.curTime.id)

		if var_52_3 and var_52_3[1] and var_52_3[2] then
			table.removebyvalue(var_52_0, iter_52_1)

			if table.contains(var_52_1, var_52_3[1]) then
				table.removebyvalue(var_52_1, var_52_3[1])
			end

			var_52_2 = var_52_2 + 1
		end
	end

	if arg_52_0.randomIds and #arg_52_0.randomIds > 0 then
		for iter_52_2, iter_52_3 in pairs(arg_52_0.roomChars) do
			if iter_52_3[1] and iter_52_3[2] and table.contains(arg_52_0.randomIds, iter_52_2) then
				if LeanTween.isTweening(iter_52_3[2]) then
					LeanTween.cancel(iter_52_3[2])
				end

				PoolMgr.GetInstance():ReturnSpineChar(iter_52_3[1], iter_52_3[2])

				arg_52_0.roomChars[iter_52_2][1] = nil
				arg_52_0.roomChars[iter_52_2][2] = nil
			end
		end
	end

	arg_52_0.randomIds = {}
	arg_52_0.randomIds = arg_52_0:GetRandomItems(underscore.filter(var_52_0, function(arg_53_0)
		return arg_53_0 ~= 4 and arg_53_0 ~= 31
	end), var_0_0.FINISH_CHAR_CNT - var_52_2)

	local var_52_4 = arg_52_0:GetRandomItems(var_52_1, var_0_0.FINISH_CHAR_CNT - var_52_2)

	for iter_52_4, iter_52_5 in ipairs(arg_52_0.randomIds) do
		PoolMgr.GetInstance():GetSpineChar(var_52_4[iter_52_4], true, function(arg_54_0)
			arg_52_0.roomChars[iter_52_5][1] = var_0
			arg_52_0.roomChars[iter_52_5][2] = arg_54_0

			setLocalScale(tf(arg_54_0), {
				x = LinerRoomCharPoint.SCALE,
				y = LinerRoomCharPoint.SCALE
			})
			setParent(arg_54_0, (arg_52_0.roomsTF:Find(iter_52_5 .. "/char")))
			arg_52_0:InitCharBehavior(iter_52_5, tf(arg_54_0))

			return
		end)
	end

	return
end

function var_0_0.UpdateBg(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_1 or arg_55_0.curTime:GetBgType()

	for iter_55_0, iter_55_1 in ipairs(arg_55_0.bgDiffList) do
		eachChild(iter_55_1, function(arg_56_0)
			setActive(arg_56_0, arg_56_0.name == var_55_0)

			return
		end)
	end

	return
end

function var_0_0.UpdateFinishTime(arg_57_0)
	local var_57_0 = os.date("*t", os.time())
	local var_57_1 = var_57_0.hour
	local var_57_2 = var_57_0.min
	local var_57_3 = var_57_0.hour < 12 and " AM" or " PM"

	arg_57_0:UpdateBg(arg_57_0.activity:GetReallyTimeType(var_57_0.hour))

	if var_57_1 > 12 then
		var_57_1 = var_57_1 - 12
	end

	setText(arg_57_0.timeTF, string.format("%d:%02d ", var_57_1, var_57_2) .. var_57_3)

	return
end

function var_0_0.UpdateTimeUI(arg_58_0)
	if arg_58_0.isReallyTime then
		eachChild(arg_58_0.targetTagTF, function(arg_59_0)
			setActive(arg_59_0, false)

			return
		end)

		arg_58_0.targetLayoutCom.spacing = -60

		setText(arg_58_0.targetTF, i18n("liner_target_type5"))

		arg_58_0.finishTimer = Timer.New(function()
			arg_58_0:UpdateFinishTime()

			return
		end, 60, -1)

		arg_58_0.finishTimer:Start()
		arg_58_0:UpdateFinishTime()

		return
	end

	setText(arg_58_0.timeTF, arg_58_0.curTime:GetStartTimeDesc())

	local var_58_0 = arg_58_0.curTime:GetType()

	eachChild(arg_58_0.targetTagTF, function(arg_61_0)
		setActive(arg_61_0, not arg_58_0.isFinishAll and arg_61_0.name == "type" .. var_58_0)

		return
	end)

	local var_58_1 = ""

	switch(var_58_0, {
		[LinerTime.TYPE.TARGET] = function()
			var_58_1 = i18n("liner_target_type1", arg_58_0.rooms[arg_58_0.targetIds[1]]:GetName())

			return
		end,
		[LinerTime.TYPE.EXPLORE] = function()
			local var_63_0 = arg_58_0.curTime:GetExploreCnt()

			var_58_1 = i18n("liner_target_type2") .. string.format("(%d/%d)", var_63_0 - arg_58_0.activity:GetRemainExploreCnt(), var_63_0)

			return
		end,
		[LinerTime.TYPE.EVENT] = function()
			local var_64_0 = #arg_58_0.curTime:GetTargetRoomIds()
			local var_64_1 = arg_58_0.activity:GetRoomIdx() - 1

			if arg_58_0.isFinishAll then
				var_64_1 = var_64_0
			end

			var_58_1 = i18n("liner_target_type3") .. string.format("(%d/%d)", var_64_1, var_64_0)

			return
		end,
		[LinerTime.TYPE.STORY] = function()
			var_58_1 = i18n("liner_target_type4", arg_58_0.rooms[arg_58_0.targetIds[1]]:GetName())

			return
		end
	})

	arg_58_0.targetLayoutCom.spacing = (var_58_0 == LinerTime.TYPE.EXPLORE or arg_58_0.isFinishAll) and -60 or -10

	if arg_58_0.isFinishAll then
		var_58_1 = i18n("liner_target_type4")
	end

	setText(arg_58_0.targetTF, var_58_1)

	return
end

function var_0_0.CheckTime(arg_66_0)
	local var_66_0 = arg_66_0.activity:GetCurIdx()

	if arg_66_0.oldTime.id ~= arg_66_0.curTime.id then
		arg_66_0.timePage:ExecuteAction("ShowAnim", arg_66_0.activity, math.max(var_66_0 - 1, 1), var_66_0, function()
			arg_66_0:UpdateView()

			return
		end)
	else
		arg_66_0:UpdateView()
	end

	return
end

function var_0_0.UpdateView(arg_68_0, arg_68_1)
	arg_68_0:UpdateBg()
	arg_68_0:UpdateTimeUI()
	arg_68_0:UpdateRooms()
	arg_68_0:UpdateTips()
	arg_68_0.floatItemList:align(#arg_68_0.targetIds)

	if arg_68_0.curTime:GetType() ~= LinerTime.TYPE.EXPLORE and arg_68_0.targetIds[1] then
		arg_68_0:FocusNode(arg_68_0.targetIds[1], arg_68_1)
	else
		arg_68_0:onDragFunction()
	end

	if arg_68_0.curTime:GetType() == LinerTime.TYPE.EXPLORE then
		if not pg.NewStoryMgr.GetInstance():IsPlayed("Liner_1") then
			arg_68_0:FocusNode(var_0_0.GUIDE_ROOM_ID, function()
				pg.NewGuideMgr.GetInstance():Play("Liner_1")
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = "Liner_1"
				})

				return
			end)
		end
	end

	if arg_68_0.oldTime.id ~= arg_68_0.curTime.id then
		arg_68_0:PlayBGM()
	end

	return
end

function var_0_0.UpdateData(arg_70_0)
	arg_70_0.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LINER)

	local var_70_0 = arg_70_0.activity and not arg_70_0.activity:isEnd()

	assert(var_70_0, "not exist liner act, type: " .. ActivityConst.ACTIVITY_TYPE_LINER)

	arg_70_0.endingStory = arg_70_0.activity:getConfig("config_client").endingstory[1]
	arg_70_0.timeConfig = arg_70_0.activity:getConfig("config_client").endingtime
	arg_70_0.sdConfig = arg_70_0.activity:getConfig("config_client").sd
	arg_70_0.isFinishAll = arg_70_0.activity:IsFinishAllTime()
	arg_70_0.isReallyTime = arg_70_0.isFinishAll and pg.NewStoryMgr.GetInstance():IsPlayed(arg_70_0.endingStory)
	arg_70_0.exploredRoomIds = arg_70_0.activity:GetExploredRoomIds()
	arg_70_0.curEventInfos = arg_70_0.activity:GetCurEventInfo()
	arg_70_0.oldTime = arg_70_0.curTime and Clone(arg_70_0.curTime) or nil
	arg_70_0.curTime = arg_70_0.activity:GetCurTime()
	arg_70_0.oldTime = arg_70_0.oldTime or Clone(arg_70_0.curTime)
	arg_70_0.targetIds = arg_70_0.isFinishAll and (not arg_70_0.isReallyTime and {
		var_0_0.FINISH_TARGET_ROOM_ID
	} or {}) or arg_70_0.curTime:GetType() == LinerTime.TYPE.EVENT and {
		arg_70_0:_getCurEventRoomId()
	} or arg_70_0.curTime:GetTargetRoomIds()

	if arg_70_0.needAutoCheck then
		arg_70_0.needAutoCheck = false

		arg_70_0:CheckTime()
	end

	return
end

function var_0_0._getCurEventRoomId(arg_71_0)
	return arg_71_0.curTime:GetParamInfo()[arg_71_0.activity:GetRoomIdx()][1]
end

function var_0_0.UpdateTips(arg_72_0)
	setActive(arg_72_0.logBtn:Find("tip"), LinerLogBookLayer.IsTip())

	return
end

function var_0_0.onDragFunction(arg_73_0)
	var_0_0.screenPoints = var_0_0.screenPoints or {
		Vector2(-arg_73_0.delta.x, arg_73_0.delta.y),
		Vector2(arg_73_0.delta.x, arg_73_0.delta.y),
		Vector2(arg_73_0.delta.x, -arg_73_0.delta.y),
		Vector2(-arg_73_0.delta.x, -arg_73_0.delta.y)
	}

	for iter_73_0, iter_73_1 in ipairs(arg_73_0.targetIds) do
		local var_73_0 = arg_73_0.roomsTF:Find(tostring(iter_73_1))

		if var_73_0 then
			local var_73_1 = arg_73_0._tf:InverseTransformPoint(var_73_0.position)
			local var_73_2

			for iter_73_2, iter_73_3 in ipairs(var_0_0.screenPoints) do
				local var_73_3 = Vector2(var_73_1.x, var_73_1.y)
				local var_73_4, var_73_5, var_73_6 = LineLine(Vector2.zero, var_73_3, iter_73_3, var_0_0.screenPoints[iter_73_2 % 4 + 1])

				if var_73_4 then
					var_73_2 = var_73_3 * var_73_5

					break
				end
			end

			local var_73_7 = arg_73_0.floatItemList.container:Find(tostring(iter_73_1))
			local var_73_8 = var_73_7:GetComponent(typeof(CanvasGroup))
			local var_73_9 = tobool(var_73_2)

			var_73_8.interactable = var_73_9
			var_73_8.blocksRaycasts = var_73_9
			var_73_8.alpha = var_73_9 and 1 or 0

			setActive(arg_73_0.roomsTF:Find(iter_73_1 .. "/tag"), not var_73_9)

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

function var_0_0.FocusNode(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_0.roomsTF:Find(tostring(arg_74_1)).anchoredPosition * -1

	var_74_0.x = math.clamp(var_74_0.x, -arg_74_0.extendLimit.x, arg_74_0.extendLimit.x)
	var_74_0.y = math.clamp(var_74_0.y, -arg_74_0.extendLimit.y, arg_74_0.extendLimit.y)

	if arg_74_0.twFocusId then
		LeanTween.cancel(arg_74_0.twFocusId)

		arg_74_0.twFocusId = nil
	end

	local var_74_1 = {}

	table.insert({}, function(arg_75_0)
		SetCompomentEnabled(arg_74_0.mapTF, typeof(ScrollRect), false)

		local var_75_0 = (arg_74_0.mapTF.anchoredPosition - var_74_0).magnitude > 0 and (arg_74_0.mapTF.anchoredPosition - var_74_0).magnitude / (40 * math.sqrt((arg_74_0.mapTF.anchoredPosition - var_74_0).magnitude)) or 0
		local var_75_1 = arg_74_0

		var_75_1.twFocusId = LeanTween.move(arg_74_0.mapTF, Vector3(var_74_0.x, var_74_0.y, 0), var_75_0):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_76_0)
			arg_74_0:onDragFunction()

			return
		end)):setOnComplete(System.Action(arg_75_0)).uniqueId

		return
	end)
	seriesAsync(var_74_1, function()
		SetCompomentEnabled(arg_74_0.mapTF, typeof(ScrollRect), true)

		if arg_74_2 then
			arg_74_2()
		end

		return
	end)

	return
end

function var_0_0.SwitchMode(arg_78_0, arg_78_1, arg_78_2)
	arg_78_0.mode = arg_78_1

	local var_78_0 = arg_78_0.mode == var_0_0.MODE_NORMAL

	setActive(arg_78_0.focusTF, arg_78_0.mode == var_0_0.MODE_NORMAL)
	arg_78_0:managedTween(LeanTween.value, nil, go(arg_78_0.mapTF), arg_78_0.mapTF.localScale.x, var_78_0 and 1 or arg_78_0.fullFactor, var_0_0.SCALE_ANIM_TIME):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_79_0)
		setLocalScale(arg_78_0.mapTF, {
			x = arg_79_0,
			y = arg_79_0,
			z = arg_79_0
		})

		return
	end))

	if not var_78_0 then
		arg_78_0:managedTween(LeanTween.move, nil, go(arg_78_0.mapTF), Vector3(0, 0, 0), var_0_0.SCALE_ANIM_TIME):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(function()
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

function var_0_0.PlayAnim(arg_81_0, arg_81_1, arg_81_2)
	seriesAsync({
		function(arg_82_0)
			if not arg_81_0.swithAnimTF then
				PoolMgr.GetInstance():GetUI("OtherworldCoverUI", true, function(arg_83_0)
					arg_81_0.swithAnimTF = arg_83_0.transform

					setParent(arg_81_0.swithAnimTF, arg_81_0._tf, false)
					setActive(arg_81_0.swithAnimTF, false)
					arg_82_0()

					return
				end)
			else
				arg_82_0()
			end

			return
		end,
		function(arg_84_0)
			setActive(arg_81_0.swithAnimTF, true)

			local var_84_0 = arg_81_0.swithAnimTF:Find("yuncaizhuanchang"):GetComponent(typeof(SpineAnimUI))

			var_84_0:SetActionCallBack(function(arg_85_0)
				if arg_85_0 == "finish" then
					if arg_81_2 then
						arg_81_2()
					end

					setActive(arg_81_0.swithAnimTF, false)
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

function var_0_0.onBackPressed(arg_87_0)
	if arg_87_0.timePage and arg_87_0.timePage:GetLoaded() and arg_87_0.timePage:isShowing() then
		return
	end

	var_0_0.super.onBackPressed(arg_87_0)

	return
end

function var_0_0.willExit(arg_88_0)
	arg_88_0.timePage:Destroy()

	arg_88_0.timePage = nil

	arg_88_0.roomPage:Destroy()

	arg_88_0.roomPage = nil

	for iter_88_0, iter_88_1 in pairs(arg_88_0.roomChars) do
		if iter_88_1[1] and iter_88_1[2] then
			PoolMgr.GetInstance():ReturnSpineChar(iter_88_1[1], iter_88_1[2])
		end
	end

	arg_88_0.roomChars = nil

	if arg_88_0.finishTimer ~= nil then
		arg_88_0.finishTimer:Stop()

		arg_88_0.finishTimer = nil
	end

	return
end

return var_0_0
