local AchievementInfoView = class("AchievementInfoView", ReduxView)

function AchievementInfoView:UIName()
	return "Widget/System/AchievementsUI/AchievementInfoUI"
end

function AchievementInfoView:UIParent()
	return manager.ui.uiMain.transform
end

function AchievementInfoView:Init()
	self:BindCfgUI()

	self.noticeRectList_ = {
		self.rectCultivate_,
		self.rectCollect_,
		self.rectMission_,
		self.rectPlayer_,
		self.rectBattle_,
		self.rectOther_
	}
	self.goButtonList_ = {
		self.goCultivate_,
		self.goCollect_,
		self.goMission_,
		self.goPlayer_,
		self.goBattle_,
		self.goOther_
	}
	self.scrollPositionList_ = {}
	self.achievementUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, AchievementInfoItem)
	self.achievementButtonList_ = {}

	for iter_3_0, iter_3_1 in pairs(AchievementConst.AchievementType) do
		self.achievementButtonList_[iter_3_1] = AchievementInfoButton.New(self.goButtonList_[iter_3_1], iter_3_1)
	end

	self.oneKeyCon_ = ControllerUtil.GetController(self.achievePlotTrans_, "onekey")

	self:InitUI()
end

function AchievementInfoView:InitUI()
	self:AddBtnListener(self.receiveAllBtn_, nil, function()
		self:ReceiveAll()
	end)
end

function AchievementInfoView:OnEnter()
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

	self.selectType_ = self.params_.achievementType

	self:RefreshScroll()
	self:RefreshButton()

	for iter_6_0, iter_6_1 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		manager.redPoint:bindUIandKey(self.noticeRectList_[iter_6_0], string.format("%s_%s", RedPointConst.ACHIEVEMENT, iter_6_0))
	end

	self:RefreshText()
	self:RefreshRecivedAll()
end

function AchievementInfoView:OnExit()
	manager.windowBar:HideBar()

	for iter_7_0, iter_7_1 in ipairs(AchievementCfg.get_id_list_by_type_id) do
		manager.redPoint:unbindUIandKey(self.noticeRectList_[iter_7_0])
	end

	self.scrollPositionList_ = {}
	self.scrollPositionList_[self.selectType_] = self.achievementUIList_:GetScrolledPosition()
end

function AchievementInfoView:OnUpdate()
	if self.selectType_ == self.params_.achievementType then
		self.scrollPositionList_[self.selectType_] = self.achievementUIList_:GetScrolledPosition()

		AchievementData:SetScrollRecord(true)
	end

	self.selectType_ = self.params_.achievementType

	self:RefreshScroll()
	self:RefreshButton()
	self:RefreshText()
	self:RefreshRecivedAll()
end

function AchievementInfoView:Dispose()
	AchievementInfoView.super.Dispose(self)

	for iter_9_0, iter_9_1 in pairs(self.achievementButtonList_) do
		iter_9_1:Dispose()
	end

	self.achievementButtonList_ = nil

	if self.achievementUIList_ then
		self.achievementUIList_:Dispose()

		self.achievementUIList_ = nil
	end
end

function AchievementInfoView:RefreshButton()
	for iter_10_0, iter_10_1 in pairs(self.achievementButtonList_) do
		iter_10_1:RefreshSelectType(self.selectType_)
	end
end

function AchievementInfoView:RefreshScroll()
	self.achievementIDList_ = AchievementData:GetAchievementIDList(self.selectType_)

	self.achievementUIList_:StartScrollByPosition(#self.achievementIDList_, AchievementData:GetScrollRecord() == true and (self.scrollPositionList_[self.selectType_] or Vector3.one) or Vector3.one)
end

function AchievementInfoView:RefreshItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.achievementIDList_[arg_12_1])
end

function AchievementInfoView:RefreshText()
	self.textAchievement_.text = AchievementData:GetFinishAchievementCnt()
	self.textCnt_.text = string.format("/%s", AchievementData:GetAchievementTotalCnt())
	self.textPoint_.text = AchievementData:GetAchievementPoint()
end

function AchievementInfoView:RefreshRecivedAll()
	if #AchievementData:GetReadyAchievementList(self.selectType_) >= 1 then
		self.oneKeyCon_:SetSelectedState("true")
	else
		self.oneKeyCon_:SetSelectedState("false")
	end
end

function AchievementInfoView:ReceiveAll()
	AchievementAction.TryToSubmitAchievementList(self.selectType_)
end

return AchievementInfoView
