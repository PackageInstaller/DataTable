local var_0_0 = {}

manager.net:Bind(86025, function(arg_1_0)
	ActivityAutoCookData:SetData(arg_1_0)
end)

function var_0_0.GetAutoCookReward(arg_2_0, arg_2_1, arg_2_2)
	manager.net:SendWithLoadingNew(86022, {
		activity_id = arg_2_1
	}, 86023, function(arg_3_0, arg_3_1)
		if isSuccess(arg_3_0.result) then
			local var_3_0 = {}

			for iter_3_0, iter_3_1 in ipairs(arg_3_0.token_list) do
				table.insert(var_3_0, {
					id = iter_3_1.id,
					num = iter_3_1.num
				})
			end

			sortMergeGetReward(var_3_0)
			ActivityAutoCookData:SetData(arg_3_0)
			manager.notify:CallUpdateFunc(ACTIVITY_AUTO_COOK_GET_REWARD)
		else
			ShowTips(GetTips(arg_3_0.result))
		end
	end)
end

function var_0_0.AutoCookStageFinish(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	manager.net:SendWithLoadingNew(86018, {
		stage_id = arg_4_1,
		hero_id = arg_4_2
	}, 86019, function(arg_5_0, arg_5_1)
		if isSuccess(arg_5_0.result) then
			if arg_4_3 ~= nil then
				arg_4_3()
			end

			ActivityAutoCookData:FinishStage(arg_5_1.stage_id)
		else
			ShowTips(GetTips(arg_5_0.result))
		end
	end)
end

function var_0_0.InitRedPoint(arg_6_0)
	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_6_0), arg_6_0), {
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_6_0),
		RedPointConst.ACTIVITY_AUTO_COOK_GOLDMAX .. arg_6_0,
		RedPointConst.ACTIVITY_AUTO_COOK_NEW_LEVLE .. arg_6_0
	})
end

function var_0_0.UpdateRedPoint(arg_7_0)
	local var_7_0 = ActivityData:GetActivityData(arg_7_0)
	local var_7_1 = manager.time:GetServerTime() + 1

	if var_7_1 >= var_7_0.stopTime then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_7_0), 0)
	elseif var_7_1 >= var_7_0.startTime then
		-- block empty
	end
end

function var_0_0.UpdateLoginRedPoint()
	if not ActivityAutoCookData.login_ then
		ActivityAutoCookData.login_ = true

		if ActivityData:GetActivityIsOpen(ActivityConst.AUTO_COOK) then
			for iter_8_0, iter_8_1 in pairs(ActivityAutoCookStageCfg.all) do
				local var_8_0 = false
				local var_8_1 = false
				local var_8_2 = ActivityAutoCookStageCfg[iter_8_1]
				local var_8_3 = not (var_8_2.condition > 0) or not not IsConditionAchieved(var_8_2.condition) and true

				if ActivityAutoCookData:GetStageIsFinish(iter_8_1) then
					var_8_1 = true
				end

				if var_8_3 == true and var_8_1 == false then
					manager.redPoint:setTip(RedPointConst.ACTIVITY_AUTO_COOK_NEW_LEVLE .. ActivityConst.AUTO_COOK, 1)

					return
				end
			end
		end
	end
end

return var_0_0
