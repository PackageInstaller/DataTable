local var_0_0 = import("game.views.task.common.CommonActivityTaskItem")
local var_0_1 = class("LimitTaskItem", var_0_0)

function var_0_1.UpdateTaskRewards(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.rewardItems_) do
		local var_1_0 = cfgToItemTemplate(arg_1_1[iter_1_0])

		if var_1_0 then
			var_1_0.grayFlag = arg_1_0.taskComplete_
			var_1_0.clickFun = handler(arg_1_0, arg_1_0.OnClickCommonItem)
		end

		iter_1_1:SetData(var_1_0)
	end
end

function var_0_1.RefreshIndex(arg_2_0, arg_2_1)
	if arg_2_0.indexText_ then
		arg_2_0.indexText_.gameObject:SetActive(false)
	end
end

return var_0_1
