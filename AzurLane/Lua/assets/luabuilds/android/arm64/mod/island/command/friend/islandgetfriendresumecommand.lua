local var_0_0 = class("IslandGetFriendResumeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	if LOCK_ISLAND_DISPLAY then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21200, {
		island_id = var_1_0.id
	}, 21201, function(arg_2_0)
		var_1_1((SharedIsland.New(arg_2_0.island)))

		return
	end)

	return
end

return var_0_0
