class = var_0_10000

local var_0_0 = "IslandAniamtionOpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().targetId
	local var_1_1 = var_2.actionId
	local var_1_2 = var_2.islandId

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 21700, {
		island_id = var_1_2,
		target_id = var_1_0,
		action_id = var_1_1
	})

	return
end

return var_0_1
