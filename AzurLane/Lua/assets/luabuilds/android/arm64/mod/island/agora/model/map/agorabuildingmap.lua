class = var_0_10000

local var_0_0 = "AgoraBuildingMap"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".AgoraMap"))

function var_0_1.GenMap(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.super.GenMap
	local var_1_1 = arg_1_0

	Vector2 = var_1_10005

	return var_1_0(var_1_1, var_1_10005(100, 100))
end

return var_0_1
