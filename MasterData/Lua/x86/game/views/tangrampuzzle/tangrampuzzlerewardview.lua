local TangramPuzzleRewardView = class("TangramPuzzleRewardView", ReduxView)

function TangramPuzzleRewardView:UIName()
	return TangramPuzzleTools.GetRewardViewUIName(self.params_.activityID)
end

function TangramPuzzleRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function TangramPuzzleRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function TangramPuzzleRewardView:InitUI()
	self:BindCfgUI()
end

function TangramPuzzleRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function TangramPuzzleRewardView:OnEnter()
	if self.activityID_ ~= self.params_.activityID then
		self:DispawnRegion()
		self:SpawnRegion(self.params_.activityID)
	end

	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function TangramPuzzleRewardView:Dispose()
	self:DispawnRegion()
	TangramPuzzleRewardView.super.Dispose(self)
end

function TangramPuzzleRewardView:RefreshUI()
	for iter_9_0, iter_9_1 in pairs(self.regionList_) do
		iter_9_1:SetData(self.activityID_, iter_9_0)
	end

	self.completeImg_.sprite = pureGetSpriteWithoutAtlas(TangramPuzzleCfg[self.activityID_].path .. TangramPuzzleCfg[self.activityID_].album_id)
end

function TangramPuzzleRewardView:SpawnRegion(arg_10_1)
	self.regionList_ = self.regionList_ or {}

	for iter_10_0 = 1, self.regionContentTrans_.childCount do
		self.regionList_[TangramPuzzleCfg[arg_10_1].reward_area_list[iter_10_0][1]] = self.regionList_[TangramPuzzleCfg[arg_10_1].reward_area_list[iter_10_0][1]] or TangramRegionRewardItem.New((self.regionContentTrans_:GetChild(iter_10_0 - 1)))
	end
end

function TangramPuzzleRewardView:DispawnRegion()
	if self.regionList_ then
		for iter_11_0, iter_11_1 in pairs(self.regionList_) do
			iter_11_1:Dispose()
		end

		self.regionList_ = nil
	end

	self.maskList_ = nil
end

function TangramPuzzleRewardView:OnExitInput()
	self:Back()

	return true
end

return TangramPuzzleRewardView
