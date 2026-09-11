local GotoChapterStage = class("GotoChapterStage", BattleSettlementStrategyBase)

function GotoChapterStage:OnGotoSettlement(arg_1_1)
	self:GotoChapterStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function GotoChapterStage:GotoChapterStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	local function var_2_2()
		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(var_2_0) do
			if ItemCfg[iter_3_1[1]] then
				if ItemConst.ITEM_TYPE.HERO == ItemCfg[iter_3_1[1]].type then
					table.insert(var_3_0, {
						id = iter_3_1[1]
					})
				elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == ItemCfg[iter_3_1[1]].type and (not IllustratedData:GetExistServant(iter_3_1[1]) or ItemCfg[iter_3_1[1]].display_rare > 3) then
					table.insert(var_3_0, {
						id = iter_3_1[1]
					})
				end
			end
		end

		manager.story:RemovePlayer()

		local function var_3_1()
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

			if var_4_4.auto_next_stage_group ~= 0 and (var_4_5 and var_4_5.auto_next_stage_group ~= 0 or nil) and var_4_4.auto_next_stage_group == var_4_5.auto_next_stage_group and (BattleStageData:GetAutoNextBattle() or var_4_4.auto_next_stage_group > 10) and StageTools.HasStageCost(var_4_0, var_4_3) and not StageTools.IsLockStage(var_4_2, var_4_3) then
				if BattleConst.BATTLE_TAG.STORY == var_4_5.tag then
					BattleController.GetInstance():LaunchStoryBattle(var_4_0, var_4_3, arg_2_2:GetActivityID())
				else
					BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(var_4_0, var_4_3, arg_2_2:GetActivityID())))
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
			gameContext:Go("obtainView", {
				doNextHandler = var_3_1,
				itemList = var_3_0
			})
		else
			var_3_1()
		end
	end

	if isSuccess(arg_2_1) then
		function BattleCallLuaCallBack()
			local var_5_0 = arg_2_2:GetType()

			if var_5_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				manager.story:CheckChessBattleStory(manager.story.WIN, var_2_2)
			elseif var_5_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_5_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
				manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, var_2_2, false)
			else
				manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, var_2_2)
			end
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoChapterStage
