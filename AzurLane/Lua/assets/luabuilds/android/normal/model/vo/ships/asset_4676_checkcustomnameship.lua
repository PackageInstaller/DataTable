class = var_0_10000

local var_0_0 = "CheckCustomNameShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Ship"))

function var_0_1.getName(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getRawData(var_1_0)

	if var_1.ShouldCheckCustomName(var_1_1) then
		return arg_1_0:GetDefaultName()
	else
		return var_0_1.super.getName(arg_1_0)
	end

	return
end

return var_0_1
