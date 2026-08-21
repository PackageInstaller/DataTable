local var_0_0 = class("BackYardEmptyCard", import(".BackYardBaseCard"))

function var_0_0.OnInit(arg_1_0)
	onButton(arg_1_0, arg_1_0._content, function()
		arg_1_0:emit(NewBackYardShipInfoMediator.OPEN_CHUANWU, arg_1_0.type)

		return
	end, SFX_PANEL)

	return
end

return var_0_0
