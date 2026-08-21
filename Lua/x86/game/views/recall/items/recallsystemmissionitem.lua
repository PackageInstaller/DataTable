local var_0_0 = class("RecallSystemMissionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.completeBtn_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskCfg.id)
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.controller = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "state")
	arg_5_0.list_ = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.listGo_, CommonItemView)
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	CommonTools.SetCommonData(arg_6_2, {
		id = arg_6_0.rewardList[arg_6_1][1],
		number = arg_6_0.rewardList[arg_6_1][2],
		clickFun = function(arg_7_0)
			ShowPopItem(POP_OTHER_ITEM, {
				arg_7_0.id,
				arg_7_0.number
			})
		end
	})
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.id

	arg_8_0.taskCfg = AssignmentCfg[var_8_0]
	arg_8_0.taskInfo = arg_8_1
	arg_8_0.rewardList = arg_8_0.taskCfg.reward or {}

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	arg_9_0.list_:StartScrollWithoutAnimator(#arg_9_0.rewardList)

	arg_9_0.taskDescTxt_.text = arg_9_0.taskCfg.desc

	local var_9_0 = arg_9_0.taskInfo.progress
	local var_9_1 = arg_9_0.taskCfg.need

	if var_9_1 < var_9_0 then
		var_9_0 = var_9_1
	end

	arg_9_0.taskProgressTxt_.text = string.format("%d/%d", var_9_0, var_9_1)

	if arg_9_0.taskInfo.complete_flag == 1 then
		arg_9_0.controller:SetSelectedState("accepted")
	elseif var_9_1 <= var_9_0 then
		arg_9_0.controller:SetSelectedState("complete")
	else
		arg_9_0.controller:SetSelectedState("uncomplete")
	end

	arg_9_0.taskTypeTxt_.text = arg_9_0.taskCfg.name
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.list_ then
		arg_12_0.list_:Dispose()

		arg_12_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
