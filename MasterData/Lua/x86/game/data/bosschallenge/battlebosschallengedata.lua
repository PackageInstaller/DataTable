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

function var_0_0:InitData(arg_3_1)
	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 0)
	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 0)

	self.selectMode_ = arg_3_1.mode

	if self.nextRefreshTime_ ~= arg_3_1.next_refresh_time then
		if self.nextRefreshTime_ ~= 0 then
			self.oldTime_ = self.nextRefreshTime_ or arg_3_1.next_refresh_time
		end
	end

	self.nextRefreshTime_ = arg_3_1.next_refresh_time
	self.openModeList_ = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.difficulty_list) do
		table.insert(self.openModeList_, iter_3_1)
	end

	if self.cooldownTimer_ then
		self.cooldownTimer_:Stop()

		self.cooldownTimer_ = nil
	end

	self.cooldownTimer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.oldTime_ or self.oldTime_ ~= arg_3_1.next_refresh_time then
			self.oldTime_ = arg_3_1.next_refresh_time

			manager.notify:Invoke(BOSS_CHALLENGE_BACK_ENTRACE)
			self.cooldownTimer_:Stop()

			self.cooldownTimer_ = nil
		end
	end, 1, -1)

	self.cooldownTimer_:Start()
end

function var_0_0:GetNextRefreshTime()
	return self.oldTime_
end

function var_0_0.Reset(arg_6_0)
	arg_6_0.selectMode_ = 0
end

function var_0_0:GetOpenModeList()
	return self.openModeList_
end

function var_0_0.SetSelectMode(arg_8_0, arg_8_1)
	arg_8_0.selectMode_ = arg_8_1
end

function var_0_0:GetSelectMode()
	return self.selectMode_
end

function var_0_0:GetCacheSelectBossIndex()
	return self.cacheSelectBossIndex_ or 1
end

function var_0_0.SaveCacheSelectBossIndex(arg_11_0, arg_11_1)
	saveData("BossChallenge", "bossIndex", arg_11_1)

	arg_11_0.cacheSelectBossIndex_ = arg_11_1
end

function var_0_0:GetRewardPreviewLevel()
	return getData("bossChallenge", string.format("rewardPreview_", self.oldTime_))
end

function var_0_0:SetRewardPreviewLevel(arg_13_1)
	saveData("bossChallenge", string.format("rewardPreview_", self.oldTime_), arg_13_1)
end

return var_0_0
