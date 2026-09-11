local AutoChessBattleView = class("AutoChessBattleView", ReduxView)

function AutoChessBattleView:UIName()
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_BattleRecordUI"
end

function AutoChessBattleView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessBattleView:Init()
	self:InitUI()
end

function AutoChessBattleView:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:AddListeners()

	self.recordItemList_ = LuaList.New(handler(self, self.IndexItem), self.itemListGo_, AutoChessRecordItemView)
	self.scoreDetailItemList_ = {}
	self.tipsPanelView_ = AutoChessTipsPanelView.New(self.tipsPanelGo_)
	self.clickChessHandler_ = handler(self, self.OnClickChess)
	self.clickScoreDetailHander_ = handler(self, self.OnClickScoreDetail)
end

function AutoChessBattleView:InitController()
	self.typeController_ = self.controllerEx_:GetController("type")
	self.tabController_ = self.controllerEx_:GetController("tab")
	self.rankTabController_ = self.controllerEx_:GetController("rankTab")
	self.hideRankTabController_ = self.controllerEx_:GetController("btnAsynchronousPVP")
	self.hideTimeController_ = self.controllerEx_:GetController("time")
end

function AutoChessBattleView:AddListeners()
	self:AddBtnListener(self.pvpBtn_, nil, function()
		self:OnCloseTips()

		if self.recordType_ == AutoChessConst.RECORD_TYPE.PVP then
			return
		end

		self:ChangeType(AutoChessConst.RECORD_TYPE.PVP)
	end)
	self:AddBtnListener(self.gloryBtn_, nil, function()
		self:OnCloseTips()

		if self.recordType_ == AutoChessConst.RECORD_TYPE.GLORY then
			return
		end

		self:ChangeType(AutoChessConst.RECORD_TYPE.GLORY)
	end)
	self:AddBtnListener(self.syncPvpBtn_, nil, function()
		self:OnCloseTips()

		if self.recordType_ == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
			return
		end

		self:ChangeType(AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE)
	end)
	self:AddBtnListener(self.asyncPvpBtn_, nil, function()
		self:OnCloseTips()

		if self.recordType_ == AutoChessConst.RECORD_TYPE.PVP_4_8 then
			return
		end

		self:ChangeType(AutoChessConst.RECORD_TYPE.PVP_4_8)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnCloseTips()
	end)
end

function AutoChessBattleView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:AddEventListener()

	self.recordType_ = self.params_.recordType or AutoChessConst.RECORD_TYPE.PVP
	self.medalID_ = self.params_.medalID
	self.emptyText_.text = GetTips("AUTO_CHESS_EMPTY_HISTORY")
	self.textTips_.text = GetTipsF("AUTO_CHESS_HISTORY_COUNT_TIP", GameSetting.auto_chess_PVP_history_count.value[1])

	if self.medalID_ then
		self:ChangeType(AutoChessConst.RECORD_TYPE.GLORY)

		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(self.recordDataList_) do
			if iter_12_1.medalId == self.medalID_ then
				var_12_0 = iter_12_0

				break
			end
		end

		if var_12_0 ~= 0 then
			self.recordItemList_:ScrollToIndex(var_12_0)
		end
	else
		self:UpdateUI()
	end
end

function AutoChessBattleView:OnExit()
	manager.windowBar:HideBar()
	self:OnCloseTips()
	self:RemoveAllEventListener()
end

function AutoChessBattleView:AddEventListener()
	self:RegistEventListener(AUTO_CHESS_RECORD_CHESS_CLICK, self.clickChessHandler_)
	self:RegistEventListener(AUTO_CHESS_RECORD_SCORE_DETAIL_CLICK, self.clickScoreDetailHander_)
end

function AutoChessBattleView:ChangeType(arg_15_1)
	self.recordType_ = arg_15_1

	self:UpdateUI()
end

function AutoChessBattleView:UpdateUI()
	self:UpdateTypeController()
	self:UpdateRecordList()
end

function AutoChessBattleView:UpdateTypeController()
	if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0 then
		self.tabController_:SetSelectedState("rankTab")

		if self.recordType_ == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
			self.rankTabController_:SetSelectedState("SynchronizePVP")

			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
				self.hideTimeController_:SetSelectedState("show")
			else
				self.hideTimeController_:SetSelectedState("hide")
			end
		else
			self.rankTabController_:SetSelectedState("AsynchronousPVP")
			self.hideTimeController_:SetSelectedState("hide")
		end

		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
			self.hideRankTabController_:SetSelectedState("hide")
		else
			self.hideRankTabController_:SetSelectedState("show")
		end

		self:RefreshLimitTime()
	else
		self.tabController_:SetSelectedState("scoreTab")
		self.typeController_:SetSelectedIndex(self.recordType_)
		self.hideRankTabController_:SetSelectedState("hide")
		self.hideTimeController_:SetSelectedState("hide")
	end
end

function AutoChessBattleView:UpdateRecordList()
	self.recordDataList_ = AutoChessData:GetRecordDataList(self.recordType_) or {}

	self.recordItemList_:StartScroll(#self.recordDataList_)
end

function AutoChessBattleView:IndexItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.recordDataList_[arg_19_1], self.scrollView_)
	arg_19_2:SetMedalClickHandler(handler(self, self.OnCloseTips))
end

function AutoChessBattleView:RefreshLimitTime()
	local var_20_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
		self.txtTime_.text = manager.time:GetLostTimeStr2(var_20_0.stopTime)
	elseif manager.time:GetServerTime() < var_20_0.startTime then
		self.txtTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_20_0.startTime))
	elseif manager.time:GetServerTime() > var_20_0.stopTime then
		self.txtTime_.text = GetTips("TIME_OVER")
	end

	if self.limittimer_ == nil then
		self.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
				if self.limittimer_ == nil then
					self.txtTime_.text = manager.time:GetLostTimeStr2(var_20_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_20_0.startTime then
				self.txtTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_20_0.startTime))
			elseif manager.time:GetServerTime() > var_20_0.stopTime then
				self.txtTime_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	self.limittimer_:Start()
end

function AutoChessBattleView:Dispose()
	if self.limittimer_ then
		self.limittimer_:Stop()

		self.limittimer_ = nil
	end

	self.recordItemList_:Dispose()

	self.recordItemList_ = nil

	self.tipsPanelView_:Dispose()

	for iter_22_0, iter_22_1 in pairs(self.scoreDetailItemList_) do
		iter_22_1:Dispose()
	end

	self.scoreDetailItemList_ = nil

	AutoChessBattleView.super.Dispose(self)
end

function AutoChessBattleView:OnClickChess(arg_23_1, arg_23_2)
	SetActive(self.maskBtn_.gameObject, true)
	self.tipsPanelView_:SetData(arg_23_1)
	self.tipsPanelView_:SetGoldState(false)
	self.tipsPanelView_:SetPos((arg_23_2:GetPos()))
	AutoChessTools.ScreenAdapter(arg_23_2, self.tipsPanelView_)
end

function AutoChessBattleView:OnClickScoreDetail(arg_24_1)
	self:OnCloseTips()
	SetActive(self.maskBtn_.gameObject, true)
	SetActive(self.scoreDetailContainerTrans_.gameObject, true)

	self.scoreDetailDataList = self:FilterScoreDetail(arg_24_1.recordItemData_.scoreDetailList)

	self:UpdateScoreDetail()
	self:ShowScoreDetailPanel(arg_24_1)
end

function AutoChessBattleView:OnCloseTips()
	SetActive(self.maskBtn_.gameObject, false)
	self.tipsPanelView_:SetActive(false)
	SetActive(self.scoreDetailContainerTrans_.gameObject, false)
end

function AutoChessBattleView:ShowScoreDetailPanel(arg_26_1)
	local var_26_0 = self.scoreDetailContainerTrans_.parent:InverseTransformPoint(arg_26_1.scoreDetailPanelPointTrans_.position)
	local var_26_1, var_26_2 = SettingTools.GetDefaultScreenSize()

	if var_26_0.y - self.viewportTrans_.rect.height < -var_26_2 / 2 then
		var_26_0 = Vector2.New(var_26_0.x, -var_26_2 / 2 + self.viewportTrans_.rect.height + 50)
	end

	self.scoreDetailContainerTrans_.localPosition = var_26_0
end

function AutoChessBattleView:UpdateScoreDetail()
	for iter_27_0 = 1, #self.scoreDetailDataList do
		self.scoreDetailItemList_[iter_27_0] = self.scoreDetailItemList_[iter_27_0] or AutoChessScoreDetailItemView.New((Object.Instantiate(self.scoreDetailItemGo_, self.scoreDetailContentTrans_)))

		self.scoreDetailItemList_[iter_27_0]:SetActive(true)
		self.scoreDetailItemList_[iter_27_0]:SetData(self.scoreDetailDataList[iter_27_0])
	end

	for iter_27_1 = #self.scoreDetailDataList + 1, #self.scoreDetailItemList_ do
		self.scoreDetailItemList_[iter_27_1]:SetActive(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.scoreDetailContainerTrans_)
end

function AutoChessBattleView:FilterScoreDetail(arg_28_1)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		if iter_28_1.score > 0 then
			table.insert(var_28_0, iter_28_1)
		end
	end

	table.sort(var_28_0, function(arg_29_0, arg_29_1)
		return arg_29_0.score > arg_29_1.score
	end)

	return var_28_0
end

return AutoChessBattleView
