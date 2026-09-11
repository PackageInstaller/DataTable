local LimitTaskItem = class("LimitTaskItem", (import("game.views.task.common.CommonActivityTaskItem")))

function LimitTaskItem:UpdateTaskRewards(arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(self.rewardItems_) do
		local var_1_0 = cfgToItemTemplate(arg_1_1[iter_1_0])

		if var_1_0 then
			var_1_0.grayFlag = self.taskComplete_
			var_1_0.clickFun = handler(self, self.OnClickCommonItem)
		end

		iter_1_1:SetData(var_1_0)
	end
end

function LimitTaskItem:RefreshIndex(arg_2_1)
	if self.indexText_ then
		self.indexText_.gameObject:SetActive(false)
	end
end

return LimitTaskItem
