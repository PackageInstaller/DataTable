class = var_0_10000

local var_0_0 = "RandomFlagshipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().isOn
	local var_1_1 = var_2.callback

	print = var_1_10005

	var_1_10005("random flag switcher state : ", var_1_0)

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 12204, {
		flag = var_1_0 and 1 or 0
	}, 12205, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_1 then
				var_1_1()
			end
		else
			if var_1_1 then
				var_1_1()
			end

			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_1(var_2_0, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
