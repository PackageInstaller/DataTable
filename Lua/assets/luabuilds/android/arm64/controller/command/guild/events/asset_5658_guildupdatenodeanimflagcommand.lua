local GuildUpdateNodeAnimFlagCommand = class("GuildUpdateNodeAnimFlagCommand", import(".GuildEventBaseCommand"))

function GuildUpdateNodeAnimFlagCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.position
	local var_1_4
	local var_1_3

	if not self:ExistMission(var_1_0.id) then
		do return end

		var_1_3 = {}
		var_1_4 = {}
	end

	var_1_4[1] = {
		event_id = var_1_0.id,
		index = var_1_0.position
	}
	var_1_3.perf = var_1_4

	pg.ConnectionMgr.GetInstance():Send(61025, var_1_3, 61026, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(GuildProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:GetActiveEvent():GetMissionById(var_1_1):UpdateNodeAnimFlagIndex(var_1_2)
			var_2_0:updateGuild(var_2_1)
			self:sendNotification(GAME.GUILD_UPDATE_NODE_ANIM_FLAG_DONE, {
				id = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GuildUpdateNodeAnimFlagCommand
