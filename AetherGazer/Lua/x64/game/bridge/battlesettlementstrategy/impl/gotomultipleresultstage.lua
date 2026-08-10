local var_0_0 = class("GotoMultipleResultStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.stageData

	if var_1_0:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL and isSuccess(arg_1_1.num) then
		local var_1_1 = var_1_0:GetDest()
		local var_1_2 = ActivityPtRouletteStageCfg[var_1_1].cost[1]

		if var_1_2 and var_1_2 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
			-- block empty
		else
			ActivityPtScrollData:AddClearTime(var_1_0:GetActivityID(), var_1_0:GetMultiple())
		end

		ActivityPtScrollData:SetClearList(var_1_0:GetActivityID(), var_1_0:GetStageId())
	end

	arg_1_0:GotoMultipleResult(arg_1_1.num, var_1_0, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function var_0_0.GotoMultipleResult(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_5 == true then
		arg_2_1 = 3
	end

	local var_2_0, var_2_1, var_2_2 = GetResultReward()

	if isSuccess(arg_2_1) or not arg_2_5 and arg_2_4.challengedNumber >= 1 then
		local var_2_3 = arg_2_2:GetType()

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == var_2_3 then
			BattleEquipAction.CaculateGuaranteeNum(arg_2_2:GetStageId(), var_2_1)
		end

		function BattleCallLuaCallBack()
			gameContext:Go("/battleMultipleResult", {
				stageData = arg_2_2,
				rewardList = var_2_1,
				extraReward = var_2_2,
				multiple = arg_2_4.challengedNumber or 0,
				battleResult = arg_2_4
			})
			EndBattleLogic(arg_2_1)
		end
	else
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return var_0_0
