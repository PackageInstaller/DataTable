local var_0_0 = class("GotoAbyssStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.starMissionData
	local var_1_3 = arg_1_1.battleResult
	local var_1_4 = 1

	if isSuccess(var_1_0) then
		if not var_1_1:IsBoss() then
			AbyssData:CompleteNormalStage(var_1_1:GetLayer(), var_1_1:GetStageId())
		end

		local var_1_5 = AbyssData:GetStageScore(var_1_1:GetLayer(), var_1_1:GetStageIndex())

		arg_1_0:GotoAbyssSuccess(arg_1_1.isHalfWay_, var_1_5, var_1_0, var_1_1, var_1_2, var_1_3)
	elseif var_1_1:IsBoss() then
		CheckBattleResultNeedAddHeroExp()

		local var_1_6 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas
		local var_1_7
		local var_1_8 = 0
		local var_1_9 = AbyssData:GetCurrentBossPhase()

		if var_1_6:TryGetValue(37, var_1_7) then
			var_1_8 = var_1_6[37] or 0
		end

		if var_1_6:TryGetValue(36, var_1_7) then
			var_1_9 = var_1_6[36] or 0
		end

		local var_1_10 = AbyssData:GetBossTotalHp(var_1_1:GetStageId())

		if var_1_3.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
			arg_1_0:GotoAbyssBossFailed(var_1_10, var_1_10, var_1_0, var_1_1, var_1_3, arg_1_1.isHalfWay_)
		else
			local var_1_11 = AbyssData:GetPhaseBossHp(var_1_1:GetStageId(), var_1_9)
			local var_1_12 = AbyssData:GetStageData(var_1_1:GetLayer(), var_1_1:GetStageIndex())
			local var_1_13 = var_1_8 / (var_1_11 * var_1_12.boss_hp_rate / 1000)

			if not var_1_6:TryGetValue(37, var_1_7) then
				var_1_13 = 1
			end

			local var_1_14 = AbyssData:ConvertPhaseBossHpToTotal(var_1_1:GetStageId(), var_1_9, var_1_12.boss_hp_rate * var_1_13)

			arg_1_0:GotoAbyssBossFailed(var_1_14, var_1_10, var_1_0, var_1_1, var_1_3, arg_1_1.isHalfWay_)
		end
	else
		function BattleCallLuaCallBack()
			local var_2_0 = var_1_1:GetStageId()

			manager.story:CheckBattleStory(var_2_0, manager.story.LOSE, function()
				JumpTools.OpenPageByJump("/battlefailedWithButton", {
					stageData = var_1_1,
					battleResult = var_1_3
				})
				manager.story:RemovePlayer()
				EndBattleLogic(var_1_0)
			end)
		end
	end
end

function var_0_0.GotoAbyssBossFailed(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if arg_4_6 == true then
		arg_4_3 = 3
	end

	function BattleCallLuaCallBack()
		manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.awb")
		gameContext:Go("/abyssBattleResult", {
			resultType = "choose",
			scoreType = "hp",
			stageData = arg_4_4,
			hp = arg_4_1,
			totalHp = arg_4_2,
			battleResult = arg_4_5,
			title = GetTips("ABYSS_BATTLE_FAIL_TIP"),
			okHandler = function()
				AbyssAction.ClearTeamCache(arg_4_4:GetStageId())
				AbyssAction.SaveProgress(arg_4_4:GetStageId(), true)
				AbyssTools.SetLayerBossTeamCacheFlag(arg_4_4:GetLayer(), arg_4_4:GetStageIndex(), false)
			end,
			giveUpHandler = function()
				AbyssAction.SaveProgress(arg_4_4:GetStageId(), false)
			end
		})
		EndBattleLogic(arg_4_3)
	end
end

function var_0_0.GotoAbyssSuccess(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	if arg_8_1 == true then
		arg_8_3 = 3
	end

	local var_8_0, var_8_1 = GetResultReward()

	if isSuccess(arg_8_3) then
		function BattleCallLuaCallBack()
			gameContext:Go("/abyssBattleResult", {
				stageData = arg_8_4,
				rewardList = var_8_1,
				score = arg_8_2,
				battleResult = arg_8_6
			})
			EndBattleLogic(arg_8_3)
		end
	end
end

return var_0_0
