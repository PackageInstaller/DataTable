local var_0_0 = class("PushSnowBallTeamTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.itemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.itemList__, CommonItem)
	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.index_ = arg_3_1
	arg_3_0.data_ = arg_3_2
	arg_3_0.cfg_ = AssignmentCfg[arg_3_2.id]

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		TaskAction:SubmitTask(arg_5_0.cfg_.id)
	end)
end

function var_0_0.SetCallBack(arg_7_0, arg_7_1)
	arg_7_0.callback = arg_7_1
end

function var_0_0.SetCheckCallBack(arg_8_0, arg_8_1)
	arg_8_0.checkCallBack_ = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshItem()
	arg_9_0:RefreshState()
end

function var_0_0.RefreshItem(arg_10_0)
	arg_10_0.rewardCfg_ = arg_10_0.cfg_.reward

	arg_10_0.itemList_:StartScroll(#arg_10_0.rewardCfg_)

	arg_10_0.progress_.text = math.min(arg_10_0.data_.progress, AssignmentCfg[arg_10_0.cfg_.id].need) .. "/" .. AssignmentCfg[arg_10_0.cfg_.id].need
	arg_10_0.descText_.text = arg_10_0.cfg_.desc
	arg_10_0.slider_.value = TaskData2:GetTaskProgress(arg_10_0.cfg_.id)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.rewardCfg_[arg_11_1]

	arg_11_2:RefreshData(formatReward(var_11_0))
	arg_11_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_11_0)
	end)
end

function var_0_0.RefreshState(arg_13_0)
	local var_13_0 = arg_13_0.data_.complete_flag >= 1

	if not (AssignmentCfg[arg_13_0.cfg_.id].need <= arg_13_0.data_.progress) then
		arg_13_0.rewardState_:SetSelectedState("unfinished")
	elseif not var_13_0 then
		arg_13_0.rewardState_:SetSelectedState("complete")
	else
		arg_13_0.rewardState_:SetSelectedState("rewarded")
	end
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.itemList_ then
		arg_14_0.itemList_:Dispose()

		arg_14_0.itemList_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
