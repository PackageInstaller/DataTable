local var_0_0 = class("DormTaskDispatchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamTaskPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.taskScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.taskuilistUilist_, DormDispatchMissionItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.autoDispatchBtn_, nil, function()
		arg_5_0:SendAutoDispatch()
	end)
end

function var_0_0.RegisterEvent(arg_8_0)
	arg_8_0:RegistEventListener(CANTEEN_REFRESH_ENTRUST_CALLBACK, function(arg_9_0)
		arg_8_0:RefreshListInfo()

		local var_9_0 = CanteenEntrustData:GetUiPosByEntrustPos(arg_9_0)

		if arg_8_0.refreshFlag then
			ShowTips("CANTEEN_TASK_REFRESH_SUCCESS")
		else
			DormRedPointTools:CheckUnLockEntrustRedPoint()
		end

		local var_9_1 = arg_8_0.taskScroll_:GetItemByIndex(var_9_0)
		local var_9_2 = CanteenEntrustData:GetEntrustByPos(arg_9_0)

		var_9_1:RefreshUI(var_9_2)
	end)
	arg_8_0:RegistEventListener(CANTEEN_DISPATCH_ENTRUST_SUCCESS, function(arg_10_0)
		arg_8_0:RefreshListInfo()

		local var_10_0 = CanteenEntrustData:GetUiPosByEntrustPos(arg_10_0)
		local var_10_1 = arg_8_0.taskScroll_:GetItemByIndex(var_10_0)
		local var_10_2 = CanteenEntrustData:GetEntrustByPos(arg_10_0)

		var_10_1:RefreshUI(var_10_2)
	end)
	arg_8_0:RegistEventListener(CANTEEN_DISPATCH_REWARD_VIEW, function()
		JumpTools.OpenPageByJump("/canteenEntrustAwardView", {
			flag = true
		})
	end)
	arg_8_0:RegistEventListener(CANTEEN_DISPATCH_TIME_OVER, function()
		arg_8_0:GetHadFinishEntrustAward()
	end)
end

function var_0_0.indexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_0.dispatchItemList_[arg_13_1])
	arg_13_2:RegisterConfirmCallBack(function(arg_14_0, arg_14_1, arg_14_2)
		CanteenEntrustData:SetCurDispatchTask(arg_14_0, arg_14_1, arg_14_2)
		JumpTools.OpenPageByJump("/chooseCharacterView", {
			roomID = arg_13_0.roomID
		})
	end)
	arg_13_2:RegisterRefreshCallBack(function(arg_15_0)
		arg_13_0.refreshFlag = true

		CanteenEntrustData:RefreshEntrustData(arg_15_0, arg_13_0.roomID)
	end)
	arg_13_2:RegisterCancelCallBack(function(arg_16_0, arg_16_1)
		CanteenEntrustData:CancelEntrust(arg_16_1, arg_13_0.roomID)
	end)
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.roomID = DormConst.CANTEEN_ID

	arg_17_0:RegisterEvent()

	if arg_17_0:GetHadFinishEntrustAward() then
		return
	end

	arg_17_0:RefreshListInfo()
	arg_17_0.taskScroll_:StartScroll(#arg_17_0.dispatchItemList_)

	arg_17_0.refreshFlag = false

	if not arg_17_0.refreshTimer then
		arg_17_0.refreshTimer = Timer.New(function()
			arg_17_0:RefreshItemTime()
		end, 1, -1)
	end

	arg_17_0.refreshTimer:Start()
end

function var_0_0.RefreshListInfo(arg_19_0)
	arg_19_0.dispatchItemList_ = {}

	for iter_19_0, iter_19_1 in ipairs(GameDisplayCfg.canteen_task_id_pos.value) do
		local var_19_0 = CanteenEntrustData:GetEntrustByPos(iter_19_1[2])

		if var_19_0 then
			table.insert(arg_19_0.dispatchItemList_, var_19_0)
		end
	end
end

function var_0_0.RefreshItemTime(arg_20_0)
	if arg_20_0.taskScroll_ then
		for iter_20_0 = 1, #arg_20_0.dispatchItemList_ do
			local var_20_0 = arg_20_0.taskScroll_:GetItemByIndex(iter_20_0)

			if var_20_0 then
				var_20_0:RefreshTimeMessage()
			end
		end
	end
end

function var_0_0.GetHadFinishEntrustAward(arg_21_0)
	local var_21_0 = CanteenEntrustData:CheckHasTimeOverEntrust()

	if #var_21_0 > 0 then
		CanteenAction:ReceiveEntrustAward(arg_21_0.roomID, var_21_0)

		return true
	end

	return false
end

function var_0_0.OnExit(arg_22_0)
	arg_22_0:RemoveAllEventListener()

	if arg_22_0.refreshTimer then
		arg_22_0.refreshTimer:Stop()

		arg_22_0.refreshTimer = nil
	end
end

function var_0_0.Dispose(arg_23_0)
	if arg_23_0.taskScroll_ then
		arg_23_0.taskScroll_:Dispose()

		arg_23_0.taskScroll_ = nil
	end

	if arg_23_0.refreshTimer then
		arg_23_0.refreshTimer:Stop()

		arg_23_0.refreshTimer = nil
	end

	var_0_0.super.Dispose(arg_23_0)
end

function var_0_0.SendAutoDispatch(arg_24_0)
	CanteenAction.BatchSendTaskDispatchInfo(DormConst.CANTEEN_ID, arg_24_0.dispatchItemList_)
end

return var_0_0
