local var_0_0 = class("GotoGuildBossStage", BattleSettlementStrategyBase)

var_0_0.StageNum = {
	[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE] = 1,
	[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE] = 2
}

local var_0_1

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.stageData:GetType()

	arg_1_0:GotoGuildBossStage(var_0_0.StageNum[var_1_0] or 1, arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoGuildBossStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0, var_2_1 = GetResultReward()

	var_0_1 = GetBattleResultNeedAddHeroExp()

	if arg_2_2 + 1 ~= BattleConst.BATTLE_RESULT.QUIT then
		function BattleCallLuaCallBack()
			local var_3_0 = 0

			if not GuildData:GetBossData().initedFromServer then
				local var_3_1 = 0

				arg_2_0:CheckAddExp()
				gameContext:Go("/battleScorResult", {
					stageData = arg_2_3,
					rewardList = var_2_1,
					score = var_3_1,
					battleResult = arg_2_5
				})
				EndBattleLogic(arg_2_2)
				ShowTips("CLUB_KICK")

				return
			end

			local var_3_2 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime
			local var_3_3 = math.floor(var_3_2)
			local var_3_4, var_3_5, var_3_6 = BattleTools.GetBattleStatisticsData()
			local var_3_7 = var_3_5.damage
			local var_3_8 = ClubBossIdCfg[GuildData:GetBossData().challengeInfo.boss_id].boss_hp[GuildData:GetBossDifficulty()]

			if arg_2_1 == 1 then
				local var_3_9 = GameSetting.club_boss_point_cal_pre_stage.value
				local var_3_10 = var_3_9[1] + (1 - var_3_3 / var_3_9[2]) * var_3_9[3]
				local var_3_11 = math.floor(var_3_10)

				if isSuccess(arg_2_2) then
					GuildData:OnPreposeSuccess()
					arg_2_0:CheckAddExp()
					gameContext:Go("/battleScorResult", {
						stageData = arg_2_3,
						rewardList = var_2_1,
						score = var_3_11,
						battleResult = arg_2_5,
						condition = function()
							if GuildData:GetBossLastTime() <= 0 then
								return false, GetTips("ERROR_BATTLE_DAILY_BATTLE_TIMES_LIMIT")
							end

							local var_4_0, var_4_1 = GuildData:GetLastTime()

							if var_4_0 ~= "prepose" then
								return false, GetTips("CLUB_BOSS_PREPOSE_FINISH_TIP")
							end

							return true, ""
						end
					})
					EndBattleLogic(arg_2_2)
				else
					arg_2_0:ClearAddExp()

					local var_3_12 = arg_2_3:GetStageId()

					manager.story:CheckBattleStory(var_3_12, manager.story.LOSE, function()
						JumpTools.OpenPageByJump("/battlefailed", {
							stageData = arg_2_3,
							starMissionData = arg_2_4,
							battleResult = arg_2_5,
							isHalfWay_ = arg_2_0.tempData.isHalfWay_
						})
						manager.story:RemovePlayer()
						EndBattleLogic(arg_2_2)
					end)
				end
			else
				arg_2_0:CheckAddExp()
				CustomLog.Log(debug.traceback(string.format("公会BOSS总伤害：%s", tostring(var_3_7))))

				local var_3_13 = GameSetting.club_boss_point_cal.value
				local var_3_14 = 0

				if isSuccess(arg_2_2) then
					var_3_14 = (1 - var_3_3 / var_3_13[2]) * var_3_13[3]
				end

				local var_3_15 = math.min(tonumber(tostring(var_3_7)) / var_3_8, 1) * var_3_13[1] + var_3_14
				local var_3_16 = math.floor(var_3_15)

				GuildData:ResetBossPersonalScore(var_3_16)
				gameContext:Go("/battleScorResult", {
					stageData = arg_2_3,
					rewardList = var_2_1,
					score = var_3_16,
					battleResult = arg_2_5
				})
				EndBattleLogic(arg_2_2)
			end
		end
	else
		arg_2_0:ClearAddExp()
		arg_2_0:GotoBattleFaild(arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	end
end

function var_0_0.CheckAddExp(arg_6_0)
	if var_0_1 then
		for iter_6_0, iter_6_1 in ipairs(var_0_1) do
			HeroAction.AddHeroExpSuccess(iter_6_1.id, iter_6_1.newLv, iter_6_1.newExp)
		end

		var_0_1 = nil
	end
end

function var_0_0.ClearAddExp(arg_7_0)
	var_0_1 = nil
end

return var_0_0
