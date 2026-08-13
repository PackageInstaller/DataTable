class = var_0_10000

local var_0_0 = "AirFightActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

function var_0_1.GetMaxProgress(arg_1_0)
	return arg_1_0:getConfig("config_data")[1]
end

function var_0_1.GetPerDayCount(arg_2_0)
	return arg_2_0:getConfig("config_data")[2]
end

function var_0_1.GetPerLevelProgress(arg_3_0)
	return arg_3_0:getConfig("config_data")[3]
end

function var_0_1.GetLevelCount(arg_4_0)
	return arg_4_0:GetMaxProgress() / arg_4_0:GetPerLevelProgress()
end

function var_0_1.readyToAchieve(arg_5_0)
	if arg_5_0:IsTip() then
		return false
	end

	local var_5_0 = arg_5_0:GetMaxProgress()
	local var_5_1 = arg_5_0:GetPerDayCount()
	local var_5_2 = arg_5_0:GetLevelCount()
	local var_5_3 = 0

	for iter_5_0 = 1, var_5_2 do
		local var_5_4

		if not arg_5_0:getKVPList(1, iter_5_0) then
			var_5_4 = 0
		end

		var_5_3 = var_5_3 + var_5_4
	end

	pg = var_5

	local var_5_5 = var_5.TimeMgr.GetInstance()
	local var_5_6 = var_5.DiffDay(var_5_5, arg_5_0.data1, var_5:GetServerTime()) + 1

	math = var_5_5

	return var_5_3 < var_5_5.min(var_5_6 * var_5_1, var_5_0)
end

function var_0_1.IsTip(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.getRawData(var_6_0).id

	PlayerPrefs = var_6_0

	local var_6_2 = var_6_0.GetInt("airfight_tip_" .. arg_6_0.id .. "_" .. var_6_1, 0)

	pg = var_3

	local var_6_3 = var_3.TimeMgr.GetInstance()

	return var_6_2 > var_3.GetServerTime(var_6_3)
end

function var_0_1.RecordTip(arg_7_0)
	local var_7_0 = arg_7_0

	if arg_7_0.IsTip(var_7_0) then
		return
	end

	getProxy = var_1
	PlayerProxy = var_7_0

	local var_7_1 = var_1(var_7_0)
	local var_7_2 = var_1.getRawData(var_7_1).id

	pg = var_7_1

	local var_7_3 = var_7_1.TimeMgr.GetInstance()
	local var_7_4 = var_2.GetTimeToNextTime(var_7_3)

	PlayerPrefs = var_7_3

	var_7_3.SetInt("airfight_tip_" .. arg_7_0.id .. "_" .. var_7_2, var_7_4)

	return
end

return var_0_1
