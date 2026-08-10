local var_0_0 = import("game.views.regression.pages.RegressionTaskPage")
local var_0_1 = class("RegressionTaskNewPage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnTwo/RT2stReturnMissionUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.scrollHelper_ = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.scrollView_, RegressionTaskNewItem)
	arg_2_0.allReceiveBtnState_ = ControllerUtil.GetController(arg_2_0.transform_, "allReceive")
end

function var_0_1.UpdateBar(arg_3_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_1.SetData(arg_4_0, arg_4_1)
	if arg_4_1 == nil then
		return
	end

	arg_4_0.taskType_ = arg_4_1
	arg_4_0._taskIDList = TaskData2:GetTypedTaskSortListCommonFilter(arg_4_0.taskType_)
	arg_4_0._finishList = TaskTools:GetFinishTaskIds(arg_4_0.taskType_)
	arg_4_0.maxRewardNum_ = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._taskIDList) do
		local var_4_0 = iter_4_1.id

		if not AssignmentCfg[var_4_0] then
			print(var_4_0)
		else
			local var_4_1 = #AssignmentCfg[var_4_0].reward

			arg_4_0.maxRewardNum_ = var_4_1 > arg_4_0.maxRewardNum_ and var_4_1 or arg_4_0.maxRewardNum_
		end
	end

	arg_4_0.scrollHelper_:StartScroll(#arg_4_0._taskIDList)
	arg_4_0:RefreshRecivedAll()
end

function var_0_1.RefreshRecivedAll(arg_5_0)
	arg_5_0.allReceiveBtnState_:SetSelectedState(#arg_5_0._finishList > 0 and "true" or "false")
end

function var_0_1.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._taskIDList[arg_6_1].id

	arg_6_2:ReEnter(var_6_0, arg_6_0.maxRewardNum_)
end

return var_0_1
