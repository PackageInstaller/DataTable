class = var_0_10000

local var_0_0 = "NewYearShrinePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

var_0_1.MAX_COUNT = 7
var_0_1.GO_MINI_GAME_ID = 34
SCENE = var_1
var_0_1.GO_BACKHILL_SCENE = var_1.NEWYEAR_BACKHILL_2022

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.progressTpl = var_1.Find(var_1_0, "ProgressTpl")

	local var_1_1 = arg_1_0._tf

	arg_1_0.progressTplContainer = var_1.Find(var_1_1, "ProgressList")
	UIItemList = var_1
	arg_1_0.progressUIItemList = var_1.New(arg_1_0.progressTplContainer, arg_1_0.progressTpl)

	local var_1_2 = arg_1_0._tf

	arg_1_0.countText = var_1.Find(var_1_2, "CountText")

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_1.Find(var_1_3, "Award")

	arg_1_0.lockTF = var_1.Find(var_1_4, "Unlock")
	arg_1_0.getBtn = var_1:Find("Achieve")
	arg_1_0.gotTag = var_1:Find("Got")

	local var_1_5 = arg_1_0._tf

	arg_1_0.goBtn = var_2.Find(var_1_5, "GoBtn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.isAchieved = arg_2_0.activity.data1
	arg_2_0.playCount = arg_2_0.activity.data2
	arg_2_0.startTimestamp = arg_2_0.activity.data3
	pg = var_1

	local var_2_0 = var_1.TimeMgr.GetInstance()
	local var_2_1 = var_1.DiffDay
	local var_2_2 = arg_2_0.startTimestamp

	pg = var_1_10004

	local var_2_3 = var_1_10004.TimeMgr.GetInstance()

	arg_2_0.dayFromStart = var_2_1(var_2_0, var_2_2, var_4.GetServerTime(var_2_3)) + 1
	math = var_1
	arg_2_0.curDay = var_1.clamp(arg_2_0.dayFromStart, 1, var_0_1.MAX_COUNT)
	arg_2_0.storyIDTable = {}

	local var_2_4 = arg_2_0.activity

	if var_1.getConfig(var_2_4, "config_client").story then
		ipairs = var_2_4

		for iter_2_0, iter_2_1 in var_2_4(var_1) do
			if iter_2_1[1] then
				arg_2_0.storyIDTable[iter_2_0] = var_7
			end
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	math = var_1_10001

	local var_3_0 = var_1_10001.clamp(arg_3_0.playCount, 0, var_0_1.MAX_COUNT)

	setText = var_2

	var_2(arg_3_0.countText, var_3_0)

	local var_3_1 = arg_3_0.progressUIItemList

	var_2.make(var_3_1, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			arg_4_1 = arg_4_1 + 1

			local var_4_0 = arg_4_2:Find("Achieve")
			local var_4_1 = arg_4_2:Find("Unlock")
			local var_4_2 = arg_4_2
			local var_4_3 = arg_4_2.Find(var_4_2, "Lock")

			setActive = var_4_2

			var_4_2(var_4_3, not (arg_4_1 <= arg_3_0.curDay))

			if arg_4_1 <= arg_3_0.curDay then
				setActive = var_6

				var_6(var_4_0, arg_4_1 <= var_3_0)

				setActive = var_6

				var_6(var_4_1, arg_4_1 > var_3_0)
			else
				setActive = var_6

				var_6(var_4_0, false)

				setActive = var_6

				var_6(var_4_1, true)
			end
		end

		return
	end)

	local var_3_2 = arg_3_0.progressUIItemList

	var_2.align(var_3_2, var_0_1.MAX_COUNT)

	onButton = var_2

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		if arg_3_0.curDay >= var_0_1.MAX_COUNT and arg_3_0.playCount >= var_0_1.MAX_COUNT and not (arg_3_0.isAchieved > 0) then
			local var_5_0 = arg_3_0
			local var_5_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_5_1(var_5_0, var_2_10002.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_3_0.activity.id
			})
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_2

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.goBtn

	local function var_3_8()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10002

		var_6_1(var_6_0, var_2_10002.GO_MINI_GAME, var_0_1.GO_MINI_GAME_ID, {
			callback = function()
				Context = var_3_10000

				local var_7_0 = var_3_10000.New()

				SCENE = var_3_10001

				var_3_10001.SetSceneInfo(var_7_0, var_0_1.GO_BACKHILL_SCENE)

				getProxy = var_1
				ContextProxy = var_2

				local var_7_1 = var_1(var_2)

				var_1.PushContext2Prev(var_7_1, var_7_0)

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_6, var_3_7, var_3_8, var_1_10006)

	local var_3_9 = {}

	pg = var_3_6

	local var_3_10 = var_3_6.NewStoryMgr.GetInstance()

	math = var_3_7

	local var_3_11 = var_3_7.clamp(arg_3_0.playCount, 0, var_0_1.MAX_COUNT)

	for iter_3_0 = 1, var_0_1.MAX_COUNT do
		if arg_3_0.storyIDTable[iter_3_0] and iter_3_0 <= arg_3_0.curDay and iter_3_0 <= var_3_11 then
			table = var_10

			var_10.insert(var_3_9, function(arg_8_0)
				local var_8_0 = var_3_10

				var_1.Play(var_8_0, var_0, arg_8_0)

				return
			end)
		end
	end

	seriesAsync = var_5

	var_5(var_3_9, function()
		print = var_2_10000

		var_2_10000("play story done,count:", #var_3_9)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.gotTag, arg_10_0.isAchieved > 0)

	if arg_10_0.curDay >= var_0_1.MAX_COUNT and arg_10_0.playCount >= var_0_1.MAX_COUNT and not (arg_10_0.isAchieved > 0) then
		setActive = var_1

		var_1(arg_10_0.lockTF, false)

		setActive = var_1

		var_1(arg_10_0.getBtn, true)

		triggerButton = var_1

		var_1(arg_10_0.getBtn)
	elseif arg_10_0.isAchieved > 0 then
		setActive = var_1

		var_1(arg_10_0.lockTF, false)

		setActive = var_1

		var_1(arg_10_0.getBtn, true)
	else
		setActive = var_1

		var_1(arg_10_0.lockTF, true)

		setActive = var_1

		var_1(arg_10_0.getBtn, false)
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

function var_0_1.IsTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_12_0 = var_1_10000(var_1_10001)
	local var_12_1 = var_0.getActivityById

	pg = var_1_10002

	if var_12_1(var_12_0, var_1_10002.activity_const.NEWYEAR_SHRINE_PAGE_ID.act_id) and not var_0:isEnd() then
		pg = var_1

		local var_12_2 = var_1.TimeMgr.GetInstance()
		local var_12_3 = var_1.DiffDay
		local var_12_4 = var_0.data3

		pg = var_1_10004

		local var_12_5 = var_1_10004.TimeMgr.GetInstance()
		local var_12_6 = var_12_3(var_12_2, var_12_4, var_4.GetServerTime(var_12_5)) + 1

		math = var_12_2

		local var_12_7 = var_12_2.clamp(var_12_6, 1, var_0_1.MAX_COUNT)

		math = var_3

		return var_12_7 > var_3.clamp(var_0.data2, 0, var_0_1.MAX_COUNT)
	end

	return
end

return var_0_1
