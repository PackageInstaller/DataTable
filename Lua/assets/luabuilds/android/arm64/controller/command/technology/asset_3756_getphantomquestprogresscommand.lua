local GetPhantomQuestProgressCommand = class("GetPhantomQuestProgressCommand", pm.SimpleCommand)

function GetPhantomQuestProgressCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(12212, {
		ship_id_list = var_1_0.shipIds
	}, 12213, function(arg_2_0)
		local var_2_0 = {}

		underscore.each(arg_2_0.ship_count_list, function(arg_3_0)
			var_2_0[arg_3_0.key] = arg_3_0.value

			return
		end)
		getProxy(TechnologyProxy):updatePhantomQuestProgress(3, var_2_0)
		existCall(var_1_1)
		self:sendNotification(GAME.GET_PHANTOM_QUEST_PROGRESS_DONE)

		return
	end)

	return
end

return GetPhantomQuestProgressCommand
