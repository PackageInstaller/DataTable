local var_0_0 = class("GotoGuildActivityStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.stageData
	local var_1_1 = arg_1_1.isHalfWay_
	local var_1_2 = var_1_0:GetType()

	if var_1_1 then
		arg_1_0:GotoBattleFaild(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)

		return
	end

	if var_1_2 == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY then
		arg_1_0:GotoGuildActivity(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
	elseif var_1_2 == BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP then
		arg_1_0:GotoGuildActivitySP(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
	end
end

function var_0_0.GotoGuildActivity(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = ActivityClubCfg[arg_2_2:GetNodeId()]

	if var_2_0.type == 1 then
		if isSuccess(arg_2_1) then
			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()
				gameContext:Go("/guildActivityNodeResult", {
					isSuccess = true,
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4,
					nodeId = arg_2_2:GetNodeId()
				})
				EndBattleLogic(arg_2_1)
			end
		else
			arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		end
	elseif var_2_0.type == 2 then
		if not GuildActivityData:GetSelfNodeData(arg_2_2:GetNodeId()) then
			arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		else
			CheckBattleResultNeedAddHeroExp()

			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()
				gameContext:Go("/guildActivityNodeResult", {
					multiple = 1,
					stageData = arg_2_2,
					battleResult = arg_2_4,
					isSuccess = isSuccess(arg_2_1),
					nodeId = arg_2_2:GetNodeId()
				})
				EndBattleLogic(arg_2_1)
			end
		end
	elseif var_2_0.type == 3 then
		CheckBattleResultNeedAddHeroExp()

		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()

			local var_5_0, var_5_1 = GetResultReward()
			local var_5_2 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime
			local var_5_3 = math.floor(var_5_2)
			local var_5_4, var_5_5, var_5_6 = BattleTools.GetBattleStatisticsData()
			local var_5_7 = var_5_5.damage
			local var_5_8 = GameSetting.activity_club_point_cal.value
			local var_5_9 = var_5_8[1]
			local var_5_10 = var_5_8[2]
			local var_5_11 = var_5_8[3]
			local var_5_12 = var_2_0.boss_stage_hp
			local var_5_13 = 0

			if isSuccess(arg_2_1) then
				var_5_13 = math.max(var_5_10 - var_5_3 * var_5_11, 0)
			end

			local var_5_14 = GuildActivityData:GetUnLockAffixList()
			local var_5_15 = GuildActivityData:GetTempEffectiveAffixList()
			local var_5_16 = 0

			for iter_5_0, iter_5_1 in pairs(var_5_15) do
				for iter_5_2, iter_5_3 in ipairs(TalentTreeCfg[iter_5_0].formula_condition) do
					if iter_5_3[1] == 1 then
						var_5_16 = var_5_16 + var_5_14[iter_5_0].level * iter_5_3[2] * iter_5_1
					end
				end
			end

			local var_5_17 = tonumber(tostring(var_5_7) * 100) / (100 - var_5_16)
			local var_5_18 = math.floor(var_5_17)
			local var_5_19 = math.min(var_5_18 / var_5_12, 1) * var_5_9 + var_5_13
			local var_5_20 = math.floor(var_5_19)
			local var_5_21 = "choose"

			if isSuccess(arg_2_1) then
				var_5_21 = "score"
			elseif ActivityClubCfg.all[#ActivityClubCfg.all] == arg_2_2:GetNodeId() then
				local var_5_22 = GuildActivityData:GetNodeData(arg_2_2:GetNodeId())

				if var_5_22 and var_5_22.health <= 0 then
					var_5_21 = "score"
				end
			end

			gameContext:Go("/battleScorResult", {
				resultType = var_5_21,
				okHandler = function()
					GuildActivityAction.SaveEliteCombatResult(1)
				end,
				giveUpHandler = function()
					GuildActivityAction.SaveEliteCombatResult(0)
				end,
				stageData = arg_2_2,
				rewardList = var_5_1,
				score = var_5_20,
				battleResult = arg_2_4,
				isSuccess = isSuccess(arg_2_1),
				nodeId = arg_2_2:GetNodeId()
			})
			EndBattleLogic(arg_2_1)
		end
	end
end

function var_0_0.GotoGuildActivitySP(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = ActivityClubSPCfg[arg_8_2:GetNodeId()]

	GuildActivitySPData:SetCurrentGrid(arg_8_2:GetNodeId())

	if var_8_0.type == 1 then
		if isSuccess(arg_8_1) then
			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()

				local var_9_0, var_9_1 = GetResultReward()

				gameContext:Go("/battleMultipleResult", {
					multiple = 1,
					notOnceMore = true,
					stageData = arg_8_2,
					rewardList = var_9_1,
					battleResult = arg_8_4
				})
				EndBattleLogic(arg_8_1)
			end
		else
			arg_8_0:GotoBattleFaild(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		end
	elseif var_8_0.type == 2 then
		if not GuildActivitySPData:GetSelfNodeData(arg_8_2:GetNodeId()) then
			arg_8_0:GotoBattleFaild(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		else
			CheckBattleResultNeedAddHeroExp()

			function BattleCallLuaCallBack()
				manager.story:RemovePlayer()

				local var_10_0, var_10_1 = GetResultReward()

				if isSuccess(arg_8_1) then
					gameContext:Go("/battleMultipleResult", {
						multiple = 1,
						notOnceMore = true,
						stageData = arg_8_2,
						rewardList = var_10_1,
						battleResult = arg_8_4
					})
				else
					gameContext:Go("/guildActivitySPNodeResult", {
						multiple = 1,
						stageData = arg_8_2,
						battleResult = arg_8_4,
						isSuccess = isSuccess(arg_8_1),
						nodeId = arg_8_2:GetNodeId()
					})
				end

				EndBattleLogic(arg_8_1)
			end
		end
	elseif var_8_0.type == 3 or var_8_0.type == 4 then
		CheckBattleResultNeedAddHeroExp()

		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()

			local var_11_0, var_11_1 = GetResultReward()
			local var_11_2 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime
			local var_11_3 = math.floor(var_11_2)
			local var_11_4, var_11_5, var_11_6 = BattleTools.GetBattleStatisticsData()
			local var_11_7 = var_11_5.damage
			local var_11_8 = GuildActivitySPData:GetCurRunActivityID()
			local var_11_9

			for iter_11_0, iter_11_1 in ipairs(ActivityClubSpPointCfg.all) do
				if ActivityClubSpPointCfg[iter_11_1].activity == var_11_8 then
					var_11_9 = ActivityClubSpPointCfg[iter_11_1].boss_point_cal

					break
				end
			end

			if not var_11_9 then
				return
			end

			local var_11_10 = var_11_9[1]
			local var_11_11 = var_11_9[2]
			local var_11_12 = var_11_9[3]
			local var_11_13 = var_8_0.boss_stage_hp
			local var_11_14 = 0

			if isSuccess(arg_8_1) then
				var_11_14 = math.max(var_11_11 - var_11_3 * var_11_12, 0)
			end

			local var_11_15 = GuildActivitySPData:GetUnLockAffixList()
			local var_11_16 = GuildActivitySPData:GetTempEffectiveAffixList()
			local var_11_17 = 0

			for iter_11_2, iter_11_3 in pairs(var_11_16) do
				for iter_11_4, iter_11_5 in ipairs(TalentTreeCfg[iter_11_2].formula_condition) do
					if iter_11_5[1] == 1 then
						var_11_17 = var_11_17 + var_11_15[iter_11_2].level * iter_11_5[2] * iter_11_3
					end
				end
			end

			local var_11_18 = tonumber(tostring(var_11_7) * 100) / (100 - var_11_17)
			local var_11_19 = math.floor(var_11_18)
			local var_11_20 = math.min(var_11_19 / var_11_13, 1) * var_11_10 + var_11_14
			local var_11_21 = math.floor(var_11_20)
			local var_11_22 = "choose"

			if isSuccess(arg_8_1) then
				var_11_22 = "score"
			elseif GuildActivitySPData:GetMaxNodeId() == arg_8_2:GetNodeId() then
				local var_11_23 = GuildActivitySPData:GetNodeData(arg_8_2:GetNodeId())

				if var_11_23 and var_11_23.health <= 0 then
					var_11_22 = "score"
				end
			end

			local var_11_24 = ActivityClubSPCfg[arg_8_2:GetNodeId()]
			local var_11_25 = -1
			local var_11_26

			if #var_11_24.boss_reward_exchange > 0 then
				local var_11_27 = 1

				for iter_11_6, iter_11_7 in ipairs(var_11_24.boss_reward_exchange[1]) do
					local var_11_28 = iter_11_7[1]
					local var_11_29 = iter_11_7[2]

					if var_11_21 < var_11_28 then
						var_11_25 = var_11_24.boss_reward_exchange[1][var_11_27 - 1][2][2]
						var_11_26 = var_11_24.boss_reward_exchange[1][var_11_27 - 1][2][1]

						break
					end

					var_11_27 = var_11_27 + 1
				end

				if var_11_25 < 0 then
					var_11_25 = var_11_24.boss_reward_exchange[1][#var_11_24.boss_reward_exchange[1]][2][2]
					var_11_26 = var_11_24.boss_reward_exchange[1][#var_11_24.boss_reward_exchange[1]][2][1]
				end
			end

			gameContext:Go("/guildActivitySPBoosNodeResultView", {
				noOnceMore = true,
				resultType = var_11_22,
				okHandler = function(arg_12_0)
					if not arg_12_0 then
						GuildActivitySPAction.SaveEliteCombatResult(1)
					end
				end,
				giveUpHandler = function()
					GuildActivitySPAction.SaveEliteCombatResult(0)
				end,
				stageData = arg_8_2,
				rewardList = var_11_1,
				score = var_11_21,
				battleResult = arg_8_4,
				isSuccess = isSuccess(arg_8_1),
				nodeId = arg_8_2:GetNodeId(),
				awardNum = var_11_25,
				currencyID = var_11_26,
				condition = function()
					local var_14_0 = ActivityClubSPCfg[arg_8_2:GetNodeId()].vitality_cost
					local var_14_1 = 0

					for iter_14_0, iter_14_1 in pairs(arg_8_2:GetHeroTeam()) do
						if iter_14_1 and iter_14_1 > 0 then
							var_14_1 = var_14_1 + 1
						end
					end

					local var_14_2 = math.floor(var_14_0 / var_14_1)

					for iter_14_2, iter_14_3 in pairs(arg_8_2:GetHeroTeam()) do
						if iter_14_3 and iter_14_3 > 0 then
							local var_14_3 = GuildActivitySPData:GetFightHeroById(iter_14_3)

							if var_14_2 > GuildActivitySPData:GetHeroFatigue(iter_14_3) then
								return false, "ACTIVITY_CLUB_HERO_VITALITY_NOT_ENOUGH_TIP"
							end
						end
					end

					return true
				end
			})
			EndBattleLogic(arg_8_1)
		end
	end
end

return var_0_0
