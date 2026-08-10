local var_0_0 = class("GotoChapterStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:GotoChapterStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.GotoChapterStage(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	local function var_2_2()
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(var_2_0) do
			local var_3_1 = ItemCfg[iter_3_1[1]]

			if var_3_1 then
				if ItemConst.ITEM_TYPE.HERO == var_3_1.type then
					table.insert(var_3_0, {
						id = iter_3_1[1]
					})
				elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == var_3_1.type and (not IllustratedData:GetExistServant(iter_3_1[1]) or var_3_1.display_rare > 3) then
					table.insert(var_3_0, {
						id = iter_3_1[1]
					})
				end
			end
		end

		manager.story:RemovePlayer()

		local function var_3_2()
			local var_4_0 = arg_2_2:GetType()
			local var_4_1 = arg_2_2:GetStageId()
			local var_4_2 = getChapterIDByStageID(var_4_1)
			local var_4_3 = StageTools.GetChapterNextStageID(var_4_2, var_4_1)
			local var_4_4 = BattleStageTools.GetStageCfg(var_4_0, var_4_1)
			local var_4_5

			if var_4_4.auto_next_stage_group ~= 0 then
				var_4_5 = BattleStageTools.GetStageCfg(var_4_0, var_4_3)
			end

			local var_4_6 = BattleStageData:GetStageData()[var_4_1]
			local var_4_7 = false

			if var_4_5 and var_4_5.auto_next_stage_group ~= 0 then
				var_4_7 = var_4_4.auto_next_stage_group == var_4_5.auto_next_stage_group
			end

			if var_4_4.auto_next_stage_group ~= 0 and var_4_7 and (BattleStageData:GetAutoNextBattle() or var_4_4.auto_next_stage_group > 10) and StageTools.HasStageCost(var_4_0, var_4_3) and not StageTools.IsLockStage(var_4_2, var_4_3) then
				if BattleConst.BATTLE_TAG.STORY == var_4_5.tag then
					BattleController.GetInstance():LaunchStoryBattle(var_4_0, var_4_3, arg_2_2:GetActivityID())
				else
					local var_4_8 = BattleStageFactory.Produce(var_4_0, var_4_3, arg_2_2:GetActivityID())

					BattleController.GetInstance():LaunchBattle(var_4_8)
				end

				return
			end

			if not manager.guide:GetIsSkipBattleResultGuide() then
				JumpTools.OpenPageByJump("/battleChapterResult", {
					result = arg_2_1,
					rewardList = var_2_0,
					stageData = arg_2_2,
					starMissionData = arg_2_3,
					battleResult = arg_2_4
				})
			end

			EndBattleLogic(arg_2_1)
		end

		if #var_3_0 > 0 then
			local var_3_3 = {
				doNextHandler = var_3_2,
				itemList = var_3_0
			}

			gameContext:Go("obtainView", var_3_3)
		else
			var_3_2()
		end
	end

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			local var_5_0 = arg_2_2:GetType()

			if var_5_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				manager.story:CheckChessBattleStory(manager.story.WIN, var_2_2)
			elseif var_5_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_5_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
				local var_5_1 = arg_2_2:GetStageId()

				manager.story:CheckBattleStory(var_5_1, manager.story.WIN, var_2_2, false)
			else
				local var_5_2 = arg_2_2:GetStageId()

				manager.story:CheckBattleStory(var_5_2, manager.story.WIN, var_2_2)
			end
		end
	else
		arg_2_0:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return var_0_0
