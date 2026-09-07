local GuildGetReportRankCommand = class("GuildGetReportRankCommand", pm.SimpleCommand)

function GuildGetReportRankCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(GuildProxy)
	local var_1_2 = var_1_1:GetReportRankList(var_1_0)

	if var_1_2 then
		self:sendNotification(GAME.GET_GUILD_REPORT_RANK_DONE, {
			ranks = var_1_2
		})
	else
		pg.ConnectionMgr.GetInstance():Send(61037, {
			id = var_1_0
		}, 61038, function(arg_2_0)
			local var_2_0 = var_1_1:getRawData()
			local var_2_1 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.list) do
				local var_2_2 = var_2_0:getMemberById(iter_2_1.user_id)

				if var_2_2 then
					table.insert(var_2_1, {
						name = var_2_2.name,
						damage = iter_2_1.damage
					})
				end
			end

			table.sort(var_2_1, function(arg_3_0, arg_3_1)
				return arg_3_0.damage > arg_3_1.damage
			end)
			var_1_1:SetReportRankList(var_1_0, var_2_1)
			self:sendNotification(GAME.GET_GUILD_REPORT_RANK_DONE, {
				ranks = var_2_1
			})

			return
		end)
	end

	return
end

return GuildGetReportRankCommand
