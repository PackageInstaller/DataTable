local var_0_0 = class("GuildActiveEventCommand", import(".GuildEventBaseCommand"))

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(GuildProxy)
	local var_1_1 = arg_1_1:getBody().eventId

	if not arg_1_0:ExistEvent(var_1_1) then
		return
	end

	if not arg_1_0:NotExistActiveEvent() then
		return
	end

	if not arg_1_0:IsAnim() then
		return
	end

	local var_1_2 = getProxy(GuildProxy):getData()
	local var_1_3 = var_1_2:GetEventById(var_1_1)

	if not arg_1_0:CheckCapital(var_1_3, (var_1_3:GetConsume())) then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(61001, {
		chapter_id = var_1_1
	}, 61002, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:IncActiveEventCnt()
			var_1_2:consumeCapital(var_0)
			var_1_0:updateGuild(var_1_2)
			arg_1_0:sendNotification(GAME.GUILD_ACTIVE_EVENT_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
