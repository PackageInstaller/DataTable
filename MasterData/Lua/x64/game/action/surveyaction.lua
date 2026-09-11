local var_0_0 = {}

manager.net:Bind(40005, function(arg_1_0)
	SurveyData:InitData(arg_1_0)
	RegressionAction.ChcekSurveyRedPoint()
end)
manager.net:Bind(40009, function(arg_2_0)
	SurveyData:FinishSurvey(arg_2_0.id)
	var_0_0.UpdateSurveyRedPoint(true)
	manager.notify:CallUpdateFunc(FINISH_SURVEY, arg_2_0)
	RegressionAction.ChcekSurveyRedPoint()
end)
manager.net:Bind(40023, function(arg_3_0)
	SurveyData:ReservationGame(arg_3_0.state == 1)
end)
manager.net:Bind(40011, function(arg_4_0)
	SurveyData:SetPraise(true)
	SurveyData:SetSourceId(arg_4_0.source_id)
end)

function var_0_0.Praise(arg_5_0)
	manager.net:Push(40012, {
		btn = arg_5_0
	})
end

function var_0_0.GetReward(arg_6_0)
	manager.net:SendWithLoadingNew(40006, {
		id = arg_6_0
	}, 40007, var_0_0.OnGetReward)
end

function var_0_0:OnGetReward(arg_7_1)
	if isSuccess(self.result) then
		SurveyData:GotReward(arg_7_1.id)
		manager.notify:CallUpdateFunc(GET_SURVEY_GIFT, self, arg_7_1)
		var_0_0.UpdateSurveyRedPoint()
		RegressionAction.ChcekSurveyRedPoint()
	else
		ShowTips(self.result)
	end
end

function var_0_0.ReservationGame()
	manager.net:SendWithLoadingNew(40024, {
		state = 1
	}, 40025, var_0_0.OnReservationGame)
end

function var_0_0:OnReservationGame(arg_9_1)
	if isSuccess(self.result) then
		SurveyData:ReservationGame(true)
		manager.notify:CallUpdateFunc(RESERVATION_GAME, self)
	else
		ShowTips(self.result)
	end
end

function var_0_0.SetSurveyRedPointData()
	saveData("SDK", "survey", (manager.time:GetServerTime()))

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(SurveyData:GetSurveyList()) do
		table.insert(var_10_0, iter_10_1.id)
	end

	saveData("SDK", "surveyList", var_10_0)
	var_0_0.UpdateSurveyRedPoint()
end

function var_0_0.UpdateSurveyRedPoint(arg_11_0)
	local var_11_0

	if not arg_11_0 then
		local var_11_1 = getData("SDK", "survey")

		if var_11_1 and manager.time:IsSameDay(var_11_1 - 18000, manager.time:GetServerTime() - 18000) then
			var_11_0 = 0
		end
	end

	local var_11_2 = getData("SDK", "surveyList") or {}

	for iter_11_0, iter_11_1 in pairs(SurveyData:GetSurveyList()) do
		if iter_11_1.type == 1 and not table.keyof(var_11_2, iter_11_0) then
			var_11_0 = 1

			break
		end
	end

	for iter_11_2, iter_11_3 in pairs((SurveyData:GetSurveyList())) do
		if iter_11_3.type == 1 and iter_11_3.status == 1 then
			var_11_0 = 1

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.SURVEY, (not table.keyof(OperationData:GetOperationOpenList(), OperationConst.QUESTIONNAIRE) or nil) and 0)
end

function var_0_0.FollowPlatform(arg_12_0)
	manager.net:SendWithLoadingNew(40026, {
		type = arg_12_0
	}, 40027, var_0_0.OnFollowPlatform)
end

function var_0_0:OnFollowPlatform(arg_13_1)
	if isSuccess(self.result) then
		if OperationConst.PLATFORM.BILIBILI == arg_13_1.type then
			SurveyData:CacheFollowTip(GetTips("WEIBO_REWARD_SENT"))
		elseif OperationConst.PLATFORM.YOUTUBE == arg_13_1.type then
			SurveyData:CacheFollowTip(GetTips("WEIBO_REWARD_SENT"))
		else
			ShowTips("WEIBO_REWARD_SENT")
		end
	elseif self.result == 6904 then
		ShowTips("ERROR_DISCORD_SUBSCRIB_FAILED")
	elseif OperationConst.PLATFORM.BILIBILI == arg_13_1.type then
		SurveyData:CacheFollowTip(GetTips("ERROR_WEIBO_REWARD_COLLECTED"))
	elseif OperationConst.PLATFORM.YOUTUBE == arg_13_1.type then
		SurveyData:CacheFollowTip(GetTips("ERROR_WEIBO_REWARD_COLLECTED"))
	else
		ShowTips("ERROR_WEIBO_REWARD_COLLECTED")
	end

	if OperationConst.PLATFORM.BILIBILI == arg_13_1.type then
		OperationAction.OpenNormalUrl((OperationAction.GetOperationUrl("FOLLOW_BILIBILI")))
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 53,
			direction_channel = 4
		})
	end
end

return var_0_0
