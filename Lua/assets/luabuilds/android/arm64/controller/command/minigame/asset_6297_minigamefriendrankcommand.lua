local MiniGameFriendRankCommand = class("MiniGameFriendRankCommand", pm.SimpleCommand)

function MiniGameFriendRankCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0.id == nil then
		return
	end

	local var_1_1 = var_1_0.id

	pg.ConnectionMgr.GetInstance():Send(26111, {
		gameid = var_1_0.id
	}, 26112, function(arg_2_0)
		local var_2_0 = underscore(arg_2_0.ranks):chain():sort(function(arg_3_0, arg_3_1)
			return arg_3_0.score > arg_3_1.score
		end):reduce({}, function(arg_4_0, arg_4_1)
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
		end):value()

		getProxy(MiniGameProxy):SetRank(var_1_1, var_2_0)

		if var_1_0.callback then
			var_1_0.callback(var_2_0)
		end

		return
	end)

	return
end

return MiniGameFriendRankCommand
