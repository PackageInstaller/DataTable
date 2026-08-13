class = var_0_10000

local var_0_0 = "MiniGameFriendRankCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	if arg_1_1:getBody().id == nil then
		return
	end

	local var_1_0 = var_2.id

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 26111, {
		gameid = var_1_0
	}, 26112, function(arg_2_0)
		underscore = var_2_10001

		local var_2_0 = var_2_10001(arg_2_0.ranks)
		local var_2_1 = var_1.chain(var_2_0)
		local var_2_2 = var_1.sort(var_2_1, function(arg_3_0, arg_3_1)
			return arg_3_0.score > arg_3_1.score
		end)
		local var_2_3 = var_1.reduce(var_2_2, {}, function(arg_4_0, arg_4_1)
			local var_4_0 = {
				position = #arg_4_0 + 1,
				player_id = arg_4_1.id,
				name = arg_4_1.name,
				score = arg_4_1.score,
				display = arg_4_1.display,
				time_data = arg_4_1.time_data
			}

			arg_4_0[#arg_4_0 + 1] = var_4_0

			if #arg_4_0 > 1 and arg_4_0[#arg_4_0 - 1].score == arg_4_1.score then
				var_4_0.position = arg_4_0[#arg_4_0 - 1].position
			end

			return arg_4_0
		end)
		local var_2_4 = var_1.value(var_2_3)

		getProxy = var_2_3
		MiniGameProxy = var_3

		local var_2_5 = var_2_3(var_3)

		var_2.SetRank(var_2_5, var_1_0, var_2_4)

		if var_0.callback then
			var_0.callback(var_2_4)
		end

		return
	end)

	return
end

return var_0_1
