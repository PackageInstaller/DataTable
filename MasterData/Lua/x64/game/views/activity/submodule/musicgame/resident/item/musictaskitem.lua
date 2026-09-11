local MusicTaskItem = class("MusicTaskItem", (import("game.views.task.common.CommonActivityTaskItem")))

function MusicTaskItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.taskID_)
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(AssignmentCfg[self.taskID_].source)
	end)
end

function MusicTaskItem:RemoveListeners()
	self.receiveBtn_.onClick:RemoveAllListeners()
	self.goBtn_.onClick:RemoveAllListeners()
end

function MusicTaskItem:UpdateTaskRewards(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self.rewardItems_) do
		local var_5_0 = cfgToItemTemplate(arg_5_1[iter_5_0])

		if var_5_0 then
			var_5_0.grayFlag = self.taskComplete_
			var_5_0.clickFun = handler(self, self.OnClickCommonItem)
		end

		iter_5_1:SetData(var_5_0)
	end
end

function MusicTaskItem:RefreshIndex(arg_6_1)
	if self.indexText_ then
		self.indexText_.gameObject:SetActive(false)
	end
end

return MusicTaskItem
