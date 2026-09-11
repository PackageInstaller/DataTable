local RaceCollectRewardConditionItemView = class("RaceCollectRewardConditionItemView", ReduxView)

function RaceCollectRewardConditionItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function RaceCollectRewardConditionItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function RaceCollectRewardConditionItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.uiList_ = LuaList.New(handler(self, self.IndexRewardItem), self.uiListGo_, CommonItemView)
end

function RaceCollectRewardConditionItemView:IndexRewardItem(arg_4_1, arg_4_2)
	arg_4_2:SetData((rewardToItemTemplate(HeroRaceCollectData.GetRewardOfTier(self.index_)[arg_4_1], nil, true)))
end

function RaceCollectRewardConditionItemView:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		HeroRaceCollectAction.ReceiveOneTaskReward(self.raceId_, HeroRaceCollectData.GetHeroCntNeedOfEachTier() * self.index_)
	end)
end

function RaceCollectRewardConditionItemView:AddEventListeners()
	self:RegistEventListener(RACE_COLLECT_REWARD_GET, function(arg_8_0)
		self:UpdateView()
	end)
end

function RaceCollectRewardConditionItemView:SetData(arg_9_1, arg_9_2)
	self.index_ = arg_9_1
	self.raceId_ = arg_9_2

	self:UpdateView()
end

function RaceCollectRewardConditionItemView:UpdateView()
	local var_10_0 = HeroRaceCollectData.GetHeroCntNeedOfEachTier() * self.index_
	local var_10_1 = HeroRaceCollectData:GetHeroRaceCount(self.raceId_)

	self.conditionLabel_.text = string.format(GetTips("COLLECT_HERO_RACE_DES"), var_10_0 <= var_10_1 and var_10_0 or var_10_1, var_10_0, (GetI18NText(RaceEffectCfg[self.raceId_].name)))

	self.uiList_:StartScroll(#HeroRaceCollectData.GetRewardOfTier(self.index_))

	local var_10_3 = HeroRaceCollectData:GetTaskState(self.raceId_, self.index_)

	if var_10_3 == 0 then
		self.statusController_:SetSelectedState("unFinish")
	elseif var_10_3 == 1 then
		self.statusController_:SetSelectedState("canGet")
	else
		self.statusController_:SetSelectedState("haveGet")
	end
end

function RaceCollectRewardConditionItemView:OnEnter()
	return
end

function RaceCollectRewardConditionItemView:OnExit()
	return
end

function RaceCollectRewardConditionItemView:OnMainHomeViewTop()
	return
end

function RaceCollectRewardConditionItemView:Dispose()
	self:RemoveAllEventListener()

	self.data_ = nil

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	RaceCollectRewardConditionItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return RaceCollectRewardConditionItemView
