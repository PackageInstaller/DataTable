local var_0_0 = class("GotoAreaBattleStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoAreaBattleStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoAreaBattleStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = arg_2_2.reserveParams_.customData.difficult
	local var_2_1 = arg_2_2:GetActivityID()
	local var_2_2 = ActivityAreaBattleCfg[var_2_1]
	local var_2_3 = false

	for iter_2_0, iter_2_1 in ipairs(var_2_2.stage_id[var_2_0]) do
		if iter_2_1 == arg_2_2:GetStageId() and iter_2_0 == #var_2_2.stage_id[var_2_0] then
			var_2_3 = true
		end
	end

	if isSuccess(arg_2_1) then
		if var_2_3 then
			arg_2_0:GotoAreaBattleSuccess(arg_2_5, 0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
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
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2)
	end
end

function var_0_0.GotoAreaBattleSuccess(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
	if arg_4_1 == true then
		arg_4_3 = 3
	end

	if isSuccess(arg_4_3) then
		function BattleCallLuaCallBack()
			local var_5_0 = arg_4_4:GetActivityID()
			local var_5_1 = ActivityCfg.get_id_list_by_sub_activity_list[var_5_0][1]
			local var_5_2 = ActivityAreaBattleData:GetDataByActivityID(var_5_1)[var_5_0]

			gameContext:Go("/battleScorResult", {
				stageData = arg_4_4,
				battleResult = arg_4_6,
				score = var_5_2.challengeValue
			})
			EndBattleLogic(arg_4_3)
		end
	end
end

return var_0_0
