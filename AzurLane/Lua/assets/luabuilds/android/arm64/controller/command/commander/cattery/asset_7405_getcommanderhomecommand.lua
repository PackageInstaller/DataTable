class = var_0_10000

local var_0_0 = "GetCommanderHomeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	CommanderProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if var_3.GetCommanderHome(var_1_1) then
		return
	end

	pg = var_4

	local var_1_2 = var_4.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 25026, {
		type = 0
	}, 25027, function(arg_2_0)
		CommanderHome = var_2_10001

		local var_2_0 = var_2_10001.New(arg_2_0)
		local var_2_1 = var_0

		var_2.AddCommanderHome(var_2_1, var_2_0)

		ipairs = var_2

		for iter_2_0, iter_2_1 in var_2(arg_2_0.slots) do
			if iter_2_1.commander_id ~= 0 and iter_2_1.commander_level and iter_2_1.commander_level ~= 0 and iter_2_1.commander_exp then
				local var_2_2 = arg_1_0

				var_7.UpdateCommanderLevelAndExp(var_2_2, iter_2_1.commander_id, iter_2_1.commander_level, iter_2_1.commander_exp)
			end
		end

		return
	end)

	return
end

function var_0_1.UpdateCommanderLevelAndExp(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	getProxy = var_1_10004
	CommanderProxy = var_1_10006

	local var_3_0 = var_1_10004(var_1_10006)

	if var_4.getCommanderById(var_3_0, arg_3_1) then
		var_5:UpdateLevelAndExp(arg_3_2, arg_3_3)
		var_4:updateCommander(var_5)
	end

	return
end

return var_0_1
