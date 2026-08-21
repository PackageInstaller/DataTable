local var_0_0 = singletonClass("BattleBossChallengeData")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.nextRefreshTime_ = 0
	arg_2_0.oldTime_ = 0
	arg_2_0.cacheSelectBossIndex_ = getData("BossChallenge", "bossIndex") or 1
	arg_2_0.openModeList_ = {}
	arg_2_0.selectMode_ = 0
end

function var_0_0.InitData(arg_3_0, arg_3_1)
	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 0)
	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 0)

	arg_3_0.selectMode_ = arg_3_1.mode

	if arg_3_0.nextRefreshTime_ ~= arg_3_1.next_refresh_time then
		arg_3_0.oldTime_ = arg_3_0.nextRefreshTime_ ~= 0 and arg_3_0.nextRefreshTime_ or arg_3_1.next_refresh_time
	end

	arg_3_0.nextRefreshTime_ = arg_3_1.next_refresh_time
	arg_3_0.openModeList_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.difficulty_list) do
		table.insert(arg_3_0.openModeList_, iter_3_1)
	end

	if arg_3_0.cooldownTimer_ then
		arg_3_0.cooldownTimer_:Stop()

		arg_3_0.cooldownTimer_ = nil
	end

	arg_3_0.cooldownTimer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_3_0.oldTime_ or arg_3_0.oldTime_ ~= arg_3_1.next_refresh_time then
			arg_3_0.oldTime_ = arg_3_1.next_refresh_time

			manager.notify:Invoke(BOSS_CHALLENGE_BACK_ENTRACE)
			arg_3_0.cooldownTimer_:Stop()

			arg_3_0.cooldownTimer_ = nil
		end
	end, 1, -1)

	arg_3_0.cooldownTimer_:Start()
end

function var_0_0.GetNextRefreshTime(arg_5_0)
	return arg_5_0.oldTime_
end

function var_0_0.Reset(arg_6_0)
	arg_6_0.selectMode_ = 0
end

function var_0_0.GetOpenModeList(arg_7_0)
	return arg_7_0.openModeList_
end

function var_0_0.SetSelectMode(arg_8_0, arg_8_1)
	arg_8_0.selectMode_ = arg_8_1
end

function var_0_0.GetSelectMode(arg_9_0)
	return arg_9_0.selectMode_
end

function var_0_0.GetCacheSelectBossIndex(arg_10_0)
	return arg_10_0.cacheSelectBossIndex_ or 1
end

function var_0_0.SaveCacheSelectBossIndex(arg_11_0, arg_11_1)
	saveData("BossChallenge", "bossIndex", arg_11_1)

	arg_11_0.cacheSelectBossIndex_ = arg_11_1
end

function var_0_0.GetRewardPreviewLevel(arg_12_0)
	return getData("bossChallenge", string.format("rewardPreview_", arg_12_0.oldTime_))
end

function var_0_0.SetRewardPreviewLevel(arg_13_0, arg_13_1)
	saveData("bossChallenge", string.format("rewardPreview_", arg_13_0.oldTime_), arg_13_1)
end

return var_0_0
