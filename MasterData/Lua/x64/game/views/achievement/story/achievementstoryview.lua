local AchievementStoryView = class("AchievementStoryView", ReduxView)

function AchievementStoryView:UIName()
	return "Widget/System/AchievementsUI/AchievementStoryUI"
end

function AchievementStoryView:UIParent()
	return manager.ui.uiMain.transform
end

function AchievementStoryView:Init()
	self:BindCfgUI()

	self.storyItemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(AchievementStoryCfg.all) do
		self.storyItemList_[iter_3_1] = AchievementStoryItem.New(self[string.format("goItem%s_", iter_3_0)], iter_3_1)
	end
end

function AchievementStoryView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	for iter_4_0, iter_4_1 in pairs(self.storyItemList_) do
		iter_4_1:Refresh()
	end
end

function AchievementStoryView:OnExit()
	manager.windowBar:HideBar()
end

function AchievementStoryView:Dispose()
	AchievementStoryView.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.storyItemList_) do
		iter_6_1:Dispose()
	end

	self.storyItemList_ = nil
end

return AchievementStoryView
