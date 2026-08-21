local var_0_0 = import("game.views.task.activityPointTaskCommon.ActivityPointTaskCommonItem")
local var_0_1 = class("RogueCardGameRecordTaskItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.descText_ = arg_1_0.desc_ or arg_1_0.descText_ or arg_1_0.titleText_
	arg_1_0.commonItemList_ = {
		CommonItemView.New(arg_1_0.awardItem1Obj_),
		CommonItemView.New(arg_1_0.awardItem2Obj_),
		CommonItemView.New(arg_1_0.awardItem3Obj_)
	}
	arg_1_0.controller_ = arg_1_0.allBtnController_:GetController("all")
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_2_0.ID_)
	end)
end

function var_0_1.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0.ID_ = arg_4_1

	arg_4_0.controller_:SetSelectedState(arg_4_3)

	arg_4_0.titleText_.text = arg_4_2 > 9 and arg_4_2 or "0" .. arg_4_2

	local var_4_0 = AssignmentCfg[arg_4_1]

	arg_4_0.descText_.text = var_4_0.desc

	for iter_4_0 = 1, 3 do
		if var_4_0.reward[iter_4_0] then
			local var_4_1 = cfgToItemTemplate(var_4_0.reward[iter_4_0])

			var_4_1.grayFlag = arg_4_3 == "complete"

			function var_4_1.clickFun(arg_5_0)
				ShowPopItem(POP_ITEM, arg_5_0)
			end

			arg_4_0.commonItemList_[iter_4_0]:SetData(var_4_1)
		end
	end

	if arg_4_3 == "go" or arg_4_3 == "receive" or arg_4_3 == "complete" then
		arg_4_0.progressText_.text = "1/1"
		arg_4_0.progressBar_.value = 1
	else
		arg_4_0.progressText_.text = "0/1"
		arg_4_0.progressBar_.value = 0
	end
end

return var_0_1
