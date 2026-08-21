InfinityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.InfinityTaskBaseView")

local var_0_0 = class("InfinityTaskFactoryView", InfinityTaskBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/catMatch/MardukTaskUI"
end

function var_0_0.GetTaskViewClass(arg_2_0)
	return ActivityTaskFactoryView
end

function var_0_0.GetInfinityPoolViewClass(arg_3_0)
	return ActivityInfinityPoolFactoryView
end

function var_0_0.GetInfinityPoolItemID(arg_4_0)
	return CurrencyConst.CURRENCY_TYPE_FACTORY_INFINITY_COIN
end

function var_0_0.GetHelpTips(arg_5_0)
	return "ACTIVITY_FACTORY_INFINITY_POOL_DESCRIPE"
end

return var_0_0
