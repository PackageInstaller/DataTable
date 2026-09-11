local GotoSeaWarfareStage = class("GotoSeaWarfareStage", BattleSettlementStrategyBase)

function GotoSeaWarfareStage:OnGotoSettlement(arg_1_1)
	LuaHidTools.ForceSelectKeyboard(nil)

	local var_1_0 = arg_1_1.num
	local var_1_1 = isSuccess(arg_1_1.num)
	local var_1_2 = arg_1_1.stageData

	if var_1_1 then
		local var_1_3 = arg_1_1.stageData:GetSeaWarfareStageID()

		if not SeaWarfareTools.IsStageCompleted(var_1_3) then
			SeaWarfareData:SetStageCompleted(var_1_3)

			if SeaWarfareStageCfg[var_1_3].reward ~= 0 then
				SeaWarfareTools.SetNeedPopFirstRewardStageID(var_1_3)
			end

			if SeaWarfareStageCfg[var_1_3].type == SeaWarfareConst.STAGE_TYPE.CHALLENGE then
				SeaWarfareTools.SetNeedFirstCompleteAnimStageID(var_1_3)

				local var_1_4 = SeaWarfareTools.GetStageIDList(SeaWarfareConst.STAGE_TYPE.CHALLENGE)
				local var_1_5 = table.indexof(var_1_4, var_1_3)

				if var_1_5 + 1 <= #var_1_4 then
					SeaWarfareTools.SetNeedFirstUnlockAnimStageID(var_1_4[var_1_5 + 1])
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

return GotoSeaWarfareStage
