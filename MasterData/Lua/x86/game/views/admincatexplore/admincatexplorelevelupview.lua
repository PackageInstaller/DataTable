local AdminCatExploreLevelUpView = class("AdminCatExploreLevelUpView", ReduxView)

function AdminCatExploreLevelUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreLevelUpView:UIName()
	return "Widget/System/ExploreUI/ExploreLevelUpPopUI"
end

function AdminCatExploreLevelUpView:UIParent()
	return manager.ui.uiPop.transform
end

function AdminCatExploreLevelUpView:InitUI()
	self:BindCfgUI()
end

function AdminCatExploreLevelUpView:AddUIListener()
	self:AddBtnListener(self.maskBg_, nil, function()
		self:Back()
	end)
end

function AdminCatExploreLevelUpView:UpdateView()
	self.curLevel = AdminCatExploreData:GetDataByPara("level")
	self.lockRegion = AdminCatExploreData:GetDataByPara("nextLockRegion")[self.curLevel]
	self.lockAdminCat = AdminCatExploreData:GetDataByPara("nextLockAdminCat")[self.curLevel]

	SetActive(self.regionGo_, self.lockRegion ~= nil)
	SetActive(self.adminCatGo_, self.lockAdminCat ~= nil)

	self.titleImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. self.curLevel)

	if self.lockRegion then
		self.regionNameTxt_.text = GetI18NText(ExploreAreaCfg[self.lockRegion].area_name)
		self.regionImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/" .. ExploreAreaCfg[self.lockRegion].icon)
	end

	if self.lockAdminCat then
		self.adminCatNameTxt_.text = GetI18NText(ExploreMeowCfg[self.lockAdminCat].meow_name)
		self.skillImg1_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. ExploreMeowInbornCfg[ExploreMeowCfg[self.lockAdminCat].inborn].inborn_icon)
		self.skillImg2_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Chip/" .. ExploreMeowSkillCfg[ExploreMeowCfg[self.lockAdminCat].skill].skill_icon)
		self.adminCatImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. ExploreMeowCfg[self.lockAdminCat].meow_icon)
	end

	self.oldQueueTxt_.text = string.format(GetTips("EXPLORE_QUEUE_AMOUNT"), ExploreLevelCfg[self.curLevel - 1].amount)
	self.newQueueTxt.text = string.format(GetTips("EXPLORE_LEVEL_UP"), ExploreLevelCfg[self.curLevel].amount)
	self.oldExploreTime_.text = string.format(GetTips("EXPLORE_MAX_TIME"), ExploreLevelCfg[self.curLevel - 1].time)
	self.newExploreTime_.text = ExploreLevelCfg[self.curLevel].time .. GetTips("HOUR")
end

function AdminCatExploreLevelUpView:OnEnter()
	self:UpdateView()
end

function AdminCatExploreLevelUpView:OnExit()
	return
end

function AdminCatExploreLevelUpView:Dispose()
	AdminCatExploreLevelUpView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreLevelUpView
