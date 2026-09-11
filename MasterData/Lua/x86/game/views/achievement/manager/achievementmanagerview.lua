local AchievementManagerView = class("AchievementManagerView", ReduxView)

function AchievementManagerView:UIName()
	return "Widget/System/AchievementsUI/AchievementManagerUI"
end

function AchievementManagerView:UIParent()
	return manager.ui.uiMain.transform
end

function AchievementManagerView:Init()
	self:BindCfgUI()

	self.noticeRectList_ = {
		self.goCultivate_,
		self.goCollect_,
		self.goMission_,
		self.goPlayer_,
		self.goBattle_,
		self.goOther_
	}
	self.achievementButtonList_ = {}

	for iter_3_0, iter_3_1 in pairs(AchievementConst.AchievementType) do
		self.achievementButtonList_[iter_3_1] = AchievementManagerButton.New(self.noticeRectList_[iter_3_1], iter_3_1)
	end

	self:AddListeners()
end

function AchievementManagerView:OnEnter()
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
	SetActive(self.goRedPoint_, manager.redPoint:getTipValue(RedPointConst.ACHIEVEMENT_STORY) > 0)

	for iter_4_0, iter_4_1 in pairs(self.achievementButtonList_) do
		iter_4_1:OnEnter()
	end

	self:RefreshUI()
end

function AchievementManagerView:OnExit()
	manager.windowBar:HideBar()
end

function AchievementManagerView:Dispose()
	self.noticeRectList_ = nil

	AchievementManagerView.super.Dispose(self)

	for iter_6_0, iter_6_1 in pairs(self.achievementButtonList_) do
		iter_6_1:Dispose()
	end

	self.achievementButtonList_ = nil
end

function AchievementManagerView:AddListeners()
	self:AddBtnListener(self.buttonStory_, nil, function()
		self:Go("/achievementStory")
	end)
end

function AchievementManagerView:RefreshUI()
	self.textAchievement_.text = AchievementData:GetFinishAchievementCnt()
	self.textTotalCnt_.text = string.format("/%s", AchievementData:GetAchievementTotalCnt())

	local var_9_0 = AchievementData:GetCurrentPoint()
	local var_9_1 = AchievementData:GetCurrentLevelPoint()

	if var_9_1 < var_9_0 then
		var_9_0 = var_9_1
	end

	self.textPoint_.text = var_9_0
	self.textTotalPoint_.text = string.format("/%s", var_9_1)
	self.imageProcess_.value = var_9_0 / var_9_1
	self.imageSlider_.fillAmount = var_9_0 / var_9_1
end

return AchievementManagerView
