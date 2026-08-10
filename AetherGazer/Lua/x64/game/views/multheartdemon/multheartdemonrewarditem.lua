local var_0_0 = class("MultHeartDemonRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		if arg_3_0.cfg then
			local var_4_0, var_4_1 = arg_3_0:IsTaskInActivity()

			if var_4_0 then
				TaskAction:SubmitTask(arg_3_0.cfg.id)
			else
				ShowTips(var_4_1)
			end
		end
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.controller = arg_5_0.allBtnController_:GetController("all")
	arg_5_0.rewardItems_ = {}

	SetActive(arg_5_0[string.format("awardItem%dObj_", 3)], false)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index = arg_6_2
	arg_6_0.data = arg_6_1
	arg_6_0.type = arg_6_3

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	for iter_7_0 = 1, 3 do
		SetActive(arg_7_0[string.format("awardItem%dObj_", iter_7_0)], false)
	end

	arg_7_0[arg_7_0.type == 1 and "UpdateNormalView" or "UpdateRankView"](arg_7_0)
end

function var_0_0.UpdateRankView(arg_8_0)
	arg_8_0.cfg = nil
	arg_8_0.rewardCfg = MultHeartDemonRewardCfg[arg_8_0.data]
	arg_8_0.conditionCfg = ConditionCfg[arg_8_0.rewardCfg.condition]

	local var_8_0 = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS1"), arg_8_0.rewardCfg.reward_rank[1], arg_8_0.rewardCfg.reward_rank[2])

	arg_8_0.titleText_.text = GetTipsF("SOLO_HEART_DEMON_REWARD_TIPS", var_8_0)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.rewardCfg.reward_list) do
		if arg_8_0.rewardItems_[iter_8_0] == nil then
			arg_8_0.rewardItems_[iter_8_0] = CommonItemView.New(arg_8_0[string.format("awardItem%dObj_", iter_8_0)])
		end

		SetActive(arg_8_0[string.format("awardItem%dObj_", iter_8_0)], true)

		local var_8_1 = clone(ItemTemplateData)

		var_8_1.id = iter_8_1[1]
		var_8_1.number = iter_8_1[2]
		var_8_1.completedFlag = false

		function var_8_1.clickFun(arg_9_0)
			ShowPopItem(POP_ITEM, {
				arg_9_0.id,
				arg_9_0.number
			})
		end

		arg_8_0.rewardItems_[iter_8_0]:SetData(var_8_1)
	end
end

function var_0_0.UpdateNormalView(arg_10_0)
	arg_10_0.cfg = AssignmentCfg[arg_10_0.data.id]
	arg_10_0.taskData = TaskData2:GetTask(arg_10_0.data.id)

	arg_10_0.controller:SetSelectedState("lock")

	local var_10_0 = 0

	if arg_10_0.taskData then
		var_10_0 = arg_10_0.taskData.progress
	end

	if var_10_0 >= arg_10_0.cfg.need then
		var_10_0 = arg_10_0.cfg.need

		arg_10_0.controller:SetSelectedState("receive")
	end

	if arg_10_0.taskData ~= nil and TaskData2:GetTaskComplete(arg_10_0.data.id) then
		arg_10_0.controller:SetSelectedState("complete")
	end

	arg_10_0.progressBar_.value = var_10_0 / arg_10_0.cfg.need
	arg_10_0.progressText_.text = var_10_0 .. "/" .. arg_10_0.cfg.need
	arg_10_0.titleText_.text = GetI18NText(arg_10_0.cfg.desc)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.cfg.reward) do
		if arg_10_0.rewardItems_[iter_10_0] == nil then
			arg_10_0.rewardItems_[iter_10_0] = CommonItemView.New(arg_10_0[string.format("awardItem%dObj_", iter_10_0)])
		end

		SetActive(arg_10_0[string.format("awardItem%dObj_", iter_10_0)], true)

		local var_10_1 = clone(ItemTemplateData)

		var_10_1.id = iter_10_1[1]
		var_10_1.number = iter_10_1[2]
		var_10_1.completedFlag = TaskData2:GetTaskComplete(arg_10_0.data.id)

		function var_10_1.clickFun(arg_11_0)
			ShowPopItem(POP_ITEM, {
				arg_11_0.id,
				arg_11_0.number
			})
		end

		arg_10_0.rewardItems_[iter_10_0]:SetData(var_10_1)
	end

	for iter_10_2 = #arg_10_0.cfg.reward + 1, #arg_10_0.rewardItems_ do
		arg_10_0.rewardItems_[iter_10_2]:SetData(nil)
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:UpdateView()
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.list then
		arg_13_0.list:Dispose()

		arg_13_0.list = nil
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.rewardItems_) do
		iter_13_1:Dispose()
	end

	arg_13_0.rewardItems_ = {}

	var_0_0.super.Dispose(arg_13_0)
	Object.Destroy(arg_13_0.gameObject_)
end

function var_0_0.IsTaskInActivity(arg_14_0)
	local var_14_0 = nullable(arg_14_0.cfg, "activity_id") or 0

	if var_14_0 ~= 0 then
		local var_14_1, var_14_2 = ActivityTools.GetActivityStatusWithTips(var_14_0)

		return var_14_1 == ActivityConst.ACTIVITY_STATE.ACTIVING, var_14_2
	end

	return true
end

return var_0_0
