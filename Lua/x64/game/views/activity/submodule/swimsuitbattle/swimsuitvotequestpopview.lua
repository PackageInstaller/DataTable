local var_0_0 = class("SwimsuitVoteQuestPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_Com/SummerUI_3_4_SwimsuitQuestUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.listGo_, SwimsuitVoteQuestPopItem)
	arg_4_0.onClickController_ = arg_4_0.controller_:GetController("oneclick")
end

function var_0_0.indexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.onClickBtn_, nil, function()
		local var_8_0 = arg_6_0:GetCanRewardTask()

		TaskAction:SubmitTaskList(var_8_0)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityIds_ = SwimsuitBattleData:GetTaskIdByRound()

	arg_9_0:RefreshUI()
	arg_9_0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(arg_9_0, arg_9_0.RefreshUI))
	arg_9_0:RegistEventListener(SWIMSUIT_BATTLE_VOTE_UPDATE, handler(arg_9_0, arg_9_0.RefreshUI))
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.uiList_:StartScroll(4)
	arg_10_0.onClickController_:SetSelectedState(tostring(not table.isEmpty(arg_10_0:GetCanRewardTask())))
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.GetCanRewardTask(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.activityIds_) do
		if iter_12_1 then
			local var_12_1 = TaskData2:GetTaskComplete(iter_12_1)

			if TaskData2:GetTaskProgress(iter_12_1) >= AssignmentCfg[iter_12_1].need and not var_12_1 then
				table.insert(var_12_0, iter_12_1)
			end
		end
	end

	return var_12_0
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.uiList_ then
		arg_13_0.uiList_:Dispose()

		arg_13_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
