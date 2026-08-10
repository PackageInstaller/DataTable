local var_0_0 = class("MultHeartDemonRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_RewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.OnSwitchLeftBtnTypeHandler_ = handler(arg_3_0, arg_3_0.OnSwitchLeftBtnType)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.normalList = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.list1_, MultHeartDemonRewardItem)
	arg_4_0.rankList = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.list2_, MultHeartDemonRewardItem)
	arg_4_0.controller = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "state")
	arg_4_0.leftBtnList_ = {}

	for iter_4_0 = 1, 2 do
		arg_4_0.leftBtnList_[iter_4_0] = StoreBtnView.New(arg_4_0[string.format("leftBtnGo%s_", iter_4_0)], CommonBtnTypeConst.DEMON, iter_4_0)
	end
end

function var_0_0.SetRewardItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = (arg_5_0.selectIndex == 1 and arg_5_0.normalTaskList or arg_5_0.rankTaskList)[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1, arg_5_0.selectIndex)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.allBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_6_0.normalTaskList) do
			table.insert(var_7_0, iter_7_1.id)
		end

		TaskTools:GetAllCanReciveTask(var_7_0)
	end)
end

function var_0_0.UpdateView(arg_8_0)
	if arg_8_0.updateTimer_ then
		arg_8_0.updateTimer_:Stop()

		arg_8_0.updateTimer_ = nil
	end

	arg_8_0.normalTaskList = TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.MULT_HEART_NORMAL_TASK)

	if arg_8_0.normalTaskList == nil or arg_8_0.normalTaskList == {} then
		arg_8_0.normalTaskList = TaskData2:GetActivityTaskSortList(arg_8_0.activityId)
	end

	arg_8_0.rankTaskList = MultHeartDemonData:GetDataByPara("rankTaskList")

	arg_8_0:UpdateList()

	arg_8_0.updateTimer_ = Timer.New(function()
		if not ActivityData:GetActivityIsOpen(arg_8_0.activityId) then
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")
			arg_8_0:Back()
			JumpTools.GoToSystem("/multHeartDemonMain", {
				activityId = arg_8_0.activityId
			})
		end
	end, 1, -1, 1)

	arg_8_0.updateTimer_:Start()
	SetActive(arg_8_0.rankSelectGo_, arg_8_0.selectIndex == 2)
	SetActive(arg_8_0.normalSelectGo_, arg_8_0.selectIndex == 1)
	arg_8_0.controller:SetSelectedState(arg_8_0:GetControllerState())
	arg_8_0:RefreshLeftBtn()
end

function var_0_0.GetControllerState(arg_10_0)
	if arg_10_0.selectIndex == 2 then
		return "message"
	else
		return arg_10_0:IsShowAllReceiveBtn() and "receive" or "noReceive"
	end
end

function var_0_0.GetDisplayList(arg_11_0, arg_11_1)
	if arg_11_1 == 1 then
		return arg_11_0.normalList, arg_11_0.normalTaskList
	else
		return arg_11_0.rankList, arg_11_0.rankTaskList
	end
end

function var_0_0.UpdateList(arg_12_0)
	SetActive(arg_12_0.list1_, arg_12_0.selectIndex == 1)
	SetActive(arg_12_0.list2_, arg_12_0.selectIndex == 2)

	local var_12_0, var_12_1 = arg_12_0:GetDisplayList(arg_12_0.selectIndex)

	var_12_0:StartScroll(#var_12_1)
end

function var_0_0.IsShowAllReceiveBtn(arg_13_0)
	local var_13_0 = TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.MULT_HEART_NORMAL_TASK)

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_1 = TaskData2:GetTaskComplete(iter_13_1.id)

		if TaskData2:GetTaskProgress(iter_13_1.id) >= AssignmentCfg[iter_13_1.id].need and not var_13_1 then
			return true
		end
	end

	return false
end

function var_0_0.OnMultDemonHeartRewardUpdate(arg_14_0, arg_14_1)
	arg_14_0.controller:SetSelectedState(arg_14_0:GetControllerState())
	arg_14_0:UpdateList()
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.selectIndex = arg_15_0.params_.selectIndex or 1
	arg_15_0.activityId = arg_15_0.params_.activityId

	arg_15_0:UpdateView()
	arg_15_0:BindRedPoint()
	arg_15_0:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		arg_15_0:UpdateView()
		MultHeartDemonAction.UpdateRewardRedPoint()
	end)
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, arg_15_0.OnSwitchLeftBtnTypeHandler_)
end

function var_0_0.BindRedPoint(arg_17_0)
	manager.redPoint:bindUIandKey(arg_17_0.leftBtnGo1_.transform, RedPointConst.MULT_HEART_DEMON_REWARD)
end

function var_0_0.UnbindRedPoint(arg_18_0)
	manager.redPoint:unbindUIandKey(arg_18_0.leftBtnGo1_.transform, RedPointConst.MULT_HEART_DEMON_REWARD)
end

function var_0_0.OnExit(arg_19_0)
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, arg_19_0.OnSwitchLeftBtnTypeHandler_)
	arg_19_0:RemoveAllEventListener()
	arg_19_0:UnbindRedPoint()
	manager.windowBar:HideBar()

	if arg_19_0.updateTimer_ then
		arg_19_0.updateTimer_:Stop()

		arg_19_0.updateTimer_ = nil
	end
end

function var_0_0.OnTop(arg_20_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshLeftBtn(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.leftBtnList_) do
		iter_21_1:RefreshUI(arg_21_0.selectIndex)
	end
end

function var_0_0.OnSwitchLeftBtnType(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 ~= CommonBtnTypeConst.DEMON or arg_22_0.selectIndex == arg_22_2 then
		return
	end

	arg_22_0.selectIndex = arg_22_2

	arg_22_0:UpdateView()
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.OnSwitchLeftBtnTypeHandler_ = nil

	for iter_23_0, iter_23_1 in pairs(arg_23_0.leftBtnList_) do
		iter_23_1:Dispose()
	end

	arg_23_0.leftBtnList_ = nil

	if arg_23_0.normalList then
		arg_23_0.normalList:Dispose()

		arg_23_0.normalList = nil
	end

	if arg_23_0.rankList then
		arg_23_0.rankList:Dispose()

		arg_23_0.rankList = nil
	end

	var_0_0.super.Dispose(arg_23_0)
	Object.Destroy(arg_23_0.gameObject_)
end

return var_0_0
