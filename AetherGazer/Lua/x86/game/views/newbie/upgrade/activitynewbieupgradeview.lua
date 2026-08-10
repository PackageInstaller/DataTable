local var_0_0 = class("ActivityNewbieUpgradeView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/Activitynewbie/NewbieUpgradeUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.upgradeItemList_ = {}

	for iter_1_0 = 1, #GameSetting.levelup_reward.value do
		arg_1_0.upgradeItemList_[iter_1_0] = ActivityNewbieUpgradeItem.New(arg_1_0[string.format("button%s_", iter_1_0)], iter_1_0)
	end
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.upgradeItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.upgradeItemList_ = nil

	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.SetData(arg_4_0)
	arg_4_0.textLevel_.text = PlayerData:GetPlayerInfo().userLevel

	for iter_4_0, iter_4_1 in pairs(arg_4_0.upgradeItemList_) do
		iter_4_1:RefreshUI()
	end
end

return var_0_0
