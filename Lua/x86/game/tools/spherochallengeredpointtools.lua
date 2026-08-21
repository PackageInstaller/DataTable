return {
	UpdataLogInRedPoint = function(arg_1_0)
		local var_1_0 = SPHeroChallengeTools:GetOpenActivityID()

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			arg_1_0:UpdataCanGetEntrustRewardRedPoint(iter_1_1)
			arg_1_0:UpdataCanGetChallengeRewardRedPoint(iter_1_1)
		end
	end,
	UpdataCanGetEntrustRewardRedPoint = function(arg_2_0, arg_2_1)
		if SPHeroChallengeTools:CheckActivityIsOpen(arg_2_1) then
			local var_2_0 = SPHeroChallengeData:GetActivityData(arg_2_1)

			if var_2_0 then
				local var_2_1 = var_2_0:GetCanGetRewardEntrustIndexList()

				if next(var_2_1) then
					manager.redPoint:setTip(RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST, 1)
				else
					manager.redPoint:setTip(RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST, 0)
				end
			end
		end
	end,
	UpdataCanGetChallengeRewardRedPoint = function(arg_3_0, arg_3_1)
		if SPHeroChallengeTools:CheckActivityIsOpen(arg_3_1) then
			local var_3_0 = SPHeroChallengeData:GetActivityData(arg_3_1)

			if var_3_0 then
				if var_3_0:CheckCanGetHeroChipTaskAward() then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_3_1), 1)
				else
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_3_1), 0)
				end
			end
		end
	end
}
