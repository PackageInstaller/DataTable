local PuzzleNewRewardView = class("PuzzleNewRewardView", ReduxView)

function PuzzleNewRewardView:UIName()
	return PuzzleNewTools.GetRewardViewUIName(self.params_.activityID)
end

function PuzzleNewRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function PuzzleNewRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PuzzleNewRewardView:InitUI()
	self:BindCfgUI()
end

function PuzzleNewRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function PuzzleNewRewardView:OnEnter()
	if self.activityID_ ~= self.params_.activityID then
		self:DispawnRegion()
		self:SpawnRegion(self.params_.activityID)
	end

	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function PuzzleNewRewardView:Dispose()
	self:DispawnRegion()
	PuzzleNewRewardView.super.Dispose(self)
end

function PuzzleNewRewardView:RefreshUI()
	self:RefreshRegionItem()
	self:RefreshPuzzleMask()
	self:RefreshPreviewImg()
end

function PuzzleNewRewardView:RefreshRegionItem()
	for iter_10_0, iter_10_1 in pairs(self.regionList_) do
		iter_10_1:SetData(self.activityID_)
	end
end

function PuzzleNewRewardView:RefreshPuzzleMask()
	local var_11_0 = PuzzleNewCfg[self.activityID_]
	local var_11_1 = PuzzleNewData:GetCurPuzzleList(self.activityID_)

	for iter_11_0, iter_11_1 in ipairs(self.maskList_) do
		SetActive(iter_11_1, var_11_1[iter_11_0] == nil or var_11_1[iter_11_0] ~= var_11_0.correct_array[iter_11_0])
	end
end

function PuzzleNewRewardView:RefreshPreviewImg()
	if self.previewImg_ then
		self.previewImg_.sprite = pureGetSpriteWithoutAtlas(PuzzleNewCfg[self.activityID_].preview_album_id)
	end
end

function PuzzleNewRewardView:SpawnRegion(arg_13_1)
	local var_13_0 = PuzzleNewTools.GetPuzzlePosDic(arg_13_1)
	local var_13_1 = PuzzleNewTools.GetRegionPosDic(arg_13_1)

	self.regionList_ = self.regionList_ or {}

	for iter_13_0 = 1, self.regionContentTrans_.childCount do
		local var_13_2 = self.regionContentTrans_:GetChild(iter_13_0 - 1)
		local var_13_3 = tonumber(var_13_2.name)

		self.regionList_[var_13_3] = self.regionList_[var_13_3] or PuzzleNewRegionItem.New(var_13_2, PuzzleNewCfg[arg_13_1].area_fragment_list[var_13_1[var_13_3]], var_13_0, PuzzleNewCfg[arg_13_1].reward_area_list[var_13_1[var_13_3]][2])
	end

	self.maskList_ = self.maskList_ or {}

	for iter_13_1 = 1, self.maskPanelTrans_.childCount do
		self.maskList_[iter_13_1] = self.maskPanelTrans_:GetChild(iter_13_1 - 1)
	end
end

function PuzzleNewRewardView:DispawnRegion()
	if self.regionList_ then
		for iter_14_0, iter_14_1 in pairs(self.regionList_) do
			iter_14_1:Dispose()
		end

		self.regionList_ = nil
	end

	self.maskList_ = nil
end

return PuzzleNewRewardView
