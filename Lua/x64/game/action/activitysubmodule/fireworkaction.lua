local var_0_0 = {}

manager.net:Bind(64051, function(arg_1_0)
	FireWorkData:InitFireData(arg_1_0)
	var_0_0.CheckRedPoint(arg_1_0.activity_id)
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_2_0)
	if ActivityTools.GetActivityType(arg_2_0) == ActivityTemplateConst.FIRE_WORK then
		FireWorkAction.CheckRedPoint(arg_2_0)
	end
end)

function var_0_0.QueryInvite(arg_3_0)
	manager.net:SendWithLoadingNew(64052, {
		activity_id = arg_3_0
	}, 64053, var_0_0.OnInviteCallBack)
end

function var_0_0.OnInviteCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		FireWorkData:SetInvited(arg_4_1.activity_id, true)
		var_0_0.CheckRedPoint(arg_4_1.activity_id)
		manager.notify:CallUpdateFunc(FIRE_WORK_UPDATE)
		JumpTools.OpenPageByJump("fireWorkResult", {
			isWin = true,
			fire_activity_id = arg_4_1.activity_id
		})
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.QueryReceiveReward(arg_5_0)
	manager.net:SendWithLoadingNew(64054, {
		activity_id = arg_5_0
	}, 64055, var_0_0.OnReceiveRewardCallBack)
end

function var_0_0.OnReceiveRewardCallBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		local var_6_0 = arg_6_0.reward_list

		getReward2(var_6_0)
		FireWorkData:SetRewarded(arg_6_1.activity_id, true)
		var_0_0.CheckRedPoint(arg_6_1.activity_id)
		manager.notify:CallUpdateFunc(FIRE_WORK_UPDATE)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.CheckRedPoint(arg_7_0)
	if ActivityData:GetActivityIsOpen(arg_7_0) then
		local var_7_0 = FireWorkData:GetFireData(arg_7_0)

		if var_7_0 then
			if var_7_0.is_invited and not var_7_0.is_rewarded then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, arg_7_0), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, arg_7_0), 0)
			end

			if var_7_0.is_invited ~= true and not FireWorkData:GetRead(arg_7_0) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, arg_7_0), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, arg_7_0), 0)
			end

			return
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, arg_7_0), 0)
	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, arg_7_0), 0)
end

function var_0_0.SetRead(arg_8_0)
	if manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, arg_8_0)) == 1 then
		FireWorkData:SetRead(arg_8_0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, arg_8_0), 0)
	end
end

return var_0_0
