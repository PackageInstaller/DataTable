local RaceCollectRewardView = class("RaceCollectRewardView", ReduxView)

function RaceCollectRewardView:UIName()
	return "Widget/System/CharacterGuideUI/HeroPreviewUIRewardUI"
end

function RaceCollectRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function RaceCollectRewardView:OnCtor()
	return
end

function RaceCollectRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RaceCollectRewardView:InitUI()
	self:BindCfgUI()

	self.raceItems_ = {}
end

function RaceCollectRewardView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.raceIds_[arg_6_1])
end

function RaceCollectRewardView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		HeroRaceCollectAction.ReceiveAllTasksReward()
	end)
end

function RaceCollectRewardView:AddEventListeners()
	self:RegistEventListener(RACE_COLLECT_REWARD_GET, function(arg_11_0)
		self:UpdateView()
	end)
end

function RaceCollectRewardView:OnTop()
	self:UpdateBar()
end

function RaceCollectRewardView:OnBehind()
	manager.windowBar:HideBar()
end

function RaceCollectRewardView:UpdateBar()
	self:ShowDefaultBar()
end

function RaceCollectRewardView:OnEnter()
	self:AddEventListeners()

	self.raceIds_ = RaceEffectCfg.all

	self:UpdateView()
end

function RaceCollectRewardView:UpdateView()
	self.getLabel1_.text = HeroRaceCollectData:GetTasksReceivedCount()
	self.getLabel2_.text = "/" .. HeroRaceCollectData:GetTaskTotalCount()

	SetActive(self.receiveAllBtn_, HeroRaceCollectData:HasRewardReceive())

	for iter_16_0, iter_16_1 in pairs(self.raceIds_) do
		if self.raceItems_[iter_16_0] == nil then
			self.raceItems_[iter_16_0] = RaceCollectRewardItemView.New(self.itemGo_, self.itemParent_)
		end

		self.raceItems_[iter_16_0]:SetData(iter_16_0, iter_16_1)
	end
end

function RaceCollectRewardView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function RaceCollectRewardView:OnMainHomeViewTop()
	return
end

function RaceCollectRewardView:Dispose()
	for iter_19_0, iter_19_1 in pairs(self.raceItems_) do
		iter_19_1:Dispose()
	end

	self.raceItems_ = {}

	RaceCollectRewardView.super.Dispose(self)
end

return RaceCollectRewardView
