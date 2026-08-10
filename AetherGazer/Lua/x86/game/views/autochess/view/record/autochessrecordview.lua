local var_0_0 = class("AutoChessBattleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_OsirisHorus/Activity_OsirisHorus_Main/Activity_OsirisHorus_BattleRecordUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitController()
	arg_4_0:AddListeners()

	arg_4_0.recordItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.itemListGo_, AutoChessRecordItemView)
	arg_4_0.scoreDetailItemList_ = {}
	arg_4_0.tipsPanelView_ = AutoChessTipsPanelView.New(arg_4_0.tipsPanelGo_)
	arg_4_0.clickChessHandler_ = handler(arg_4_0, arg_4_0.OnClickChess)
	arg_4_0.clickScoreDetailHander_ = handler(arg_4_0, arg_4_0.OnClickScoreDetail)
end

function var_0_0.InitController(arg_5_0)
	arg_5_0.typeController_ = arg_5_0.controllerEx_:GetController("type")
	arg_5_0.tabController_ = arg_5_0.controllerEx_:GetController("tab")
	arg_5_0.rankTabController_ = arg_5_0.controllerEx_:GetController("rankTab")
	arg_5_0.hideRankTabController_ = arg_5_0.controllerEx_:GetController("btnAsynchronousPVP")
	arg_5_0.hideTimeController_ = arg_5_0.controllerEx_:GetController("time")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.pvpBtn_, nil, function()
		arg_6_0:OnCloseTips()

		if arg_6_0.recordType_ == AutoChessConst.RECORD_TYPE.PVP then
			return
		end

		arg_6_0:ChangeType(AutoChessConst.RECORD_TYPE.PVP)
	end)
	arg_6_0:AddBtnListener(arg_6_0.gloryBtn_, nil, function()
		arg_6_0:OnCloseTips()

		if arg_6_0.recordType_ == AutoChessConst.RECORD_TYPE.GLORY then
			return
		end

		arg_6_0:ChangeType(AutoChessConst.RECORD_TYPE.GLORY)
	end)
	arg_6_0:AddBtnListener(arg_6_0.syncPvpBtn_, nil, function()
		arg_6_0:OnCloseTips()

		if arg_6_0.recordType_ == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
			return
		end

		arg_6_0:ChangeType(AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE)
	end)
	arg_6_0:AddBtnListener(arg_6_0.asyncPvpBtn_, nil, function()
		arg_6_0:OnCloseTips()

		if arg_6_0.recordType_ == AutoChessConst.RECORD_TYPE.PVP_4_8 then
			return
		end

		arg_6_0:ChangeType(AutoChessConst.RECORD_TYPE.PVP_4_8)
	end)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:OnCloseTips()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_12_0:AddEventListener()

	arg_12_0.recordType_ = arg_12_0.params_.recordType or AutoChessConst.RECORD_TYPE.PVP
	arg_12_0.medalID_ = arg_12_0.params_.medalID
	arg_12_0.emptyText_.text = GetTips("AUTO_CHESS_EMPTY_HISTORY")
	arg_12_0.textTips_.text = GetTipsF("AUTO_CHESS_HISTORY_COUNT_TIP", GameSetting.auto_chess_PVP_history_count.value[1])

	if arg_12_0.medalID_ then
		arg_12_0:ChangeType(AutoChessConst.RECORD_TYPE.GLORY)

		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(arg_12_0.recordDataList_) do
			if iter_12_1.medalId == arg_12_0.medalID_ then
				var_12_0 = iter_12_0

				break
			end
		end

		if var_12_0 ~= 0 then
			arg_12_0.recordItemList_:ScrollToIndex(var_12_0)
		end
	else
		arg_12_0:UpdateUI()
	end
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()
	arg_13_0:OnCloseTips()
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.AddEventListener(arg_14_0)
	arg_14_0:RegistEventListener(AUTO_CHESS_RECORD_CHESS_CLICK, arg_14_0.clickChessHandler_)
	arg_14_0:RegistEventListener(AUTO_CHESS_RECORD_SCORE_DETAIL_CLICK, arg_14_0.clickScoreDetailHander_)
end

function var_0_0.ChangeType(arg_15_0, arg_15_1)
	arg_15_0.recordType_ = arg_15_1

	arg_15_0:UpdateUI()
end

function var_0_0.UpdateUI(arg_16_0)
	arg_16_0:UpdateTypeController()
	arg_16_0:UpdateRecordList()
end

function var_0_0.UpdateTypeController(arg_17_0)
	if AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_4_8 or AutoChessData:GetActivityID() == ActivityConst.ACTIVITY_AUTO_CHESS_5_0 then
		arg_17_0.tabController_:SetSelectedState("rankTab")

		if arg_17_0.recordType_ == AutoChessConst.RECORD_TYPE.PVP_4_8_ONLINE then
			arg_17_0.rankTabController_:SetSelectedState("SynchronizePVP")

			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
				arg_17_0.hideTimeController_:SetSelectedState("show")
			else
				arg_17_0.hideTimeController_:SetSelectedState("hide")
			end
		else
			arg_17_0.rankTabController_:SetSelectedState("AsynchronousPVP")
			arg_17_0.hideTimeController_:SetSelectedState("hide")
		end

		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
			arg_17_0.hideRankTabController_:SetSelectedState("hide")
		else
			arg_17_0.hideRankTabController_:SetSelectedState("show")
		end

		arg_17_0:RefreshLimitTime()
	else
		arg_17_0.tabController_:SetSelectedState("scoreTab")
		arg_17_0.typeController_:SetSelectedIndex(arg_17_0.recordType_)
		arg_17_0.hideRankTabController_:SetSelectedState("hide")
		arg_17_0.hideTimeController_:SetSelectedState("hide")
	end
end

function var_0_0.UpdateRecordList(arg_18_0)
	arg_18_0.recordDataList_ = AutoChessData:GetRecordDataList(arg_18_0.recordType_) or {}

	arg_18_0.recordItemList_:StartScroll(#arg_18_0.recordDataList_)
end

function var_0_0.IndexItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:SetData(arg_19_0.recordDataList_[arg_19_1], arg_19_0.scrollView_)
	arg_19_2:SetMedalClickHandler(handler(arg_19_0, arg_19_0.OnCloseTips))
end

function var_0_0.RefreshLimitTime(arg_20_0)
	local var_20_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
		arg_20_0.txtTime_.text = manager.time:GetLostTimeStr2(var_20_0.stopTime)
	elseif manager.time:GetServerTime() < var_20_0.startTime then
		arg_20_0.txtTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_20_0.startTime))
	elseif manager.time:GetServerTime() > var_20_0.stopTime then
		arg_20_0.txtTime_.text = GetTips("TIME_OVER")
	end

	if arg_20_0.limittimer_ == nil then
		arg_20_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_AUTO_CHESS_PVP_4_8) then
				if arg_20_0.limittimer_ == nil then
					arg_20_0.txtTime_.text = manager.time:GetLostTimeStr2(var_20_0.stopTime)
				end
			elseif manager.time:GetServerTime() < var_20_0.startTime then
				arg_20_0.txtTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_20_0.startTime))
			elseif manager.time:GetServerTime() > var_20_0.stopTime then
				arg_20_0.txtTime_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_20_0.limittimer_:Start()
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.limittimer_ then
		arg_22_0.limittimer_:Stop()

		arg_22_0.limittimer_ = nil
	end

	arg_22_0.recordItemList_:Dispose()

	arg_22_0.recordItemList_ = nil

	arg_22_0.tipsPanelView_:Dispose()

	for iter_22_0, iter_22_1 in pairs(arg_22_0.scoreDetailItemList_) do
		iter_22_1:Dispose()
	end

	arg_22_0.scoreDetailItemList_ = nil

	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.OnClickChess(arg_23_0, arg_23_1, arg_23_2)
	SetActive(arg_23_0.maskBtn_.gameObject, true)
	arg_23_0.tipsPanelView_:SetData(arg_23_1)
	arg_23_0.tipsPanelView_:SetGoldState(false)

	local var_23_0 = arg_23_2:GetPos()

	arg_23_0.tipsPanelView_:SetPos(var_23_0)
	AutoChessTools.ScreenAdapter(arg_23_2, arg_23_0.tipsPanelView_)
end

function var_0_0.OnClickScoreDetail(arg_24_0, arg_24_1)
	arg_24_0:OnCloseTips()
	SetActive(arg_24_0.maskBtn_.gameObject, true)
	SetActive(arg_24_0.scoreDetailContainerTrans_.gameObject, true)

	local var_24_0 = arg_24_1.recordItemData_

	arg_24_0.scoreDetailDataList = arg_24_0:FilterScoreDetail(var_24_0.scoreDetailList)

	arg_24_0:UpdateScoreDetail()
	arg_24_0:ShowScoreDetailPanel(arg_24_1)
end

function var_0_0.OnCloseTips(arg_25_0)
	SetActive(arg_25_0.maskBtn_.gameObject, false)
	arg_25_0.tipsPanelView_:SetActive(false)
	SetActive(arg_25_0.scoreDetailContainerTrans_.gameObject, false)
end

function var_0_0.ShowScoreDetailPanel(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.scoreDetailPanelPointTrans_
	local var_26_1 = arg_26_0.scoreDetailContainerTrans_.parent:InverseTransformPoint(var_26_0.position)
	local var_26_2 = arg_26_0.viewportTrans_.rect.height
	local var_26_3, var_26_4 = SettingTools.GetDefaultScreenSize()

	if var_26_1.y - var_26_2 < -var_26_4 / 2 then
		local var_26_5 = -var_26_4 / 2 + var_26_2 + 50

		var_26_1 = Vector2.New(var_26_1.x, var_26_5)
	end

	arg_26_0.scoreDetailContainerTrans_.localPosition = var_26_1
end

function var_0_0.UpdateScoreDetail(arg_27_0)
	for iter_27_0 = 1, #arg_27_0.scoreDetailDataList do
		local var_27_0 = arg_27_0.scoreDetailDataList[iter_27_0]

		if not arg_27_0.scoreDetailItemList_[iter_27_0] then
			local var_27_1 = Object.Instantiate(arg_27_0.scoreDetailItemGo_, arg_27_0.scoreDetailContentTrans_)

			arg_27_0.scoreDetailItemList_[iter_27_0] = AutoChessScoreDetailItemView.New(var_27_1)
		end

		arg_27_0.scoreDetailItemList_[iter_27_0]:SetActive(true)
		arg_27_0.scoreDetailItemList_[iter_27_0]:SetData(var_27_0)
	end

	for iter_27_1 = #arg_27_0.scoreDetailDataList + 1, #arg_27_0.scoreDetailItemList_ do
		arg_27_0.scoreDetailItemList_[iter_27_1]:SetActive(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_0.scoreDetailContainerTrans_)
end

function var_0_0.FilterScoreDetail(arg_28_0, arg_28_1)
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

return var_0_0
