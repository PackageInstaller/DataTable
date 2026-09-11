local SummerChessBoardChessTaskView = class("SummerChessBoardChessTaskView", ReduxView)

SummerChessBoardChessTaskView.PHASE_ACTIVITY = {
	280004,
	280005,
	280006
}

function SummerChessBoardChessTaskView:Ctor(arg_1_1, arg_1_2)
	self.cfg_ = arg_1_2
	self.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2.prefab_path), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.exploreRewardList_ = {}
	self.taskPanelList_ = {}
	self.selectController_ = {}

	for iter_1_0 = 1, 3 do
		self.selectController_[iter_1_0] = self[string.format("toggleControllerEx%s_", iter_1_0)]:GetController("select")
	end

	self.receiveAllController_ = self.controllerEx_:GetController("receiveAll")
	self.updateActivityHandler_ = handler(self, self.UpdateActivity)
	self.pointValueChanedHandler_ = handler(self, self.PointValueChanged)
	self.taskChangedHandler_ = handler(self, self.OnTaskChanged)
	self.refreshAllPhaseRewardItemHandler_ = handler(self, self.RefreshAllPhaseRewardItem)

	self:OnEnter()
end

function SummerChessBoardChessTaskView:OnTaskChanged()
	self:RefreshExploreValue()
	self:RefreshPhaseRewardPanel()
	self:RefreshReceiveAllBtn()
end

function SummerChessBoardChessTaskView:OnEnter()
	manager.notify:RegistListener(ACTIVITY_UPDATE, self.updateActivityHandler_)
	manager.notify:RegistListener(MATERIAL_MODIFY, self.pointValueChanedHandler_)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, self.taskChangedHandler_)
	manager.notify:RegistListener(SUMMER_CHESS_BOARD_RECEIVE_PHASE_REWARD, self.refreshAllPhaseRewardItemHandler_)

	for iter_3_0, iter_3_1 in ipairs(self.taskPanelList_) do
		iter_3_1:OnEnter()
	end

	self:RefreshExploreValue()
end

function SummerChessBoardChessTaskView:OnExit()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.updateActivityHandler_)
	manager.notify:RemoveListener(MATERIAL_MODIFY, self.pointValueChanedHandler_)
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, self.taskChangedHandler_)

	for iter_4_0, iter_4_1 in ipairs(self.taskPanelList_) do
		iter_4_1:OnExit()
	end

	manager.notify:RemoveListener(SUMMER_CHESS_BOARD_RECEIVE_PHASE_REWARD, self.refreshAllPhaseRewardItemHandler_)
end

function SummerChessBoardChessTaskView:Dispose()
	self.updateActivityHandler_ = nil
	self.pointValueChanedHandler_ = nil
	self.refreshAllPhaseRewardItemHandler_ = nil

	for iter_5_0, iter_5_1 in ipairs(self.exploreRewardList_) do
		iter_5_1:Dispose()
	end

	self.exploreRewardList_ = nil

	for iter_5_2, iter_5_3 in ipairs(self.taskPanelList_) do
		iter_5_3:Dispose()
	end

	self.taskPanelList_ = nil

	SummerChessBoardChessTaskView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SummerChessBoardChessTaskView:AddListeners()
	self:AddBtnListener(self.phaseBtn1_, nil, function()
		self:Scroll2Phase(1)
	end)
	self:AddBtnListener(self.phaseBtn2_, nil, function()
		self:Scroll2Phase(2)
	end)
	self:AddBtnListener(self.phaseBtn3_, nil, function()
		self:Scroll2Phase(3)
	end)
	self:AddToggleListener(self.phaseScrollView_, function()
		self:RefreshPhaseBtn()
	end)
	self:AddBtnListener(self.receiveAllBtn_, nil, function()
		TaskAction:SubmitTaskList(self.finishIDList_, nil, function()
			self:RefreshReceiveAllBtn()
		end)
	end)
end

function SummerChessBoardChessTaskView:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

function SummerChessBoardChessTaskView:SetData(arg_14_1)
	self.mainActivityID_ = arg_14_1.main_activity_id
	self.activityID_ = arg_14_1.activity_id

	self:RefreshRewardPanel()
	self:RefreshPhaseRewardPanel()
	self:ScrollPhase()
	self:RefreshReceiveAllBtn()
end

function SummerChessBoardChessTaskView:RefreshPhaseRewardItem(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if self.exploreRewardList_[iter_15_0] == nil then
			self.exploreRewardList_[iter_15_0] = SummerChessBoardChessPhaseItem.New(self.phaseItem_, self.parentGo_, iter_15_0)
		end

		self.exploreRewardList_[iter_15_0]:SetData(iter_15_1, arg_15_1)
	end
end

function SummerChessBoardChessTaskView:RefreshAllPhaseRewardItem()
	for iter_16_0, iter_16_1 in ipairs(self.exploreRewardList_) do
		iter_16_1:RefreshUI()
	end
end

function SummerChessBoardChessTaskView:HightPhaseBtn(arg_17_1)
	for iter_17_0 = 1, 3 do
		self.selectController_[iter_17_0]:SetSelectedState(tostring(arg_17_1 == iter_17_0))
	end
end

function SummerChessBoardChessTaskView:ScrollPhase()
	local var_18_0 = SummerChessBoardTools.GetChessExploreIndex()

	if var_18_0 == 0 then
		return
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTf_)

	self.contentTf_.localPosition = Vector3(self.exploreRewardList_[var_18_0]:GetLocalPosition().x * -1 + self.phaseItemTf_.rect.width / 2, self.contentTf_.localPosition.y, self.contentTf_.localPosition.z)

	self:RefreshPhaseBtn()
end

function SummerChessBoardChessTaskView:RefreshPhaseBtn()
	for iter_19_0 = #self.itemFirstIndex_, 1, -1 do
		if ((self.contentTf_.localPosition.x < 0 or nil) and math.abs(self.contentTf_.localPosition.x)) + self.viewPortTf_.rect.width > self.exploreRewardList_[self.itemFirstIndex_[iter_19_0]]:GetLocalPosition().x + self.phaseItemTf_.rect.width / 2 then
			self:HightPhaseBtn(iter_19_0)

			break
		end
	end
end

function SummerChessBoardChessTaskView:Scroll2Phase(arg_20_1)
	self.phaseScrollView_:StopMovement()

	self.contentTf_.localPosition = Vector3(self.exploreRewardList_[self.itemFirstIndex_[arg_20_1]]:GetLocalPosition().x * -1 + self.phaseItemTf_.rect.width / 2, self.contentTf_.localPosition.y, self.contentTf_.localPosition.z)

	self:HightPhaseBtn(arg_20_1)
end

function SummerChessBoardChessTaskView:RefreshExploreValue()
	self.exportNumText_.text = string.format(GetTips("EXPLORE_VALUE"), (ItemTools.getItemNum(SummerChessBoardTools.GetPointItemID())))
end

function SummerChessBoardChessTaskView:PointValueChanged(arg_22_1)
	if arg_22_1 == SummerChessBoardTools.GetPointItemID() then
		self:RefreshExploreValue()

		for iter_22_0, iter_22_1 in ipairs(self.exploreRewardList_) do
			iter_22_1:RefreshUI()
		end
	end
end

function SummerChessBoardChessTaskView:RefreshPhaseRewardPanel()
	local var_23_0 = false
	local var_23_1 = {}

	self.itemFirstIndex_ = {}

	for iter_23_0, iter_23_1 in ipairs(SummerChessBoardChessTaskView.PHASE_ACTIVITY) do
		local var_23_2 = clone(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_23_1]) or {}

		if ActivityTools.GetActivityStatus(iter_23_1) == ActivityConst.ACTIVITY_STATE.ACTIVING and #var_23_2 > 0 then
			SetActive(self[string.format("phaseGo%s_", iter_23_0)], true)

			self.itemFirstIndex_[iter_23_0] = #var_23_1 + 1

			table.insertto(var_23_1, var_23_2)
		else
			var_23_0 = true

			SetActive(self[string.format("phaseGo%s_", iter_23_0)], false)
		end
	end

	self:RefreshPhaseRewardItem(var_23_1)
	SetActive(self.phaseLockGo_, var_23_0)

	if var_23_0 then
		self.phaseLockGo_.transform:SetAsLastSibling()
	end
end

function SummerChessBoardChessTaskView:RefreshRewardPanel()
	for iter_24_0, iter_24_1 in ipairs(ActivityCfg[self.mainActivityID_].sub_activity_list) do
		if self.taskPanelList_[iter_24_0] == nil then
			self.taskPanelList_[iter_24_0] = SummerChessBoardChessTaskPanel.New(self.taskPanelItem_, self.taskParentGo_, iter_24_1, ActivityCfg[self.activityID_].sub_activity_list[iter_24_0])
		end

		self.taskPanelList_[iter_24_0]:RefreshUI()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.taskContentTf_)

	local var_24_0 = self.taskPanelList_[self:GetUncompleteIndex()]

	self.taskContentTf_.localPosition = Vector3(self.taskContentTf_.localPosition.x, (var_24_0:GetLocalPosition().y + var_24_0:GetHeight() / 2) * -1, self.taskContentTf_.localPosition.z)
end

function SummerChessBoardChessTaskView:GetUncompleteIndex()
	for iter_25_0, iter_25_1 in ipairs(ActivityCfg[self.mainActivityID_].sub_activity_list) do
		for iter_25_2, iter_25_3 in ipairs((SummerChessBoardData:CallFun("GetTaskIDList", iter_25_1, ActivityCfg[self.activityID_].sub_activity_list[iter_25_0]))) do
			if not TaskData2:GetTaskComplete(iter_25_3) then
				return iter_25_0
			end
		end
	end

	return 1
end

function SummerChessBoardChessTaskView:RefreshReceiveAllBtn()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(ActivityCfg[self.mainActivityID_].sub_activity_list) do
		table.insertto(var_26_0, SummerChessBoardData:CallFun("GetTaskIDList", iter_26_1, ActivityCfg[self.activityID_].sub_activity_list[iter_26_0]))
	end

	self.finishIDList_ = TaskTools:GetFinishTaskIDList(var_26_0)

	self.receiveAllController_:SetSelectedState(tostring(#self.finishIDList_ > 0))

	for iter_26_2, iter_26_3 in ipairs(self.taskPanelList_) do
		iter_26_3:RefreshUI()
	end
end

function SummerChessBoardChessTaskView:UpdateActivity()
	self:RefreshPhaseRewardPanel()
	self:RefreshRewardPanel()
end

return SummerChessBoardChessTaskView
