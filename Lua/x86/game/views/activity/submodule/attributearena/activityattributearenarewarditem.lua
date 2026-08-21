local var_0_0 = class("ActivityAttributeArenaRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.awardList_ = {}
	arg_3_0.buttonController = arg_3_0.allBtnController_:GetController("all")

	for iter_3_0 = 1, 3 do
		local var_3_0 = CommonItemView.New(arg_3_0["awardItem" .. iter_3_0 .. "Obj_"])

		table.insert(arg_3_0.awardList_, var_3_0)
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.taskID_ = arg_6_1.id
	arg_6_0.taskProgress = arg_6_1.progress
	arg_6_0.taskComplete_ = arg_6_1.complete_flag >= 1

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshProgress()
	arg_7_0:RefreshItems()
end

function var_0_0.RefreshProgress(arg_8_0)
	local var_8_0 = AssignmentCfg[arg_8_0.taskID_]
	local var_8_1 = arg_8_0.taskProgress

	if arg_8_0.taskProgress > var_8_0.need then
		var_8_1 = var_8_0.need
	end

	local var_8_2 = AssignmentCfg[arg_8_0.taskID_]

	arg_8_0.titleText_.text = var_8_2.desc
	arg_8_0.progressBar_.value = var_8_1 / var_8_2.need
	arg_8_0.progressText_.text = string.format("%s/%s", var_8_1, var_8_2.need)

	local var_8_3 = arg_8_0.taskProgress >= var_8_2.need

	if arg_8_0.taskComplete_ then
		arg_8_0.buttonController:SetSelectedIndex("2")
	elseif var_8_3 then
		arg_8_0.buttonController:SetSelectedIndex("1")
	else
		arg_8_0.buttonController:SetSelectedIndex("3")
	end
end

function var_0_0.RefreshItems(arg_9_0)
	arg_9_0.rewards = AssignmentCfg[arg_9_0.taskID_].reward or {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.awardList_) do
		local var_9_0 = arg_9_0.rewards[iter_9_0]

		if var_9_0 then
			local var_9_1 = clone(ItemTemplateData)

			var_9_1.id = var_9_0[1]
			var_9_1.number = var_9_0[2]

			function var_9_1.clickFun(arg_10_0)
				ShowPopItem(POP_ITEM, {
					arg_10_0.id,
					arg_10_0.number
				})
			end

			iter_9_1:SetData(var_9_1)
			iter_9_1:RefreshGray(arg_9_0.taskComplete_)
		else
			iter_9_1:SetData(nil)
		end
	end
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.awardList_ then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.awardList_) do
			iter_11_1:Dispose()

			iter_11_1 = nil
		end

		arg_11_0.awardList_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
