NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleResultChapterView = class("BattleResultChapterView", NewBattleSettlementView)

function BattleResultChapterView:NeedAddExp()
	return BattleInstance.NeedAddExp(self.stageData)
end

function BattleResultChapterView:RefreshBottomBtn()
	local var_2_0 = self.stageData:GetStageId()
	local var_2_1 = getChapterIDByStageID(var_2_0)
	local var_2_2 = StageTools.GetChapterNextStageID(var_2_1, var_2_0)
	local var_2_3 = var_2_2 ~= nil and not StageTools.IsLockStage(var_2_1, var_2_2)
	local var_2_4 = BattleStageData:GetStageData()[var_2_0]

	if manager.guide:IsPlaying() and table.keyof(GameSetting.guide_use_old_result_stage.value, var_2_0) and var_2_4 and var_2_4.clear_times == 1 then
		var_2_3 = false
	end

	local var_2_5 = ChapterCfg[var_2_1].clientID

	SetActive(self.nextStageBtn_.gameObject, (ChapterCfg[var_2_1].clientID == ChapterConst.CHAPTER_CLIENT_19 or var_2_5 == ChapterConst.CHAPTER_CLIENT_23 or var_2_5 == ChapterConst.CHAPTER_CLIENT_24 or var_2_5 == ChapterConst.CHAPTER_CLIENT_25 or nil) and false)

	if var_2_2 then
		local var_2_6 = BattleStageData:GetStageData()[var_2_2]
		local var_2_7 = BattleStageTools.GetStageCfg(self.stageData:GetType(), var_2_2)

		self.costImage_.sprite = type(var_2_7.extra_cost) == "table" and var_2_7.extra_cost[1] and ItemTools.getItemLittleSprite(var_2_7.extra_cost[1]) or ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_VITALITY)
		self.vitalityCostText_.text = (var_2_6 == nil or var_2_6.clear_times <= 0) and (type(var_2_7.extra_cost) == "table" and var_2_7.extra_cost[1] and var_2_7.extra_cost[2] or var_2_7.cost) or 0
	end
end

function BattleResultChapterView:OnAddListner()
	self:AddBtnListener(self.nextStageBtn_, nil, function()
		local var_4_0 = self.stageData:GetStageId()
		local var_4_1 = getChapterIDByStageID(var_4_0)
		local var_4_2 = StageTools.GetChapterNextStageID(var_4_1, var_4_0)
		local var_4_3 = self.stageData:GetType()

		if StageTools.IsLockSubChapterStage(var_4_1, var_4_2) then
			if var_4_1 == 6010106 then
				ShowTips("ACTIVITY_FINISH_ALL_SUMMER_CHESS")
			end

			return
		end

		local var_4_4 = BattleStageTools.GetStageCfg(var_4_3, var_4_2)
		local var_4_5 = BattleStageData:GetStageData()[var_4_2]

		if var_4_5 == nil or var_4_5.clear_times <= 0 then
			if not BattleStageData:IsFinishAllPreUnlockStage(var_4_3, var_4_2) then
				return
			end

			if type(var_4_4.extra_cost) == "table" and var_4_4.extra_cost[1] then
				if var_4_4.extra_cost[2] > ItemTools.getItemNum(var_4_4.extra_cost[1]) then
					self:PopCurrencyWindow()

					return
				end
			elseif ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < var_4_4.cost then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", self.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end

				return
			end
		end

		local function var_4_7()
			if BattleConst.BATTLE_TAG.STORY == var_4_4.tag then
				BattleController.GetInstance():LaunchStoryBattle(var_4_3, var_4_2)
			else
				if var_4_3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT and BattleStageTools.SkipSectionSelectHero(var_4_3, var_4_2) then
					BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(var_4_3, var_4_2)))

					return
				end

				if BattleStageTools.CheckPopTrailStage(var_4_3, var_4_2) then
					return
				end

				BattleInstance.GotoBattleReadyPage(var_4_1, var_4_2, var_4_3)
			end
		end

		if StageTools.NeedShowContinueBattleWindow(var_4_3, var_4_2) then
			JumpTools.OpenPopUp("continueBattleCostPop", {
				stageType = var_4_3,
				stageID = var_4_2,
				callback = function()
					var_4_7()
				end
			})
		else
			var_4_7()
		end
	end)
end

function BattleResultChapterView:PopCurrencyWindow()
	local var_7_0 = self.stageData:GetStageId()
	local var_7_1 = getChapterIDByStageID(var_7_0)

	if ActivityTools.GetActivityStatus(ItemExchangeCfg[ChapterCfg[var_7_1].cost_exchange_id].activity_id) == 1 then
		ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(BattleStageTools.GetStageCfg(self.stageData:GetType(), (StageTools.GetChapterNextStageID(var_7_1, var_7_0))).extra_cost[1])))
	else
		JumpTools.OpenPageByJump("itemExchange", {
			exchangeID = ChapterCfg[var_7_1].cost_exchange_id,
			maxCnt = ChapterTools.GetUnclearStageCnt(var_7_1)
		})
	end
end

return BattleResultChapterView
