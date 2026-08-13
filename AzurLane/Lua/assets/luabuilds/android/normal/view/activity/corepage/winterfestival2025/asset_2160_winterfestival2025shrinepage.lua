class = var_0_10000

local var_0_0 = "WinterFestival2025ShrinePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

var_0_1.GO_MINI_GAME_ID = 80

function var_0_1.getUIName(arg_1_0)
	return "WinterFestival2025ShrinePage"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "AD")

	arg_2_0.progressTpl = var_1.Find(var_2_1, "progress_tpl")
	arg_2_0.progressTplContainer = var_1:Find("progress")
	UIItemList = var_2
	arg_2_0.progressUIItemList = var_2.New(arg_2_0.progressTplContainer, arg_2_0.progressTpl)

	local var_2_2 = var_1:Find("Award")

	arg_2_0.lockTF = var_2.Find(var_2_2, "Unlock")
	arg_2_0.getTag = var_2:Find("Achieve")
	arg_2_0.gotTag = var_2:Find("Got")
	arg_2_0.goBtn = var_1:Find("btn_go")

	local var_2_3 = arg_2_0.goBtn

	arg_2_0.goBtnRedDot = var_3.Find(var_2_3, "red")
	arg_2_0.gotBtn = var_1:Find("btn_got")
	arg_2_0.getBtn = var_1:Find("btn_get")
	setActive = var_3

	var_3(arg_2_0.gotBtn, false)

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	arg_3_0.isAchieved = arg_3_0.activity.data1
	arg_3_0.playCount = arg_3_0.activity.data2
	arg_3_0.startTimestamp = arg_3_0.activity.data3

	local var_3_0 = arg_3_0.activity

	arg_3_0.maxDay = var_1.getConfig(var_3_0, "config_id")
	pg = var_1

	local var_3_1 = var_1.TimeMgr.GetInstance()
	local var_3_2 = var_1.DiffDay
	local var_3_3 = arg_3_0.startTimestamp

	pg = var_1_10004

	local var_3_4 = var_1_10004.TimeMgr.GetInstance()

	arg_3_0.dayFromStart = var_3_2(var_3_1, var_3_3, var_4.GetServerTime(var_3_4)) + 1
	math = var_1
	arg_3_0.curDay = var_1.clamp(arg_3_0.dayFromStart, 1, arg_3_0.maxDay)
	arg_3_0.storyIDTable = {}

	local var_3_5 = arg_3_0.activity

	if var_1.getConfig(var_3_5, "config_client") then
		type = var_3_5

		if var_3_5(var_1) == "table" and var_1.story then
			ipairs = var_3

			for iter_3_0, iter_3_1 in var_3(var_3_5) do
				if iter_3_1[1] then
					arg_3_0.storyIDTable[iter_3_0] = var_8
				end
			end
		end
	end

	print = var_3_5
	tostring = var_3

	local var_3_6 = var_3(arg_3_0.isAchieved)

	tostring = var_4

	local var_3_7 = var_4(arg_3_0.playCount)

	tostring = var_5

	var_3_5(var_3_6, var_3_7, var_5(arg_3_0.curDay))

	return
end

function var_0_1.OnFirstFlush(arg_4_0)
	math = var_1_10001

	local var_4_0 = var_1_10001.clamp(arg_4_0.playCount, 0, arg_4_0.maxDay)
	local var_4_1 = arg_4_0.progressUIItemList

	var_2.make(var_4_1, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			if arg_5_1 + 1 <= arg_4_0.curDay then
				setActive = var_3

				var_3(arg_5_2, arg_5_1 <= var_4_0)
			else
				setActive = var_3

				var_3(arg_5_2, false)
			end
		end

		return
	end)

	local var_4_2 = arg_4_0.progressUIItemList

	var_2.align(var_4_2, arg_4_0.maxDay)

	onButton = var_2

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.getBtn

	local function var_4_5()
		if arg_4_0.curDay >= arg_4_0.maxDay and arg_4_0.playCount >= arg_4_0.maxDay and not (arg_4_0.isAchieved > 0) then
			local var_6_0 = arg_4_0
			local var_6_1 = var_0.emit

			ActivityMediator = var_2_10002

			var_6_1(var_6_0, var_2_10002.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_4_0.activity.id
			})
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_2

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.goBtn

	local function var_4_8()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_MINI_GAME, var_0_1.GO_MINI_GAME_ID, {})

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_4_6, var_4_7, var_4_8, var_1_10006)

	local var_4_9 = {}

	pg = var_4_6

	local var_4_10 = var_4_6.NewStoryMgr.GetInstance()

	math = var_4_7

	local var_4_11 = var_4_7.clamp(arg_4_0.playCount, 0, arg_4_0.maxDay)

	for iter_4_0 = 1, arg_4_0.maxDay do
		if arg_4_0.storyIDTable[iter_4_0] and iter_4_0 <= arg_4_0.curDay and iter_4_0 <= var_4_11 then
			table = var_10

			var_10.insert(var_4_9, function(arg_8_0)
				local var_8_0 = var_4_10

				var_1.Play(var_8_0, var_0, arg_8_0)

				return
			end)
		end
	end

	seriesAsync = var_5

	var_5(var_4_9, function()
		print = var_2_10000

		var_2_10000("play story done,count:", #var_4_9)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.gotTag, arg_10_0.isAchieved > 0)

	setActive = var_1_10001

	local var_10_0 = arg_10_0.goBtnRedDot

	Shrine2022View = var_3

	var_1_10001(var_10_0, var_3.IsNeedShowTipForShipCount())

	if arg_10_0.curDay >= arg_10_0.maxDay and arg_10_0.playCount >= arg_10_0.maxDay and not (arg_10_0.isAchieved > 0) then
		setActive = var_1

		var_1(arg_10_0.lockTF, false)

		setActive = var_1

		var_1(arg_10_0.getTag, true)

		setActive = var_1

		var_1(arg_10_0.getBtn, true)

		setActive = var_1

		var_1(arg_10_0.goBtn, false)
	elseif arg_10_0.isAchieved > 0 then
		setActive = var_1

		var_1(arg_10_0.lockTF, false)

		setActive = var_1

		var_1(arg_10_0.getTag, true)

		setActive = var_1

		var_1(arg_10_0.getBtn, false)

		setActive = var_1

		var_1(arg_10_0.goBtn, true)
	else
		setActive = var_1

		var_1(arg_10_0.lockTF, true)

		setActive = var_1

		var_1(arg_10_0.getTag, false)

		setActive = var_1

		var_1(arg_10_0.getBtn, false)

		setActive = var_1

		var_1(arg_10_0.goBtn, true)
	end

	return
end

return var_0_1
