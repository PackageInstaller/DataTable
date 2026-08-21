local var_0_0 = class("GetGuildRankCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = {}

	if var_1_1:getRawData().memberCount < 1 then
		var_1_1:SetRank(var_1_0, {})
	else
		pg.ConnectionMgr.GetInstance():Send(62029, {
			type = var_1_0
		}, 62030, function(arg_2_0)
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.list) do
				for iter_2_2, iter_2_3 in ipairs(iter_2_1.rankuserinfo) do
					local var_2_0 = var_0:getMemberById(iter_2_3.user_id)

					if var_2_0 then
						local var_2_1 = var_1_2[iter_2_3.user_id]

						if not var_1_2[iter_2_3.user_id] then
							var_2_1 = GuildRank.New(iter_2_3.user_id)

							var_2_1:SetName(var_2_0.name)

							var_1_2[var_2_1.id] = var_2_1
						end

						var_2_1:SetScore(iter_2_1.period, iter_2_3.count)
					end
				end
			end

			var_1_1:SetRank(var_1_0, var_1_2)
			arg_1_0:sendNotification(GAME.GUILD_GET_RANK_DONE, {
				id = var_1_0,
				list = var_1_2
			})

			return
		end)
	end

	return
end

return var_0_0
