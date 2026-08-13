class = var_0_10000

local var_0_0 = "MiniGameHubData"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id

	local var_1_0

	if not arg_1_1.available_cnt then
		var_1_0 = arg_1_0:getConfig("reborn_times")
	end

	arg_1_0.count = var_1_0

	local var_1_1

	if not arg_1_1.used_cnt then
		var_1_1 = 0
	end

	arg_1_0.usedtime = var_1_1

	local var_1_2

	if not arg_1_1.ultimate then
		var_1_2 = 0
	end

	arg_1_0.ultimate = var_1_2
	arg_1_0.highScores = {}
	underscore = var_2

	local var_1_3 = var_2.each
	local var_1_4

	if not arg_1_1.maxscores then
		var_1_4 = {}
	end

	var_1_3(var_1_4, function(arg_2_0)
		arg_1_0.highScores[arg_2_0.key] = {
			arg_2_0.value1,
			arg_2_0.value2
		}

		return
	end)

	return
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.mini_game_hub
end

function var_0_1.UpdateData(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_1.available_cnt then
		var_4_0 = arg_4_0.count
	end

	arg_4_0.count = var_4_0

	local var_4_1

	if not arg_4_1.used_cnt then
		var_4_1 = arg_4_0.usedtime
	end

	arg_4_0.usedtime = var_4_1

	local var_4_2

	if not arg_4_1.ultimate then
		var_4_2 = arg_4_0.ultimate
	end

	arg_4_0.ultimate = var_4_2

	local var_4_3 = arg_4_1.maxscores

	underscore = var_1_10003

	local var_4_4 = var_1_10003.each
	local var_4_5

	if not arg_4_1.maxscores then
		var_4_5 = {}
	end

	var_4_4(var_4_5, function(arg_5_0)
		arg_4_0.highScores[arg_5_0.key] = {
			arg_5_0.value1,
			arg_5_0.value2
		}

		return
	end)

	print = var_4_4

	local var_4_6 = "Hub 更新"
	local var_4_7 = "ID:"

	tostring = var_1_10006

	local var_4_8 = var_1_10006(arg_4_0.id)
	local var_4_9 = "Count:"

	tostring = var_1_10008

	local var_4_10 = var_1_10008(arg_4_0.count)
	local var_4_11 = "UsedTime:"

	tostring = var_1_10010

	local var_4_12 = var_1_10010(arg_4_0.usedtime)
	local var_4_13 = "Ultimate:"

	tostring = var_1_10012

	var_4_4(var_4_6, var_4_7, var_4_8, var_4_9, var_4_10, var_4_11, var_4_12, var_4_13, var_1_10012(arg_4_0.ultimate))

	return
end

function var_0_1.CheckInTime(arg_6_0)
	local var_6_0 = arg_6_0

	if arg_6_0.getConfig(var_6_0, "act_id") ~= nil then
		pg = var_6_0

		if var_6_0.activity_template[var_1] then
			local var_6_1 = var_2.time

			pg = var_1_10004

			local var_6_2 = var_1_10004.TimeMgr.GetInstance()

			return (var_4.inTime(var_6_2, var_6_1))
		end
	else
		return true
	end

	return
end

return var_0_1
