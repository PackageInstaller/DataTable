class = var_0_10000

local var_0_0 = "SurveyStateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 11027, {
		survey_id = var_1_1.surveyID
	}, 11028, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_1.setSurveyState(var_2_0, arg_2_0.result)
		else
			local var_2_1 = arg_2_0.result

			if 0 < var_2_1 then
				getProxy = var_2_1
				ActivityProxy = var_2

				local var_2_2 = var_2_1(var_2)

				var_2_1.setSurveyState(var_2_2, arg_2_0.result)
			else
				pg = var_2_1

				local var_2_3 = var_2_1.TipsMgr.GetInstance()
				local var_2_4 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_4(var_2_3, var_2_10003("", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
