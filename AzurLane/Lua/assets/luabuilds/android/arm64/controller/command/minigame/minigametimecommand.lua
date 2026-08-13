class = var_0_10000

local var_0_0 = "MiniGameTimeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().id then
		var_1_0 = 0
	end

	local var_1_1 = var_2.time

	pg = var_1_10005

	local var_1_2 = var_1_10005.GameTrackerMgr.GetInstance()
	local var_1_3 = var_5.Record

	GameTrackerBuilder = var_1_10008

	local var_1_4 = var_1_10008.BuildHubGames
	local var_1_5 = var_1_0

	math = var_1_10011

	var_1_3(var_1_2, var_1_4(var_1_5, var_1_10011.floor(var_1_1), ""))

	return
end

return var_0_1
