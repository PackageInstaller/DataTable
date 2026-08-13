class = var_0_10000

local var_0_0 = "NewNavalTacticsEmptyCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewNavalTacticsBaseCard"))

function var_0_1.OnInit(arg_1_0)
	onButton = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0._tf

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		NewNavalTacticsLayer = var_2_10003

		var_2_1(var_2_0, var_2_10003.ON_ADD_STUDENT, arg_1_0.index)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

return var_0_1
