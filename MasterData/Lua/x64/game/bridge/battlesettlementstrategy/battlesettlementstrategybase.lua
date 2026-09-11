local BattleSettlementStrategyBase = class("BattleSettlementStrategyBase")

function BattleSettlementStrategyBase:BuildTempData(arg_1_1)
	self.tempData = {
		isHalfWay_ = arg_1_1.isHalfWay_
	}
end

function BattleSettlementStrategyBase:GotoSettlement(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self:BuildTempData({
		isHalfWay_ = arg_2_5
	})

	local var_2_0 = {}
	local var_2_1 = arg_2_1:GetThreeStar()

	if var_2_1 and type(var_2_1) == "table" then
		for iter_2_0 = 1, #var_2_1 do
			local var_2_2 = var_2_1[iter_2_0]

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == arg_2_1:GetType() then
				if arg_2_3 and arg_2_3[iter_2_0] then
					table.insert(var_2_0, {
						id = var_2_2[1],
						total = arg_2_3[iter_2_0].need_progress,
						current = arg_2_3[iter_2_0].now_progress,
						xData = var_2_2[2],
						yData = var_2_2[3],
						isComplete = arg_2_3[iter_2_0].is_achieve == 1 and true or false
					})

					if arg_2_3[iter_2_0].is_achieve == 1 and (isSuccess(arg_2_2) or var_2_2[1] == 15 or var_2_2[1] == 16) then
						MythicData:UpdateStarIndex(iter_2_0)
					end
				end
			elseif arg_2_3 and arg_2_3[iter_2_0] then
				table.insert(var_2_0, {
					id = var_2_2[1],
					total = arg_2_3[iter_2_0].need_progress,
					current = arg_2_3[iter_2_0].now_progress,
					xData = var_2_2[2],
					yData = var_2_2[3],
					isComplete = arg_2_3[iter_2_0].is_achieve == 1 and true or false
				})
			end
		end
	end

	if isSuccess(arg_2_2) and isSuccess(arg_2_4.errorCode) then
		local var_2_3, var_2_4 = arg_2_1:GetHeroTeam()
		local var_2_5 = arg_2_1:GetSystemHeroTeam()
		local var_2_6 = arg_2_1:GetAssistHeroOwnerList()
		local var_2_7 = arg_2_1:GetMultiple()
		local var_2_8 = arg_2_4.clear_times * GameSetting.mastery_gain.value[1]

		for iter_2_1 = 1, #var_2_3 do
			if arg_2_1:GetHeroDataByPos(iter_2_1) and not var_2_5[iter_2_1] and (var_2_4[iter_2_1] == 0 or table.isEmpty(var_2_4)) and (var_2_6 and (var_2_6[iter_2_1] == "0" or var_2_6[iter_2_1] ~= "0" and var_2_6[iter_2_1] == PlayerData:GetPlayerInfo().userID) or table.isEmpty(var_2_6)) then
				HeroData:HeroClearTimesModify(var_2_3[iter_2_1], var_2_8)
				ArchiveData:AddExp(HeroTools.GetHeroOntologyID(var_2_3[iter_2_1]), GameSetting.hero_love_exp_gain.value[1] * var_2_7)
			end
		end

		HeroAction.UpdateHeartRedPoint()
		HeroAction.UpdateStoryRedPoint()
		HeroAction.UpdateSuperStoryRedPoint()
	end

	self:OnGotoSettlement({
		num = arg_2_2,
		starList = arg_2_3,
		battleResult = arg_2_4,
		stageData = arg_2_1,
		starMissionData = var_2_0,
		isHalfWay_ = arg_2_5
	})
end

function BattleSettlementStrategyBase:OnGotoSettlement(arg_3_1)
	return
end

function BattleSettlementStrategyBase:GotoStage(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0, var_4_1 = GetResultReward()

	local function var_4_2()
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in pairs(var_4_0) do
			if ItemCfg[iter_5_1[1]] then
				if ItemConst.ITEM_TYPE.HERO == ItemCfg[iter_5_1[1]].type then
					table.insert(var_5_0, {
						id = iter_5_1[1]
					})
				elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == ItemCfg[iter_5_1[1]].type and (not IllustratedData:GetExistServant(iter_5_1[1]) or ItemCfg[iter_5_1[1]].display_rare > 3) then
					table.insert(var_5_0, {
						id = iter_5_1[1]
					})
				end
			end
		end

		manager.story:RemovePlayer()

		local function var_5_1()
			JumpTools.OpenPageByJump("/newSettlement", {
				result = arg_4_1,
				rewardList = var_4_0,
				stageData = arg_4_2,
				starMissionData = arg_4_3,
				battleResult = arg_4_4
			})
			EndBattleLogic(arg_4_1)
		end

		if #var_5_0 > 0 then
			gameContext:Go("obtainView", {
				doNextHandler = var_5_1,
				itemList = var_5_0
			})
		else
			var_5_1()
		end
	end

	if isSuccess(arg_4_1) then
		function BattleCallLuaCallBack()
			local var_7_0 = arg_4_2:GetType()

			if var_7_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				manager.story:CheckChessBattleStory(manager.story.WIN, var_4_2)
			elseif var_7_0 == BattleConst.STAGE_TYPE_NEW.CHESS_BOARD then
				manager.story:CheckBattleStory(arg_4_2:GetStageId(), manager.story.WIN, var_4_2, false)
			else
				manager.story:CheckBattleStory(arg_4_2:GetStageId(), manager.story.WIN, var_4_2)
			end
		end
	else
		self:GotoBattleFaild(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	end
end

function BattleSettlementStrategyBase:GotoBattleFaild(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	function BattleCallLuaCallBack()
		manager.story:CheckBattleStory(arg_8_2:GetStageId(), manager.story.LOSE, function()
			if arg_8_2 and arg_8_2:GetType() == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON then
				JumpTools.OpenPageByJump("/battlefailedWithButton", {
					stageData = arg_8_2,
					battleResult = arg_8_4,
					isHalfWay_ = self.tempData.isHalfWay_
				})
			else
				JumpTools.OpenPageByJump("/battlefailed", {
					stageData = arg_8_2,
					starMissionData = arg_8_3,
					battleResult = arg_8_4,
					isHalfWay_ = self.tempData.isHalfWay_
				})
			end

			manager.story:RemovePlayer()
			EndBattleLogic(arg_8_1)
		end)
	end
end

function BattleSettlementStrategyBase:GotoBattleFaildRecommend(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	function BattleCallLuaCallBack()
		manager.story:CheckBattleStory(arg_11_2:GetStageId(), manager.story.LOSE, function()
			if arg_11_5 then
				JumpTools.OpenPageByJump("/battlefailedChallengeWithButton", {
					stageData = arg_11_2,
					battleResult = arg_11_4,
					isHalfWay_ = self.tempData.isHalfWay_
				})
			else
				JumpTools.OpenPageByJump("/battleChallengeFailed", {
					stageData = arg_11_2,
					starMissionData = arg_11_3,
					battleResult = arg_11_4,
					isHalfWay_ = self.tempData.isHalfWay_
				})
			end

			manager.story:RemovePlayer()
			EndBattleLogic(arg_11_1)
		end)
	end
end

return BattleSettlementStrategyBase
