local var_0_0 = class("TowerGameRewardBlock", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listgo_, FactorySoloChallengeRewardCommonItem)
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "statu")
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.rewradCfg_[arg_4_1]

	arg_4_2:SetData(var_4_0, POP_ITEM)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		TowerGameACtion:GetReward(arg_5_0.rewardpointid_)
	end)
end

function var_0_0.RefreshItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index_ = arg_7_1
	arg_7_0.levelid_ = arg_7_2
	arg_7_0.rewardpointid_ = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_7_2][arg_7_1]
	arg_7_0.cfg_ = ActivityPointRewardCfg[arg_7_0.rewardpointid_]
	arg_7_0.text_.text = string.format(GetTips("ACTIVITY_TOWER_DEFENSE_REWARD"), arg_7_0.cfg_.need)

	arg_7_0.controller_:SetSelectedState(TowerGameData:GetRewardStatuByLevelIDAndPointId(arg_7_2, arg_7_0.rewardpointid_))

	arg_7_0.rewradCfg_ = arg_7_0.cfg_.reward_item_list

	arg_7_0.list_:StartScroll(#arg_7_0.rewradCfg_)
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.list_ then
		arg_8_0.list_:Dispose()

		arg_8_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
