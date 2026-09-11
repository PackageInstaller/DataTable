local StageArchivePictureInfoView = class("StageArchivePictureInfoView", ReduxView)

function StageArchivePictureInfoView:UIName()
	return "Widget/System/Operation/OperationDiaryUI"
end

function StageArchivePictureInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function StageArchivePictureInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function StageArchivePictureInfoView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function StageArchivePictureInfoView:OnEnter()
	self.archiveID_ = self.params_.archiveID

	self:RefreshUI()
end

function StageArchivePictureInfoView:RefreshUI()
	self.nameText_.text = formatText(StageArchivesCollectCfg[self.archiveID_].name)
	self.archiveText_.text = formatText(StageArchivesCollectCfg[self.archiveID_].desc)

	if self.iconImage_ then
		self.iconImage_.sprite = pureGetSpriteWithoutAtlas(StageArchivesCollectCfg[self.archiveID_].archive_icon)
	end

	self.scrollView_.verticalNormalizedPosition = 1
end

return StageArchivePictureInfoView
