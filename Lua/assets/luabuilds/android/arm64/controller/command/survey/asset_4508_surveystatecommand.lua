local SurveyStateCommand = class("SurveyStateCommand", pm.SimpleCommand)

function SurveyStateCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(11027, {
		survey_id = arg_1_1:getBody().surveyID
	}, 11028, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(ActivityProxy):setSurveyState(arg_2_0.result)
		elseif arg_2_0.result > 0 then
			getProxy(ActivityProxy):setSurveyState(arg_2_0.result)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return SurveyStateCommand
