local var_0_0 = class("PlayerVitaeEducateAddCard", import(".PlayerVitaeEducateBaseCard"))

function var_0_0.Flush(arg_1_0)
	onButton(arg_1_0, arg_1_0._tf, function()
		arg_1_0:emit(PlayerVitaeMediator.ON_SEL_EDUCATE_CHAR)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Clear(arg_3_0)
	removeOnButton(arg_3_0._tf)

	return
end

return var_0_0
