class = var_0_10000

local var_0_0 = "SurveyStateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 11027, {
		survey_id = var_1_0.surveyID
	}, 11028, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10003
			var_2_10003 = var_1(var_2_10003)

			var_1.setSurveyState(var_2_10003, arg_2_0.result)
		elseif arg_2_0.result > 0 then
			getProxy = var_1
			ActivityProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.setSurveyState(var_2_0, arg_2_0.result)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_2(var_2_1, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
