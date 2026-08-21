manager.net:Bind(45201, function(arg_1_0)
	BattleBossChallengeData:InitData(arg_1_0)
end)
manager.net:Bind(45001, function(arg_2_0)
	BattleBossChallengeNormalData:InitData(arg_2_0)
	manager.notify:Invoke(BOSS_CHALLENGE_UPDATE)
end)
manager.net:Bind(45003, function(arg_3_0)
	BattleBossChallengeNormalData:SetUsedCnt(arg_3_0.use_times)
	manager.notify:Invoke(BOSS_CHALLENGE_UPDATE_CHALLENGE_CNT)
end)
manager.net:Bind(45101, function(arg_4_0)
	BattleBossChallengeAdvanceData:InitData(arg_4_0)
end)

return {
	RequireBossChallengeData = function(arg_5_0, arg_5_1)
		manager.net:SendWithLoadingNew(45202, {
			select = arg_5_0
		}, 45203, function(arg_6_0)
			if isSuccess(arg_6_0.result) then
				arg_5_1()
			else
				ShowTips(arg_6_0.result)
			end
		end)
	end,
	ResetHardMode = function(arg_7_0)
		manager.net:SendWithLoadingNew(45204, {}, 45205, function(arg_8_0)
			BattleBossChallengeAdvanceData:Init()
			BattleBossChallengeData:Reset()
			arg_7_0(arg_8_0)
		end)
	end,
	ResetNormalModeBoss = function(arg_9_0, arg_9_1)
		local var_9_0 = BattleBossChallengeNormalData:GetBossList()[arg_9_0]

		manager.net:SendWithLoadingNew(45006, {
			group_id = var_9_0
		}, 45007, function(arg_10_0)
			BattleBossChallengeNormalData:ResetBoss(arg_9_0)
			arg_9_1(arg_10_0)
		end)
	end,
	ResetHardModeBoss = function(arg_11_0, arg_11_1)
		local var_11_0 = BattleBossChallengeAdvanceData:GetBossList()[arg_11_0].id

		manager.net:SendWithLoadingNew(45106, {
			boss_id = var_11_0
		}, 45107, function(arg_12_0)
			BattleBossChallengeAdvanceData:ResetBoss(arg_11_0)
			arg_11_1(arg_12_0)
		end)
	end,
	ChangeBossHeroTeam = function(arg_13_0, arg_13_1)
		if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NORMAL then
			local var_13_0 = BattleBossChallengeNormalData:GetBossList()[arg_13_0]

			BattleBossChallengeNormalData:SetCacheHeroTeam(arg_13_0, arg_13_1)
			manager.net:SendWithLoadingNew(45110, {
				group_id = var_13_0,
				heroes_cfg = arg_13_1
			}, 45111, function(arg_14_0)
				return
			end)
		else
			local var_13_1 = BattleBossChallengeAdvanceData:GetBossList()[arg_13_0].id

			BattleBossChallengeAdvanceData:SetCacheHeroTeam(arg_13_0, arg_13_1)
			manager.net:SendWithLoadingNew(45108, {
				id = var_13_1,
				heroes_cfg = arg_13_1
			}, 45109, function(arg_15_0)
				return
			end)
		end
	end,
	RequireBossExchange = function(arg_16_0, arg_16_1)
		manager.net:SendWithLoadingNew(45004, {
			star = arg_16_0
		}, 45005, function(arg_17_0)
			arg_16_1(arg_17_0)
		end)
	end,
	ClientModifyThreeStar = function(arg_18_0, arg_18_1)
		BattleBossChallengeNormalData:ClientModifyThreeStar(arg_18_0, arg_18_1)
	end,
	RequireBossPointExchange = function(arg_19_0, arg_19_1)
		manager.net:SendWithLoadingNew(45102, {
			point = arg_19_0
		}, 45103, function(arg_20_0)
			arg_19_1(arg_20_0)
		end)
	end,
	RequireAllBossPointExchange = function(arg_21_0)
		manager.net:SendWithLoadingNew(45112, {}, 45113, function(arg_22_0)
			arg_21_0(arg_22_0)
		end)
	end,
	ModifySelectAffix = function(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		manager.net:SendWithLoadingNew(45104, {
			id = arg_23_0,
			affix_index_list = arg_23_3,
			time_index_list = arg_23_2,
			diffculty_index = arg_23_1
		}, 45105, function(arg_24_0)
			arg_23_4(arg_24_0)
		end)
	end,
	BossChallengeBackEntrace = function()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_REFRESH_DATA"),
			OkCallback = function()
				if #BattleBossChallengeData:GetOpenModeList() >= 2 then
					gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
					gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
					gameContext:Go("/bossMode")
				else
					gameContext:Go("/bossSwitch")
				end
			end,
			MaskCallback = function()
				if #BattleBossChallengeData:GetOpenModeList() >= 2 then
					gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
					gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
					gameContext:Go("/bossMode")
				else
					gameContext:Go("/bossSwitch")
				end
			end
		})
	end,
	EnterBossChallenge = function()
		local var_28_0 = BattleBossChallengeData:GetSelectMode()

		if var_28_0 == BossConst.MODE_NONE then
			if #BattleBossChallengeData:GetOpenModeList() >= 2 then
				JumpTools.GoToSystem("/bossMode", {}, ViewConst.SYSTEM_ID.BOSS_CHALLENGE)
			else
				JumpTools.GoToSystem("/bossSwitch", {}, ViewConst.SYSTEM_ID.BOSS_CHALLENGE)
			end
		elseif var_28_0 == BossConst.MODE_NORMAL then
			JumpTools.GoToSystem("/bossSwitch", {}, ViewConst.SYSTEM_ID.BOSS_CHALLENGE)
		else
			JumpTools.GoToSystem("/bossAdvanceSwitch", {}, ViewConst.SYSTEM_ID.BOSS_CHALLENGE)
		end
	end
}
