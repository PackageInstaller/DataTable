local OsirisPlayGamePointTaskCommonItem = class("OsirisPlayGamePointTaskCommonItem", (import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonItem")))

function OsirisPlayGamePointTaskCommonItem:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		OsirisPlayGameAction.GetPointReward({
			self.ID_
		})
	end)
end

function OsirisPlayGamePointTaskCommonItem:SetData(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.ID_ = arg_3_1
	self.titleText_.text = arg_3_2 > 9 and arg_3_2 or "0" .. arg_3_2

	self.controller_:SetSelectedState(arg_3_3)

	self.descText_.text = TipsCfg.get_id_list_by_define["ACTIVITY_POINT_TASK_COMMON_NAME_" .. arg_3_4] and GetTipsF("ACTIVITY_POINT_TASK_COMMON_NAME_" .. arg_3_4, arg_3_2) or arg_3_2

	local var_3_0 = ActivityPointRewardCfg[arg_3_1]

	for iter_3_0 = 1, 3 do
		if var_3_0.reward_item_list[iter_3_0] then
			local var_3_1 = cfgToItemTemplate(var_3_0.reward_item_list[iter_3_0])

			var_3_1.grayFlag = arg_3_3 == "complete"

			function var_3_1.clickFun(arg_4_0)
				ShowPopItem(POP_ITEM, arg_4_0)
			end

			self.commonItemList_[iter_3_0]:SetData(var_3_1)
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

return OsirisPlayGamePointTaskCommonItem
