local var_0_0 = class("ClassResourcePage", import(".ResourcePage"))

function var_0_0.getUIName(arg_1_0)
	return "ClassResourcePage"
end

function var_0_0.OnUpgrade(arg_2_0)
	arg_2_0:emit(ClassMediator.UPGRADE_FIELD, (arg_2_0.resourceField:GetUpgradeType()))

	return
end

return var_0_0
