local var_0_0 = class("ChallengeRogueTeamIllustratedTaskPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.itemGoList_ = {}

	for iter_2_0 = 1, 3 do
		table.insert(arg_2_0.itemGoList_, arg_2_0["awardItem" .. iter_2_0 .. "Obj_"])
	end

	arg_2_0.itemList_ = {}
	arg_2_0.btnController_ = arg_2_0.controller_:GetController("all")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = formatReward(arg_6_0.rewardData_[arg_6_1])
	local var_6_1 = clone(ItemTemplateData)

	var_6_1.id = var_6_0.id
	var_6_1.number = var_6_0.num
	var_6_1.timeValid = var_6_0.timeValid or 0

	function var_6_1.clickFun(arg_7_0)
		ShowPopItem(POP_ITEM, {
			arg_7_0.id,
			arg_7_0.number
		})
	end

	arg_6_2:SetData(var_6_1)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.taskID_ = arg_8_1
	arg_8_0.cfg_ = AssignmentCfg[arg_8_1]
	arg_8_0.rewardData_ = arg_8_0.cfg_.reward

	if not arg_8_0.taskID_ or arg_8_0.taskID_ == 0 then
		return
	end

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = TaskData2:GetTaskComplete(arg_9_0.taskID_)
	local var_9_1 = TaskData2:GetTaskProgress(arg_9_0.taskID_) >= arg_9_0.cfg_.need

	arg_9_0.titleText_.text = arg_9_0.cfg_.desc

	if var_9_0 then
		arg_9_0.btnController_:SetSelectedState("complete")
	elseif var_9_1 then
		arg_9_0.btnController_:SetSelectedState("receive")
	else
		arg_9_0.btnController_:SetSelectedState("lock")
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemGoList_) do
		if not arg_9_0.itemList_[iter_9_0] then
			arg_9_0.itemList_[iter_9_0] = CommonItemView.New(iter_9_1)
		end

		local var_9_2 = arg_9_0.itemList_[iter_9_0]

		if arg_9_0.rewardData_[iter_9_0] then
			arg_9_0:IndexItem(iter_9_0, var_9_2)
			SetActive(iter_9_1, true)
		else
			SetActive(iter_9_1, false)
		end
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	if arg_10_0.itemList_ then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.itemList_) do
			iter_10_1:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
