local NewHeroStoryView = class("NewHeroStoryView", ReduxView)

function NewHeroStoryView:UIName()
	return "UI/HeroArchive/HeroStoryPopUI"
end

function NewHeroStoryView:UIParent()
	return manager.ui.uiMain.transform
end

function NewHeroStoryView:Init()
	self:InitUI()
end

function NewHeroStoryView:InitUI()
	self:BindCfgUI()
end

function NewHeroStoryView:OnEnter()
	self.data_ = self.params_.data
	self.archiveID_ = self.params_.archiveID

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ArchiveAction.SendViewArchiveStory(self.archiveID_, self.data_.id)
	self:RefreshUI()
end

function NewHeroStoryView:RefreshUI()
	self.nameText_.text = string.format(self.data_.name)
	self.storyText_.text = formatText(self.data_.anecdote)
	self.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. self.data_.id)
	self.roleNameText_.text = HeroCfg[self.data_.id].name
end

function NewHeroStoryView:OnExit()
	if self.callback_ then
		self.callback_()
	end
end

return NewHeroStoryView
