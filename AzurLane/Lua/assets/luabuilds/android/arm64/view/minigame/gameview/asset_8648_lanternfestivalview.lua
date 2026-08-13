class = var_0_10000

local var_0_0 = "LanternFestivalView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "LanternFestivalUI"
end

function var_0_1.didEnter(arg_2_0)
	LanternRiddlesController = var_1_10001
	arg_2_0.controller = var_1_10001.New()

	local var_2_0 = arg_2_0.controller.view

	var_1.SetUI(var_2_0, arg_2_0._tf)

	local function var_2_1()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_BACK)

		return
	end

	local function var_2_2()
		local var_4_0 = arg_2_0

		var_0.emit(var_4_0, var_0_1.ON_HOME)

		return
	end

	local function var_2_3()
		local var_5_0 = arg_2_0

		if var_0.GetMGHubData(var_5_0).count > 0 then
			local var_5_1 = arg_2_0

			var_1.SendSuccess(var_5_1, 0)
		end

		return
	end

	local function var_2_4()
		local var_6_0 = arg_2_0.controller
		local var_6_1 = var_0.GetSaveData(var_6_0)
		local var_6_2 = arg_2_0

		var_1.StoreDataToServer(var_6_2, var_6_1)

		return
	end

	local var_2_5 = arg_2_0.controller

	var_5.SetCallBack(var_2_5, var_2_1, var_2_2, var_2_3, var_2_4)

	local var_2_6 = arg_2_0:PackData()
	local var_2_7 = arg_2_0.controller

	var_6.SetUp(var_2_7, var_2_6)

	return
end

function var_0_1.PackData(arg_7_0)
	local var_7_0 = 15
	local var_7_1 = arg_7_0:GetMGHubData()
	local var_7_2 = arg_7_0:GetMGData()
	local var_7_3 = var_3.GetRuntimeData(var_7_2, "elements")
	local var_7_4
	local var_7_5

	if var_7_3 and #var_7_3 > 0 then
		_ = var_6
		var_7_4 = var_6.slice(var_7_3, 1, var_7_0)
		_ = var_6
		var_7_5 = var_6.slice(var_7_3, var_7_0 + 1, var_7_1.usedtime)
	else
		var_7_4 = {}

		for iter_7_0 = 1, var_7_0 do
			table = var_1_10010

			var_1_10010.insert(var_7_4, 0)
		end

		var_7_5 = {}
	end

	return {
		finishCount = var_7_1.usedtime,
		unlockCount = var_7_1.count,
		nextTimes = var_7_4,
		finishList = var_7_5
	}
end

function var_0_1.OnGetAwardDone(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.cmd

	MiniGameOPCommand = var_1_10003

	if var_8_0 == var_1_10003.CMD_COMPLETE then
		local var_8_1 = arg_8_0:GetMGHubData().ultimate
		local var_8_2 = var_2.usedtime
		local var_8_3 = var_2:getConfig("reward_need")

		if var_8_1 == 0 and var_8_3 <= var_8_2 then
			pg = var_1_10006

			local var_8_4 = var_1_10006.m02
			local var_8_5 = var_6.sendNotification

			GAME = var_1_10009

			local var_8_6 = var_1_10009.SEND_MINI_GAME_OP
			local var_8_7 = {
				hubid = var_2.id
			}

			MiniGameOPCommand = var_11
			var_8_7.cmd = var_11.CMD_ULTIMATE
			var_8_7.args1 = {}

			var_8_5(var_8_4, var_8_6, var_8_7)
		end
	end

	return
end

function var_0_1.willExit(arg_9_0)
	local var_9_0 = arg_9_0.controller

	var_1.Dispose(var_9_0)

	return
end

return var_0_1
