local var_0_0 = class("IslandFollowerAgency", import(".IslandBaseAgency"))

var_0_0.ADD_FOLLOWER = "IslandFollowerAgency:ADD_FOLLOWER"
var_0_0.DEL_FOLLOWER = "IslandFollowerAgency:DEL_FOLLOWER"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.followers = {}

	return
end

function var_0_0.InitPrivateData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.follow_ships) do
		table.insert(arg_2_0.followers, iter_2_1)
	end

	arg_2_0.maxCnt = pg.island_set.max_follower_cnt.key_value_int

	return
end

function var_0_0.GetFollowers(arg_3_0)
	return arg_3_0.followers
end

function var_0_0.AddFollower(arg_4_0, arg_4_1)
	if not arg_4_0:Following(arg_4_1) then
		table.insert(arg_4_0.followers, arg_4_1)
		arg_4_0:DispatchEvent(IslandFollowerAgency.ADD_FOLLOWER, arg_4_1)
	end

	return
end

function var_0_0.DelFollower(arg_5_0, arg_5_1)
	if arg_5_0:Following(arg_5_1) then
		table.removebyvalue(arg_5_0.followers, arg_5_1)
		arg_5_0:DispatchEvent(IslandFollowerAgency.DEL_FOLLOWER, arg_5_1)
	end

	return
end

function var_0_0.Following(arg_6_0, arg_6_1)
	return table.contains(arg_6_0.followers, arg_6_1)
end

function var_0_0.ReachMaxCnt(arg_7_0)
	return #arg_7_0.followers >= arg_7_0.maxCnt
end

return var_0_0
