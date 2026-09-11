local GoldMinerSectionInfoThreeStarBar = class("GoldMinerSectionInfoThreeStarBar", ReduxView)

function GoldMinerSectionInfoThreeStarBar:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.sectionTargets_ = {}

	for iter_1_0 = 1, 3 do
		self.sectionTargets_[iter_1_0] = GoldMinerSectionTargetItem.New(self[string.format("targetItem%s_", iter_1_0)], iter_1_0)
	end

	SetActive(self.targetPanel_, true)
end

function GoldMinerSectionInfoThreeStarBar:Dispose()
	for iter_2_0, iter_2_1 in pairs(self.sectionTargets_) do
		iter_2_1:Dispose()
	end

	self.sectionTargets_ = {}

	GoldMinerSectionInfoThreeStarBar.super.Dispose(self)
end

function GoldMinerSectionInfoThreeStarBar:SetData(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		self.sectionTargets_[iter_3_0]:Refresh(iter_3_1[1], iter_3_1[2], iter_3_1[3])
	end
end

return GoldMinerSectionInfoThreeStarBar
