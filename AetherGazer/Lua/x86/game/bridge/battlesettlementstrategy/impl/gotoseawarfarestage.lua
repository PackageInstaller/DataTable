local var_0_0 = class("GotoSeaWarfareStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	LuaHidTools.ForceSelectKeyboard(nil)

	local var_1_0 = arg_1_1.num
	local var_1_1 = isSuccess(var_1_0)
	local var_1_2 = arg_1_1.stageData

	if var_1_1 then
		local var_1_3 = var_1_2:GetSeaWarfareStageID()

		if not SeaWarfareTools.IsStageCompleted(var_1_3) then
			SeaWarfareData:SetStageCompleted(var_1_3)

			local var_1_4 = SeaWarfareStageCfg[var_1_3]

			if var_1_4.reward ~= 0 then
				SeaWarfareTools.SetNeedPopFirstRewardStageID(var_1_3)
			end

			if var_1_4.type == SeaWarfareConst.STAGE_TYPE.CHALLENGE then
				SeaWarfareTools.SetNeedFirstCompleteAnimStageID(var_1_3)

				local var_1_5 = SeaWarfareTools.GetStageIDList(SeaWarfareConst.STAGE_TYPE.CHALLENGE)
				local var_1_6 = table.indexof(var_1_5, var_1_3)

				if var_1_6 + 1 <= #var_1_5 then
					SeaWarfareTools.SetNeedFirstUnlockAnimStageID(var_1_5[var_1_6 + 1])
				end
			end
		end
	end

	CheckBattleResultNeedAddHeroExp()

	function BattleCallLuaCallBack()
		JumpTools.OpenPageByJump("battleSeaWarfareResult", {
			stageData = var_1_2,
			isSuccess = var_1_1
		})
		manager.story:RemovePlayer()
		EndBattleLogic(var_1_0)
	end
end

return var_0_0
