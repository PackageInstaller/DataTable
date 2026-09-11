local SkinTrialSelectView_2_0 = class("SkinTrialSelectView_2_0", ReduxView)

function SkinTrialSelectView_2_0:UIName()
	return SkinTrialTools.GetSelectViewUIName(self.params_.activityID)
end

function SkinTrialSelectView_2_0:UIParent()
	return manager.ui.uiMain.transform
end

function SkinTrialSelectView_2_0:Init()
	self:InitUI()
	self:AddListeners()
end

function SkinTrialSelectView_2_0:InitUI()
	self:BindCfgUI()
	self:InitStaticText()
	self:InitController()
	self:InitRewardItem()

	self.skinImage_.immediate = true
end

function SkinTrialSelectView_2_0:InitStaticText()
	if self.battleBtnText_ then
		self.battleBtnText_.text = GetTips("ACTIVITY_HERO_TRIAL_START")
	end

	if self.sourceBtnText_ then
		self.sourceBtnText_.text = GetTips("ACTIVITY_SKIN_TRIAL_GOTOGET")
	end
end

function SkinTrialSelectView_2_0:InitController()
	self.rewardController_ = self.rewardControllerEx_:GetController("reward")
end

function SkinTrialSelectView_2_0:InitRewardItem()
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

function SkinTrialSelectView_2_0:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:OnBackBtnClick()
	end)
	self:RegistEventListener(SKIN_TRIAL_UPDATE, handler(self, self.OnSkinTrialUpdate))

	self.activityID_ = self.params_.activityID
	self.skinTrialID_ = self.params_.skinTrialID
	self.startTime_ = ActivityData:GetActivityData(self.activityID_).startTime
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	self:RefreshUI()
	self:AddTimer()
end

function SkinTrialSelectView_2_0:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		SkinTrialData:SaveStageID(self.skinTrialID_)

		if not ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		self:SaveRoute()
		self:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[self.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.sourceBtn_, nil, function()
		if not ActivityData:GetActivityData(self.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.JumpToPage2(ActivitySkinTrialCfg[self.skinTrialID_].source)
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		SkinTrialAction.RequestSkinTrialReward(self.skinTrialID_)
	end)
end

function SkinTrialSelectView_2_0:OnBackBtnClick()
	SkinTrialData:SaveSkinTrialMainScrollPos(SkinTrialData:GetSkinTrialMainScrollPos("Global"), "Back")
	self:Back()
end

function SkinTrialSelectView_2_0:OnExit()
	self:StopTimer()
	self:RemoveAllEventListener()
end

function SkinTrialSelectView_2_0:Dispose()
	for iter_17_0, iter_17_1 in pairs(self.rewardItemList_) do
		iter_17_1:Dispose()
	end

	self.rewardItemList_ = nil
	self.itemDataList_ = nil

	SkinTrialSelectView_2_0.super.Dispose(self)
end

function SkinTrialSelectView_2_0:RefreshUI()
	self:RefreshSkinInfo()
	self:RefreshRoleImage()
	self:RefreshReward()
end

function SkinTrialSelectView_2_0:RefreshSkinInfo()
	local var_19_0 = SkinTrialTools.GetHeroStandardID(self.skinTrialID_)

	self.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[HeroStandardSystemCfg[var_19_0].hero_id].name), GetI18NText(HeroCfg[HeroStandardSystemCfg[var_19_0].hero_id].suffix))
	self.skinDescText_.text = GetI18NText(SkinCfg[HeroStandardSystemCfg[var_19_0].skin_id].desc)
	self.skinNameText_.text = GetI18NText(SkinCfg[HeroStandardSystemCfg[var_19_0].skin_id].name)
end

function SkinTrialSelectView_2_0:RefreshRoleImage()
	self.skinImage_.spriteSync = "TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[SkinTrialTools.GetHeroStandardID(self.skinTrialID_)].skin_id].picture_id
end

function SkinTrialSelectView_2_0:RefreshReward()
	self:RefreshRewardState()
	self:RefreshRewardItem()
end

function SkinTrialSelectView_2_0:RefreshRewardState()
	local var_22_0 = SkinTrialData:GetSkinTrialStatus(self.skinTrialID_)

	if var_22_0 == 0 then
		self.rewardController_:SetSelectedState("normal")
	elseif var_22_0 == 1 then
		self.rewardController_:SetSelectedState("clear")
	elseif var_22_0 == 2 then
		self.rewardController_:SetSelectedState("receive")
	end
end

function SkinTrialSelectView_2_0:RefreshRewardItem()
	for iter_23_0, iter_23_1 in ipairs(ActivitySkinTrialCfg[self.skinTrialID_].reward) do
		self.itemDataList_[iter_23_0].id = iter_23_1[1]
		self.itemDataList_[iter_23_0].number = iter_23_1[2]

		self.rewardItemList_[iter_23_0]:SetData(self.itemDataList_[iter_23_0])
	end

	for iter_23_2 = #ActivitySkinTrialCfg[self.skinTrialID_].reward + 1, #self.rewardItemList_ do
		self.rewardItemList_[iter_23_2]:SetData(nil)
	end
end

function SkinTrialSelectView_2_0:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		self.textTime_.text = GetTips("TIME_OVER")

		return
	end

	self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			self.textTime_.text = GetTips("TIME_OVER")

			return
		end

		self.textTime_.text = manager.time:GetLostTimeStr(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function SkinTrialSelectView_2_0:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkinTrialSelectView_2_0:SaveRoute()
	SkinTrialData:SaveRoute({
		name = "skinTrialSelectView_2_0",
		activityID = self.activityID_,
		skinTrialID = self.skinTrialID_
	})
end

function SkinTrialSelectView_2_0:OnSkinTrialUpdate(arg_28_1)
	self:RefreshRewardState()
end

return SkinTrialSelectView_2_0
