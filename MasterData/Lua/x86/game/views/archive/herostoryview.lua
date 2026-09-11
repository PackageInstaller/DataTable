local HeroStoryView = class("HeroStoryView", ReduxView)

function HeroStoryView:UIName()
	return "UI/HeroArchive/ArchiveStoryUI"
end

function HeroStoryView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroStoryView:Init()
	self.itemInstance_ = {}

	self:InitUI()
	self:AddUIListener()
end

function HeroStoryView:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")
end

function HeroStoryView:AddUIListener()
	return
end

function HeroStoryView:OnEnter()
	self:ShowDefaultBar()
	manager.ui:SetMainCamera("hero")

	self.heroID_ = self.params_.heroID
	self.archiveID_ = HeroTools.GetHeroOntologyID(self.heroID_)

	if #HeroRecordCfg[self.archiveID_].plot_id > 1 then
		self.controller_:SetSelectedState("unlock")

		self.itemList_ = HeroRecordCfg[self.archiveID_].plot_id
		self.picImg_.sprite = getSpriteViaConfig("HeroIcon", self.heroID_)

		for iter_6_0 = 1, #self.itemList_ do
			self.itemInstance_[iter_6_0] = self.itemInstance_[iter_6_0] or HeroArchiveStoryItem.New(self["itemGo_" .. iter_6_0])

			self.itemInstance_[iter_6_0]:RefreshUI(iter_6_0, self.archiveID_)
		end
	else
		self.controller_:SetSelectedState("lock")
	end
end

function HeroStoryView:OnExit()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	OperationRecorder.RecordStayView("STAY_VIEW_HERO_STORY", self:GetStayTime(), self.heroID_)
end

function HeroStoryView:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.itemInstance_) do
		iter_8_1:Dispose()
	end

	HeroStoryView.super.Dispose(self)
end

return HeroStoryView
