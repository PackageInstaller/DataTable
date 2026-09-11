local StageArchiveCollectView = class("StageArchiveCollectView", ReduxView)

function StageArchiveCollectView:UIName()
	return "Widget/System/Operation/OperationTerminalRecordUI"
end

function StageArchiveCollectView:UIParent()
	return manager.ui.uiPop.transform
end

function StageArchiveCollectView:Init()
	self:InitUI()
	self:AddListeners()
end

function StageArchiveCollectView:InitUI()
	self:BindCfgUI()

	self.groupItemList_ = {}
	self.emptyController_ = self.controllerEx_:GetController("empty")
end

function StageArchiveCollectView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function StageArchiveCollectView:OnEnter()
	self.chpaterID_ = self.params_.chapterID
	self.unlockedArchiveList_ = StageTools.GetUnlockStageArchiveList(self.chpaterID_)

	self:RefreshUI()
end

function StageArchiveCollectView:RefreshUI()
	self:RefreshEmpty()

	if not self:GetIsEmpty() then
		self:RefreshGroupItem()
		self:ForceRebuildGroup()
	end
end

function StageArchiveCollectView:RefreshEmpty()
	self.emptyController_:SetSelectedState(tostring(self:GetIsEmpty()))
end

function StageArchiveCollectView:GetIsEmpty()
	return #self.unlockedArchiveList_ == 0
end

function StageArchiveCollectView:RefreshGroupItem()
	self.archiveGroupIDList_, self.archiveGroupList_ = StageTools.ReorderStageArchiveListByGroup(self.unlockedArchiveList_)

	for iter_11_0, iter_11_1 in ipairs(self.archiveGroupIDList_) do
		self.groupItemList_[iter_11_0] = self.groupItemList_[iter_11_0] or StageArchiveCollectGroupItem.New((Object.Instantiate(self.groupItemGo_, self.groupPanelTrans_)))

		self.groupItemList_[iter_11_0]:SetActive(true)
		self.groupItemList_[iter_11_0]:SetData(iter_11_1, self.archiveGroupList_[iter_11_1])
	end

	for iter_11_2 = #self.archiveGroupIDList_ + 1, #self.groupItemList_ do
		self.groupItemList_[iter_11_2]:SetActive(false)
	end
end

function StageArchiveCollectView:ForceRebuildGroup()
	self:StopForceRebuildGroup()

	self.rebuildTimer_ = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.groupPanelTrans_)
		self:StopForceRebuildGroup()
	end, 1, 1)

	self.rebuildTimer_:Start()
end

function StageArchiveCollectView:StopForceRebuildGroup()
	if self.rebuildTimer_ then
		self.rebuildTimer_:Stop()

		self.rebuildTimer_ = nil
	end
end

function StageArchiveCollectView:OnExit()
	self:StopForceRebuildGroup()
end

function StageArchiveCollectView:Dispose()
	for iter_16_0, iter_16_1 in ipairs(self.groupItemList_) do
		iter_16_1:Dispose()
	end

	self.groupItemList_ = nil

	StageArchiveCollectView.super.Dispose(self)
end

return StageArchiveCollectView
