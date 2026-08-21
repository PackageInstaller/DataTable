local var_0_0 = class("MainActCompensatBtn", import(".MainBaseSpcailActBtn"))

function var_0_0.GetContainer(arg_1_0)
	return arg_1_0.root.parent:Find("link_top/layout")
end

function var_0_0.InShowTime(arg_2_0)
	return getProxy(CompensateProxy):hasRewardCount()
end

function var_0_0.GetUIName(arg_3_0)
	return "MainActCompensatBtn"
end

function var_0_0.OnClick(arg_4_0)
	arg_4_0.event:emit(NewMainMediator.OPEN_Compensate)

	return
end

function var_0_0.OnRegister(arg_5_0)
	return
end

function var_0_0.OnClear(arg_6_0)
	return
end

return var_0_0
