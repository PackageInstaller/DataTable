local var_0_0 = class("CanteenEntrustAwardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.awardItemListScroll_ = LuaList.New(handler(arg_3_0, arg_3_0.indexAwardItem), arg_3_0.awarduilistUilist_, DormDispatchAwardItem)
	arg_3_0.extraController = ControllerUtil.GetController(arg_3_0.transform_, "extra")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1.id
	arg_4_0.titletextText_.text = GetI18NText(BackHomeCanteenTaskCfg[arg_4_1.id].name) .. GetTips("CANTEEN_TASK_FINISH")
	arg_4_0.itemList = {}

	if arg_4_1.extra_reward == 1 then
		arg_4_0.extraController:SetSelectedState("true")

		arg_4_0.rewardText_.text = GetTips("DORM_CANTEEN_BIG_WIN")
	else
		arg_4_0.extraController:SetSelectedState("false")

		arg_4_0.rewardText_.text = GetTips("DORM_CANTEEN_WIN")
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.award) do
		table.insert(arg_4_0.itemList, iter_4_1)
	end

	arg_4_0.awardItemListScroll_:StartScroll(#arg_4_0.itemList)
end

function var_0_0.indexAwardItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.itemList[arg_5_1])
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.changeListFun = arg_6_1
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:RemoveAllListeners()

	if arg_7_0.awardItemListScroll_ then
		arg_7_0.awardItemListScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
