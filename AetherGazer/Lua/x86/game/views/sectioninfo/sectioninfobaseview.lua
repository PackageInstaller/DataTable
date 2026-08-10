local var_0_0 = class("SectionInfoBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/ChapterSectionInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rewardItems_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.multiple_ = 1
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshRewardItem), arg_3_0.rewardUIListGo_, CommonItemView)
	arg_3_0.hideStageNumController_ = arg_3_0.controllerEx_:GetController("hideStageNum")
	arg_3_0.hideThreeStarController_ = arg_3_0.controllerEx_:GetController("hideThreeStar")
	arg_3_0.hideDropPanelController_ = arg_3_0.controllerEx_:GetController("hideDropPanel")
	arg_3_0.hideStageDescController_ = arg_3_0.controllerEx_:GetController("hideStageDesc")
	arg_3_0.hideMultiplePanelController_ = arg_3_0.controllerEx_:GetController("hideMultiplePanel")
	arg_3_0.hideAffixController_ = arg_3_0.controllerEx_:GetController("hideAffixPanel")
	arg_3_0.hideBattleAffixController_ = arg_3_0.controllerEx_:GetController("hideBattleAffixPanel")
	arg_3_0.guildStateController_ = arg_3_0.controllerEx_:GetController("guildstate")
	arg_3_0.hideSmallAffixController_ = arg_3_0.controllerEx_:GetController("hideSmallAffix")
	arg_3_0.hideFatigueController_ = arg_3_0.controllerEx_:GetController("hideFatigue")
	arg_3_0.challengeTimeController_ = arg_3_0.controllerEx_:GetController("challengeTime")
	arg_3_0.refreshTimeController_ = arg_3_0.controllerEx_:GetController("refreshTime")
	arg_3_0.btnWebController_ = arg_3_0.controllerEx_:GetController("btnWeb")
	arg_3_0.btnController_ = arg_3_0.btnControllerEx_:GetController("lock")
	arg_3_0.showTipsController_ = arg_3_0.controllerEx_:GetController("showTips")
	arg_3_0.titleDesController_ = arg_3_0.describeControllerexcollection_:GetController("text")

	arg_3_0.hideStageNumController_:SetSelectedState("true")
	arg_3_0.hideThreeStarController_:SetSelectedState("true")
	arg_3_0.hideDropPanelController_:SetSelectedState("true")
	arg_3_0.hideStageDescController_:SetSelectedState("true")
	arg_3_0.hideMultiplePanelController_:SetSelectedState("true")
	arg_3_0.hideAffixController_:SetSelectedState("true")
	arg_3_0.hideBattleAffixController_:SetSelectedState("true")
	arg_3_0.guildStateController_:SetSelectedState("common")
	arg_3_0.hideSmallAffixController_:SetSelectedState("true")
	arg_3_0.btnController_:SetSelectedState("false")
	arg_3_0.hideFatigueController_:SetSelectedState("show")
	arg_3_0.challengeTimeController_:SetSelectedState("close")
	arg_3_0.refreshTimeController_:SetSelectedState("close")
	arg_3_0.btnWebController_:SetSelectedState("notshow")
	arg_3_0.showTipsController_:SetSelectedState("false")

	arg_3_0.currencyUpdateHandle_ = handler(arg_3_0, arg_3_0.OnCurrencyChange)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.stageID_ = arg_4_0.params_.section
	arg_4_0.stageType_ = arg_4_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	manager.notify:RegistListener(CURRENCY_UPDATE, arg_4_0.currencyUpdateHandle_)
	arg_4_0:RefreshData()
	arg_4_0:RefreshUI()
	arg_4_0:RefreshTitleDesc()
	arg_4_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_5_0)
	local var_5_0 = BattleStageTools.GetStageCfg(arg_5_0.stageType_, arg_5_0.stageID_)

	if type(var_5_0.extra_cost) == "table" and var_5_0.extra_cost[1] then
		local var_5_1 = var_5_0.extra_cost[1]

		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			var_5_1,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetBarCanClick(var_5_1, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
	end

	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_0.OnUpdate(arg_6_0)
	if arg_6_0.stageID_ == arg_6_0.params_.section then
		return
	end

	arg_6_0.stageID_ = arg_6_0.params_.section

	arg_6_0:RefreshData()
	arg_6_0:RefreshUI()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(CURRENCY_UPDATE, arg_7_0.currencyUpdateHandle_)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.sectionImage_.immediate = true
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.battleBtn_, nil, function()
		local var_10_0 = arg_9_0.stageID_
		local var_10_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		local var_10_2 = BattleStageTools.GetStageCfg(arg_9_0.stageType_, arg_9_0.stageID_)

		if arg_9_0.lock_ then
			ShowTips(arg_9_0.lockTips_)
		elseif type(var_10_2.extra_cost) == "table" and var_10_2.extra_cost[1] then
			local var_10_3 = var_10_2.extra_cost[1]

			if arg_9_0.cost_ > ItemTools.getItemNum(var_10_2.extra_cost[1]) then
				arg_9_0:PopCurrencyWindow()
			else
				arg_9_0:CheckTrailOrStart()
			end
		elseif var_10_1 < arg_9_0.cost_ * arg_9_0.multiple_ then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", arg_9_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			arg_9_0:CheckTrailOrStart()
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.battleBtn2_, nil, function()
		local var_11_0 = arg_9_0.stageID_
		local var_11_1 = 0
		local var_11_2 = BattleStageTools.GetStageCfg(arg_9_0.stageType_, arg_9_0.stageID_)
		local var_11_3 = 0
		local var_11_4 = 0
		local var_11_5 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_9_0.params_.activityId]

		if arg_9_0.costID_ == nil then
			var_11_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		else
			var_11_1 = ItemTools.getItemNum(arg_9_0.costID_)
		end

		if arg_9_0.lock_ then
			ShowTips(arg_9_0.lockTips_)
		elseif type(var_11_2.extra_cost) == "table" and var_11_2.extra_cost[1] then
			local var_11_6 = var_11_2.extra_cost[1]

			if arg_9_0.cost_ > ItemTools.getItemNum(var_11_2.extra_cost[1]) then
				arg_9_0:PopCurrencyWindow()
			else
				arg_9_0:CheckTrailOrStart()
			end
		elseif var_11_1 < arg_9_0.cost_ * arg_9_0.multiple_ then
			if arg_9_0.costID_ == CurrencyConst.CURRENCY_TYPE_VITALITY or arg_9_0.costID_ == nil then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", arg_9_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(arg_9_0.costID_)))
			end
		else
			arg_9_0:CheckTrailOrStart()
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.rushBtn_, nil, function()
		if arg_9_0.params_.chapterID and arg_9_0.params_.chapterID > 0 then
			if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < arg_9_0.cost_ * arg_9_0.multiple_ then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", arg_9_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				local var_12_0 = GameSetting.quick_battle_chapter

				if table.indexof(var_12_0.value, arg_9_0.params_.chapterID) and BattleStageData:GetStageClearTimes(arg_9_0.stageID_) > 0 then
					if arg_9_0.params_.chapterID == 203 then
						JumpTools.Back()
					end

					JumpTools.OpenPopUp("operationRushPopView", {
						chapterID = arg_9_0.params_.chapterID,
						stageID = arg_9_0.stageID_,
						stageType = arg_9_0.stageType_,
						multiple = arg_9_0.multiple_,
						activityID = arg_9_0.activityID_
					})
				end
			end
		elseif arg_9_0.params_.activityId then
			local var_12_1 = GameSetting.quick_battle_type.value
			local var_12_2 = GameSetting.quick_battle_mode.value
			local var_12_3 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_9_0.params_.activityId]
			local var_12_4 = 0
			local var_12_5 = 0
			local var_12_6 = 0

			if var_12_3 and type(var_12_3) == "table" then
				for iter_12_0, iter_12_1 in ipairs(var_12_3) do
					if ActivityPtRouletteStageCfg[iter_12_1].stage_id == arg_9_0.params_.section then
						var_12_4 = ActivityPtRouletteStageCfg[iter_12_1].mode
						var_12_5 = ActivityPtRouletteStageCfg[iter_12_1].cost[2]

						break
					end
				end

				if var_12_4 == 1 then
					if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < var_12_5 * arg_9_0.multiple_ then
						if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
							JumpTools.OpenPopUp("currencyBuyFatigue", arg_9_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
						else
							ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
						end
					elseif table.indexof(var_12_1, arg_9_0.stageType_) and var_12_4 > 0 and table.indexof(var_12_2, var_12_4) then
						local var_12_7 = ActivityPtScrollData:GetClearList(arg_9_0.params_.activityId)

						if table.indexof(var_12_7, arg_9_0.params_.section) then
							JumpTools.OpenPopUp("operationRushPopView", {
								chapterID = 0,
								stageID = arg_9_0.stageID_,
								stageType = arg_9_0.stageType_,
								multiple = arg_9_0.multiple_,
								activityID = arg_9_0.activityID_,
								cost = var_12_5
							})
						else
							ShowTips("QUICK_BATTLE_UNLOCK")
						end
					end
				else
					if arg_9_0.costID_ == nil then
						var_12_6 = CurrencyConst.CURRENCY_TYPE_VITALITY
					else
						var_12_6 = arg_9_0.costID_
					end

					if ItemTools.getItemNum(var_12_6) < var_12_5 * arg_9_0.multiple_ then
						ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_12_6)))
					else
						BattleStageAction.OperationRush(0, arg_9_0.stageID_, arg_9_0.stageType_, arg_9_0.multiple_, arg_9_0.activityID_, function()
							JumpTools.Back()
						end)
					end
				end
			end
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.noRushBtn_, nil, function()
		ShowTips("QUICK_BATTLE_UNLOCK")
	end)
end

function var_0_0.PopCurrencyWindow(arg_15_0)
	local var_15_0 = arg_15_0.params_.chapterID
	local var_15_1 = ChapterCfg[var_15_0].cost_exchange_id

	if var_15_1 == 0 then
		return
	end

	local var_15_2 = BattleStageTools.GetStageCfg(arg_15_0.stageType_, arg_15_0.stageID_)
	local var_15_3 = ItemExchangeCfg[var_15_1]

	if ActivityTools.GetActivityStatus(var_15_3.activity_id) == 1 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("CURRENCY_NO_ENOUGH_ADN_GOT"), ItemTools.getItemName(var_15_2.extra_cost[1]), ActivityCfg[var_15_3.activity_id].remark),
			OkCallback = function()
				JumpTools.JumpToPage2(var_15_3.jump_system)
			end
		})
	else
		JumpTools.OpenPageByJump("itemExchange", {
			exchangeID = var_15_1,
			maxCnt = ChapterTools.GetUnclearStageCnt(var_15_0)
		})
	end
end

function var_0_0.OnCurrencyChange(arg_17_0)
	arg_17_0:RefreshData()
	arg_17_0:RefreshCost()
end

function var_0_0.RefreshData(arg_18_0)
	arg_18_0.lock_ = false
	arg_18_0.lockTips_ = ""
	arg_18_0.cost_ = 0
	arg_18_0.isFirstClear_ = false
	arg_18_0.dropLibID_ = 0
end

function var_0_0.RefreshUI(arg_19_0)
	arg_19_0:RefreshStageInfo()
	arg_19_0:RefreshReward()
	arg_19_0:RefreshCost()
	arg_19_0:RefreshBtn()

	if arg_19_0.lock_ then
		arg_19_0.btnLockText_.text = arg_19_0.lockTips_

		arg_19_0.btnController_:SetSelectedState("true")
	elseif arg_19_0.params_.chapterID then
		local var_19_0 = GameSetting.quick_battle_chapter

		if table.indexof(var_19_0.value, arg_19_0.params_.chapterID) then
			if BattleStageData:GetStageClearTimes(arg_19_0.stageID_) > 0 then
				arg_19_0.btnController_:SetSelectedState("rush")
			else
				arg_19_0.btnController_:SetSelectedState("cantrush")
			end
		else
			arg_19_0.btnController_:SetSelectedState("false")
		end
	else
		arg_19_0.btnController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshTitleDesc(arg_20_0)
	if arg_20_0.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING or arg_20_0.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
		arg_20_0.titleDesController_:SetSelectedState("state1")
	elseif arg_20_0.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
		arg_20_0.titleDesController_:SetSelectedState("state0")
	else
		arg_20_0.titleDesController_:SetSelectedState("state2")
	end
end

function var_0_0.HaveCostCntFlag(arg_21_0)
	local var_21_0 = arg_21_0.cost_ * arg_21_0.multiple_
	local var_21_1 = BattleStageTools.GetStageCfg(arg_21_0.stageType_, arg_21_0.stageID_)
	local var_21_2 = true

	if type(var_21_1.extra_cost) == "table" and var_21_1.extra_cost[1] then
		local var_21_3 = var_21_1.extra_cost[1]

		arg_21_0.costImage_.sprite = ItemTools.getItemLittleSprite(var_21_3)

		if var_21_0 > ItemTools.getItemNum(var_21_1.extra_cost[1]) then
			var_21_2 = false
		end
	else
		arg_21_0.costImage_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if var_21_0 > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
			var_21_2 = false
		end
	end

	return var_21_2
end

function var_0_0.RefreshCost(arg_22_0)
	local var_22_0 = arg_22_0:HaveCostCntFlag()
	local var_22_1 = arg_22_0.cost_ * arg_22_0.multiple_

	if var_22_0 then
		arg_22_0.costText_.text = string.format("<color=#%s>%s</color>", ColorConst.BLACK_HEX, var_22_1)
	else
		arg_22_0.costText_.text = string.format("<color=#%s>%s</color>", ColorConst.RED_HEX, var_22_1)
	end
end

function var_0_0.RefreshBtn(arg_23_0)
	local var_23_0 = arg_23_0:HaveCostCntFlag()

	if arg_23_0.lock_ then
		arg_23_0.btnLockText_.text = arg_23_0.lockTips_

		arg_23_0.btnController_:SetSelectedState("true")
	elseif arg_23_0.params_.chapterID then
		local var_23_1 = GameSetting.quick_battle_chapter

		if table.indexof(var_23_1.value, arg_23_0.params_.chapterID) then
			if BattleStageData:GetStageClearTimes(arg_23_0.stageID_) > 0 then
				arg_23_0.btnController_:SetSelectedState("rush")
			else
				arg_23_0.btnController_:SetSelectedState("cantrush")
			end
		else
			arg_23_0.btnController_:SetSelectedState("false")
		end
	else
		arg_23_0.btnController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshStageInfo(arg_24_0)
	local var_24_0 = BattleStageTools.GetStageCfg(arg_24_0.stageType_, arg_24_0.stageID_)

	if arg_24_0.oldCfgID_ ~= var_24_0.id then
		local var_24_1, var_24_2 = BattleStageTools.GetChapterSectionIndex(arg_24_0.stageType_, arg_24_0.stageID_)

		arg_24_0.sectionText_.text = string.format("%s-%s", GetI18NText(var_24_1), GetI18NText(var_24_2))
		arg_24_0.sectionName_.text = GetI18NText(var_24_0.name)
		arg_24_0.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, var_24_0.background_1)
		arg_24_0.oldCfgID_ = var_24_0.id
	end
end

function var_0_0.RefreshReward(arg_25_0)
	local var_25_0 = arg_25_0.dropLibID_

	arg_25_0.rewardList_ = getRewardFromDropCfg(var_25_0, arg_25_0.isFirstClear_)

	local var_25_1 = arg_25_0.rewardList_

	if arg_25_0.isFirstClear_ and DropCfg[var_25_0] and #DropCfg[var_25_0].base_drop >= 1 then
		arg_25_0.rewardTitleText_.text = GetTips("FIRST_DROP")
	else
		arg_25_0.rewardTitleText_.text = GetTips("MAYBE_DROP")
	end

	if #var_25_1 > 0 then
		arg_25_0.hideDropPanelController_:SetSelectedState("false")
	else
		arg_25_0.hideDropPanelController_:SetSelectedState("true")
	end

	arg_25_0.uiList_:StartScroll(#var_25_1)
end

function var_0_0.RefreshRewardItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0.rewardList_[arg_26_1]
	local var_26_1

	if var_26_0 then
		var_26_1 = rewardToItemTemplate(var_26_0)
		var_26_1.number = arg_26_0.isFirstClear_ and var_26_0.num or nil

		function var_26_1.clickFun(arg_27_0)
			ShowPopItem(POP_ITEM, arg_27_0)
		end
	end

	arg_26_2:SetData(var_26_1)
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.uiList_:Dispose()

	arg_28_0.uiList_ = nil
	arg_28_0.currencyUpdateHandle_ = nil

	var_0_0.super.Dispose(arg_28_0)
end

function var_0_0.CheckTrailOrStart(arg_29_0)
	if BattleStageTools.CheckPopTrailStage(arg_29_0.stageType_, arg_29_0.stageID_, function()
		arg_29_0:OnClickBtn()
	end) then
		return
	end

	arg_29_0:OnClickBtn()
end

return var_0_0
