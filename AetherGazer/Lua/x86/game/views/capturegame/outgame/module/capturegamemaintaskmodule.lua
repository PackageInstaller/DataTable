local var_0_0 = class("CaptureCheckPointModule", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListener()

	arg_3_0.timeController = arg_3_0.greyController_:GetController("TImeTips")
	arg_3_0.btnController = arg_3_0.allBtnController_:GetController("all")

	arg_3_0.timeController:SetSelectedState("false")

	arg_3_0.rewardItem = {}

	for iter_3_0 = 1, 3 do
		table.insert(arg_3_0.rewardItem, CommonItemView.New(arg_3_0[string.format("awardItem%dObj_", iter_3_0)]))
	end
end

function var_0_0.AddListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		arg_4_0:OnReceiveClick()
	end)
end

function var_0_0.OnReceiveClick(arg_6_0)
	CaptureGameAction.ReceiveTaskReward({
		arg_6_0.taskId
	})
end

function var_0_0.RenderReward(arg_7_0)
	local var_7_0 = ActivityPointRewardCfg[arg_7_0.taskId]

	for iter_7_0 = 1, 3 do
		local var_7_1 = var_7_0.reward_item_list[iter_7_0]

		if var_7_1 then
			local var_7_2 = clone(ItemTemplateData)

			var_7_2.id = var_7_1[1]
			var_7_2.number = var_7_1[2]

			function var_7_2.clickFun(arg_8_0)
				ShowPopItem(POP_ITEM, {
					arg_8_0.id,
					arg_8_0.number
				})
			end

			arg_7_0.rewardItem[iter_7_0]:SetData(var_7_2)
		else
			arg_7_0.rewardItem[iter_7_0]:SetData(nil)
		end
	end
end

function var_0_0.RenderView(arg_9_0, arg_9_1)
	local var_9_0 = ActivityPointRewardCfg[arg_9_1]

	arg_9_0.taskId = var_9_0.id
	arg_9_0.activityId = var_9_0.activity_id
	arg_9_0.need = var_9_0.need
	arg_9_0.titleText_.text = arg_9_0:GetTaskDescription(var_9_0.id)

	local var_9_1 = math.min(CaptureGameData:GetCompleteNumByMainActivity(arg_9_0.activityId) or 0, var_9_0.need)

	arg_9_0.progressText_.text = var_9_1 .. "/" .. var_9_0.need
	arg_9_0.progressBar_.value = var_9_1 / var_9_0.need

	arg_9_0:BuildBtnState()
	arg_9_0:RenderReward()
end

function var_0_0.GetTaskDescription(arg_10_0, arg_10_1)
	local var_10_0 = ActivityPointRewardCfg[arg_10_1]
	local var_10_1 = var_10_0.activity_id
	local var_10_2 = var_10_0.need
	local var_10_3 = ""

	if arg_10_0.activityId == CaptureGameConst.ModeMainActivity.Single then
		var_10_3 = "CAPTURE_GAME_TASK_SINGLE"
	end

	if arg_10_0.activityId == CaptureGameConst.ModeMainActivity.Multi then
		var_10_3 = "CAPTURE_GAME_TASK_MULTI"
	end

	if arg_10_0.activityId == CaptureGameConst.ModeMainActivity.MultiFree then
		var_10_3 = "CAPTURE_GAME_TASK_MULTI_FREE"
	end

	if arg_10_0.activityId == CaptureGameConst.ModeMainActivity.SingleFree then
		var_10_3 = "CAPTURE_GAME_TASK_SINGLE_FREE"
	end

	if arg_10_0.activityId == CaptureGameConst.ModeMainActivity.Common then
		var_10_3 = "CAPTURE_GAME_TASK_TOTAL"
	end

	return string.format(GetTips(var_10_3), var_10_2)
end

function var_0_0.BuildBtnState(arg_11_0)
	local var_11_0 = ActivityPointRewardCfg[arg_11_0.taskId]

	if CaptureGameData:GetCompleteNumByMainActivity(arg_11_0.activityId) < var_11_0.need then
		arg_11_0.btnController:SetSelectedState("lock")

		return
	end

	local var_11_1 = CaptureGameData:CheckTaskIsComplete(arg_11_0.taskId)

	arg_11_0.btnController:SetSelectedState(var_11_1 and "complete" or "receive")
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
