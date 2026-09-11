local GotoMultipleResultStage = class("GotoMultipleResultStage", BattleSettlementStrategyBase)

function GotoMultipleResultStage:OnGotoSettlement(arg_1_1)
	if arg_1_1.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL and isSuccess(arg_1_1.num) then
		local var_1_0 = ActivityPtRouletteStageCfg[arg_1_1.stageData:GetDest()].cost[1]

		if var_1_0 and var_1_0 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
			-- block empty
		else
			ActivityPtScrollData:AddClearTime(arg_1_1.stageData:GetActivityID(), arg_1_1.stageData:GetMultiple())
		end

		ActivityPtScrollData:SetClearList(arg_1_1.stageData:GetActivityID(), arg_1_1.stageData:GetStageId())
	end

	self:GotoMultipleResult(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoMultipleResultStage:GotoMultipleResult(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if arg_2_5 == true then
		arg_2_1 = 3
	end

	local var_2_0, var_2_1, var_2_2 = GetResultReward()

	if isSuccess(arg_2_1) or not arg_2_5 and arg_2_4.challengedNumber >= 1 then
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == arg_2_2:GetType() then
			BattleEquipAction.CaculateGuaranteeNum(arg_2_2:GetStageId(), var_2_1)
		end

		function BattleCallLuaCallBack()
			local var_3_0 = {
				stageData = arg_2_2,
				rewardList = var_2_1,
				extraReward = var_2_2
			}

			var_3_0.multiple = arg_2_4.challengedNumber or 0
			var_3_0.battleResult = arg_2_4

			gameContext:Go("/battleMultipleResult", var_3_0)
			EndBattleLogic(arg_2_1)
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoMultipleResultStage
