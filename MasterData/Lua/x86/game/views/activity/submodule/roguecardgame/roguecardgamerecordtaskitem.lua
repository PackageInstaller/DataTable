local RogueCardGameRecordTaskItem = class("RogueCardGameRecordTaskItem", (import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonItem")))

function RogueCardGameRecordTaskItem:InitUI()
	self:BindCfgUI()

	self.descText_ = self.desc_ or self.descText_ or self.titleText_
	self.commonItemList_ = {
		CommonItemView.New(self.awardItem1Obj_),
		CommonItemView.New(self.awardItem2Obj_),
		CommonItemView.New(self.awardItem3Obj_)
	}
	self.controller_ = self.allBtnController_:GetController("all")
end

function RogueCardGameRecordTaskItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTask(self.ID_)
	end)
end

function RogueCardGameRecordTaskItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.ID_ = arg_4_1

	self.controller_:SetSelectedState(arg_4_3)

	self.titleText_.text = arg_4_2 > 9 and arg_4_2 or "0" .. arg_4_2
	self.descText_.text = AssignmentCfg[arg_4_1].desc

	for iter_4_0 = 1, 3 do
		if AssignmentCfg[arg_4_1].reward[iter_4_0] then
			local var_4_0 = cfgToItemTemplate(AssignmentCfg[arg_4_1].reward[iter_4_0])

			var_4_0.grayFlag = arg_4_3 == "complete"

			function var_4_0.clickFun(arg_5_0)
				ShowPopItem(POP_ITEM, arg_5_0)
			end

			self.commonItemList_[iter_4_0]:SetData(var_4_0)
		end
	end

	if arg_4_3 == "go" or arg_4_3 == "receive" or arg_4_3 == "complete" then
		self.progressText_.text = "1/1"
		self.progressBar_.value = 1
	else
		self.progressText_.text = "0/1"
		self.progressBar_.value = 0
	end
end

return RogueCardGameRecordTaskItem
