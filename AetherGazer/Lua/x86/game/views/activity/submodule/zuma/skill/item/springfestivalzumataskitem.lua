local var_0_0 = class("SpringFestivalZumaTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.showStateController = arg_3_0.allBtnController_:GetController("all")

	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskData.id)
	end)

	arg_3_0.rewardItemList = {}
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.taskData = arg_5_1

	arg_5_0:Refresh()
end

function var_0_0.Refresh(arg_6_0)
	local var_6_0 = arg_6_0.taskData
	local var_6_1 = var_6_0.id
	local var_6_2 = AssignmentCfg[var_6_1]

	arg_6_0.titleText_.text = var_6_2.desc

	if var_6_0.complete_flag == 1 then
		arg_6_0.showStateController:SetSelectedState("complete")
	elseif var_6_0.progress >= var_6_2.need then
		arg_6_0.showStateController:SetSelectedState("receive")
	else
		arg_6_0.showStateController:SetSelectedState("lock")
	end

	var_6_0.progress = var_6_0.progress
	arg_6_0.progressBar_.value = var_6_0.progress / var_6_2.need

	local var_6_3 = math.min(var_6_0.progress, var_6_2.need)

	arg_6_0.progressText_.text = string.format("%s/%s", var_6_3, var_6_2.need)

	arg_6_0:RefreshRewardList(var_6_2.reward)
end

function var_0_0.RefreshRewardList(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if not arg_7_0.rewardItemList[iter_7_0] then
			local var_7_0 = string.format("awardItem%sObj_", iter_7_0)

			arg_7_0.rewardItemList[iter_7_0] = CommonItemView.New(arg_7_0[var_7_0])
		end

		local var_7_1 = clone(ItemTemplateData)

		var_7_1.id = iter_7_1[1]
		var_7_1.number = iter_7_1[2]

		function var_7_1.clickFun()
			ShowPopItem(POP_ITEM, {
				var_7_1.id
			})
		end

		arg_7_0.rewardItemList[iter_7_0]:SetData(var_7_1)
		arg_7_0.rewardItemList[iter_7_0]:Show(true)
	end

	for iter_7_2 = #arg_7_1 + 1, #arg_7_0.rewardItemList do
		arg_7_0.rewardItemList[iter_7_2]:Show(false)
	end
end

function var_0_0.Dispose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.rewardItemList) do
		iter_9_1:Dispose()

		iter_9_1 = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
