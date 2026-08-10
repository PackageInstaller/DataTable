local var_0_0 = import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonItem")
local var_0_1 = class("HellaPinballTaskCommonItem", var_0_0)

function var_0_1.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_1_0.ID_)
	end)
end

function var_0_1.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.ID_ = arg_3_1

	arg_3_0.controller_:SetSelectedState(arg_3_3)

	local var_3_0 = AssignmentCfg[arg_3_1]

	arg_3_0.descText_.text = var_3_0.desc

	for iter_3_0 = 1, 3 do
		if var_3_0.reward[iter_3_0] then
			local var_3_1 = cfgToItemTemplate(var_3_0.reward[iter_3_0])

			var_3_1.grayFlag = arg_3_3 == "complete"

			function var_3_1.clickFun(arg_4_0)
				ShowPopItem(POP_ITEM, arg_4_0)
			end

			arg_3_0.commonItemList_[iter_3_0]:SetData(var_3_1)
		end
	end

	if arg_3_3 == "go" or arg_3_3 == "receive" or arg_3_3 == "complete" then
		arg_3_0.progressText_.text = "1/1"
		arg_3_0.progressBar_.value = 1
	else
		arg_3_0.progressText_.text = "0/1"
		arg_3_0.progressBar_.value = 0
	end
end

return var_0_1
