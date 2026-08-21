local var_0_0 = class("NewEducateGetExtraDropCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.scheduleDrops

	pg.ConnectionMgr.GetInstance():Send(29048, {
		id = var_1_0.id
	}, 29049, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_GET_EXTRA_DROP_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				scheduleDrops = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GetExtraDrop: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
