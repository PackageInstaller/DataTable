class = var_0_10000

local var_0_0 = "PlayerVitaeEducateAddCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".PlayerVitaeEducateBaseCard"))

function var_0_1.Flush(arg_1_0)
	onButton = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0._tf

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		PlayerVitaeMediator = var_2_10002

		var_2_1(var_2_0, var_2_10002.ON_SEL_EDUCATE_CHAR)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_1_0, var_1_1, var_1_2, var_1_10005)

	return
end

function var_0_1.Clear(arg_3_0)
	removeOnButton = var_1_10001

	var_1_10001(arg_3_0._tf)

	return
end

return var_0_1
