local var_0_0 = class("GotoStage", BattleSettlementStrategyBase)

function var_0_0.Init(arg_1_0)
	arg_1_0.PreGotoFunc = {
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER] = handler(arg_1_0, arg_1_0.OnGotoTowerStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC] = handler(arg_1_0, arg_1_0.OnGotoMythicStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS] = handler(arg_1_0, arg_1_0.OnGotoChessStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS] = handler(arg_1_0, arg_1_0.OnGotoNewChessStage),
		[BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE] = handler(arg_1_0, arg_1_0.OnGotoPushBoxStage)
	}
end

function var_0_0.OnGotoSettlement(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.num
	local var_2_1 = arg_2_1.stageData
	local var_2_2 = arg_2_1.starMissionData
	local var_2_3 = arg_2_1.battleResult
	local var_2_4 = var_2_1:GetType()
	local var_2_5 = var_2_1:GetStageId()
	local var_2_6 = arg_2_0.PreGotoFunc[var_2_4]

	if var_2_6 then
		var_2_6(arg_2_1)
	end

	arg_2_0:GotoStage(arg_2_1.num, arg_2_1.stageData, arg_2_1.starMissionData, arg_2_1.battleResult)
end

function var_0_0.OnGotoTowerStage(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.num
	local var_3_1 = arg_3_1.stageData:GetStageId()

	if isSuccess(var_3_0) then
		local var_3_2 = getChapterIDByStageID(var_3_1)

		TowerData:UpdateOverTower(var_3_2, var_3_1)
	end
end

function var_0_0.OnGotoMythicStage(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.num
	local var_4_1 = arg_4_1.stageData

	if isSuccess(var_4_0) and not MythicData:GetIsNew() then
		local var_4_2 = var_4_1:GetDest()

		MythicData:UpdatePartitionState(var_4_2)
	end

	MythicAction:UpdateMythicRedTip()
end

function var_0_0.OnGotoChessStage(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.num
	local var_5_1 = arg_5_1.stageData

	if isSuccess(var_5_0) then
		manager.ChessManager:BattleSuccess()
	end

	manager.ChessManager.forceBattle:BattleResult(isSuccess(var_5_0))
end

function var_0_0.OnGotoNewChessStage(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.num
	local var_6_1 = arg_6_1.stageData

	if isSuccess(var_6_0) then
		manager.NewChessManager:BattleSuccess()
	end
end

function var_0_0.OnGotoPushBoxStage(arg_7_0, arg_7_1)
	return
end

function var_0_0.GotoStage(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0, var_8_1 = GetResultReward()

	local function var_8_2()
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(var_8_0) do
			local var_9_1 = ItemCfg[iter_9_1[1]]

			if var_9_1 then
				if ItemConst.ITEM_TYPE.HERO == var_9_1.type then
					table.insert(var_9_0, {
						id = iter_9_1[1]
					})
				elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == var_9_1.type and (not IllustratedData:GetExistServant(iter_9_1[1]) or var_9_1.display_rare > 3) then
					table.insert(var_9_0, {
						id = iter_9_1[1]
					})
				end
			end
		end

		manager.story:RemovePlayer()

		local function var_9_2()
			JumpTools.OpenPageByJump("/newSettlement", {
				result = arg_8_1,
				rewardList = var_8_0,
				stageData = arg_8_2,
				starMissionData = arg_8_3,
				battleResult = arg_8_4
			})
			EndBattleLogic(arg_8_1)
		end

		if #var_9_0 > 0 then
			local var_9_3 = {
				doNextHandler = var_9_2,
				itemList = var_9_0
			}

			gameContext:Go("obtainView", var_9_3)
		else
			var_9_2()
		end
	end

	local var_8_3 = arg_8_2:GetType()

	if isSuccess(arg_8_1) then
		function BattleCallLuaCallBack()
			if var_8_3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				manager.story:CheckChessBattleStory(manager.story.WIN, var_8_2)
			elseif var_8_3 == BattleConst.STAGE_TYPE_NEW.CHESS_BOARD then
				local var_11_0 = arg_8_2:GetStageId()

				manager.story:CheckBattleStory(var_11_0, manager.story.WIN, var_8_2, false)
			else
				local var_11_1 = arg_8_2:GetStageId()

				manager.story:CheckBattleStory(var_11_1, manager.story.WIN, var_8_2)
			end
		end
	elseif var_8_3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC or var_8_3 == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
		function BattleCallLuaCallBack()
			local var_12_0 = arg_8_2:GetStageId()

			manager.story:CheckBattleStory(var_12_0, manager.story.LOSE, function()
				JumpTools.OpenPageByJump("/battleMythicFinalFailedView", {
					stageData = arg_8_2,
					starMissionData = arg_8_3,
					battleResult = arg_8_4,
					isHalfWay_ = arg_8_0.tempData.isHalfWay_
				})
				manager.story:RemovePlayer()
				EndBattleLogic(arg_8_1)
			end)
		end
	elseif var_8_3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER then
		local var_8_4 = false

		arg_8_0:GotoBattleFaildRecommend(arg_8_1, arg_8_2, arg_8_3, arg_8_4, var_8_4)
	else
		arg_8_0:GotoBattleFaild(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	end
end

return var_0_0
