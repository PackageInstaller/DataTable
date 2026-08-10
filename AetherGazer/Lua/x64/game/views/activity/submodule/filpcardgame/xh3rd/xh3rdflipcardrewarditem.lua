local var_0_0 = class("XH3rdFlipCardRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.itemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.rewardListGo_, CommonItemView)
	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.taskID = arg_3_1
	arg_3_0.cfg = AssignmentCfg[arg_3_1]
	arg_3_0.rewardCfg = arg_3_0.cfg.reward
	arg_3_0.activityID = arg_3_0.cfg.activity_id

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTask(arg_5_0.taskID)
	end)

	arg_5_0.onSubmitTaskResponseHandle_ = handler(arg_5_0, arg_5_0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_5_0.onSubmitTaskResponseHandle_)
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshState()
	arg_7_0:RefreshItem()
end

function var_0_0.RefreshState(arg_8_0)
	local var_8_0 = TaskData2:GetTask(arg_8_0.taskID).progress >= arg_8_0.cfg.need
	local var_8_1 = TaskData2:GetTaskComplete(arg_8_0.taskID)

	if not var_8_0 then
		arg_8_0.rewardState_:SetSelectedState("uncomplete")
	elseif not var_8_1 then
		arg_8_0.rewardState_:SetSelectedState("complete")
	else
		arg_8_0.rewardState_:SetSelectedState("received")
	end
end

function var_0_0.RefreshItem(arg_9_0)
	local var_9_0 = TaskData2:GetTask(arg_9_0.taskID)

	arg_9_0.text_.text = arg_9_0.cfg.desc
	arg_9_0.slider_.value = var_9_0.progress / arg_9_0.cfg.need

	local var_9_1

	if var_9_0.progress >= arg_9_0.cfg.need then
		var_9_1 = arg_9_0.cfg.need
	else
		var_9_1 = var_9_0.progress
	end

	arg_9_0.sliderText_.text = var_9_1 .. "/" .. arg_9_0.cfg.need

	arg_9_0.itemList_:StartScroll(#arg_9_0.rewardCfg)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.rewardCfg[arg_10_1]
	local var_10_1 = clone(ItemTemplateData)

	var_10_1.id = var_10_0[1]
	var_10_1.number = var_10_0[2]

	function var_10_1.clickFun(arg_11_0)
		ShowPopItem(POP_ITEM, {
			arg_11_0.id,
			arg_11_0.number
		})
	end

	arg_10_2:SetData(var_10_1)
end

function var_0_0.Dispose(arg_12_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_12_0.onSubmitTaskResponseHandle_)

	if arg_12_0.itemList_ then
		arg_12_0.itemList_:Dispose()

		arg_12_0.itemList_ = nil
	end

	arg_12_0.onReceived_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.SetReveivedHandler(arg_13_0, arg_13_1)
	arg_13_0.onReceived_ = arg_13_1
end

function var_0_0.onSubmitTaskResponse(arg_14_0)
	arg_14_0:RefreshState()

	if arg_14_0.onReceived_ ~= nil then
		arg_14_0.onReceived_()
	end
end

return var_0_0
