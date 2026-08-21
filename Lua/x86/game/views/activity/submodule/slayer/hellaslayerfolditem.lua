local var_0_0 = class("HellaSlayerFoldItem", ReduxView)

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

	arg_3_0.list = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.m_list, CommonItem)
	arg_3_0.buttonController = ControllerUtil.GetController(arg_3_0.m_btnController, "stateBtn")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_receiveBtn, nil, function()
		SlayerAction.QueryPointReward(arg_4_0.slayer_activity_id, arg_4_0.pointRewardId)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.slayer_activity_id = arg_6_1
	arg_6_0.pointRewardId = arg_6_2

	local var_6_0 = ActivitySlayerPointRewardCfg[arg_6_2]

	arg_6_0.m_pointLab.text = var_6_0 and var_6_0.need or ""
	arg_6_0.rewards = var_6_0 and var_6_0.reward_item_list or {}

	arg_6_0.list:StartScroll(#arg_6_0.rewards)

	local var_6_1 = SlayerData:GetPoint(arg_6_1, var_6_0.activity_id)

	if SlayerData:GetReceivedReward(arg_6_1, arg_6_2) then
		arg_6_0.buttonController:SetSelectedIndex(2)
	elseif var_6_1 >= var_6_0.need then
		arg_6_0.buttonController:SetSelectedIndex(0)
	else
		arg_6_0.buttonController:SetSelectedIndex(1)
	end
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rewards[arg_7_1]

	arg_7_2:RefreshData(formatReward(var_7_0))
	arg_7_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_7_0)
	end)
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.list:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
