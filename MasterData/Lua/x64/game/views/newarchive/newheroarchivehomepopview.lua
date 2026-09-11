local NewHeroArchiveHomePopView = class("NewHeroArchiveHomePopView", ReduxView)

function NewHeroArchiveHomePopView:UIName()
	return "UI/HeroArchive/ArchiveStoryHomePopUI_new"
end

function NewHeroArchiveHomePopView:UIParent()
	return manager.ui.uiPop.transform
end

function NewHeroArchiveHomePopView:Init()
	self:InitUI()
end

function NewHeroArchiveHomePopView:InitUI()
	self:BindCfgUI()
	self:AddUIListeners()
end

function NewHeroArchiveHomePopView:AddUIListeners()
	self:AddBtnListener(self.mask_, nil, function()
		self:Back()
		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 0,
			record_id = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[self.heroID_][1]).archive_id
		})
	end)
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 0,
			record_id = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[self.heroID_][1]).archive_id
		})
	end)
	self:AddBtnListener(self.yesBtn_, nil, function()
		local var_8_0 = ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[self.heroID_][1])

		JumpTools.GoToSystem("/newHeroDetailArchive", {
			isBackHome = true,
			id = var_8_0.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 3,
			record_id = var_8_0.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_picture_open_tip", {
			opt = 1,
			record_id = var_8_0.archive_id
		})
	end)
end

function NewHeroArchiveHomePopView:OnEnter()
	self.heroID_ = self.params_.heroID
	self.heartType_ = self.params_.type

	saveData("archivePop", "popInfo" .. HeroRecordCfg.get_id_list_by_hero_id[self.heroID_][1] .. self.heartType_, true)

	if self.heartType_ == 2 then
		saveData("archivePop", "popInfo" .. HeroRecordCfg.get_id_list_by_hero_id[self.heroID_][1] .. 1, true)
	end

	saveData("archivePop", "cache", manager.time:GetServerTime())
	self:RefreshUI()
end

function NewHeroArchiveHomePopView:RefreshUI()
	local var_10_0 = HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[self.heroID_][1]]

	if self.heartType_ == 1 then
		self.descText_.text = var_10_0.plot_tip
	elseif self.heartType_ == 2 then
		self.descText_.text = var_10_0.super_plot_tip
	end

	self.roleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_10_0.plot_tip_picture)
	self.roleNameText_.text = HeroTools.GetHeroName(self.heroID_)
end

function NewHeroArchiveHomePopView:OnExit()
	if self.callback_ then
		self.callback_()
	end
end

return NewHeroArchiveHomePopView
