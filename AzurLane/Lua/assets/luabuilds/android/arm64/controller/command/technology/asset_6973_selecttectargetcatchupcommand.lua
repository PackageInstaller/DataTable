class = var_0_10000

local var_0_0 = "SelectTecTargetCatchupCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().tecID
	local var_1_1 = var_2.charID

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 63011, {
		version = var_1_0,
		target = var_1_1
	}, 63012, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			TechnologyProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)

			local var_2_1 = var_0.tecID
			local var_2_2 = var_1_1

			if var_1_1 == 0 then
				-- block empty
			else
				var_2_0:setCurCatchupTecInfo(var_2_1, var_2_2)
			end

			local var_2_3 = arg_1_0
			local var_2_4 = var_4.sendNotification

			GAME = var_2_10007

			var_2_4(var_2_3, var_2_10007.SELECT_TEC_TARGET_CATCHUP_DONE, {
				tecID = var_2_1
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "Error Code" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
