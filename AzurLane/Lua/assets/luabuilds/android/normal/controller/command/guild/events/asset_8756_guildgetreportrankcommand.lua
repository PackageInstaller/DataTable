class = var_0_10000

local var_0_0 = "GuildGetReportRankCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	GuildProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if var_4.GetReportRankList(var_1_1, var_1_0) then
		local var_1_2 = arg_1_0

		var_1_1 = arg_1_0.sendNotification
		GAME = var_1_10008

		var_1_1(var_1_2, var_1_10008.GET_GUILD_REPORT_RANK_DONE, {
			ranks = var_5
		})
	else
		pg = var_1_1

		local var_1_3 = var_1_1.ConnectionMgr.GetInstance()

		var_6.Send(var_1_3, 61037, {
			id = var_1_0
		}, 61038, function(arg_2_0)
			local var_2_0 = var_0
			local var_2_1 = var_1.getRawData(var_2_0)
			local var_2_2 = {}

			ipairs = var_2_10003

			for iter_2_0, iter_2_1 in var_2_10003(arg_2_0.list) do
				local var_2_3 = var_2_1

				if var_2_1.getMemberById(var_2_3, iter_2_1.user_id) then
					table = var_2_3

					var_2_3.insert(var_2_2, {
						name = var_8.name,
						damage = iter_2_1.damage
					})
				end
			end

			table = var_3

			var_3.sort(var_2_2, function(arg_3_0, arg_3_1)
				return arg_3_0.damage > arg_3_1.damage
			end)

			local var_2_4 = var_0

			var_3.SetReportRankList(var_2_4, var_1_0, var_2_2)

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_5

			var_2_6(var_2_5, var_5.GET_GUILD_REPORT_RANK_DONE, {
				ranks = var_2_2
			})

			return
		end)
	end

	return
end

return var_0_1
