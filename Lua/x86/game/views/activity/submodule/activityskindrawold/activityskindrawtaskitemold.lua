local var_0_0 = class("ActivitySkinDrawTaskItemOld", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.dailyCon_ = ControllerUtil.GetController(arg_3_0.transform_, "daily")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	arg_6_0.info_ = arg_6_1
	arg_6_0.taskID_ = arg_6_0.info_.id
	arg_6_0.cfg_ = AssignmentCfg[arg_6_0.taskID_]

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshReward()
	arg_7_0:RefreshTask()
end

function var_0_0.RefreshReward(arg_8_0)
	local var_8_0 = arg_8_0.cfg_.reward

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not arg_8_0.rewardItems_[iter_8_0] then
			local var_8_1 = Object.Instantiate(arg_8_0.rewardItem_, arg_8_0.rewardParent_)

			arg_8_0.rewardItems_[iter_8_0] = CommonItemView.New(var_8_1, true)
		end

		local var_8_2 = clone(ItemTemplateData)

		var_8_2.id = iter_8_1[1]
		var_8_2.number = iter_8_1[2]

		function var_8_2.clickFun()
			ShowPopItem(POP_ITEM, {
				var_8_2.id
			})
		end

		arg_8_0.rewardItems_[iter_8_0]:SetData(var_8_2)
		arg_8_0.rewardItems_[iter_8_0]:Show(true)
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.rewardItems_ do
		arg_8_0.rewardItems_[iter_8_2]:Show(false)
	end
end

function var_0_0.RefreshTask(arg_10_0)
	arg_10_0.desc_.text = GetI18NText(arg_10_0.cfg_.desc)

	local var_10_0 = arg_10_0.info_.progress > arg_10_0.cfg_.need and arg_10_0.cfg_.need or arg_10_0.info_.progress

	if arg_10_0.info_.complete_flag >= 1 then
		var_10_0 = arg_10_0.cfg_.need
	end

	arg_10_0.progress_.text = GetI18NText(var_10_0 .. "/" .. arg_10_0.cfg_.need)
	arg_10_0.slider_.value = var_10_0 / arg_10_0.cfg_.need

	if arg_10_0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		arg_10_0.typeCon_:SetSelectedState("normal")
	else
		arg_10_0.typeCon_:SetSelectedState("challenge")
	end

	if arg_10_0.info_.complete_flag >= 1 then
		arg_10_0.stateCon_:SetSelectedState("received")
	elseif arg_10_0.info_.progress >= arg_10_0.cfg_.need then
		arg_10_0.stateCon_:SetSelectedState("complete")
	else
		arg_10_0.stateCon_:SetSelectedState("unfinish")
	end

	arg_10_0.dailyCon_:SetSelectedState(tostring(arg_10_0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY))
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	for iter_12_0 = 1, #arg_12_0.rewardItems_ do
		arg_12_0.rewardItems_[iter_12_0]:Dispose()
	end

	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
