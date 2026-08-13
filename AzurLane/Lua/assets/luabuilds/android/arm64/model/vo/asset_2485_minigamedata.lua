class = var_0_10000

local var_0_0 = "MiniGameData"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.configCsv = arg_1_0:getConfig("config_csv")
	arg_1_0.configCsvKey = arg_1_0:getConfig("config_csv_key")
	arg_1_0.runtimeData = {}
	arg_1_0.exData = nil
	arg_1_0.rank = {}
	arg_1_0._rankCd = 0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.mini_game
end

function var_0_1.GetSimpleValue(arg_3_0, arg_3_1)
	return arg_3_0:getConfig("simple_config_data")[arg_3_1]
end

function var_0_1.GetConfigCsvValue(arg_4_0, arg_4_1)
	pg = var_1_10002

	return var_1_10002[arg_4_0.configCsv][arg_4_0.configCsvKey][arg_4_1]
end

function var_0_1.GetConfigCsvLine(arg_5_0, arg_5_1)
	pg = var_1_10002

	return var_1_10002[arg_5_0.configCsv][arg_5_1]
end

function var_0_1.SetRuntimeData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.runtimeData[arg_6_1] = arg_6_2

	return
end

function var_0_1.GetRuntimeData(arg_7_0, arg_7_1)
	return arg_7_0.runtimeData[arg_7_1]
end

function var_0_1.CheckInTime(arg_8_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = arg_8_0:getConfig("hub_id")

	if var_8_0:CheckHasHub(var_8_1) then
		local var_8_2 = var_8_0:GetHubByHubId(var_8_1)

		return var_3.CheckInTime(var_8_2)
	else
		return false
	end

	return
end

function var_0_1.GetRank(arg_9_0)
	return arg_9_0.rank
end

function var_0_1.SetRank(arg_10_0, arg_10_1)
	GetHalfHour = var_1_10002
	arg_10_0._rankCd = var_1_10002()
	arg_10_0.rank = arg_10_1

	return
end

function var_0_1.CanFetchRank(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_11_0) > arg_11_0._rankCd
end

return var_0_1
