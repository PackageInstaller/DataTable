local var_0_0 = class("DormLinkGameDailyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListenerScale(arg_4_0.btn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.taskID_ = arg_6_1
	arg_6_0.activityID_ = arg_6_2
	arg_6_0.taskActivityID_ = DormLinkGameTools:GetTaskActivityID(arg_6_0.activityID_)
	arg_6_0.info_ = TaskData2:GetTask(arg_6_0.taskID_)
	arg_6_0.cfg_ = AssignmentCfg[arg_6_1]

	arg_6_0:RefreshReward()
	arg_6_0:RefreshTask()
end

local function var_0_1(arg_7_0)
	ShowPopItem(POP_ITEM, arg_7_0)
end

function var_0_0.RefreshReward(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.cfg_.reward) do
		local var_8_0 = formatReward(iter_8_1)
		local var_8_1 = rewardToItemTemplate(var_8_0)

		var_8_1.clickFun = var_0_1

		if not arg_8_0.rewardItems_[iter_8_0] then
			arg_8_0.rewardItems_[iter_8_0] = CommonItemPool.New(arg_8_0.rewardParent_, var_8_1, true)
		else
			arg_8_0.rewardItems_[iter_8_0]:SetData(var_8_1)
		end

		arg_8_0.rewardItems_[iter_8_0]:Show(true)
	end

	for iter_8_2 = #arg_8_0.cfg_.reward + 1, #arg_8_0.rewardItems_ do
		arg_8_0.rewardItems_[iter_8_2]:Show(false)
	end
end

function var_0_0.RefreshTask(arg_9_0)
	arg_9_0.desc_.text = arg_9_0.cfg_.desc

	local var_9_0 = 0

	if arg_9_0.info_.progress >= arg_9_0.cfg_.need then
		var_9_0 = arg_9_0.cfg_.need
	else
		var_9_0 = arg_9_0.info_.progress
	end

	arg_9_0.progress_.text = var_9_0 .. "/" .. arg_9_0.cfg_.need
	arg_9_0.slider_.value = var_9_0 / arg_9_0.cfg_.need

	if arg_9_0.info_.complete_flag >= 1 then
		arg_9_0.stateCon_:SetSelectedState("received")
	elseif var_9_0 >= arg_9_0.cfg_.need then
		arg_9_0.stateCon_:SetSelectedState("complete")
	else
		arg_9_0.stateCon_:SetSelectedState("unfinish")
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	for iter_10_0 = 1, #arg_10_0.rewardItems_ do
		arg_10_0.rewardItems_[iter_10_0]:Dispose()
	end

	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
