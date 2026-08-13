class = var_0_10000

local var_0_0 = "IslandFollowerAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

var_0_1.ADD_FOLLOWER = "IslandFollowerAgency:ADD_FOLLOWER"
var_0_1.DEL_FOLLOWER = "IslandFollowerAgency:DEL_FOLLOWER"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.followers = {}

	return
end

function var_0_1.InitPrivateData(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_1.follow_ships) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.followers, iter_2_1)
	end

	pg = var_2
	arg_2_0.maxCnt = var_2.island_set.max_follower_cnt.key_value_int

	return
end

function var_0_1.GetFollowers(arg_3_0)
	return arg_3_0.followers
end

function var_0_1.AddFollower(arg_4_0, arg_4_1)
	if not arg_4_0:Following(arg_4_1) then
		table = var_2

		var_2.insert(arg_4_0.followers, arg_4_1)

		local var_4_0 = arg_4_0
		local var_4_1 = arg_4_0.DispatchEvent

		IslandFollowerAgency = var_5

		var_4_1(var_4_0, var_5.ADD_FOLLOWER, arg_4_1)
	end

	return
end

function var_0_1.DelFollower(arg_5_0, arg_5_1)
	if arg_5_0:Following(arg_5_1) then
		table = var_2

		var_2.removebyvalue(arg_5_0.followers, arg_5_1)

		local var_5_0 = arg_5_0
		local var_5_1 = arg_5_0.DispatchEvent

		IslandFollowerAgency = var_5

		var_5_1(var_5_0, var_5.DEL_FOLLOWER, arg_5_1)
	end

	return
end

function var_0_1.Following(arg_6_0, arg_6_1)
	table = var_1_10002

	return var_1_10002.contains(arg_6_0.followers, arg_6_1)
end

function var_0_1.ReachMaxCnt(arg_7_0)
	return #arg_7_0.followers >= arg_7_0.maxCnt
end

return var_0_1
