class = var_0_10000

local var_0_0 = "MainOverDueSkinSequence"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainOverDueAttireSequence"))

function var_0_1.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ShipSkinProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)

	if #var_2.getOverDueSkins(var_1_0) > 0 then
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.Display

		SkinExpireDisplayPage = var_1_10006

		var_1_2(var_1_1, var_1_10006, var_3, arg_1_1)
	else
		arg_1_1()
	end

	return
end

return var_0_1
