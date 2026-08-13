class = var_0_10000

local var_0_0 = "BackYardEmptyCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardBaseCard"))

function var_0_1.OnInit(arg_1_0)
	onButton = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0._content

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		NewBackYardShipInfoMediator = var_2_10003

		var_2_1(var_2_0, var_2_10003.OPEN_CHUANWU, arg_1_0.type)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

return var_0_1
