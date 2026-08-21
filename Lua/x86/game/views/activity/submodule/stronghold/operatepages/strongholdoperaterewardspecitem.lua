local var_0_0 = class("StrongholdOperateSpecRewardItem", ReduxView)

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

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_rewardBtn, function()
		local var_5_0 = StrongholdData:GetRewardState(arg_4_0.activity_id, arg_4_0.reward_id)

		if var_5_0 == 0 then
			StrongholdAction.QueryReward(arg_4_0.activity_id, {
				arg_4_0.reward_id
			})
		elseif var_5_0 == 1 then
			ShowTips("ACTIVITY_STRONGHOLD_REWARD_FAIL")
		end
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_iconBtn, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			arg_4_0.item_id,
			1
		})
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.activity_id = arg_7_1
	arg_7_0.reward_id = arg_7_2

	local var_7_0 = ActivityStrongholdRewardCfg[arg_7_0.reward_id]
	local var_7_1 = var_7_0.condition
	local var_7_2 = var_7_0.params[1]
	local var_7_3
	local var_7_4 = ActivityStrongholdLevelCfg.get_id_list_by_type[var_7_1]

	for iter_7_0, iter_7_1 in ipairs(var_7_4) do
		if ActivityStrongholdLevelCfg[iter_7_1].level == var_7_2 then
			var_7_3 = ActivityStrongholdLevelCfg[iter_7_1]
		end
	end

	local var_7_5 = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. var_7_1)

	arg_7_0.m_des.text = string.format(GetTips("ACTIVITY_STRONGHOLD_REWARD_TIP"), var_7_5, var_7_2, var_7_3.level_des)

	local var_7_6 = StrongholdData:GetRewardState(arg_7_1, arg_7_2)

	arg_7_0.stateController:SetSelectedIndex(var_7_6)

	local var_7_7 = var_7_0.reward[1][1]

	arg_7_0.item_id = var_7_7

	if ItemCfg[var_7_7] then
		arg_7_0.m_icon.sprite = ItemTools.getItemSprite(var_7_7)
		arg_7_0.m_title.text = ItemTools.getItemName(var_7_7)
	end
end

return var_0_0
