class = var_0_10000

local var_0_0 = "DecodeMiniGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "DecodeGameUI"
end

function var_0_1.didEnter(arg_2_0)
	DecodeGameController = var_1_10001
	arg_2_0.controller = var_1_10001.New()

	local var_2_0 = arg_2_0.controller.view

	var_1.SetUI(var_2_0, arg_2_0._tf)

	local function var_2_1()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_BACK)

		return
	end

	local function var_2_2(arg_4_0)
		local var_4_0 = arg_2_0

		if var_1.GetMGHubData(var_4_0).count > 0 then
			local var_4_1 = arg_2_0.controller
			local var_4_2 = var_2.GetSaveData(var_4_1)
			local var_4_3 = arg_2_0

			var_3.StoreDataToServer(var_4_3, var_4_2)

			arg_2_0.onGetAward = arg_4_0

			local var_4_4 = arg_2_0

			var_3.SendSuccess(var_4_4, 0)
		end

		return
	end

	local function var_2_3()
		local var_5_0 = arg_2_0

		if var_0.GetMGHubData(var_5_0).ultimate == 0 then
			pg = var_1

			local var_5_1 = var_1.m02
			local var_5_2 = var_1.sendNotification

			GAME = var_2_10003

			local var_5_3 = var_2_10003.SEND_MINI_GAME_OP
			local var_5_4 = {
				hubid = var_0.id
			}

			MiniGameOPCommand = var_5
			var_5_4.cmd = var_5.CMD_ULTIMATE
			var_5_4.args1 = {}

			var_5_2(var_5_1, var_5_3, var_5_4)
		end

		return
	end

	local var_2_4 = arg_2_0.controller

	var_4.SetCallback(var_2_4, var_2_1, var_2_2, var_2_3)

	local var_2_5 = arg_2_0:PackData()
	local var_2_6 = arg_2_0.controller

	var_5.SetUp(var_2_6, var_2_5)

	return
end

function var_0_1.GetData(arg_6_0, arg_6_1)
	PlayerPrefs = var_1_10002

	local var_6_0 = var_1_10002.GetInt("DecodeGameMapId", 1)
	local var_6_1 = arg_6_1:GetRuntimeData("elements")

	local function var_6_2()
		for iter_7_0 = 1, 60 do
			table = var_2_10004

			if not var_2_10004.contains(var_6_1, iter_7_0) then
				table = var_2_10004

				var_2_10004.insert(var_6_1, iter_7_0)

				break
			end
		end

		return
	end

	local function var_6_3()
		table = var_2_10000

		var_2_10000.remove(var_6_1, 1)

		return
	end

	if #var_6_1 ~= arg_6_0.usedtime then
		local var_6_4 = arg_6_0.usedtime - #var_6_1

		for iter_6_0 = 1, var_6_4 do
			var_6_2()
		end

		local var_6_5 = #var_6_1 - arg_6_0.usedtime

		for iter_6_1 = 1, var_6_5 do
			var_6_3()
		end
	end

	local var_6_6 = {
		mapId = var_6_0,
		unlocks = var_6_1,
		canUseCnt = arg_6_0.count
	}

	DecodeGameConst = var_7
	var_6_6.passwords = var_7.MAPS_PASSWORD
	var_6_6.isFinished = arg_6_0.ultimate > 0

	return var_6_6
end

function var_0_1.PackData(arg_9_0)
	local var_9_0 = arg_9_0:GetMGHubData()
	local var_9_1 = arg_9_0:GetMGData()

	return var_0_1.GetData(var_9_0, var_9_1)
end

function var_0_1.OnGetAwardDone(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.cmd

	MiniGameOPCommand = var_1_10003

	if var_10_0 == var_1_10003.CMD_COMPLETE and arg_10_0.onGetAward then
		arg_10_0.onGetAward()

		arg_10_0.onGetAward = nil
	end

	return
end

function var_0_1.willExit(arg_11_0)
	local var_11_0

	if not arg_11_0.controller.mapId then
		var_11_0 = 1
	end

	PlayerPrefs = var_1_10002

	var_1_10002.SetInt("DecodeGameMapId", var_11_0)

	PlayerPrefs = var_2

	var_2.Save()

	local var_11_1 = arg_11_0.controller

	var_2.Dispose(var_11_1)

	return
end

return var_0_1
