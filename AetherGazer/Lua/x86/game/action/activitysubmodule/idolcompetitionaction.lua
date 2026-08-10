local var_0_0 = {}

manager.net:Bind(65101, function(arg_1_0)
	IdolCompetitionData:InitDataFromServer(arg_1_0)
	var_0_0.CheckRaceSignRedPoint()
	manager.notify:Invoke(IDOL_COMPETITION_RACE_PHASE_UPDATE)
end)

function var_0_0.RequestSignUpForRace(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = {
		activity_id = arg_2_0,
		hero_setting_list = arg_2_1
	}

	manager.net:SendWithLoadingNew(65102, var_2_0, 65103, function(arg_3_0, arg_3_1)
		if isSuccess(arg_3_0.result) then
			IdolCompetitionData:OnRequestSignUpForRace(arg_2_0, arg_2_1)

			if arg_2_2 then
				arg_2_2()
			end
		else
			ShowTips(GetTips(arg_3_0.result))
		end
	end)
end

function var_0_0.RequestForRaceSchedule(arg_4_0, arg_4_1)
	manager.net:SendWithLoadingNew(65104, {
		activity_id = arg_4_0
	}, 65105, function(arg_5_0, arg_5_1)
		if isSuccess(arg_5_0.result) then
			IdolCompetitionData:UpdateRacePhaseData(arg_5_0, arg_4_0)
		else
			ShowTips(GetTips(arg_5_0.result))
		end

		if arg_4_1 then
			arg_4_1()
		end
	end)
end

manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	if #TaskTools:GetCanGetActivityTaskList(2932801) > 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_IDOL_COMPETITION_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_IDOL_COMPETITION_REWARD, 0)
	end
end)

function var_0_0.CheckRaceSignRedPoint()
	local var_7_0 = getData("IdolCompetition", "click_time") or 0
	local var_7_1 = _G.gameTimer:GetNextDayFreshTime()

	if not IdolCompetitionData:CheckRaceSignState() then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN, 0)
	elseif haveProgress or var_7_1 > 0 and var_7_1 <= var_7_0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN, 0)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_IDOL_COMPETITION_SIGN, 1)
	end
end

return var_0_0
