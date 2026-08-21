local var_0_0 = class("SurveyCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(11025, {
		survey_id = arg_1_1:getBody().surveyID
	}, 11026, function(arg_2_0)
		if arg_2_0.result == 0 then
			print(var_0.surveyID, var_0.surveyUrlStr)
			pg.SdkMgr.GetInstance():Survey(var_0.surveyUrlStr)

			if IsUnityEditor then
				Application.OpenURL(var_0.surveyUrlStr)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
