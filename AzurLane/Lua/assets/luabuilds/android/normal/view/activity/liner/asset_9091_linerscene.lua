class = var_0_10000

local var_0_0 = "LinerScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.AUTO_DELAY_TIME = 0.5
var_0_1.SCALE_ANIM_TIME = 0.5
var_0_1.FINISH_TARGET_ROOM_ID = 4
var_0_1.FINISH_CHAR_CNT = 10
var_0_1.GUIDE_ROOM_ID = 22
var_0_1.MODE_NORMAL = 1
var_0_1.MODE_FULLVIEW = 2

function var_0_1.getUIName(arg_1_0)
	return "LinerMainUI"
end

function var_0_1.PlayBGM(arg_2_0)
	local var_2_2

	if not arg_2_0.activity then
		getProxy = var_1_10002
		ActivityProxy = var_1_10003

		local var_2_0 = var_1_10002(var_1_10003)
		local var_2_1 = var_2.getActivityByType

		ActivityConst = var_1_10004
		var_2_2 = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_LINER)
		assert = var_2

		local var_2_3 = var_2_2 and not var_2_2:isEnd()
		local var_2_4 = "not exist liner act, type: "

		ActivityConst = var_1_10005

		var_2(var_2_3, var_2_4 .. var_1_10005.ACTIVITY_TYPE_LINER)
	end

	local var_2_5 = var_2_2
	local var_2_6 = var_2_2.GetBgmName(var_2_5)

	pg = var_2_5

	local var_2_7 = var_2_5.BgmMgr.GetInstance()

	var_3.Push(var_2_7, arg_2_0.__cname, var_2_6)

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.mapTF = var_1.Find(var_3_0, "map")

	local var_3_1 = arg_3_0.mapTF

	arg_3_0.bgTF = var_1.Find(var_3_1, "bg")

	local var_3_2 = arg_3_0.mapTF

	arg_3_0.roomsTF = var_1.Find(var_3_2, "content")

	local var_3_3 = arg_3_0._tf

	arg_3_0.topUI = var_1.Find(var_3_3, "top")

	local var_3_4 = arg_3_0.topUI

	arg_3_0.nameBgTF = var_1.Find(var_3_4, "name_bg")

	local var_3_5 = arg_3_0.topUI

	arg_3_0.nameInput = var_1.Find(var_3_5, "name/input")

	local var_3_6 = arg_3_0.topUI

	arg_3_0.logBtn = var_1.Find(var_3_6, "logbook")

	local var_3_7 = arg_3_0.topUI

	arg_3_0.timeBgTF = var_1.Find(var_3_7, "time/bg")

	local var_3_8 = arg_3_0.topUI

	arg_3_0.timeTF = var_1.Find(var_3_8, "time/Text")

	local var_3_9 = arg_3_0.topUI

	arg_3_0.targetTagTF = var_1.Find(var_3_9, "time/target/tag")

	local var_3_10 = arg_3_0.topUI
	local var_3_11 = var_1.Find(var_3_10, "time/target")
	local var_3_12 = var_1.GetComponent

	typeof = var_3
	HorizontalLayoutGroup = var_1_10004
	arg_3_0.targetLayoutCom = var_3_12(var_3_11, var_3(var_1_10004))

	local var_3_13 = arg_3_0.topUI

	arg_3_0.targetTF = var_1.Find(var_3_13, "time/target/Text")

	local var_3_14 = arg_3_0.topUI

	arg_3_0.focusTF = var_1.Find(var_3_14, "focus")
	setActive = var_1

	local var_3_15 = arg_3_0.focusTF

	var_1(var_2.Find(var_3_15, "tpl"), false)

	local var_3_16 = {
		arg_3_0.bgTF,
		arg_3_0.nameBgTF,
		arg_3_0.timeBgTF
	}
	local var_3_17 = arg_3_0.roomsTF

	var_3_16[4] = var_2.Find(var_3_17, "1/icon")

	local var_3_18 = arg_3_0.roomsTF

	var_3_16[5] = var_2.Find(var_3_18, "3/icon")

	local var_3_19 = arg_3_0.roomsTF

	var_3_16[6] = var_2.Find(var_3_19, "4/icon")
	arg_3_0.bgDiffList = var_3_16

	local var_3_20 = arg_3_0._tf
	local var_3_21 = var_1.Find(var_3_20, "pages")

	LinerPassTimePage = var_3_20
	arg_3_0.timePage = var_3_20.New(var_3_21, arg_3_0)
	LinerRoomInfoPage = var_2
	arg_3_0.roomPage = var_2.New(var_3_21, arg_3_0)
	getSizeRate = var_2

	local var_3_22, var_3_23, var_3_24 = var_2()

	Vector2 = var_1_10005
	arg_3_0.delta = var_1_10005(var_3_23 - 100, var_3_24 - 100) / 2
	Vector2 = var_5
	arg_3_0.extendLimit = var_5(arg_3_0.mapTF.rect.width - arg_3_0._tf.rect.width, arg_3_0.mapTF.rect.height - arg_3_0._tf.rect.height) / 2
	math = var_5
	arg_3_0.fullFactor = var_5.max(arg_3_0._tf.rect.width / arg_3_0.mapTF.rect.width, arg_3_0._tf.rect.height / arg_3_0.mapTF.rect.height)

	return
end

function var_0_1.addListeners(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_4_2 = var_4_1(var_4_0, var_1_10003.LINER_NAMED_ID)

	assert = var_4_0

	local var_4_3 = var_4_2 and not var_4_2:isEnd()
	local var_4_4 = "not exist named act, id: "

	ActivityConst = var_1_10005

	var_4_0(var_4_3, var_4_4 .. var_1_10005.LINER_NAMED_ID)

	arg_4_0.linerName = var_4_2:getStrData1()
	setInputText = var_2

	var_2(arg_4_0.nameInput, arg_4_0.linerName)

	getProxy = var_2
	PlayerProxy = var_3

	local var_4_5 = var_2(var_3)
	local var_4_6 = var_2.getRawData(var_4_5)

	arg_4_0.defaultName = var_2.GetName(var_4_6)
	onInputEndEdit = var_4_7

	var_4_7(arg_4_0, arg_4_0.nameInput, function(arg_5_0)
		if arg_5_0 ~= arg_4_0.defaultName then
			nameValidityCheck = var_1

			if not var_1(arg_5_0, 4, 14, {
				"spece_illegal_tip",
				"login_newPlayerScene_name_tooShort",
				"login_newPlayerScene_name_tooLong",
				"login_newPlayerScene_invalideName"
			}) then
				setInputText = var_1

				var_1(arg_4_0.nameInput, arg_4_0.linerName)

				do return end

				goto label_5_0
			end
		end

		getInputText = var_1

		do
			local var_5_0 = var_1(arg_4_0.nameInput)
			local var_5_1 = arg_4_0
			local var_5_2 = var_2.emit

			LinerMediator = var_2_10004

			var_5_2(var_5_1, var_2_10004.SET_NAME, {
				actId = var_4_2.id,
				strValue = var_5_0,
				callback = function()
					local var_6_0 = arg_4_0

					var_6_0.linerName = var_5_0
					setInputText = var_6_0

					var_6_0(arg_4_0.nameInput, arg_4_0.linerName)

					pg = var_6_0

					local var_6_1 = var_6_0.TipsMgr.GetInstance()
					local var_6_2 = var_0.ShowTips

					i18n = var_2

					var_6_2(var_6_1, var_2("liner_name_modify"))

					return
				end
			})
		end

		::label_5_0::

		return
	end)

	PLATFORM_CODE = var_4_7
	PLATFORM_CH = var_3

	local var_4_7 = var_4_7 == var_3 and var_4_7
	local var_4_8 = arg_4_0.nameInput
	local var_4_9 = var_3.GetComponent

	typeof = var_5
	InputField = var_1_10006

	local var_4_10 = var_4_9(var_4_8, var_5(var_1_10006))

	var_4_10.interactable = not var_4_7
	setActive = var_4_10

	local var_4_11 = arg_4_0.topUI

	var_4_10(var_4.Find(var_4_11, "name/edit"), not var_4_7)

	onButton = var_4_10

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.topUI
	local var_4_14 = var_5.Find(var_4_13, "back")

	local function var_4_15()
		local var_7_0 = arg_4_0

		var_0.onBackPressed(var_7_0)

		return
	end

	SFX_PANEL = var_7

	var_4_10(var_4_12, var_4_14, var_4_15, var_7)

	onButton = var_4_10

	local var_4_16 = arg_4_0
	local var_4_17 = arg_4_0.topUI
	local var_4_18 = var_5.Find(var_4_17, "home")

	local function var_4_19()
		local var_8_0 = arg_4_0

		var_0.quickExitFunc(var_8_0)

		return
	end

	SFX_PANEL = var_7

	var_4_10(var_4_16, var_4_18, var_4_19, var_7)

	onButton = var_4_10

	local var_4_20 = arg_4_0
	local var_4_21 = arg_4_0.topUI
	local var_4_22 = var_5.Find(var_4_21, "help")

	local function var_4_23()
		pg = var_2_10000

		local var_9_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_9_2.type = var_2_10003
		pg = var_2_10003
		var_9_2.helps = var_2_10003.gametip.liner_help.tip

		var_9_1(var_9_0, var_9_2)

		return
	end

	SFX_CANCEL = var_7

	var_4_10(var_4_20, var_4_22, var_4_23, var_7)

	onButton = var_4_10

	local var_4_24 = arg_4_0
	local var_4_25 = arg_4_0.logBtn

	local function var_4_26()
		local var_10_0 = arg_4_0
		local var_10_1 = var_0.emit

		LinerMediator = var_2_10002

		local var_10_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_10_3 = var_2_10003.New
		local var_10_4 = {}

		LinerLogBookMediator = var_2_10005
		var_10_4.mediator = var_2_10005
		LinerLogBookLayer = var_2_10005
		var_10_4.viewComponent = var_2_10005

		var_10_1(var_10_0, var_10_2, var_10_3(var_10_4))

		return
	end

	SFX_PANEL = var_7

	var_4_10(var_4_24, var_4_25, var_4_26, var_7)

	onButton = var_4_10

	local var_4_27 = arg_4_0
	local var_4_28 = arg_4_0.topUI
	local var_4_29 = var_5.Find(var_4_28, "fullview")

	local function var_4_30()
		if arg_4_0.mode == var_0_1.MODE_NORMAL then
			local var_11_0 = arg_4_0

			var_0.SwitchMode(var_11_0, var_0_1.MODE_FULLVIEW)
		else
			local var_11_1 = arg_4_0

			var_0.SwitchMode(var_11_1, var_0_1.MODE_NORMAL)
		end

		return
	end

	SFX_PANEL = var_7

	var_4_10(var_4_27, var_4_29, var_4_30, var_7)

	onScroll = var_4_10

	var_4_10(arg_4_0, arg_4_0.mapTF, function(arg_12_0)
		local var_12_0 = arg_4_0

		var_1.onDragFunction(var_12_0)

		return
	end)

	return
end

function var_0_1.didEnter(arg_13_0)
	arg_13_0:addListeners()

	arg_13_0.mode = var_0_1.MODE_NORMAL
	arg_13_0.isFirstUpdate = true

	arg_13_0:UpdateData()

	local var_13_0 = arg_13_0

	arg_13_0.InitRooms(var_13_0)

	local var_13_1 = {}

	table = var_13_0

	var_13_0.insert(var_13_1, function(arg_14_0)
		local var_14_0 = arg_13_0.activity

		if var_1.GetCurIdx(var_14_0) == 1 then
			local var_14_1 = arg_13_0
			local var_14_2 = var_1.managedTween

			LeanTween = var_2_10003

			var_14_2(var_14_1, var_2_10003.delayedCall, function()
				local var_15_0 = arg_13_0.targetIds[1]

				triggerButton = var_3_10001

				local var_15_1 = arg_13_0._tf
				local var_15_2 = var_2.Find

				tostring = var_3_10004

				var_3_10001(var_15_2(var_15_1, var_3_10004(var_15_0), arg_13_0.roomsTF))

				return
			end, var_0_1.AUTO_DELAY_TIME, nil)
		else
			arg_14_0()
		end

		return
	end)
	arg_13_0:UpdateView(function()
		seriesAsync = var_2_10000

		var_2_10000(var_13_1, function()
			return
		end)

		return
	end)

	return
end

function var_0_1.InitRooms(arg_18_0)
	arg_18_0.rooms = {}
	arg_18_0.roomChars = {}

	local var_18_0 = arg_18_0.activity

	arg_18_0.roomIds = var_1.GetAllExploreRoomIds(var_18_0)
	eachChild = var_1

	var_1(arg_18_0.roomsTF, function(arg_19_0)
		tonumber = var_2_10001

		if not var_2_10001(arg_19_0.name) then
			return
		end

		table = var_2

		if var_2.contains(arg_18_0.roomIds, var_1) then
			local var_19_0 = arg_18_0.rooms

			LinerRoom = var_3
			var_19_0[var_1] = var_3.New(var_1)
			arg_18_0.roomChars[var_1] = {}
		end

		return
	end)

	UIItemList = var_1

	local var_18_1 = var_1.New
	local var_18_2 = arg_18_0.focusTF
	local var_18_3 = arg_18_0.focusTF

	arg_18_0.floatItemList = var_18_1(var_18_2, var_3.Find(var_18_3, "tpl"))

	local var_18_4 = arg_18_0.floatItemList

	var_1.make(var_18_4, function(arg_20_0, arg_20_1, arg_20_2)
		arg_20_1 = arg_20_1 + 1
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			arg_20_2.name = arg_18_0.targetIds[arg_20_1]

			local var_20_0 = arg_18_0.curTime
			local var_20_1 = var_4.GetType(var_20_0)

			eachChild = var_20_0

			var_20_0(arg_20_2:Find("tag"), function(arg_21_0)
				setActive = var_3_10001

				var_3_10001(arg_21_0, arg_21_0.name == "type" .. var_20_1)

				return
			end)

			eachChild = var_20_0

			var_20_0(arg_20_2:Find("arrow"), function(arg_22_0)
				setActive = var_3_10001

				var_3_10001(arg_22_0, arg_22_0.name == "type" .. var_20_1)

				return
			end)

			onButton = var_20_0

			local var_20_2 = arg_18_0
			local var_20_3 = arg_20_2

			local function var_20_4()
				local var_23_0 = arg_18_0

				var_0.FocusNode(var_23_0, var_0)

				return
			end

			SFX_PANEL = var_2_10009

			var_20_0(var_20_2, var_20_3, var_20_4, var_2_10009)
		end

		return
	end)

	return
end

function var_0_1.UpdateRooms(arg_24_0)
	eachChild = var_1_10001

	var_1_10001(arg_24_0.roomsTF, function(arg_25_0)
		tonumber = var_2_10001

		if not var_2_10001(arg_25_0.name) then
			return
		end

		local var_25_0 = arg_24_0

		var_2.OnUpdateRoom(var_25_0, var_1, arg_25_0)

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

function var_0_1.OnUpdateRoom(arg_26_0, arg_26_1, arg_26_2)
	table = var_1_10003

	if not var_1_10003.contains(arg_26_0.roomIds, arg_26_1) then
		setActive = var_3

		var_3(arg_26_2:Find("tag"), false)

		setActive = var_3

		var_3(arg_26_2:Find("mask"), false)

		setActive = var_3

		var_3(arg_26_2:Find("explore"), false)

		onButton = var_3

		local var_26_0 = arg_26_0
		local var_26_1 = arg_26_2

		local function var_26_2()
			if arg_26_0.mode == var_0_1.MODE_FULLVIEW then
				local var_27_0 = arg_26_0

				var_0.SwitchMode(var_27_0, var_0_1.MODE_NORMAL)

				local var_27_1 = arg_26_0

				var_0.FocusNode(var_27_1, arg_26_1)
			end

			return
		end

		SFX_CONFIRM = var_1_10007

		var_3(var_26_0, var_26_1, var_26_2, var_1_10007)

		return
	end

	local var_26_3 = arg_26_0.curTime
	local var_26_4 = var_3.GetType(var_26_3)

	table = var_26_3

	local var_26_5

	if not var_26_3.contains(arg_26_0.targetIds, arg_26_1) then
		LinerTime = var_26_5
		var_26_5 = var_26_4 == var_26_5.TYPE.EXPLORE
	end

	local var_26_6 = arg_26_2
	local var_26_7 = arg_26_2.Find(var_26_6, "tag")

	setActive = var_26_6

	var_26_6(var_26_7, var_26_5)

	eachChild = var_26_6

	var_26_6(var_26_7, function(arg_28_0)
		setActive = var_2_10001

		var_2_10001(arg_28_0, arg_28_0.name == "type" .. var_26_4)

		return
	end)

	LinerTime = var_26_6

	local var_26_8

	if var_26_4 == var_26_6.TYPE.EXPLORE then
		table = var_6
		var_26_8 = var_6.contains(arg_26_0.exploredRoomIds, arg_26_1)
	else
		var_26_8 = false
	end

	if false then
		var_26_8 = true
	end

	LinerTime = var_7

	local var_26_9

	if var_26_4 == var_7.TYPE.EXPLORE then
		table = var_7
		var_26_9 = not var_7.contains(arg_26_0.exploredRoomIds, arg_26_1)
	else
		var_26_9 = false
	end

	if false then
		var_26_9 = true
	end

	setActive = var_8

	var_8(arg_26_2:Find("mask"), var_26_8)

	setActive = var_8

	var_8(arg_26_2:Find("explore"), var_26_9)

	onButton = var_8

	local var_26_10 = arg_26_0
	local var_26_11 = arg_26_2

	local function var_26_12()
		if arg_26_0.mode == var_0_1.MODE_FULLVIEW then
			local var_29_0 = arg_26_0

			var_0.SwitchMode(var_29_0, var_0_1.MODE_NORMAL)

			local var_29_1 = arg_26_0

			var_0.FocusNode(var_29_1, arg_26_1)

			return
		end

		if not var_26_5 or var_26_8 then
			return
		end

		if arg_26_0.isFinishAll and not arg_26_0.isReallyTime then
			pg = var_0

			local var_29_2 = var_0.NewStoryMgr.GetInstance()

			var_0.Play(var_29_2, arg_26_0.endingStory, function()
				local var_30_0 = arg_26_0

				var_0.PlayAnim(var_30_0, function()
					local var_31_0 = arg_26_0

					var_0.UpdateData(var_31_0)

					local var_31_1 = arg_26_0

					var_0.CheckTime(var_31_1)

					return
				end)

				return
			end)

			return
		end

		switch = var_0

		local var_29_3 = var_26_4
		local var_29_4 = {}

		LinerTime = var_2_10003
		var_29_4[var_2_10003.TYPE.TARGET] = function()
			pg = var_3_10000

			local var_32_0 = var_3_10000.NewStoryMgr.GetInstance()
			local var_32_1 = var_0.Play
			local var_32_2 = arg_26_0.curTime

			var_32_1(var_32_0, var_2.GetStory(var_32_2), function()
				local var_33_0 = arg_26_0
				local var_33_1 = var_0.emit

				LinerMediator = var_4_10002

				var_33_1(var_33_0, var_4_10002.CLICK_ROOM, arg_26_0.activity.id, arg_26_1)

				arg_26_0.needAutoCheck = true

				return
			end, true)

			return
		end
		LinerTime = var_3
		var_29_4[var_3.TYPE.EXPLORE] = function()
			local var_34_0 = arg_26_0.roomPage

			var_0.ExecuteAction(var_34_0, "ShowInfo", arg_26_0.activity, arg_26_1, function()
				local var_35_0 = arg_26_0

				var_0.CheckTime(var_35_0)

				return
			end)

			return
		end
		LinerTime = var_3
		var_29_4[var_3.TYPE.EVENT] = function()
			local var_36_0 = arg_26_0.curTime
			local var_36_1 = var_0.GetEventSubType(var_36_0, arg_26_1)

			LinerTime = var_36_0

			if var_36_1 == var_36_0.EVENT_SUB_TYPE.CLUE then
				local var_36_2 = arg_26_0.roomPage

				var_1.ExecuteAction(var_36_2, "ShowInfo", arg_26_0.activity, arg_26_1, function()
					local var_37_0 = arg_26_0

					var_0.CheckTime(var_37_0)

					return
				end)
			else
				LinerTime = var_1

				if var_36_1 == var_1.EVENT_SUB_TYPE.STORY then
					pg = var_1

					local var_36_3 = var_1.NewStoryMgr.GetInstance()
					local var_36_4 = var_1.Play
					local var_36_5 = arg_26_0.curTime

					var_36_4(var_36_3, var_3.GetStory(var_36_5, arg_26_1), function()
						local var_38_0 = arg_26_0
						local var_38_1 = var_0.emit

						LinerMediator = var_4_10002

						var_38_1(var_38_0, var_4_10002.CLICK_ROOM, arg_26_0.activity.id, arg_26_1)

						arg_26_0.needAutoCheck = true

						return
					end, true)
				end
			end

			return
		end
		LinerTime = var_3
		var_29_4[var_3.TYPE.STORY] = function()
			seriesAsync = var_3_10000

			var_3_10000({
				function(arg_40_0)
					local var_40_0 = arg_26_0.activity

					if var_1.GetCurIdx(var_40_0) == 1 then
						arg_40_0()
					else
						local var_40_1 = arg_26_0

						var_2.PlayAnim(var_40_1, function()
							local var_41_0 = arg_26_0

							var_0.UpdateBg(var_41_0, "day")

							return
						end, arg_40_0)
					end

					return
				end,
				function(arg_42_0)
					pg = var_4_10001

					local var_42_0 = var_4_10001.NewStoryMgr.GetInstance()
					local var_42_1 = var_1.Play
					local var_42_2 = arg_26_0.curTime

					var_42_1(var_42_0, var_3.GetStory(var_42_2), arg_42_0, true)

					return
				end
			}, function()
				local var_43_0 = arg_26_0
				local var_43_1 = var_0.emit

				LinerMediator = var_4_10002

				var_43_1(var_43_0, var_4_10002.CLICK_ROOM, arg_26_0.activity.id, arg_26_1)

				arg_26_0.needAutoCheck = true

				return
			end)

			return
		end

		var_0(var_29_3, var_29_4)

		return
	end

	SFX_CONFIRM = var_1_10012

	var_8(var_26_10, var_26_11, var_26_12, var_1_10012)

	if not arg_26_0.isFinishAll or arg_26_0.isFinishAll and not arg_26_0.isReallyTime then
		arg_26_0:UpdateRoomChar(arg_26_1, arg_26_2)
	end

	return
end

function var_0_1.UpdateRoomChar(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_0.oldTime.id == arg_44_0.curTime.id and not arg_44_0.isFirstUpdate then
		return
	end

	local var_44_0 = arg_44_0.rooms[arg_44_1]
	local var_44_1 = var_3.GetSpineCharInfo(var_44_0, arg_44_0.oldTime.id)
	local var_44_2 = var_3:GetSpineCharInfo(arg_44_0.curTime.id)
	local var_44_3

	if not var_44_1 or not var_44_1[1] then
		var_44_3 = ""
	end

	local var_44_4

	if not var_44_2 or not var_44_2[1] then
		var_44_4 = ""
	end

	if var_44_3 == var_44_4 and not arg_44_0.isFirstUpdate then
		return
	end

	local var_44_5 = arg_44_2:Find("char")
	local var_44_7

	if arg_44_0.roomChars[arg_44_1][1] and arg_44_0.roomChars[arg_44_1][2] then
		LeanTween = var_44_7

		if var_44_7.isTweening(arg_44_0.roomChars[arg_44_1][2]) then
			LeanTween = var_44_7

			var_44_7.cancel(arg_44_0.roomChars[arg_44_1][2])
		end

		PoolMgr = var_44_7

		local var_44_6 = var_44_7.GetInstance()

		var_44_7.ReturnSpineChar(var_44_6, arg_44_0.roomChars[arg_44_1][1], arg_44_0.roomChars[arg_44_1][2])

		var_44_7 = arg_44_0.roomChars[arg_44_1]
		var_44_7[1] = nil
		var_44_7 = arg_44_0.roomChars[arg_44_1]
		var_44_7[2] = nil
	end

	if var_44_4 ~= "" then
		PoolMgr = var_44_7

		local var_44_8 = var_44_7.GetInstance()

		var_9.GetSpineChar(var_44_8, var_44_4, true, function(arg_45_0)
			arg_44_0.roomChars[arg_44_1][1] = var_44_4

			local var_45_0 = arg_44_0.roomChars[arg_44_1]

			var_45_0[2] = arg_45_0
			setLocalScale = var_45_0
			tf = var_2

			local var_45_1 = var_2(arg_45_0)
			local var_45_2 = {}

			LinerRoomCharPoint = var_2_10004
			var_45_2.x = var_2_10004.SCALE
			LinerRoomCharPoint = var_4
			var_45_2.y = var_4.SCALE

			var_45_0(var_45_1, var_45_2)

			setParent = var_45_0

			var_45_0(arg_45_0, var_44_5)

			local var_45_3 = arg_44_0
			local var_45_4 = var_1.InitCharBehavior
			local var_45_5 = arg_44_1

			tf = var_4

			var_45_4(var_45_3, var_45_5, var_4(arg_45_0), var_44_2[2])

			return
		end)
	end

	return
end

function var_0_1.InitCharBehavior(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	LinerRoomCharPoint = var_1_10004

	local var_46_0 = var_1_10004[arg_46_1]

	LinerRoomCharPoint = var_1_10005

	local var_46_1 = var_1_10005.SCALE

	if var_46_0.type == 2 then
		setLocalPosition = var_46_2

		var_46_2(arg_46_2, var_46_0.idlePoint)

		local var_46_2

		if not arg_46_3 then
			::label_46_0::

			LinerRoomCharPoint = var_46_2
			var_46_2 = var_46_2.IDLE_ACTION
		end

		local var_46_3 = arg_46_2:GetComponent("SpineAnimUI")

		var_7.SetAction(var_46_3, var_46_2, 0)
	elseif var_46_0.type == 1 then
		local var_46_4 = var_46_0.startPoint.x
		local var_46_5 = var_46_0.endPoint.x - var_46_4

		LinerRoomCharPoint = var_1_10009

		local var_46_6 = var_46_5 / var_1_10009.SPEED

		setLocalPosition = var_46_7

		var_46_7(arg_46_2, var_46_0.startPoint)

		local var_46_7

		if not arg_46_3 then
			::label_46_1::

			LinerRoomCharPoint = var_46_7
			var_46_7 = var_46_7.MOVE_ACTION
		end

		local var_46_8 = arg_46_2:GetComponent("SpineAnimUI")

		var_10.SetAction(var_46_8, var_46_7, 0)

		local var_46_9 = arg_46_0
		local var_46_10 = arg_46_0.managedTween

		LeanTween = var_12

		local var_46_11 = var_12.value
		local var_46_12

		go = var_1_10014

		local var_46_13 = var_46_10(var_46_9, var_46_11, var_46_12, var_1_10014(arg_46_2), var_46_4, var_7, var_46_6)
		local var_46_14 = var_10.setOnUpdate

		System = var_46_11

		local var_46_15 = var_46_14(var_46_13, var_46_11.Action_float(function(arg_47_0)
			setLocalPosition = var_2_10001

			var_2_10001(arg_46_2, {
				x = arg_47_0
			})

			if arg_47_0 == var_46_4 then
				setLocalScale = var_1

				var_1(arg_46_2, {
					x = var_46_1,
					y = var_46_1
				})
			end

			if arg_47_0 == var_0 then
				setLocalScale = var_1

				var_1(arg_46_2, {
					x = -var_46_1,
					y = var_46_1
				})
			end

			return
		end))

		var_10.setLoopPingPong(var_46_15)
	end

	return
end

function var_0_1.GetRandomItems(arg_48_0, arg_48_1, arg_48_2)
	assert = var_1_10003

	var_1_10003(arg_48_2 <= #arg_48_1, "不合法的随机数量")

	local var_48_0 = {}

	for iter_48_0 = 1, #arg_48_1 do
		table = var_1_10008

		var_1_10008.insert(var_48_0, iter_48_0)
	end

	shuffle = var_4

	var_4(var_48_0)

	local var_48_1 = {}

	for iter_48_1 = 1, arg_48_2 do
		table = var_1_10009

		var_1_10009.insert(var_48_1, arg_48_1[var_48_0[iter_48_1]])
	end

	return var_48_1
end

function var_0_1.InitRandomChars(arg_49_0)
	pairs = var_1_10001

	for iter_49_0, iter_49_1 in var_1_10001(arg_49_0.roomChars) do
		if iter_49_1[1] and iter_49_1[2] then
			LeanTween = var_6

			if var_6.isTweening(iter_49_1[2]) then
				LeanTween = var_6

				var_6.cancel(iter_49_1[2])
			end

			PoolMgr = var_6

			local var_49_0 = var_6.GetInstance()

			var_6.ReturnSpineChar(var_49_0, iter_49_1[1], iter_49_1[2])

			arg_49_0.roomChars[iter_49_0][1] = nil
			arg_49_0.roomChars[iter_49_0][2] = nil
		end
	end

	local var_49_1 = arg_49_0
	local var_49_2 = arg_49_0.GetRandomItems

	underscore = var_3

	local var_49_3 = var_49_2(var_49_1, var_3.filter(arg_49_0.roomIds, function(arg_50_0)
		return arg_50_0 ~= 4 and arg_50_0 ~= 31
	end), var_0_1.FINISH_CHAR_CNT)
	local var_49_4 = arg_49_0
	local var_49_5 = arg_49_0.GetRandomItems(var_49_4, arg_49_0.sdConfig, var_0_1.FINISH_CHAR_CNT)

	ipairs = var_49_4

	for iter_49_2, iter_49_3 in var_49_4(var_49_3) do
		local var_49_6 = var_49_5[iter_49_2]

		PoolMgr = var_1_10009

		local var_49_7 = var_1_10009.GetInstance()

		var_1_10009.GetSpineChar(var_49_7, var_49_6, true, function(arg_51_0)
			arg_49_0.roomChars[iter_49_3][1] = var_49_6
			arg_49_0.roomChars[iter_49_3][2] = arg_51_0

			local var_51_0 = arg_49_0.roomsTF
			local var_51_1 = var_1.Find(var_51_0, iter_49_3 .. "/char")

			setLocalScale = var_51_0
			tf = var_3

			local var_51_2 = var_3(arg_51_0)
			local var_51_3 = {}

			LinerRoomCharPoint = var_2_10005
			var_51_3.x = var_2_10005.SCALE
			LinerRoomCharPoint = var_5
			var_51_3.y = var_5.SCALE

			var_51_0(var_51_2, var_51_3)

			setParent = var_51_0

			var_51_0(arg_51_0, var_51_1)

			local var_51_4 = arg_49_0
			local var_51_5 = var_2.InitCharBehavior
			local var_51_6 = iter_49_3

			tf = var_5

			var_51_5(var_51_4, var_51_6, var_5(arg_51_0))

			return
		end)
	end

	return
end

function var_0_1.FillRandomChars(arg_52_0)
	if arg_52_0.oldTime.id == arg_52_0.curTime.id and not arg_52_0.isFirstUpdate then
		return
	end

	Clone = var_1

	local var_52_0 = var_1(arg_52_0.roomIds)

	Clone = var_2

	local var_52_1 = var_2(arg_52_0.sdConfig)
	local var_52_2 = 0

	ipairs = var_1_10004

	for iter_52_2, iter_52_1 in var_1_10004(arg_52_0.roomIds) do
		local var_52_3 = arg_52_0.rooms[iter_52_1]

		if var_9.GetSpineCharInfo(var_52_3, arg_52_0.curTime.id) and var_9[1] and var_9[2] then
			table = var_10

			var_10.removebyvalue(var_52_0, iter_52_1)

			table = var_10

			if var_10.contains(var_52_1, var_9[1]) then
				table = var_10

				var_10.removebyvalue(var_52_1, var_9[1])
			end

			var_52_2 = var_52_2 + 1
		end
	end

	if arg_52_0.randomIds and #arg_52_0.randomIds > 0 then
		pairs = var_4

		for iter_52_2, iter_52_3 in var_4(arg_52_0.roomChars) do
			if iter_52_3[1] and iter_52_3[2] then
				table = var_9

				if var_9.contains(arg_52_0.randomIds, iter_52_2) then
					LeanTween = var_9

					if var_9.isTweening(iter_52_3[2]) then
						LeanTween = var_9

						var_9.cancel(iter_52_3[2])
					end

					PoolMgr = var_9

					local var_52_4 = var_9.GetInstance()

					var_9.ReturnSpineChar(var_52_4, iter_52_3[1], iter_52_3[2])

					arg_52_0.roomChars[iter_52_2][1] = nil
					arg_52_0.roomChars[iter_52_2][2] = nil
				end
			end
		end
	end

	arg_52_0.randomIds = {}

	local var_52_5 = var_0_1.FINISH_CHAR_CNT - var_52_2
	local var_52_6 = arg_52_0
	local var_52_7 = arg_52_0.GetRandomItems

	underscore = iter_52_2
	arg_52_0.randomIds = var_52_7(var_52_6, iter_52_2.filter(var_52_0, function(arg_53_0)
		return arg_53_0 ~= 4 and arg_53_0 ~= 31
	end), var_52_5)

	local var_52_8 = arg_52_0
	local var_52_9 = arg_52_0.GetRandomItems(var_52_8, var_52_1, var_52_5)

	ipairs = var_52_8

	for iter_52_4, iter_52_5 in var_52_8(arg_52_0.randomIds) do
		local var_52_10 = var_52_9[iter_52_4]

		PoolMgr = var_1_10012

		local var_52_11 = var_1_10012.GetInstance()

		var_1_10012.GetSpineChar(var_52_11, var_52_10, true, function(arg_54_0)
			arg_52_0.roomChars[iter_52_5][1] = var_52_10
			arg_52_0.roomChars[iter_52_5][2] = arg_54_0

			local var_54_0 = arg_52_0.roomsTF
			local var_54_1 = var_1.Find(var_54_0, iter_52_5 .. "/char")

			setLocalScale = var_54_0
			tf = var_3

			local var_54_2 = var_3(arg_54_0)
			local var_54_3 = {}

			LinerRoomCharPoint = var_2_10005
			var_54_3.x = var_2_10005.SCALE
			LinerRoomCharPoint = var_5
			var_54_3.y = var_5.SCALE

			var_54_0(var_54_2, var_54_3)

			setParent = var_54_0

			var_54_0(arg_54_0, var_54_1)

			local var_54_4 = arg_52_0
			local var_54_5 = var_2.InitCharBehavior
			local var_54_6 = iter_52_5

			tf = var_5

			var_54_5(var_54_4, var_54_6, var_5(arg_54_0))

			return
		end)
	end

	return
end

function var_0_1.UpdateBg(arg_55_0, arg_55_1)
	local var_55_0

	if not arg_55_1 then
		::label_55_0::

		var_1_10003 = arg_55_0.curTime
		var_55_0 = var_2.GetBgType(var_1_10003)
	end

	ipairs = var_1_10003

	for iter_55_0, iter_55_1 in var_1_10003(arg_55_0.bgDiffList) do
		eachChild = var_1_10008

		var_1_10008(iter_55_1, function(arg_56_0)
			setActive = var_2_10001

			var_2_10001(arg_56_0, arg_56_0.name == var_55_0)

			return
		end)
	end

	return
end

function var_0_1.UpdateFinishTime(arg_57_0)
	os = var_1_10001

	local var_57_0 = var_1_10001.date
	local var_57_1 = "*t"

	os = var_1_10003

	local var_57_2 = var_57_0(var_57_1, var_1_10003.time()).hour
	local var_57_3 = var_1.min
	local var_57_4 = var_57_2 < 12 and " AM" or " PM"
	local var_57_5 = arg_57_0
	local var_57_6 = arg_57_0.UpdateBg
	local var_57_7 = arg_57_0.activity

	var_57_6(var_57_5, var_7.GetReallyTimeType(var_57_7, var_57_2))

	if 12 < var_57_2 then
		var_57_2 = var_57_2 - 12
	end

	setText = var_5

	local var_57_8 = arg_57_0.timeTF

	string = var_7

	var_5(var_57_8, var_7.format("%d:%02d ", var_57_2, var_57_3) .. var_57_4)

	return
end

function var_0_1.UpdateTimeUI(arg_58_0)
	local var_58_0

	if arg_58_0.isReallyTime then
		eachChild = var_58_0

		var_58_0(arg_58_0.targetTagTF, function(arg_59_0)
			setActive = var_2_10001

			var_2_10001(arg_59_0, false)

			return
		end)

		var_58_0 = arg_58_0.targetLayoutCom
		var_58_0.spacing = -60
		setText = var_58_0

		local var_58_1 = arg_58_0.targetTF

		i18n = var_3

		var_58_0(var_58_1, var_3("liner_target_type5"))

		Timer = var_58_0
		arg_58_0.finishTimer = var_58_0.New(function()
			local var_60_0 = arg_58_0

			var_0.UpdateFinishTime(var_60_0)

			return
		end, 60, -1)

		local var_58_2 = arg_58_0.finishTimer

		var_58_0.Start(var_58_2)
		arg_58_0:UpdateFinishTime()

		return
	end

	setText = var_58_0

	local var_58_3 = arg_58_0.timeTF
	local var_58_4 = arg_58_0.curTime

	var_58_0(var_58_3, var_3.GetStartTimeDesc(var_58_4))

	local var_58_5 = arg_58_0.curTime
	local var_58_6 = var_1.GetType(var_58_5)

	eachChild = var_58_5

	var_58_5(arg_58_0.targetTagTF, function(arg_61_0)
		setActive = var_2_10001

		var_2_10001(arg_61_0, not arg_58_0.isFinishAll and arg_61_0.name == "type" .. var_58_6)

		return
	end)

	local var_58_7 = ""

	switch = var_3

	local var_58_8 = var_58_6
	local var_58_9 = {}

	LinerTime = var_1_10006
	var_58_9[var_1_10006.TYPE.TARGET] = function()
		i18n = var_2_10000

		local var_62_0 = "liner_target_type1"
		local var_62_1 = arg_58_0.rooms[arg_58_0.targetIds[1]]

		var_58_7 = var_2_10000(var_62_0, var_2.GetName(var_62_1))

		return
	end
	LinerTime = var_6
	var_58_9[var_6.TYPE.EXPLORE] = function()
		local var_63_0 = arg_58_0.curTime
		local var_63_1 = var_0.GetExploreCnt(var_63_0)
		local var_63_2 = arg_58_0.activity
		local var_63_3 = var_1.GetRemainExploreCnt(var_63_2)

		i18n = var_63_2

		local var_63_4 = var_63_2("liner_target_type2")

		string = var_3
		var_58_7 = var_63_4 .. var_3.format("(%d/%d)", var_63_1 - var_63_3, var_63_1)

		return
	end
	LinerTime = var_6
	var_58_9[var_6.TYPE.EVENT] = function()
		local var_64_0 = arg_58_0.curTime
		local var_64_1 = #var_0.GetTargetRoomIds(var_64_0)
		local var_64_2 = arg_58_0.activity
		local var_64_3 = var_1.GetRoomIdx(var_64_2) - 1

		if arg_58_0.isFinishAll then
			var_64_3 = var_64_1
		end

		i18n = var_2

		local var_64_4 = var_2("liner_target_type3")

		string = var_3
		var_58_7 = var_64_4 .. var_3.format("(%d/%d)", var_64_3, var_64_1)

		return
	end
	LinerTime = var_6
	var_58_9[var_6.TYPE.STORY] = function()
		i18n = var_2_10000

		local var_65_0 = "liner_target_type4"
		local var_65_1 = arg_58_0.rooms[arg_58_0.targetIds[1]]

		var_58_7 = var_2_10000(var_65_0, var_2.GetName(var_65_1))

		return
	end

	var_3(var_58_8, var_58_9)

	local var_58_10 = arg_58_0.targetLayoutCom

	LinerTime = var_58_8
	var_58_10.spacing = (var_58_6 == var_58_8.TYPE.EXPLORE or arg_58_0.isFinishAll) and -60 or -10

	if arg_58_0.isFinishAll then
		i18n = var_3
		var_58_7 = var_3("liner_target_type4")
	end

	setText = var_3

	var_3(arg_58_0.targetTF, var_58_7)

	return
end

function var_0_1.CheckTime(arg_66_0)
	local var_66_0 = arg_66_0.oldTime.id ~= arg_66_0.curTime.id
	local var_66_1 = arg_66_0.activity
	local var_66_2 = var_2.GetCurIdx(var_66_1)

	math = var_66_1

	local var_66_3 = var_66_1.max(var_66_2 - 1, 1)

	if var_66_0 then
		local var_66_4 = arg_66_0.timePage

		var_4.ExecuteAction(var_66_4, "ShowAnim", arg_66_0.activity, var_66_3, var_66_2, function()
			local var_67_0 = arg_66_0

			var_0.UpdateView(var_67_0)

			return
		end)
	else
		arg_66_0:UpdateView()
	end

	return
end

function var_0_1.UpdateView(arg_68_0, arg_68_1)
	arg_68_0:UpdateBg()
	arg_68_0:UpdateTimeUI()
	arg_68_0:UpdateRooms()
	arg_68_0:UpdateTips()

	local var_68_0 = arg_68_0.floatItemList

	var_2.align(var_68_0, #arg_68_0.targetIds)

	local var_68_1 = arg_68_0.curTime
	local var_68_2 = var_2.GetType(var_68_1)

	LinerTime = var_68_1

	if var_68_2 ~= var_68_1.TYPE.EXPLORE and arg_68_0.targetIds[1] then
		arg_68_0:FocusNode(arg_68_0.targetIds[1], arg_68_1)
	else
		arg_68_0:onDragFunction()
	end

	local var_68_3 = arg_68_0.curTime
	local var_68_4 = var_2.GetType(var_68_3)

	LinerTime = var_68_3

	if var_68_4 == var_68_3.TYPE.EXPLORE then
		pg = var_68_4

		local var_68_5 = var_68_4.NewStoryMgr.GetInstance()

		if not var_2.IsPlayed(var_68_5, "Liner_1") then
			arg_68_0:FocusNode(var_0_1.GUIDE_ROOM_ID, function()
				pg = var_2_10000

				local var_69_0 = var_2_10000.NewGuideMgr.GetInstance()

				var_0.Play(var_69_0, "Liner_1")

				pg = var_0

				local var_69_1 = var_0.m02
				local var_69_2 = var_0.sendNotification

				GAME = var_2

				var_69_2(var_69_1, var_2.STORY_UPDATE, {
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

function var_0_1.UpdateData(arg_70_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_70_0 = var_1_10001(var_1_10002)
	local var_70_1 = var_1.getActivityByType

	ActivityConst = var_1_10003
	arg_70_0.activity = var_70_1(var_70_0, var_1_10003.ACTIVITY_TYPE_LINER)
	assert = var_1

	local var_70_3

	if arg_70_0.activity then
		local var_70_2 = arg_70_0.activity

		var_70_3 = not var_2.isEnd(var_70_2)
	end

	local var_70_4 = "not exist liner act, type: "

	ActivityConst = var_1_10004

	var_1(var_70_3, var_70_4 .. var_1_10004.ACTIVITY_TYPE_LINER)

	local var_70_5 = arg_70_0.activity

	arg_70_0.endingStory = var_1.getConfig(var_70_5, "config_client").endingstory[1]

	local var_70_6 = arg_70_0.activity

	arg_70_0.timeConfig = var_1.getConfig(var_70_6, "config_client").endingtime

	local var_70_7 = arg_70_0.activity

	arg_70_0.sdConfig = var_1.getConfig(var_70_7, "config_client").sd

	local var_70_8 = arg_70_0.activity

	arg_70_0.isFinishAll = var_1.IsFinishAllTime(var_70_8)

	local var_70_10

	if arg_70_0.isFinishAll then
		pg = var_70_10

		local var_70_9 = var_70_10.NewStoryMgr.GetInstance()

		var_70_10 = var_70_10.IsPlayed(var_70_9, arg_70_0.endingStory)
	end

	arg_70_0.isReallyTime = var_70_10

	local var_70_11 = arg_70_0.activity

	arg_70_0.exploredRoomIds = var_1.GetExploredRoomIds(var_70_11)

	local var_70_12 = arg_70_0.activity

	arg_70_0.curEventInfos = var_1.GetCurEventInfo(var_70_12)

	if arg_70_0.curTime then
		Clone = var_1

		local var_70_13

		if not var_1(arg_70_0.curTime) then
			var_70_13 = nil
		end

		arg_70_0.oldTime = var_70_13

		local var_70_14 = arg_70_0.activity

		arg_70_0.curTime = var_1.GetCurTime(var_70_14)

		if not arg_70_0.oldTime then
			Clone = var_1
			arg_70_0.oldTime = var_1(arg_70_0.curTime)
		end

		if arg_70_0.isFinishAll then
			if not arg_70_0.isReallyTime then
				arg_70_0.targetIds = {
					var_0_1.FINISH_TARGET_ROOM_ID
				}
			else
				arg_70_0.targetIds = {}
			end
		else
			local var_70_15 = arg_70_0.curTime
			local var_70_16 = var_1.GetType(var_70_15)

			LinerTime = var_70_15

			if var_70_16 == var_70_15.TYPE.EVENT then
				arg_70_0.targetIds = {
					arg_70_0:_getCurEventRoomId()
				}
			else
				local var_70_17 = arg_70_0.curTime

				arg_70_0.targetIds = var_1.GetTargetRoomIds(var_70_17)
			end
		end

		if arg_70_0.needAutoCheck then
			arg_70_0.needAutoCheck = false

			arg_70_0:CheckTime()
		end

		return
	end
end

function var_0_1._getCurEventRoomId(arg_71_0)
	local var_71_0 = arg_71_0.curTime
	local var_71_1 = var_1.GetParamInfo(var_71_0)
	local var_71_2 = arg_71_0.activity

	return var_71_1[var_2.GetRoomIdx(var_71_2)][1]
end

function var_0_1.UpdateTips(arg_72_0)
	setActive = var_1_10001

	local var_72_0 = arg_72_0.logBtn
	local var_72_1 = var_2.Find(var_72_0, "tip")

	LinerLogBookLayer = var_72_0

	var_1_10001(var_72_1, var_72_0.IsTip())

	return
end

function var_0_1.onDragFunction(arg_73_0)
	local var_73_0

	if not var_0_1.screenPoints then
		var_73_0 = var_0_1

		local var_73_1 = {}

		Vector2 = var_1_10003
		var_73_1[1] = var_1_10003(-arg_73_0.delta.x, arg_73_0.delta.y)
		Vector2 = var_3
		var_73_1[2] = var_3(arg_73_0.delta.x, arg_73_0.delta.y)
		Vector2 = var_3
		var_73_1[3] = var_3(arg_73_0.delta.x, -arg_73_0.delta.y)
		Vector2 = var_3
		var_73_1[4] = var_3(-arg_73_0.delta.x, -arg_73_0.delta.y)
		var_73_0.screenPoints = var_73_1
	end

	ipairs = var_73_0

	for iter_73_0, iter_73_1 in var_73_0(arg_73_0.targetIds) do
		local var_73_2 = arg_73_0.roomsTF
		local var_73_3 = var_6.Find

		tostring = var_1_10008

		if var_73_3(var_73_2, var_1_10008(iter_73_1)) then
			var_1_10008 = arg_73_0._tf

			local var_73_4 = var_7.InverseTransformPoint(var_1_10008, var_6.position)

			var_1_10008 = nil
			ipairs = var_9

			for iter_73_2, iter_73_3 in var_9(var_0_1.screenPoints) do
				local var_73_5 = var_0_1.screenPoints[iter_73_2 % 4 + 1]

				Vector2 = var_15

				local var_73_6 = var_15(var_73_4.x, var_73_4.y)

				LineLine = var_16
				Vector2 = var_17

				local var_73_7, var_73_8, var_73_9 = var_16(var_17.zero, var_73_6, iter_73_3, var_73_5)

				if var_73_7 then
					var_1_10008 = var_73_6 * var_73_8

					break
				end
			end

			local var_73_10 = arg_73_0.floatItemList.container
			local var_73_11 = var_9.Find

			tostring = var_11

			local var_73_12 = var_73_11(var_73_10, var_11(iter_73_1))
			local var_73_13 = var_9.GetComponent

			typeof = var_12
			CanvasGroup = iter_73_3

			local var_73_14 = var_73_13(var_73_12, var_12(iter_73_3))

			tobool = var_73_12
			var_73_14.interactable = var_73_12(var_1_10008)
			var_73_14.blocksRaycasts = var_11
			var_73_14.alpha = var_11 and 1 or 0
			setActive = var_12

			local var_73_15 = arg_73_0.roomsTF

			var_12(var_13.Find(var_73_15, iter_73_1 .. "/tag"), not var_11)

			if var_1_10008 then
				local var_73_16 = var_1_10008
				local var_73_17 = var_1_10008 * (1 - 50 / var_1_10008.Magnitude(var_73_16))

				setAnchoredPosition = var_73_16

				var_73_16(var_9, var_73_17)

				math = var_73_16

				local var_73_18 = var_73_16.rad2Deg

				math = var_14

				local var_73_19 = var_73_18 * var_14.atan2(var_1_10008.y, var_1_10008.x)

				setLocalEulerAngles = var_14

				var_14(var_9:Find("arrow"), {
					z = var_73_19
				})
			end
		end
	end

	return
end

function var_0_1.FocusNode(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_0.roomsTF
	local var_74_1 = var_3.Find

	tostring = var_1_10005

	local var_74_2 = var_74_1(var_74_0, var_1_10005(arg_74_1)).anchoredPosition * -1

	math = var_5
	var_74_2.x = var_5.clamp(var_74_2.x, -arg_74_0.extendLimit.x, arg_74_0.extendLimit.x)
	math = var_5
	var_74_2.y = var_5.clamp(var_74_2.y, -arg_74_0.extendLimit.y, arg_74_0.extendLimit.y)

	if arg_74_0.twFocusId then
		LeanTween = var_5

		var_5.cancel(arg_74_0.twFocusId)

		arg_74_0.twFocusId = nil
	end

	local var_74_3 = {}

	table = var_6

	var_6.insert(var_74_3, function(arg_75_0)
		SetCompomentEnabled = var_2_10001

		local var_75_0 = arg_74_0.mapTF

		typeof = var_2_10003
		ScrollRect = var_2_10004

		var_2_10001(var_75_0, var_2_10003(var_2_10004), false)

		local var_75_1 = (arg_74_0.mapTF.anchoredPosition - var_74_2).magnitude

		if 0 < var_75_1 then
			math = var_2

			local var_75_2

			if not (var_75_1 / (40 * var_2.sqrt(var_75_1))) then
				var_75_2 = 0
			end

			local var_75_3 = arg_74_0

			LeanTween = var_4

			local var_75_4 = var_4.move
			local var_75_5 = arg_74_0.mapTF

			Vector3 = var_2_10006

			local var_75_6 = var_75_4(var_75_5, var_2_10006(var_74_2.x, var_74_2.y, 0), var_75_2)
			local var_75_7 = var_4.setEase

			LeanTweenType = var_6

			local var_75_8 = var_75_7(var_75_6, var_6.easeInOutSine)
			local var_75_9 = var_4.setOnUpdate

			System = var_6

			local var_75_10 = var_75_9(var_75_8, var_6.Action_float(function(arg_76_0)
				local var_76_0 = arg_74_0

				var_1.onDragFunction(var_76_0)

				return
			end))
			local var_75_11 = var_4.setOnComplete

			System = var_6
			var_75_3.twFocusId = var_75_11(var_75_10, var_6.Action(arg_75_0)).uniqueId

			return
		end
	end)

	seriesAsync = var_6

	var_6(var_74_3, function()
		SetCompomentEnabled = var_2_10000

		local var_77_0 = arg_74_0.mapTF

		typeof = var_2_10002
		ScrollRect = var_2_10003

		var_2_10000(var_77_0, var_2_10002(var_2_10003), true)

		if arg_74_2 then
			arg_74_2()
		end

		return
	end)

	return
end

function var_0_1.SwitchMode(arg_78_0, arg_78_1, arg_78_2)
	arg_78_0.mode = arg_78_1

	local var_78_0 = arg_78_0.mode == var_0_1.MODE_NORMAL

	setActive = var_4

	var_4(arg_78_0.focusTF, var_78_0)

	local var_78_1 = arg_78_0.mapTF.localScale.x
	local var_78_2 = var_78_0 and 1 or arg_78_0.fullFactor
	local var_78_3 = arg_78_0
	local var_78_4 = arg_78_0.managedTween

	LeanTween = var_1_10008

	local var_78_5 = var_1_10008.value
	local var_78_6

	go = var_1_10010

	local var_78_7 = var_78_4(var_78_3, var_78_5, var_78_6, var_1_10010(arg_78_0.mapTF), var_78_1, var_78_2, var_0_1.SCALE_ANIM_TIME)
	local var_78_8 = var_6.setEase

	LeanTweenType = var_78_5

	local var_78_9 = var_78_8(var_78_7, var_78_5.easeInOutSine)
	local var_78_10 = var_6.setOnUpdate

	System = var_8

	var_78_10(var_78_9, var_8.Action_float(function(arg_79_0)
		setLocalScale = var_2_10001

		var_2_10001(arg_78_0.mapTF, {
			x = arg_79_0,
			y = arg_79_0,
			z = arg_79_0
		})

		return
	end))

	if not var_78_0 then
		local var_78_11 = arg_78_0
		local var_78_12 = arg_78_0.managedTween

		LeanTween = var_8

		local var_78_13 = var_8.move
		local var_78_14

		go = var_10

		local var_78_15 = var_10(arg_78_0.mapTF)

		Vector3 = var_11

		local var_78_16 = var_78_12(var_78_11, var_78_13, var_78_14, var_78_15, var_11(0, 0, 0), var_0_1.SCALE_ANIM_TIME)
		local var_78_17 = var_6.setEase

		LeanTweenType = var_78_13

		local var_78_18 = var_78_17(var_78_16, var_78_13.easeInOutSine)
		local var_78_19 = var_6.setOnComplete

		System = var_8

		var_78_19(var_78_18, var_8.Action(function()
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

function var_0_1.PlayAnim(arg_81_0, arg_81_1, arg_81_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_82_0)
			if not arg_81_0.swithAnimTF then
				PoolMgr = var_1

				local var_82_0 = var_1.GetInstance()

				var_1.GetUI(var_82_0, "OtherworldCoverUI", true, function(arg_83_0)
					local var_83_0 = arg_81_0

					var_83_0.swithAnimTF = arg_83_0.transform
					setParent = var_83_0

					var_83_0(arg_81_0.swithAnimTF, arg_81_0._tf, false)

					setActive = var_83_0

					var_83_0(arg_81_0.swithAnimTF, false)
					arg_82_0()

					return
				end)
			else
				arg_82_0()
			end

			return
		end,
		function(arg_84_0)
			setActive = var_2_10001

			var_2_10001(arg_81_0.swithAnimTF, true)

			local var_84_0 = arg_81_0.swithAnimTF
			local var_84_1 = var_1.Find(var_84_0, "yuncaizhuanchang")
			local var_84_2 = var_1.GetComponent

			typeof = var_3
			SpineAnimUI = var_2_10004

			local var_84_3 = var_84_2(var_84_1, var_3(var_2_10004))

			var_1.SetActionCallBack(var_84_3, function(arg_85_0)
				if arg_85_0 == "finish" then
					if arg_81_2 then
						arg_81_2()
					end

					setActive = var_1

					var_1(arg_81_0.swithAnimTF, false)
				elseif arg_85_0 == "action" and arg_81_1 then
					arg_81_1()
				end

				return
			end)
			var_1:SetAction("action", 0)

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_1.onBackPressed(arg_87_0)
	if arg_87_0.timePage then
		local var_87_0 = arg_87_0.timePage

		if var_1.GetLoaded(var_87_0) then
			local var_87_1 = arg_87_0.timePage

			if var_1.isShowing(var_87_1) then
				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_87_0)

	return
end

function var_0_1.willExit(arg_88_0)
	local var_88_0 = arg_88_0.timePage

	var_1.Destroy(var_88_0)

	arg_88_0.timePage = nil

	local var_88_1 = arg_88_0.roomPage

	var_1.Destroy(var_88_1)

	arg_88_0.roomPage = nil
	pairs = var_1

	for iter_88_0, iter_88_1 in var_1(arg_88_0.roomChars) do
		if iter_88_1[1] and iter_88_1[2] then
			PoolMgr = var_6

			local var_88_2 = var_6.GetInstance()

			var_6.ReturnSpineChar(var_88_2, iter_88_1[1], iter_88_1[2])
		end
	end

	arg_88_0.roomChars = nil

	if arg_88_0.finishTimer ~= nil then
		local var_88_3 = arg_88_0.finishTimer

		var_1.Stop(var_88_3)

		arg_88_0.finishTimer = nil
	end

	return
end

return var_0_1
