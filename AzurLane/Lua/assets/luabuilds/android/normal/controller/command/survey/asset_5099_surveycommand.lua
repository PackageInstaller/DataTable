class = var_0_10000

local var_0_0 = "SurveyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 11025, {
		survey_id = var_1_1.surveyID
	}, 11026, function(arg_2_0)
		if arg_2_0.result == 0 then
			print = var_1

			var_1(var_1_1.surveyID, var_1_1.surveyUrlStr)

			pg = var_1

			local var_2_0 = var_1.SdkMgr.GetInstance()

			var_1.Survey(var_2_0, var_1_1.surveyUrlStr)

			IsUnityEditor = var_1

			if var_1 then
				Application = var_1

				var_1.OpenURL(var_1_1.surveyUrlStr)
			end
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_2(var_2_1, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
