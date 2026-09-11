SectionBaseView = import("game.views.sectionInfo.SectionInfoMultipleBaseView")

local ActivityPt2SectionInfoView = class("ActivityPt2SectionInfoView", SectionBaseView)

function ActivityPt2SectionInfoView:UIName()
	return "UI/Stage/PTSectionInfoUI"
end

function ActivityPt2SectionInfoView:Init()
	ActivityPt2SectionInfoView.super.Init(self)
end

function ActivityPt2SectionInfoView:InitUI()
	ActivityPt2SectionInfoView.super.InitUI(self)

	self.affixGoList_ = {}

	for iter_3_0 = 1, self.affixContentTrans_.childCount do
		self.affixGoList_[iter_3_0] = self.affixContentTrans_:GetChild(iter_3_0 - 1).gameObject
	end
end

function ActivityPt2SectionInfoView:AddListeners()
	ActivityPt2SectionInfoView.super.AddListeners(self)
	self:RemoveBtnListener(nil, self.battleBtn_.transform)
	self:AddBtnListener(self.battleBtn_, nil, function()
		if self.lock_ then
			ShowTips(self.lockTips_)
		elseif self.costId ~= 0 and ItemTools.getItemNum(self.costId) < self.cost * self.multiple_ then
			if self.costId == CurrencyConst.CURRENCY_TYPE_VITALITY then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", self.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(self.costId)))
			end
		else
			self:OnClickBtn()
		end
	end)
end

function ActivityPt2SectionInfoView:UpdateBar()
	local var_6_0 = ActivityPt2Tools.GetChallengeCurrencyID(self.params_.mainActivityId)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		var_6_0,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(var_6_0, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function()
		if self.params_.backCall then
			self.params_.backCall()
		end

		self:Back()
	end)
end

function ActivityPt2SectionInfoView:RefreshData()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)

	self:RefreshCostInfo()

	local var_8_0 = 1

	for iter_8_0 = #GameSetting.challenge_multiple_count_unlock_level.value, 1, -1 do
		if ItemTools.getItemNum(self.costId) >= self.cost * iter_8_0 then
			var_8_0 = iter_8_0

			break
		end
	end

	self.maxMultiple_ = var_8_0
	self.multiple_ = self.multiple_ or 1
	self.challengeCnt_ = self:GetUnlockChallengeCnt()

	local var_8_1 = 0

	if self.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL then
		local var_8_2 = ActivityPt2Data:GetNormalData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[1], self.params_.repeat_id)

		var_8_1 = var_8_2 and var_8_2.clear_time or 0
	elseif self.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		local var_8_3 = ActivityPt2Data:GetChallengeData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[2], self.params_.repeat_id)

		var_8_1 = var_8_3 and var_8_3.clear_time or 0
	else
		local var_8_4 = ActivityPt2Data:GetHardData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[3])

		var_8_1 = var_8_4 and var_8_4.clear_time or 0
	end

	self.lock_ = false
	self.lockTips_ = ""
	self.isFirstClear_ = var_8_1 == 0
	self.drop_lib_id = self.cfg_.drop_lib_id
end

function ActivityPt2SectionInfoView:RefreshCostInfo()
	if ActivityPt2Cfg[self.params_.repeat_id].cost[1][1] then
		self.costId = ActivityPt2Cfg[self.params_.repeat_id].cost[1][1]
		self.cost = ActivityPt2Cfg[self.params_.repeat_id].cost[1][2]
		self.costIcon_.sprite = ItemTools.getItemLittleSprite(self.costId)

		SetActive(self.resourcePanel_, true)
		SetActive(self.multiplePanel_, true)
		SetActive(self.rewardPanel_, true)
	else
		self.costId = 0
		self.cost = 0

		SetActive(self.resourcePanel_, false)
		SetActive(self.multiplePanel_, false)
		SetActive(self.rewardPanel_, false)
	end
end

function ActivityPt2SectionInfoView:RefreshStageInfo()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)

	if self.oldCfgID_ ~= self.cfg_.id then
		self.sectionName_.text = GetI18NText(self.cfg_.name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, self.cfg_.background_1))
		self.textStory_.text = GetI18NText(self.cfg_.tips)
		self.oldCfgID_ = self.cfg_.id
		self.tipsText_.text = self.cfg_.tips
		self.titleCanvasGroup_.alpha = 0
		self.multiple_ = 1

		self:RefreshAffix()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.textContent_)
end

function ActivityPt2SectionInfoView:RefreshAffix()
	if type(self.cfg_.affix_type) ~= "table" then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(self.cfg_.affix_type) do
		self["affixName_" .. iter_11_0].text = GetI18NText(getAffixName(iter_11_1))
		self["affixDesc_" .. iter_11_0].text = GetI18NText(getAffixDesc(iter_11_1))
		self["affixIcon_" .. iter_11_0].sprite = getAffixSprite(iter_11_1)

		if self.affixGoList_[iter_11_0] then
			SetActive(self.affixGoList_[iter_11_0], true)
		end
	end

	for iter_11_2 = #self.cfg_.affix_type + 1, #self.affixGoList_ do
		if self.affixGoList_[iter_11_2] then
			SetActive(self.affixGoList_[iter_11_2], false)
		end
	end
end

function ActivityPt2SectionInfoView:OnClickBtn()
	self:Go("/sectionSelectHero", {
		section = self.params_.section,
		sectionType = self.params_.sectionType,
		activityID = self.params_.activityId,
		multiple = self.multiple_
	})
end

function ActivityPt2SectionInfoView:OnTop()
	self:UpdateBar()
end

function ActivityPt2SectionInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityPt2SectionInfoView:GetUnlockChallengeCnt()
	local var_15_0 = 0

	if self.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL then
		local var_15_1 = ActivityPt2Data:GetNormalData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[1], self.params_.repeat_id)

		var_15_0 = var_15_1 and var_15_1.clear_time or 0
	elseif self.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		local var_15_2 = ActivityPt2Data:GetChallengeData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[2], self.params_.repeat_id)

		var_15_0 = var_15_2 and var_15_2.clear_time or 0
	else
		local var_15_3 = ActivityPt2Data:GetHardData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[3])

		var_15_0 = var_15_3 and var_15_3.clear_time or 0
	end

	if var_15_0 > 0 then
		return ActivityPt2SectionInfoView.super.GetUnlockChallengeCnt(self)
	end

	return var_15_0
end

function ActivityPt2SectionInfoView:GetChallengeCntMaxTip()
	local var_16_0 = 0

	if self.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL then
		local var_16_1 = ActivityPt2Data:GetNormalData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[1], self.params_.repeat_id)

		var_16_0 = var_16_1 and var_16_1.clear_time or 0
	elseif self.params_.sectionType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		local var_16_2 = ActivityPt2Data:GetChallengeData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[2], self.params_.repeat_id)

		var_16_0 = var_16_2 and var_16_2.clear_time or 0
	else
		local var_16_3 = ActivityPt2Data:GetHardData(ActivityCfg[self.params_.mainActivityId].sub_activity_list[3])

		var_16_0 = var_16_3 and var_16_3.clear_time or 0
	end

	if var_16_0 > 0 then
		return ActivityPt2SectionInfoView.super.GetChallengeCntMaxTip(self)
	end

	return GetTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")
end

function ActivityPt2SectionInfoView:Dispose()
	self.affixGoList_ = nil

	ActivityPt2SectionInfoView.super.Dispose(self)
end

return ActivityPt2SectionInfoView
