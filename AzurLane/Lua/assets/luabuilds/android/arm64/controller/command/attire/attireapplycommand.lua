local var_0_0 = class("AttireApplyCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.type

	if not getProxy(AttireProxy):getAttireFrame(var_1_0.type, var_1_0.id) then
		return
	end

	local var_1_3 = getProxy(PlayerProxy)
	local var_1_4 = var_1_3:getData()

	pg.ConnectionMgr.GetInstance():Send(11005, {
		id = var_1_0.id,
		type = var_1_0.type
	}, 11006, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_4:updateAttireFrame(var_1_2, var_1_1)
			var_1_3:updatePlayer(var_1_4)
			arg_1_0:sendNotification(GAME.ATTIRE_APPLY_DONE)
		else
			print(arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
