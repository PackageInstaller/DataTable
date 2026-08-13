class = var_0_10000

local var_0_0 = "GetGuildRankCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.getRawData(var_1_1)
	local var_1_3 = {}

	if var_1_2.memberCount < 1 then
		var_4:SetRank(var_1_0, var_1_3)
	else
		pg = var_7

		local var_1_4 = var_7.ConnectionMgr.GetInstance()

		var_7.Send(var_1_4, 62029, {
			type = var_1_0
		}, 62030, function(arg_2_0)
			ipairs = var_2_10001

			for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.list) do
				ipairs = var_2_10006

				for iter_2_2, iter_2_3 in var_2_10006(iter_2_1.rankuserinfo) do
					local var_2_0 = var_1_2

					if var_11.getMemberById(var_2_0, iter_2_3.user_id) then
						if not var_1_3[iter_2_3.user_id] then
							GuildRank = var_13

							local var_2_1 = var_13.New(iter_2_3.user_id)

							var_12.SetName(var_2_1, var_11.name)

							var_1_3[var_12.id] = var_12
						end

						var_12:SetScore(iter_2_1.period, iter_2_3.count)
					end
				end
			end

			local var_2_2 = var_0

			var_1.SetRank(var_2_2, var_1_0, var_1_3)

			local var_2_3 = arg_1_0
			local var_2_4 = var_1.sendNotification

			GAME = var_3

			var_2_4(var_2_3, var_3.GUILD_GET_RANK_DONE, {
				id = var_1_0,
				list = var_1_3
			})

			return
		end)
	end

	return
end

return var_0_1
