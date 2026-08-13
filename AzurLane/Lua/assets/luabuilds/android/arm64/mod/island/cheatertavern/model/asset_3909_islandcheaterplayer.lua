class = var_0_10000

local var_0_0 = var_0_10000("IslandCheaterPlayer")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.user_id = arg_1_1.user_id
	arg_1_0.seat = arg_1_1.seat
	arg_1_0.card_num = arg_1_1.card_num
	arg_1_0.bomb_dic = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.bomb_list) do
		arg_1_0.bomb_dic[iter_1_1.bomb_id] = iter_1_1.state == 1
	end

	arg_1_0.state = 0
	arg_1_0.player_info = arg_1_1.player_info
	arg_1_0.rank = 0
	arg_1_0.addScore = 0

	return
end

function var_0_0.SetGameData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.rank = arg_2_1
	arg_2_0.addScore = arg_2_2

	return
end

function var_0_0.GetRank(arg_3_0)
	return arg_3_0.rank
end

function var_0_0.GetAddScore(arg_4_0)
	return arg_4_0.addScore
end

function var_0_0.GetName(arg_5_0)
	return arg_5_0.player_info.name
end

function var_0_0.ReduceCardNum(arg_6_0, arg_6_1)
	arg_6_0.card_num = arg_6_0.card_num - arg_6_1

	return
end

function var_0_0.GetCardNum(arg_7_0)
	return arg_7_0.card_num
end

function var_0_0.UpdateBombState(arg_8_0, arg_8_1)
	arg_8_0.bomb_dic[arg_8_1] = true

	return
end

function var_0_0.UpdateDelegateState(arg_9_0, arg_9_1)
	arg_9_0.delegateState = arg_9_1

	return
end

function var_0_0.IsDelegate(arg_10_0)
	return arg_10_0.delegateState == 1
end

function var_0_0.SetOutState(arg_11_0)
	arg_11_0.state = 1

	return
end

function var_0_0.IsOut(arg_12_0)
	return arg_12_0.state == 1
end

function var_0_0.GetBombState(arg_13_0, arg_13_1)
	local var_13_0

	if not arg_13_0.bomb_dic[arg_13_1] then
		var_13_0 = false
	end

	return var_13_0
end

function var_0_0.GetCurrentAndAllHp(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0

	pairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.bomb_dic) do
		if iter_14_1 then
			var_14_0 = var_14_0 + 1
		end

		var_14_1 = var_14_1 + 1
	end

	return var_14_1 - var_14_0, var_14_1
end

function var_0_0.GetCurrentBombId(arg_15_0)
	local var_15_0
	local var_15_1 = 0

	pg = var_1_10003

	local var_15_2 = var_1_10003.gameset.bar_punishment_limit.key_value

	for iter_15_0 = 1, var_15_2 do
		if arg_15_0.bomb_dic[iter_15_0] == false and not var_15_0 then
			var_15_0 = iter_15_0 - 1
		elseif arg_15_0.bomb_dic[iter_15_0] == true then
			var_15_1 = var_15_1 + 1
		end
	end

	if var_15_0 == 0 then
		var_15_0 = var_15_2
	end

	return var_15_0 or 1, var_15_1
end

return var_0_0
