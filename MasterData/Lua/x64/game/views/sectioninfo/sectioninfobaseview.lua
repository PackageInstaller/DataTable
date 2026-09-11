local SectionInfoBaseView = class("SectionInfoBaseView", ReduxView)

function SectionInfoBaseView:UIName()
	return "Widget/System/Operation/ChapterSectionInfoUI"
end

function SectionInfoBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function SectionInfoBaseView:Init()
	self.rewardItems_ = {}

	self:InitUI()
	self:AddListeners()

	self.multiple_ = 1
	self.uiList_ = LuaList.New(handler(self, self.RefreshRewardItem), self.rewardUIListGo_, CommonItemView)
	self.hideStageNumController_ = self.controllerEx_:GetController("hideStageNum")
	self.hideThreeStarController_ = self.controllerEx_:GetController("hideThreeStar")
	self.hideDropPanelController_ = self.controllerEx_:GetController("hideDropPanel")
	self.hideStageDescController_ = self.controllerEx_:GetController("hideStageDesc")
	self.hideMultiplePanelController_ = self.controllerEx_:GetController("hideMultiplePanel")
	self.hideAffixController_ = self.controllerEx_:GetController("hideAffixPanel")
	self.hideBattleAffixController_ = self.controllerEx_:GetController("hideBattleAffixPanel")
	self.guildStateController_ = self.controllerEx_:GetController("guildstate")
	self.hideSmallAffixController_ = self.controllerEx_:GetController("hideSmallAffix")
	self.hideFatigueController_ = self.controllerEx_:GetController("hideFatigue")
	self.challengeTimeController_ = self.controllerEx_:GetController("challengeTime")
	self.refreshTimeController_ = self.controllerEx_:GetController("refreshTime")
	self.btnWebController_ = self.controllerEx_:GetController("btnWeb")
	self.btnController_ = self.btnControllerEx_:GetController("lock")
	self.showTipsController_ = self.controllerEx_:GetController("showTips")
	self.titleDesController_ = self.describeControllerexcollection_:GetController("text")

	self.hideStageNumController_:SetSelectedState("true")
	self.hideThreeStarController_:SetSelectedState("true")
	self.hideDropPanelController_:SetSelectedState("true")
	self.hideStageDescController_:SetSelectedState("true")
	self.hideMultiplePanelController_:SetSelectedState("true")
	self.hideAffixController_:SetSelectedState("true")
	self.hideBattleAffixController_:SetSelectedState("true")
	self.guildStateController_:SetSelectedState("common")
	self.hideSmallAffixController_:SetSelectedState("true")
	self.btnController_:SetSelectedState("false")
	self.hideFatigueController_:SetSelectedState("show")
	self.challengeTimeController_:SetSelectedState("close")
	self.refreshTimeController_:SetSelectedState("close")
	self.btnWebController_:SetSelectedState("notshow")
	self.showTipsController_:SetSelectedState("false")

	self.currencyUpdateHandle_ = handler(self, self.OnCurrencyChange)
end

function SectionInfoBaseView:OnEnter()
	self.stageID_ = self.params_.section
	self.stageType_ = self.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	manager.notify:RegistListener(CURRENCY_UPDATE, self.currencyUpdateHandle_)
	self:RefreshData()
	self:RefreshUI()
	self:RefreshTitleDesc()
	self:UpdateBar()
end

function SectionInfoBaseView:UpdateBar()
	local var_5_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if type(var_5_0.extra_cost) == "table" and var_5_0.extra_cost[1] then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			var_5_0.extra_cost[1],
			CurrencyConst.CURRENCY_TYPE_VITALITY,
			CurrencyConst.CURRENCY_TYPE_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetBarCanClick(var_5_0.extra_cost[1], true)
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

function SectionInfoBaseView:OnUpdate()
	if self.stageID_ == self.params_.section then
		return
	end

	self.stageID_ = self.params_.section

	self:RefreshData()
	self:RefreshUI()
end

function SectionInfoBaseView:OnExit()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RemoveListener(CURRENCY_UPDATE, self.currencyUpdateHandle_)
end

function SectionInfoBaseView:InitUI()
	self:BindCfgUI()

	self.sectionImage_.immediate = true
end

function SectionInfoBaseView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		local var_10_1 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

		if self.lock_ then
			ShowTips(self.lockTips_)
		elseif type(var_10_1.extra_cost) == "table" and var_10_1.extra_cost[1] then
			if self.cost_ > ItemTools.getItemNum(var_10_1.extra_cost[1]) then
				self:PopCurrencyWindow()
			else
				self:CheckTrailOrStart()
			end
		elseif ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < self.cost_ * self.multiple_ then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", self.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			self:CheckTrailOrStart()
		end
	end)
	self:AddBtnListener(self.battleBtn2_, nil, function()
		local var_11_1 = 0
		local var_11_2 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

		var_11_1 = self.costID_ == nil and ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) or ItemTools.getItemNum(self.costID_)

		if self.lock_ then
			ShowTips(self.lockTips_)
		elseif type(var_11_2.extra_cost) == "table" and var_11_2.extra_cost[1] then
			if self.cost_ > ItemTools.getItemNum(var_11_2.extra_cost[1]) then
				self:PopCurrencyWindow()
			else
				self:CheckTrailOrStart()
			end
		elseif var_11_1 < self.cost_ * self.multiple_ then
			if self.costID_ == CurrencyConst.CURRENCY_TYPE_VITALITY or self.costID_ == nil then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", self.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(self.costID_)))
			end
		else
			self:CheckTrailOrStart()
		end
	end)
	self:AddBtnListener(self.rushBtn_, nil, function()
		if self.params_.chapterID and self.params_.chapterID > 0 then
			if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < self.cost_ * self.multiple_ then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", self.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			elseif table.indexof(GameSetting.quick_battle_chapter.value, self.params_.chapterID) and BattleStageData:GetStageClearTimes(self.stageID_) > 0 then
				if self.params_.chapterID == 203 then
					JumpTools.Back()
				end

				JumpTools.OpenPopUp("operationRushPopView", {
					chapterID = self.params_.chapterID,
					stageID = self.stageID_,
					stageType = self.stageType_,
					multiple = self.multiple_,
					activityID = self.activityID_
				})
			end
		elseif self.params_.activityId then
			local var_12_0 = 0
			local var_12_1 = 0
			local var_12_2 = 0

			if ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.params_.activityId] and type(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.params_.activityId]) == "table" then
				for iter_12_0, iter_12_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.params_.activityId]) do
					if ActivityPtRouletteStageCfg[iter_12_1].stage_id == self.params_.section then
						var_12_0 = ActivityPtRouletteStageCfg[iter_12_1].mode
						var_12_1 = ActivityPtRouletteStageCfg[iter_12_1].cost[2]

						break
					end
				end

				if var_12_0 == 1 then
					if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < var_12_1 * self.multiple_ then
						if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
							JumpTools.OpenPopUp("currencyBuyFatigue", self.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
						else
							ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
						end
					elseif table.indexof(GameSetting.quick_battle_type.value, self.stageType_) and var_12_0 > 0 and table.indexof(GameSetting.quick_battle_mode.value, var_12_0) then
						if table.indexof(ActivityPtScrollData:GetClearList(self.params_.activityId), self.params_.section) then
							JumpTools.OpenPopUp("operationRushPopView", {
								chapterID = 0,
								stageID = self.stageID_,
								stageType = self.stageType_,
								multiple = self.multiple_,
								activityID = self.activityID_,
								cost = var_12_1
							})
						else
							ShowTips("QUICK_BATTLE_UNLOCK")
						end
					end
				else
					var_12_2 = self.costID_ == nil and CurrencyConst.CURRENCY_TYPE_VITALITY or self.costID_

					if ItemTools.getItemNum(var_12_2) < var_12_1 * self.multiple_ then
						ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(var_12_2)))
					else
						BattleStageAction.OperationRush(0, self.stageID_, self.stageType_, self.multiple_, self.activityID_, function()
							JumpTools.Back()
						end)
					end
				end
			end
		end
	end)
	self:AddBtnListener(self.noRushBtn_, nil, function()
		ShowTips("QUICK_BATTLE_UNLOCK")
	end)
end

function SectionInfoBaseView:PopCurrencyWindow()
	if ChapterCfg[self.params_.chapterID].cost_exchange_id == 0 then
		return
	end

	local var_15_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)
	local var_15_1 = ItemExchangeCfg[ChapterCfg[self.params_.chapterID].cost_exchange_id]

	if ActivityTools.GetActivityStatus(ItemExchangeCfg[ChapterCfg[self.params_.chapterID].cost_exchange_id].activity_id) == 1 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("CURRENCY_NO_ENOUGH_ADN_GOT"), ItemTools.getItemName(var_15_0.extra_cost[1]), ActivityCfg[ItemExchangeCfg[ChapterCfg[self.params_.chapterID].cost_exchange_id].activity_id].remark),
			OkCallback = function()
				JumpTools.JumpToPage2(var_15_1.jump_system)
			end
		})
	else
		JumpTools.OpenPageByJump("itemExchange", {
			exchangeID = ChapterCfg[self.params_.chapterID].cost_exchange_id,
			maxCnt = ChapterTools.GetUnclearStageCnt(self.params_.chapterID)
		})
	end
end

function SectionInfoBaseView:OnCurrencyChange()
	self:RefreshData()
	self:RefreshCost()
end

function SectionInfoBaseView:RefreshData()
	self.lock_ = false
	self.lockTips_ = ""
	self.cost_ = 0
	self.isFirstClear_ = false
	self.dropLibID_ = 0
end

function SectionInfoBaseView:RefreshUI()
	self:RefreshStageInfo()
	self:RefreshReward()
	self:RefreshCost()
	self:RefreshBtn()

	if self.lock_ then
		self.btnLockText_.text = self.lockTips_

		self.btnController_:SetSelectedState("true")
	elseif self.params_.chapterID then
		if table.indexof(GameSetting.quick_battle_chapter.value, self.params_.chapterID) then
			if BattleStageData:GetStageClearTimes(self.stageID_) > 0 then
				self.btnController_:SetSelectedState("rush")
			else
				self.btnController_:SetSelectedState("cantrush")
			end
		else
			self.btnController_:SetSelectedState("false")
		end
	else
		self.btnController_:SetSelectedState("false")
	end
end

function SectionInfoBaseView:RefreshTitleDesc()
	if self.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING or self.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
		self.titleDesController_:SetSelectedState("state1")
	elseif self.stageType_ == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
		self.titleDesController_:SetSelectedState("state0")
	else
		self.titleDesController_:SetSelectedState("state2")
	end
end

function SectionInfoBaseView:HaveCostCntFlag()
	local var_21_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)
	local var_21_1 = true

	if type(var_21_0.extra_cost) == "table" and var_21_0.extra_cost[1] then
		self.costImage_.sprite = ItemTools.getItemLittleSprite(var_21_0.extra_cost[1])

		if self.cost_ * self.multiple_ > ItemTools.getItemNum(var_21_0.extra_cost[1]) then
			var_21_1 = false
		end
	else
		self.costImage_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if self.cost_ * self.multiple_ > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
			var_21_1 = false
		end
	end

	return var_21_1
end

function SectionInfoBaseView:RefreshCost()
	self.costText_.text = self:HaveCostCntFlag() and string.format("<color=#%s>%s</color>", ColorConst.BLACK_HEX, self.cost_ * self.multiple_) or string.format("<color=#%s>%s</color>", ColorConst.RED_HEX, self.cost_ * self.multiple_)
end

function SectionInfoBaseView:RefreshBtn()
	local var_23_0 = self:HaveCostCntFlag()

	if self.lock_ then
		self.btnLockText_.text = self.lockTips_

		self.btnController_:SetSelectedState("true")
	elseif self.params_.chapterID then
		if table.indexof(GameSetting.quick_battle_chapter.value, self.params_.chapterID) then
			if BattleStageData:GetStageClearTimes(self.stageID_) > 0 then
				self.btnController_:SetSelectedState("rush")
			else
				self.btnController_:SetSelectedState("cantrush")
			end
		else
			self.btnController_:SetSelectedState("false")
		end
	else
		self.btnController_:SetSelectedState("false")
	end
end

function SectionInfoBaseView:RefreshStageInfo()
	local var_24_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if self.oldCfgID_ ~= var_24_0.id then
		local var_24_1, var_24_2 = BattleStageTools.GetChapterSectionIndex(self.stageType_, self.stageID_)

		self.sectionText_.text = string.format("%s-%s", GetI18NText(var_24_1), GetI18NText(var_24_2))
		self.sectionName_.text = GetI18NText(var_24_0.name)
		self.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, var_24_0.background_1)
		self.oldCfgID_ = var_24_0.id
	end
end

function SectionInfoBaseView:RefreshReward()
	self.rewardList_ = getRewardFromDropCfg(self.dropLibID_, self.isFirstClear_)

	local var_25_0 = self.rewardList_

	self.rewardTitleText_.text = self.isFirstClear_ and DropCfg[self.dropLibID_] and #DropCfg[self.dropLibID_].base_drop >= 1 and GetTips("FIRST_DROP") or GetTips("MAYBE_DROP")

	if #var_25_0 > 0 then
		self.hideDropPanelController_:SetSelectedState("false")
	else
		self.hideDropPanelController_:SetSelectedState("true")
	end

	self.uiList_:StartScroll(#var_25_0)
end

function SectionInfoBaseView:RefreshRewardItem(arg_26_1, arg_26_2)
	local var_26_0

	if self.rewardList_[arg_26_1] then
		var_26_0 = rewardToItemTemplate(self.rewardList_[arg_26_1])

		if self.isFirstClear_ then
			var_26_0.number = self.rewardList_[arg_26_1].num or nil
		end

		function var_26_0.clickFun(arg_27_0)
			ShowPopItem(POP_ITEM, arg_27_0)
		end
	end

	arg_26_2:SetData(var_26_0)
end

function SectionInfoBaseView:Dispose()
	self.uiList_:Dispose()

	self.uiList_ = nil
	self.currencyUpdateHandle_ = nil

	SectionInfoBaseView.super.Dispose(self)
end

function SectionInfoBaseView:CheckTrailOrStart()
	if BattleStageTools.CheckPopTrailStage(self.stageType_, self.stageID_, function()
		self:OnClickBtn()
	end) then
		return
	end

	self:OnClickBtn()
end

return SectionInfoBaseView
