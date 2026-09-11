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
end

function StageArchiveCollectGroupItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		StageTools.OpenStageArchiveInfo(self.archiveID_)

		if StageTools.IsHaveRedStageArchive(self.archiveID_) then
			BattleStageData:SetStageArchiveRedState(self.archiveID_)
			BattleStageAction.SetStageArchiveRead(self.archiveID_)
			manager.redPoint:SetRedPointIndependent(self.transform_, false)
			manager.notify:Invoke(STAGE_ARCHIVE_RED_UPDATE)
		end
	end)
end

function StageArchiveCollectGroupItem:SetData(arg_6_1)
	self.archiveID_ = arg_6_1

	self:RefreshUI()
end

function StageArchiveCollectGroupItem:RefreshUI()
	self.titleText_.text = StageArchivesCollectCfg[self.archiveID_].name

	manager.redPoint:SetRedPointIndependent(self.transform_, StageTools.IsHaveRedStageArchive(self.archiveID_))
end

function StageArchiveCollectGroupItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

return StageArchiveCollectGroupItem
