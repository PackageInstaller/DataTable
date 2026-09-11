local HellaPinballTaskCommonItem = class("HellaPinballTaskCommonItem", (import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonItem")))

function HellaPinballTaskCommonItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.ID_)
	end)
end

function HellaPinballTaskCommonItem:SetData(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.ID_ = arg_3_1

	self.controller_:SetSelectedState(arg_3_3)

	self.descText_.text = AssignmentCfg[arg_3_1].desc

	for iter_3_0 = 1, 3 do
		if AssignmentCfg[arg_3_1].reward[iter_3_0] then
			local var_3_0 = cfgToItemTemplate(AssignmentCfg[arg_3_1].reward[iter_3_0])

			var_3_0.grayFlag = arg_3_3 == "complete"

			function var_3_0.clickFun(arg_4_0)
				ShowPopItem(POP_ITEM, arg_4_0)
			end

			self.commonItemList_[iter_3_0]:SetData(var_3_0)
		end
	end

	if arg_3_3 == "go" or arg_3_3 == "receive" or arg_3_3 == "complete" then
		self.progressText_.text = "1/1"
		self.progressBar_.value = 1
	else
		self.progressText_.text = "0/1"
		self.progressBar_.value = 0
	end
end

return HellaPinballTaskCommonItem
