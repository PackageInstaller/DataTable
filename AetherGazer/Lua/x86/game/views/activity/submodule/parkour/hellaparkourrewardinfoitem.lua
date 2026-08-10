local var_0_0 = class("HellaParkourRewardInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.list = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.m_list, CommonItem)
	arg_2_0.rewardController = ControllerUtil.GetController(arg_2_0.transform_, "reward")
	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.m_stateController, "stateBtn")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_receiveBtn, nil, function()
		ParkourAction.QueryParkourStarReward(arg_4_0.entrust_activity_id, arg_4_0.index)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.index = arg_6_1
	arg_6_0.entrust_activity_id = arg_6_2
	arg_6_0.rewards = arg_6_3

	arg_6_0.rewardController:SetSelectedIndex(math.min(3, arg_6_1 - 1))
	arg_6_0.list:StartScroll(#arg_6_0.rewards)

	local var_6_0 = ParkourData:GetParkourEntrustData(arg_6_2)

	if not var_6_0 then
		arg_6_0.stateController:SetSelectedIndex(1)

		return
	end

	local var_6_1 = ParkourData:GetStarCount(arg_6_2)

	if table.indexof(var_6_0.rewards, arg_6_1) then
		arg_6_0.stateController:SetSelectedIndex(2)
	elseif arg_6_1 == 4 and table.indexof(var_6_0.stars, 4) then
		arg_6_0.stateController:SetSelectedIndex(0)
	elseif arg_6_1 ~= 4 and arg_6_1 <= var_6_1 then
		arg_6_0.stateController:SetSelectedIndex(0)
	else
		arg_6_0.stateController:SetSelectedIndex(1)
	end
end

function var_0_0.RegistCallBack(arg_7_0, arg_7_1)
	arg_7_0.callback_ = arg_7_1
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.rewards[arg_8_1]

	arg_8_2:RefreshData(formatReward(var_8_0))
	arg_8_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_8_0)
	end)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.list:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
