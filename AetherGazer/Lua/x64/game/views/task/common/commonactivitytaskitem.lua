local var_0_0 = class("CommonActivityTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.rewardItems_ = {}
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isShow_ = true

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.RefreshTaskItem(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	arg_2_0.taskID_ = arg_2_1
	arg_2_0.taskProgress = TaskData2:GetTaskProgress(arg_2_1)
	arg_2_0.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	arg_2_0:RefreshProgress()
	arg_2_0:RefreshUI()

	arg_2_0.isShow_ = true
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.isShow_ = false
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:RemoveListeners()

	for iter_4_0, iter_4_1 in pairs(arg_4_0.rewardItems_) do
		if iter_4_1 then
			iter_4_1:Dispose()
		end
	end

	arg_4_0.rewardItems_ = nil

	arg_4_0:StopTimer()
	var_0_0.super.Dispose(arg_4_0)
end

local var_0_1 = {
	"awardItem1Obj_",
	"awardItem2Obj_",
	"awardItem3Obj_",
	"rewardItem_"
}

local function var_0_2(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0 then
		return nil
	end

	arg_5_3 = arg_5_3 or arg_5_2

	return arg_5_0:GetController(arg_5_2) or ControllerUtil.GetController(arg_5_1, arg_5_2)
end

function var_0_0.BindCfgUIAlias(arg_6_0)
	arg_6_0.allBtnController_ = arg_6_0.allBtnController_ or arg_6_0.controllerEx_ or arg_6_0.itemCon_
	arg_6_0.controllers_ = arg_6_0.controllers_ or arg_6_0.allBtnController_
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
	arg_7_0:BindCfgUIAlias()

	arg_7_0.controller = var_0_2(arg_7_0.allBtnController_, arg_7_0.transform_, "state")
	arg_7_0.buttonController = arg_7_0.allBtnController_:GetController("all")
	arg_7_0.progressBar_ = arg_7_0.progressBar_ or arg_7_0.slider_
	arg_7_0.progress_ = arg_7_0.progress_ or arg_7_0.progressText_
	arg_7_0.desc_ = arg_7_0.desc_ or arg_7_0.titleText_ or arg_7_0.descText_
	arg_7_0.receiveBtn_ = arg_7_0.receiveBtn_ or arg_7_0.btn_
	arg_7_0.typeController = var_0_2(arg_7_0.controllers_, arg_7_0.transform_, "type")
	arg_7_0.timeController = var_0_2(arg_7_0.controllers_, arg_7_0.transform_, "time")

	for iter_7_0, iter_7_1 in ipairs(var_0_1) do
		local var_7_0 = arg_7_0[iter_7_1]

		if not isNil(var_7_0) then
			table.insert(arg_7_0.rewardItems_, CommonItemView.New(var_7_0.gameObject, true))
		end
	end
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_8_0.taskID_)
	end)

	if arg_8_0.goBtn_ and not isNil(arg_8_0.goBtn_) then
		arg_8_0:AddBtnListener(arg_8_0.goBtn_, nil, function()
			local var_10_0 = AssignmentCfg[arg_8_0.taskID_]

			JumpTools.JumpToPage2(var_10_0.source)
		end)
	end
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0.receiveBtn_.onClick:RemoveAllListeners()
end

local function var_0_3(arg_12_0)
	local var_12_0 = TaskData2:GetTask(arg_12_0).expired_timestamp

	if var_12_0 and var_12_0 > 0 then
		return var_12_0
	end

	return nil
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end
end

function var_0_0.StartTimer(arg_14_0, arg_14_1)
	arg_14_0:StopTimer()

	arg_14_0.timer = Timer.New(function()
		if manager.time:GetServerTime() > arg_14_1 then
			arg_14_0:StopTimer()

			return
		end

		arg_14_0:UpdateTaskLimitTime(arg_14_1)
	end, 1, -1)

	arg_14_0.timer:Start()
end

function var_0_0.UpdateTaskRewards(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.rewardItems_) do
		local var_16_0 = cfgToItemTemplate(arg_16_1[iter_16_0])

		if var_16_0 then
			var_16_0.grayFlag = arg_16_0.taskComplete_
			var_16_0.clickFun = handler(arg_16_0, arg_16_0.OnClickCommonItem)
		end

		iter_16_1:SetData(var_16_0)
	end
end

local function var_0_4(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0 and not isNil(arg_17_1) then
		arg_17_1.text = manager.time:GetLostTimeStrWith2Unit(arg_17_0, true)
	end

	if arg_17_2 then
		arg_17_2:SetSelectedState(arg_17_0 and "true" or "false")
	end
end

function var_0_0.UpdateTaskLimitTime(arg_18_0, arg_18_1)
	if not arg_18_1 then
		arg_18_0:StopTimer()
		var_0_4(nil, arg_18_0.timeText_, arg_18_0.timeController)
	else
		arg_18_0:StartTimer(arg_18_1)
		var_0_4(arg_18_1, arg_18_0.timeText_, arg_18_0.timeController)
	end
end

function var_0_0.UpdateTaskType(arg_19_0, arg_19_1)
	if arg_19_0.typeController ~= nil then
		if arg_19_1 == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
			arg_19_0.typeController:SetSelectedState("normal")
		elseif AssignmentCfg[arg_19_0.taskID_].activity_id == ActivityConst.AUTO_COOK or AssignmentCfg[arg_19_0.taskID_].activity_id == ActivityConst.ACTIVITY_BLOOD_CARD_TASK or AssignmentCfg[arg_19_0.taskID_].activity_id == ActivityConst.ACTIVITY_SPRING_QUIZ_TASK then
			arg_19_0.typeController:SetSelectedState("nolabels")
		else
			arg_19_0.typeController:SetSelectedState("challenge")
		end
	end
end

function var_0_0.RefreshUI(arg_20_0)
	local var_20_0 = AssignmentCfg[arg_20_0.taskID_]
	local var_20_1 = var_20_0.type

	arg_20_0.desc_.text = GetI18NText(var_20_0.desc)

	local var_20_2 = var_20_0.reward or {}

	arg_20_0:UpdateTaskRewards(var_20_2)

	local var_20_3

	if var_20_1 ~= TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		var_20_3 = var_0_3(arg_20_0.taskID_)
	end

	arg_20_0:UpdateTaskLimitTime(var_20_3)
	arg_20_0:UpdateTaskType(var_20_1)
end

local var_0_5 = {
	go = "go",
	received = "complete",
	unfinish = "lock",
	complete = "receive"
}

local function var_0_6(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0 then
		arg_21_0:SetSelectedState(var_0_5[arg_21_2])
	else
		arg_21_1:SetSelectedState(arg_21_2)
	end
end

local function var_0_7(arg_22_0)
	if arg_22_0 and next(arg_22_0) then
		return true
	end

	return false
end

function var_0_0.RefreshProgress(arg_23_0)
	local var_23_0 = AssignmentCfg[arg_23_0.taskID_]
	local var_23_1 = arg_23_0.taskProgress

	if arg_23_0.taskProgress > var_23_0.need then
		var_23_1 = var_23_0.need
	end

	if arg_23_0.progressBar_ then
		arg_23_0.progressBar_.value = var_23_1 / var_23_0.need
	end

	if arg_23_0.progress_ then
		arg_23_0.progress_.text = string.format("%s/%s", var_23_1, var_23_0.need)
	end

	local var_23_2 = arg_23_0.taskProgress >= var_23_0.need

	if arg_23_0.taskComplete_ then
		var_0_6(arg_23_0.buttonController, arg_23_0.controller, "received")
	elseif var_23_2 then
		var_0_6(arg_23_0.buttonController, arg_23_0.controller, "complete")
	elseif arg_23_0.goBtn_ and not isNil(arg_23_0.goBtn_) and var_0_7(var_23_0.source) then
		var_0_6(arg_23_0.buttonController, arg_23_0.controller, "go")
	else
		var_0_6(arg_23_0.buttonController, arg_23_0.controller, "unfinish")
	end
end

function var_0_0.OnClickCommonItem(arg_24_0, arg_24_1)
	ShowPopItem(POP_ITEM, {
		arg_24_1.id,
		arg_24_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return var_0_0
