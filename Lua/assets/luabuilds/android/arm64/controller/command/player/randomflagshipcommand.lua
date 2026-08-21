local var_0_0 = class("RandomFlagshipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.isOn
	local var_1_2 = var_1_0.callback

	print("random flag switcher state : ", var_1_0.isOn)
	pg.ConnectionMgr.GetInstance():Send(12204, {
		flag = var_1_1 and 1 or 0
	}, 12205, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_2 then
				var_1_2()
			end
		else
			if var_1_2 then
				var_1_2()
			end

			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
