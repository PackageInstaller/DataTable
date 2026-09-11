local HeroTrialActivityView = class("HeroTrialActivityView", ReduxView)

function HeroTrialActivityView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisUIontrial"
end

function HeroTrialActivityView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroTrialActivityView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.heroItemList_ = {}
	self.rewardItemList_ = {}
	self.onClickTrialHandler_ = handler(self, self.OnClickTrial)
	self.controller_ = ControllerUtil.GetController(self.transformBtn_, "name")
	self.adaptImg_ = self:FindCom("AdaptImage", nil, self.imageIcon_.transform)
end

function HeroTrialActivityView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HERO_TRIAL_DESCRIPE")
	manager.notify:RegistListener(HERO_TRIAL_CLICK, self.onClickTrialHandler_)

	self.activityID_ = self.params_.activityID
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:AddTimer()
	self:RefreshUI()
end

function HeroTrialActivityView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(HERO_TRIAL_CLICK, self.onClickTrialHandler_)
	self:StopTimer()
end

function HeroTrialActivityView:Dispose()
	HeroTrialActivityView.super.Dispose(self)

	self.onClickTrialHandler_ = nil

	for iter_6_0, iter_6_1 in pairs(self.rewardItemList_) do
		iter_6_1:Dispose()
	end

	self.rewardItemList_ = nil

	for iter_6_2, iter_6_3 in pairs(self.heroItemList_) do
		iter_6_3:Dispose()
	end

	self.heroItemList_ = nil
end

function HeroTrialActivityView:OnTop()
	if self.selectActivityHeroID_ == nil then
		ShowTips("TIME_OVER")
		self:Back()

		return
	end
end

function HeroTrialActivityView:AddListeners()
	self:AddBtnListener(self.btnReceive_, nil, function()
		HeroTrialAction.GetTrialReward(self.selectActivityHeroID_, function(arg_10_0)
			if isSuccess(arg_10_0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[self.selectActivityHeroID_].reward_list))
				self.controller_:SetSelectedState("complete")
			else
				ShowTips(arg_10_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.btnTrial_, nil, function()
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in ipairs(self.activityHeroIDList_) do
			table.insert(var_11_0, (HeroTrialTools.GetHeroStandardID(iter_11_1)))
		end

		self:Go("/newHero", {
			isEnter = true,
			isTemp = true,
			hid = HeroTrialTools.GetHeroStandardID(self.selectActivityHeroID_),
			tempHeroList = var_11_0
		})
	end)
	self:AddBtnListener(self.btnBattle_, nil, function()
		HeroTrialData:SaveStageID(self.selectActivityHeroID_)
		self:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[self.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = self.activityID_
		})
	end)
end

function HeroTrialActivityView:RefreshUI()
	local var_13_0 = self:GetActivityHeroIDList()

	self.activityHeroIDList_ = var_13_0

	local var_13_1 = HeroTrialData:GetSelectActivityHeroID(self.activityID_) or var_13_0[1]

	self.selectActivityHeroID_ = var_13_1

	if var_13_1 == nil then
		return
	end

	HeroTrialData:SetSelectActivityHeroID(self.activityID_, var_13_1)
	self:RefreshHeroItem()

	local var_13_2 = HeroTrialTools.GetHeroStandardID(var_13_1)

	self.heroID_ = HeroStandardSystemCfg[var_13_2].hero_id
	self.heroCfg_ = HeroCfg[self.heroID_]

	local var_13_3 = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[var_13_2].skin_id].picture_id)

	if var_13_3 ~= nil then
		self.imageIcon_.sprite = var_13_3
	end

	self.imageIcon_:SetNativeSize()

	if self.adaptImg_ then
		self.adaptImg_:AdaptImg()
	end

	local var_13_4 = string.format("%s·%s", self.heroCfg_.name, self.heroCfg_.suffix)

	self:RefreshTextName(var_13_4)

	self.textTips_.text = string.format(GetTips("COMPLETE_TRAIL_STAGE"), GetI18NText(var_13_4))
	self.imageRace_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[self.heroCfg_.race].icon)

	self:RefreshReward(var_13_1)

	self.imageLv_.sprite = getSprite("Atlas/Common", "star_" .. self.heroCfg_.rare)
end

function HeroTrialActivityView:RefreshTextName(arg_14_1)
	self.textName_.text = GetI18NText(arg_14_1)
end

function HeroTrialActivityView:RefreshHeroItem()
	for iter_15_0, iter_15_1 in ipairs(self.activityHeroIDList_) do
		if self.heroItemList_[iter_15_0] then
			self.heroItemList_[iter_15_0]:SetActivityHeroID(self.activityID_, iter_15_1)
		else
			self.heroItemList_[iter_15_0] = HeroTrialActivityItem.New(self.goItem_, self.goItemParent_, iter_15_1, self.activityID_)
		end
	end

	for iter_15_2 = #self.heroItemList_, #self.activityHeroIDList_ + 1, -1 do
		self.heroItemList_[iter_15_2]:Dispose()

		self.heroItemList_[iter_15_2] = nil
	end

	for iter_15_3, iter_15_4 in pairs(self.activityHeroIDList_) do
		if iter_15_4 == self.selectActivityHeroID_ then
			self:RefreshSelectActivityHero(self.selectActivityHeroID_)

			return
		end
	end

	self:RefreshSelectActivityHero(self.activityHeroIDList_[1])
end

function HeroTrialActivityView:RefreshReward(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(ActivityHeroTrialCfg[arg_16_1].reward_list) do
		if self.rewardItemList_[iter_16_0] then
			self.rewardItemList_[iter_16_0]:SetData(iter_16_1, false)
		else
			self.rewardItemList_[iter_16_0] = self:GetRewardItem(iter_16_1)
		end
	end

	for iter_16_2 = #ActivityHeroTrialCfg[arg_16_1].reward_list + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_16_2]:Show(false)
	end

	local var_16_0 = HeroTrialData:GetHeroTrialStateList()[arg_16_1]

	if var_16_0 then
		if var_16_0 == 1 then
			self.controller_:SetSelectedState("receive")
		elseif var_16_0 == 2 then
			self.controller_:SetSelectedState("complete")
		else
			self.controller_:SetSelectedState("not")
		end
	else
		self.controller_:SetSelectedState("not")
	end
end

function HeroTrialActivityView:GetRewardItem(arg_17_1)
	return RewardPoolItem.New(self.goRewardPanel_, arg_17_1, false)
end

function HeroTrialActivityView:OnClickTrial()
	self:RefreshUI()
end

function HeroTrialActivityView:GetActivityHeroIDList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[self.activityID_]) do
		if true then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function HeroTrialActivityView:RefreshSelectActivityHero(arg_20_1)
	for iter_20_0, iter_20_1 in pairs(self.heroItemList_) do
		iter_20_1:OnSelect(arg_20_1)
	end
end

function HeroTrialActivityView:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		self:Back()

		return
	end

	self.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(self.stopTime_))
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(self.stopTime_))

			return
		end

		self.textTime_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStr(self.stopTime_))
	end, 1, -1)

	self.timer_:Start()
end

function HeroTrialActivityView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return HeroTrialActivityView
