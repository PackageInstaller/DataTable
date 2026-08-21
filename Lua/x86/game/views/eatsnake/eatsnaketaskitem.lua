local var_0_0 = class("EatSnakeTaskItem", ReduxView)

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
		if not ActivityData:GetActivityIsOpen(arg_3_0.activityId) then
			return
		end

		TaskAction:SubmitTask(arg_3_0.data.id)
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.controller = arg_5_0.allBtnController_:GetController("all")
	arg_5_0.rewardItems_ = {}
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index = arg_6_2
	arg_6_0.data = arg_6_1
	arg_6_0.activityId = arg_6_3

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0:UpdateNormalView()
end

function var_0_0.UpdateNormalView(arg_8_0)
	arg_8_0.cfg = AssignmentCfg[arg_8_0.data.id]
	arg_8_0.taskData = TaskData2:GetTask(arg_8_0.data.id)

	arg_8_0.controller:SetSelectedState("lock")

	local var_8_0 = 0

	if arg_8_0.taskData then
		var_8_0 = arg_8_0.taskData.progress
	end

	if var_8_0 >= arg_8_0.cfg.need then
		var_8_0 = arg_8_0.cfg.need

		arg_8_0.controller:SetSelectedState("receive")
	end

	if arg_8_0.taskData ~= nil and TaskData2:GetTaskComplete(arg_8_0.data.id) then
		arg_8_0.controller:SetSelectedState("complete")
	end

	arg_8_0.progressBar_.value = var_8_0 / arg_8_0.cfg.need
	arg_8_0.progressText_.text = var_8_0 .. "/" .. arg_8_0.cfg.need
	arg_8_0.titleText_.text = string.format(GetI18NText(arg_8_0.cfg.desc), arg_8_0.cfg.need)
	arg_8_0.remainTxt_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(arg_8_0.activityId).stopTime, true)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.cfg.reward) do
		if arg_8_0.rewardItems_[iter_8_0] == nil then
			arg_8_0.rewardItems_[iter_8_0] = CommonItemView.New(arg_8_0[string.format("awardItem%dObj_", iter_8_0)])
		end

		SetActive(arg_8_0[string.format("awardItem%dObj_", iter_8_0)], true)

		local var_8_1 = clone(ItemTemplateData)

		var_8_1.id = iter_8_1[1]
		var_8_1.number = iter_8_1[2]
		var_8_1.grayFlag = TaskData2:GetTaskComplete(arg_8_0.data.id)

		function var_8_1.clickFun(arg_9_0)
			ShowPopItem(POP_ITEM, {
				arg_9_0.id,
				arg_9_0.number
			})
		end

		arg_8_0.rewardItems_[iter_8_0]:SetData(var_8_1)
	end

	for iter_8_2 = #arg_8_0.cfg.reward + 1, #arg_8_0.rewardItems_ do
		arg_8_0.rewardItems_[iter_8_2]:SetData(nil)
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:UpdateView()
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.list then
		arg_11_0.list:Dispose()

		arg_11_0.list = nil
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.rewardItems_) do
		iter_11_1:Dispose()
	end

	arg_11_0.rewardItems_ = {}

	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

return var_0_0
