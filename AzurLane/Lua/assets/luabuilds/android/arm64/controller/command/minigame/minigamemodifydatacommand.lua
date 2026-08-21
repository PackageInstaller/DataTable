local var_0_0 = class("MiniGameModifyDataCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(MiniGameProxy):GetMiniGameData(var_1_0.id)

	for iter_1_0, iter_1_1 in pairs(var_1_0.map) do
		var_1_1:SetRuntimeData(iter_1_0, iter_1_1)
	end

	arg_1_0:sendNotification(GAME.MODIFY_MINI_GAME_DATA_DONE, {
		id = var_1_0.id,
		map = var_1_0.map
	})

	return
end

return var_0_0
