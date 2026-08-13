class = var_0_10000

local var_0_0 = "IslandSyncCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

local function var_0_2(...)
	if false then
		warning = var_1_10000

		var_1_10000(...)
	end

	return
end

function var_0_1.execute(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.getBody(var_2_0)

	_ = var_2_0

	local var_2_2 = var_2_0.map(var_2_1.data, function(arg_3_0)
		return arg_3_0:Pack()
	end)

	var_0_2("send")

	_ = var_4

	var_4.each(var_2_1.data, function(arg_4_0)
		var_0_2(arg_4_0:toString())

		return
	end)

	pg = var_4

	local var_2_3 = var_4.ConnectionMgr.GetInstance()

	var_4.Send(var_2_3, 21211, {
		island_id = var_2_1.islandId,
		sync_ob_list = var_2_2
	})

	return
end

return var_0_1
