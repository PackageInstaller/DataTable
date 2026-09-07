local MiniGameTimeCommand = class("MiniGameTimeCommand", pm.SimpleCommand)

function MiniGameTimeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildHubGames(var_1_0.id or 0, math.floor(var_1_0.time), ""))

	return
end

return MiniGameTimeCommand
