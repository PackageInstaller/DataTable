class = var_0_10000

local var_0_0 = "PlayerVitaeLockCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".PlayerVitaeBaseCard"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.desc = var_1.Find(var_1_0, "Text")

	return
end

function var_0_1.OnUpdate(arg_2_0, arg_2_1, arg_2_2)
	setText = var_1_10003

	local var_2_0 = arg_2_0.desc

	i18n = var_1_10006

	var_1_10003(var_2_0, var_1_10006("secretary_unlock" .. arg_2_1))

	return
end

function var_0_1.OnDispose(arg_3_0)
	return
end

return var_0_1
