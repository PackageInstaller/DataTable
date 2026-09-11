SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")

local ActivityPtScrollSectionInfoView = class("ActivityPtScrollSectionInfoView", SectionBaseView)
local var_0_1 = #GameSetting.challenge_multiple_count_unlock_level.value

function ActivityPtScrollSectionInfoView:AddListeners()
	ActivityPtScrollSectionInfoView.super.AddListeners(self)
	self:RemoveBtnListener(nil, self.battleBtn_.transform)
	self:AddBtnListener(self.battleBtn_, nil, function()
		if self.lock_ then
			ShowTips(self.lockTips_)
		elseif self.costID_ ~= 0 and ItemTools.getItemNum(self.costID_) < self.cost_ * self.multiple_ then
			if self.costID_ == CurrencyConst.CURRENCY_TYPE_VITALITY then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", self.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(self.costID_)))
			end
		else
			self:OnClickBtn()
		end
	end)
end

function ActivityPtScrollSectionInfoView:UpdateBar()
	local var_3_0 = ActivityPtScrollTools.GetChallengeCurrencyID(self.params_.activityId)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		var_3_0,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(var_3_0, true)
	manager.windowBar:RegistBackCallBack(function()
		if self.params_.backCall then
			self.params_.backCall()
		end

		self:Back()
	end)
end

function ActivityPtScrollSectionInfoView:RefreshData()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)

	self.hideStageDescController_:SetSelectedState("false")

	self.storyText_.text = self.cfg_.tips

	self:RefreshCostInfo()

	local var_5_0 = 1

	for iter_5_0 = var_0_1, 1, -1 do
		if ItemTools.getItemNum(self.costID_) >= self.cost_ * iter_5_0 then
			var_5_0 = iter_5_0

			break
		end
	end

	self.maxMultiple_ = var_5_0
	self.multiple_ = self.multiple_ or 1
	self.challengeCnt_ = self:GetUnlockChallengeCnt()
	self.lock_ = false
	self.lockTips_ = ""
	self.isFirstClear_ = (table.indexof(ActivityPtScrollData:GetClearList(self.params_.activityId), self.params_.section) ~= false and 1 or 0) == 0
	self.dropLibID_ = self.cfg_.drop_lib_id
end

function ActivityPtScrollSectionInfoView:RefreshCostInfo()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.params_.activityId]) do
		if ActivityPtRouletteStageCfg[iter_6_1].stage_id == self.params_.section then
			var_6_0 = ActivityPtRouletteStageCfg[iter_6_1].cost

			break
		end
	end

	self.costID_ = var_6_0[1]
	self.cost_ = var_6_0[2]
	self.costImage_.sprite = ItemTools.getItemLittleSprite(self.costID_)
end

function ActivityPtScrollSectionInfoView:OnEnter()
	ActivityPtScrollSectionInfoView.super.OnEnter(self)

	self.activityID_ = self.params_.activityId
end

function ActivityPtScrollSectionInfoView:RefreshUI()
	ActivityPtScrollSectionInfoView.super.RefreshUI(self)

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.params_.activityId]) do
		if ActivityPtRouletteStageCfg[iter_8_1].stage_id == self.params_.section then
			var_8_0 = ActivityPtRouletteStageCfg[iter_8_1].mode

			break
		end
	end

	if table.indexof(GameSetting.quick_battle_type.value, self.stageType_) and var_8_0 > 0 and table.indexof(GameSetting.quick_battle_mode.value, var_8_0) then
		if table.indexof(ActivityPtScrollData:GetClearList(self.params_.activityId), self.params_.section) then
			self.btnController_:SetSelectedState("rush")
		else
			self.btnController_:SetSelectedState("cantrush")
		end
	else
		self.btnController_:SetSelectedState("false")
	end
end

function ActivityPtScrollSectionInfoView:RefreshBtn()
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[self.params_.activityId]) do
		if ActivityPtRouletteStageCfg[iter_9_1].stage_id == self.params_.section then
			var_9_0 = ActivityPtRouletteStageCfg[iter_9_1].mode

			break
		end
	end

	if table.indexof(GameSetting.quick_battle_type.value, self.stageType_) and var_9_0 > 0 and table.indexof(GameSetting.quick_battle_mode.value, var_9_0) then
		if table.indexof(ActivityPtScrollData:GetClearList(self.params_.activityId), self.params_.section) then
			self.btnController_:SetSelectedState("rush")
		else
			self.btnController_:SetSelectedState("cantrush")
		end
	else
		self.btnController_:SetSelectedState("false")
	end
end

function ActivityPtScrollSectionInfoView:HaveCostCntFlag()
	local var_10_0 = self.cost_ * self.multiple_

	self.costImage_.sprite = ItemTools.getItemLittleSprite(self.costID_)

	return var_10_0 <= ItemTools.getItemNum(self.costID_)
end

function ActivityPtScrollSectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.params_.section,
		sectionType = self.params_.sectionType,
		activityID = self.params_.activityId,
		multiple = self.multiple_
	})
end

function ActivityPtScrollSectionInfoView:GetUnlockChallengeCnt()
	local var_12_0 = table.indexof(ActivityPtScrollData:GetClearList(self.params_.activityId), self.params_.section) ~= false and 1 or 0

	if var_12_0 > 0 then
		return ActivityPtScrollSectionInfoView.super.GetUnlockChallengeCnt(self)
	end

	return var_12_0
end

function ActivityPtScrollSectionInfoView:GetChallengeCntMaxTip()
	if (table.indexof(ActivityPtScrollData:GetClearList(self.params_.activityId), self.params_.section) ~= false and 1 or 0) > 0 then
		return ActivityPtScrollSectionInfoView.super.GetChallengeCntMaxTip(self)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function ActivityPtScrollSectionInfoView:RefreshStageInfo()
	local var_14_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)

	if self.oldCfgID_ ~= var_14_0.id then
		local var_14_1, var_14_2 = BattleStageTools.GetChapterSectionIndex(self.stageType_, self.stageID_)

		self.sectionText_.text = string.format("%s-%s", GetI18NText(var_14_1), GetI18NText(var_14_2))
		self.sectionName_.text = GetI18NText(var_14_0.name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_14_0.background_1))
		self.oldCfgID_ = var_14_0.id
		self.multiple_ = 1
	end
end

return ActivityPtScrollSectionInfoView
