NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("BattleResultChapterView", NewBattleSettlementView)

function var_0_0.NeedAddExp(arg_1_0)
	return BattleInstance.NeedAddExp(arg_1_0.stageData)
end

function var_0_0.RefreshBottomBtn(arg_2_0)
	local var_2_0 = arg_2_0.stageData:GetStageId()
	local var_2_1 = getChapterIDByStageID(var_2_0)
	local var_2_2 = StageTools.GetChapterNextStageID(var_2_1, var_2_0)
	local var_2_3 = var_2_2 ~= nil

	var_2_3 = var_2_3 and not StageTools.IsLockStage(var_2_1, var_2_2)

	local var_2_4 = BattleStageData:GetStageData()[var_2_0]

	if manager.guide:IsPlaying() and table.keyof(GameSetting.guide_use_old_result_stage.value, var_2_0) and var_2_4 and var_2_4.clear_times == 1 then
		var_2_3 = false
	end

	local var_2_5 = ChapterCfg[var_2_1].clientID

	if var_2_5 == ChapterConst.CHAPTER_CLIENT_19 or var_2_5 == ChapterConst.CHAPTER_CLIENT_23 or var_2_5 == ChapterConst.CHAPTER_CLIENT_24 or var_2_5 == ChapterConst.CHAPTER_CLIENT_25 then
		var_2_3 = false
	end

	SetActive(arg_2_0.nextStageBtn_.gameObject, var_2_3)

	if var_2_2 then
		local var_2_6 = BattleStageData:GetStageData()[var_2_2]
		local var_2_7 = arg_2_0.stageData:GetType()
		local var_2_8 = BattleStageTools.GetStageCfg(var_2_7, var_2_2)

		if type(var_2_8.extra_cost) == "table" and var_2_8.extra_cost[1] then
			local var_2_9 = var_2_8.extra_cost[1]

			arg_2_0.costImage_.sprite = ItemTools.getItemLittleSprite(var_2_9)
		else
			arg_2_0.costImage_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_VITALITY)
		end

		if var_2_6 == nil or var_2_6.clear_times <= 0 then
			if type(var_2_8.extra_cost) == "table" and var_2_8.extra_cost[1] then
				local var_2_10 = var_2_8.extra_cost[1]

				arg_2_0.vitalityCostText_.text = var_2_8.extra_cost[2]
			else
				arg_2_0.vitalityCostText_.text = var_2_8.cost
			end
		else
			arg_2_0.vitalityCostText_.text = 0
		end
	end
end

function var_0_0.OnAddListner(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.nextStageBtn_, nil, function()
		local var_4_0 = arg_3_0.stageData:GetStageId()
		local var_4_1 = getChapterIDByStageID(var_4_0)
		local var_4_2 = StageTools.GetChapterNextStageID(var_4_1, var_4_0)
		local var_4_3 = arg_3_0.stageData:GetType()

		if StageTools.IsLockSubChapterStage(var_4_1, var_4_2) then
			if var_4_1 == 6010106 then
				ShowTips("ACTIVITY_FINISH_ALL_SUMMER_CHESS")
			end

			return
		end

		local var_4_4 = BattleStageTools.GetStageCfg(var_4_3, var_4_2)
		local var_4_5 = BattleStageData:GetStageData()[var_4_2]
		local var_4_6 = 0
		local var_4_7 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if var_4_5 == nil or var_4_5.clear_times <= 0 then
			if not BattleStageData:IsFinishAllPreUnlockStage(var_4_3, var_4_2) then
				return
			end

			if type(var_4_4.extra_cost) == "table" and var_4_4.extra_cost[1] then
				if var_4_4.extra_cost[2] > ItemTools.getItemNum(var_4_4.extra_cost[1]) then
					arg_3_0:PopCurrencyWindow()

					return
				end
			elseif var_4_7 < var_4_4.cost then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", arg_3_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end

				return
			end
		end

		local function var_4_8()
			if BattleConst.BATTLE_TAG.STORY == var_4_4.tag then
				BattleController.GetInstance():LaunchStoryBattle(var_4_3, var_4_2)
			else
				if var_4_3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT and BattleStageTools.SkipSectionSelectHero(var_4_3, var_4_2) then
					local var_5_0 = BattleStageFactory.Produce(var_4_3, var_4_2)

					BattleController.GetInstance():LaunchBattle(var_5_0)

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
					var_4_8()
				end
			})
		else
			var_4_8()
		end
	end)
end

function var_0_0.PopCurrencyWindow(arg_7_0)
	local var_7_0 = arg_7_0.stageData:GetStageId()
	local var_7_1 = getChapterIDByStageID(var_7_0)
	local var_7_2 = StageTools.GetChapterNextStageID(var_7_1, var_7_0)
	local var_7_3 = arg_7_0.stageData:GetType()
	local var_7_4 = BattleStageTools.GetStageCfg(var_7_3, var_7_2)
	local var_7_5 = ChapterCfg[var_7_1].cost_exchange_id
	local var_7_6 = ItemExchangeCfg[var_7_5]

	if ActivityTools.GetActivityStatus(var_7_6.activity_id) == 1 then
		ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_7_4.extra_cost[1])))
	else
		JumpTools.OpenPageByJump("itemExchange", {
			exchangeID = var_7_5,
			maxCnt = ChapterTools.GetUnclearStageCnt(var_7_1)
		})
	end
end

return var_0_0
