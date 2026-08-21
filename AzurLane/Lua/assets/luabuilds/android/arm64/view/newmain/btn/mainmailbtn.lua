local var_0_0 = class("MainMailBtn", import(".MainBaseBtn"))

function var_0_0.OnClick(arg_1_0)
	arg_1_0:emit(NewMainMediator.OPEN_MAIL)

	return
end

return var_0_0
