local var_0_0 = class("ActivityMatrixScoreExchangeItem", ReduxView)

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
	arg_3_0.itemList = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.bonusListGo_, CommonItem)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.getBtn_, nil, function()
		ActivityAction.ReceivePointReward({
			arg_4_0.rewardId
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.rewardId = arg_6_1
	arg_6_0.matrix_activity_id = arg_6_2

	local var_6_0 = ActivityPointRewardCfg[arg_6_1]

	arg_6_0.scoreText_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_REACHED"), var_6_0.need)
	arg_6_0.items = var_6_0.reward_item_list

	arg_6_0.itemList:StartScroll(#arg_6_0.items)
	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = ActivityMatrixData:GetMatrixScore(arg_7_0.matrix_activity_id)
	local var_7_1 = ActivityPointRewardCfg[arg_7_0.rewardId]

	if ActivityMatrixData:GetMatrixPointRewardState(arg_7_0.matrix_activity_id, arg_7_0.rewardId) then
		arg_7_0.stateController_:SetSelectedIndex(2)
	elseif var_7_0 >= var_7_1.need then
		arg_7_0.stateController_:SetSelectedIndex(1)
	else
		arg_7_0.stateController_:SetSelectedIndex(0)
	end
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.items[arg_8_1]

	arg_8_2:RefreshData(formatReward(var_8_0))
	arg_8_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_8_0)
	end)
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.stateController_ then
		arg_10_0.stateController_:Dispose()

		arg_10_0.stateController_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
