class = var_0_10000

local var_0_0 = "BillboardProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.FETCH_LIST_DONE = "BillboardProxy:FETCH_LIST_DONE"
var_0_1.NONTIMER = {}

function var_0_1.register(arg_1_0)
	local var_1_0 = var_0_1
	local var_1_1 = {}

	PowerRank = var_1_10003
	var_1_1[1] = var_1_10003.TYPE_MILITARY_RANK
	PowerRank = var_3
	var_1_1[2] = var_3.TYPE_BOSSRUSH
	var_1_0.NONTIMER = var_1_1
	arg_1_0.data = {}
	arg_1_0.playerData = {}
	arg_1_0.timeStamps = {}
	arg_1_0.hashList = {}
	arg_1_0.hashCount = 0

	return
end

function var_0_1.setPlayerRankData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_0:getHashId(arg_2_1, arg_2_2)

	table = var_1_10005

	if var_1_10005.contains(var_0_1.NONTIMER, arg_2_1) then
		return
	end

	arg_2_0.playerData[var_2_0] = arg_2_3

	return
end

function var_0_1.getPlayerRankData(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.playerData[arg_3_0:getHashId(arg_3_1, arg_3_2)]
end

function var_0_1.setRankList(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.getHashId(var_4_0, arg_4_1, arg_4_2)

	table = var_1_10005

	if var_1_10005.contains(var_0_1.NONTIMER, arg_4_1) then
		return
	end

	arg_4_0.data[var_4_1] = arg_4_3

	local var_4_2 = arg_4_0.timeStamps

	GetHalfHour = var_4_0
	var_4_2[var_4_1] = var_4_0()

	return
end

function var_0_1.getRankList(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0.data[arg_5_0:getHashId(arg_5_1, arg_5_2)]
end

function var_0_1.canFetch(arg_6_0, arg_6_1, arg_6_2)
	table = var_1_10003

	if var_1_10003.contains(var_0_1.NONTIMER, arg_6_1) then
		return true
	end

	local var_6_0 = arg_6_0:getHashId(arg_6_1, arg_6_2)

	if arg_6_0.timeStamps[var_6_0] then
		pg = var_4

		local var_6_1 = var_4.TimeMgr.GetInstance()

		if var_4.GetServerTime(var_6_1) > arg_6_0.timeStamps[var_6_0] then
			return true
		end

		return false
	end
end

function var_0_1.getHashId(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_2 then
		local var_7_1 = arg_7_0.hashList
		local var_7_2

		if not arg_7_0.hashList[arg_7_1] then
			var_7_2 = {}
		end

		var_7_1[arg_7_1] = var_7_2
		var_7_0 = arg_7_0.hashList[arg_7_1][arg_7_2]
	else
		var_7_0 = arg_7_0.hashList[arg_7_1]
	end

	if var_7_0 then
		return var_7_0
	else
		arg_7_0.hashCount = arg_7_0.hashCount + 1

		if arg_7_2 then
			arg_7_0.hashList[arg_7_1][arg_7_2] = arg_7_0.hashCount
		else
			arg_7_0.hashList[arg_7_1] = arg_7_0.hashCount
		end

		return arg_7_0.hashCount
	end

	return
end

return var_0_1
