local StageArchiveCollectGroupItem = class("StageArchiveCollectGroupItem", ReduxView)

function StageArchiveCollectGroupItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StageArchiveCollectGroupItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StageArchiveCollectGroupItem:InitUI()
	self:BindCfgUI()

	self.archiveItemList_ = {}
end

function StageArchiveCollectGroupItem:AddUIListener()
	return
end

function StageArchiveCollectGroupItem:SetData(arg_5_1, arg_5_2)
	self.groupID_ = arg_5_1
	self.archiveIDList_ = arg_5_2

	self:RefreshUI()
end

function StageArchiveCollectGroupItem:RefreshUI()
	self:RefreshArchiveItem()
	self:RefreshTitle()
end

function StageArchiveCollectGroupItem:RefreshArchiveItem()
	for iter_7_0, iter_7_1 in ipairs(self.archiveIDList_) do
		self.archiveItemList_[iter_7_0] = self.archiveItemList_[iter_7_0] or StageArchiveCollectItem.New((Object.Instantiate(self.archiveItemGo_, self.archivePanelTrans_)))

		self.archiveItemList_[iter_7_0]:SetActive(true)
		self.archiveItemList_[iter_7_0]:SetData(iter_7_1)
	end

	for iter_7_2 = #self.archiveIDList_ + 1, #self.archiveItemList_ do
		self.archiveItemList_[iter_7_2]:SetActive(false)
	end
end

function StageArchiveCollectGroupItem:RefreshTitle()
	self.titleText_.text = StageArchivesCollectTagCfg[self.groupID_].tag_name
end

function StageArchiveCollectGroupItem:SetActive(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function StageArchiveCollectGroupItem:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.archiveItemList_) do
		iter_10_1:Dispose()
	end

	self.archiveItemList_ = nil

	StageArchiveCollectGroupItem.super.Dispose(self)
end

return StageArchiveCollectGroupItem
