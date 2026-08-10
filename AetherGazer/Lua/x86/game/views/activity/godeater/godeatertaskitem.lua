local var_0_0 = class("GodEaterTaskItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshItem), arg_1_0.uilistUilist_, CommonItemView)
	arg_1_0.btnControlller = arg_1_0.btn_one_s_allControllerexcollection_:GetController("all")
	arg_1_0.lockControlller = arg_1_0.bountyitemControllerexcollection_:GetController("lock")
	arg_1_0.gradeControlller = arg_1_0.bountyitemControllerexcollection_:GetController("grade")
	arg_1_0.completeControlller = arg_1_0.bountyitemControllerexcollection_:GetController("complete")

	arg_1_0:AddUIListeners()

	arg_1_0.reward = {}
end

function var_0_0.AddUIListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btngoBtn_, nil, function()
		local var_3_0 = AssignmentCfg[arg_2_0.id]

		JumpTools.JumpToPage2(var_3_0.source)
	end)
	arg_2_0:AddBtnListener(arg_2_0.btnreceiveBtn_, nil, function()
		if arg_2_0.isCanReceive then
			TaskAction:SubmitTask(arg_2_0.id)
		end
	end)
	arg_2_0:AddBtnListener(arg_2_0.btncomplete01Btn_, nil, function()
		return
	end)
	arg_2_0:AddBtnListener(arg_2_0.btnunlockedBtn_, nil, function()
		return
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	if type(arg_7_1) == "table" and arg_7_1.state == "lock" then
		arg_7_0.lockControlller:SetSelectedState("true")

		arg_7_0.locktextText_.text = string.format(GetTips("GODEATER_DES_5"), arg_7_1.num)
	else
		arg_7_0.lockControlller:SetSelectedState("false")
	end

	local var_7_0 = AssignmentCfg[arg_7_1]

	arg_7_0.id = arg_7_1
	arg_7_0.isDraw = false

	if var_7_0 then
		arg_7_0.desctextText_.text = var_7_0.desc
		arg_7_0.fillImg_.transform.localScale = Vector3.New(Mathf.Clamp(TaskData2:GetTaskProgress(arg_7_1) / var_7_0.need, 0, 1), 1, 1)
		arg_7_0.processtextText_.text = math.min(TaskData2:GetTaskProgress(arg_7_1), var_7_0.need) .. "/" .. var_7_0.need

		local var_7_1 = GodEaterTool.GetTaskType(arg_7_1)

		arg_7_0.gradeControlller:SetSelectedState(var_7_1 == 1 and "A" or "S")

		arg_7_0.reward = AssignmentCfg[arg_7_0.id] and AssignmentCfg[arg_7_0.id].reward or {}
		arg_7_0.complete_flag = TaskData2:GetTaskComplete(arg_7_1)
		arg_7_0.isCompleteProcess = TaskData2:GetTaskProgress(arg_7_1) >= AssignmentCfg[arg_7_1].need
		arg_7_0.isCanReceive = not arg_7_0.complete_flag and arg_7_0.isCompleteProcess
		arg_7_0.titletextText_.text = var_7_0.name

		if arg_7_0.complete_flag then
			arg_7_0.btnControlller:SetSelectedState("complete")
			arg_7_0.completeControlller:SetSelectedState("true")

			arg_7_0.isDraw = true
		else
			if arg_7_0.isCanReceive then
				arg_7_0.btnControlller:SetSelectedState("receive")
			else
				arg_7_0.btnControlller:SetSelectedState("lock")
			end

			arg_7_0.completeControlller:SetSelectedState("false")
		end

		arg_7_0.uiList_:StartScroll(#arg_7_0.reward)
	end
end

function var_0_0.RefreshItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = AssignmentCfg[arg_8_0.id] and AssignmentCfg[arg_8_0.id].reward or {}
	local var_8_1 = {
		id = var_8_0[arg_8_1][1],
		number = var_8_0[arg_8_1][2],
		completedFlag = arg_8_0.isDraw,
		clickFun = function(arg_9_0)
			ShowPopItem(POP_ITEM, {
				arg_9_0.id
			})
		end
	}

	arg_8_2:SetData(var_8_1)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.uiList_ then
		arg_10_0.uiList_:Dispose()

		arg_10_0.uiList_ = nil
	end
end

return var_0_0
