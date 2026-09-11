local GotoStage = class("GotoStage", BattleSettlementStrategyBase)

function GotoStage:Init()
	self.PreGotoFunc = {
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER] = handler(self, self.OnGotoTowerStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC] = handler(self, self.OnGotoMythicStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS] = handler(self, self.OnGotoChessStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS] = handler(self, self.OnGotoNewChessStage),
		[BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE] = handler(self, self.OnGotoPushBoxStage)
	}
end

function GotoStage:OnGotoSettlement(arg_2_1)
	local var_2_3 = arg_2_1.stageData:GetStageId()
	local var_2_4 = self.PreGotoFunc[arg_2_1.stageData:GetType()]

	if var_2_4 then
		var_2_4(arg_2_1)
	end

	self:GotoStage(arg_2_1.num, arg_2_1.stageData, arg_2_1.starMissionData, arg_2_1.battleResult)
end

function GotoStage:OnGotoTowerStage(arg_3_1)
	local var_3_0 = arg_3_1.stageData:GetStageId()

	if isSuccess(arg_3_1.num) then
		TowerData:UpdateOverTower(getChapterIDByStageID(var_3_0), var_3_0)
	end
end

function GotoStage:OnGotoMythicStage(arg_4_1)
	if isSuccess(arg_4_1.num) and not MythicData:GetIsNew() then
		MythicData:UpdatePartitionState((arg_4_1.stageData:GetDest()))
	end

	MythicAction:UpdateMythicRedTip()
end

function GotoStage:OnGotoChessStage(arg_5_1)
	if isSuccess(arg_5_1.num) then
		manager.ChessManager:BattleSuccess()
	end

	manager.ChessManager.forceBattle:BattleResult(isSuccess(arg_5_1.num))
end

function GotoStage:OnGotoNewChessStage(arg_6_1)
	if isSuccess(arg_6_1.num) then
		manager.NewChessManager:BattleSuccess()
	end
end

function GotoStage:OnGotoPushBoxStage(arg_7_1)
	return
end

function GotoStage:GotoStage(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0, var_8_1 = GetResultReward()

	local function var_8_2()
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(var_8_0) do
			if ItemCfg[iter_9_1[1]] then
				if ItemConst.ITEM_TYPE.HERO == ItemCfg[iter_9_1[1]].type then
					table.insert(var_9_0, {
						id = iter_9_1[1]
					})
				elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == ItemCfg[iter_9_1[1]].type and (not IllustratedData:GetExistServant(iter_9_1[1]) or ItemCfg[iter_9_1[1]].display_rare > 3) then
					table.insert(var_9_0, {
						id = iter_9_1[1]
					})
				end
			end
		end

		manager.story:RemovePlayer()

		local function var_9_1()
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
			gameContext:Go("obtainView", {
				doNextHandler = var_9_1,
				itemList = var_9_0
			})
		else
			var_9_1()
		end
	end

	local var_8_3 = arg_8_2:GetType()

	if isSuccess(arg_8_1) then
		function BattleCallLuaCallBack()
			if var_8_3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				manager.story:CheckChessBattleStory(manager.story.WIN, var_8_2)
			elseif var_8_3 == BattleConst.STAGE_TYPE_NEW.CHESS_BOARD then
				manager.story:CheckBattleStory(arg_8_2:GetStageId(), manager.story.WIN, var_8_2, false)
			else
				manager.story:CheckBattleStory(arg_8_2:GetStageId(), manager.story.WIN, var_8_2)
			end
		end
	elseif var_8_3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC or var_8_3 == BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL then
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(arg_8_2:GetStageId(), manager.story.LOSE, function()
				JumpTools.OpenPageByJump("/battleMythicFinalFailedView", {
					stageData = arg_8_2,
					starMissionData = arg_8_3,
					battleResult = arg_8_4,
					isHalfWay_ = self.tempData.isHalfWay_
				})
				manager.story:RemovePlayer()
				EndBattleLogic(arg_8_1)
			end)
		end
	elseif var_8_3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER then
		self:GotoBattleFaildRecommend(arg_8_1, arg_8_2, arg_8_3, arg_8_4, false)
	else
		self:GotoBattleFaild(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	end
end

return GotoStage
