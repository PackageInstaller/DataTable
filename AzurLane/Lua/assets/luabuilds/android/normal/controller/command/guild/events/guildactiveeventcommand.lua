class = var_0_10000

local var_0_0 = "GuildActiveEventCommand"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildEventBaseCommand"))

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	GuildProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_1_1.eventId

	if not arg_1_0:ExistEvent(var_1_3) then
		return
	end

	if not arg_1_0:NotExistActiveEvent() then
		return
	end

	if not arg_1_0:IsAnim() then
		return
	end

	local var_1_4 = var_1_2:getData()
	local var_1_5 = var_5.GetEventById(var_1_4, var_1_3)
	local var_1_6 = var_6.GetConsume(var_1_5)

	if not arg_1_0:CheckCapital(var_6, var_1_6) then
		return
	end

	pg = var_8

	local var_1_7 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_7, 61001, {
		chapter_id = var_1_3
	}, 61002, function(arg_2_0)
		local var_2_4

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_4.IncActiveEventCnt(var_2_0)

			local var_2_1 = var_0

			var_2_4.consumeCapital(var_2_1, var_1_6)

			local var_2_2 = var_1_2

			var_2_4.updateGuild(var_2_2, var_0)

			local var_2_3 = arg_1_0

			var_2_4 = var_2_4.sendNotification
			GAME = var_2_10003

			var_2_4(var_2_3, var_2_10003.GUILD_ACTIVE_EVENT_DONE)
		else
			pg = var_2_4

			local var_2_5 = var_2_4.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
