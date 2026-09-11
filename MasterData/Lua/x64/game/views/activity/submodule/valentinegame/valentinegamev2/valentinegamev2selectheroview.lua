local ValentineGameV2SelectHeroView = class("ValentineGameV2SelectHeroView", ReduxView)

function ValentineGameV2SelectHeroView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineMainUI"
end

function ValentineGameV2SelectHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameV2SelectHeroView:Init()
	self:InitUI()
end

function ValentineGameV2SelectHeroView:InitUI()
	self:BindCfgUI()

	self.heroList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ValentineGameV2SelectHeroItem)
end

function ValentineGameV2SelectHeroView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.subActivityID_[arg_5_1])
end

function ValentineGameV2SelectHeroView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.subActivityID_ = ActivityCfg[self.activityID_].sub_activity_list

	self.heroList_:StartScroll(#self.subActivityID_)

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			for iter_7_0, iter_7_1 in pairs((self.heroList_:GetItemList())) do
				iter_7_1:RefreshTimeText()
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function ValentineGameV2SelectHeroView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_DESCRIBE")
end

function ValentineGameV2SelectHeroView:OnExit()
	manager.windowBar:HideBar()

	for iter_9_0, iter_9_1 in pairs((self.heroList_:GetItemList())) do
		iter_9_1:OnExit()
	end

	self:StopTimer()
end

function ValentineGameV2SelectHeroView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ValentineGameV2SelectHeroView:Dispose()
	if self.heroList_ then
		self.heroList_:Dispose()

		self.heroList_ = nil
	end

	self:StopTimer()
	self.super.Dispose(self)
end

return ValentineGameV2SelectHeroView
