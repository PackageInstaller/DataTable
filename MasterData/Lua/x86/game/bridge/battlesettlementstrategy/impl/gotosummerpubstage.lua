local GotoSummerPubStage = class("GotoSummerPubStage", BattleSettlementStrategyBase)

function GotoSummerPubStage:OnGotoSettlement(arg_1_1)
	self:GotoSummerStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoSummerPubStage:GotoSummerStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, function()
				manager.story:RemovePlayer()

				local var_4_0 = arg_2_2:GetDest()

				SummerPubData:PassLevel(var_4_0)

				if var_4_0 == SummerPubConst.THIRD_LEVEL_ID and SummerPubData:GetClearNumByStageID(var_4_0, nil) == 1 then
					DestroyLua()
					LuaExchangeHelper.GoToMain()
					OpenPageUntilLoaded("/summerPubEnterView")
				else
					local var_4_1 = {}

					if SummerPubData:GetClearNumByStageID(var_4_0) <= 1 then
						if SummerPubData:GetClearNumByStageID(var_4_0, SummerPubConst.PIN_BALL_STAGE_TYPE.NORMAL) > 0 then
							-- block empty
						end

						var_4_1 = getRewardFromDropCfg(SummerPubLevelCfg[var_4_0].drop_lib_id, true)
					end

					JumpTools.OpenPageByJump("/newSettlement", {
						result = arg_2_1,
						rewardList = unformatRewardCfgList(var_4_1),
						stageData = arg_2_2,
						battleResult = arg_2_4
					})
				end

				EndBattleLogic(arg_2_1)
			end, false)
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoSummerPubStage
