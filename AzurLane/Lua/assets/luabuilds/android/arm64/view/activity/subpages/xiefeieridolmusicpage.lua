class = var_0_10000

local var_0_0 = "XiefeierIdolMusicPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))
local var_0_2 = {
	0.08,
	0.19,
	0.4,
	0.6,
	0.734,
	0.876,
	1,
	1
}

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.masklist = var_1.Find(var_1_1, "maskList")

	local var_1_2 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_2, "slider")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.HubID = var_1.getConfig(var_2_0, "config_id")
	print = var_1

	var_1("self.HubID:" .. arg_2_0.HubID)

	getProxy = var_1
	MiniGameProxy = var_3
	arg_2_0.mgProxy = var_1(var_3)

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bg
	local var_3_2 = var_4.Find(var_3_1, "battle_btn")

	local function var_3_3()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.GO_MINI_GAME, 16)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	local var_5_0 = arg_5_0.mgProxy

	arg_5_0.hubData = var_1.GetHubByHubId(var_5_0, arg_5_0.HubID)
	arg_5_0.finish_times = arg_5_0.hubData.usedtime
	arg_5_0.all_times = arg_5_0.hubData.usedtime + arg_5_0.hubData.count

	for iter_5_0 = 1, 7 do
		setActive = var_1_10005

		local var_5_1 = arg_5_0.masklist

		var_1_10005(var_7.Find(var_5_1, "mask" .. iter_5_0 .. "/dot"), iter_5_0 <= arg_5_0.finish_times)

		setActive = var_1_10005

		local var_5_2 = arg_5_0.masklist
		local var_5_3 = var_7.Find(var_5_2, "mask" .. iter_5_0 .. "/frame")
		local var_5_5

		if iter_5_0 <= arg_5_0.all_times then
			isActive = var_8

			local var_5_4 = arg_5_0.masklist

			var_5_5 = not var_8(var_10.Find(var_5_4, "mask" .. iter_5_0 .. "/dot"))
		else
			var_5_5 = false
		end

		if false then
			var_5_5 = true
		end

		var_1_10005(var_5_3, var_5_5)
	end

	if arg_5_0.finish_times > 0 then
		setSlider = var_1

		var_1(arg_5_0.slider, 0, 1, var_0_2[arg_5_0.finish_times])
	else
		setSlider = var_1

		var_1(arg_5_0.slider, 0, 1, 0)
	end

	local var_5_6 = arg_5_0.finish_times
	local var_5_7 = arg_5_0.hubData

	if var_5_6 >= var_2.getConfig(var_5_7, "reward_need") and arg_5_0.hubData.ultimate == 0 then
		local var_5_8 = arg_5_0

		var_5_6 = arg_5_0.emit
		ActivityMediator = var_5_7

		local var_5_9 = var_5_7.MUSIC_GAME_OPERATOR
		local var_5_10 = {
			hubid = arg_5_0.HubID
		}

		MiniGameOPCommand = var_6
		var_5_10.cmd = var_6.CMD_ULTIMATE
		var_5_10.args1 = {}

		var_5_6(var_5_8, var_5_9, var_5_10)
	end

	setActive = var_5_6

	local var_5_11 = arg_5_0.bg

	var_5_6(var_3.Find(var_5_11, "got_icon"), arg_5_0.hubData.ultimate ~= 0)

	return
end

function var_0_1.OnDestroy(arg_6_0)
	clearImageSprite = var_1_10001

	var_1_10001(arg_6_0.bg)

	return
end

return var_0_1
