local var_0_0 = class("XH3rdWaterExchangeItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "state")
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.rewardItem_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, arg_5_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		if arg_4_0.stateController_:GetSelectedState() == "complete" then
			ActivityWaterAction.GetSelfAssistantReward(arg_4_0.activityId_, {
				arg_4_0.taskId_
			}, ActivityPointRewardCfg[arg_4_0.taskId_].reward_item_list)
		end
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	return
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.taskId_ = arg_8_1
	arg_8_0.activityId_ = arg_8_2
	arg_8_0.rewardCfg_ = ActivityPointRewardCfg[arg_8_0.taskId_].reward_item_list[1]

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = formatReward(arg_9_0.rewardCfg_)

	arg_9_0.commonItem_:RefreshData(rewardToItemTemplate(var_9_0))

	arg_9_0.text_.text = string.format(GetTips("ACTIVITY_WATER_SELF_PROGRESS"), ActivityPointRewardCfg[arg_9_0.taskId_].need)

	if ActivityWaterData:GetCurrentSelfProgress(arg_9_0.activityId_) < ActivityPointRewardCfg[arg_9_0.taskId_].need then
		arg_9_0.stateController_:SetSelectedState("uncomplete")
	elseif ActivityWaterData:HaveGetSelfProgressReward(arg_9_0.activityId_, arg_9_0.taskId_) then
		arg_9_0.stateController_:SetSelectedState("received")
	else
		arg_9_0.stateController_:SetSelectedState("complete")
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:AddEventListeners()
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.data_ = nil

	if arg_13_0.commonItem_ then
		arg_13_0.commonItem_:Dispose()

		arg_13_0.commonItem_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
