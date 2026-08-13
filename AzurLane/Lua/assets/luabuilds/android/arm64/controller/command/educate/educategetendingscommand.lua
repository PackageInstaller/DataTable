class = var_0_10000

local var_0_0 = "EducateGetEndingsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 27010, {
		type = 0
	}, 27011, function(arg_2_0)
		local var_2_2

		if arg_2_0.endings then
			getProxy = var_2_2
			EducateProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)

			var_2_2.SetEndings(var_2_0, arg_2_0.endings, arg_2_0.qualifieds)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.EDUCATE_GET_ENDINGS_DONE)

			if var_1_1 then
				var_1_1()
			end
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("educate get endings error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
