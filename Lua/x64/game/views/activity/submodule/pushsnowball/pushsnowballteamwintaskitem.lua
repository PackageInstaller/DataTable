local var_0_0 = class("PushSnowBallTeamWinTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "stateBtn")
	arg_2_0.commonItem_ = CommonItem.New(arg_2_0.commonItemGo_)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.index_ = arg_3_1
	arg_3_0.data_ = arg_3_2
	arg_3_0.cfg_ = AssignmentCfg[arg_3_2.id]
	arg_3_0.rewardList_ = arg_3_0.cfg_.reward

	manager.redPoint:bindUIandKey(arg_3_0.transform_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. arg_3_0.data_.id)
	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
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

function var_0_0.OnExit(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.transform_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. arg_10_0.data_.id)
end

function var_0_0.RefreshItem(arg_11_0)
	arg_11_0.commonItem_:RefreshData({
		id = arg_11_0.rewardList_[1][1],
		number = arg_11_0.rewardList_[1][2]
	})
	arg_11_0.commonItem_:RegistCallBack(function()
		ShowPopItem(POP_ITEM, {
			arg_11_0.rewardList_[1][1]
		})
	end)
	arg_11_0.commonItem_:SetBottomText(arg_11_0.rewardList_[1][2])

	arg_11_0.descText_.text = arg_11_0.cfg_.desc
end

function var_0_0.RefreshState(arg_13_0)
	local var_13_0 = TaskData2:GetTaskComplete(arg_13_0.cfg_.id)

	if not (AssignmentCfg[arg_13_0.cfg_.id].need <= TaskData2:GetTask(arg_13_0.cfg_.id).progress) then
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

	arg_14_0.commonItem_:Dispose()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
