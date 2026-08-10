local var_0_0 = class("PushSnowBallTeamTaskPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballQuestPopUI"
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

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.taskList_, PushSnowBallTeamTaskItem)
	arg_4_0.rewardController_ = ControllerUtil.GetController(arg_4_0.transform_, "clear")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(arg_5_0.taskDataList_) do
			local var_7_1 = iter_7_1.complete_flag >= 1

			if AssignmentCfg[iter_7_1.id].need <= iter_7_1.progress and not var_7_1 then
				var_7_0[#var_7_0 + 1] = iter_7_1.id
			end
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RefreshUI()
end

function var_0_0.OnTaskListChange(arg_9_0)
	arg_9_0:RefreshUI()
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, arg_10_0.taskDataList_[arg_10_1])
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.taskDataList_ = PushSnowBallData:GetTeamParticipateTaskList()

	arg_11_0.uiList_:StartScroll(#arg_11_0.taskDataList_)

	local var_11_0 = PushSnowBallData:GetHasCompeletedTeamTask()

	arg_11_0.rewardController_:SetSelectedState(tostring(var_11_0))
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.uiList_ then
		arg_12_0.uiList_:Dispose()

		arg_12_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
