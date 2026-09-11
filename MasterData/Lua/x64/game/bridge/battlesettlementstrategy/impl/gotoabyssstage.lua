local GotoAbyssStage = class("GotoAbyssStage", BattleSettlementStrategyBase)

function GotoAbyssStage:OnGotoSettlement(arg_1_1)
	local var_1_0 = arg_1_1.num
	local var_1_1 = arg_1_1.stageData
	local var_1_2 = arg_1_1.battleResult

	if isSuccess(arg_1_1.num) then
		if not arg_1_1.stageData:IsBoss() then
			AbyssData:CompleteNormalStage(arg_1_1.stageData:GetLayer(), arg_1_1.stageData:GetStageId())
		end

		self:GotoAbyssSuccess(arg_1_1.isHalfWay_, AbyssData:GetStageScore(arg_1_1.stageData:GetLayer(), arg_1_1.stageData:GetStageIndex()), arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
	elseif arg_1_1.stageData:IsBoss() then
		CheckBattleResultNeedAddHeroExp()

		local var_1_4 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas
		local var_1_5 = 0
		local var_1_6 = AbyssData:GetCurrentBossPhase()

		if var_1_4:TryGetValue(37, nil) then
			var_1_5 = var_1_4[37] or 0
		end

		if var_1_4:TryGetValue(36, nil) then
			var_1_6 = var_1_4[36] or 0
		end

		local var_1_7 = AbyssData:GetBossTotalHp(arg_1_1.stageData:GetStageId())

		if arg_1_1.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
			self:GotoAbyssBossFailed(var_1_7, var_1_7, arg_1_1.num, arg_1_1.stageData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
		else
			local var_1_8 = AbyssData:GetPhaseBossHp(arg_1_1.stageData:GetStageId(), var_1_6)

			self:GotoAbyssBossFailed(AbyssData:ConvertPhaseBossHpToTotal(arg_1_1.stageData:GetStageId(), var_1_6, AbyssData:GetStageData(arg_1_1.stageData:GetLayer(), arg_1_1.stageData:GetStageIndex()).boss_hp_rate * ((not var_1_4:TryGetValue(37, nil) or nil) and 1)), var_1_7, arg_1_1.num, arg_1_1.stageData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
		end
	else
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(var_1_1:GetStageId(), manager.story.LOSE, function()
				JumpTools.OpenPageByJump("/battlefailedWithButton", {
					stageData = var_1_1,
					battleResult = var_1_2
				})
				manager.story:RemovePlayer()
				EndBattleLogic(var_1_0)
			end)
		end
	end
end

function GotoAbyssStage:GotoAbyssBossFailed(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
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

function GotoAbyssStage:GotoAbyssSuccess(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
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

return GotoAbyssStage
