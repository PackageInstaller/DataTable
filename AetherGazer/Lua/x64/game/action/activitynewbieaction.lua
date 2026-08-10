local var_0_0 = {}
local var_0_1 = false

manager.net:Bind(59001, function(arg_1_0)
	var_0_1 = true

	ActivityNewbieData:InitData(arg_1_0)
	var_0_0.PlayerUpgradeRedPoint()
	ActivityNewbieTools.RefreshFirstRechargeRedPoint()
	ActivityNewbieTools.RefreshMonthlyCardRedPoint()
	ActivityNewbieTools.RefreshBpRedPoint()
	ActivityNewbieTools.RefreshAdvanceTaskRedPoint()
end)
manager.net:Bind(59009, function(arg_2_0)
	if var_0_1 == true then
		ActivityNewbieData:UpdateRecharge(arg_2_0.newbie_recharge_reward)
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
	local var_4_1 = ActivityNewbieData:GetUpgradeFinishList()

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

function var_0_0.NewbieSignIn(arg_5_0)
	manager.net:SendWithLoadingNew(59002, {}, 59003, function(arg_6_0)
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

return var_0_0
