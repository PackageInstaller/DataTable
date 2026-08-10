local var_0_0 = class("PassportBuyLevelItemView", ReduxView)

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

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.indexItem), arg_3_0.listGo_, CommonItem)
end

function var_0_0.indexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshData({
		id = arg_4_0.rewards_[arg_4_1].id,
		number = arg_4_0.rewards_[arg_4_1].num
	})
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.SetIndex(arg_8_0, arg_8_1)
	arg_8_0.index_ = arg_8_1

	arg_8_0:UpdateView()
end

function var_0_0.UpdateView(arg_9_0)
	local var_9_0 = PassportData:GetLevel() + arg_9_0.index_

	arg_9_0.levelLabel_.text = string.format(GetTips("BATTLEPASS_LEVEL_UNLOCK_REWARD"), var_9_0)
	arg_9_0.rewards_ = {}

	local var_9_1 = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type][var_9_0]

	for iter_9_0, iter_9_1 in ipairs(BattlePassCfg[var_9_1].reward_free) do
		table.insert(arg_9_0.rewards_, iter_9_1)
	end

	if PassportData:GetPayLevel() > 0 then
		for iter_9_2, iter_9_3 in ipairs(BattlePassCfg[var_9_1].reward_pay) do
			table.insert(arg_9_0.rewards_, iter_9_3)
		end
	end

	local var_9_2 = formatRewardCfgList(arg_9_0.rewards_)

	arg_9_0.rewards_ = mergeReward(var_9_2)

	arg_9_0.list_:StartScroll(#arg_9_0.rewards_)
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.list_ then
		arg_10_0.list_:Dispose()

		arg_10_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
