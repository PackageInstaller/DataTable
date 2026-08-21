local var_0_0 = class("PlayerVitaeLockCard", import(".PlayerVitaeBaseCard"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.desc = arg_1_0._tf:Find("Text")

	return
end

function var_0_0.OnUpdate(arg_2_0, arg_2_1, arg_2_2)
	setText(arg_2_0.desc, i18n("secretary_unlock" .. arg_2_1))

	return
end

function var_0_0.OnDispose(arg_3_0)
	return
end

return var_0_0
