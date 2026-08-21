local var_0_0 = class("WinterFestival2025ShrinePage", import("view.activity.CorePage.CoreActivityPage"))

var_0_0.GO_MINI_GAME_ID = 80

function var_0_0.getUIName(arg_1_0)
	return "WinterFestival2025ShrinePage"
end

function var_0_0.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf:Find("AD")

	arg_2_0.progressTpl = var_2_0:Find("progress_tpl")
	arg_2_0.progressTplContainer = var_2_0:Find("progress")
	arg_2_0.progressUIItemList = UIItemList.New(arg_2_0.progressTplContainer, arg_2_0.progressTpl)

	local var_2_1 = var_2_0:Find("Award")

	arg_2_0.lockTF = var_2_1:Find("Unlock")
	arg_2_0.getTag = var_2_1:Find("Achieve")
	arg_2_0.gotTag = var_2_1:Find("Got")
	arg_2_0.goBtn = var_2_0:Find("btn_go")
	arg_2_0.goBtnRedDot = arg_2_0.goBtn:Find("red")
	arg_2_0.gotBtn = var_2_0:Find("btn_got")
	arg_2_0.getBtn = var_2_0:Find("btn_get")

	setActive(arg_2_0.gotBtn, false)

	return
end

function var_0_0.OnDataSetting(arg_3_0)
	arg_3_0.isAchieved = arg_3_0.activity.data1
	arg_3_0.playCount = arg_3_0.activity.data2
	arg_3_0.startTimestamp = arg_3_0.activity.data3
	arg_3_0.maxDay = arg_3_0.activity:getConfig("config_id")
	arg_3_0.dayFromStart = pg.TimeMgr.GetInstance():DiffDay(arg_3_0.startTimestamp, pg.TimeMgr.GetInstance():GetServerTime()) + 1
	arg_3_0.curDay = math.clamp(arg_3_0.dayFromStart, 1, arg_3_0.maxDay)
	arg_3_0.storyIDTable = {}

	local var_3_0 = arg_3_0.activity:getConfig("config_client")

	if var_3_0 and type(var_3_0) == "table" then
		if var_3_0.story then
			for iter_3_0, iter_3_1 in ipairs(var_3_0.story) do
				if iter_3_1[1] then
					arg_3_0.storyIDTable[iter_3_0] = iter_3_1[1]
				end
			end
		end
	end

	print(tostring(arg_3_0.isAchieved), tostring(arg_3_0.playCount), tostring(arg_3_0.curDay))

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	local var_4_0 = math.clamp(arg_4_0.playCount, 0, arg_4_0.maxDay)

	arg_4_0.progressUIItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_5_1 = arg_5_1 + 1

			if arg_5_1 <= arg_4_0.curDay then
				setActive(arg_5_2, arg_5_1 <= var_4_0)
			else
				setActive(arg_5_2, false)
			end
		end

		return
	end)
	arg_4_0.progressUIItemList:align(arg_4_0.maxDay)
	onButton(arg_4_0, arg_4_0.getBtn, function()
		if arg_4_0.curDay >= arg_4_0.maxDay and arg_4_0.playCount >= arg_4_0.maxDay and arg_4_0.isAchieved <= 0 then
			arg_4_0:emit(ActivityMediator.EVENT_OPERATION, {
				cmd = 1,
				activity_id = arg_4_0.activity.id
			})
		end

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.goBtn, function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, var_0_0.GO_MINI_GAME_ID, {})

		return
	end, SFX_PANEL)

	local var_4_1 = {}
	local var_4_2 = pg.NewStoryMgr.GetInstance()
	local var_4_3 = math.clamp(arg_4_0.playCount, 0, arg_4_0.maxDay)

	for iter_4_0 = 1, arg_4_0.maxDay do
		if arg_4_0.storyIDTable[iter_4_0] and iter_4_0 <= arg_4_0.curDay and iter_4_0 <= var_4_3 then
			table.insert({}, function(arg_8_0)
				var_4_2:Play(var_0, arg_8_0)

				return
			end)
		end
	end

	seriesAsync({}, function()
		print("play story done,count:", #var_4_1)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_10_0)
	setActive(arg_10_0.gotTag, arg_10_0.isAchieved > 0)
	setActive(arg_10_0.goBtnRedDot, Shrine2022View.IsNeedShowTipForShipCount())

	if arg_10_0.curDay >= arg_10_0.maxDay and arg_10_0.playCount >= arg_10_0.maxDay and arg_10_0.isAchieved <= 0 then
		setActive(arg_10_0.lockTF, false)
		setActive(arg_10_0.getTag, true)
		setActive(arg_10_0.getBtn, true)
		setActive(arg_10_0.goBtn, false)
	elseif arg_10_0.isAchieved > 0 then
		setActive(arg_10_0.lockTF, false)
		setActive(arg_10_0.getTag, true)
		setActive(arg_10_0.getBtn, false)
		setActive(arg_10_0.goBtn, true)
	else
		setActive(arg_10_0.lockTF, true)
		setActive(arg_10_0.getTag, false)
		setActive(arg_10_0.getBtn, false)
		setActive(arg_10_0.goBtn, true)
	end

	return
end

return var_0_0
