class = var_0_10000

local var_0_0 = "AprilFool2022Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

var_0_1.Order = {
	1,
	3,
	2
}

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")
	arg_1_0.selectIndex = 0
	arg_1_0.stars = {}

	for iter_1_0 = 1, 3 do
		local var_1_1 = arg_1_0.stars
		local var_1_2 = arg_1_0.bg

		var_1_1[iter_1_0] = var_6.Find(var_1_2, "Star" .. iter_1_0)
	end

	arg_1_0.clickIndex = 0

	local var_1_3 = arg_1_0.bg

	arg_1_0.btnBattle = var_1.Find(var_1_3, "Battle_btn")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client")

	type = var_1_10002

	if var_1_10002(var_2_1) == "table" and var_2_1[2] then
		type = var_2

		if var_2(var_2_1[2]) == "string" then
			pg = var_2

			local var_2_2 = var_2.NewStoryMgr.GetInstance()

			if not var_2.IsPlayed(var_2_2, var_2_1[2]) then
				pg = var_2

				local var_2_3 = var_2.NewStoryMgr.GetInstance()

				var_2.Play(var_2_3, var_2_1[2], nil, true, true)
			end
		end
	end

	if arg_2_0.activity.data2 == 0 and arg_2_0.activity.data3 == 1 then
		arg_2_0.activity.data3 = 0

		local var_2_4 = arg_2_0
		local var_2_5 = arg_2_0.emit

		ActivityMediator = var_1_10005

		var_2_5(var_2_4, var_1_10005.EVENT_OPERATION, {
			cmd = 2,
			activity_id = arg_2_0.activity.id
		})

		return true
	end

	if arg_2_0.activity.data1 == 0 then
		local var_2_6 = arg_2_0.activity
		local var_2_7 = var_2.getStartTime(var_2_6)

		pg = var_2_0

		local var_2_8 = var_2_0.TimeMgr.GetInstance()
		local var_2_9 = var_3.GetServerTime(var_2_8)
		local var_2_10 = arg_2_0.activity

		if var_4.getConfig(var_2_10, "config_client").autounlock <= var_2_9 - var_2_7 then
			local var_2_11 = arg_2_0
			local var_2_12 = arg_2_0.emit

			ActivityMediator = var_1_10008

			var_2_12(var_2_11, var_1_10008.EVENT_OPERATION, {
				arg1 = 1,
				cmd = 1,
				activity_id = arg_2_0.activity.id
			})

			return true
		end
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	var_0_1.super.OnFirstFlush(arg_3_0)

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.btnBattle

	local function var_3_2()
		local var_4_0 = arg_3_0.activity
		local var_4_1 = var_0.getConfig(var_4_0, "config_client").stageid
		local var_4_2 = arg_3_0
		local var_4_3 = var_1.emit

		ActivityMediator = var_2_10004

		var_4_3(var_4_2, var_2_10004.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = var_4_1
		}, function()
			pg = var_3_10000

			local var_5_0 = var_3_10000.NewStoryMgr.GetInstance()
			local var_5_1 = var_0.IsPlayed

			tostring = var_3_10003

			local var_5_2

			if not var_5_1(var_5_0, var_3_10003(var_4_1), true) then
				pg = var_5_2
				var_5_0 = var_5_2.m02
				var_5_2 = var_5_2.sendNotification
				GAME = var_3

				local var_5_3 = var_3.STORY_UPDATE
				local var_5_4 = {}

				tostring = var_5
				var_5_4.storyId = var_5(var_4_1)

				var_5_2(var_5_0, var_5_3, var_5_4)
			end

			getProxy = var_5_2
			ActivityProxy = var_5_0

			local var_5_5 = var_5_2(var_5_0)

			if var_0.getActivityById(var_5_5, arg_3_0.activity.id).data2 > 0 then
				return
			end

			var_1.data3 = 1

			var_0:updateActivity(var_1)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	local function var_3_3(arg_6_0, arg_6_1, arg_6_2)
		GetOrAddComponent = var_2_10003

		local var_6_0 = var_2_10003(arg_6_1, "ButtonEventExtend").onPointerDown

		pg = var_5

		var_5.DelegateInfo.Add(arg_6_0, var_6_0)
		var_6_0:RemoveAllListeners()
		var_6_0:AddListener(function()
			if arg_3_0.activity.data1 ~= 0 then
				return
			end

			local var_7_0
			local var_7_1 = arg_6_2 ~= arg_3_0.Order[arg_3_0.clickIndex + 1] and "event:/ui/shibai" or "event:/ui/deng" .. arg_3_0.clickIndex + 1

			pg = var_1

			local var_7_2 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_7_2, var_7_1)

			return
		end)

		return
	end

	table = var_1_10002

	var_1_10002.Foreach(arg_3_0.stars, function(arg_8_0, arg_8_1)
		onButton = var_2_10002

		var_2_10002(arg_3_0, arg_8_1, function()
			if arg_3_0.activity.data1 ~= 0 then
				return
			end

			if arg_8_0 ~= arg_3_0.Order[arg_3_0.clickIndex + 1] then
				arg_3_0.clickIndex = 0

				local var_9_0 = arg_3_0

				var_0.OnUpdateFlush(var_9_0)

				return
			end

			arg_3_0.clickIndex = arg_3_0.clickIndex + 1

			local var_9_1 = arg_3_0

			var_0.OnUpdateFlush(var_9_1)

			if arg_3_0.clickIndex < #arg_3_0.Order then
				return
			end

			local var_9_2 = arg_3_0
			local var_9_3 = var_0.emit

			ActivityMediator = var_3_10003

			var_9_3(var_9_2, var_3_10003.EVENT_OPERATION, {
				arg1 = 1,
				cmd = 1,
				activity_id = arg_3_0.activity.id
			})

			return
		end)
		var_3_3(arg_3_0, arg_8_1, arg_8_0)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	var_0_1.super.OnUpdateFlush(arg_10_0)

	setActive = var_1

	var_1(arg_10_0.btnBattle, arg_10_0.activity.data1 ~= 0)

	SetCompomentEnabled = var_1

	var_1(arg_10_0.btnBattle, "Animator", arg_10_0.activity.data2 == 0)

	table = var_1

	var_1.Foreach(arg_10_0.Order, function(arg_11_0, arg_11_1)
		setActive = var_2_10002

		local var_11_0 = arg_10_0.stars[arg_11_1]

		var_2_10002(var_4.Find(var_11_0, "Effect"), arg_11_0 <= arg_10_0.clickIndex or arg_10_0.activity.data1 ~= 0)

		return
	end)

	return
end

return var_0_1
