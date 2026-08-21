local var_0_0 = class("MiniGameFriendRankCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0.id == nil then
		return
	end

	;({}).gameid = var_1_0.id

	pg.ConnectionMgr.GetInstance():Send(26111, {}, 26112, function(arg_2_0)
		local var_2_0 = underscore(arg_2_0.ranks):chain():sort(function(arg_3_0, arg_3_1)
			return arg_3_0.score > arg_3_1.score
		end):reduce({}, function(arg_4_0, arg_4_1)
			arg_4_0[#arg_4_0 + 1] = {
				position = #arg_4_0 + 1,
				player_id = arg_4_1.id,
				name = arg_4_1.name,
				score = arg_4_1.score,
				display = arg_4_1.display,
				time_data = arg_4_1.time_data
			}

			if #arg_4_0 > 1 and arg_4_0[#arg_4_0 - 1].score == arg_4_1.score then
				({
					position = #arg_4_0 + 1,
					player_id = arg_4_1.id,
					name = arg_4_1.name,
					score = arg_4_1.score,
					display = arg_4_1.display,
					time_data = arg_4_1.time_data
				}).position = arg_4_0[#arg_4_0 - 1].position
			end

			return arg_4_0
		end):value()

		getProxy(MiniGameProxy):SetRank(var_0, var_2_0)

		if var_1_0.callback then
			var_1_0.callback(var_2_0)
		end

		return
	end)

	return
end

return var_0_0
