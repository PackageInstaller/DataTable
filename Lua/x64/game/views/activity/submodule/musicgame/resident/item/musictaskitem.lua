local var_0_0 = import("game.views.task.common.CommonActivityTaskItem")
local var_0_1 = class("MusicTaskItem", var_0_0)

function var_0_1.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_1_0.taskID_)
	end)
	arg_1_0:AddBtnListener(arg_1_0.goBtn_, nil, function()
		local var_3_0 = AssignmentCfg[arg_1_0.taskID_]

		JumpTools.JumpToPage2(var_3_0.source)
	end)
end

function var_0_1.RemoveListeners(arg_4_0)
	arg_4_0.receiveBtn_.onClick:RemoveAllListeners()
	arg_4_0.goBtn_.onClick:RemoveAllListeners()
end

function var_0_1.UpdateTaskRewards(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.rewardItems_) do
		local var_5_0 = cfgToItemTemplate(arg_5_1[iter_5_0])

		if var_5_0 then
			var_5_0.grayFlag = arg_5_0.taskComplete_
			var_5_0.clickFun = handler(arg_5_0, arg_5_0.OnClickCommonItem)
		end

		iter_5_1:SetData(var_5_0)
	end
end

function var_0_1.RefreshIndex(arg_6_0, arg_6_1)
	if arg_6_0.indexText_ then
		arg_6_0.indexText_.gameObject:SetActive(false)
	end
end

return var_0_1
