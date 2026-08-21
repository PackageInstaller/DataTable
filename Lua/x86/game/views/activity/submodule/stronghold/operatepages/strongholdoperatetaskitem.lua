local var_0_0 = class("StrongholdOperateTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.rewardItemGos_ = {}
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.rewardCountController = ControllerUtil.GetController(arg_3_0.transform_, "rewardCount")
	arg_3_0.typeCountController = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.task_activity_id = arg_4_1
	arg_4_0.taskID_ = arg_4_2

	local var_4_0 = TaskData2:GetTask(arg_4_0.taskID_)

	arg_4_0.taskProgress = var_4_0 and var_4_0.progress or 0
	arg_4_0.taskComplete_ = var_4_0 and var_4_0.complete_flag >= 1 or false

	arg_4_0:RefreshUI()
	arg_4_0:RefreshProgress()
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.rewardItems_) do
		iter_5_1:Dispose()
	end

	arg_5_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = AssignmentCfg[arg_6_0.taskID_]

	arg_6_0.titleText_.text = var_6_0.desc

	local var_6_1 = var_6_0.reward or {}

	arg_6_0.rewardCountController:SetSelectedIndex(math.min(3, #var_6_1))

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if arg_6_0.rewardItems_[iter_6_0] == nil then
			arg_6_0.rewardItems_[iter_6_0] = RewardItem.New(arg_6_0.rewardItem_, arg_6_0.rewardParent_)

			arg_6_0.rewardItems_[iter_6_0]:UpdateCommonItemAni()
			arg_6_0.rewardItems_[iter_6_0].commonItem_:RegistCallBack(function()
				OperationRecorder.Record("task", "task_item")
			end)
		end

		arg_6_0.rewardItems_[iter_6_0]:SetData(iter_6_1)
	end

	for iter_6_2 = #var_6_0.reward + 1, #arg_6_0.rewardItems_ do
		arg_6_0.rewardItems_[iter_6_2]:Show(false)
	end

	local var_6_2 = var_6_0.type

	if var_6_2 == 711 or var_6_2 == 721 or var_6_2 == 731 then
		arg_6_0.typeCountController:SetSelectedIndex(0)
	else
		arg_6_0.typeCountController:SetSelectedIndex(1)
	end
end

function var_0_0.RefreshProgress(arg_8_0)
	local var_8_0 = AssignmentCfg[arg_8_0.taskID_]
	local var_8_1 = arg_8_0.taskProgress

	if arg_8_0.taskProgress > var_8_0.need then
		var_8_1 = var_8_0.need
	end

	arg_8_0.progressBar_.fillAmount = var_8_1 / var_8_0.need
	arg_8_0.progressText_.text = string.format("%s/%s", var_8_1, var_8_0.need)

	local var_8_2 = arg_8_0.taskProgress >= var_8_0.need

	if arg_8_0.taskComplete_ then
		arg_8_0.controller_:SetSelectedIndex(2)
	elseif var_8_2 then
		arg_8_0.controller_:SetSelectedIndex(1)
	else
		arg_8_0.controller_:SetSelectedIndex(0)
	end

	local var_8_3 = ActivityStrongholdTaskIconCfg[arg_8_0.taskID_]
	local var_8_4 = var_8_3 and var_8_3.task_icon or ""

	arg_8_0.m_icon.sprite = getSprite("Atlas/XuHeng3rdUI", var_8_4)
end

function var_0_0.RefreshComplete(arg_9_0)
	SetActive(arg_9_0.gameObject_, not arg_9_0.taskComplete_)
end

return var_0_0
