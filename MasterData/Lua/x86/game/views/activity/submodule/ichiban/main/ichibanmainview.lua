local IchiBanMainView = class("IchiBanMainView", ReduxView)

function IchiBanMainView:UIName()
	return IchiBanTools.GetMainUIName(self.params_.mainActivityID)
end

function IchiBanMainView:UIParent()
	return manager.ui.uiMain.transform
end

function IchiBanMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.ichiBanLevelViewList_ = {}
	self.showBtnController_ = self.uiControllerEx_:GetController("showBtn")
	self.lackController_ = self.uiControllerEx_:GetController("lack")
	self.showMaskController_ = self.uiControllerEx_:GetController("default2")
	self.xlController_ = self.uiControllerEx_:GetController("xl_over")
	self.lController_ = self.uiControllerEx_:GetController("l_over")
	self.mController_ = self.uiControllerEx_:GetController("m_over")
	self.sController_ = self.uiControllerEx_:GetController("s_over")
	self.ichiBanLeverOverController_ = {
		self.xlController_,
		self.lController_,
		self.mController_,
		self.sController_
	}
	self.onRefreshHandler_ = handler(self, self.DisplayReward)
end

function IchiBanMainView:OnEnter()
	self.activityID_ = self.params_.mainActivityID

	local var_4_0 = IchiBanTools.GetCurrencyID(self.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_4_0
	})
	manager.windowBar:SetBarCanClick(var_4_0, true)

	for iter_4_0, iter_4_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[self.activityID_]) do
		self.ichiBanLevelViewList_[iter_4_0] = self.ichiBanLevelViewList_[iter_4_0] or IchiBanLevelView.New(self[string.format("uiRank%s_", iter_4_0)])
	end

	local var_4_1 = ItemTools.getItemLittleSprite(var_4_0)

	self.uiIcon1_.sprite = var_4_1
	self.uiIcon2_.sprite = var_4_1
	self.uiScrollView_.normalizedPosition = Vector2(0, 1)

	self:RefreshUI()
	manager.notify:RegistListener(ICHIBAN_REFRESH, self.onRefreshHandler_)
end

function IchiBanMainView:OnExit()
	manager.notify:RemoveListener(ICHIBAN_REFRESH, self.onRefreshHandler_)
	manager.windowBar:HideBar()

	for iter_5_0, iter_5_1 in ipairs(self.ichiBanLevelViewList_) do
		iter_5_1:OnExit()
	end
end

function IchiBanMainView:Dispose()
	self.onRefreshHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.ichiBanLevelViewList_) do
		iter_6_1:Dispose()
	end

	self.ichiBanLevelViewList_ = nil

	IchiBanMainView.super.Dispose(self)
end

function IchiBanMainView:AddListeners()
	self:AddBtnListener(self.uiRaffleBtn_, nil, function()
		if IchiBanTools.GetMaxRaffleCnt(self.activityID_) <= 0 then
			ShowTips("ICHIBAN_LACK_CURRENCY")

			return
		end

		IchiBanAction.SendRaffle(self.activityID_, 1, function()
			self:ShowReward(data)
		end)
	end)
	self:AddBtnListener(self.uiAllRaffleBtn_, nil, function()
		if IchiBanTools.GetMaxRaffleCnt(self.activityID_) <= 0 then
			ShowTips("ICHIBAN_LACK_CURRENCY")

			return
		end

		IchiBanAction.SendRaffle(self.activityID_, 0, function()
			self:ShowReward(data)
		end)
	end)
end

function IchiBanMainView:ShowReward()
	JumpTools.OpenPageByJump("iChiBanRaffle", {
		activityID = self.activityID_
	})
end

function IchiBanMainView:RefreshUI()
	self:RefreshCommonUI()

	for iter_13_0, iter_13_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[self.activityID_]) do
		self.ichiBanLevelViewList_[iter_13_0]:SetData(iter_13_1)
	end

	self:RefreshPaint()
	self:RefreshOverState()
end

function IchiBanMainView:RefreshCommonUI()
	local var_14_0 = IchiBanTools.GetMaxRaffleCnt(self.activityID_)

	self.uiAllRaffleCntText_.text = string.format("X%s", var_14_0 <= 0 and 1 or var_14_0)

	self.showBtnController_:SetSelectedState(tostring(IchiBanTools.GetUnRaffleCnt(self.activityID_) > 0))
	self.lackController_:SetSelectedState(tostring(var_14_0 <= 0))
end

function IchiBanMainView:DisplayReward()
	self:RefreshCommonUI()

	for iter_15_0, iter_15_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[self.activityID_]) do
		self.ichiBanLevelViewList_[iter_15_0]:UpdateData()
	end

	IchiBanData:ClearUIData(self.activityID_)

	if IchiBanTools.GetUnRaffleCnt(self.activityID_) == 0 then
		Timer.New(function()
			self:RefreshPaint(true)
		end, 0.5, 1).Start(nil)
	end

	self:RefreshOverState()
end

function IchiBanMainView:RefreshPaint(arg_17_1)
	local var_17_0 = IchiBanTools.GetCfg(self.activityID_)

	if IchiBanTools.GetUnRaffleCnt(self.activityID_) == 0 then
		self.showMaskController_:SetSelectedState(arg_17_1 and "state1" or "state2")
	else
		self.showMaskController_:SetSelectedState("state0")
	end
end

function IchiBanMainView:RefreshOverState()
	for iter_18_0, iter_18_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[self.activityID_]) do
		if self.ichiBanLeverOverController_[iter_18_0] then
			self.ichiBanLeverOverController_[iter_18_0]:SetSelectedIndex(IchiBanTools.IsGotAllLevelReward(iter_18_1) and 1 or 0)
		end
	end
end

return IchiBanMainView
