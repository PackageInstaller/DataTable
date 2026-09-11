local ValentineGameV3SelectHeroView = class("ValentineGameV3SelectHeroView", ReduxView)

function ValentineGameV3SelectHeroView:UIName()
	return "Widget/Version/Alone_ValentineUI/Alone_ValentineHomeUI"
end

function ValentineGameV3SelectHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameV3SelectHeroView:Init()
	self:InitUI()
end

function ValentineGameV3SelectHeroView:InitUI()
	self:BindCfgUI()

	self.heroList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ValentineGameV3SelectHeroItem)
end

function ValentineGameV3SelectHeroView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.activityID_, self.subActivityID_[arg_5_1])
end

function ValentineGameV3SelectHeroView:OnEnter()
	self.selectHeroText_.text = GetTips("ACTIVITY_VALENTINE_V3_SELECT_HERO")
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

function ValentineGameV3SelectHeroView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VALENTINE_V3_DES")
end

function ValentineGameV3SelectHeroView:OnExit()
	manager.windowBar:HideBar()

	for iter_9_0, iter_9_1 in pairs((self.heroList_:GetItemList())) do
		iter_9_1:OnExit()
	end

	self:StopTimer()
end

function ValentineGameV3SelectHeroView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ValentineGameV3SelectHeroView:Dispose()
	if self.heroList_ then
		self.heroList_:Dispose()

		self.heroList_ = nil
	end

	self:StopTimer()
	self.super.Dispose(self)
end

return ValentineGameV3SelectHeroView
