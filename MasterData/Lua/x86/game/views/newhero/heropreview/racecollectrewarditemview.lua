local RaceCollectRewardItemView = class("RaceCollectRewardItemView", ReduxView)

function RaceCollectRewardItemView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function RaceCollectRewardItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RaceCollectRewardItemView:InitUI()
	self:BindCfgUI()

	self.taskItems_ = {}
end

function RaceCollectRewardItemView:AddUIListener()
	return
end

function RaceCollectRewardItemView:AddEventListeners()
	return
end

function RaceCollectRewardItemView:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.raceId_ = arg_6_2
	self.raceCfg_ = RaceEffectCfg[self.raceId_]

	self:UpdateView()
end

function RaceCollectRewardItemView:UpdateView()
	self.nameLabel.text = GetI18NText(self.raceCfg_.name)
	self.raceIcon_.sprite = getSprite("Atlas/CampItemAtlas", self.raceCfg_.icon)

	for iter_7_0 = 1, HeroRaceCollectData.GetHeroCollectoMaxTier(self.raceId_) do
		if self.taskItems_[iter_7_0] == nil then
			self.taskItems_[iter_7_0] = RaceCollectRewardConditionItemView.New(self.itemGo_, self.itemParent_)
		end

		self.taskItems_[iter_7_0]:SetData(iter_7_0, self.raceId_)
	end
end

function RaceCollectRewardItemView:OnEnter()
	self:AddEventListeners()
end

function RaceCollectRewardItemView:OnExit()
	self:RemoveAllEventListener()
end

function RaceCollectRewardItemView:OnMainHomeViewTop()
	return
end

function RaceCollectRewardItemView:Dispose()
	self.data_ = nil

	for iter_11_0, iter_11_1 in pairs(self.taskItems_) do
		iter_11_1:Dispose()
	end

	self.taskItems_ = {}

	RaceCollectRewardItemView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return RaceCollectRewardItemView
