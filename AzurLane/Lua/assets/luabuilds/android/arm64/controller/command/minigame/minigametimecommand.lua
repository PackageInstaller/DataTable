local var_0_0 = class("MiniGameTimeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildHubGames(var_1_1, math.floor(var_1_0.time), ""))

	return
end

return var_0_0
