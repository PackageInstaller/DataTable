local var_0_0 = class("SummerChessBoardChessTaskView", ReduxView)

var_0_0.PHASE_ACTIVITY = {
	280004,
	280005,
	280006
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.cfg_ = arg_1_2
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_2.prefab_path), arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.exploreRewardList_ = {}
	arg_1_0.taskPanelList_ = {}
	arg_1_0.selectController_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.selectController_[iter_1_0] = arg_1_0[string.format("toggleControllerEx%s_", iter_1_0)]:GetController("select")
	end

	arg_1_0.receiveAllController_ = arg_1_0.controllerEx_:GetController("receiveAll")
	arg_1_0.updateActivityHandler_ = handler(arg_1_0, arg_1_0.UpdateActivity)
	arg_1_0.pointValueChanedHandler_ = handler(arg_1_0, arg_1_0.PointValueChanged)
	arg_1_0.taskChangedHandler_ = handler(arg_1_0, arg_1_0.OnTaskChanged)
	arg_1_0.refreshAllPhaseRewardItemHandler_ = handler(arg_1_0, arg_1_0.RefreshAllPhaseRewardItem)

	arg_1_0:OnEnter()
end

function var_0_0.OnTaskChanged(arg_2_0)
	arg_2_0:RefreshExploreValue()
	arg_2_0:RefreshPhaseRewardPanel()
	arg_2_0:RefreshReceiveAllBtn()
end

function var_0_0.OnEnter(arg_3_0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_3_0.updateActivityHandler_)
	manager.notify:RegistListener(MATERIAL_MODIFY, arg_3_0.pointValueChanedHandler_)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, arg_3_0.taskChangedHandler_)
	manager.notify:RegistListener(SUMMER_CHESS_BOARD_RECEIVE_PHASE_REWARD, arg_3_0.refreshAllPhaseRewardItemHandler_)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.taskPanelList_) do
		iter_3_1:OnEnter()
	end

	arg_3_0:RefreshExploreValue()
end

function var_0_0.OnExit(arg_4_0)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_4_0.updateActivityHandler_)
	manager.notify:RemoveListener(MATERIAL_MODIFY, arg_4_0.pointValueChanedHandler_)
	manager.notify:RemoveListener(OSIRIS_TASK_UPDATE, arg_4_0.taskChangedHandler_)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.taskPanelList_) do
		iter_4_1:OnExit()
	end

	manager.notify:RemoveListener(SUMMER_CHESS_BOARD_RECEIVE_PHASE_REWARD, arg_4_0.refreshAllPhaseRewardItemHandler_)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.updateActivityHandler_ = nil
	arg_5_0.pointValueChanedHandler_ = nil
	arg_5_0.refreshAllPhaseRewardItemHandler_ = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.exploreRewardList_) do
		iter_5_1:Dispose()
	end

	arg_5_0.exploreRewardList_ = nil

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.taskPanelList_) do
		iter_5_3:Dispose()
	end

	arg_5_0.taskPanelList_ = nil

	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.phaseBtn1_, nil, function()
		arg_6_0:Scroll2Phase(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.phaseBtn2_, nil, function()
		arg_6_0:Scroll2Phase(2)
	end)
	arg_6_0:AddBtnListener(arg_6_0.phaseBtn3_, nil, function()
		arg_6_0:Scroll2Phase(3)
	end)
	arg_6_0:AddToggleListener(arg_6_0.phaseScrollView_, function()
		arg_6_0:RefreshPhaseBtn()
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveAllBtn_, nil, function()
		TaskAction:SubmitTaskList(arg_6_0.finishIDList_, nil, function()
			arg_6_0:RefreshReceiveAllBtn()
		end)
	end)
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

function var_0_0.SetData(arg_14_0, arg_14_1)
	arg_14_0.mainActivityID_ = arg_14_1.main_activity_id
	arg_14_0.activityID_ = arg_14_1.activity_id

	arg_14_0:RefreshRewardPanel()
	arg_14_0:RefreshPhaseRewardPanel()
	arg_14_0:ScrollPhase()
	arg_14_0:RefreshReceiveAllBtn()
end

function var_0_0.RefreshPhaseRewardItem(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if arg_15_0.exploreRewardList_[iter_15_0] == nil then
			arg_15_0.exploreRewardList_[iter_15_0] = SummerChessBoardChessPhaseItem.New(arg_15_0.phaseItem_, arg_15_0.parentGo_, iter_15_0)
		end

		arg_15_0.exploreRewardList_[iter_15_0]:SetData(iter_15_1, arg_15_1)
	end
end

function var_0_0.RefreshAllPhaseRewardItem(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.exploreRewardList_) do
		iter_16_1:RefreshUI()
	end
end

function var_0_0.HightPhaseBtn(arg_17_0, arg_17_1)
	for iter_17_0 = 1, 3 do
		arg_17_0.selectController_[iter_17_0]:SetSelectedState(tostring(arg_17_1 == iter_17_0))
	end
end

function var_0_0.ScrollPhase(arg_18_0)
	local var_18_0 = SummerChessBoardTools.GetChessExploreIndex()

	if var_18_0 == 0 then
		return
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_0.contentTf_)

	local var_18_1 = arg_18_0.contentTf_.localPosition

	arg_18_0.contentTf_.localPosition = Vector3(arg_18_0.exploreRewardList_[var_18_0]:GetLocalPosition().x * -1 + arg_18_0.phaseItemTf_.rect.width / 2, var_18_1.y, var_18_1.z)

	arg_18_0:RefreshPhaseBtn()
end

function var_0_0.RefreshPhaseBtn(arg_19_0)
	for iter_19_0 = #arg_19_0.itemFirstIndex_, 1, -1 do
		local var_19_0 = 0

		if arg_19_0.contentTf_.localPosition.x < 0 then
			var_19_0 = math.abs(arg_19_0.contentTf_.localPosition.x)
		end

		if var_19_0 + arg_19_0.viewPortTf_.rect.width > arg_19_0.exploreRewardList_[arg_19_0.itemFirstIndex_[iter_19_0]]:GetLocalPosition().x + arg_19_0.phaseItemTf_.rect.width / 2 then
			arg_19_0:HightPhaseBtn(iter_19_0)

			break
		end
	end
end

function var_0_0.Scroll2Phase(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.contentTf_.localPosition

	arg_20_0.phaseScrollView_:StopMovement()

	arg_20_0.contentTf_.localPosition = Vector3(arg_20_0.exploreRewardList_[arg_20_0.itemFirstIndex_[arg_20_1]]:GetLocalPosition().x * -1 + arg_20_0.phaseItemTf_.rect.width / 2, var_20_0.y, var_20_0.z)

	arg_20_0:HightPhaseBtn(arg_20_1)
end

function var_0_0.RefreshExploreValue(arg_21_0)
	local var_21_0 = ItemTools.getItemNum(SummerChessBoardTools.GetPointItemID())

	arg_21_0.exportNumText_.text = string.format(GetTips("EXPLORE_VALUE"), var_21_0)
end

function var_0_0.PointValueChanged(arg_22_0, arg_22_1)
	if arg_22_1 == SummerChessBoardTools.GetPointItemID() then
		arg_22_0:RefreshExploreValue()

		for iter_22_0, iter_22_1 in ipairs(arg_22_0.exploreRewardList_) do
			iter_22_1:RefreshUI()
		end
	end
end

function var_0_0.RefreshPhaseRewardPanel(arg_23_0)
	local var_23_0 = false
	local var_23_1 = {}

	arg_23_0.itemFirstIndex_ = {}

	for iter_23_0, iter_23_1 in ipairs(var_0_0.PHASE_ACTIVITY) do
		local var_23_2 = clone(ActivityPointRewardCfg.get_id_list_by_activity_id[iter_23_1]) or {}

		if ActivityTools.GetActivityStatus(iter_23_1) == ActivityConst.ACTIVITY_STATE.ACTIVING and #var_23_2 > 0 then
			SetActive(arg_23_0[string.format("phaseGo%s_", iter_23_0)], true)

			arg_23_0.itemFirstIndex_[iter_23_0] = #var_23_1 + 1

			table.insertto(var_23_1, var_23_2)
		else
			var_23_0 = true

			SetActive(arg_23_0[string.format("phaseGo%s_", iter_23_0)], false)
		end
	end

	arg_23_0:RefreshPhaseRewardItem(var_23_1)
	SetActive(arg_23_0.phaseLockGo_, var_23_0)

	if var_23_0 then
		arg_23_0.phaseLockGo_.transform:SetAsLastSibling()
	end
end

function var_0_0.RefreshRewardPanel(arg_24_0)
	local var_24_0 = arg_24_0.mainActivityID_
	local var_24_1 = arg_24_0.activityID_

	for iter_24_0, iter_24_1 in ipairs(ActivityCfg[var_24_0].sub_activity_list) do
		if arg_24_0.taskPanelList_[iter_24_0] == nil then
			local var_24_2 = ActivityCfg[var_24_1].sub_activity_list[iter_24_0]

			arg_24_0.taskPanelList_[iter_24_0] = SummerChessBoardChessTaskPanel.New(arg_24_0.taskPanelItem_, arg_24_0.taskParentGo_, iter_24_1, var_24_2)
		end

		arg_24_0.taskPanelList_[iter_24_0]:RefreshUI()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_0.taskContentTf_)

	local var_24_3 = arg_24_0:GetUncompleteIndex()
	local var_24_4 = arg_24_0.taskContentTf_.localPosition
	local var_24_5 = arg_24_0.taskPanelList_[var_24_3]

	arg_24_0.taskContentTf_.localPosition = Vector3(var_24_4.x, (var_24_5:GetLocalPosition().y + var_24_5:GetHeight() / 2) * -1, var_24_4.z)
end

function var_0_0.GetUncompleteIndex(arg_25_0)
	local var_25_0 = arg_25_0.mainActivityID_
	local var_25_1 = arg_25_0.activityID_

	for iter_25_0, iter_25_1 in ipairs(ActivityCfg[var_25_0].sub_activity_list) do
		local var_25_2 = ActivityCfg[var_25_1].sub_activity_list[iter_25_0]
		local var_25_3 = SummerChessBoardData:CallFun("GetTaskIDList", iter_25_1, var_25_2)

		for iter_25_2, iter_25_3 in ipairs(var_25_3) do
			local var_25_4 = AssignmentCfg[iter_25_3]

			if not TaskData2:GetTaskComplete(iter_25_3) then
				return iter_25_0
			end
		end
	end

	return 1
end

function var_0_0.RefreshReceiveAllBtn(arg_26_0)
	local var_26_0 = arg_26_0.mainActivityID_
	local var_26_1 = arg_26_0.activityID_
	local var_26_2 = {}

	for iter_26_0, iter_26_1 in ipairs(ActivityCfg[var_26_0].sub_activity_list) do
		local var_26_3 = ActivityCfg[var_26_1].sub_activity_list[iter_26_0]

		table.insertto(var_26_2, SummerChessBoardData:CallFun("GetTaskIDList", iter_26_1, var_26_3))
	end

	arg_26_0.finishIDList_ = TaskTools:GetFinishTaskIDList(var_26_2)

	arg_26_0.receiveAllController_:SetSelectedState(tostring(#arg_26_0.finishIDList_ > 0))

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.taskPanelList_) do
		iter_26_3:RefreshUI()
	end
end

function var_0_0.UpdateActivity(arg_27_0)
	arg_27_0:RefreshPhaseRewardPanel()
	arg_27_0:RefreshRewardPanel()
end

return var_0_0
