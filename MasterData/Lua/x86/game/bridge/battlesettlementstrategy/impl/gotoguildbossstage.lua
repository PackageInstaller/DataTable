local GotoGuildBossStage = class("GotoGuildBossStage", BattleSettlementStrategyBase)

GotoGuildBossStage.StageNum = {
	[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE] = 1,
	[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE] = 2
}

local var_0_1

function GotoGuildBossStage:OnGotoSettlement(arg_1_1)
	self:GotoGuildBossStage(GotoGuildBossStage.StageNum[arg_1_1.stageData:GetType()] or 1, arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoGuildBossStage:GotoGuildBossStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0, var_2_1 = GetResultReward()

	var_0_1 = GetBattleResultNeedAddHeroExp()

	if arg_2_2 + 1 ~= BattleConst.BATTLE_RESULT.QUIT then
		function BattleCallLuaCallBack()
			if not GuildData:GetBossData().initedFromServer then
				self:CheckAddExp()
				gameContext:Go("/battleScorResult", {
					stageData = arg_2_3,
					rewardList = var_2_1,
					score = 0,
					battleResult = arg_2_5
				})
				EndBattleLogic(arg_2_2)
				ShowTips("CLUB_KICK")

				return
			end

			local var_3_1 = math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
			local var_3_2, var_3_3, var_3_4 = BattleTools.GetBattleStatisticsData()

			if arg_2_1 == 1 then
				if isSuccess(arg_2_2) then
					GuildData:OnPreposeSuccess()
					self:CheckAddExp()
					gameContext:Go("/battleScorResult", {
						stageData = arg_2_3,
						rewardList = var_2_1,
						score = math.floor(GameSetting.club_boss_point_cal_pre_stage.value[1] + (1 - var_3_1 / GameSetting.club_boss_point_cal_pre_stage.value[2]) * GameSetting.club_boss_point_cal_pre_stage.value[3]),
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
					self:ClearAddExp()
					manager.story:CheckBattleStory(arg_2_3:GetStageId(), manager.story.LOSE, function()
						JumpTools.OpenPageByJump("/battlefailed", {
							stageData = arg_2_3,
							starMissionData = arg_2_4,
							battleResult = arg_2_5,
							isHalfWay_ = self.tempData.isHalfWay_
						})
						manager.story:RemovePlayer()
						EndBattleLogic(arg_2_2)
					end)
				end
			else
				self:CheckAddExp()
				CustomLog.Log(debug.traceback(string.format("公会BOSS总伤害：%s", tostring(var_3_3.damage))))

				local var_3_6 = math.floor(math.min(tonumber(tostring(var_3_3.damage)) / ClubBossIdCfg[GuildData:GetBossData().challengeInfo.boss_id].boss_hp[GuildData:GetBossDifficulty()], 1) * GameSetting.club_boss_point_cal.value[1] + ((isSuccess(arg_2_2) or nil) and (1 - var_3_1 / GameSetting.club_boss_point_cal.value[2]) * GameSetting.club_boss_point_cal.value[3]))

				GuildData:ResetBossPersonalScore(var_3_6)
				gameContext:Go("/battleScorResult", {
					stageData = arg_2_3,
					rewardList = var_2_1,
					score = var_3_6,
					battleResult = arg_2_5
				})
				EndBattleLogic(arg_2_2)
			end
		end
	else
		self:ClearAddExp()
		self:GotoBattleFaild(arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	end
end

function GotoGuildBossStage:CheckAddExp()
	if var_0_1 then
		for iter_6_0, iter_6_1 in ipairs(var_0_1) do
			HeroAction.AddHeroExpSuccess(iter_6_1.id, iter_6_1.newLv, iter_6_1.newExp)
		end

		var_0_1 = nil
	end
end

function GotoGuildBossStage:ClearAddExp()
	var_0_1 = nil
end

return GotoGuildBossStage
