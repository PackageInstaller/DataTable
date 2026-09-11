local GoldMinerStageSectionView = class("GoldMinerStageSectionView", ReduxView)

function GoldMinerStageSectionView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/V4_2_GodEaterUI_GoldenMiner_StageBaseUI"
end

function GoldMinerStageSectionView:UIParent()
	return manager.ui.uiMain.transform
end

function GoldMinerStageSectionView:Init()
	self:InitUI()
	self:AddListeners()
end

function GoldMinerStageSectionView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.RefreshRewardItem), self.rewardUIListGo_, CommonItemView)
	self.hideDropPanelController_ = self.controllerEx_:GetController("hideDropPanel")
	self.btnController_ = self.btnControllerEx_:GetController("lock")
	self.sectionInfoThreeStarBar_ = GoldMinerSectionInfoThreeStarBar.New(self.threeStarGo_)
end

function GoldMinerStageSectionView:RefreshRewardItem(arg_5_1, arg_5_2)
	local var_5_0

	if self.rewardList_[arg_5_1] then
		var_5_0 = rewardToItemTemplate(self.rewardList_[arg_5_1])

		if self.isFirstClear_ then
			var_5_0.number = self.rewardList_[arg_5_1].num or nil
		end

		function var_5_0.clickFun(arg_6_0)
			ShowPopItem(POP_ITEM, arg_6_0)
		end
	end

	arg_5_2:SetData(var_5_0)
end

function GoldMinerStageSectionView:AddListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		local var_8_0 = GodEaterData:GetCurHeroID()

		if var_8_0 == 0 then
			manager.notify:CallUpdateFunc(GOLDMINER_OPEN_SELECT_HERO_PANEL)
		else
			GodEaterData:SetGoldActivityId(self.activityID_)
			self:Back()
			JumpTools.OpenPageByJump("/goldMinerGameView", {
				subActivityID = self.activityID_,
				heroID = var_8_0
			})
		end
	end)
end

function GoldMinerStageSectionView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.isActivityOpen_ = self.params_.isActivityOpen
	self.isUnLock_ = self.params_.isUnLock
	self.systemCfg_ = ActivityGodEaterGoldminerStageCfg[self.activityID_]

	self:RefreshData()

	if not self.isActivityOpen_ then
		self.btnLockText_.text = string.format(GetTips("GOLDMINER_ENTER_TIPS_1"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityID_).startTime)))
	elseif not self.isUnLock_ then
		self.btnLockText_.text = GetTips("GOLDMINER_ENTER_TIPS_2")
	end

	self.btnController_:SetSelectedState(tostring(not self.isActivityOpen_ or not self.isUnLock_))

	self.sectionName_.text = self.systemCfg_.name
	self.icon1_.sprite = ItemTools.getItemSprite(75)
	self.icon2_.sprite = ItemTools.getItemSprite(75)
	self.icon3_.sprite = ItemTools.getItemSprite(75)

	if self.isFirstClear_ then
		self.hideDropPanelController_:SetSelectedState("false")

		self.rewardList_ = {}

		for iter_9_0, iter_9_1 in pairs(self.systemCfg_.first_reward) do
			table.insert(self.rewardList_, {
				id = iter_9_1[1],
				num = iter_9_1[2]
			})
		end

		self.uiList_:StartScroll(#self.rewardList_)
	else
		self.hideDropPanelController_:SetSelectedState("true")
	end

	self.threeStarDataList_ = {}

	local var_9_0 = GodEaterData:GetStageStar(self.activityID_)

	for iter_9_2 = 1, 3 do
		self.threeStarDataList_[iter_9_2] = {
			iter_9_2 <= var_9_0,
			self.systemCfg_.score[iter_9_2],
			self.systemCfg_.reward[iter_9_2][1][2]
		}
	end

	self.sectionInfoThreeStarBar_:SetData(self.threeStarDataList_)
end

function GoldMinerStageSectionView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function GoldMinerStageSectionView:OnExit()
	manager.windowBar:HideBar()
end

function GoldMinerStageSectionView:OnUpdate()
	if self.activityID_ == self.params_.activityID then
		return
	end

	self.activityID_ = self.params_.activityID
	self.isActivityOpen_ = self.params_.isActivityOpen
	self.isUnLock_ = self.params_.isUnLock
	self.systemCfg_ = ActivityGodEaterGoldminerStageCfg[self.activityID_]

	self:RefreshData()

	self.sectionName_.text = self.systemCfg_.name

	if not self.isActivityOpen_ then
		self.btnLockText_.text = string.format(GetTips("GOLDMINER_ENTER_TIPS_1"), (manager.time:GetLostTimeStr(ActivityData:GetActivityData(self.activityID_).startTime)))
	elseif not self.isUnLock_ then
		self.btnLockText_.text = GetTips("GOLDMINER_ENTER_TIPS_2")
	end

	self.btnController_:SetSelectedState(tostring(not self.isActivityOpen_ or not self.isUnLock_))

	if self.isFirstClear_ then
		self.hideDropPanelController_:SetSelectedState("false")

		self.rewardList_ = {}

		for iter_12_0, iter_12_1 in pairs(self.systemCfg_.first_reward) do
			table.insert(self.rewardList_, {
				id = iter_12_1[1],
				num = iter_12_1[2]
			})
		end

		self.uiList_:StartScroll(#self.rewardList_)
	else
		self.hideDropPanelController_:SetSelectedState("true")
	end

	self.threeStarDataList_ = {}

	local var_12_0 = GodEaterData:GetStageStar(self.activityID_)

	for iter_12_2 = 1, 3 do
		self.threeStarDataList_[iter_12_2] = {
			iter_12_2 <= var_12_0,
			self.systemCfg_.score[iter_12_2],
			self.systemCfg_.reward[iter_12_2][1][2]
		}
	end

	self.sectionInfoThreeStarBar_:SetData(self.threeStarDataList_)
end

function GoldMinerStageSectionView:RefreshData()
	self.lock_ = not ActivityData:GetActivityIsOpen(self.activityID_)
	self.cost_ = 0
	self.isFirstClear_ = GodEaterData:GetStageStar(self.activityID_) <= 0
end

function GoldMinerStageSectionView:Dispose()
	self.sectionInfoThreeStarBar_:Dispose()

	self.sectionInfoThreeStarBar_ = nil

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	GoldMinerStageSectionView.super.Dispose(self)
end

return GoldMinerStageSectionView
