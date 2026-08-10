local var_0_0 = class("XH3rdWaterMainRewardItemView", ReduxView)

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

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "status")
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.statusController_:GetSelectedState() == "finish" then
			local var_5_0 = ActivityWaterData:GetCurrentSchedule(arg_4_0.activityId_)

			ActivityWaterAction.GetTotalAssistantReward(var_5_0.schedule_id, ActivityWaterData:GetCurrentAssistantRole(arg_4_0.activityId_), {
				arg_4_0.rewardData_[1]
			}, {
				{
					arg_4_0.rewardData_[2],
					arg_4_0.rewardData_[3]
				}
			})
		end
	end)
	arg_4_0.commonItem_:RegistCallBack(function(arg_6_0)
		if arg_4_0.statusController_:GetSelectedState() == "finish" then
			local var_6_0 = ActivityWaterData:GetCurrentSchedule(arg_4_0.activityId_)

			ActivityWaterAction.GetTotalAssistantReward(var_6_0.schedule_id, ActivityWaterData:GetCurrentAssistantRole(arg_4_0.activityId_), {
				arg_4_0.rewardData_[1]
			}, {
				{
					arg_4_0.rewardData_[2],
					arg_4_0.rewardData_[3]
				}
			})
		else
			ShowPopItem(POP_ITEM, {
				arg_6_0.id,
				arg_6_0.number
			})
		end
	end)
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(ACTIVITY_WATER_TOTAL_ASSISTANT_REWARD_UPDATE, function()
		arg_7_0:UpdateView()
	end)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.index_ = arg_9_1
	arg_9_0.activityId_ = arg_9_2
	arg_9_0.rewardData_ = arg_9_3

	arg_9_0:UpdateView()
end

function var_0_0.UpdateView(arg_10_0)
	if ActivityWaterData:GetCurrentAssistantRoleProcess(arg_10_0.activityId_) < arg_10_0.rewardData_[1] then
		arg_10_0.statusController_:SetSelectedState("notFinish")
	elseif ActivityWaterData:HaveGetTotalProgressReward(arg_10_0.activityId_, arg_10_0.rewardData_[1]) then
		arg_10_0.statusController_:SetSelectedState("haveGet")
	else
		arg_10_0.statusController_:SetSelectedState("finish")
	end

	arg_10_0.valueText_.text = NumberTools.FormatNumberWithThousandsSeparator(arg_10_0.rewardData_[1])

	arg_10_0.commonItem_:RefreshData({
		id = arg_10_0.rewardData_[2],
		number = arg_10_0.rewardData_[3]
	})
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.data_ = nil

	if arg_14_0.commonItem_ then
		arg_14_0.commonItem_:Dispose()

		arg_14_0.commonItem_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
