local DormTaskDispatchView = class("DormTaskDispatchView", ReduxView)

function DormTaskDispatchView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamTaskPop"
end

function DormTaskDispatchView:UIParent()
	return manager.ui.uiMain.transform
end

function DormTaskDispatchView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormTaskDispatchView:InitUI()
	self:BindCfgUI()

	self.taskScroll_ = LuaList.New(handler(self, self.indexItem), self.taskuilistUilist_, DormDispatchMissionItem)
end

function DormTaskDispatchView:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.autoDispatchBtn_, nil, function()
		self:SendAutoDispatch()
	end)
end

function DormTaskDispatchView:RegisterEvent()
	self:RegistEventListener(CANTEEN_REFRESH_ENTRUST_CALLBACK, function(arg_9_0)
		self:RefreshListInfo()

		local var_9_0 = CanteenEntrustData:GetUiPosByEntrustPos(arg_9_0)

		if self.refreshFlag then
			ShowTips("CANTEEN_TASK_REFRESH_SUCCESS")
		else
			DormRedPointTools:CheckUnLockEntrustRedPoint()
		end

		self.taskScroll_:GetItemByIndex(var_9_0):RefreshUI((CanteenEntrustData:GetEntrustByPos(arg_9_0)))
	end)
	self:RegistEventListener(CANTEEN_DISPATCH_ENTRUST_SUCCESS, function(arg_10_0)
		self:RefreshListInfo()
		self.taskScroll_:GetItemByIndex((CanteenEntrustData:GetUiPosByEntrustPos(arg_10_0))):RefreshUI((CanteenEntrustData:GetEntrustByPos(arg_10_0)))
	end)
	self:RegistEventListener(CANTEEN_DISPATCH_REWARD_VIEW, function()
		JumpTools.OpenPageByJump("/canteenEntrustAwardView", {
			flag = true
		})
	end)
	self:RegistEventListener(CANTEEN_DISPATCH_TIME_OVER, function()
		self:GetHadFinishEntrustAward()
	end)
end

function DormTaskDispatchView:indexItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(self.dispatchItemList_[arg_13_1])
	arg_13_2:RegisterConfirmCallBack(function(arg_14_0, arg_14_1, arg_14_2)
		CanteenEntrustData:SetCurDispatchTask(arg_14_0, arg_14_1, arg_14_2)
		JumpTools.OpenPageByJump("/chooseCharacterView", {
			roomID = self.roomID
		})
	end)
	arg_13_2:RegisterRefreshCallBack(function(arg_15_0)
		self.refreshFlag = true

		CanteenEntrustData:RefreshEntrustData(arg_15_0, self.roomID)
	end)
	arg_13_2:RegisterCancelCallBack(function(arg_16_0, arg_16_1)
		CanteenEntrustData:CancelEntrust(arg_16_1, self.roomID)
	end)
end

function DormTaskDispatchView:OnEnter()
	self.roomID = DormConst.CANTEEN_ID

	self:RegisterEvent()

	if self:GetHadFinishEntrustAward() then
		return
	end

	self:RefreshListInfo()
	self.taskScroll_:StartScroll(#self.dispatchItemList_)

	self.refreshFlag = false
	self.refreshTimer = self.refreshTimer or Timer.New(function()
		self:RefreshItemTime()
	end, 1, -1)

	self.refreshTimer:Start()
end

function DormTaskDispatchView:RefreshListInfo()
	self.dispatchItemList_ = {}

	for iter_19_0, iter_19_1 in ipairs(GameDisplayCfg.canteen_task_id_pos.value) do
		local var_19_0 = CanteenEntrustData:GetEntrustByPos(iter_19_1[2])

		if var_19_0 then
			table.insert(self.dispatchItemList_, var_19_0)
		end
	end
end

function DormTaskDispatchView:RefreshItemTime()
	if self.taskScroll_ then
		for iter_20_0 = 1, #self.dispatchItemList_ do
			local var_20_0 = self.taskScroll_:GetItemByIndex(iter_20_0)

			if var_20_0 then
				var_20_0:RefreshTimeMessage()
			end
		end
	end
end

function DormTaskDispatchView:GetHadFinishEntrustAward()
	local var_21_0 = CanteenEntrustData:CheckHasTimeOverEntrust()

	if #var_21_0 > 0 then
		CanteenAction:ReceiveEntrustAward(self.roomID, var_21_0)

		return true
	end

	return false
end

function DormTaskDispatchView:OnExit()
	self:RemoveAllEventListener()

	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end
end

function DormTaskDispatchView:Dispose()
	if self.taskScroll_ then
		self.taskScroll_:Dispose()

		self.taskScroll_ = nil
	end

	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end

	DormTaskDispatchView.super.Dispose(self)
end

function DormTaskDispatchView:SendAutoDispatch()
	CanteenAction.BatchSendTaskDispatchInfo(DormConst.CANTEEN_ID, self.dispatchItemList_)
end

return DormTaskDispatchView
