local var_0_0 = class("DodgeBarrageTaskItem", ReduxView)

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
	arg_3_0:InitRewardItem()

	arg_3_0.stausController_ = arg_3_0.itemCon_:GetController("status")
end

function var_0_0.InitRewardItem(arg_4_0)
	arg_4_0.rewardItemList_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.rewardItemList_[iter_4_0] = CommonItemView.New(arg_4_0["rewardItem_" .. iter_4_0])
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnReceive_, nil, function()
		TaskAction:SubmitTask(arg_5_0.taskId_)
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.taskStatus_ = arg_7_1
	arg_7_0.taskId_ = arg_7_1.id
	arg_7_0.taskCfg_ = AssignmentCfg[arg_7_0.taskId_]

	arg_7_0:UpdateView()
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = 1

	if arg_8_0.taskStatus_.progress >= arg_8_0.taskCfg_.need then
		var_8_0 = arg_8_0.taskStatus_.complete_flag < 1 and 0 or 2
	end

	arg_8_0.descText_.text = arg_8_0.taskCfg_.desc

	arg_8_0.stausController_:SetSelectedIndex(var_8_0)
	arg_8_0:UpdateRewardItem()
end

function var_0_0.UpdateRewardItem(arg_9_0)
	for iter_9_0 = 1, 3 do
		local var_9_0 = arg_9_0.taskCfg_.reward[iter_9_0]
		local var_9_1 = arg_9_0.rewardItemList_[iter_9_0]

		if var_9_0 then
			local var_9_2 = clone(ItemTemplateData)

			var_9_2.id = var_9_0[1]
			var_9_2.number = var_9_0[2]

			function var_9_2.clickFun(arg_10_0)
				ShowPopItem(POP_ITEM, {
					arg_10_0.id
				})
			end

			var_9_1:SetData(var_9_2)
		else
			var_9_1:SetData(nil)
		end
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.rewardItemList_) do
		iter_11_1:Dispose()
	end

	arg_11_0.rewardItemList_ = nil
end

return var_0_0
