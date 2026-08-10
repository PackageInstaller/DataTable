local var_0_0 = class("ActivityTaskCommonModule", ReduxView)

function var_0_0.GetLevelIDList(arg_1_0)
	return AssignmentCfg.get_id_list_by_activity_id[arg_1_0.activityPointRewardActivityID_]
end

function var_0_0.GetLevelInfo(arg_2_0)
	local var_2_0 = arg_2_0:GetLevelIDList()

	return TaskTools:GetFinishTaskNum(var_2_0), #var_2_0
end

function var_0_0.UIName(arg_3_0)
	return "Widget/Common/Com_Prefab/Com_Activity_RewardTrustUI"
end

function var_0_0.SetActivityID(arg_4_0)
	arg_4_0.activityPointRewardActivityID_ = 1
end

function var_0_0.UIParent(arg_5_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_6_0)
	arg_6_0:InitUI()
	arg_6_0:AddUIListener()
	arg_6_0:SetActivityID()

	arg_6_0.idList_ = arg_6_0:GetLevelIDList()
	arg_6_0.receiveList_ = {}
	arg_6_0.showIdList_ = {}
	arg_6_0.curLv_ = 0
	arg_6_0.maxLv_ = 0
	arg_6_0.levelLuaList_ = LuaList.New(handler(arg_6_0, arg_6_0.IndexItem), arg_6_0.levelUilist_, ActivityTaskCommonItem)
	arg_6_0.taskChangedHandler_ = handler(arg_6_0, arg_6_0.OnReceivePointReward)
	arg_6_0.onekeyController_ = arg_6_0.mainControllerEx_:GetController("onekey")
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.receiveBtn_, nil, function()
		TaskAction:SubmitTaskList(arg_8_0.receiveList_)
	end)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_0.showIdList_[arg_10_1].id, arg_10_0.showIdList_[arg_10_1].ind, arg_10_0.showIdList_[arg_10_1].state)
end

function var_0_0.BindRedPoint(arg_11_0)
	return
end

function var_0_0.OnEnter(arg_12_0)
	manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, arg_12_0.taskChangedHandler_)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_12_0:UpdateView()
	arg_12_0:BindRedPoint()
end

function var_0_0.UnbindRedPoint(arg_13_0)
	return
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:UnbindRedPoint()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(TASK_LIST_CHANGE_NOTIFY, arg_14_0.taskChangedHandler_)
end

function var_0_0.OnReceivePointReward(arg_15_0)
	arg_15_0:UpdateView()
end

function var_0_0.SetLevelText(arg_16_0)
	arg_16_0.curLv_, arg_16_0.maxLv_ = arg_16_0:GetLevelInfo()
	arg_16_0.levelText_.text = "<size=90><color=\"#F4D179\">" .. arg_16_0.curLv_ .. "</color></size><color=\"#93847D\">/" .. arg_16_0.maxLv_ .. "</color>"
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0:SetLevelText()

	arg_17_0.receiveList_ = {}
	arg_17_0.showIdList_ = {}

	local var_17_0 = 1
	local var_17_1 = true

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.idList_) do
		local var_17_2 = TaskData2:GetTask(iter_17_1)
		local var_17_3 = "lock"

		if var_17_2.progress >= AssignmentCfg[iter_17_1].need then
			if var_17_2.complete_flag < 1 then
				table.insert(arg_17_0.receiveList_, iter_17_1)

				var_17_3 = "receive"
				var_17_1 = false
			else
				var_17_3 = "complete"

				if var_17_1 then
					var_17_0 = iter_17_0 + 1
				end
			end
		end

		table.insert(arg_17_0.showIdList_, {
			id = iter_17_1,
			ind = iter_17_0,
			state = var_17_3
		})
	end

	arg_17_0.levelLuaList_:StartScroll(#arg_17_0.showIdList_, var_17_0)
	arg_17_0.onekeyController_:SetSelectedState(#arg_17_0.receiveList_ > 0 and "true" or "false")
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)

	if arg_18_0.levelLuaList_ then
		arg_18_0.levelLuaList_:Dispose()

		arg_18_0.levelLuaList_ = nil
	end
end

return var_0_0
