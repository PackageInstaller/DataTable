class = var_0_10000

local var_0_0 = "NewEducateGetExtraDropCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.scheduleDrops

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29048, {
		id = var_1_0
	}, 29049, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			NewEducateDropHelper = var_2_0
			var_2_0 = var_2_0.HandleDrops(arg_2_0.drop)

			local var_2_1 = arg_1_0
			local var_2_2 = var_2.sendNotification

			GAME = var_2_10005

			var_2_2(var_2_1, var_2_10005.NEW_EDUCATE_GET_EXTRA_DROP_DONE, {
				drops = var_2_0,
				scheduleDrops = var_1_1
			})
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_3, "NewEducate_GetExtraDrop: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
