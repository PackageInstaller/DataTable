local GotoAreaBattleStage = class("GotoAreaBattleStage", BattleSettlementStrategyBase)

function GotoAreaBattleStage:OnGotoSettlement(arg_1_1)
	self:GotoAreaBattleStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoAreaBattleStage:GotoAreaBattleStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = ActivityAreaBattleCfg[arg_2_2:GetActivityID()]
	local var_2_1 = false

	for iter_2_0, iter_2_1 in ipairs(var_2_0.stage_id[arg_2_2.reserveParams_.customData.difficult]) do
		if iter_2_1 == arg_2_2:GetStageId() and iter_2_0 == #var_2_0.stage_id[arg_2_2.reserveParams_.customData.difficult] then
			var_2_1 = true
		end
	end

	if isSuccess(arg_2_1) then
		if var_2_1 then
			self:GotoAreaBattleSuccess(arg_2_5, 0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		elseif isSuccess(arg_2_1) then
			function BattleCallLuaCallBack()
				JumpTools.OpenPageByJump("/areaBattleSettlement", {
					result = arg_2_1,
					stageData = arg_2_2,
					starMissionData = arg_2_3,
					battleResult = arg_2_4
				})
				EndBattleLogic(arg_2_1)
			end
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2)
	end
end

function GotoAreaBattleStage:GotoAreaBattleSuccess(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	if arg_4_1 == true then
		arg_4_3 = 3
	end

	if isSuccess(arg_4_3) then
		function BattleCallLuaCallBack()
			local var_5_0 = arg_4_4:GetActivityID()

			gameContext:Go("/battleScorResult", {
				stageData = arg_4_4,
				battleResult = arg_4_6,
				score = ActivityAreaBattleData:GetDataByActivityID(ActivityCfg.get_id_list_by_sub_activity_list[var_5_0][1])[var_5_0].challengeValue
			})
			EndBattleLogic(arg_4_3)
		end
	end
end

return GotoAreaBattleStage
