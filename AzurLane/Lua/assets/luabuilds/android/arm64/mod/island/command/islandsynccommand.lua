class = var_0_10000

local var_0_0 = "IslandSyncCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

local function var_0_2(...)
	if false then
		warning = var_1_10000

		var_1_10000(...)
	end

	return
end

function var_0_1.execute(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getBody()

	_ = var_1_10003

	local var_2_1 = var_1_10003.map(var_2_0.data, function(arg_3_0)
		return arg_3_0:Pack()
	end)

	var_0_2("send")

	_ = var_4

	var_4.each(var_2_0.data, function(arg_4_0)
		var_0_2(arg_4_0:toString())

		return
	end)

	pg = var_4

	local var_2_2 = var_4.ConnectionMgr.GetInstance()

	var_4.Send(var_2_2, 21211, {
		island_id = var_2_0.islandId,
		sync_ob_list = var_2_1
	})

	return
end

return var_0_1
