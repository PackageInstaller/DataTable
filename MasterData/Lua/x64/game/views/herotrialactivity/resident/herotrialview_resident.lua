local HeroTrialView_Resident = class("HeroTrialView_Resident", ReduxView)

function HeroTrialView_Resident:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName(arg_1_2)), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform
	self.activityID_ = arg_1_2

	self:Init()
end

function HeroTrialView_Resident:UIName(arg_2_1)
	return HeroTrialTools.GetMainUIName(arg_2_1)
end

function HeroTrialView_Resident:Init()
	self:InitUI()
	self:AddListeners()
end

function HeroTrialView_Resident:InitUI()
	self:BindCfgUI()

	self.heroItemList_ = {}
	self.onClickTrialHandler_ = handler(self, self.OnClickTrial)
	self.onActivityUpdateHandler_ = handler(self, self.OnActivityUpdate)
	self.heroImage_.immediate = true

	self:InitController()
	self:InitStaticText()
	self:InitRewardItem()
end

function HeroTrialView_Resident:InitController()
	self.rewardController_ = self.rewardControllerEx_:GetController("reward")
end

function HeroTrialView_Resident:InitStaticText()
	self.activityTitle_.text = GetTips("ACTIVITY_HERO_TRIAL_TITLE")
	self.previewText_.text = GetTips("ACTIVITY_HERO_TRIAL_PREVIEW")
	self.battleBtnText_.text = GetTips("ACTIVITY_HERO_TRIAL_START")
end

function HeroTrialView_Resident:InitRewardItem()
	self.rewardItemList_ = {}
	self.itemDataList_ = {}

	for iter_7_0 = 1, self.rewardPanelTrans_.childCount do
		self.rewardItemList_[iter_7_0] = CommonItemView.New(self.rewardPanelTrans_:GetChild(iter_7_0 - 1).gameObject, true)
		self.itemDataList_[iter_7_0] = clone(ItemTemplateData)
		self.itemDataList_[iter_7_0].clickFun = function(self)
			ShowPopItem(POP_ITEM, {
				self.id,
				self.number
			})
		end
	end
end

function HeroTrialView_Resident:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		HeroTrialAction.GetTrialReward(self.activityID_, self.selectActivityHeroID_, function(arg_11_0)
			if isSuccess(arg_11_0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list))
				self:RefreshReward()
			else
				ShowTips(arg_11_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(self.activityHeroIDList_) do
			table.insert(var_12_0, (HeroTrialTools.GetHeroStandardID(iter_12_1)))
		end

		self:Go("/newHero", {
			isEnter = true,
			hid = HeroTrialTools.GetHeroStandardID(self.selectActivityHeroID_),
			type = HeroConst.HERO_DATA_TYPE.TRIAL,
			tempHeroList = var_12_0
		})
	end)
	self:AddBtnListener(self.battleBtn_, nil, function()
		HeroTrialData:SaveStageID(self.selectActivityHeroID_)
		HeroTrialData:SetBattleWay(ActivityHeroTrialConst.BATTLE_WAY.ACTIVITY)
		self:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[self.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_HERO_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")
		})
	end)
end

function HeroTrialView_Resident:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HeroTrialView_Resident:Dispose()
	HeroTrialView_Resident.super.Dispose(self)

	for iter_16_0, iter_16_1 in pairs(self.rewardItemList_) do
		iter_16_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.itemDataList_ = nil

	for iter_16_2, iter_16_3 in pairs(self.heroItemList_) do
		iter_16_3:Dispose()
	end

	self.heroItemList_ = nil
end

function HeroTrialView_Resident:Show(arg_17_1)
	SetActive(self.gameObject_, arg_17_1)

	if arg_17_1 == true then
		self:OnEnable()
	else
		self:OnDisable()
	end
end

function HeroTrialView_Resident:OnEnable()
	self:InitActivityList()

	if #self.activityHeroIDList_ == 0 then
		ShowTips("TIME_OVER")
		self:Back()

		return
	end

	self:InitSelectActivityHeroID()
	self:ScrollToLastPos()
	self:RefreshHeroItem()
	self:RefreshUI()
	self:UpdateStopTime()
	self:AddTimer()
	self:RegistEventListener(HERO_TRIAL_CLICK, self.onClickTrialHandler_)
	self:RegistEventListener(ACTIVITY_UPDATE, self.onActivityUpdateHandler_)
	self:OnClickSwitchItem()
end

function HeroTrialView_Resident:OnDisable()
	self:StopTimer()
	self:RemoveAllEventListener()
	self:SaveLastScrollPos()
end

function HeroTrialView_Resident:InitActivityList()
	self.activityHeroIDList_ = {}

	for iter_20_0, iter_20_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
		if ActivityData:GetActivityIsOpen(iter_20_1) then
			for iter_20_2, iter_20_3 in ipairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[iter_20_1]) do
				self.activityHeroIDList_[#self.activityHeroIDList_ + 1] = iter_20_3
			end
		end
	end

	local var_20_0 = HeroTrialData:GetHeroTrialStateList()

	table.sort(self.activityHeroIDList_, function(arg_21_0, arg_21_1)
		if var_20_0[arg_21_0] ~= var_20_0[arg_21_1] then
			return var_20_0[arg_21_0] < var_20_0[arg_21_1]
		else
			return arg_21_0 < arg_21_1
		end
	end)
end

function HeroTrialView_Resident:InitSelectActivityHeroID()
	local var_22_0 = HeroTrialData:GetSelectActivityHeroID(self.activityID_)

	if not var_22_0 or not table.indexof(self.activityHeroIDList_, var_22_0) then
		var_22_0 = self.activityHeroIDList_[1]
	end

	self.selectActivityHeroID_ = var_22_0

	HeroTrialData:SetSelectActivityHeroID(self.activityID_, self.selectActivityHeroID_)
end

function HeroTrialView_Resident:ScrollToLastPos()
	local var_23_0 = HeroTrialData:GetLastContentPosX(self.activityID_)

	if var_23_0 then
		self.goItemParentTrans_:SetAnchoredPositionX(var_23_0)
	end
end

function HeroTrialView_Resident:SaveLastScrollPos()
	HeroTrialData:SetLastContentPosX(self.activityID_, (self.goItemParentTrans_:GetAnchoredPositionX(nil)))
end

function HeroTrialView_Resident:RefreshHeroItem()
	for iter_25_0, iter_25_1 in ipairs(self.activityHeroIDList_) do
		if self.heroItemList_[iter_25_0] then
			self.heroItemList_[iter_25_0]:SetActivityHeroID(self.activityID_, iter_25_1)
		else
			self.heroItemList_[iter_25_0] = self:GetHeroTrialSelectItemClass().New(self.heroItemGo_, self.goItemParentTrans_, iter_25_1, self.activityID_)
		end
	end

	for iter_25_2 = #self.heroItemList_, #self.activityHeroIDList_ + 1, -1 do
		self.heroItemList_[iter_25_2]:Dispose()

		self.heroItemList_[iter_25_2] = nil
	end

	self:RefreshSelectActivityHero()
end

function HeroTrialView_Resident:RefreshSelectActivityHero()
	for iter_26_0, iter_26_1 in pairs(self.heroItemList_) do
		iter_26_1:OnSelect(self.selectActivityHeroID_)
	end
end

function HeroTrialView_Resident:OnClickTrial(arg_27_1)
	self.selectActivityHeroID_ = arg_27_1

	HeroTrialData:SetSelectActivityHeroID(self.activityID_, self.selectActivityHeroID_)
	self:RefreshUI()
	self:RefreshSelectActivityHero()
	self:UpdateStopTime()
	self:OnClickSwitchItem()
end

function HeroTrialView_Resident:OnClickSwitchItem()
	if not self.activityHeroIDList_ or not self.selectActivityHeroID_ then
		return
	end

	FrameTimer.New(function()
		local var_29_0 = self.heroItemList_[table.indexof(self.activityHeroIDList_, self.selectActivityHeroID_)]

		if self.goItemParentTrans_ and self.viewportTrs_ and var_29_0 then
			local var_29_1

			if -(self.goItemParentTrans_.anchoredPosition.x + self.viewportTrs_.rect.width / 2) > var_29_0.transform_.anchoredPosition.x - (var_29_0.transform_.sizeDelta.x / 2 + 10) then
				var_29_1 = self.goItemParentTrans_.anchoredPosition.x + -(self.goItemParentTrans_.anchoredPosition.x + self.viewportTrs_.rect.width / 2) - (var_29_0.transform_.anchoredPosition.x - (var_29_0.transform_.sizeDelta.x / 2 + 10))
				var_29_1 = math.min(self.goItemParentTrans_.anchoredPosition.x + -(self.goItemParentTrans_.anchoredPosition.x + self.viewportTrs_.rect.width / 2) - (var_29_0.transform_.anchoredPosition.x - (var_29_0.transform_.sizeDelta.x / 2 + 10)), -self.viewportTrs_.rect.width / 2)
			elseif -(self.goItemParentTrans_.anchoredPosition.x - self.viewportTrs_.rect.width / 2) < var_29_0.transform_.anchoredPosition.x + (var_29_0.transform_.sizeDelta.x / 2 + 10) then
				var_29_1 = self.goItemParentTrans_.anchoredPosition.x + -(self.goItemParentTrans_.anchoredPosition.x - self.viewportTrs_.rect.width / 2) - (var_29_0.transform_.anchoredPosition.x + (var_29_0.transform_.sizeDelta.x / 2 + 10))
				var_29_1 = math.max(self.goItemParentTrans_.anchoredPosition.x + -(self.goItemParentTrans_.anchoredPosition.x - self.viewportTrs_.rect.width / 2) - (var_29_0.transform_.anchoredPosition.x + (var_29_0.transform_.sizeDelta.x / 2 + 10)), self.viewportTrs_.rect.width / 2 - self.goItemParentTrans_.sizeDelta.x)
			end

			if var_29_1 then
				self.goItemParentTrans_:SetAnchoredPositionX(var_29_1)
			end
		end
	end, 1, 1):Start()
end

function HeroTrialView_Resident:OnActivityUpdate(arg_30_1)
	if ActivityCfg[arg_30_1].activity_template == ActivityTemplateConst.SUB_HERO_TRIAL then
		self:InitActivityList()

		if #self.activityHeroIDList_ == 0 then
			ShowTips("TIME_OVER")
			self:Back()

			return
		end

		self:InitSelectActivityHeroID()
		self:RefreshHeroItem()
		self:RefreshUI()
	end
end

function HeroTrialView_Resident:GetHeroTrialSelectItemClass()
	return HeroTrialSelectItem_Resident
end

function HeroTrialView_Resident:RefreshUI()
	self:RefreshHeroUI()
	self:RefreshReward()
end

function HeroTrialView_Resident:RefreshHeroUI()
	self:GetHeroCfg()
	self:RefreshHeroImage()
	self:RefreshHeroName()
	self:RefreshRangeType()
	self:RefreshChargeType()
	self:RefreshAttackType()
	self:RefreshRace()
	self:RefreshRare()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.typeTrans_)
end

function HeroTrialView_Resident:GetHeroCfg()
	self.heroID_ = HeroStandardSystemCfg[HeroTrialTools.GetHeroStandardID(self.selectActivityHeroID_)].hero_id
	self.heroCfg_ = HeroCfg[self.heroID_]
end

function HeroTrialView_Resident:RefreshHeroImage()
	self.heroImage_.spriteSync = "TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[HeroTrialTools.GetHeroStandardID(self.selectActivityHeroID_)].skin_id].picture_id

	self.rolenodeAni_:Play("UI_Activity_HeroTrialUI_role_cx", 0, 0)
	self.rolenodeAni_:Update(0)
end

function HeroTrialView_Resident:RefreshHeroName()
	self.heroName_.text = self.heroCfg_.name
	self.heroSuffixName_.text = self.heroCfg_.suffix
	self.rewardTitle_.text = string.format(GetTips("COMPLETE_TRAIL_STAGE"), HeroTools.GetHeroFullName(self.heroID_))
end

function HeroTrialView_Resident:RefreshRangeType()
	self.rangeTypeText_.text = CharactorParamCfg[self.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

function HeroTrialView_Resident:RefreshChargeType()
	self.chargeTypeText_.text = HeroTools.GetChargeTextByType(self.heroCfg_.mechanism_type[1])
end

function HeroTrialView_Resident:RefreshAttackType()
	if self.atackTypeIcon_ then
		self.atackTypeIcon_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroID_)
	end
end

function HeroTrialView_Resident:RefreshRace()
	self.raceImg_.sprite = HeroTools.GetHeroRaceIcon(self.heroCfg_.id)
end

function HeroTrialView_Resident:RefreshRare()
	self.rareImg_.sprite = HeroTools.GetHeroRareSprite(self.heroCfg_.id)
end

function HeroTrialView_Resident:RefreshReward()
	self:RefreshRewardState()
	self:RefreshRewardItem()
end

function HeroTrialView_Resident:RefreshRewardState()
	self.rewardState_ = HeroTrialData:GetHeroTrialStateList()[self.selectActivityHeroID_]

	if self.rewardState_ then
		if self.rewardState_ == ActivityHeroTrialConst.REWARD_STATE.RECEIVE then
			self.rewardController_:SetSelectedState("receive")
		elseif self.rewardState_ == ActivityHeroTrialConst.REWARD_STATE.COMPLETE then
			self.rewardController_:SetSelectedState("clear")
		else
			self.rewardController_:SetSelectedState("normal")
		end
	else
		self.rewardController_:SetSelectedState("normal")
	end
end

function HeroTrialView_Resident:RefreshRewardItem()
	for iter_44_0, iter_44_1 in ipairs(ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list) do
		self.itemDataList_[iter_44_0].id = iter_44_1[1]
		self.itemDataList_[iter_44_0].number = iter_44_1[2]

		self.rewardItemList_[iter_44_0]:SetData(self.itemDataList_[iter_44_0])
	end

	for iter_44_2 = #ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_44_2]:SetData(nil)
	end
end

function HeroTrialView_Resident:UpdateStopTime()
	self.stopTime_ = ActivityData:GetActivityData(ActivityHeroTrialCfg[self.selectActivityHeroID_].activity_id).stopTime
end

function HeroTrialView_Resident:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self:StopTimer()

	self.textTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_)
	self.timer_ = Timer.New(handler(self, self.UpdateTimer), 1, -1)

	self.timer_:Start()
end

function HeroTrialView_Resident:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HeroTrialView_Resident:UpdateTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self:StopTimer()

		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_)
end

return HeroTrialView_Resident
