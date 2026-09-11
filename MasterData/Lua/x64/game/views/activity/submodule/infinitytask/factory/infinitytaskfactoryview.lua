InfinityTaskBaseView = import("game.views.activity.Submodule.infinityTask.base.InfinityTaskBaseView")

local InfinityTaskFactoryView = class("InfinityTaskFactoryView", InfinityTaskBaseView)

function InfinityTaskFactoryView:UIName()
	return "UI/MardukUI/catMatch/MardukTaskUI"
end

function InfinityTaskFactoryView:GetTaskViewClass()
	return ActivityTaskFactoryView
end

function InfinityTaskFactoryView:GetInfinityPoolViewClass()
	return ActivityInfinityPoolFactoryView
end

function InfinityTaskFactoryView:GetInfinityPoolItemID()
	return CurrencyConst.CURRENCY_TYPE_FACTORY_INFINITY_COIN
end

function InfinityTaskFactoryView:GetHelpTips()
	return "ACTIVITY_FACTORY_INFINITY_POOL_DESCRIPE"
end

return InfinityTaskFactoryView
