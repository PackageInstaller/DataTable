local var_0_0 = {}
local var_0_1 = false

manager.net:Bind(59011, function(arg_1_0)
	if not var_0_1 then
		var_0_0.InitRedPointConst(arg_1_0.version_id)
	end

	var_0_1 = true

	ActivityNoobData:InitData(arg_1_0)
	var_0_0.PlayerUpgradeRedPoint()
	var_0_0.RefreshAccumulateRedPoint()
	ActivityNewbieTools.RefreshFirstRechargeRedPoint()
	ActivityNewbieTools.RefreshMonthlyCardRedPoint()
	ActivityNewbieTools.RefreshBpRedPoint()
	TaskRedPoint:UpdateNoobTaskRedFull(ActivityNewbieTools.GetNoobTaskType())
	ActivityNewbieTools.RefreshAdvanceTaskRedPoint()
end)
manager.net:Bind(59009, function(arg_2_0)
	if var_0_1 == true then
		ActivityNoobData:UpdateRecharge(arg_2_0.newbie_recharge_reward)
		manager.notify:Invoke(NEWBIE_RECHARGE_UPDATE)
		ActivityNewbieTools.RefreshFirstRechargeRedPoint()
		ActivityNewbieTools.RefreshMonthlyCardRedPoint()
		ActivityNewbieTools.RefreshBpRedPoint()
	end
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	if var_0_1 == true then
		var_0_0.PlayerUpgradeRedPoint()
		ActivityNewbieTools.RefreshAdvanceTaskRedPoint()
	end
end)

function var_0_0.PlayerUpgradeRedPoint()
	if not var_0_1 then
		return
	end

	local var_4_0 = PlayerData:GetPlayerInfo().userLevel
	local var_4_1 = ActivityNoobData:GetUpgradeFinishList()

	for iter_4_0, iter_4_1 in ipairs(GameSetting.levelup_reward.value) do
		local var_4_2 = iter_4_1[1]

		if var_4_0 < var_4_2 then
			manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 0)

			return
		end

		if not table.keyof(var_4_1, var_4_2) then
			manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.NEWBIE_UPGRADE, 0)
end

function var_0_0.NoobSignIn(arg_5_0)
	manager.net:SendWithLoadingNew(59012, {}, 59013, function(arg_6_0)
		arg_5_0(arg_6_0)
	end)
end

function var_0_0.ReceiveUpgradeReward(arg_7_0, arg_7_1)
	manager.net:SendWithLoadingNew(59004, {
		level = arg_7_0
	}, 59005, function(arg_8_0)
		arg_7_1(arg_8_0)
	end)
end

function var_0_0.ReceiveRechargeReward(arg_9_0, arg_9_1, arg_9_2)
	manager.net:SendWithLoadingNew(59006, {
		type = arg_9_0,
		reward_type = arg_9_1
	}, 59007, function(arg_10_0)
		if arg_9_2 then
			arg_9_2(arg_10_0)
		end
	end)
end

function var_0_0.ReceiveAccumulateReward(arg_11_0)
	manager.net:SendWithLoadingNew(59014, {
		id = arg_11_0
	}, 59015, function(arg_12_0)
		if isSuccess(arg_12_0.result) then
			ActivityNoobData:SetAccumulateReceivedList(arg_11_0)
			var_0_0.RefreshAccumulateRedPoint()
			getReward2(arg_12_0.reward_list)
			manager.notify:Invoke(NOOB_ACCUMULATE_RECEIVE)
		else
			ShowTips(arg_12_0.result)
		end
	end)
end

function var_0_0.InitRedPointConst(arg_13_0)
	local var_13_0 = {}

	for iter_13_0 = 1, 2 do
		var_13_0[#var_13_0 + 1] = string.format("%s_%d", RedPointConst.NEWBIE_SIGN, iter_13_0)
	end

	manager.redPoint:addGroup(RedPointConst.NEWBIE_SIGN, var_13_0)

	local var_13_1 = NoobVersionCfg[arg_13_0] or NoobVersionCfg[2]

	if var_13_1.noob_task_type ~= 0 then
		local var_13_2 = #TaskTools:GetNoobPhaseTask(var_13_1.noob_task_type)
		local var_13_3 = {}

		for iter_13_1 = 1, var_13_2 do
			var_13_3[#var_13_3 + 1] = string.format("%s_%d", RedPointConst.NEWBIE_TASK, iter_13_1)
		end

		var_13_3[#var_13_3 + 1] = RedPointConst.NOOB_TASK_ACCUMULATE

		manager.redPoint:addGroup(RedPointConst.NEWBIE_TASK, var_13_3)
	end
end

function var_0_0.RefreshAccumulateRedPoint()
	local var_14_0 = ActivityNewbieTools.GetVersionID()
	local var_14_1 = NoobVersionCfg[var_14_0].noob_task_type
	local var_14_2 = TaskTools:GetNoobCompletedList(var_14_1)
	local var_14_3 = 0

	for iter_14_0, iter_14_1 in pairs(var_14_2) do
		var_14_3 = var_14_3 + iter_14_1
	end

	local var_14_4 = ActivityNoobData:GetAccumulateReceivedList() or {}
	local var_14_5 = ActivityNewbieTools.GetNoobPorgressRewardList()

	for iter_14_2, iter_14_3 in ipairs(var_14_5) do
		if var_14_3 >= iter_14_3[1] and not var_14_4[iter_14_2] then
			manager.redPoint:setTip(RedPointConst.NOOB_TASK_ACCUMULATE, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.NOOB_TASK_ACCUMULATE, 0)
end

function var_0_0.UpdateFirstRecharge()
	manager.net:SendWithLoadingNew(59016, {}, 59017, function(arg_16_0)
		ActivityNoobData:SetNewTagRoleFlag(false)
	end)
end

function var_0_0.UpdateFirstSign()
	manager.net:SendWithLoadingNew(59018, {}, 59019, function(arg_18_0)
		ActivityNoobData:SetNewTagSignFlag(false)
	end)
end

function var_0_0.UpdateFirstGearNewTag()
	manager.net:SendWithLoadingNew(59020, {}, 59021, function(arg_20_0)
		ActivityNoobData:SetFirstGearNewTag(false)
	end)
end

function var_0_0.UpdateSecondGearNewTag()
	manager.net:SendWithLoadingNew(59022, {}, 59023, function(arg_22_0)
		ActivityNoobData:SetSecondGearNewTag(false)
	end)
end

function var_0_0.UpdateBattlePassNewTag()
	manager.net:SendWithLoadingNew(59024, {}, 59025, function(arg_24_0)
		ActivityNoobData:SetBattlePassNewTag(false)
	end)
end

return var_0_0
